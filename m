Return-Path: <netdev+bounces-241200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 690A9C8174E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC481346896
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1121314D0D;
	Mon, 24 Nov 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDco8JXJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D9314B8F;
	Mon, 24 Nov 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999930; cv=none; b=NvmeCjTonjDe9aO5NsSjeR7TNP/jx3m1cVNhzviVaXrsMb7QDw6UaUj64eVbT5Acgwykvsi1X6V249DB0YciMDcVnbZppV+D1F9BW0wxZjllnxVBTfr/3lH8u2jD65Sre92l6QXH0wxgtSGsC4hHHt2LdDxzE5buTkhHCuTH0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999930; c=relaxed/simple;
	bh=odaw98tLYaCUbAIdX4IxkB2qfVzFQovODqA1R+4730c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAFoVOAhc3/HBAQz3OetueyJHNDiIKL7mC3c3IrU8oKwtEAdwr+ED77Nd00bQUKDVJ10KNA1PNyAjyAkJjdP92dNHsOmsXMSVeBCOQwhf6lJ0FFpB3zoiqx1KelPpMoYaBTIQI2BaTOmw7fEQ/qVyQNBKIPUIbhCQVj/3j1B3+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDco8JXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B584C4CEF1;
	Mon, 24 Nov 2025 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763999930;
	bh=odaw98tLYaCUbAIdX4IxkB2qfVzFQovODqA1R+4730c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDco8JXJ7CkDOZhXm/bom6HqdsYsXSLvvSJQV1RM+TKa7W7yK4nwBxSkw0RVko/vD
	 /BDQ9IKD4G7N68c/bpxDAG/awR5wHsd4RdBEBXz3zv+E0Kggp3a+IjUEEc1z3xg4Ep
	 wd8Oo2m32JBU9XAyTKofqOiSCdIx1TtspXTYtuLPcF+O23/db1dNuVyLl9QAGD6Ouk
	 yHazasXFskKAGS8J/gJ6mnGy1XWi5Mj3LUvmehJryrjuuoKz4+0vLNNpJnzIJq63De
	 9GZxqkfwS232ky/9kzwAvfw4KJBMCAsDRr2RqQHATrQmRJLfMCBQNPeZPJ9NQ1b+//
	 fD9tcBGZozS8Q==
Date: Mon, 24 Nov 2025 15:58:45 +0000
From: Simon Horman <horms@kernel.org>
To: Vimlesh Kumar <vimleshk@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sedara@marvell.com, srasheed@marvell.com, hgani@marvell.com,
	Veerasenareddy Burru <vburru@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] octeon_ep: reset firmware ready status
Message-ID: <aSSAtY6C8QyRoW42@horms.kernel.org>
References: <20251120112345.649021-1-vimleshk@marvell.com>
 <20251120112345.649021-2-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120112345.649021-2-vimleshk@marvell.com>

On Thu, Nov 20, 2025 at 11:23:44AM +0000, Vimlesh Kumar wrote:
> Add support to reset firmware ready status
> when the driver is removed(either in unload
> or unbind)
> 
> Signed-off-by: Sathesh Edara <sedara@marvell.com>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>

I'm a little confused about the asymmetry of the cn9k and cnxk code
before this patch. Maybe it would make sense to split this
into two patches, one for cn9k and cnxk with more specific
commit messages.

And for both cn9k and cnxk, I'm unclear on the what the behaviour was
before this patch? IOW, is this a bug fix for either of both of xn9k and
cnkx?

> ---
>  .../marvell/octeon_ep/octep_cn9k_pf.c         | 22 +++++++++++++++++++
>  .../marvell/octeon_ep/octep_cnxk_pf.c         |  2 +-
>  .../marvell/octeon_ep/octep_regs_cn9k_pf.h    | 11 ++++++++++
>  .../marvell/octeon_ep/octep_regs_cnxk_pf.h    |  1 +
>  4 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> index b5805969404f..6f926e82c17c 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> @@ -637,6 +637,17 @@ static int octep_soft_reset_cn93_pf(struct octep_device *oct)
>  
>  	octep_write_csr64(oct, CN93_SDP_WIN_WR_MASK_REG, 0xFF);
>  
> +	/* Firmware status CSR is supposed to be cleared by
> +	 * core domain reset, but due to a hw bug, it is not.
> +	 * Set it to RUNNING right before reset so that it is not
> +	 * left in READY (1) state after a reset.  This is required
> +	 * in addition to the early setting to handle the case where
> +	 * the OcteonTX is unexpectedly reset, reboots, and then
> +	 * the module is removed.
> +	 */
> +	OCTEP_PCI_WIN_WRITE(oct, CN9K_PEMX_PFX_CSX_PFCFGX(0, 0, CN9K_PCIEEP_VSECST_CTL),
> +			    FW_STATUS_DOWNING);
> +

