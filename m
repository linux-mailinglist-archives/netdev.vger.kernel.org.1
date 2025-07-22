Return-Path: <netdev+bounces-208787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8A0B0D20C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF5F54366F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 06:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F8919F121;
	Tue, 22 Jul 2025 06:48:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C132BEFF3
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166930; cv=none; b=J6V5SqEwqFtYoMuc2+0lPDKeDYZGiCFzKRuZZWtzhqNUzF7poTWy1Y5zIM1OS0ALohuYfkoQI2afdZpYHBdOWsM7RTZ6x4tFCuemajWNcXaxof1Tj9sZxskQCa1+WMO3RoNhsPrZ/08BY8duZtJEVfrn3B2Kr9qlMRXJ5ypWAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166930; c=relaxed/simple;
	bh=iSbkyPzqN1Hj0CXey8Fx8nw1cT+ihZBX/aPel5YT3EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ/qqNvBWxcEMNV7W7pgsEc9AUVjZs5TgerTU0BfeQplDL3z4pDjVtdf+orto9I3R3zulUaCh0N8Os6vxxm7bzyurV6i2WYn1KreNUc/RirZUef6IcaRDSEUVDSGyacC/Nsy49t+RTqcJCAaGe7ZfKeKXa1OUrV9SwBh53BTaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz10t1753166917tae364b87
X-QQ-Originating-IP: mKK12zRgZoLI2Gza1yGjMKaEIk8SuogXIs16fAZRlJs=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 14:48:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14186350718973111170
Date: Tue, 22 Jul 2025 14:48:35 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] net: rnpgbe: Add link up handler
Message-ID: <689C469EE0E578FA+20250722064835.GD99399@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-13-dong100@mucse.com>
 <a77ef7df-537b-49f7-a455-c23295fddbd5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a77ef7df-537b-49f7-a455-c23295fddbd5@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OYMEOeTae7mluXgwomV2Yl++G1nWnUliEF1+H0GZ/UUaCNOTMpLsOAGt
	qzxLuiZZa9ZfLjX92vJeapkkz2BaghEmRqEq6n7Fr5zm3alZRDanK7j8UT+slD8Y+sa21AZ
	/PFmarH+jS+hQnWzkX1UJ+Le0MvtO7D5VC/NCuUr9PhvIOu0lJRkVq4a1pOb2wtOz3nXalL
	LyikSKXzbjDuwo/yLdctiFF13BSuZeunmfKWSMZoMk/r8e6RPesV7OlDYJbb+Dqtlnd0soa
	Syn4042rAePMA1bHjbQRENAq1WTVA2fBB85KZIlSgVnt7QkgyJnRSVzAsyIz25KsucLMqCG
	OyeLyiQ8EEZEaWCbsBw7pCi2tMUedF8S529qNBR3+XO7NpW7PpC3X9pbluwcDWVnPD7rQwb
	J0VGXtwjyh0G1MNgFonI6P/zVfRGAOHLBe/w/EAwK3EA6foGLjMP//iqdX07MGJ/qAnn1W5
	+0auZyGLDdLxK1XdJqTx7Kk6FRrNJ8Q3ubxbacpnxnnJeSa2qLnoRPsW0MkpiKwTwE0GHM8
	+E6sSeMe75FImeD/zipVrmjPQw2K8JMQR7AeE3ixJd3vxyvq0oqCYZCb+5KBSo8D6AcDJ5Z
	W50sbcZR0Gk9EPUMNd9YUK09U8X9A7wOg5H9rc1j8pthfj3nA/gNvSVvBgrkhMk3tJbi/2d
	EmpVMLjN3moYCCPsmGLcQ3P+8+N1ZBEyG7UeZ0Qqi0W/a5+U8vU571UglRYjSuzFaKkUcxE
	c4KsBgETQoJeSNAvOUXs5LMvHJH3YoS7Cue9OwWFUZpk7RRaOimFGrAisMExRFE4sYuypGr
	573fsU2DwGDch2tzkJT8rlFCGM7s7Z6PBuShtUzaXOBVYwGKXZ4Zf5WDckkQ+2RpcVmWmAS
	2yz6d3aRqfqWTYrQHxPbSvZjUh5vvfiiljpv0+1UShNumeYU4MK/4Tddc5pMzp2ZMDmA+rg
	hAU761qUD2OuGbWI1AgFP22SGfbIgECsYbU3K67A9XUdeZPTekAkgtvYSh+S6wYb8+9U=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Mon, Jul 21, 2025 at 05:47:09PM +0200, Andrew Lunn wrote:
> On Mon, Jul 21, 2025 at 07:32:35PM +0800, Dong Yibo wrote:
> > Initialize link status handler
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  53 +++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  26 +++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    |   7 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 139 +++++++++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   1 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 187 ++++++++++++++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   7 +
> >  7 files changed, 420 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 624e0eec562a..b241740d9cc5 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -26,6 +26,15 @@ enum rnpgbe_hw_type {
> >  	rnpgbe_hw_unknow
> >  };
> >  
> > +enum speed_enum {
> > +	speed_10,
> > +	speed_100,
> > +	speed_1000,
> > +	speed_10000,
> > +	speed_25000,
> > +	speed_40000,
> 
> Patch 1/X says:
> 
> +config MGBE
> +       tristate "Mucse(R) 1GbE PCI Express adapters support"
> +       depends on PCI
> +       select PAGE_POOL
> +       help
> +         This driver supports Mucse(R) 1GbE PCI Express family of
> +         adapters.
> 
> This is a 1G NIC, so you can remove 10G, 25G and 40G from there. They
> are pointless.
> 
> 	Andrew
> 

Got it, I will fix this.
Thanks for your feedback.



