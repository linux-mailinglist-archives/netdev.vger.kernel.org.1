Return-Path: <netdev+bounces-275242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIoZJn850GmP4wYAu9opvQ
	(envelope-from <netdev+bounces-275242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:04:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE210398A34
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22F6A301BF4F
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F37D23C8AE;
	Fri,  3 Apr 2026 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="FDEV46l3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA918859B
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253684; cv=none; b=hZYAr8EFPlrB9KMi8X4euW6kYG1gXc+nF/D72I9kiB/omVwvugs6dr1yZTWkYjwl0zca1TqYQVaa28iAQxfVzu5gLXzK8VQZl9fjoYidCGt1dCMozfhsYzAmXNVPvmbi+OljAIFXgDQKffBAHRJ8VpoxkD0W/pmZKkBkLz3lHsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253684; c=relaxed/simple;
	bh=3mS0E94egBABaGuX92IvZ2g5gs5ady1w/71AozqiVzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3XZi5EJwjnZOdO1Jm1WsogBL9jspagnGGro73XcKF6/1hD958TM/wGI+hBwfTo9s26Ce9Pn87XWUr5M0xNiTUQvU+KdMxoJIkrRXl0q5wLNervTYoxq8v4UL5x7ghyLaHf5T2cmt0rssA/bEW5+PIW3pt2ookcbjsCcmQ8n5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=FDEV46l3; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4e9694so3599072c88.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775253682; x=1775858482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G43DBHI+jHrWW0S2QWI6xZIfMiIiQUtt7GZ8D3+SuI0=;
        b=FDEV46l3zN8Ej1gXBZmct4BW+LC8z9oVe1b0SaUZk2DeRtOJOr8zFwa9DuUN14Gcf8
         xfX2Bv9/m2DMk1OPjdIEtoJN1WZt4OVF4fwS7RyICSa6kdclkWync+fNyJ2jvzXDyEhk
         WjCth3R4B70p3+bAXaX/BIuReWAqlsoe2eMRGZ11wc+gPqH2HbTAHUo/shu+5L5PR9Rp
         Bt5cS3vQ4bqPPo3Kx5/hNHCqIGoGaVgQfOgpul7hZyxEjr7NjdqYL7sJBK6pY5Ps2N7H
         Ze7gBy+FdnQ7WLiWwdFewByYlimRhL97VryNxpt9za/lRLwYgDaVUeLGpMEmIBqOoeJH
         L/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775253682; x=1775858482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G43DBHI+jHrWW0S2QWI6xZIfMiIiQUtt7GZ8D3+SuI0=;
        b=Q6Fx1Su5SDIXqANOK/fxDD6LbhDoLGdlfhYCjEXrK16YGhgRuQfVBPDZtnqrngAmsk
         0OHou2o/bqdeiJNz2cd+3tPoNdOxgQZa8Jw+UfsCuEDVVZSgEm7QVuKkWeaRZVopSJAq
         g9FTRyhifBHpY/8zgWNlbz80IOQl8sm0agb0o24rqtxv8Xzm/LVzHOcWJPxURq92383N
         XxTlHFT0seFpUBht48HYxErMUoM4p19AQP/2ox6umgdlFEFNNooJhErhwLXhaXBT3j8Q
         XkRhT71f8NRgXn+PcpFIopZOVJBeVqg4oVRkfDoIk4dE94XV6WNNo5pExT5tinrEY7gW
         XZfA==
X-Gm-Message-State: AOJu0YyD2KKvg5bLt2YoxXUu55ISPhh2YGvphx2tVCQ3+IBKoRA4n8ph
	/BT10YU1lbmKv40g6xgM0Stsxdv58er31HFtAO7Vqh/sp4YaEqHVGvEclIHyjomKN2s=
X-Gm-Gg: ATEYQzzmvRzpum0OZpQerT8EGr4eQvtZNzJShT2Q24TjhEsXHhKVbh0m1IUnrk0mK0E
	TBPAMRam8kaGpZx2r2+/2qqdHnwgEJGWZ85KEwEGhnTPtGvdUTxyNMtoUVlVOE47LH4Vl4YDQYh
	sHRv0O++mbnoFqadKWxiELjxOBGovBOJfb6lxZOmpq72RRexCxsz3w6ppR3Nukomul48G9g1zw5
	Hwj9xN/ZaTX+y3RSisQAtfFfQJHz4ZUveXC+hKWolN3OmlYpze/BuUh/cd/Yfxbj9eUAkuC/AgF
	XtESC9S19EXLuIDhipuv/2DAUSDi7HorCFqrtB9InOE2Ts+H5FpwjKYy7KNlRnChWJsfz82fyVZ
	9S4W0JC1bjF6yKm0n5V0NWm+197QNpYSNYwlw2Gs5oEzXa5hJZ7zEPa9pePz1Z4Bbi4h7mhGNAe
	f9HN0FYhmIrgG3K7FdudHpzHpn80nrafBcTtU=
X-Received: by 2002:a05:7022:10d:b0:128:d4be:7428 with SMTP id a92af1059eb24-12bfb74c67bmr2198507c88.19.1775253681501;
        Fri, 03 Apr 2026 15:01:21 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bfea5f860sm2342414c88.2.2026.04.03.15.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 15:01:21 -0700 (PDT)
Date: Fri, 3 Apr 2026 15:01:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v3 0/7] net/sched: Fix packet loops in mirred and
 netem
Message-ID: <20260403150117.5bf6cdff@phoenix.local>
In-Reply-To: <20260403140040.7aeb565c@kernel.org>
References: <20260326181701.308275-1-stephen@networkplumber.org>
	<20260402131618.21624737@phoenix.local>
	<20260402174906.0ee218f2@kernel.org>
	<20260403120354.6e926c05@phoenix.local>
	<20260403140040.7aeb565c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275242-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE210398A34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 3 Apr 2026 14:00:40 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 3 Apr 2026 12:03:54 -0700 Stephen Hemminger wrote:
> > On Thu, 2 Apr 2026 17:49:06 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >   
> > > On Thu, 2 Apr 2026 13:16:18 -0700 Stephen Hemminger wrote:    
> > > > Why is this marked Changes Requested.      
> > > 
> > > Is this a question.    
> > Yes a process question what is the blocker? What needs to change?
> > More review?  
> 
> I think what happened was it was posted at the same time as another
> series for netem and made TDC fail. Then Jamal said something which 
> TBH I didn't completely follow so I left it as Changes Requested :S
> Imperfection of the maintainer, I'd say :S
> 
> Please repost if the series is good (presumably once the other
> series you have pending for net goes in?)


No problem

