Return-Path: <netdev+bounces-217577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F87DB3916B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2D2983C5D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608B02405E3;
	Thu, 28 Aug 2025 02:03:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C45023D7DD;
	Thu, 28 Aug 2025 02:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346594; cv=none; b=i02D86PljFIzG63Nv3Kk4KIv7ZSgnjq2PJ7RABBSfUyL5TyDopWZIcjzdDhLvCSOSl+09loRZ9htb6+D9EvaeUrpGwUwDDISfgG/9KlTghxIm/Fr6VLWVW6S5kiNLsUjxihL9LzLtxREuq977eQ2k0uELJLXBTDbBtPL+v06azA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346594; c=relaxed/simple;
	bh=UjmKbCyMJJ9zmz7zbM1buwduN9e6eT2BXp7RuIqNz5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVH4YMDbQ6YQR3CNNbN7V/g/vZ5j2Lpna0g6e4i/jxkfB/8nVVjov5FKSWxuacEkny8Ts4XKwsGg5mG/aP0FE6Dbh0x8aPLZcrTYRX2KtxEPHiUdHaAjbvHBxrmmtlZ2MZAL9iGreH1zldW/hASEalo0Pr7f87AaPErqQuhidEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1756346568t07ceae18
X-QQ-Originating-IP: lzFI7TXL1SrYTlvNNRGAzC/pQJsFNUanN24gowoDYvM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 28 Aug 2025 10:02:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13552423620670666961
Date: Thu, 28 Aug 2025 10:02:46 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <0254B5B3B54BEDD3+20250828020246.GA567033@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <316f57e3-5953-4db6-84aa-df9278461d30@linux.dev>
 <82E3BE49DB4195F0+20250826013113.GA6582@nic-Precision-5820-Tower>
 <bbdabd48-61c0-46f9-bf33-c49d6d27ffb0@linux.dev>
 <8C1007761115185D+20250826110539.GA461663@nic-Precision-5820-Tower>
 <bd1d77b2-c218-4dce-bbf6-1cbdecabb30b@lunn.ch>
 <05B2D818DB1348E6+20250827014211.GA469112@nic-Precision-5820-Tower>
 <a61b6cdb-0f20-480c-877a-68c920e76ae2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61b6cdb-0f20-480c-877a-68c920e76ae2@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NDW+fwfL9uPK+yfA2yzy39yfPIHT+4VZCovv/DT/qdT08dLhgMR/A5LA
	N9FMC+com0nZFrWOnixmhRTZNJwZ4wCaPBSUYJPNxCxk4cP8ze8L9ZMFU17olkoZ5qSxLZz
	2Jhiw46Kb7c3CqJkoxtSfoqtDGdw2XffGm6bvkscIA78J/l19sr6SQePquSy5YZl0sRCvpM
	X6/ADOVw1KJS6JfhcRvhLhXlTbUyRhUntTQ+zjjAECWsS8UEPXWNDR9miFGv8K5XHddS7ah
	K6DDeum3WT4D6IAbU2cQTC66QDe8YPgoo8TFV09H1gOn7RpYahmeH/ikG1DfGWj01TMXqkD
	Wc0h5RzQK98F/2JWzg4bpKwg2vAtcP9N9t78GSIl6E8og1xfGVMbJ9gohcoI+gvmBCHqoIv
	ZUp5h+PSbY98bljUG3n0M2XsCRpJkRYxleh+5j2BwNE+at2Vbhmd0B1hQ8PJ4iApelA9gpZ
	dDEjChNfEXugTuYOl8UYtpOXqLWcmZs0bFJ8yiSM5XvysBLiLNlCnRrqG8i5Ss1sQbkPQpk
	CtlHobMY7Z5uBjdUknCZ3qVeP6aZZqcHnQQqzaF18ka5dqpqi68/ynj02tsllzZ/1y6kqND
	RIomX0ndiPH0YjWvzcQGLbsjDuisf/MoxkTOSuP2JlVylFpEozLS41cQl7ophbsiaXbH6aU
	JivlmLdbL8AH39Z0qjSyjF82ZaO+fBbksXYnr7+iFX+P33GoFGWRGbqAxUGvL70+s2q4IpF
	VqOdTwxhm6Fiw9IkPSRuJI3D8o0e9EjJgDL5+0v6qWoVUUi8g01QcWxKQ8t3adxtzzRa8VT
	RNuCaEWJtEDb/VZTpUV/TzajamYaRP60OxIg3IOKnATiPLpB2QqPCNZbdGSefdm2Lpnws+q
	i1L1JqNcm4SeJfw7rxVXKHqgFJpK0T0AkuLc3jK67adMipmfOqz/MFXwtq/yqAZNmQYuKf3
	BJhA0jy31DQ6RuuEYv2XewI/Zt/7eKm9lC6GBClgq2Eh6i1VBrordsVAC3YFEY05fuKQyHY
	luSKF8J/wInTnk6nRD6MQyfWTlpIcw3GEs49CF5A==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Wed, Aug 27, 2025 at 09:54:58PM +0200, Andrew Lunn wrote:
> > I try to explain the it:
> > 
> > driver-->fw, we has two types request:
> > 1. without response, such as mucse_mbx_ifinsmod
> > 2. with response, such as mucse_fw_get_macaddr
> > 
> > fw --> driver, we has one types request:
> > 1. link status (link speed, duplex, pause status...)
> 
> Is the firmware multi threaded? By that, i mean can there be two
> request/responses going on at once?
> 
> I'm assuming not.

No, fw is single threaded.

> 
> So there appears to be four use cases:
> 
> 1) Fire and forget, request without response.
> 2) Request with a response
> 3) Link state change from the firmware
> 4) Race condition: Request/response and link state change at the same time.
> 
> Again, assuming the firmware is single threaded, there must be a big
> mutex around the message box so there can only be one thread doing any
> sort of interaction with the firmware.
> 
> Since there can only be one thread waiting for the response, the
> struct completion can be a member of the message box. The thread
> waiting for a response uses wait_for_completion(mbx->completion).
> 
> The interrupt handler can look at the type of message it got from the
> firmware. If it is a link state, process it, and exit. If it is
> anything else, complete(mbx->completion) and exit.
> 
> I don't see the need for any sort of cookie.

Got it, I will try in patch which adds irq handler in the future.

> 
>   Andrew
> 

Thanks for your feedback.


