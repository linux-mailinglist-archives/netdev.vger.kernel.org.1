Return-Path: <netdev+bounces-49664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3337F2FFF
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 14:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAF01C21A0D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9150551C5F;
	Tue, 21 Nov 2023 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n0DylS3t"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7163BD7E
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 05:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=DYYXpMKTNSlAZz0EhMyy0t5hRj9u1q6sRN2TryLeepE=; b=n0
	DylS3tTwj+MTVnMGG51U6kqXg6PLUft+784B8BjIRFHCGriRLH36MTvqQGppkOVG9c4CCsh0KTDIp
	0NcPiqVv+uJ5I0ZR1GRn3RMsuVpN1G4mg+SdPZ7sORiJRSibrEU04icQodY8LlejnBCCQdNaJ01T/
	Q2+0kFsoTYGUbM0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5RHT-000lHy-87; Tue, 21 Nov 2023 14:59:11 +0100
Date: Tue, 21 Nov 2023 14:59:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v5 2/9] net: stmmac: Allow platforms to set irq_flags
Message-ID: <a4552462-0d18-456b-83ef-265b5f9f0080@lunn.ch>
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <e18edf4ab0a83de235fa3475eee4ba8ac88ee651.1699533745.git.siyanteng@loongson.cn>
 <111eed66-afd6-4ae9-acc6-1e32639051cc@lunn.ch>
 <427158b3-bd50-4ba5-8395-bba7465333b9@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <427158b3-bd50-4ba5-8395-bba7465333b9@loongson.cn>

On Tue, Nov 21, 2023 at 08:01:53PM +0800, Yanteng Si wrote:
> 
> 在 2023/11/12 03:51, Andrew Lunn 写道:
> > On Fri, Nov 10, 2023 at 05:25:41PM +0800, Yanteng Si wrote:
> > > Some platforms need extra irq flags when request multi msi, add
> > > irq_flags variable for them.
> > It would be nice to document what flags are needed.
> > 
> > You also seem to be pass the same flags to all instances of
> > request_irq. However, the flags should be specific to one irq.  So you
> > need irq_irq_flags, wol_irq_flags, lpi_irq_flags, etc.
> 
> It is a trigger type.

Yes, i figure that out eventually. But it would be good to state it
here.

And trigger type, edge verses level, rising vs falling, is a per
interrupt property. So you do need the flag per interrupt.

	  Andrew

