Return-Path: <netdev+bounces-103240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C099073C6
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EED2839B0
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316E143895;
	Thu, 13 Jun 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WnZ97HAT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5451E49B;
	Thu, 13 Jun 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285646; cv=none; b=pJB2U3Tz3zVbAsch/6wVGyXM0RziYLiufkeaJkUuF3teamwf5Nw9vc2gRix9LRAcXTz3gRvOmNl8Uk4ZE8l3J8Qvi0umza9jO+0p7n3SKWIhWRMRWsBqhtImnqGwczX86FcJ/iGGJ/FANqQSZbkiDyCr2rSIJ1ZwVL146HeJtv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285646; c=relaxed/simple;
	bh=hSnxi1yCAEFbEdOATXUDF4lzPF7LOP3u53tk5+lHDx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISyYGI0wLklVHCqkgYSEOYwlrLH2rOmGXZgqlfAKHzDd6yPDMK2LJt4spoz23SbnA+hokIh2IooSHGNchjW8H7sTje3X0wp4YW+bRL/KBlRSoPP8ySwSjYItMCKVWn60nw6eHQtzEJghLveGupx8PV1RTJvDSk/RakNwi6GhZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WnZ97HAT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S1RuFp0vlLAyeY1qWapt9cro6Y3Ttv10wLLV6eWht0Y=; b=WnZ97HATOH2e8wV28w4HHoeKFS
	2uQgBkOkxlWJMQuvHacBpyXvMzqzqfsI4mIBYmLsPROFEDXxgeBAVBwYVOe/o0eRYHIQ+xO16yvrU
	Fn28I5tmt9j346HZqiasu5F1ppBG7jZSpjTtlI61kQa5f736Ix241HkfmAaf2xRqn+ZY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sHkaM-00HZFj-2B; Thu, 13 Jun 2024 15:33:50 +0200
Date: Thu, 13 Jun 2024 15:33:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v6 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <b68146c6-e59d-4be8-9b57-c2747c175126@lunn.ch>
References: <Zl3ELbG8c8y0/4DN@shell.armlinux.org.uk>
 <Zl3Fwoiv1bJlGaQZ@makrotopia.org>
 <Zl3IGN5ZHCQfQfmt@shell.armlinux.org.uk>
 <Zl3Yo3dwQlXEfP3i@makrotopia.org>
 <Zl3lkIDqnt4JD//u@shell.armlinux.org.uk>
 <Zl32waW34yTiuF9u@makrotopia.org>
 <Zl4LvKlhty/9o38y@shell.armlinux.org.uk>
 <864a09b213169bc20f33af2f35239c6154ca81e3.camel@mediatek.com>
 <Zl8bjNzdB7g1fRyn@makrotopia.org>
 <a6c79128dca5b99951e95527bd2b51a4ae7b42fd.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c79128dca5b99951e95527bd2b51a4ae7b42fd.camel@mediatek.com>

> Since I found out that there's phy-mode="gmii" in mt7981-rfb.dts on
> openWRT, I thought maybe we need gmii&internal for mt7981's built-in
> GbE and xgmii&internal for mt7988's built-in 2.5GbE.

Just because openwrt is using it, does not mean it is correct. We do
not break in tree DT files, but out of tree DT can be ignored.
Hopefully if mt7981-rfb.dts is ever submitted for mainline, the
problem will be fixed. And when OpenWRT updates to a newer kernel they
are likely to fix it.

    Andrew

