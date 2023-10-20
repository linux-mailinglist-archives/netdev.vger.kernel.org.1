Return-Path: <netdev+bounces-43156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FD87D19B8
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 01:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8024B1C20FE8
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB4E36AF3;
	Fri, 20 Oct 2023 23:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QED9SpgO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1B3551B
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 23:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D27C433C8;
	Fri, 20 Oct 2023 23:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697846123;
	bh=RdH0R62ubdsvm6yoL5pHnjKkl2MqWF7NGcqJh85kZO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QED9SpgO5zyForucyabZCmm3rGMTFcpq43GNFNr7Pfr/TLd1C3c4j3oQgEqjYPrGh
	 JNaaLYIXFIuvZJdemRvc4+qcNEIpo+GYxFbTaJlSdQHPmJEZe3+rNDSwI2k3cp5tHg
	 De0RlWbpRf3bj3FWwKY7sofraW8b/mKPfq0W2UoVuuQ643RdnWdL2iO9sDDbJtm0Ud
	 TIFAaMs+LwkoECoi8gk3YUfaRggMoAlSUVwzoX7O22UKvaA5Ay1ccI9659zBNopCFg
	 uHUBQxftOhAo2qrEiTcAjPJit32RMBIgStna11dIV53bGV7fW+wheusJ9uvwvE6bCE
	 zzanBDJnDMkbQ==
Date: Fri, 20 Oct 2023 16:55:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org, Alexander Stein
 <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH net-next v3 0/3] fix forced link mode for KSZ886X
 switches
Message-ID: <20231020165522.78aec32c@kernel.org>
In-Reply-To: <20231019111459.1000218-1-o.rempel@pengutronix.de>
References: <20231019111459.1000218-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 13:14:57 +0200 Oleksij Rempel wrote:
> Oleksij Rempel (2):
>   net: dsa: microchip: ksz8: Enable MIIM PHY Control reg access
>   net: phy: micrel: Fix forced link mode for KSZ886X switches

Looks applied, thanks!

