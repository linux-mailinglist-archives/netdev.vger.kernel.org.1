Return-Path: <netdev+bounces-233288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA46C10570
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 19:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 307514FA28C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3244832B9A2;
	Mon, 27 Oct 2025 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV2r+MXV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0543F246BB7;
	Mon, 27 Oct 2025 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591261; cv=none; b=X2+ZOgxSCTBMvnAo2/3USXzC9WXQV8FRCVt3YoOvwW0u2vndifxJDzIad4uqtQvfg4lJzwQw+z7AUc/irsO4BKMVVheewZblfF+Ff7vmM2QOq1UgDxwp+A9qkyCLd1l+UM/h7tTBvwvEHaO9gjRtIMEZOJzaPAQSmQuaJQnZV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591261; c=relaxed/simple;
	bh=GFYVrpsOhV/IDMS7pxMo1goftmWnsj824iiTB3K/kLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoV6FP2ZxE7pbg/qlYK3spt29Y5XgJxn+ojj4qvS/TggzSEllC7MyhY+DumR51Z9Y67ofh3AbJCuQyEJgBj4VJe4vnzdxQX3lmpAOZdFc0gy1rwRCFcxTZENm7msnxaH6ADW5nU+qlF6ARys35S4r9oOLtmiuu3yKW56q47IUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV2r+MXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7675BC116B1;
	Mon, 27 Oct 2025 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761591260;
	bh=GFYVrpsOhV/IDMS7pxMo1goftmWnsj824iiTB3K/kLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DV2r+MXVqDP7hNaS7Zfg/b6Aw/fUNBkTRGbrdVNn4fqcY6VZs/0ivvzBd8JNL4MBX
	 Nu5glfecNS5S03aV/cxn23Qz3MtmQuXzL75RpQkGcyVM7r5w6aZS97ZOtKeqVFDtdu
	 zXvq9WCB81uIFqaQvrPQNNuTvvU3VV3D7odoCgzKvg/8TZSuNVrQikF3ja0+Ag3trM
	 3Pt2kBuekfha8mQ5IfXbERZPkSl2jdKG7UoypxDSVl1b0FVL8I6v1K9t6FzViixUW0
	 qJC/IpM78qbW1c/MpUowiADH+2myLwbDV5Ts8hrodnCsgOW7aHPIgupCU4sd4Uh3IN
	 kuWVKmFnKCqzA==
Date: Mon, 27 Oct 2025 13:54:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	devicetree@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] dt-bindings: net: phy: vsc8531: Convert to
 DT schema
Message-ID: <176159122491.1402525.10322213596595945549.robh@kernel.org>
References: <20251025064850.393797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025064850.393797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>


On Sat, 25 Oct 2025 07:48:50 +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Convert VSC8531 Gigabit ethernet phy binding to DT schema format. While
> at it add compatible string for VSC8541 PHY which is very much similar
> to the VSC8531 PHY and is already supported in the kernel. VSC8541 PHY
> is present on the Renesas RZ/T2H EVK.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Inspired from the DT warnings seen while running dtbs check [0],
> took an opportunity to convert this binding to DT schema format.
> As there was no entry in the maintainers file Ive added myself
> as the maintainer for this binding.
> [0] https://lore.kernel.org/all/176073765433.419659.2490051913988670515.robh@kernel.org/
> 
> Note,
> 1] As there is no entry in maintainers file for this binding, Ive added myself
> as the maintainer for this binding.
> 
> v1->v2:
> - Updated dependencies format as per review comments.
> - Updated vsc8531,edge-slowdown description to use formatting.
> ---
>  .../bindings/net/mscc-phy-vsc8531.txt         |  73 ----------
>  .../bindings/net/mscc-phy-vsc8531.yaml        | 131 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +-
>  3 files changed, 132 insertions(+), 74 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
>  create mode 100644 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


