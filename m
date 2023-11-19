Return-Path: <netdev+bounces-48979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F70E7F0415
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 03:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B31C2085A
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 02:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62FBEDD;
	Sun, 19 Nov 2023 02:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofnqLoBb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3EEA0;
	Sun, 19 Nov 2023 02:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C083C433C8;
	Sun, 19 Nov 2023 02:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700361331;
	bh=Hu0l8gem3AFvKDDXWK35JduR9I2FeaVd7BP10Ig/cOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ofnqLoBbd1XOmSwpNOwjSUdtX2OGbuloSIwk7TTS9VWCTD/JT4odyAPjLinvkKPFg
	 TiCsPg3DdcolCTTb7/GpCGNU8qlotaIS8vI0l7YCLjRClrf+NUIbKkDezvmtLZo1mh
	 Ih4gxSTqR7xJcLz2fqcXtZ89+RVubPZaofO67BE30dcFS3hurZhDxD5sJY9Em5AO78
	 aQ2FNTnAPE1CvvOcKxMZTm9RJi8k75Gt+G9fhLMspCh7cMZ92dKMiaDHNEBGZI5oJj
	 OO+hoCIPPH+UBM+XjyAyHs4XaQQT91PG8js6daX4g6nH4IpyZZ2NAe5SRA9ebouygg
	 K+LJxanb48CTQ==
Date: Sat, 18 Nov 2023 18:35:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	""@codeaurora.org, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
	radu-nicolae.pirea@oss.nxp.com, j.vosburgh@gmail.com,
	andy@greyhouse.net, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, willemdebruijn.kernel@gmail.com,
	corbet@lwn.net, horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com, horms@kernel.org,
	vladimir.oltean@nxp.com, thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, maxime.chevallier@bootlin.com,
	jay.vosburgh@canonical.com
Subject: Re: [PATCH net-next v7 00/16] net: Make timestamping selectable
Message-ID: <20231118183529.6e67100c@kernel.org>
In-Reply-To: <170032022683.7145.6992267439143242783.git-patchwork-notify@kernel.org>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
	<170032022683.7145.6992267439143242783.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Nov 2023 15:10:26 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
> This series was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:

You need to run ./tools/net/ynl/ynl-regen.sh after touching specs.
The tree will now be dirty for anyone trying to do YNL work.
I'm dropping this series, sorry, please post a v8.

