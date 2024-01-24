Return-Path: <netdev+bounces-65616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5183B22C
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 20:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956CA1C23715
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7D134737;
	Wed, 24 Jan 2024 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqB7/WBx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264781339AA
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123942; cv=none; b=lp7m/ml/R2NsGppYhaabSpCRJTQGmNCTqFUKKANQxcc9GumgflNxt/SeZdjmGCjDPscC5OwDXNptI2iNrC+FWby+c5d5or92SeKXB82aSqFjJI9iws9A6282nZ/ljgs0YvfinjfpPxevD1T2CJsWveKNSJshF978oq3ADcZfxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123942; c=relaxed/simple;
	bh=TLpqMLoXrtLpzL+3bPPjQAYgpv6avatM7Q0vtuX4YiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjgKMLfrAcpf2L5oAJVNqNZM13RTWP47WQ9KXodAYymXbp7nI7g1LgsY+hB3iln13jF8B+7lWK8bPdqGaVwkJPveF1Qf+Vl2AeoLmrsPLphMBSa14i5gPkKzbPdRNyM1NI+v+i0PaPbWPRKVC/1e/UUwMSwveIB2F1C+C7Cs8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqB7/WBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5E8C433C7;
	Wed, 24 Jan 2024 19:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706123941;
	bh=TLpqMLoXrtLpzL+3bPPjQAYgpv6avatM7Q0vtuX4YiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CqB7/WBx4zjxQgkfZlUimPrIANXiphh3mh6Z+7Z7b6aBbBQzKU6JMzX2vdlhDQ8Qg
	 4sZhkIyupaqsO6Cyqz9RFU9Z5tKoF9WovALZ2E/jNlhZHYJTwnNDqRCAevxPMJWDaK
	 6/St0ZlmMG+Oz8bJ0DOk+MWW8vfbGgdmvHY17m6D4zIH+Tk0hiWTTx/U+5PJtJV/tf
	 F5mVEmjP7YeNyBQbNvE5LBeb7GwRt91pr+RSbwnn33c9eBxkl3Cwln6Ju2Gl/S8u3U
	 bkwFls9CiCjscKwP/+zr2Zs4AVJBrNDSWEJe2PJ2rleQqsuVZmRYZDsND+fOc9iN0A
	 EnojJ7Qil4XtQ==
Date: Wed, 24 Jan 2024 11:19:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 03/11] net: dsa: realtek: convert variants
 into real drivers
Message-ID: <20240124111900.2c0999a1@kernel.org>
In-Reply-To: <20240123215606.26716-4-luizluca@gmail.com>
References: <20240123215606.26716-1-luizluca@gmail.com>
	<20240123215606.26716-4-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 18:55:55 -0300 Luiz Angelo Daros de Luca wrote:
> +/**
> + * realtek_mdio_remove() - Remove the driver of an MDIO-connected switch
> + * @pdev: platform_device to probe on.
> + *
> + * This function should be used as the .remove_new in an mdio_driver. First
> + * it unregisters the DSA switch and cleans internal data. If a method is
> + * provided, the hard reset is asserted to avoid traffic leakage.
> + *
> + * Context: Any context.
> + * Return: Nothing.
> + *
> + */
> +void realtek_mdio_remove(struct mdio_device *mdiodev)

kerne-doc says:

drivers/net/dsa/realtek/realtek-mdio.c:159: warning: Function parameter or struct member 'mdiodev' not described in 'realtek_mdio_probe'
drivers/net/dsa/realtek/realtek-mdio.c:159: warning: Excess function parameter 'pdev' description in 'realtek_mdio_probe'
drivers/net/dsa/realtek/realtek-mdio.c:268: warning: Function parameter or struct member 'mdiodev' not described in 'realtek_mdio_remove'
drivers/net/dsa/realtek/realtek-mdio.c:268: warning: Excess function parameter 'pdev' description in 'realtek_mdio_remove'
drivers/net/dsa/realtek/realtek-mdio.c:294: warning: Function parameter or struct member 'mdiodev' not described in 'realtek_mdio_shutdown'
drivers/net/dsa/realtek/realtek-mdio.c:294: warning: Excess function parameter 'pdev' description in 'realtek_mdio_shutdown'
-- 
pw-bot: cr

