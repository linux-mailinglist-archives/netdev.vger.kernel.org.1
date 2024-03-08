Return-Path: <netdev+bounces-78583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F65875D1D
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB84F1F21D2D
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 04:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14782C857;
	Fri,  8 Mar 2024 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGHrFJjO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FE72C6B6;
	Fri,  8 Mar 2024 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709871852; cv=none; b=A0e/fCevvI4nFHLag50kJGOuanZE5A6lsqlSC1HE2MM2Pm0NwS1JAXDcXxR4s1pze4Us7vpKvEuAHaEeDxQwe5uc12zvUKW2KLkvL9Z8BPwZ5nlWSYR6tmvAekUxUyfN81+TWhKOpC9OrerOjZ+FXvYerf1v6UiCj8g7WDE23XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709871852; c=relaxed/simple;
	bh=BGBLixuXPGuuA+n3MUis9zLgUWGUfR0TjhRnP9RUYyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAh0EhWGV4///tYqtYgdiMWi9FXmJ2rojgJs59Ctt6FauJ2zM+pSHgaJG9BU5iZrbgzylQCGls756/FbUDI8hkm+3BVDPVBsLZgEfsJPqHIzX4dYSKNVg4gyqowQcgY4qW3VhQ7HakXfErqa2kqMwbnnUvLPS2LPN4+Vjkghe9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGHrFJjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CA7C433C7;
	Fri,  8 Mar 2024 04:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709871852;
	bh=BGBLixuXPGuuA+n3MUis9zLgUWGUfR0TjhRnP9RUYyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FGHrFJjOdLNAVPlVV2y72PZHt3Zdq4NO6a+2+jAPscXe8XtPmN7Tw5MpgAwOpfnIs
	 I0WUyIL5s1vqJaI0IX0Ki8W6r8zuEby3COUU1JpXiKWJaF95D/irATYgjmIIuebnUk
	 RdorUU4amsEI8+zINNVQZ0VogYecAyLAkxiT2NSMv+EK97eBBx7qk4plSZotGlcRuE
	 QMjS28xC/h7VJcLhked9kTMwFyrqXfWM/AC/oCbULkfXCD/KXxL370woS29Y5YOYf2
	 w0HOiVvaibuTBsPk+i/iAwk5Cak0nZIRub8G4aTliPs++t3bSwIHhT50zGU6OgzYpl
	 i9TuBjrxV3FlQ==
Date: Thu, 7 Mar 2024 20:24:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
 <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss
 <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v1 1/1] net: dsa: microchip: make sure drive
 strength configuration is not lost by soft reset
Message-ID: <20240307202410.65595460@kernel.org>
In-Reply-To: <20240304135612.814404-1-o.rempel@pengutronix.de>
References: <20240304135612.814404-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 14:56:12 +0100 Oleksij Rempel wrote:
> This driver has two separate reset sequence in different places:
> - gpio/HW reset on start of ksz_switch_register()
> - SW reset on start of ksz_setup()
> 
> The second one will overwrite drive strength configuration made in the
> ksz_switch_register().
> 
> To fix it, move ksz_parse_drive_strength() from ksz_switch_register() to
> ksz_setup().
> 
> Fixes: d67d7247f641 ("net: dsa: microchip: Add drive strength configuration")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks!

