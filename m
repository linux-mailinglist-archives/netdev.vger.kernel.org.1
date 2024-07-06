Return-Path: <netdev+bounces-109594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B14F928FF7
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 03:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64351C218B8
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 01:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB197483;
	Sat,  6 Jul 2024 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnXf5UiP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45C33F9;
	Sat,  6 Jul 2024 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720230078; cv=none; b=mcoL8SEx5u1C2Q6jhnAJm4o8x5bfHQZ0H8l7S+7eKLdMqoz3XfcG3DnGJjEQswsb8frNrOuZSSpQEX6ZJXsDzYhwiSguBfAjGTfQM5bzUJ95AWzjJo9XpaEUW0kdwrbgNDDnyCEMP43BRYJZtvgTZCLpRx1815NtvccDwT5GfGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720230078; c=relaxed/simple;
	bh=CB5xnPiURRUfsrDWz5BC2R5ksUafNpcL4HmVkzoybUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOxVCML6OwLm3uO688be1x3QDCDMMtj5mdg2DIRI+O9WhWrcys1TyxRe9VaN1gYWnZuVop7usslf8D5vsGqdrs4DpkZ2RJgXYw83y86I41EwrE4XzRmH1HWRAiOh3c0nSYrofXxhH/4Tzeszp6akfjRmeDp7/ZpoduRmZkkKytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnXf5UiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC58FC116B1;
	Sat,  6 Jul 2024 01:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720230077;
	bh=CB5xnPiURRUfsrDWz5BC2R5ksUafNpcL4HmVkzoybUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XnXf5UiPoqiR4BJOuw3YdC/bBs+9EFTP8hsTDhxzz4NbM/TYVj8vx7TCQT++maESX
	 yVZk8nqR93sFBqZlT6cfBRKjaOdi8uo855I/i2RUcUU0MwwQ7zj5dIqVwteg5/tUIC
	 emxf25IscVOaDxK0YgWdCBTjcb/E1hn2TgwvXlqkM7i1RXBvt2OdgR5vZOkWQ4hvfD
	 rUIk0hEd6G4DbnW118Oeb1bypTqVq1VlBNn/kXFgrN6i/+F4M5oJrRUxtG5pCawX6o
	 CZn/9JPGwzBZuRepwu0Icqp75V65Oci+oODzCIyXLIz0hIB8wkGNMlz+Yok775lDIq
	 6edsyD57ZY0Aw==
Date: Fri, 5 Jul 2024 18:41:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/7] net: ethtool: Add new power limit get
 and set features
Message-ID: <20240705184116.13d8235a@kernel.org>
In-Reply-To: <20240704-feature_poe_power_cap-v6-5-320003204264@bootlin.com>
References: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
	<20240704-feature_poe_power_cap-v6-5-320003204264@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Jul 2024 10:12:00 +0200 Kory Maincent wrote:
> +	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] ||
> +	    tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]) {
> +		struct pse_control_config config = {};
> +
> +		if (pse_has_podl(phydev->psec))
> +			config.podl_admin_control = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
> +		if (pse_has_c33(phydev->psec))
> +			config.c33_admin_control = nla_get_u32(tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]);

This smells of null-deref if user only passes one of the attributes.
But the fix should probably be in ethnl_set_pse_validate() so it won't
conflict (I'm speculating that it will need to go to net).

