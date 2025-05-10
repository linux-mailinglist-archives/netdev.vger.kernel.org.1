Return-Path: <netdev+bounces-189424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0606EAB2096
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 02:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5703C3BCAB6
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 00:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA9A213224;
	Sat, 10 May 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHoyM5Fl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D4212B2F;
	Sat, 10 May 2025 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746837696; cv=none; b=sBuBcETGCJidko4XGUxE7t8BG2nVIQX5/pXR7VwNl9OHvGRNEEFZ4KoQ0bEpLRf9/7gHJvzV6ErDhr3PFPE9xIOebs1IRAGcSuTqDCcqmfuzp6RAFy2X82RkPOGdx8dsFmTCdHED/hfjVoHTAkMPqMgmnbMOspd1sqixdG6ihbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746837696; c=relaxed/simple;
	bh=UieL6rCfYVSI5KcmuBXjatBPrhUko46Fc543UCh7Pac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pReZc45OAE7Oi/t6kJ0Oog0obg0buv7QRbuTGH+PFNTH5DGNQX+ffaZfxrBslBlL/QKd54cXcHlgTCAiqDk+JH6W7LWcgl7swk6K43kGHkUAqSVWzQcqH7qi7pJ6DOK/tVA9/llMu7UdruKHqwzeeqK677UfQFCaGtaWhRbPDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHoyM5Fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080B7C4CEE4;
	Sat, 10 May 2025 00:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746837695;
	bh=UieL6rCfYVSI5KcmuBXjatBPrhUko46Fc543UCh7Pac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UHoyM5FlIuPjdj8HCg1uhhMK9+0T0tT1Ex7P+tL68GCYTNxYl6QzBRYP8mYWRf17/
	 INEreAUOIz2F1nMiI/LMz+ThzHzPHDMMaiGnZpwbTLNX8rj4fwrJOrACMa1hgKhYWR
	 vo6T0CsIupeQh09hV0w0EsqPk0sfDUrAVwW7XgivGLcVMBqxZBGvfVlXLobOBAhNhp
	 rPNfNNSVv0MiTz/ncIY2tltBgLCl4aUbEfA4rZTaR1MSUF7EhSSj5JvSnCTj5NUkIC
	 DEW7/deRoKcNTz5nImjWmfIYM6HZYRQ0pWPvB7CZRRGueQRnY5NXSTCeoIkk9NvfsY
	 PGo856gwtzaXg==
Date: Fri, 9 May 2025 17:41:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Tristram.Ha@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Woojung Huh <woojung.huh@microchip.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean <olteanv@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <20250509174134.03c224ea@kernel.org>
In-Reply-To: <20250507000911.14825-1-Tristram.Ha@microchip.com>
References: <20250507000911.14825-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 May 2025 17:09:11 -0700 Tristram.Ha@microchip.com wrote:
>  drivers/net/dsa/microchip/Kconfig      |   1 +
>  drivers/net/dsa/microchip/ksz9477.c    | 191 ++++++++++++++++++++++++-
>  drivers/net/dsa/microchip/ksz9477.h    |   4 +-
>  drivers/net/dsa/microchip/ksz_common.c |  36 ++++-
>  drivers/net/dsa/microchip/ksz_common.h |  23 ++-

No longer applies cleanly, please rebase:

Applying: net: dsa: microchip: Add SGMII port support to KSZ9477 switch
Using index info to reconstruct a base tree...
M	drivers/net/dsa/microchip/ksz_common.h
Falling back to patching base and 3-way merge...
-- 
pw-bot: cr

