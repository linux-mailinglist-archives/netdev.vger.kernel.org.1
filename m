Return-Path: <netdev+bounces-290136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLbGAXRHDmoM9gUAu9opvQ
	(envelope-from <netdev+bounces-290136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:44:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFA659CE20
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D1DD301065B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5D43D0905;
	Wed, 20 May 2026 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bqqt8qVo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C17C3CF66A;
	Wed, 20 May 2026 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320677; cv=none; b=jj0pzBsNOR6D/V0ZNVe8yyjsBhr0TV2M/dZs9l2rb7XDwhlVIrps/zrynLB7g5JvmtKR0WGmuIkQ8s2J7v/6jnAVPL3LHNMBILnMa8d3Ucjk82IPLevHu8FJKwdPBVL5v9N0IsLKn+vA7n4Of0wpNjFDE3JS+fsO6ufPQSixV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320677; c=relaxed/simple;
	bh=u3pZjarmjdrQ0OZ25teuGgndOEYLq0VLewqn93yp5Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2fNVrDyvJUUT4JYtbrt2oRFAKSKjpe5aHJ0z25+v+1y8mdSaHrGWMDvXj2QA61t1lOO9Q3p4NkAQJRLuLlyEWGGrR80Vrrf+fn5oBwGdHwJoUdLpFnpr/KoxVoOY7lqmoKeht838uB3Gd/kGvzmmZN7GNantkEs5LebwjB9FOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bqqt8qVo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53B21F00A39;
	Wed, 20 May 2026 23:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779320674;
	bh=9Z0oYdIHdBSPIjHT41CL5TQAjfl8+CVhjLktPrK/rAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bqqt8qVorDy/cgx+/OnGNrP9mY6mgN2laZ1LZoc6FDyT8oR16OQF0GlmskR03zjKr
	 9bJnu49NVQz8qVGRS94p1f423m+Nez7fLD+PSpSbfxLsMkXxkoYRDvAoeosdtWu857
	 CO48zRQMn9JfCcRJ+rkGPUxx5metUxxuGDJMxYUeXJhEt1cg94AI5LNGCuFq5uJ+Eb
	 oZS8boPyxGj8Bl3js6g6woVubu2wcp8Wqo53Ml9lDrMm/tYYjlXmId1RnF7ua8alQI
	 YkrBEyUIJwI2tEvd0wmu3Cn5C4D4se/9YoKEaJmkLDy2foJDFaqD2lvOBI1rzBfpwt
	 YOvdxK9TfZXkw==
From: Jakub Kicinski <kuba@kernel.org>
To: nikhil.rao@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eric.joyner@amd.com,
	Vamsi.Atluri@amd.com
Subject: Re: [PATCH net-next v2 3/6] pds_core: add PLDM firmware update support via devlink flash
Date: Wed, 20 May 2026 16:44:32 -0700
Message-ID: <20260520234432.567056-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516-upstream_v2_clean-v2-3-7e0d66bf4020@amd.com>
References: <20260516-upstream_v2_clean-v2-3-7e0d66bf4020@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290136-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9BFA659CE20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
pds_core: add PLDM firmware update support via devlink flash

This adds PLDM firmware update support to pds_core via the upstream
pldmfw API, allowing flashing of entire packages or individual
components through devlink dev flash.

> diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
> index fa626719e68d..f091a753bce9 100644
> --- a/drivers/net/ethernet/amd/pds_core/fw.c
> +++ b/drivers/net/ethernet/amd/pds_core/fw.c

[ ... ]

> +int pdsc_get_component_info(struct pdsc *pdsc)
> +{
> +	union pds_core_dev_cmd cmd = {
> +		.get_component_info.opcode = PDS_CORE_CMD_GET_COMPONENT_INFO,
> +		.get_component_info.ver = 1,
> +	};
> +	struct pds_core_component_list_info *list_info;
> +	union pds_core_dev_comp comp = {};
> +	dma_addr_t dma_addr;
> +	u8 num_components;
> +	int err, i;
> +
> +	list_info = kzalloc(PDS_PAGE_SIZE, GFP_KERNEL);
> +	if (!list_info)
> +		return -ENOMEM;
> +
> +	dma_addr = dma_map_single(pdsc->dev, list_info, PDS_PAGE_SIZE,
> +				  DMA_FROM_DEVICE);
> +	if (dma_mapping_error(pdsc->dev, dma_addr)) {
> +		dev_err(pdsc->dev,
> +			"Failed to dma_map component_list_info length %d\n",
> +			PDS_PAGE_SIZE);
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	cmd.get_component_info.data_len = cpu_to_le16(PDS_PAGE_SIZE);
> +	cmd.get_component_info.data_pa = cpu_to_le64(dma_addr);
> +
> +	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout * 2);
> +	dma_unmap_single(pdsc->dev, dma_addr, PDS_PAGE_SIZE, DMA_FROM_DEVICE);
> +	if (err)
> +		goto out;
> +
> +	if (comp.get_component_info.ver == 0) {
> +		/* Don't support backward compatibility as version 0 has
> +		 * alignment issues, so give a hint to users to update
> +		 * their firmware
> +		 */
> +		dev_warn(pdsc->dev,
> +			 "Incompatible get_component_info version %u reported by firmware\n",
> +			 comp.get_component_info.ver);
> +		err = 0;
> +		goto out;
> +	}

[Medium]
The comment states version 0 is not supported because of alignment
issues, but the code sets err = 0 and falls through with
pdsc->fw_components.num_components left at zero.

The caller pdsc_pldm_firmware_update() treats err == 0 as success and
calls pldmfw_flash_image() with no cached components, which leads to
a few user-visible side effects:

  - When a user passes a specific component, pdsc_get_slot_id() iterates
    an empty fw_components array and returns PDS_CORE_FW_SLOT_MAX, which
    bubbles up as -ENOENT from pdsc_send_component_table() rather than a
    "firmware too old" indication.

  - For a full-image flash, pdsc_set_component_name() finds no matches,
    so devlink_flash_update_status_notify() ends up reporting empty
    component strings throughout the flash.

  - pdsc_pldm_firmware_update() resets num_components = 0 at the end of
    every flash, so the dev_warn and the same downstream paths recur on
    every subsequent attempt.

Should this path return an error such as -EOPNOTSUPP so the documented
intent matches what callers see?

[ ... ]

> +static int pdsc_devcmd_send_component(struct pdsc *pdsc,
> +				      struct pds_core_flash_component *info,
> +				      u16 info_sz, dma_addr_t addr, u32 length,
> +				      u32 offset, u16 slot_id,
> +				      union pds_core_dev_comp *comp)
> +{
> +	union pds_core_dev_cmd cmd = {
> +		.send_component.opcode = PDS_CORE_CMD_SEND_COMPONENT,
> +		.send_component.ver = 1,
> +		.send_component.operation = PDS_CORE_SEND_COMPONENT_START,
> +		.send_component.data_pa = cpu_to_le64(addr),
> +		.send_component.data_len = cpu_to_le32(length),
> +		.send_component.offset = cpu_to_le32(offset),
> +		.send_component.slot_id = slot_id,
> +	};
> +	unsigned long timeout = 300 * HZ;
> +	unsigned long start_time;
> +	unsigned long end_time;
> +	int err;
> +
> +	start_time = jiffies;
> +	end_time = start_time + timeout;
> +	do {
> +		/* prevent noisy/benign devcmd failures */
> +		err = pdsc_devcmd_with_data_nomsg(pdsc, &cmd, info, info_sz,
> +						  comp, 60);
> +		if (err != -EAGAIN)
> +			break;
> +
> +		/* if required, subsequent commands check status of
> +		 * PDS_CORE_CMD_SEND_COMPONENT command, which returns
> +		 * EAGAIN while the command is still running,
> +		 * else we get the final command status.
> +		 */
> +		cmd.send_component.operation = PDS_CORE_SEND_COMPONENT_STATUS;
> +		msleep(20);
> +	} while (time_before(jiffies, end_time));
> +
> +	if (err == -EAGAIN || err == -ETIMEDOUT)
> +		dev_err(pdsc->dev, "PDS_CORE_CMD_SEND_COMPONENT timed out\n");
> +
> +	return err;
> +}

[ ... ]

> +static int pdsc_flash_component(struct pldmfw *context,
> +				struct pldmfw_component *component)
> +{

[ ... ]

> +		err = pdsc_devcmd_send_component(pdsc, component_info, info_sz,
> +						 dma_addr, copy_sz, offset,
> +						 slot_id, &comp);
> +		dma_unmap_single(dev, dma_addr, copy_sz, DMA_TO_DEVICE);
> +		kfree(component_data);

[High]
On the -EAGAIN or -ETIMEDOUT exit from pdsc_devcmd_send_component(),
can the device still be DMA-reading from this buffer when the unmap
and kfree happen here?

The polling loop in pdsc_devcmd_send_component() runs up to 300 seconds
and the only exits when the device is still busy are -EAGAIN (the
status query explicitly says START has not completed) or -ETIMEDOUT.
No abort or cancel opcode is issued, and the wire format documented
for struct pds_core_send_component_cmd hands data_pa to the device on
the START call.

Looking at __pdsc_devcmd_locked() in pds_core/dev.c:

    if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
            queue_work(pdsc->wq, &pdsc->health_work);

-EAGAIN does not even trigger health_work, so the device is not
treated as hung in that case.

Once control returns to pdsc_flash_component():

    err = pdsc_devcmd_send_component(...);
    dma_unmap_single(dev, dma_addr, copy_sz, DMA_TO_DEVICE);
    kfree(component_data);

If the firmware finishes the flash a moment later and reads from
data_pa, on IOMMU systems the unmap can race the DMA and produce
IOMMU faults; on non-IOMMU systems the device can DMA-read from
freed slab memory belonging to a later allocation.

Should this path leak the buffer, reset the device, or send an abort
opcode to the firmware before unmapping and freeing on the busy
timeout exits?

[ ... ]

