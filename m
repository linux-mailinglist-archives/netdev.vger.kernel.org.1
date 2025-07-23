Return-Path: <netdev+bounces-209317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B328BB0F020
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B27583B9C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5902328505D;
	Wed, 23 Jul 2025 10:42:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5990286887
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267358; cv=none; b=PMzK7Z0wrvTPxtQ8P+B/4nlgvol61Jwt5lzP/DrTirrXib8nr9OnRvRaz8ZHy8pydq3k2AUqHGeuMWqy8iwfUd9IoLRprr5wFVyv064sC2wV1vRhiOnCVUluJ635GCwWgNjhORRu+XRtk/I9siwf7XJcqCXyJX1lHuCf2erBUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267358; c=relaxed/simple;
	bh=CeNRvuvwYWoVJB5M5UHDRPJgLHidL2E1QaHeWDWNRNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+sfcPiygk81zG8PYyq5iustrShQ7GxAYkKyClBUbUpjzais6qn2YwrF8qq5mbHXTBh18eH8/KkEAVIwH6Dv/tqusRJOB83lQfCnAMH9q2DFvALaVNgmEPEW+eoEtMsvP2RGMMzUQCZ3Njwyh1qrpjNKQlxi035Oe8C7qdIBM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1753267343tbb65405f
X-QQ-Originating-IP: AMID40wbO4UnU89sYl62AWFs9G0YVjfeRYNVQgQgS8o=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 18:42:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3337543533688690038
Date: Wed, 23 Jul 2025 18:42:20 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: MD Danish Anwar <danishanwar@ti.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] Add driver for 1Gbe network chips from MUCSE
Message-ID: <A7AE3E9B4297A2FA+20250723104220.GA981103@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <5bce6424-51f9-4cc1-9289-93a2c15aa0c1@ti.com>
 <49D59FF93211A147+20250722113541.GA126730@nic-Precision-5820-Tower>
 <b51950c8-ce79-4b0b-af5c-bb788af33620@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b51950c8-ce79-4b0b-af5c-bb788af33620@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OGXGpjbpoMuawxMkxKWRjRmfqayCEX91hguAA7FZKTztmVwECo4Nm/ov
	9aN1CVdHu7fXrOi3Mq7PE6FdIywQbdk8vkoRhLjajKIDBkEqBgje5tsDMgQODTFA+HfZMvu
	Oki3bWhCzimclIsRC/Bl1sTPa6WAA63MCUac12OnkpyhPYZcG0Kko932yYb4mU2ZsTkrhjK
	oNP6ItlXgkBBxu+sjtA4v5oOH0FMLmE/Yj4D3mpP/B8Iv4ll6x4HYw9okgUJhyNMTyX9lNr
	/oWabI4TMdSc+yQw1jAfgOExulwGXXN8pssOBB4yE0w63o0qBTUs9+yX8CytEHTUYCjP7Hx
	ItmT/HqafXgRNmBaqlRacIUJLtR6NqJnEAZ8sRNQVu1Wx9CmsABw20gV8hkSZpJkYp4h2yh
	aUW/TJ0PC3wXCs9qXLudbt8LGNAxlH9jiHFjVgZRw99hIa5n+D7ojn7Hinpj9f8e/TnnBFe
	PW6FCMGwZEYFDU22I61CuEEJ6R2coPCMIb+iZYn+nTYqbvLiE5HhOrcuQqvi/0yalyZy3Up
	FXtf5AcXV2mBlaYng2DoysBsPmHNqnb/NaDCHIwfzaYXHFi7EYNCdHtLqiSdyR0sLjjMtt1
	TU775ZU5KqN9NGkl3UyDH90dEbHHtYIrR40TgVl+W9cDf7yzYIFMv87CX7enApwhJFiZ8c9
	Oto6dgXBO8BRfrOHVMHYP5Vxhu+6se0GUxPQR52LZP42oV+BxjADud8KeYCrPwIwA5uxaVQ
	JbkqbgiJ93b/NDLx/a1449TyM5vJCLpUKLd34q3FoPP9lMTasbyyH3EILrvBuRfs8G0EuKw
	ouJ8RS8Q/gOs2c3HJT+5893W9bk+h0tUzaJsglGkoO4XMlekUXFdeVOWlha0QMSybgup1V+
	JK4RjyEsRpV5Sx7LpxYeMIG6uolDs4cZKMcLOw/8I7iPvxDRjit7wfgQcpeO60b2D537TQB
	HdFoAx5MP483QHY83IXRt0dK3PL0VemeUdgc+GQ65E7ojntcoidmU6vosVsGjG+Kpz/x/mw
	y94Wh7ZhQSDWeTAnIqs0qDDEqUs4Zq66J2RtFWWEYBfd9P+s6i
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 05:07:08PM +0200, Andrew Lunn wrote:
> > A series patches can be accepted without achieving the basic tx/rx
> > functions for a network card? If so, I can split this.
> 
> Think about the very minimum to make it useful. Maybe only support
> PF. Throw out all VF support. You don't need statistics, ethtool,
> devlink etc. They can all be added later.
> 
> 	Andrew
> 

Ok, I'll try to minmum it.

Thanks for your feedback.

