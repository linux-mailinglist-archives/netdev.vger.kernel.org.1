Return-Path: <netdev+bounces-197791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F5AD9E53
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D217AB237
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A802D9EC1;
	Sat, 14 Jun 2025 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiudJ1/U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F1A192B81;
	Sat, 14 Jun 2025 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749918861; cv=none; b=ArjM1sNmMncRhsBqAilkqkjkFKAP8Lhi1FDVceEZRHdZuO4lXZ2fDaSASzmNQ8zix/k8F2nNsJWoh0y4KOFDU4EUkfDcfT2HnTFU5qNWfLSjeH3VoDy5k3U5teeTBN+tnYuMTJL0nZkq1MjfZGUui3n4B0FHl0EYT+5gxEO28x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749918861; c=relaxed/simple;
	bh=6DHh6qMvxKyEHqO6TUPLFEX3fT9/Ww7Zix2JLZu2+zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYoZM5KfWG0xA6MaSQuPxRAGdn8U7nF2rEDaKJUOZoaOt+c/cy2D4paZ5v3FiT3cjYg1ZBl4nCeenr3GgfojYQ/WMR/a2V0Uvqhpjan7AsYopcd3aN6tp/cYM/huO/ebv15Io1JGkeoY9AYo5HxwFd6m7LzJNzuEnn4JQASk4QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiudJ1/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60D9C4CEEB;
	Sat, 14 Jun 2025 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749918861;
	bh=6DHh6qMvxKyEHqO6TUPLFEX3fT9/Ww7Zix2JLZu2+zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiudJ1/UIPb/qZf3XFHvsUzlYqe22b0WpmGze8OxroK/l0VvhVx2PWU3fYxNm+Pyg
	 aVq4y2MqJVfaU5Re7+JiVycEEpumJgxU0x6j75lJIfsXMaegqv6EwFBt+U8wbP2p8w
	 AZ+0jWQxeyORVD4piEMi9rJvimJnV5pKlVhV0mZtx6nTkKE0g4ZSGffdyRZhPV0quV
	 sbaXpXEXhW+EhJtNAZkg5bVVoXdla2UahdHv87wJRQXrFSi6zE5d+5fFPzB4CEoTz9
	 A+f2fQmaW/7XieIf71Kb8mgEuwRbtgRcKUxS145xGnfA1G/kWHUXz3fyjk5kPm/Nph
	 F4HbQVqYVXj3Q==
Date: Sat, 14 Jun 2025 17:34:16 +0100
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Meghana Malladi <m-malladi@ti.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Read firmware-names
 from device tree
Message-ID: <20250614163416.GT414686@horms.kernel.org>
References: <20250613064547.44394-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613064547.44394-1-danishanwar@ti.com>

On Fri, Jun 13, 2025 at 12:15:47PM +0530, MD Danish Anwar wrote:
> Refactor the way firmware names are handled for the ICSSG PRUETH driver.
> Instead of using hardcoded firmware name arrays for different modes (EMAC,
> SWITCH, HSR), the driver now reads the firmware names from the device tree
> property "firmware-name". Only the EMAC firmware names are specified in the
> device tree property. The firmware names for all other supported modes are
> generated dynamically based on the EMAC firmware names by replacing
> substrings (e.g., "eth" with "sw" or "hsr") as appropriate.
> 
> Example: Below are the firmwares used currently for PRU0 core
> 
> EMAC: ti-pruss/am65x-sr2-pru0-prueth-fw.elf
> SW  : ti-pruss/am65x-sr2-pru0-prusw-fw.elf
> HSR : ti-pruss/am65x-sr2-pru0-pruhsr-fw.elf
> 
> All three firmware names are same except for the operating mode.
> 
> In general for PRU0 core, firmware name is,
> 
>         ti-pruss/am65x-sr2-pru0-pru<mode>-fw.elf
> 
> Since the EMAC firmware names are defined in DT, driver will read those
> directly and for other modes swap the mode name. i.e. eth -> sw or
> eth -> hsr.
> 
> This preserves backwards compatibility as ICSSG driver is supported only
> by AM65x and AM64x. Both of these have "firmware-name" property
> populated in their device tree.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> v1 - v2: Changed commit message to include an example as suggested by 
>          Jakub Kicinski <kuba@kernel.org>
> 
> v1: https://lore.kernel.org/all/20250610052501.3444441-1-danishanwar@ti.com/

I agree with Jakub's comment in his review of v1 that the backwards
compatibility aspects seem fine. And, overall, the patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


