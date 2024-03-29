Return-Path: <netdev+bounces-83418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9634B892352
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C421C2123F
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C1C137903;
	Fri, 29 Mar 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq5sy/8o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9E1369A7
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736900; cv=none; b=hrs2qbnPgGBW3gfXilrFbfWS7Jf/eggy2GYy9B3QASVOHxZJFiy0ltWwEOe4B0Zf3Jxl2PCD0c1ogJ0vkKkhDGoDKiJW5SbNm9nrU7s5q6QEbuqch74RYqsXi9uiZCEnuLd6hGr2ASipvrTrfKUwodPbprFzIIKQF+wUTy0HB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736900; c=relaxed/simple;
	bh=aaTxx/gxFQ4PytepyKlYYbI3sL2CzQNsV3HkRrmNumU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4qJGj7a6nny8pq6TItSHnRADnK4EX6y9CP8Y1XUie/ORqmujKQQbCaYaf3a1rUAbcOGj8dY/l8RF599Hjn2aUvcZUpjHr0NFH6kMGDRx3HCYX1Y++DAsB/QfT7BIP+UTeisc/fxZXTC88SeP72OkKKHP1bluW+dqxvyZvlNYes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq5sy/8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D404C433C7;
	Fri, 29 Mar 2024 18:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711736899;
	bh=aaTxx/gxFQ4PytepyKlYYbI3sL2CzQNsV3HkRrmNumU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hq5sy/8oIsmtqsHP7KbybzBi1Q46Xnl+aOvV1MHAc7FGXfsGFvU7DlecZ4+kcivV3
	 yt3Kmk7xRQWxyiXiAqfqh6yRFlxXsCe6gTDnVKaP9Xdja2G0MRp+qxt5tYBRjVuyTQ
	 5s9f+xHvK5WWRho5/HtV51ZKwhMov0PWoVwt4k7yusk9CmnGlud+j8YKeJ3AOskuUj
	 5McCtrihxIEH8E6zN9LtAyMibiPlCIWt82cITUwiDYW++J//beyGAxvJxMrhhK4p8Q
	 agc22RiosSfMwOs9OqB3mSpu10eCJ2AV/8DyjOEZA/HSRVQSqqzgzeAqOedJxj1iUb
	 HNmmGAOEpTyhw==
Date: Fri, 29 Mar 2024 18:28:16 +0000
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-next v1 1/5] ixgbe: Add support for E610 FW Admin
 Command Interface
Message-ID: <20240329182816.GP651713@kernel.org>
References: <20240327155422.25424-1-piotr.kwapulinski@intel.com>
 <20240327155422.25424-2-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327155422.25424-2-piotr.kwapulinski@intel.com>

On Wed, Mar 27, 2024 at 04:54:18PM +0100, Piotr Kwapulinski wrote:
> Add low level support for Admin Command Interface (ACI). ACI is the
> Firmware interface used by a driver to communicate with E610 adapter. Add
> the following ACI features:
> - data structures, macros, register definitions
> - commands handling
> - events handling
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/Makefile     |    4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  505 ++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   19 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   71 +-
>  .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1063 +++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   15 +
>  6 files changed, 1671 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>  create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
>  create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
>  create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/Makefile b/drivers/net/ethernet/intel/ixgbe/Makefile
> index 4fb0d9e..e0444ae 100644
> --- a/drivers/net/ethernet/intel/ixgbe/Makefile
> +++ b/drivers/net/ethernet/intel/ixgbe/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 1999 - 2018 Intel Corporation.
> +# Copyright(c) 1999 - 2024 Intel Corporation.
>  #
>  # Makefile for the Intel(R) 10GbE PCI Express ethernet driver
>  #
> @@ -9,7 +9,7 @@ obj-$(CONFIG_IXGBE) += ixgbe.o
>  ixgbe-objs := ixgbe_main.o ixgbe_common.o ixgbe_ethtool.o \
>                ixgbe_82599.o ixgbe_82598.o ixgbe_phy.o ixgbe_sriov.o \
>                ixgbe_mbx.o ixgbe_x540.o ixgbe_x550.o ixgbe_lib.o ixgbe_ptp.o \
> -              ixgbe_xsk.o
> +              ixgbe_xsk.o ixgbe_e610.o
>  
>  ixgbe-$(CONFIG_IXGBE_DCB) +=  ixgbe_dcb.o ixgbe_dcb_82598.o \
>                                ixgbe_dcb_82599.o ixgbe_dcb_nl.o
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c

...

