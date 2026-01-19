Return-Path: <netdev+bounces-251025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 943F9D3A2F3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA77A3006AAB
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6116A33E34D;
	Mon, 19 Jan 2026 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BPkFrCJI"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46224355039
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814892; cv=none; b=D/X91xr0eetVLHTEcnLztdsFYP8SLFkJqXkHj5W6QftISY0T6611PVDLbuEPRfyPmr7B7zKgMQFLbNrFmhwRN14ZrbOpuv2kvtw6POnhWEYrk0rchF4A5k3FxA2cb3LA16rOKvGskysToIvLA7aLUNFs1O60ipAcPGU0eDBWVe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814892; c=relaxed/simple;
	bh=/rbsgtwh0IFmobpYZIg0T/1qRai3iU7Ujtclbpd0ZlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlu5JsxPhBJBwd2OqXGz/zRJkjzJCvlleY6Dl6kBI6SwyCXp4OZTwNlkrLhrCit3zsGPFTibWms92zOFiakfqONCG5pjEDARrR9MXdV36Jcpow09GRSaVjWnhw/t/Cv2FTtpJGqmt6doqYEQe3aH99HOB7sFFC6uTE+X2xtdR7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BPkFrCJI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1A0A61A291C;
	Mon, 19 Jan 2026 09:27:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC34660731;
	Mon, 19 Jan 2026 09:27:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9701710B69822;
	Mon, 19 Jan 2026 10:27:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768814878; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QO0a3o9xTofyckkMjL1Y/gdZw32YkbHo0CE1eCRMHCI=;
	b=BPkFrCJIXEObVHgwmOFiAVu4V3QldAy8U2FZjIRU3PYtj8BQ+3uH9pxG/cucWuIpmc57nt
	1Wx2nj4+UEMv/TClfb03AT1v/EY6cg8tWFLd/6zt1zJDuTkmWHX5fz70Usmw6weHbx9pXo
	sdHqgk95XC9wxcVLbh0gS85HWqYMfr4cslsaOdmjvXFI9Jjt0ciRdXoz9S7E/sezOIEPZU
	bvCxPZ/n7JgCAFTvCNY8NeBjZCQErTxFqnrPAZHeMG4NGFYKsqTap+asaz2FzjOw/28HdU
	QFScPtUlRYzXA+ffyNfk9fm5Gi9qfQndCTw7B26fsxD2p8fHk2P6PT0BXHoLBg==
Message-ID: <b8cafe50-c87b-4bd4-a47e-d11c11c16f7c@bootlin.com>
Date: Mon, 19 Jan 2026 10:27:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 1/2] net: phy: marvell: 88e1111: define
 gigabit features
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
 <20260101-cisco-1g-sfp-phy-features-v2-1-47781d9e7747@solid-run.com>
 <aVe-SlqC0DfGS6O5@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aVe-SlqC0DfGS6O5@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell, Josua,

On 02/01/2026 13:47, Russell King (Oracle) wrote:

> If the operational mode of the PHY is reconfigured at runtime, then I
> think it would be reasonable to re-read the supported linkmodes.
> However, I think this will cause issues for phylink, as currently it
> wants to know the link modes that are supported so it can choose an
> appropriate interface mode.

Russell, I agree that your patches for phydev->supported_interfaces
are required, but I also think we need another piece of the puzzle to
solve Josua's issue.

From what I get, it's impossible from the PHY driver's perspective only,
to know which configuration the PHY is in, i.e. is it in :

 1000X to 1000T
 SGMII to 1000T
 SGMII to something else ?

This is one of the issues I was facing with the SGMII to 100FX adapters.

Selecting the right phy_interface, is one thing, but it doesn't address
the fact that whe don't know which linkmodes to put in phydev->supported.

The approach I took to address that is in patch 3 of this series [1] :

 - The SFP's eeprom should ideally store information about the MDI of the
  module, is it outputing fiber at 1G, at 100M, is it BaseT, etc.

 - in sfp_sm_probe_phy(), we have the sfp_module_caps fully parsed, with
   fixups and quirks applied, so what I do is store a pointer to those in
   struct phy_device

 - The PHY driver can then use that in its .get_features() to report the
   proper linkmodes.

Of course, this may not be the right approach. What do we trust more, the SFP
eeprom, or the PHY's reported linkmodes through features discovery ?

IMO relying on the SFP subsystem to build a proper list of linkmodes we can
achieve on the module is a bit better, as we have the opportunity to apply
fixups and quirks.

Maxime

[1] : https://lore.kernel.org/all/20260114225731.811993-1-maxime.chevallier@bootlin.com/#t

