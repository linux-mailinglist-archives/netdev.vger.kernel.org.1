Return-Path: <netdev+bounces-58240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7256C815A05
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 16:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B1B1C2161C
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4877C2F87A;
	Sat, 16 Dec 2023 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TD0pN7zb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587DD18EAF;
	Sat, 16 Dec 2023 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RTORsuSZkvTY31cBxhOWBrsjpZhS9406R8HEK6TsWi4=; b=TD0pN7zbB0jXOyXv6KMq2/137+
	Fp9nw07US5W1x3YwL7ogqlxquYrzrn5c0D4bYvvC+9IKP5+fkl+NmiKJ7FQ8hqGHvPbNbIaiz4l0J
	uMhNMunnY0lbMCASpOfvUVSB6Y/8nKffFsTWWuxL2ivGy84dM8cnhKhsUkiclVirVRKk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEWsc-0036TX-Ty; Sat, 16 Dec 2023 16:47:06 +0100
Date: Sat, 16 Dec 2023 16:47:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v6 5/9] net: stmmac: Add Loongson-specific register
 definitions
Message-ID: <8a7d2d11-a299-42e0-960f-a6916e9b54fe@lunn.ch>
References: <cover.1702458672.git.siyanteng@loongson.cn>
 <40eff8db93b02599f00a156b07a0dcdacfc0fbf3.1702458672.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40eff8db93b02599f00a156b07a0dcdacfc0fbf3.1702458672.git.siyanteng@loongson.cn>

On Wed, Dec 13, 2023 at 06:14:23PM +0800, Yanteng Si wrote:
> There are two types of Loongson DWGMAC. The first type shares the same
> register definitions and has similar logic as dwmac1000. The second type
> uses several different register definitions.
> 
> Simply put, we split some single bit fields into double bits fileds:
> 
> DMA_INTR_ENA_NIE = 0x00040000 + 0x00020000
> DMA_INTR_ENA_AIE = 0x00010000 + 0x00008000
> DMA_STATUS_NIS = 0x00040000 + 0x00020000
> DMA_STATUS_AIS = 0x00010000 + 0x00008000
> DMA_STATUS_FBI = 0x00002000 + 0x00001000

What is missing here is why? What are the second bits used for? And
why does the driver not care which bit is set when handing interrupts? 

    Andrew