> +/**
> + * ixgbe_aci_send_cmd_execute - execute sending FW Admin Command to FW Admin
> + * Command Interface
> + * @hw: pointer to the HW struct
> + * @desc: descriptor describing the command
> + * @buf: buffer to use for indirect commands (NULL for direct commands)
> + * @buf_size: size of buffer for indirect commands (0 for direct commands)
> + *
> + * Admin Command is sent using CSR by setting descriptor and buffer in specific
> + * registers.
> + *
> + * Return: the exit code of the operation.
> + * * - 0 - success.
> + * * - -EIO - CSR mechanism is not enabled.
> + * * - -EBUSY - CSR mechanism is busy.
> + * * - -EINVAL - buf_size is too big or
> + * invalid argument buf or buf_size.
> + * * - -ETIME - Admin Command X command timeout.
> + * * - -EIO - Admin Command X invalid state of HICR register or
> + * Admin Command failed because of bad opcode was returned or
> + * Admin Command failed with error Y.
> + */
> +static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
> +				      struct ixgbe_aci_desc *desc,
> +				      void *buf, u16 buf_size)
> +{
> +	u32 *tmp_buf __free(kfree) = NULL;
> +	u32 *raw_desc = (u32 *)desc;
> +	u32 hicr, i, tmp_buf_size;
> +	bool valid_buf = false;
> +	u16 opcode;
> +
> +	hw->aci.last_status = IXGBE_ACI_RC_OK;
> +
> +	/* It's necessary to check if mechanism is enabled */
> +	hicr = IXGBE_READ_REG(hw, IXGBE_PF_HICR);
> +
> +	if (!(hicr & IXGBE_PF_HICR_EN))
> +		return -EIO;
> +
> +	if (hicr & IXGBE_PF_HICR_C)
> +		return -EBUSY;
> +
> +	opcode = desc->opcode;

The type of opcode is u16, host byte order.
But the type of desc->opcode is __le16, little endien.
This does not seem right.

Flagged by Sparse.

There are a number of problems flagged by Sparse in this patch-set.
Please make sure the patchset is Sparse-clean..

> +
> +	if (buf_size > IXGBE_ACI_MAX_BUFFER_SIZE)
> +		return -EINVAL;
> +
> +	if (buf)
> +		desc->flags |= cpu_to_le16(IXGBE_ACI_FLAG_BUF);
> +
> +	if (desc->flags & cpu_to_le16(IXGBE_ACI_FLAG_BUF)) {
> +		if ((buf && !buf_size) ||
> +		    (!buf && buf_size))
> +			return -EINVAL;
> +		if (buf && buf_size)
> +			valid_buf = true;
> +	}
> +
> +	if (valid_buf) {
> +		if (buf_size % 4 == 0)
> +			tmp_buf_size = buf_size;
> +		else
> +			/* Allow aligned PF_HIBA access */
> +			tmp_buf_size = (buf_size & (u16)(~0x03)) + 4;
> +
> +		tmp_buf = kmalloc(tmp_buf_size, GFP_KERNEL);
> +		if (!tmp_buf)
> +			return -ENOMEM;
> +
> +		/* tmp_buf will be firstly filled with 0xFF and after
> +		 * that the content of buf will be written into it.
> +		 * This approach lets us use valid buf_size and
> +		 * prevents us from reading past buf area
> +		 * when buf_size mod 4 not equal to 0.
> +		 */
> +		memset(tmp_buf, 0xFF, tmp_buf_size);
> +		memcpy(tmp_buf, buf, buf_size);
> +
> +		if (tmp_buf_size > IXGBE_ACI_LG_BUF)
> +			desc->flags |= cpu_to_le16(IXGBE_ACI_FLAG_LB);
> +
> +		desc->datalen = cpu_to_le16(buf_size);
> +
> +		if (desc->flags & cpu_to_le16(IXGBE_ACI_FLAG_RD))
> +			for (i = 0; i < tmp_buf_size / 4; i++)
> +				IXGBE_WRITE_REG(hw, IXGBE_PF_HIBA(i),
> +						le32_to_cpu(tmp_buf[i]));
> +	}
> +
> +	/* Descriptor is written to specific registers */
> +	for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
> +		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i),
> +				le32_to_cpu(raw_desc[i]));
> +
> +	/* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
> +	 * PF_HICR_EV
> +	 */
> +	hicr = (IXGBE_READ_REG(hw, IXGBE_PF_HICR) | IXGBE_PF_HICR_C) &
> +	       ~(IXGBE_PF_HICR_SV | IXGBE_PF_HICR_EV);
> +	IXGBE_WRITE_REG(hw, IXGBE_PF_HICR, hicr);
> +
> +#define MAX_SLEEP_RESP_US 1000
> +#define MAX_TMOUT_RESP_SYNC_US 100000000
> +
> +	/* Wait for sync Admin Command response */
> +	read_poll_timeout(IXGBE_READ_REG, hicr,
> +			  (hicr & IXGBE_PF_HICR_SV) ||
> +			  !(hicr & IXGBE_PF_HICR_C),
> +			  MAX_SLEEP_RESP_US, MAX_TMOUT_RESP_SYNC_US, true, hw,
> +			  IXGBE_PF_HICR);
> +
> +#define MAX_TMOUT_RESP_ASYNC_US 150000000
> +
> +	/* Wait for async Admin Command response */
> +	read_poll_timeout(IXGBE_READ_REG, hicr,
> +			  (hicr & IXGBE_PF_HICR_EV) ||
> +			  !(hicr & IXGBE_PF_HICR_C),
> +			  MAX_SLEEP_RESP_US, MAX_TMOUT_RESP_ASYNC_US, true, hw,
> +			  IXGBE_PF_HICR);
> +
> +	/* Read sync Admin Command response */
> +	if ((hicr & IXGBE_PF_HICR_SV)) {
> +		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> +			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> +			raw_desc[i] = cpu_to_le32(raw_desc[i]);
> +		}
> +	}
> +
> +	/* Read async Admin Command response */
> +	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
> +		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> +			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> +			raw_desc[i] = cpu_to_le32(raw_desc[i]);
> +		}
> +	}
> +
> +	/* Handle timeout and invalid state of HICR register */
> +	if (hicr & IXGBE_PF_HICR_C)
> +		return -ETIME;
> +
> +	if (!(hicr & IXGBE_PF_HICR_SV) && !(hicr & IXGBE_PF_HICR_EV))
> +		return -EIO;
> +
> +	/* For every command other than 0x0014 treat opcode mismatch
> +	 * as an error. Response to 0x0014 command read from HIDA_2
> +	 * is a descriptor of an event which is expected to contain
> +	 * different opcode than the command.
> +	 */
> +	if (desc->opcode != opcode &&
> +	    opcode != cpu_to_le16(ixgbe_aci_opc_get_fw_event))
> +		return -EIO;
> +
> +	if (desc->retval) {
> +		hw->aci.last_status = (enum ixgbe_aci_err)desc->retval;
> +		return -EIO;
> +	}
> +
> +	/* Write a response values to a buf */
> +	if (valid_buf) {
> +		for (i = 0; i < tmp_buf_size / 4; i++) {
> +			tmp_buf[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIBA(i));
> +			tmp_buf[i] = cpu_to_le32(tmp_buf[i]);
> +		}
> +		memcpy(buf, tmp_buf, buf_size);
> +	}
> +
> +	return 0;
> +}

