Return-Path: <netdev+bounces-209169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1B9B0E845
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EE51CC0CA6
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F782628D;
	Wed, 23 Jul 2025 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSaxlIQU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C835360;
	Wed, 23 Jul 2025 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235272; cv=none; b=o42kaD5CPf/cPsrhtzcPReQdh5mx7wGuqOWPlRRUkSst4d1CUFewCMz2GjYGB91KDIJtYTiIEHfO8TeGyZO1J9UiTJg3LqDmIeojDPqQK4B082MuB1iyoSueM5mh4w7RDy5lMEfNllmQxHR9KM6p26QWkjdY9yMC7zGaD1Xray4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235272; c=relaxed/simple;
	bh=Mb7U/KhjDFYsWZAeq7kpLX/tB1mdXgzYH+ofNnJA7w8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8MQcgCLTfrVnhsLjBL1z+biV32y6JI7jSwPpQ50oozIJ6cvh7H9sBEr+fBMV7kHhAYxVtIq9Lj3WW9cV87RryWio+qgJhbMlPmJmraEAj8gMUI6wrJgmtA0VM8nYNbLa1fQp93l4MvSiGbRnTjiLB9207zlH466cBc5LJBhipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSaxlIQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A242C4CEEB;
	Wed, 23 Jul 2025 01:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753235271;
	bh=Mb7U/KhjDFYsWZAeq7kpLX/tB1mdXgzYH+ofNnJA7w8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eSaxlIQUL3eEVbxCOQIkht46i9qOkmpPjC5awQyRZf+80aAT4OZIJZUgFL0KzvJob
	 jJN9p51Z2Gn4Jjut7HLS2qSJ2CVjZLi7xvRlDmvJH6ovV+oomM+l9vLsoj9OnTbtpW
	 gxs+lyqFOALDov3oq+hcqHiX5bceaHhcg3F2jZnSRCskO2KltNrL1K3hCADq/ykMAl
	 dgy5YzH7L4s2rPVAubBNabH9/l+qwCEmNDieDGEv+uN28T8PLqc2BcIgO84RMCRbiz
	 CXaYalL5ZiufedGuZVCYL1iAm0lLSPJPgbuugLy4hJuM57rIH6Gm01wEMYqpqD4y7f
	 Cib+Y+5jAPyhA==
Date: Tue, 22 Jul 2025 18:47:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ssantosh@kernel.org, richardcochran@gmail.com, s.hauer@pengutronix.de,
 m-karicheri2@ti.com, glaroque@baylibre.com, afd@ti.com,
 saikrishnag@marvell.com, m-malladi@ti.com, jacob.e.keller@intel.com,
 kory.maincent@bootlin.com, diogo.ivo@siemens.com,
 javier.carrasco.cruz@gmail.com, horms@kernel.org, s-anna@ti.com,
 basharath@couthit.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev, pratheesh@ti.com,
 prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v11 2/5] net: ti: prueth: Adds ICSSM Ethernet
 driver
Message-ID: <20250722184749.0c04d669@kernel.org>
In-Reply-To: <20250722132700.2655208-3-parvathi@couthit.com>
References: <20250722132700.2655208-1-parvathi@couthit.com>
	<20250722132700.2655208-3-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 18:55:02 +0530 Parvathi Pudi wrote:
> +	for_each_child_of_node(eth_ports_node, eth_node) {
> +		u32 reg;
> +
> +		if (strcmp(eth_node->name, "ethernet-port"))
> +			continue;
> +		ret = of_property_read_u32(eth_node, "reg", &reg);
> +		if (ret < 0) {
> +			dev_err(dev, "%pOF error reading port_id %d\n",
> +				eth_node, ret);
> +			return ret;

missing put for eth_node

> +		}
> +
> +		of_node_get(eth_node);
> +
> +		if (reg == 0 && !eth0_node) {
> +			eth0_node = eth_node;
> +			if (!of_device_is_available(eth0_node)) {
> +				of_node_put(eth0_node);
> +				eth0_node = NULL;
> +			}
> +		} else if (reg == 1 && !eth1_node) {
> +			eth1_node = eth_node;
> +			if (!of_device_is_available(eth1_node)) {
> +				of_node_put(eth1_node);
> +				eth1_node = NULL;
> +			}
> +		} else {
> +			if (reg == 0 || reg == 1)
> +				dev_err(dev, "duplicate port reg value: %d\n",
> +					reg);
> +			else
> +				dev_err(dev, "invalid port reg value: %d\n",
> +					reg);
> +
> +			of_node_put(eth_node);
> +		}
> +	}
-- 
pw-bot: cr

