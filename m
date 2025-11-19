Return-Path: <netdev+bounces-239753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D09C6C25B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A26A124136
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 00:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D2620468E;
	Wed, 19 Nov 2025 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+uvrV3H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EF01A2C04;
	Wed, 19 Nov 2025 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763512895; cv=none; b=Z6ZhR02lLpLZDY6dOqZbog8bIJpf6e/0zJQVHAgt+T8l1Lvy6WSPIOwxL7sJagqUK05Kni+GybJ69uehdjwVkQC1G84Aiuw1neKycaa6H6YWg8Ga+fPoZLVebJj+80wwK9ACGG72O5YfypzmvwlY0Qy+z+f21IwDBgezSKihQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763512895; c=relaxed/simple;
	bh=U5ciVnT2YkZa7iCqKBuM/ky462nEvfW6ahGS+5NElxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsqvNFtqAUSgHrfcuOlkkRGg8G3dNnKc3XjGS3ohh91yUk9Y+zjgYYxP7hy1eB6YAdcox797fSAfEOpn2qpL52XIYGyFD5V2tY5of8tyWg2x/gbmHZmf+x2AWCDZX0bMr0smScMzf0d3Rk994hFwpP7EpDIEeYHpZzuusEoRobw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+uvrV3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B890DC4CEF1;
	Wed, 19 Nov 2025 00:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763512894;
	bh=U5ciVnT2YkZa7iCqKBuM/ky462nEvfW6ahGS+5NElxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q+uvrV3HZ6oEBAhz7AenGKm/Y3gm9c+rvz8g3yo4tjIRZC5+ewpa1IM9WuBO35O69
	 C9jKOoZ9QRTmLTgpnCIeqPgNUHlY1UyiY65SK17fuWsF8duhujxheUvyUZxPBokGl1
	 n2LMpACSbwgQSgp3eaTOXqCvC+v2RvDT/DhFPSA9G7xRaalowfbhjRJcZMcrv961i8
	 yCVRoZFLZylvf4AyqOM5jtXrk/47fFuP1oH2ARp+4Jfc53O2RamxZt8WBghJBDb0uy
	 RZfY4gJuf1Ywdj0DCkDlrjv959sVvxMmtk9JbxjD8t5r9dXy2rJy586VtybGABh4x/
	 KOybyhK2WMgrw==
Date: Tue, 18 Nov 2025 16:41:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, Serge Semin
 <fancer.lancer@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Herve Codina
 <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <20251118164130.4e107c93@kernel.org>
In-Reply-To: <20251118190530.580267-15-vladimir.oltean@nxp.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
	<20251118190530.580267-15-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 21:05:29 +0200 Vladimir Oltean wrote:
> +static bool sja1105_child_node_exists(struct device_node *node,
> +				      const char *name,
> +				      const struct resource *res)
> +{
> +	struct device_node *child = of_get_child_by_name(node, name);
> +	u32 reg[2];
> +
> +	for_each_child_of_node(node, child) {
> +		if (!of_node_name_eq(child, name))
> +			continue;
> +
> +		if (of_property_read_u32_array(child, "reg", reg, ARRAY_SIZE(reg)))
> +			continue;
> +
> +		if (reg[0] == res->start && reg[1] == resource_size(res))
> +			return true;

coccicheck says you're likely leaking the reference on the child here

> +	}
> +
> +	return false;
> +}
-- 
pw-bot: cr

