Return-Path: <netdev+bounces-268205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QICSIAQwuGmvaAEAu9opvQ
	(envelope-from <netdev+bounces-268205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:29:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D98FF29D688
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E4933036EE5
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ABF336EE1;
	Mon, 16 Mar 2026 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="ZWi4YKjd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BAA2C375A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678458; cv=none; b=uZkmH3nwV9n9jKHwam9RQmCZUf5yt34EDwWACfIjpt2HUPnRCqvXBiLg2LZyWhxvvipvDM/Bg0YDqxFtiyrstmdwSRzEKt3a/6XEIc+Vi9AX4TAKlyWrWiZSFfHgWCONse67fBOHC3mMs52/UnTyU4YoBPePq0yIvheTrSysdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678458; c=relaxed/simple;
	bh=W9iNtOC2woi+l8O/PzM+FZSfJCAQ4BX+bwu6Hcc3QxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBJLvPGGZr5jpsJab3tL1CDsCfN5aOGyyPt174EHQu5MeKFXTpheBIJ7tWDeWOQb8jg9yuaMMwSqqBpFcoRnaG/B0UIvfkZ3xxvMrFeDersYbpAF651WYsPXJyKPIAVW5AJvV3zWR2X1qB6lgdCziLEiaOjO9G9LHkcs/0/vqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=ZWi4YKjd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82a07738118so2781110b3a.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773678456; x=1774283256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NntYy/V7JVgb+jLubKmKRpuGvm4xlSlKrtgDs98vuSo=;
        b=ZWi4YKjdeRwYIknoldG2QWHfEi824tlTVmzSKYM62SGxStO9tqWrxbJRUXQTu2T3rR
         +BkbG21jFFyJu2FBqeB6jwXQV6Ma+Cy8tnFapifgeCe15eUQMV/g4aRg7yIGL/G8TEwR
         V1HnvqvMDMQwuNRL1l6Y3q6fWWsrvq+Po1FVjOUUAFj9ddFuVm2yguGa0g/hQelyVM66
         VcYAifIZk4KGVJDvpnKmgOHufQHYiB3OXEWjPkcBA9VzcrLs+9FqMytMtF6W5/AzS4R7
         ctFjtA9jFVovtf6ruKHmFcAkP8sK3SIOUSTIJhxXugStXwz/lSK7mqNGFnkJbfntLU0A
         tAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773678456; x=1774283256;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NntYy/V7JVgb+jLubKmKRpuGvm4xlSlKrtgDs98vuSo=;
        b=CGJTI1G2Owtq64t7sV5Qbki6be8ZOnx8Tzp/Xfb89TPnIoaxItSehkZ9GtRAxGvpWK
         C0NE++St+iRFP4YYzd1qUTBzel/l4nuuwcoWvqcFtUF9Pr0uRiFijIeWWwqAI8pzZdyV
         Cr4lIgpJ3eA5SBd/o6Qcg9+CMNwUaOcVZvTjA/Rr+ierLFJ1j+ppfMoPb/2vvn8WzqCp
         L8CJV3W3wHJLFj6GFAi/1mzzZ5F5Da19WoPtu5GyVu0VDEGb8rCBumyA/2oH+p4hboxK
         PD+mUUBNIseQ0NYri1aPsFOUFkGB64QMmxNV8qvdwXCffxlfu+8zvAhkKbTxEw/N5dYE
         NsLg==
X-Forwarded-Encrypted: i=1; AJvYcCWvTGCnZCP/74yLgox2pjLAkVrI3SYNHN0IXsKMFuSD3PbbuaOqUb7d+deU4ATMopC7zxfd4WY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2jgftRSJKB08BN14hwo+t04UcOmBc2fSEjK2j4blqAwOLx38+
	yeylJE6pSMbkrENhIo0o0YYstK9+6chZI7dN2FYs+TAD+4+6sWwdsgGdp255uh1vrik=
X-Gm-Gg: ATEYQzxgZ92hsafRYaSif7L4tZlSsWkTe8xA4J4m7/EksdUcwTEE+S7SOlAG+hQM3XN
	p3NLGd8PuUYPgSuU6zO/5igiz6avaXuszOVZOppzfi6Fxu/YdOgKi3qYgsfNl47LCKZ7som+1Ty
	uFbnJdM9q8ec4wHiLxIITehr7JT0zRFHIdj37YLxbzFcg8fCyb38sFIoERfSc1YyyQUOs8eRa7/
	ZoPdWy456ZrFSncatv9xRxqUgjTR/2564JcUfZLDxMe0uu9itLQAioScdYghL7I9c5b942YfBrh
	as4LZlbOe1pcgVjSlupsAeK3QW2ZVgMdNQfvHBWYqmNSP7R//ADUBf/+wm79tkuyZGI3UulPZH3
	jWjNh9orLOw07i+YddBkPiySoHyMNtZrKCG4peJpIq4DbzrLlumo1wPoj19+24JAlBDzCjKRbhs
	VwlGft3hLUWoe5qWQ=
X-Received: by 2002:a05:6a00:1da3:b0:82a:1529:2b4f with SMTP id d2e1a72fcca58-82a198dc64fmr9962631b3a.44.1773678456284;
        Mon, 16 Mar 2026 09:27:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a06fe211csm14309103b3a.0.2026.03.16.09.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:27:35 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:27:35 -0700
From: Joe Damato <joe@dama.to>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] fou: Remove IPPROTO_UDPLITE check in
 gue_err() and gue6_err().
Message-ID: <abgvdzrmZwBZrALr@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20260316133127.2646421-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316133127.2646421-1-kuniyu@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268205-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D98FF29D688
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 01:31:25PM +0000, Kuniyuki Iwashima wrote:
> UDP-Lite has been removed, and its error handler is no
> longer found in either inet_protos[IPPROTO_UDPLITE] or
> inet6_protos[IPPROTO_UDPLITE].
> 
> The recursion fixed by the protocol check in gue_err()
> and gue6_err() no longer occurs with UDP-Lite.
> 
> Let's remove the checks.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv4/fou_core.c | 3 +--
>  net/ipv6/fou6.c     | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

