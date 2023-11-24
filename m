Return-Path: <netdev+bounces-50878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B0E7F76E1
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9311C21148
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1B728DB7;
	Fri, 24 Nov 2023 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TKP2haAl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99EDD60
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 06:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Doqkdo2wDa/GeK41KKlD3aytXKdYoeayjDsQ9gRgitc=; b=TK
	P2haAlTEQNDDlGc+HPiePZaUs1AE2vRm6RQDR+9GFgxkwOiBhndi1ShEmce3xr++nJXJsXD6JCnmh
	GhlnlEWJ8gJYBPezmBkprqRrAKgBCG6CJ53vOvMIWgV2Xuj3Jc+5qcFkzqsmzlh5aTQy2BRUuFDwj
	T8GupjMxpdeNfjQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6XWO-0016at-9p; Fri, 24 Nov 2023 15:51:08 +0100
Date: Fri, 24 Nov 2023 15:51:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v5 3/9] net: stmmac: Add Loongson DWGMAC definitions
Message-ID: <7dde9b88-8dc5-4a35-a6e3-c56cf673e66d@lunn.ch>
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <87011adcd39f20250edc09ee5d31bda01ded98b5.1699533745.git.siyanteng@loongson.cn>
 <2e1197f9-22f6-4189-8c16-f9bff897d567@lunn.ch>
 <df17d5e9-2c61-47e3-ba04-64b7110a7ba6@loongson.cn>
 <9c2806c7-daaa-4a2d-b69b-245d202d9870@lunn.ch>
 <8d82761e-c978-4763-a765-f6e0b57ec6a6@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d82761e-c978-4763-a765-f6e0b57ec6a6@loongson.cn>

> In general, we split one into two.
> 
> the details are as follows：
> 
> DMA_INTR_ENA_NIE = DMA_INTR_ENA_NIE_LOONGSON= DMA_INTR_ENA_TX_NIE +
> DMA_INTR_ENA_RX_NIE

What does the documentation from Synopsys say about the bit you have
used for DMA_INTR_ENA_NIE_LOONGSON? Is it marked as being usable by IP
integrators for whatever they want, or is it marked as reserved?

I'm just wondering if we are heading towards a problem when the next
version of this IP assigns the bit to mean something else.

	Andrew

