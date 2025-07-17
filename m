Return-Path: <netdev+bounces-207862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B084CB08D1E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D971C26299
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D5F2C3262;
	Thu, 17 Jul 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEAYLjaE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED32BDC0E;
	Thu, 17 Jul 2025 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755901; cv=none; b=feY6fOgPtTsyQBiu9Nc3u2Fvfk6GLn3zeb3U5cXwFreYzaAeuf3Lke7AUWzaAITg8qiC04i22JDWBj6E58WDETT9kGciXxGUi3oOF18Tw7KZnYPpORHXo0Z3rhOHdhnd1LDdfhqc6O+bJMaA3jsWP5vQwoGT03H3UTob01vOweU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755901; c=relaxed/simple;
	bh=LPwayIMS3ZhlEmO2Jrd9H9wbN9BAgZSee8cnCpTCIY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC5iCpMMp/t93WSPXOnHxXaFWkXjf/sadiAAuuvoAXa1WjJOFu3cLCUhHz/CNwmYQFcDhmcNa2rf2/OqwWoCQgs8o9n+tNOPWpLm8zEUptDtcn0XeimlojbzqFW5Ock3N+ChzAYh8+YarEzzCb6mJ2kNTTKPYIl6+8w9cEWHnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEAYLjaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B07C4CEE3;
	Thu, 17 Jul 2025 12:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752755900;
	bh=LPwayIMS3ZhlEmO2Jrd9H9wbN9BAgZSee8cnCpTCIY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEAYLjaEhgLewWG2t7FYvrEXz7i9TGePJFqqwxk4OF3Nv+6mzaZSVE1QcWY4Qk2iB
	 IbyxguNn6hRtLt3WNEjDFuKUkTKqTZeTNCRIvdiZNmYaMaIyg/2/5a4PLBezHClk6E
	 6NsGtG8l3Rr96uWo8END0Z0gj9MD3cKsgylNP2hbNBR2mdNnQuzu5qGhYl7UxJx2DW
	 JnO9nA+S7Y+LAeog39ffid6m0K7Sp4/yKlLR0mWFS/mkp8Mu3CHXVEHdA+00FvH210
	 r/E4aqYUsisGOzK9rh5uXtB8TjGAgvpE2x/z6YKm8FLMpCbswxYjhurkXNvan9ldPU
	 /5BFZ6rNq6ACA==
Date: Thu, 17 Jul 2025 13:38:15 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, bbhushan2@marvell.com
Subject: Re: [net-next 4/4] Octeontx2-af: Debugfs support for firmware data
Message-ID: <20250717123815.GE27043@horms.kernel.org>
References: <20250716164158.1537269-1-hkelam@marvell.com>
 <20250716164158.1537269-5-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716164158.1537269-5-hkelam@marvell.com>

On Wed, Jul 16, 2025 at 10:11:58PM +0530, Hariprasad Kelam wrote:
> MAC address, Link modes (supported and advertised) and eeprom data
> for the Netdev interface are read from the shared firmware data.
> This patch adds debugfs support for the same.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   7 +-
>  .../marvell/octeontx2/af/rvu_debugfs.c        | 148 ++++++++++++++++++
>  2 files changed, 154 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 0bc0dc79868b..933073cd2280 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -664,7 +664,12 @@ struct cgx_lmac_fwdata_s {
>  	/* Only applicable if SFP/QSFP slot is present */
>  	struct sfp_eeprom_s sfp_eeprom;
>  	struct phy_s phy;
> -#define LMAC_FWDATA_RESERVED_MEM 1021
> +	u32 lmac_type;
> +	u32 portm_idx;
> +	u64 mgmt_port:1;
> +	u64 advertised_an:1;
> +	u64 port;
> +#define LMAC_FWDATA_RESERVED_MEM 1018
>  	u64 reserved[LMAC_FWDATA_RESERVED_MEM];
>  };
>  
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index 0c20642f81b9..900bd1ae240d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -867,6 +867,65 @@ static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
>  
>  RVU_DEBUG_SEQ_FOPS(rvu_pf_cgx_map, rvu_pf_cgx_map_display, NULL);
>  
> +static int rvu_dbg_rvu_fwdata_display(struct seq_file *s, void *unused)
> +{
> +	struct rvu *rvu = s->private;
> +	struct rvu_fwdata *fwdata;
> +	u8 mac[ETH_ALEN];
> +	int count = 0, i;
> +
> +	if (!rvu->fwdata)
> +		return -EAGAIN;
> +
> +	fwdata = rvu->fwdata;
> +	seq_puts(s, "\nRVU Firmware Data:\n");
> +	seq_puts(s, "\n\t\tPTP INFORMATION\n");
> +	seq_puts(s, "\t\t===============\n");
> +	seq_printf(s, "\t\texternal clockrate \t :%x\n", fwdata->ptp_ext_clk_rate);

Please line wrap to 80 columns wide or less.
Likewise elsewhere in this patch.

> +	seq_printf(s, "\t\texternal timestamp \t :%x\n", fwdata->ptp_ext_tstamp);
> +	seq_puts(s, "\n");
> +
> +	seq_puts(s, "\n\t\tSDP CHANNEL INFORMATION\n");
> +	seq_puts(s, "\t\t=======================\n");
> +	seq_printf(s, "\t\tValid \t\t\t :%x\n", fwdata->channel_data.valid);
> +	seq_printf(s, "\t\tNode ID \t\t :%x\n", fwdata->channel_data.info.node_id);
> +	seq_printf(s, "\t\tNumner of VFs  \t\t :%x\n", fwdata->channel_data.info.max_vfs);
> +	seq_printf(s, "\t\tNumber of PF-Rings \t :%x\n", fwdata->channel_data.info.num_pf_rings);
> +	seq_printf(s, "\t\tPF SRN \t\t\t :%x\n", fwdata->channel_data.info.pf_srn);
> +	seq_puts(s, "\n");

...

-- 
pw-bot: changes-requested

