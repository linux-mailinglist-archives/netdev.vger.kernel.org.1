Return-Path: <netdev+bounces-247441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B15D9CFA805
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 20:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48080305F528
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 19:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718AE2C027B;
	Tue,  6 Jan 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFQ5SAei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44142274FDF;
	Tue,  6 Jan 2026 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726482; cv=none; b=jgp0ZmZjYCm907l9u+JrKp696He5b5lNPrd8NUrlGR0SwCHq4GHiknR6JLnER4/6PDD7QUih6Gp/Ypmuggm4yoFMnqOK9MAJoS6RFoLbUiezwO6WmfjnYBDcnfOllZ+0NQaS7bwYRJ4pzzzCSaE9Y/av3gDSfchSDnJ1yOmTVok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726482; c=relaxed/simple;
	bh=u9DkmJtck8Gc8X7zOPBHUnDaOOBZacRpl9q/C06riN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKHOt4nXzG2lDoZZ5dsMK97qBFc8Gxn+M2uE6j0sXbB/7EW2iJBCWD/C0bbZZQFtMBOUXWzSBztT1e8kRneVQZpFB3WOZ2+68wxWFuiafxfNBipjQxIA4k3nbt4ubqp0VoPb8JB5ri4IWM1rj9dTdTVxY+hDQSDo8rpVUP8BZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFQ5SAei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCBBC19422;
	Tue,  6 Jan 2026 19:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767726481;
	bh=u9DkmJtck8Gc8X7zOPBHUnDaOOBZacRpl9q/C06riN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFQ5SAeiBqjiwrJGCO0B7KsJHn/6wn0GLVEQG4Rl16FaTkv8L/Od3KLBU6TrweBG7
	 2cqKgSdU8YQyshLZP4ZFg2WuN3Dw53KkGNFUCtk1NoQaqfVhv6Rvt0RHflV33LQ2B6
	 BTw6e4rWTdVIf/4n28ye+uDgMU7kBZ1LoWDQUXjhqS7jMElwB0t7UN4RYe55ZqlOLg
	 zAQD0YhaLu7D560lJVbOljv5INF/IlDEOdJAAJv+0YMVhyB3hV4kzgCP8IapNwBOdt
	 cS6OxwoNZiblSwool7IVY89R68Aoa47PjrpjEfF5Dy0G+7ph5Vmreg3wwLmcx9eKLF
	 HOA4qTQVmi9GA==
Date: Tue, 6 Jan 2026 13:08:00 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: dsa: lantiq,gswip: add
 MaxLinear R(G)MII slew rate
Message-ID: <176772648028.2565771.5663023472968969071.robh@kernel.org>
References: <20260105175825.2142205-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105175825.2142205-1-alexander.sverdlin@siemens.com>


On Mon, 05 Jan 2026 18:58:21 +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Add new slew-rate uint32 property. This property is only applicable for
> ports in R(G)MII mode and allows for slew rate reduction in comparison to
> "normal" default configuration with the purpose to reduce radiated
> emissions.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> Changelog:
> v3:
> - use [pinctrl] standard "slew-rate" property as suggested by Rob
>   https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.org/
> v2:
> - unchanged
> 
>  .../devicetree/bindings/net/dsa/lantiq,gswip.yaml          | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


