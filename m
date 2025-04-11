Return-Path: <netdev+bounces-181682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B8A8616A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5DFB1BA5BB3
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCE220C02A;
	Fri, 11 Apr 2025 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8+ON3jD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C020AF7B;
	Fri, 11 Apr 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384209; cv=none; b=BnB+Cv1a/Mm/serHFYoOYDTF6p/gaNO9E+cdTV85v84jPCsFsFl6K+bOg0f3tTwqeuqXDKZxZ3Abh+6QGvmpzArE/29OIGCfmupESLa6ZQRTbgLdqzQQo5ec8+qgzBxma6iQfYfL0a4W592BakLAG6UGOMRj5scAMWaTaFprb9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384209; c=relaxed/simple;
	bh=nV7QUsY7pocrTLl7+krZ9Vjz4uByyHrtuPWZ3jHggtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxdv4YpWWpGnuuZunr1hqk8+jh4KsD4bQh8S9W5XPNfy7Gq8KgkKn4GzJQfRBOKbUbqtCOSXqwZmG0l74a0KXoKqbKAEKfpUbGBF87db2Lf8sCnQwF++TXWcJO0YOm0zuXKScUSApokaKBHGjMHjyB1PsA/jpYKt7awYF7zMfoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8+ON3jD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AB4C4CEE2;
	Fri, 11 Apr 2025 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744384208;
	bh=nV7QUsY7pocrTLl7+krZ9Vjz4uByyHrtuPWZ3jHggtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8+ON3jDxuMhAktXI7jzW1oXlfLzIB/wn/r3nc+Dk4EvAvRM4zw0hS5E8lQgzb5sO
	 dhhX27snOzoNVidZH4vEhTERLUI8mcDyGIswXt3IY5A4Zw1paxXHqD4ZKwwSnTM9c4
	 pnn/+PZ74C+6gb9TOSa17oOdk+fH6s7xH11L1YSKqr5rdjIF0yLwVEFc62ezEK0Aaz
	 Gi1cff+pQIe0pNxrSCsMlycjFDmTkxKYfIMd2VQH5BJcNZH4AnnHsPKG07vnGDRRgg
	 KMlyNp9vrDGh9IKpm+XYkSpLQu2lTXW6xEBwT809wncke0+Mm10Xwut9NJbuDlVCGj
	 cljYUFggYDwSA==
Date: Fri, 11 Apr 2025 10:10:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, upstream@airoha.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [net-next PATCH v14 05/16] dt-bindings: mfd: Document support
 for Airoha AN8855 Switch SoC
Message-ID: <174438420580.3258271.14505351039830543579.robh@kernel.org>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
 <20250408095139.51659-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408095139.51659-6-ansuelsmth@gmail.com>


On Tue, 08 Apr 2025 11:51:12 +0200, Christian Marangi wrote:
> Document support for Airoha AN8855 Switch SoC. This SoC expose various
> peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> 
> It does also support i2c and timers but those are not currently
> supported/used.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/mfd/airoha,an8855.yaml           | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


