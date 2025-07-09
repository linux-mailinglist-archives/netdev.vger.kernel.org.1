Return-Path: <netdev+bounces-205206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD34AFDC7F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD7C3B8824
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8895E84A2B;
	Wed,  9 Jul 2025 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9kuF89l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9662C187;
	Wed,  9 Jul 2025 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752021892; cv=none; b=uSpYWgVW/df1FVwANtyQIHl4JuRhD65sJP+xUVB3UBX9HL9adgJeXVS84zP4oLe9YPb43zQ3iaRqSpoJbRYHk7MKYXq3UGW/2rI29PY+5ZO3/AnjWJVKfD1f9IAr73mX0q6nkUf7HFjCp+3Vv5OxvoV5OaI8cqCjXpahE+VZMLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752021892; c=relaxed/simple;
	bh=T4lJ7IfchIx8O9WvBI06w6cJ9APqPZYrqfcn3GERTnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZBRR6U2s51MOQzXZn0fzGpXMEXJWrOT7GY0+rXo1NWU/QdmJ55lH/CyhG1DMK7Jor4DelbccGBlM+xconR52OzajY3hKYpE86l90/VxgLHu5vhGgqkxBCsezgDbUEygyDBdKoqmHd3vfub5ZjeQzN9uf+nhXPmzyajrZ3lkaPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9kuF89l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BA4C4CEED;
	Wed,  9 Jul 2025 00:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752021891;
	bh=T4lJ7IfchIx8O9WvBI06w6cJ9APqPZYrqfcn3GERTnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i9kuF89ldU0b1uMh3vMccYfMUpaz3W1vZn1wwiXEZTgBtDuDh7QZCKIlx5BCCu4Z2
	 RFir5VLFXA9imk7oK0V/i1q7OGqEvsGd1UI0deRqedVHXc9a34nrNB0CMA3XXEtzBW
	 aOTxcyh+eE3AqQOcE66QQby60yMccydVdqtGBps2Xwa2vsHjkDYxG9jwaiJu2gHImJ
	 dztPSn8gNNS3SM3jdvnAA53lxAO6COWG1aA3en5UTk/V4SYsukxIzb3nrm7BZDNSj0
	 IRKPMnGfg0ZxbB2qo6TZv6Fg+syBlOV5QDM79wrAJgtZ4AEsUi9/X94edNtJ4+1Qcy
	 1gMu1pQXGmRcg==
Date: Tue, 8 Jul 2025 17:44:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ssantosh@kernel.org, richardcochran@gmail.com, s.hauer@pengutronix.de,
 m-karicheri2@ti.com, glaroque@baylibre.com, afd@ti.com,
 saikrishnag@marvell.com, m-malladi@ti.com, jacob.e.keller@intel.com,
 diogo.ivo@siemens.com, javier.carrasco.cruz@gmail.com, horms@kernel.org,
 s-anna@ti.com, basharath@couthit.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev, pratheesh@ti.com,
 prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v10 02/11] net: ti: prueth: Adds ICSSM Ethernet
 driver
Message-ID: <20250708174449.3e8744c5@kernel.org>
In-Reply-To: <20250702140633.1612269-3-parvathi@couthit.com>
References: <20250702140633.1612269-1-parvathi@couthit.com>
	<20250702140633.1612269-3-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 19:36:24 +0530 Parvathi Pudi wrote:
> +		if (ret < 0) {
> +			dev_err(dev, "%pOF error reading port_id %d\n",
> +				eth_node, ret);
> +		}

unnecessary parenthesis, but also did you mean to error out here?

> +			dev_err(dev, "port reg should be 0 or 1\n");
> +			of_node_put(eth_node);

this error will also trigger if same port is specified multiple times

+			ret = PTR_ERR(prueth->pru1);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "unable to get PRU1: %d\n", ret);
+			goto put_pru;

dev_err_probe() ?

> +/**
> + * struct prueth_private_data - PRU Ethernet private data
> + * @fw_pru: firmware names to be used for PRUSS ethernet usecases
> + * @support_lre: boolean to indicate if lre is enabled
> + * @support_switch: boolean to indicate if switch is enabled

Please improve or remove this, adding kdoc which doesn't explain
anything is discouraged per kernel coding style.

This one is actually more confusing than helpful the fields are
called "support" but kdoc says "enabled". Maybe name the fields
'enabled' ?

> + */
> +struct prueth_private_data {
> +	const struct prueth_firmware fw_pru[PRUSS_NUM_PRUS];
> +	bool support_lre;
> +	bool support_switch;
> +};
> +
> +/* data for each emac port */
> +struct prueth_emac {
> +	struct prueth *prueth;
> +	struct net_device *ndev;
> +
> +	struct rproc *pru;
> +	struct phy_device *phydev;
> +
> +	int link;
> +	int speed;
> +	int duplex;
> +
> +	enum prueth_port port_id;
> +	const char *phy_id;
> +	u8 mac_addr[6];
> +	phy_interface_t phy_if;
> +	spinlock_t lock;	/* serialize access */

'serialize access' to what? Which fields does it protect?
-- 
pw-bot: cr