...

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h

...

> +/**
> + * struct ixgbe_aq_desc - Admin Command (AC) descriptor

nit: ixgbe_aci_desc

     ./scripts/kernel-doc -none is your friend here

> + * @flags: IXGBE_ACI_FLAG_* flags
> + * @opcode: Admin command opcode
> + * @datalen: length in bytes of indirect/external data buffer
> + * @retval: return value from firmware
> + * @cookie_high: opaque data high-half
> + * @cookie_low: opaque data low-half
> + * @params: command-specific parameters
> + *
> + * Descriptor format for commands the driver posts via the
> + * Admin Command Interface (ACI).
> + * The firmware writes back onto the command descriptor and returns
> + * the result of the command. Asynchronous events that are not an immediate
> + * result of the command are written to the Admin Command Interface (ACI) using
> + * the same descriptor format. Descriptors are in little-endian notation with
> + * 32-bit words.
> + */
> +struct ixgbe_aci_desc {
> +	__le16 flags;
> +	__le16 opcode;
> +	__le16 datalen;
> +	__le16 retval;
> +	__le32 cookie_high;
> +	__le32 cookie_low;
> +	union {
> +		u8 raw[16];
> +		struct ixgbe_aci_cmd_get_ver get_ver;
> +		struct ixgbe_aci_cmd_driver_ver driver_ver;
> +		struct ixgbe_aci_cmd_get_exp_err exp_err;
> +		struct ixgbe_aci_cmd_req_res res_owner;
> +		struct ixgbe_aci_cmd_list_caps get_cap;
> +		struct ixgbe_aci_cmd_disable_rxen disable_rxen;
> +		struct ixgbe_aci_cmd_get_phy_caps get_phy;
> +		struct ixgbe_aci_cmd_set_phy_cfg set_phy;
> +		struct ixgbe_aci_cmd_restart_an restart_an;
> +		struct ixgbe_aci_cmd_get_link_status get_link_status;
> +		struct ixgbe_aci_cmd_set_event_mask set_event_mask;
> +		struct ixgbe_aci_cmd_get_link_topo get_link_topo;
> +		struct ixgbe_aci_cmd_get_link_topo_pin get_link_topo_pin;
> +		struct ixgbe_aci_cmd_sff_eeprom read_write_sff_param;
> +		struct ixgbe_aci_cmd_nvm nvm;
> +		struct ixgbe_aci_cmd_nvm_checksum nvm_checksum;
> +	} params;
> +};

...

