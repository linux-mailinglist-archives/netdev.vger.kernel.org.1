Return-Path: <netdev+bounces-235397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18071C2FE3F
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 09:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E31E19209EF
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 08:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1BA314D08;
	Tue,  4 Nov 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/UtMIYU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304D30F941;
	Tue,  4 Nov 2025 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244430; cv=none; b=MC2VWgR6lCotmIMOtES7b/+fz6IRoHOwaICz4a/K3IyJ27/bH6LzTlGWRjhnfgs4tk5ds6MFVwHAvsrXdmv9eMfRh1hd0uChgVFaIO0apxE9+gXV6vtfxVcX3bWsC4aryf+dNfEy+1IHrLEg4ZzNdxUyxSgSaKCnLzw6iWeml1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244430; c=relaxed/simple;
	bh=6jABtiP9twriCAafB7qhdYkC2NWk+AwMtjQZTn4C2Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOmzuM0xq+4lYfzFbaN/2Yz5F/HU3VzyC53cQnNnanUQwI80Ljbuohnh7lyVUtMEmgoUVyH53WDdbZFNPIvX5TofvbDuSAAcrKYh+2YypUKlY1p/frKdEpMR3ym8mTSXEVwAU9bC0y2SWPJEG0iQ/VuiLVF2yIr1CjJGbtO/VHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/UtMIYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB78C4CEF7;
	Tue,  4 Nov 2025 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762244429;
	bh=6jABtiP9twriCAafB7qhdYkC2NWk+AwMtjQZTn4C2Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/UtMIYUTCw7UuAF9ifUV2bMlp41aMmcBIUBJORgkZB30LLHmuz5KXhEbbzN934YZ
	 GQhbh+pgeMaaScX3k5Osd9TsIcCBB97MDUtjBNcwPx/VGrSntzG9+96E7QGOZjzlFY
	 bgNFFIar+xKpx2US5yb1If682qFHgNMo/EXBhKSIHVSLgHrDhTCGc/qCmo9kecprat
	 3u4T/P2Qu0Bc83QpxNpHqVmkhIFEX+2KaHtsWYKUO/9gY2zu/iwIDLgxB9WiraWnDk
	 xQynuOYpwwzR9HH05orJUGrVbMH7tqbDr8fiNUIbilQ7Kpy6eaoh2IkY0uge3aR2eM
	 ErY0lNpemZBGA==
Date: Tue, 4 Nov 2025 09:20:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v3 0/4] Add AST2600 RGMII delay into ftgmac100
Message-ID: <20251104-dangerous-auk-of-order-6afab2@kuoka>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>

On Mon, Nov 03, 2025 at 03:39:15PM +0800, Jacky Chou wrote:
> This patch series adds support for configuring RGMII internal delays for the
> Aspeed AST2600 FTGMAC100 Ethernet MACs. It introduces new compatible strings to
> distinguish between MAC0/1 and MAC2/3, as their delay chains and configuration
> units differ.
> The device tree bindings are updated to restrict the allowed phy-mode and delay
> properties for each MAC type. Corresponding changes are made to the device tree
> source files and the FTGMAC100 driver to support the new delay configuration.
> 
> Summary of changes:
> - dt-bindings: net: ftgmac100: Add conditional schema for AST2600 MAC0/1 and
>   MAC2/3, restrict delay properties, and require SCU phandle.
> - ARM: dts: aspeed-g6: Add ethernet aliases to indentify the index of
>   MAC.
> - ARM: dts: aspeed-ast2600-evb: Add new compatibles, scu handle and
>   rx/tx-internal-delay-ps properties and update phy-mode for MACs.
> - net: ftgmac100: Add driver support for configuring RGMII delay for AST2600
>   MACs via SCU.
> 
> This enables precise RGMII timing configuration for AST2600-based platforms,
> improving interoperability with various PHYs
> 
> ---
> v3:
>  - Add new item on compatible property for new compatible strings
>  - Remove the new compatible and scu handle of MAC from aspeed-g6.dtsi
>  - Add new compatible and scu handle to MAC node in
>    aspeed-ast2600-evb.dts
>  - Change all phy-mode of MACs to "rgmii-id"
>  - Keep "aspeed,ast2600-mac" compatible in ftgmac100.c and configure the
>    rgmii delay with "aspeed,ast2600-mac01" and "aspeed,ast2600-mac23"
> v2:
>  - added new compatible strings for MAC0/1 and MAC2/3
>  - updated device tree bindings to restrict phy-mode and delay properties
>  - refactored driver code to handle rgmii delay configuration

That's b4 managed change, so where are the lorelinks? Why are you
removing them?

Since you decided to drop them making it difficult for me to find
previous revisions, I will not bother to look at background of this
patchset to understand why you did that way and just NAK the binding.

Next time, make it easy for reviewers, not intentionally difficult.

Best regards,
Krzysztof


