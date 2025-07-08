Return-Path: <netdev+bounces-204953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10DFAFCAD9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16B5189AB53
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B8A273FE;
	Tue,  8 Jul 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvfZfLAN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2A42C17A8;
	Tue,  8 Jul 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978923; cv=none; b=gl+SgTQ2/RQ4M/JHjTZXcFAx7RfQnC3VhHTneLo+0MCJOohAQUhQTZWJx8iF8ptOY/DFpYzgdMBL1jc3ZMrmvVYHcGRtn+5+o7i5gOwU6oxzbPsB/jvBXTMtNrhAQluJD/GnJLwnIdDChtep/u6weXUDCKaDyea+uoW9v3YD9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978923; c=relaxed/simple;
	bh=g28q4NZzgjbR8MHAVRF184NIvjRYYLJKJLr/vf5Xqa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXCU1h3uA03g70r667haXjXaPb1pIjLAsCbEjEMXxCi0aeZGadDzvmxkdjT97ktr6Fq0I2mDmNKM92GbKYcRa8YxiQD1T7PZdZOw+IIZlqf7vQ6l+0idWUg04GjxP17AXLN8X+w3JWUNfel/oATQtGyD4IY+3itTpoxW0zJCdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvfZfLAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE67AC4CEED;
	Tue,  8 Jul 2025 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751978922;
	bh=g28q4NZzgjbR8MHAVRF184NIvjRYYLJKJLr/vf5Xqa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvfZfLAN6D+0IltIX1CfxRC4LV3nqjMMYob8x+k/tq5lZH2vSghsXQkcSbA6EkQ9s
	 s53PpjKI1lcBbHdI2NcG7YgWNJD/umeQ7hSWowRigX5AajnQC6NZjd9SQJ85h8FmSo
	 wobXcIJYzu0qP0EQhLQ8udcdZ/mYPIfpbFoHyvSqPtGkaOA2HwGwFKncmjgrsafVHG
	 mqInBklOngKJlfwPJWyWKU7XKPTRszd4I+D9E00vA3NnpyjzWjFWxkEYd7yJWJNFJO
	 F+2MumPHbe9KOXGyWz3qSk6k3QXW78S74nC4IwI+IJFiwEFM/w6t5DGsrBXr42/RLm
	 4I+YmUWHiFGTg==
Date: Tue, 8 Jul 2025 07:48:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: netdev@vger.kernel.org, Jernej Skrabec <jernej@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-sunxi@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
	Andre Przywara <andre.przywara@arm.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 1/2] dt-bindings: net: sun8i-emac: Rename A523 EMAC0
 to GMAC0
Message-ID: <175197892100.398224.11294321138188145975.robh@kernel.org>
References: <20250628054438.2864220-1-wens@kernel.org>
 <20250628054438.2864220-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628054438.2864220-2-wens@kernel.org>


On Sat, 28 Jun 2025 13:44:37 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The datasheets refer to the first Ethernet controller as GMAC0, not
> EMAC0.
> 
> Rename the compatible string to align with the datasheets. A fix for
> the device trees will be sent separately.
> 
> Fixes: 0454b9057e98 ("dt-bindings: net: sun8i-emac: Add A523 EMAC0 compatible")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


