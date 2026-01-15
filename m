Return-Path: <netdev+bounces-250303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D0BD283F3
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAFFE3014DC6
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DC430FC19;
	Thu, 15 Jan 2026 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8LnFsKP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AF2FBDE6;
	Thu, 15 Jan 2026 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768506723; cv=none; b=f9zaVKUjw0uifg7yAkwHBUYAUQrOx75JrSuG2kjpcykpy7uKWTYYTHXWpFgsYMnBOrybFwSPNomx53EYKzW7yAx9KhEfU/pZ5fkv1hVJC9cMT0X2POCBTuK3H/qrlyj47to57Yg2T7PMrohhBQnnNxYuu14EfrbBeO6DQB5IZh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768506723; c=relaxed/simple;
	bh=//kBx7ppGNM7srddCfSx5X1Hj9UEY3/BlqtI1+Rrfdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNr2hz6qT+4KZTU6NG3KjJcYgKsmPkq3LdbUamlqwb5hpiAT7T0oAd7KXSg2pfjZcom+nSbgo7tLcSxdWmqZ7Naho275HeCm4AZEZCQwCgeQXc/cAX1IvucJrkfvluW2E+w09MqXbhdRsbGwy2WHx4/o/OnCLwlU5sdyYxDEkg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8LnFsKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A87C116D0;
	Thu, 15 Jan 2026 19:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768506723;
	bh=//kBx7ppGNM7srddCfSx5X1Hj9UEY3/BlqtI1+Rrfdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8LnFsKP9vuB8TLWzXkSqj6bv+7IAzahiT7yqeOPhJbSq6ofXxBEy9tjqJlXQYHZB
	 WSCWGwxjveUXlemRZA3bt+snY9lIeUvHIU6qgV37HvVXwnZamxWCx0qayacKEAnqhO
	 skLdErbMsIHCvVxM8mHzG7xhyNULRVJ1AQ4B67HZfGkGmAHk07PKf9BueIJ2q4Ug4x
	 DVwAN3K6eUQEMFlG2Pib/c464pu3cN3q8z6Uwn958YBABTjWq8YdK7bifJhi8I6n3M
	 ugqhae9ohaPjhX/tI2ZagWWo09FC/8lVoVJ156O34dWQKn/w7kcX3j7PXwzhIzh7lP
	 HGqKl18saozOA==
Date: Thu, 15 Jan 2026 13:52:02 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Kishon Vijay Abraham I <kishon@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-phy@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH phy 2/8] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <176850672122.1082429.444623229961712368.robh@kernel.org>
References: <20260114152111.625350-1-vladimir.oltean@nxp.com>
 <20260114152111.625350-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114152111.625350-3-vladimir.oltean@nxp.com>


On Wed, 14 Jan 2026 17:21:05 +0200, Vladimir Oltean wrote:
> The 28G Lynx SerDes is instantiated 3 times in the NXP LX2160A SoC and
> twice in the NXP LX2162A. All these instances share the same register
> map, but the number of lanes and the protocols supported by each lane
> differs in a way that isn't detectable by the programming model.
> 
> Going by the generic "fsl,lynx-28g" compatible string and expecting all
> SerDes instantiations to use it was a mistake that needs to be fixed.
> 
> The two major options considered are
> (a) encode the SoC and the SerDes instance in the compatible string,
>     everything else is the responsibility of the driver to derive based
>     on this sufficient information
> (b) add sufficient device tree properties to describe the per-lane
>     differences, as well as the different lane count
> 
> Another important consideration is that any decision made here should
> be consistent with the decisions taken for the yet-to-be-introduced
> 10G Lynx SerDes (older generation for older SoCs), because of how
> similar they are.
> 
> I've seen option (b) at play in this unmerged patch set for the 10G Lynx
> here, and I didn't like it:
> https://lore.kernel.org/linux-phy/20230413160607.4128315-3-sean.anderson@seco.com/
> 
> This is because there, we have a higher degree of variability in the
> PCCR register values that need to be written per protocol. This makes
> that approach more drawn-out and more prone to errors, compared to (a)
> which is more succinct and obviously correct.
> 
> So I've chosen option (a) through elimination, and this also reflects
> how the SoC reference manual provides different tables with protocol
> combinations for each SerDes. NXP clearly documents these as not
> identical, and refers to them as such (SerDes 1, 2, etc).
> 
> The per-SoC compatible string is prepended to the "fsl,lynx-28g" generic
> compatible, which is left there for compatibility with old kernels. An
> exception would be LX2160A SerDes #3, which at the time of writing is
> not described in fsl-lx2160a.dtsi, and is a non-networking SerDes, so
> the existing Linux driver is useless for it. So there is no practical
> reason to put the "fsl,lynx-28g" fallback for "fsl,lx2160a-serdes3".
> 
> The specific compatible strings give us the opportunity to express more
> constraints in the schema that we weren't able to express before:
> - We allow #phy-cells in the top-level SerDes node only for
>   compatibility with old kernels that don't know how to translate
>   "phys = <&serdes_1_lane_a>" to a PHY. We don't need that feature for
>   the not-yet-introduced LX2160A SerDes #3, so make the presence of
>   #phy-cells at the top level be dependent on the presence of the
>   "fsl,lynx-28g" fallback compatible.
> - The modernization of the compatible string should come together with
>   per-lane OF nodes.
> - LX2162A SerDes 1 has fewer lanes than the others, and trying to use
>   lanes 0-3 would be a mistake that could be caught by the schema.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> part 1 -> part 2:
> - drop everything having to do with constraints (on #phy-cells,
>   #address-cells, #size-cells) based on new compatible strings.
> 
> Patch made its last appearance in v4 from part 1:
> https://lore.kernel.org/linux-phy/20251110092241.1306838-16-vladimir.oltean@nxp.com/
> 
> v3->v4:
> - OF nodes per lane broken out as a separate "[PATCH v4 phy 01/16]
>   dt-bindings: phy: lynx-28g: permit lane OF PHY providers"
> - rewritten commit message
> - s|"^phy@[0-9a-f]+$"|"^phy@[0-7]$"|g in patternProperties
> - define "#address-cells" and "#size-cells" as part of common
>   properties, only leave the part which marks them required in the allOf
>   constraints area
> v2->v3:
> - re-add "fsl,lynx-28g" as fallback compatible, and #phy-cells = <1> in
>   top-level "serdes" node
> - drop useless description texts
> - fix text formatting
> - schema is more lax to allow overlaying old and new required properties
> v1->v2:
> - drop the usage of "fsl,lynx-28g" as a fallback compatible
> - mark "fsl,lynx-28g" as deprecated
> - implement Josua's request for per-lane OF nodes for the new compatible
>   strings
> 
>  .../devicetree/bindings/phy/fsl,lynx-28g.yaml | 33 +++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


