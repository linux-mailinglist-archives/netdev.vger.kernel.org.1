Return-Path: <netdev+bounces-99408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4738D4CA7
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65AD284B7B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A517D8B0;
	Thu, 30 May 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YUXu8I0Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22917D8AE
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075603; cv=none; b=AvvPIDBjsOiO/ftLD5t5Buy4BBePUlR0LieiieWMcw5YuP31XVz/PKpnfr3aj/+mq3UPWmjh4TnWuvUocVh6VsEj6JvHjazrJ80wraaTW02+JMafd7PG4F2dTOuyIdsq2qyKIGQQPDTFakyEd8m0ZCSaAq9sdJunonOOPPFY4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075603; c=relaxed/simple;
	bh=9lOhzS4Y8/sxn2kSGNAmZKwIOUXEK/+n1oVaKZDK73E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atL7IRBw5lEIUuet9+IdPYidEB29qgikZFSi2V5MQe7SP3zVOukuCt44LbKMYQ4zm4xnBpI/6vMo49hhDO9XopjYCuFpclwVToJO/0OgipzCfMETr7djuPMVBT8F07fS/bVBkYCicupqD1Jma4+v++SYE1tExMIl3QtMh6lWz1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YUXu8I0Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=77DhvLrweiSZ6t2PamyKbKr3Kg/NHUbwQjFIAIZJIVA=; b=YUXu8I0QL0Nav23+J0VpkVUaAV
	xne7bxwbcUR1IZZ0ZS2VfTrY8tcGwk0CCRW5uznpvMzsHZSuURxpNAO52ucJmIrdZFZTkssav+9+t
	3SAlnLw854/iqMIEw0KHiiwi5XxJH3CdmwI8UIuA7nSuso7ui6vY79FhWIUCF4sPjrvQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sCfnj-00GLmf-Tf; Thu, 30 May 2024 15:26:39 +0200
Date: Thu, 30 May 2024 15:26:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	embedded-discuss@lists.savoirfairelinux.net
Subject: Re: [PATCH v3 1/5] net: phy: micrel: add Microchip KSZ 9897 Switch
 PHY support
Message-ID: <7693b5bc-f710-47cf-8331-3438fcf026f6@lunn.ch>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240530102436.226189-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530102436.226189-2-enguerrand.de-ribaucourt@savoirfairelinux.com>

On Thu, May 30, 2024 at 10:24:32AM +0000, Enguerrand de Ribaucourt wrote:
> There is a DSA driver for microchip,ksz9897 which can be controlled
> through SPI or I2C. This patch adds support for it's CPU ports PHYs to
> also allow network access to the switch's CPU port.
> 
> The CPU ports PHYs of the KSZ9897 are not documented in the datasheet.
> They weirdly use the same PHY ID as the KSZ8081, which is a different
> PHY and that driver isn't compatible with KSZ9897. Before this patch,
> the KSZ8081 driver was used for the CPU ports of the KSZ9897 but the
> link would never come up.
> 
> A new driver for the KSZ9897 is added, based on the compatible KSZ87XX.
> I could not test if Gigabit Ethernet works, but the link comes up and
> can successfully allow packets to be sent and received with DSA tags.
> 
> To resolve the KSZ8081/KSZ9897 phy_id conflicts, I could not find any
> stable register to distinguish them. The crude solution is to check if a
> KSZ9897 DSA switch is present in the devicetree. A discussion to find
> better alternatives had been opened with the Microchip team, with no
> response yet.

A better solution it to use:

      - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
        description:
          If the PHY reports an incorrect ID (or none at all) then the
          compatible list may contain an entry with the correct PHY ID
          in the above form.

If there is no official ID for this PHY, you can ask Microchip to
allocate one. Or just pick the highest free ID in Microchips range.

	Andrew

