Return-Path: <netdev+bounces-220080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AEBB44611
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A96D3B785F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA4D248F59;
	Thu,  4 Sep 2025 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qiump116"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F56237707
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012562; cv=none; b=ntotr/+S5Wirk/shhkFkmSSmYypGjt2wlUWs9TCdICPaO0x0wBUXHtTDX0B3zb6867MyhbYwWjLRdhq+mxTCFmW9xKcZvrw0i1/xoGzh0Icu3gCJj5jyzfjNTP9xukgucQS1Opw2+gdRjVwOo/LVO9lQXZ6AQFv/f6syCGCl/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012562; c=relaxed/simple;
	bh=X98SVVqh4HXLG0UcboSylB0zWFMkOWmmNBg+xwi1XT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClS8QU2pKeyPsEGoCAYGug2RAMHRbI4sBYY0F8P61KCyF/zVzGA3SQ1otz0U96Hvkf0rOsxV3zBsQQfb5ruy63b9bxIO7Qihaizh8akt6yZzisJw5vLAuh88DvM/g1j3VNBiZTe29whRMwOozvVcp05RVNwr4WoiJlY3cdoHXYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qiump116; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7c9LF8t05wCPldyGpjFav7F6YUnp2uaWeZeIYO17YxQ=; b=Qiump116rQI8IMkUSa7QZlAi7A
	cplaNriHRhCc74m3WtjPza3rxaDBckbUs/+OT7XBH8z8pAFmwA/iQ91ktuM1F5h+SHX/V8JbSQrD5
	KHgKaT+ULRzJEmRIP0O7ozT53XwkbVOV2/8Py3OB1Zh+0wnmdNqm8qGquqprlD/Od87g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuFE8-007G8T-AD; Thu, 04 Sep 2025 21:02:32 +0200
Date: Thu, 4 Sep 2025 21:02:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 07/11] net: stmmac: mdio: improve mdio
 register field definitions
Message-ID: <7b9f2bd1-76c0-4965-8148-c6c6cc282126@lunn.ch>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
 <E1uu8oM-00000001vp4-3DC5@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uu8oM-00000001vp4-3DC5@rmk-PC.armlinux.org.uk>

On Thu, Sep 04, 2025 at 01:11:30PM +0100, Russell King (Oracle) wrote:
> Include the register name in the definitions, and use a name which
> more closely resembles that used in documentation, while still being
> descriptive.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

