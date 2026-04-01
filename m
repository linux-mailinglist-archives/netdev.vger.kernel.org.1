Return-Path: <netdev+bounces-273934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDQNH63JzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:30:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08780375EAF
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F68430DF6F6
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C637C922;
	Wed,  1 Apr 2026 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj4C94Gl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7C37C0E5
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028124; cv=none; b=EVvEd7m5iVtNlQgdouMGz4HLG4MF85b/50TrFbINqC+fjvsot1W2jR9T8uUvHumRtOgA+AjszJfmaivP9XoxhYN2Gf61Xn7EgFVrOwWLyn5ptxlJ4A8ABBl1wQMfrPAvrzp1nm+g/GNd3AIjYdSqG5zpNZ0WNM+QxwF8CbRG8KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028124; c=relaxed/simple;
	bh=zoMzCwLz58hsOtyKlOVT1dSDiy6GUF38z6feI7bv1Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KntY659WQf6sqezD1Ck5sTmrKO448jthMF7nRTSD10SU4lw9t4mtayrKlV3Pz0hLGN5zqidQi3Jv0UyoK0emJiox9NVa9zNGi+xNfg4uGqtIc3IBXagyNQFxP1gDzZNrkpeb+8EopwOOawGZWx6U1EsnXfSBEoL+0M7Ubvl38I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj4C94Gl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b256a4c6b5so17418485ad.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 00:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775028123; x=1775632923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jQNznQ9kFgYwHnnqDt5/rCEInESrDADfWL0k3BeYRCU=;
        b=Pj4C94Gl9cbbI6mKlI5M/W/3gly9FICMboC536Q2Z5YsFmQENo5HTfFcZEaX0H3c5r
         D+UIgz2iePUa5TQEgha/q87h0ARaPrsEpryRDPFrGSzyVig1VCCLlB4q/C/rTMPBl2+r
         5BmmJ+5mTIfqhoh3MhaLdAOdy9U5SRxdvz4BouyvoNh/I1Zfb859oa14UEdJUBH16PBW
         lt6nXK9VNuomCE3c1EB1QzkHj2esr3QTvOYc4IOGQ+a1gsJ6zzemAhmsgxULVf4BK3Ap
         NUmQ4j/XoncSS4iOdv3usEF8Je4D46G/wa98TtYh9whs93FY9V4uPCoHzLBj87FrMicv
         UTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775028123; x=1775632923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQNznQ9kFgYwHnnqDt5/rCEInESrDADfWL0k3BeYRCU=;
        b=qH2Nc4pU2fKe+XL7UNlmYteneeN6RZ3bSymlWdzVSRsXlD5XXHAAWTjwRUlbrY3kZX
         8lz0/2XFmL+wjoUwIdThej8Eonbpf2cdJrMgqpy+vJ/cw1FJPHoUj3rHOxjw5Dd7gBkk
         7pDdCAYVnj4W+eIPZsRUR0RfIFZZYRWfGCx2LUtf/swo+rzie0DsydZ59WWaO66MQgum
         jNQxyvNFn/z7TsXITS3yTE1H4Kuw/pMfcSBY46mRiaof6oELzImYyTrnOowmLXHh6vBB
         /8cJZoeGrT4RI5s6Qhp4Jrs0JcyTy+B9/VK7RNf28ZDlps0Jd0ghvRZECjKw4CZ1oZJi
         M2mg==
X-Forwarded-Encrypted: i=1; AJvYcCWCcYbkxuwCEh5fdyZ1HzZ+yqshcFUCihZ2qpLxP3f/Pq3bJsR3EqFQB66FCrMhR8nuE+tt4pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysfGdw+Ot5ag7T6WEdUFzvHl0CoXENyHmpcdRklVLamcNGiQVj
	F9C3RW7tPKm80+S7Fn3d/N0qyLbTQbSxixvCUZKlMItaYIou1ua5nskT
X-Gm-Gg: ATEYQzxj4ZAaep9and7zC9tcAFX43JOa70rdtbNGQIDzzlIuJCAcIKlXRjM/DvyYbpD
	3/XzQRw5S0tbJsqkQj6IN/sga7xsYaxLhJIXdYg5xyGLliHk+rKDODDegxV9YHvWWNTb6d9mB8n
	LMoQ5DpgWdlG9GHdUvs96n2wOvmYChfQxPQzQgrm3omyDd3+wkBmE40olK5JpBFNufN+M2WJ8yw
	BLYubCRvpcbiyO3hn1TzPf6VnV964ZSvRd0H0CpzUw5/E1HO8TLQlG8spLK8KF4HvEVfGMGvbXV
	qVdeEqdbpSWOqawfd4cJtm2E2Ogy+knuhSuNDGR10+LtQ0zG03b3yCBgMdSs0f7O/rTbFjiHbyC
	fWbn/ts3ZXq6Nx7oQOTo0PhvHKCEEofo5idqE/q8Fem+xaNPN3EciRrYcZDILSGKTNUt/f+fPei
	uVmjZD/Zh0S+NiH3CIN+mJzRuW0WA=
X-Received: by 2002:a17:902:f54f:b0:2ae:4555:479e with SMTP id d9443c01a7336-2b269ac86a1mr22411875ad.18.1775028122935;
        Wed, 01 Apr 2026 00:22:02 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24ddc0afbsm139505495ad.64.2026.04.01.00.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:22:02 -0700 (PDT)
Date: Wed, 1 Apr 2026 07:21:54 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] tools: ynl: ethtool: use doit instead of
 dumpit for per-device GET
Message-ID: <aczHkqj_0ErqCfXS@fedora>
References: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
 <20260331-b4-ynl_ethtool-v1-1-dda2a9b55df8@gmail.com>
 <20260331185028.45dffe3a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331185028.45dffe3a@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273934-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08780375EAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 06:50:28PM -0700, Jakub Kicinski wrote:
> On Tue, 31 Mar 2026 11:56:11 +0800 Hangbin Liu wrote:
> > +++ b/tools/net/ynl/pyynl/ethtool.py
> 
> We have converted all the samples to selftests so this script is 
> the last piece of random "PoC" code we still have laying around.
> Should we also move it to tests/ ?
> 
> If there's a reason to keep it as is -- could you please add that reason
> at the top of the file for my future self? I'm pretty sure I already
> questioned this script in the past ;)

I have no objection to this. Will you keep it as it is when moving it to
tests/ ? Should I wait for your moving first?

Hangbin

