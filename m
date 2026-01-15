Return-Path: <netdev+bounces-250305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DD1D28444
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4BE3024D4A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EA031AAA8;
	Thu, 15 Jan 2026 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD9PJ0Yj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229182E0925;
	Thu, 15 Jan 2026 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507175; cv=none; b=PBnJ4B6QWeNeiyWtFiQfTETlvw3qCQETbYZ+BiEuUbhRktk70rTmyPLxEZv/rFqGFjcaZcpZcFcEiTb8QQ1mIz5eufDGCHKsb2dMZM0Tcy6hprmUxYVZYwrnc1JFpdEHy+ykbzwUkrDYq33bRtK558/wPBygR7oZVLyC9stQdak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507175; c=relaxed/simple;
	bh=RkEYbPqQQiioZsN+BkMGnR/PxVB7SupczVUWZyoWiDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMHeZGM4L4ZXZzlCV98Bi1/6ofDZmWjyjPmIbv785J/cWyQf5BmclXrTYEF2NuzEvizff4/+AV/1QgmK2UDXguGzJGjFsu00kTMzL57UnDBSiARQlvYf1DeMtQ7VFkhHPRXTVlYk8J/K6dzWTrmu5qut2LMqQ8Fbj4L6Rlujm9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD9PJ0Yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87427C116D0;
	Thu, 15 Jan 2026 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768507174;
	bh=RkEYbPqQQiioZsN+BkMGnR/PxVB7SupczVUWZyoWiDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JD9PJ0YjTxh8rb1+9Fi89FovaohjbD3WoBomeuE7/GN8JbARe91WH2o+rEU5zlmrj
	 76fvqWY4sup2FSu3zkoZIukUMhDU6IIpiIBvwyPQGvf0uQtg0buKIzPp5LMMmJIjiL
	 nuOOdjVd8YhoPak/CLJzKgcGzR69N51mBykPvHJp7p9CnvmA67w+mpHLdvmRI13WLx
	 jNDMGWdZ13i4euSHxZ5ZeYz5rffi8fFIf4ialksR9oUU5+xXdwH6ibaPHgWoNABpp8
	 hi1ZONKHkUj4OE0hYeipbwnCe8QbFD2xrQITe2oGzFb65BP+L4QV04m0Wiv1yxN7Z7
	 ZuiXENd/7jOkA==
Date: Thu, 15 Jan 2026 13:59:33 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, netdev@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Xinfa Deng <xinfa.deng@gl-inet.com>, Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	Chen Minqiang <ptpt52@gmail.com>
Subject: Re: [PATCH net-next v2 1/6] dt-bindings: net: dsa: lantiq,gswip: use
 correct node name
Message-ID: <176850717284.1090644.6719802783809882607.robh@kernel.org>
References: <cover.1768438019.git.daniel@makrotopia.org>
 <83c6aa2578c6fa7b832a6146ef74b9f7aee0941d.1768438019.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c6aa2578c6fa7b832a6146ef74b9f7aee0941d.1768438019.git.daniel@makrotopia.org>


On Thu, 15 Jan 2026 00:56:39 +0000, Daniel Golle wrote:
> Ethernet PHYs should use nodes named 'ethernet-phy@'.
> Rename the Ethernet PHY nodes in the example to comply.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: new patch
> 
>  Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