There seems to be some inconsistency between the comment,
which describes setting the status to RUNNING, and the code,
which sets the status to DOWNING.

Flagged by Claude Code with https://github.com/masoncl/review-prompts/

>  	/* Set core domain reset bit */
>  	OCTEP_PCI_WIN_WRITE(oct, CN93_RST_CORE_DOMAIN_W1S, 1);
>  	/* Wait for 100ms as Octeon resets. */
> @@ -894,4 +905,15 @@ void octep_device_setup_cn93_pf(struct octep_device *oct)
>  
>  	octep_init_config_cn93_pf(oct);
>  	octep_configure_ring_mapping_cn93_pf(oct);
> +
> +	if (oct->chip_id == OCTEP_PCI_DEVICE_ID_CN98_PF)
> +		return;
> +
> +	/* Firmware status CSR is supposed to be cleared by
> +	 * core domain reset, but due to IPBUPEM-38842, it is not.
> +	 * Set it to RUNNING early in boot, so that unexpected resets
> +	 * leave it in a state that is not READY (1).
> +	 */
> +	OCTEP_PCI_WIN_WRITE(oct, CN9K_PEMX_PFX_CSX_PFCFGX(0, 0, CN9K_PCIEEP_VSECST_CTL),
> +			    FW_STATUS_RUNNING);
>  }
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
> index 5de0b5ecbc5f..e07264b3dbf8 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
> @@ -660,7 +660,7 @@ static int octep_soft_reset_cnxk_pf(struct octep_device *oct)
>  	 * the module is removed.
>  	 */
>  	OCTEP_PCI_WIN_WRITE(oct, CNXK_PEMX_PFX_CSX_PFCFGX(0, 0, CNXK_PCIEEP_VSECST_CTL),
> -			    FW_STATUS_RUNNING);
> +			    FW_STATUS_DOWNING);

Likewise here.

>  
>  	/* Set chip domain reset bit */
>  	OCTEP_PCI_WIN_WRITE(oct, CNXK_RST_CHIP_DOMAIN_W1S, 1);
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
> index ca473502d7a0..d7fa5adbce98 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
> @@ -383,6 +383,17 @@
>  /* bit 1 for firmware heartbeat interrupt */
>  #define CN93_SDP_EPF_OEI_RINT_DATA_BIT_HBEAT	BIT_ULL(1)
>  
> +#define FW_STATUS_DOWNING      0ULL
> +#define FW_STATUS_RUNNING      2ULL
> +#define CN9K_PEMX_PFX_CSX_PFCFGX(pem, pf, offset)      ((0x8e0000008000 | (uint64_t)(pem) << 36 \
> +							| (pf) << 18 \
> +							| (((offset) >> 16) & 1) << 16 \
> +							| ((offset) >> 3) << 3) \
> +							+ ((((offset) >> 2) & 1) << 2))

I realise that this implementation mirrors that in octep_regs_cnxk_pf.h,
but I do think it would be better rexpressed in terms of FIELD_PREP(),
GETMASK_ULL, and BIT_ULL. With #defines so the masks (and bits are named).

Also, as the above duplicates what is present in octep_regs_cnxk_pf.h,
maybe it would be nice to share it somehow.

> +
> +/* Register defines for use with CN9K_PEMX_PFX_CSX_PFCFGX */
> +#define CN9K_PCIEEP_VSECST_CTL  0x4D0
> +
>  #define CN93_PEM_BAR4_INDEX            7
>  #define CN93_PEM_BAR4_INDEX_SIZE       0x400000ULL
>  #define CN93_PEM_BAR4_INDEX_OFFSET     (CN93_PEM_BAR4_INDEX * CN93_PEM_BAR4_INDEX_SIZE)
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
> index e637d7c8224d..a6b6c9f356de 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
> @@ -396,6 +396,7 @@
>  #define CNXK_SDP_EPF_OEI_RINT_DATA_BIT_MBOX	BIT_ULL(0)
>  /* bit 1 for firmware heartbeat interrupt */
>  #define CNXK_SDP_EPF_OEI_RINT_DATA_BIT_HBEAT	BIT_ULL(1)
> +#define FW_STATUS_DOWNING      0ULL
>  #define FW_STATUS_RUNNING      2ULL
>  #define CNXK_PEMX_PFX_CSX_PFCFGX(pem, pf, offset)      ({ typeof(offset) _off = (offset); \
>  							  ((0x8e0000008000 | \
> -- 
> 2.34.1
> 
> 

