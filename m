Return-Path: <netdev+bounces-297030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L8jPIjkAKGr26wIAu9opvQ
	(envelope-from <netdev+bounces-297030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:59:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD00465FC3A
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:59:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eM8rVVSy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297030-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297030-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDE1A303A8FB
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC44404BD0;
	Tue,  9 Jun 2026 11:55:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179ED3F8257
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 11:55:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006148; cv=pass; b=A25QnRJSumyHdk+zvR5KSaefJqSdZ1liH3c8Ur2caypSu6BzZ0TwdVOQq+Bptbqqqa2uMOU7YNvTFz9Uy342wEAw3qteMPY+Rplafxq2psqAEUoco/aXb2mWmcWHC1Q62+3in5Twi6CO6fHWmLenkVK2fu6oKB9jzVjC0m1xK+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006148; c=relaxed/simple;
	bh=FKJs8B/CpzRObFelhj5Ni9IZqTohjsKgThlEuhgNuUs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qDK2TOkjO6C2E/CiEtm/HiDbTubBVZXDmb7LMzvYUHmmzM1lpcgZ3GKa+HPB7WiidO0qPq2BotPD2yuT4qQoS63O5ijQ6hBy+hKMl4W8A6jisxzUDd/q6z0G5UCSyFlkKUJcEvp+s6j1KklVCUCtkCeL086x2qAd3XXUMyZI3Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM8rVVSy; arc=pass smtp.client-ip=209.85.219.66
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8cebfb15413so57838106d6.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 04:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781006146; cv=none;
        d=google.com; s=arc-20240605;
        b=F5eu9pL9rLKrRSFHzTmyusi+Bb2tLRo1RgWh4oPJGOrdR7J3U9yfIhtOupsiHVo+2P
         1YgEpBFkfZOOtLDr0810VqC2Qz1gAPwZPp3IxbfMgSZqK6+Xe57UtqDGBd3h69oGc1fU
         zSWnta5VG0oK2OWD5G4I7csaAQneNTDdCHqJ9ZMxsj5s8zeMbaB3I/5duRn2ZFj99gYd
         rQjLrGnTwJfDSyExWYxCr4ZmTURm85uNJJeGfhIBiQfQA55+321L8GzSSYtosIpc9GlJ
         SZZ5nA374zPWm1HXN5xu1JL0ID01EmgrYs+6y+CvFvYqatEaxLmEBvZGPRTZA9En2eIB
         PZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ccLfzzecOI94kITVqiyQjRCRJIDy/3yUfKVrOQs2bcI=;
        fh=p36qR5ekPgTJ8/nEb8vE4EeSCUojSN2HHX/72gAbQkI=;
        b=BuWtA7ZIt9MJ01oR9UQyoPrSHUDQKFFmWhDcUn4vbyJ2nK18GlzFkmGgOtWuuEW9FR
         Mo40NXH91PLIgjBh8NlBe1LB8XvJQX5JR6Ac8p+aNvB2/MgqVdKDa0XLsy3c3O4P3Efk
         PzsxxrV9vVV9ruA+Vzroc7GnMDFsPBATk8ssDehGAWf6Q+UUfZg/ccWHNumWenjc6xGp
         Tfdj/YykVbY3OLo9P4Uia2srCxah8mGr1XPXnKnsNmeR5m1+urbDtRdOVyio5xf0sj4l
         721jn9vNv099OVbor8Smf8XhxOl/gdFzEWnRnVHo+8ikrtv9QbvRz8IA1POssf9ftKsV
         UMsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781006146; x=1781610946; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ccLfzzecOI94kITVqiyQjRCRJIDy/3yUfKVrOQs2bcI=;
        b=eM8rVVSyj6nOD6r4GepekEv9mlDw6sMkuXGGSG9Mtyn3UdyMtKNFRUpbfhGraeaaq0
         y5h4Mj7GCI8yXd7vM4L99+L021+ucu3+8fTWuvQ9lqSse0S4uco4bgEiygytsXAU50+k
         BLl3yP+b7lWDqH2Q8jAMrisw0M9cRsLNk5Mw8nlfYTAG3EtH+cuC8fWfue7CeIbIAWtU
         d2vefPV5vvGzF4gXoi4JZG4NpkiUmi++xDiUQ1wYzlHgRu8qOG/Oftwzr4LZlcoyhPBM
         STB8Cs6pMOjJ7kI07/q5DG7ProB4lLequtyP5MIAuCjSjjA2iMZJ4vguxtQG1UHkqaxS
         QvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006146; x=1781610946;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccLfzzecOI94kITVqiyQjRCRJIDy/3yUfKVrOQs2bcI=;
        b=ii53XmkxeIBgnQDhdZsXG+bf/GpmesyLko0xhE4OYRocykXFtFUr2LgQfo4Kq+brzr
         w0fgR3edHi/Px5YYn/UEbv+6IXB7Pyqiq+Oi+U6LMCeg0mckVnhnF8m8vbbK3CN8Whyo
         QcyRyYzHYfYwCHoKmgU4hiHII/iy0LkX+H8qJ+aL5mCV98Aw+IhOmH4ergEzp4tQ2skq
         uykY8YZpPfQqUg8go1Ip6nk+nxYe91cqwOAZRnM12uYpWHjzo+VbTqkWp89bXd0v3qPj
         /0y8emuEQnbEU4lJzDtrXmFxoV/tdeHK3e8lrZ8ilge8LCqI3GEA+/lMuCsuHkXFJLRq
         Ygow==
X-Forwarded-Encrypted: i=1; AFNElJ/efEhUcWccH0Z4uvbax8Hay+RB7iedkNNr06rrnycsZqQnK13pO70F3/GfNL9eeS518MqWnV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1O/OJDe8Ozh2rUdbdoURBLEGZH6O/GAepPbzVzaJE5CheoWf
	8F1O7paAhHU1n7Js+Ts0IOa9t3ssFuC5efv/ZhR3IFgByP441epl0ubzG+eCqVyTv1ouC4og9HZ
	u3FUS89gN/27cgSoay5HL8kZ+1MY4rD8=
X-Gm-Gg: Acq92OEmOjz6LW6A91JPwNl41x+TqOGTfmCsYu7hQpq3nmdRabcLx220ZKgZvITslcV
	usLc0DRNbQPV66Xv+KH/kaY41qVcDVOJzw4JPQLuCX5IM0IwcvyeWE7lWSfYpZB25Gy/QtrtLCB
	/7NemFO1oS5Gl5riIdGS3fRRhWYWaEHqiiFo19NL+oI3isqq/cW33qUwSt+R487jFevscuKfUqs
	vJ1XiWEBx6vvqlsKTXeUnDnufDWXVodH6b801anQBzjwtC87mL21djJc0KNDcxMvN6uiZiuxSWJ
	wcEKZfpFomAdPmHLObKP14o7058X
X-Received: by 2002:a0c:f156:0:10b0:8ce:b2e9:a4bf with SMTP id
 6a1803df08f44-8cee5fed2edmr261948636d6.16.1781006146033; Tue, 09 Jun 2026
 04:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Longxing Li <coregee2000@gmail.com>
Date: Tue, 9 Jun 2026 19:55:34 +0800
X-Gm-Features: AVVi8Cf-JY9xHUp5ARwbSMr5Ssxu8o6eb8KyWoWmOUOtK_hy1_hOV33TAjOBkZg
Message-ID: <CAHPqNmyfm4j0Vy--8rpYMEY1wOP-TgmnRWYd=7ragj1Z29=F7g@mail.gmail.com>
Subject: [Kernel Bug] INFO: task hung in xt_find_table
To: syzkaller@googlegroups.com, pablo@netfilter.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297030-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:syzkaller@googlegroups.com,m:pablo@netfilter.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[coregee2000@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coregee2000@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD00465FC3A

Dear Linux kernel developers and maintainers,

We would like to report a new kernel bug found by our tool. INFO: task
hung in xt_find_table. Details are as follows.

Kernel commit: v7.0.6
Kernel config: see attachment
report: see attachment

We are currently analyzing the root cause and  working on a
reproducible PoC. We will provide further updates in this thread as
soon as we have more information.

Best regards,
Longxing Li

==================================================================
https://drive.google.com/file/d/1Bx2unEf-QntjVi8g6Zw7QNO6OP4cjGO_/view?usp=drive_link

https://drive.google.com/file/d/1ELWnHa1fKJSXMFMNxMzw-Yje3XSETRBt/view?usp=drive_link

