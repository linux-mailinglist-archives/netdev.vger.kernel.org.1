Return-Path: <netdev+bounces-81093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40469885C37
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 16:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92161F26E0F
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BD38626C;
	Thu, 21 Mar 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wDDsCNMA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95A86262
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035516; cv=none; b=pWYS1Jn/3FI2zpaekP/Scu+rZqXdoG7gvsIgy8IX7gLDyUAxq7fqTU/yqMdRAiZF+1+aPJQrNs9/R8Y4oATbp72+Pn49AWgjq8PetVJG/tTGQdEpuvoyTcGR88PQWTV3qt8wl0AAIXvImnEi8GtveRE4MHmTXVRZ0B1+Jrx2ZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035516; c=relaxed/simple;
	bh=AyDP6ochd65d+zvQPE/QMaZ5RobGX59ZcxleqBE4qMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I53nQxjJzTI4jeMccW8rgO8kb5KbpcMJ030xMAWcxUfTju5zUQyZI91VMc3k49hTucffXCd81mDIsMZjoax8NmZ3fre+S7FxHhYLFST6ovYty6Yj0AbBMSmQXD1xLnhsjPklNn0qTkAW3+1BpJ61j/obQeHo5fLFgjRLOvZEIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wDDsCNMA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4wLSlOkCaIoYkTt4N+TPWubydm9nXBYxh+G1LvS4yMY=; b=wDDsCNMAtM2RbdO2isCTTkNeKs
	ZsgLzXtMFkBZtcgiKJLqUHL+BTVGbUObXUhCDya2/GGrmLTy5WLnoMdP0ZVJRoBFOYnLnAKFbB2xF
	sZquMFjrv45UtEWhgJhwikVy0BPjmTk28CdCQ3aRwxoQLSpiG2dX9oYDWvXXoQXLLAJ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnKUs-00At9d-3z; Thu, 21 Mar 2024 16:38:26 +0100
Date: Thu, 21 Mar 2024 16:38:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Serge Semin <fancer.lancer@gmail.com>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, guyinggang@loongson.cn,
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 08/11] net: stmmac: dwmac-loongson: Fix MAC
 speed for GNET
Message-ID: <2f84de49-7e03-4851-8d75-c0d17813d573@lunn.ch>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>
 <fg46ykzlyhw7vszgfaxkfkqe5la77clj2vcyrxo6f2irjod3gq@xdrlg4h7hzbu>
 <4873ea5a-1b23-4512-b039-0a9198b53adf@loongson.cn>
 <2b6459cf-7be3-4e69-aff0-8fc463eace64@loongson.cn>
 <odsfccr7b3pphxha5vuyfauhslnr3hm5oy34pdowh24fi35mhc@4mcfbvtnfzdh>
 <a9e27007-c754-4baf-84ed-0deed9f29da4@loongson.cn>
 <3c551143-2e49-47c6-93bf-b43d6c62012b@lunn.ch>
 <ZfxQHv7Y5Pqgfq4c@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfxQHv7Y5Pqgfq4c@shell.armlinux.org.uk>

> However, because stmmac uses phylink, we should be adding phylink
> interfaces that forward to phylib to avoid the layering violation.

Yes.

Maybe just call phylink_ethtool_nway_reset()?  Just depends if the
additional phylink_pcs_an_restart(pl) will mess things up for this
device.

      Andrew

