Return-Path: <netdev+bounces-110359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E0792C1A6
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E161C235E3
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126671B3F38;
	Tue,  9 Jul 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twvyRLuc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCD31B3F36;
	Tue,  9 Jul 2024 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542953; cv=none; b=hK20eBb/uBV4BXjiDvemWMLOW0i5CHXXjcWt0Ob5RZIp3dc/8qpK1CdHWDo/AQoyW5GkDxwXElK1bD/YLj6WO6I3ZfLxSkdVVYU+VRf/saotfWwwtmn94nIzlTh420o/1JoZ9ZmQF4WA68IN9ZCpRX3GK9GemhrmJQVN5PwezQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542953; c=relaxed/simple;
	bh=PYon4hQdxGO7e0EDMK4Nxz9LKrzuP9di25nvK4n93mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNp20o3bHRzITnUbH/e1gSKBDNxUnimlXBdEWXGSl7M8/lV7NRlIc4x2OBVQOBciHQ9Ke7E3dZOQoVfLKbGqofeR0rNYco0rfJttI3Cxkrmk1mn9jrQeVU7YU7dGF3Cj9mmHsUg7Wnwuj721KtE2yRSy8KZ+p9DkKgx4kckC/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twvyRLuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B732C3277B;
	Tue,  9 Jul 2024 16:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542952;
	bh=PYon4hQdxGO7e0EDMK4Nxz9LKrzuP9di25nvK4n93mQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twvyRLucwGY1I58lLSwdlpoMQKYfsN7ad13xckCwcWLcTJJCyF/F2wjhV6uOFRK3P
	 /mfPrbBeBF6yFSudZThbfYJKEJ6aJMEYgFR49affrowxcaMZPT+/UmVkCDXOoHt/Sk
	 Rztm7x48OlKQDxBoRjuP/hAhWZrzTCYOWZqKPDwKcoi6vYA7Z1kD/k2QcgQrTvQWCb
	 4U/sOQ3gNj9FMbN4Pz3mpKJNGu3n9FCxRb9JUDGRa1AAQiEnJCrfZjDh4jyE6D4bLY
	 l+RXRRaFl/e8J2ScMYejv8hmbptKWYCs7fys3F4E00P6OufqAIHvqNrpZrAXYHbc0v
	 cuoP4FtyXPONA==
Date: Tue, 9 Jul 2024 10:35:50 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: will@kernel.org, robh+dt@kernel.org, pabeni@redhat.com,
	catalin.marinas@arm.com, nbd@nbd.name, netdev@vger.kernel.org,
	conor@kernel.org, kuba@kernel.org, edumazet@google.com,
	conor+dt@kernel.org, davem@davemloft.net, andrew@lunn.ch,
	upstream@airoha.com, krzysztof.kozlowski+dt@linaro.org,
	benjamin.larsson@genexis.eu, devicetree@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	lorenzo.bianconi83@gmail.com, horms@kernel.org,
	sgoutham@marvell.com, arnd@arndb.de, rkannoth@marvell.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 net-next 1/2] dt-bindings: net: airoha: Add EN7581
 ethernet controller
Message-ID: <172054295007.3801994.16971652851530691751.robh@kernel.org>
References: <cover.1720504637.git.lorenzo@kernel.org>
 <da1a2266e457c8e9b2c29605b8aca4ca688e4c60.1720504637.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da1a2266e457c8e9b2c29605b8aca4ca688e4c60.1720504637.git.lorenzo@kernel.org>


On Tue, 09 Jul 2024 08:05:21 +0200, Lorenzo Bianconi wrote:
> Introduce device-tree binding documentation for Airoha EN7581 ethernet
> mac controller.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/net/airoha,en7581-eth.yaml       | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


