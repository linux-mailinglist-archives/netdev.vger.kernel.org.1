Return-Path: <netdev+bounces-117419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E8894DD7E
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 17:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C72C4B20A44
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB95915AD90;
	Sat, 10 Aug 2024 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GTqGJu15"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2685B3FB31;
	Sat, 10 Aug 2024 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723304221; cv=none; b=ZRf4uFigPuX5ApemOZNnRCENHzPufSN9KqM7bTaHWQnZeWZhYKyv9tEtEiup+75m+vOcv6kZKteiDggx08J+qFmsm5+UFBr7LEqbaYqvKIdBNVyMcePWvyCwXqoHpAFY4WlUaR28Uz38sRbEgLydwtOmehuyFjq9g3C/EDIS2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723304221; c=relaxed/simple;
	bh=rk0h//kNadRvGwUIVsLSY/s8fPXfayYXmdtWiPMuN/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d74mcegHvQfhcCfU6D2H++6MtmmUoeZu4IHdnz9bdw1XCBK1ittNANilaHUs1sqDJS8/TqVA90K2/ZP7aqOI7lUscq3l26PyMTGHsfdgoeQ2gbJveLmsGpNWZzLMv0Xmy/0e51uA27crdPBIOgHLaDHnpNpztmCRnWfEshWgezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GTqGJu15; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E6Oda4HdEg1Enuz9oVCvlhnuHEVkoHUTSD/lPFZ9MFI=; b=GTqGJu15CPkEq9qQukFSlynL7I
	6wInbFE+gXvcb/fC1W0v/3izIKn/Ucjf03Ba8RD2Y4+uULi6tOVrsU+hnh3b4Qq4ivzAmUsc3pRuh
	XO+2EOzk+1H7i3XmVVkWqQtr2vZPn7mW7EHg/9NdR/TJm6OTpx86wskrhEfcG8Ti/fBQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sco8w-004SCV-Rr; Sat, 10 Aug 2024 17:36:34 +0200
Date: Sat, 10 Aug 2024 17:36:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: EnDe Tan <ende.tan@starfivetech.com>
Cc: Tan En De <endeneer@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [net,1/1] net: stmmac: Set OWN bit last in dwmac4_set_rx_owner()
Message-ID: <a3b52da3-a084-4fc5-a60f-90e18d9f8132@lunn.ch>
References: <20240809144229.1370-1-ende.tan@starfivetech.com>
 <06297829-0bf7-4a06-baaf-e32c39888947@lunn.ch>
 <NTZPR01MB1018A388BD187A1CB38833B3F8BB2@NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NTZPR01MB1018A388BD187A1CB38833B3F8BB2@NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn>

On Sat, Aug 10, 2024 at 02:58:50AM +0000, EnDe Tan wrote:
>  Hi Andrew, thanks for taking a look at my patch.
> 
> > Are you seeing things going wrong with real hardware, or is this just code
> > review? If this is a real problem, please add a description of what the user
> > would see.
> >
> > Does this need to be backported in stable?
> 
> On my FPGA, after running iperf3 for a while, the GMAC somehow got stuck,
> as shown by 0.00 bits/sec, for example:
> ```
> iperf3 -t 6000 -c 192.168.xxx.xxx -i 10 -P 2 -l 128
> ...
> [  5] 220.00-230.00 sec  2.04 MBytes  1.71 Mbits/sec    3   1.41 KBytes
> [  7] 220.00-230.00 sec  2.04 MBytes  1.71 Mbits/sec    3   1.41 KBytes
> [SUM] 220.00-230.00 sec  4.07 MBytes  3.42 Mbits/sec    6
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [  5] 230.00-240.01 sec  0.00 Bytes  0.00 bits/sec    2   1.41 KBytes
> [  7] 230.00-240.01 sec  0.00 Bytes  0.00 bits/sec    2   1.41 KBytes
> [SUM] 230.00-240.01 sec  0.00 Bytes  0.00 bits/sec    4
> ```
> 
> Used devmem to check registers:
> 0x780 (Rx_Packets_Count_Good_Bad)
> - The count was incrementing, so packets were still received.
> 0x114C (DMA_CH0_Current_App_RxDesc)
> - Value was changing, so DMA did update the RX descriptor address pointer.
> 0x1160 (DMA_CH0_Status).
> - Receive Buffer Unavailable RBU = 0.
> - Receive Interrupt RI = 1 (stuck at 1).
> 
> which led me to suspect that there was missed RX interrupt.
> I then came across dwmac4_set_rx_owner() function, and saw the possibility of 
> missed interrupt (when DMA sees OWN bit before INT_ON_COMPLETION bit).
> 
> However, even with this patch, the problem persists on my FPGA.
> Therefore, I'd treat this patch as a code review, as I can't provide a concrete proof
> that this patch fixes any real hardware.

O.K. Please target this patch to net-next. We can always get it
backported to stable later.

> > Is the problem here that RDES3_INT_ON_COMPLETION_EN is added after the
> > RDES3_OWN above has hit the hardware, so it gets ignored?
> > 
> > It seems like it would be better to calculate the value in a local variable, and
> > then assign to p->des3 once.
> 
> I didn't use local variable because I worry about CPU out-of-order execution. 
> For example,
> ```
> local_var = (INT_ON_COMPLETION | OWN)
> des3 |= local_var
> ```
> CPU optimization might result in this
> ```
> des3 |= INT_ON_COMPLETION
> des3 |= OWN
> ```
> or worst, out of order like this
> ```
> des3 |= OWN
> des3 |= INT_ON_COMPLETION
> ```
> which could cause missing interrupt.

I'm assuming the des3 is mapped as non-cached. So each access is
expensive. If you can convince the compiler to assemble the value in a
register and then perform one write, it will be cheaper than two
writes.

	Andrew

