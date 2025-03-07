Return-Path: <netdev+bounces-172929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8967BA5686B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE2B16EC97
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E366420F068;
	Fri,  7 Mar 2025 13:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D3A219A9B
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352597; cv=none; b=jKoOdb0TR6fD6A6m1TcfbK7H0+eAw7+kpoXfcI2NGFcVlpY1265kB4nJI3WcdkQlXp9X7pvq9MateLrRPQRXxRRviofS5iOeqj5HWDLX+xzkA6EU6EOpMkGMeAImaXQDswLyrxGymitTdJMa+6NN/nsnJo3x4MTTBmTRZWdQGS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352597; c=relaxed/simple;
	bh=9sSfSCNJuGh7+401kQz0K5JyXtMAnDudoCNPfUFhe1A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gYCMHSac/Eghl0gHAEQ+kIjfW4IjxbX4PENCNkXK0t9DsyxX2cAx9x2m0JnV7ALlDZK/VAEixilVEcFP08uvrUc9DEaGjD9hIkG76bOXaHM5JB279wq3xlA9HSwAY8xguOuYQ9sXmHembCuDhlHoX9tx2ry7BlSXj7m05XCtJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaecf50578eso342956666b.2
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 05:03:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741352594; x=1741957394;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbE+feLK/wdrcW3YIi4q9NS5y6sznYh7FGT/9ZOSlLg=;
        b=EtHgAa7R9CU5F4PdXTkRFz4v/KfMh5/ivDyS5M9djrTvec/OO8mi7RcbTD3aLTtLKz
         sxresFMvaV9vMaFZojxcSgsQYvLr3KHJBREzc8yp5kLmPzt9U7Nd2TmXl/FDc30qnvJb
         VsJtKn6M1IybBGbVqzqNelFLBfCOwtBTYbjp1+j6G2Nck4S+P205loOM9fqLX3O6FQT9
         qd5Z/GIK6H6AiTqyrowV5Di11laRORgYopnyu9fwOhvcQzTmF15xFNCP0ja5s2cHtTIT
         u2o1ftfZXnRmxAZ7Vn9sItDlul9JfVlVU1mami4eKMeGZmVnF+9sT5P8KyhQ3vQZ+i/X
         +rKg==
X-Gm-Message-State: AOJu0YwdTLl1YGfiVMWlrzfLEMTeeYWAQUu+v+6Wt1aoOyduj5/CxoGH
	8buSN1Slpe2XqmVe2zNpzRahc46HLgHtd+kHUX/3zs6d6/n4o8ESKQDeTQ==
X-Gm-Gg: ASbGnctHkHR19JViVP9ESx3U7kQd3+Gmg1/L15AF4NBRRWWZ6Ur26Ji1wi6ivnL8V/g
	rw6Du44zih4qUaB7aqs5FrIRlWQT/iJr0+jWs4YxVQGZ/tQ+56HZmr+x9uoxk9lO7zz2kLkBc3d
	wJdsgrV3ifryENY5AhKvo07zEV87m7UUrX0f3t/FAN5fE3Gs+6BfLvKt+L5z5NChNYCKTlBCqNo
	Rza3WyDdOPNk9ttdZGwVhrqd8KM0w9gkqrQzMGvzIXb2WxctyJki31tjqFHR/06A+Wi//tZtfll
	Mi24IeWCUTyneJpm/nL3rErtuyZemyNBmOg=
X-Google-Smtp-Source: AGHT+IHTAZKQiwu/aK0inH8jz/Ec06qUrsdwX0njTGh+xdIMJdDLbdaZSxb04h98fbtTUAss+K5V+w==
X-Received: by 2002:a17:907:c1c:b0:ac2:63b:6a45 with SMTP id a640c23a62f3a-ac252bab1b1mr394060966b.30.1741352593663;
        Fri, 07 Mar 2025 05:03:13 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399d4802sm276239066b.175.2025.03.07.05.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:03:13 -0800 (PST)
Date: Fri, 7 Mar 2025 05:03:11 -0800
From: Breno Leitao <leitao@debian.org>
To: eric.dumazet@gmail.com
Cc: netdev@vger.kernel.org, horms@verge.net.au
Subject: netpoll: netpoll zap_completion_queue() question
Message-ID: <20250307-lovely-smiling-honeybee-d15ecc@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Eric,

I am looking at netpoll code, specifically at zap_completion_queue(),
and I saw you tried to get rid of it a while ago with 15e83ed78864d0
("net: remove zap_completion_queue") but it needed to be reverted.

Unfortunately I didn't get the history behind the revert in the mailing
lists. Do you remember why it was reverted?

I understand that zap_completion_queue() is being called to potentially
free some space (by dropping skbs in the completion queue) when trying
at netpoll TX side when trying to find SKBs.

I am thinking about the patch below, but, I want to check with you since
you have some context I might be missing.

Thanks
breno

	Author: Breno Leitao <leitao@debian.org>
	Date:   Fri Mar 7 04:30:08 2025 -0800

	netpoll: Only zap completion queue under memory pressure

	Optimize the netpoll TX path by removing unnecessary calls to
	zap_completion_queue() during normal operation. Previously, this
	function was called unconditionally in the find_skb() path, which
	unnecessarily slowed down TX processing when system memory was
	sufficient.

	The completion queue should only be cleared when there's actual
	memory pressure, such as when:

	1. An SKB was consumed from the pool, and we need to refill the SKB pool
	(in refill_skbs_work_handler())
	2. We can't allocate new SKBs during polling (and netpoll_poll_dev() is
	called (which also calls zap_completion_queue())

	This change improves netpoll TX performance in the common case while
	maintaining the memory pressure handling capability when needed.

	Signed-off-by: Breno Leitao <leitao@debian.org>

	diff --git a/net/core/netpoll.c b/net/core/netpoll.c
	index 8a0df2b274a88..83d6c960d2079 100644
	--- a/net/core/netpoll.c
	+++ b/net/core/netpoll.c
	@@ -283,7 +283,6 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
		int count = 0;
		struct sk_buff *skb;

	-	zap_completion_queue();
	repeat:

		skb = alloc_skb(len, GFP_ATOMIC);
	@@ -628,6 +627,7 @@ static void refill_skbs_work_handler(struct work_struct *work)
		struct netpoll *np =
			container_of(work, struct netpoll, refill_wq);

	+	zap_completion_queue();
		refill_skbs(np);
	}

PS: This patch works on top of https://lore.kernel.org/all/20250306114826.GX3666230@kernel.org/#r

