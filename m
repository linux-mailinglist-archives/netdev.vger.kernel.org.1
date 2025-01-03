Return-Path: <netdev+bounces-155102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E3CA0104F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 23:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32AA1883972
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A738719F411;
	Fri,  3 Jan 2025 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HgTT/mlk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB628E8
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735944284; cv=none; b=ZX5uwDbNMhEyqMCA0fMJ30Aq7YzBC4tcWaeUWxveaJAT1PlOlPvyj4OSCKrTIqOj8ReTTxMA2e0oa4MQ9ZdR4SRIMy7aOCeP9KgRUSrnahUdG0PXB8F162jSikqELQ6YdEznXmw2I0W3HQWuR4UutAlqsfZwxoB601WIky+8OhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735944284; c=relaxed/simple;
	bh=Xdysxq/qIhjODGb3TuHPJY4Gse8uDrwMLaUZT+6yl1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+O942Xwy0lCJJ/71lPtKHcrqtL72jxf0VHuKftgNuJH1XKlUAHTzkqDJK35YI3E9hAg6cvHxCN2BR31clKyFWx68vEUbgfJxShTLQ4qtJD+0NQK1OYnN0+TqqMfqxDqqSZlPwcSHLk5bxiFZkjqHo73TwZ9WmfiF8HrCJHFd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HgTT/mlk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TYb4EVw66eFgqXF6Tn680xcobIKnl8hXMw/P0sf476w=; b=HgTT/mlkcWu/bQBF4yf7rsUfoK
	IX+2MRAxuIKjglLa4YemYOixyNP0wDA+AuG5/tM1LkOOWNFJYB4AZYWDcG45px3K2SQe/8Ozo1/I7
	CXw1JXfrK/sbJZxVjXRYAmaGia4iuUXKzqWy2IhOsqEaLUIC2E50Q6q4aQAUMnQ8r/2o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tTqOn-001AB3-BZ; Fri, 03 Jan 2025 23:44:09 +0100
Date: Fri, 3 Jan 2025 23:44:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/6] net: pcs: mtk-lynxi: fill in PCS
 supported_interfaces
Message-ID: <86d264c5-73fb-45ee-ad11-4a2517a12cfa@lunn.ch>
References: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk>
 <E1tTffV-007RoP-8D@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tTffV-007RoP-8D@rmk-PC.armlinux.org.uk>

On Fri, Jan 03, 2025 at 11:16:41AM +0000, Russell King (Oracle) wrote:
> Fill in the new PCS supported_interfaces member with the interfaces
> that the Mediatek LynxI supports.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

