Return-Path: <netdev+bounces-128446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F469798AE
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 22:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E7E1C2195E
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0A0282E1;
	Sun, 15 Sep 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xUr1GMiR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73B8C13
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726431681; cv=none; b=Hb6U9VFjfgeIQxqcZazvE5s0HztqY2rVGtdNzlWxoZcWZv0NkRTUsOzwhz28ToSnEaywwWG6jZAcSLjdBJzyhaiaJLcTmEB98pXTa8elwYH4xe66FJlOTqgVS3kcY22pWuL1JbPD2wS2W0X4KOCEkt8BU9FpG1rvV6dzrWpuUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726431681; c=relaxed/simple;
	bh=+C+o8ZGJJPdNwRki9BRhn9OxO++HMDrJ7ojR1+Im9po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rusQTQz2ce/TpZ7SeR/Uhsg48OkVEdOkFgPW3ArMf5HCLeqxcNpG7o8dUA1gkh0MnDp4AFVVhW0cPMnBY4L75YCAiqHT8E2CpMNQh9UPiViFtEv8V134FQiW/woiVGRnOqfHOQrFxXmEAAtE9ta+CQOgUif6BXDeTQZ70wsso8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xUr1GMiR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cD4O+Lna8AMlg38ajHHhpcIfko03ahh769oEV8PjDTo=; b=xUr1GMiRt+owkngGNuKCCO1z1N
	zPGq/NJI9cXA6UcdA7WWmElYM3c0yY+ReHzM4MCZ8eYsQGrBp+tsHdmC+sqo+N+9ZlXIxCJ75VQE9
	iO01RkfsGiO8arz6gk4vaOwQvRpIHiWOHotMV+Fc8PUnBpRUjTo9iJbGKCeTJisVocd4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1spvkC-007WGK-Ad; Sun, 15 Sep 2024 22:21:16 +0200
Date: Sun, 15 Sep 2024 22:21:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 0/7] net: tn40xx: add support for AQR105
 based cards
Message-ID: <c3bd51cc-fc8f-46b5-bfc3-ccb0fa1386e9@lunn.ch>
References: <trinity-602c050f-bc76-4557-9824-252b0de48659-1726429697171@3c-app-gmx-bap07>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-602c050f-bc76-4557-9824-252b0de48659-1726429697171@3c-app-gmx-bap07>

On Sun, Sep 15, 2024 at 09:48:17PM +0200, Hans-Frieder Vogt wrote:
> This patch series adds support to the Tehuti tn40xx driver for TN9510 cards
> which combine a TN4010 MAC with an Aquantia AQR105.
> It is an update of the patch series "net: tn40xx: add support for AQR105 based cards",
> https://lore.kernel.org/netdev/trinity-33332a4a-1c44-46b7-8526-b53b1a94ffc2-1726082106356@3c-app-gmx-bs04/
> addressing review comments and generally cleaning up the series.

Hi Hans-Frieder

A few process issues first, before i get to the patches themselves.

We are currently in the merged window, so net-next is closed.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You can send patches, but please mark them as RFC.

You have one patch with the wrong subject, not net-next, but net-dev.

Your emails are not threaded together.

These last two point suggest you are not using the tools correctly.
You should have all the code on one branch, then use

git format-patch --cover-letter --subject-prefix="RFC PATCH v2 net-next" HEAD~42

and then use git send-email to actually send the patches. That will
cause them to be threaded together.

Alternatively look at b4 prep:

https://b4.docs.kernel.org/en/latest/contributor/prep.html

It handles a lot of the details for you.

	Andrew

