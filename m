Return-Path: <netdev+bounces-229583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CC9BDE8B3
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 873964ED5FD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53A1C9DE5;
	Wed, 15 Oct 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8o3nVis"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B3218E1F;
	Wed, 15 Oct 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532751; cv=none; b=Y9DtKpVPZOeQqaBoGkHySl2nf4WldhwH22RY/78gV5bwZ3b9ndO9L7U4riJEits6TKrfXLO96dA2lro2LeWDwkf4CayLCfY8WauagcGJeg10Sp7Nnc9v7iVYUjKAsR55feQYH9CUjTimDAtdtEE3zA185earlPi87aKfXffy7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532751; c=relaxed/simple;
	bh=4DK8NsHpOSDw78JlpzEJiBRJK0MDuJa00sse3sDOyDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIYJAZsDW55PwXwnU5mM8pNzxKd0+j6USYrNjqDwG96Qz9sW4NlDNJEGKMQXGGbFphD/DfyocsBBK3CK8UiJkeP4isw3ILO3O7xh2h82HIQ4I4CqMW44vZd0saWydW3+Dk/Ozni0YQ/V64NjiEFRLmIV7De5wImWR9n12y88SNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8o3nVis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F712C4CEF8;
	Wed, 15 Oct 2025 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760532750;
	bh=4DK8NsHpOSDw78JlpzEJiBRJK0MDuJa00sse3sDOyDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t8o3nVisN7MqQBJeLDOFcbTRf67htnjR8DcPwRhAq4aev4tsHgIkoMlwuWCeCa59R
	 jlqIcNRknLKlRb10gzt5joFkL1eEy7qb+mt/Q3pSm6LISI5M1QcmNxEwCRuQhkjFVy
	 GjM39Goe0J/dWh2Lj3mWdO8BnpWZB64sG2Dhtmlcf+AtuYFim9Tm5oXfgMHB3oJU4G
	 a0cGFDrFaJdrgVy5ES42Knl7f2I61yFf6tVgGI5i1bD8NaBUtayoom8W8zWj5doLaW
	 9hWYFmzDkaKeDlv5b3NJmcOqRRuKGz2S8nNWATw5VeH3PKNyK2f7GDL6cTTEwJFi4G
	 zEuQ9KR/cNgKw==
Date: Wed, 15 Oct 2025 13:52:26 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 03/12] net: airoha: Add
 airoha_ppe_get_num_stats_entries() and
 airoha_ppe_get_num_total_stats_entries()
Message-ID: <aO-ZCqsvPQ6Pqjpg@horms.kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-3-064855f05923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-an7583-eth-support-v1-3-064855f05923@kernel.org>

On Wed, Oct 15, 2025 at 09:15:03AM +0200, Lorenzo Bianconi wrote:
> Introduce airoha_ppe_get_num_stats_entries and
> airoha_ppe_get_num_total_stats_entries routines in order to make the
> code more readable controlling if CONFIG_NET_AIROHA_FLOW_STATS is
> enabled or disabled.
> Modify airoha_ppe_foe_get_flow_stats_index routine signature relying on
> airoha_ppe_get_num_total_stats_entries().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.h |  10 +--
>  drivers/net/ethernet/airoha/airoha_ppe.c | 103 +++++++++++++++++++++++++------
>  2 files changed, 86 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> index 4330b672d99e1e190efa5ad75d13fb35e77d070e..1f7e34a5f457ca2200e9c81dd05dc03cd7c5eb77 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -50,15 +50,9 @@
>  
>  #define PPE_NUM				2
>  #define PPE1_SRAM_NUM_ENTRIES		(8 * 1024)
> -#define PPE_SRAM_NUM_ENTRIES		(2 * PPE1_SRAM_NUM_ENTRIES)
> -#ifdef CONFIG_NET_AIROHA_FLOW_STATS
> +#define PPE_SRAM_NUM_ENTRIES		(PPE_NUM * PPE1_SRAM_NUM_ENTRIES)
>  #define PPE1_STATS_NUM_ENTRIES		(4 * 1024)
> -#else
> -#define PPE1_STATS_NUM_ENTRIES		0
> -#endif /* CONFIG_NET_AIROHA_FLOW_STATS */
> -#define PPE_STATS_NUM_ENTRIES		(2 * PPE1_STATS_NUM_ENTRIES)
> -#define PPE1_SRAM_NUM_DATA_ENTRIES	(PPE1_SRAM_NUM_ENTRIES - PPE1_STATS_NUM_ENTRIES)
> -#define PPE_SRAM_NUM_DATA_ENTRIES	(2 * PPE1_SRAM_NUM_DATA_ENTRIES)
> +#define PPE_STATS_NUM_ENTRIES		(PPE_NUM * PPE1_STATS_NUM_ENTRIES)
>  #define PPE_DRAM_NUM_ENTRIES		(16 * 1024)
>  #define PPE_NUM_ENTRIES			(PPE_SRAM_NUM_ENTRIES + PPE_DRAM_NUM_ENTRIES)
>  #define PPE_HASH_MASK			(PPE_NUM_ENTRIES - 1)
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
> index 8d1dceadce0becb2b1ce656d64ab77bd3c2f914a..303d31e1da4b723023ee0cc1ca5f6038c16966cd 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -32,6 +32,30 @@ static const struct rhashtable_params airoha_l2_flow_table_params = {
>  	.automatic_shrinking = true,
>  };
>  
> +static int airoha_ppe_get_num_stats_entries(struct airoha_ppe *ppe,
> +					    u32 *num_stats)
> +{
> +#ifdef CONFIG_NET_AIROHA_FLOW_STATS
> +	*num_stats = PPE1_STATS_NUM_ENTRIES;
> +	return 0;
> +#else
> +	return -EOPNOTSUPP;
> +#endif /* CONFIG_NET_AIROHA_FLOW_STATS */
> +}

Hi Lorenzo,

I think that in general using IS_ENABLED is preferred over #ifdef
in cases where the former can be used. For one thing it improves compile
coverage.

That does seem applicable here, so I'm wondering if
we can do something like the following.
(Compile tested only!)

static int airoha_ppe_get_num_stats_entries(struct airoha_ppe *ppe,
                                            u32 *num_stats)
{
        if (!IS_ENABLED(CONFIG_NET_AIROHA_FLOW_STATS))
                return -EOPNOTSUPP;

        *num_stats = PPE1_STATS_NUM_ENTRIES;
        return 0;
}

Also, very subjectively, I might have returned num_stats as
a positive return value. I'm assuming it's value will never overflow an int.
Likewise elsewhere.

But that's just my idea. Feel free to stick with the current scheme.

...

