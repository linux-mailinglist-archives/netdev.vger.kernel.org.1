Return-Path: <netdev+bounces-289820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G3yCm9sDWrgxAUAu9opvQ
	(envelope-from <netdev+bounces-289820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:10:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B930589718
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8705307B179
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF783A5438;
	Wed, 20 May 2026 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GacjGQ9j";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7Ms0UGX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A43A6B85
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264537; cv=none; b=XLsH2dT68qN+aX3NdfILnUHw1W3u5RL6ngDAy9yFurai8UhtHPcABe91vCAP6uI4ZGLKFCAhrzezLxhxLaE7NjvgY6tKi5XcLFVx+qJQepvLYn6tKCMd8cTOaDO5FnzXWghanLuVqTIeuPPhCHHVKefsFjpIIZ71zZeFHXIFkpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264537; c=relaxed/simple;
	bh=BRXJwfMfnV1zMnJtM7GywPXGIHyYEcE6F4GmrqYaR2Y=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=q0ltqhgGrjk10ID2ZZiHEOFUHzHSHRu6I35BbU9I7FDKIRHHB2hDP1BGUgHB3qID39PZdY2rKGS5kMagJ4EKf7rSV2BGEl9ScpBgFbPjxg+ylr5h35e5jzG4i9Y1hPExJWBn5c6+cmczTB4qydDQXNYh09rDKbbixWap0i4g/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GacjGQ9j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7Ms0UGX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779264535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cPESQ7LAH4zMILZd/axqS8ovydxXDBYxaaBJksIM40=;
	b=GacjGQ9jx9NLQ+XLo7dbxUbAMokxawc+2bA8J120F4gE2NK8FrijJMdQkzGy9BrM9paLh4
	CxTYX3S+WvR4+r+8m9TKOs760bbs1zMwGhVj19vqWo7QQM+kGohDzbzY49LckBXVM7NDRQ
	GJj+g1i1WVVGiYr0FUATAVe0p9BxnBQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-ssRDT9o9OuSiLg5VJCKRiw-1; Wed, 20 May 2026 04:08:52 -0400
X-MC-Unique: ssRDT9o9OuSiLg5VJCKRiw-1
X-Mimecast-MFC-AGG-ID: ssRDT9o9OuSiLg5VJCKRiw_1779264531
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fd33b4921so30831225e9.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779264531; x=1779869331; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cPESQ7LAH4zMILZd/axqS8ovydxXDBYxaaBJksIM40=;
        b=F7Ms0UGXd1NRVAXhXsX1Ppoky26tWJIavAUFUYwddybbXZBqgjmukKPyl2Mesj2aAl
         W269pjTRypFQo59Nf1peEKueGjnj0jTyiDFyGqu6+LwX17ubG9GNAfoV6eXhTOH1N2N3
         O1Ar5u2MABDeNzU4N05mr965UlzffYXt2lJnq7Ll0FBkQ1HeiozV4JWajkJBAJjKR2CT
         3FyUZIjOn3YJwjQJmKWZQPt63s2LxxpJpRpMLlfemsIxMNJZJcWfeX1Sake2lZqp4wAf
         rPR3C61mK8IIxXNu2og/AYLaRj/8/gQtaB3MydqbqHn2wmZCIdqh4eBlB593XCmLEMr+
         3glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264531; x=1779869331;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cPESQ7LAH4zMILZd/axqS8ovydxXDBYxaaBJksIM40=;
        b=e/sKTS9Silli9p7UBwM+HT8oU+sYDVUcXptaOG3gvA9YknrWgHMqESHKRu/Wy3wC9s
         r6Z7+N2/+CC02nX5kbyDi9/98UJK6Reoy/EzWpUynZU8Fxo9jN8iUNV9Kt7NR7/7tpG5
         iuF8uhmNhkpAEFPR5iZkLxDhH1sz9UWFhjIKQ13fLairGLdxGKuu724xZklUkj1LMyFj
         4Jsvm113Gbru9adiNUNHssjB/Y2KGY0VKbfq/KInVWmkiqR0ANU1fCHDa1+FTqLr/eof
         JvovT24ARu2hmcoYSJqsPYRdpC0hVye9b7ArUkoOUN/Szbt37J6y358O7L4h4ifrM/nc
         kLzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tIyK/s7/AwVBeq18cmwTtokFLF6uCDv2BPZl5cl88KV9tG1kQYFKhhBksiyfVUHIVPaNEPSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKezqlgWnQo/NmLfqrj1rasssCa3YTbW83DXEXRECIaBC+NXUY
	fDFWNctcR5WIAH2ye+xxq3SUk+MIpej6/lIutS4syRIVXwdOTuZPV0lntOGH1Wq0g9rwBOI71l1
	c3+2io7IP9iAclRKsLQ7PFVPLjzhUZ3/txsgGKxhTUVC6n1YJU6lc4n6fGQ==
X-Gm-Gg: Acq92OHhOUC9TXbPa91Dn0D5khQIYtXKc61zmNOsrsWUPrTjMZ4GqANHhwi6UiyGEYF
	9ziWgWE1xZfBeiHSOzvnFodK0v6c2eUjGjRtWTJAVuaF2KDgSyEhL2YkC2Dx4RV5kHOc+zDaPqd
	u4Sf+ElcfOHPsaO5qG3F1svkFM1kBcKtkRQMvGxVZ/wlM5I0G4yqiO9oDvZGZC+Wwp+pP9iIMlp
	DEJegLQoZnScHQUDpG0YGvo1Cr5qL2fGxelU0vaJ1l7GQsUlUGXnLMJA37CXXdG2qtG1fL4UzH1
	kNkWJzXm0ElSa8YKNOiklb4CB0e6dSJD5NKZSVh2bYQxEIjaslPrRkcbtRfRcSqzzelhM990VSF
	unPUsRdu8sKZPzC7Gs+yZDlTVJgWMcnqN
X-Received: by 2002:a05:600c:1389:b0:48f:fe2a:107c with SMTP id 5b1f17b1804b1-49001285b87mr227310225e9.6.1779264530719;
        Wed, 20 May 2026 01:08:50 -0700 (PDT)
X-Received: by 2002:a05:600c:1389:b0:48f:fe2a:107c with SMTP id 5b1f17b1804b1-49001285b87mr227309635e9.6.1779264530196;
        Wed, 20 May 2026 01:08:50 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm379368225e9.2.2026.05.20.01.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:08:49 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Pavel Emelyanov
 <xemul@scylladb.com>, Laurent Vivier <lvivier@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>, Jon Maloy <jmaloy@redhat.com>, Dmitry
 Safonov <dima@arista.com>, Andrei Vagin <avagin@google.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net v2 0/2] Fix race condition between TCP_REPAIR dump
 and data receive
