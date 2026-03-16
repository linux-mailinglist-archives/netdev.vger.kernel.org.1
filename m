Return-Path: <netdev+bounces-268277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJPrKzFwuGn5dgEAu9opvQ
	(envelope-from <netdev+bounces-268277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:03:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 240E62A0826
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51DB730AA158
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C923D35C1A6;
	Mon, 16 Mar 2026 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFEVXzfs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657130BF4F;
	Mon, 16 Mar 2026 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694757; cv=none; b=mjs0VtR7LP0x2T49g/2IbY1IqppJDkOpBGzPW3nSapLZu8ZWQEsyQ/nVYaerPLC8nVRUqxJbT0hcEzvAEUQ1Y79DddJ7mIbSp5ciCBeD0yxXVEXHgoR5uCZy1FLYlPQJSUso1wHyI+uhvqpEpjkkPbfDv2cZjCCDoNxZs5+FYeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694757; c=relaxed/simple;
	bh=OmDOMlVBBy6YetFqHSZ7R4cjd4+2Jdw8ISAECi+XxFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+8fqWitsq2LHdVgBNMtxkRCmrZdGwwUyw9O5LMlQupJc9diiRQIj5LFybAb+3XGhjLP2BJsPsAzk7E6SQpCJDLL00kT6WVWNQMOuvW12qX1eoveA9ZDBSoqScKFnI3P4Hl4nOc9qmEGAhR483MUxRJb8l3PbYg3bR0zumFKPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFEVXzfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D892DC19421;
	Mon, 16 Mar 2026 20:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773694757;
	bh=OmDOMlVBBy6YetFqHSZ7R4cjd4+2Jdw8ISAECi+XxFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RFEVXzfs0t6Vpib9Q7Emee0DitRl3sYSa4e0rbL6T7tqRCBghIBEyCpClfVjtP/04
	 v5jgyARu8hDaZ8Dn+tC97+cHXzVyhziAfY4/ONkdfZT2VAgBlJdzsVeWxEy0XPUJgd
	 RscF8LHAQjthyLgkinOBuBSxzQsotVUAltC2G8gIQ5phDHqzI/Pniwrwl4DOfMn24W
	 X8vk/dNEGUpb4pp9I9ueg75RzWisOp1O+qoKS1MUU6mUDMXqNtG3zYfzU8a/caG/4c
	 uOZ33aVBcrPFtF8PmdleFNf+SX+UuarSAfNAS0XL4X9vKZRcIUQpqFDDy7Mift4Z3R
	 ct+I9Q9KuIzHg==
Date: Mon, 16 Mar 2026 13:59:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bcmgenet: enable EEE TX LPI by default
Message-ID: <20260316135915.28c64ec8@kernel.org>
In-Reply-To: <997daf22-260b-40c4-a2d6-8c63f59df9a7@broadcom.com>
References: <20260303160225.542613-1-nb@tipi-net.de>
	<997daf22-260b-40c4-a2d6-8c63f59df9a7@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[tipi-net.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,broadcom.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268277-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 240E62A0826
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 12:54:46 -0700 Florian Fainelli wrote:
> On 3/3/26 08:02, Nicolai Buchwitz wrote:
> > GENET never initializes priv->eee.eee_enabled or
> > priv->eee.tx_lpi_enabled to true, so the link-change callback in
> > bcmgenet_mac_config() always calls bcmgenet_eee_enable_set() with
> > enable=false.  The result is that EEE is negotiated at the PHY level
> > but the MAC never enters Low Power Idle, wasting the power savings
> > that EEE is designed to provide.
> > 
> > Users can work around this with 'ethtool --set-eee eth0 eee on tx-lpi
> > on tx-timer 250', but the MAC should enable TX LPI out of the box when
> > the hardware supports it, consistent with how phylink-managed MACs
> > behave (phylink calls phy_support_eee() which sets eee_enabled=true and
> > tx_lpi_enabled=true by default).
> > 
> > Initialize EEE software state during bcmgenet_open() on GENET v2+ so
> > that the link-change path activates EEE in hardware once the PHY
> > negotiates it.  Use an LPI timer of 250 us, matching the default used
> > by other MAC drivers (mvneta, mvpp2).
> > 
> > Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>  
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

FWIW this patch is set to Changes Requested, I _think_ based on this
reply from Andrew:

https://lore.kernel.org/all/d352039f-4cbb-41e6-9aeb-0b4f3941b54c@lunn.ch/

LMK if the patch is good as is.

