Return-Path: <netdev+bounces-109337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC82E928046
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 04:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829F11F25D62
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 02:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4578101CE;
	Fri,  5 Jul 2024 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzYGLJ4J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6B175BE;
	Fri,  5 Jul 2024 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720145808; cv=none; b=f8PF1ro/fo+6YfiCrliPxfRETRwasGSf/SaNRzdxdpyYRCozoL86VOrbGywjajPxAamO8H277008qmxPV5ckDfwE8gJc8VaLPf60Z1DODnAJOe/Pc5oF1eStTLJu/DuaEyqqhcaTphPj9tCkpEqcHATlDhRCar6BfLDMeWwTU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720145808; c=relaxed/simple;
	bh=hKmjhi2xmvB/59Pvh7AExkrvoAZ0CzfZP+83fP4UK2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENi2XJ25xcnTMGEXR2QET+ZGqjvDNQ7SPuYLMSrgNMG+bqvyYfiEcTAIplceuFshj4Y6FIxuRQrzI/Jmg9ilLM3R5H32mmEVD0Sat2Kz3H53C2WKdoHbOITFlq0arG+VPEvCFB/TWlnw/LfW5b60KOM2Lm45XUTTrpfoYio8uJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzYGLJ4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB34C3277B;
	Fri,  5 Jul 2024 02:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720145808;
	bh=hKmjhi2xmvB/59Pvh7AExkrvoAZ0CzfZP+83fP4UK2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tzYGLJ4JLO2kcAiCFH8SE7LMY4nG26OxSyUYiBrJE5AxqA/v5amwRggXD0Qipeu7I
	 pVv9Tqzt0CqR6ytnwVjqFFghkmlSWid7GQEFUgK9GnJzMLa84/Obn0mHYx3i8FG5uc
	 L/VGHFXA78mKzibJw36Lo3LQjmpsBZluH7EuZpDKSre5Ff9hcbGCPBR0M42hHhfWS+
	 SpbjwzP5j06cx/gLnl0npca19Wiye4PgZKt4FoLYZ1VWyODJ4vuON9uO3iBXrYqO1w
	 gb6qfBCL8oP8fxADyK60DSDC0oNfeznrvWDkl6W0sUylFYYFYkNym49bVSx/++Kyl2
	 SZVR7b0+PyTBA==
Date: Thu, 4 Jul 2024 19:16:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew@lunn.ch>, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] netdev_features: convert
 NETIF_F_FCOE_MTU to dev->fcoe_mtu
Message-ID: <20240704191646.06bb23c8@kernel.org>
In-Reply-To: <20240703150342.1435976-6-aleksander.lobakin@intel.com>
References: <20240703150342.1435976-1-aleksander.lobakin@intel.com>
	<20240703150342.1435976-6-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jul 2024 17:03:42 +0200 Alexander Lobakin wrote:
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -571,6 +571,7 @@ static int vlan_dev_init(struct net_device *dev)
>  
>  	dev->features |= dev->hw_features;
>  	dev->lltx = true;
> +	dev->fcoe_mtu = true;

why?