Message-ID: <20260520100843.3646f1f6@elisabeth>
In-Reply-To: <20260519190352.45c8478e@kernel.org>
References: <20260518183424.3144867-1-sbrivio@redhat.com>
	<20260519190352.45c8478e@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 20 May 2026 10:08:48 +0200 (CEST)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289820-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9B930589718
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 19:03:52 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 18 May 2026 20:34:22 +0200 Stefano Brivio wrote:
> > Stefano Brivio (2):
> >   tcp: Don't accept data when socket is in repair mode  
> 
> Not sure Eric is on board with this patch in the first place.
> Sound like it's not the intended use case for REPAIR so IMO
> it's up to TCP maintainers whether we want to support this.
> And it's definitely not a Fix.

Jakub, thanks for looking into this.

As I was pointing out on the v1 thread, I think it's a race
condition regardless of the usage, because after you switch a socket to
repair mode you can do separate operations on the socket and the
outcome will be inconsistent between them. It depends on external
conditions and looks quite fragile.

For example, you could dump a given length of the receive queue, just
to read it a moment later, but now the length is wrong.

Note that now, on the v1 thread, also Andrei, one of the authors of
TCP_REPAIR and the matching feature in CRIU, agreed that my "fix" makes
things safer:

  https://lore.kernel.org/all/CAEWA0a4d-PpWpVexYGP5SLRuzj8hs1W1_Ww6qA4BBrkzSs4umQ@mail.gmail.com/

But I won't certainly insist on handling it as a fix and I'm now taking
care of the new feedback coming from Eric of course.

> >   selftests: Add data path tests for TCP_REPAIR mode  
> 
> Please don't add a new target, fold it under net.
> Targets are a PITA to deal with in kselftests.

Sorry, I had no idea, I'll change that.

-- 
Stefano


