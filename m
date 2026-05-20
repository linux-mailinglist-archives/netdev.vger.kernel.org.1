Return-Path: <netdev+bounces-290138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNAjEmpJDmqZ9gUAu9opvQ
	(envelope-from <netdev+bounces-290138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:53:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 500B859CF9F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00C8D305B15E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F59F3D6CA5;
	Wed, 20 May 2026 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P95ok930"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322513CFF5D;
	Wed, 20 May 2026 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320679; cv=none; b=I3KqJGkSL1AsGztvj8bJRj+no4E7GGACMkoIeAkG0Fc5DDQzWAowJ165PxbE6JT88J+iF15U1vjNqTC6frIw3vlJXwYfD0TuEtGVQSIxeaIV948k5VOsZKOsE15A/LojFL8pcJgjtaalb4JrCIe7zBmXNAMIHaLs1GpsHOc2O28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320679; c=relaxed/simple;
	bh=aje9XEuUNJjqw7H1SodHsl0ciXq/rE2V1ROFgfW0N7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Szsheic8Ys1OGMXPuZV80IBnSoYK25tNso03a7+8SmrwMh20uVoH7c75TD3EOXSnx6S8RxqAqXdIN72ppBuPnjO65hlZ5Hrxe48JuNI1PHjMCXf25BDbESesUoTdiBO/WT69TYmuSo6brMUrCPN0meW+w9ZzCyBUyo7BpL6OSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P95ok930; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9151F000E9;
	Wed, 20 May 2026 23:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779320677;
	bh=SMGmAnaqqMFwZ/ms8bS1jE0mRxGhgL4+qrx5hR290rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P95ok930jk2rxBkIkSWPylzXui1iEWk0FwtTxb5mqSa1+u3YQxLMM9FSCgq0z18VM
	 VBJ/tUlEURhMhws/d9wQB3VqaUI4YUju9fqnosw5OU5w1jXC8VnCTPpeurx2cofxjD
	 EcIoEwn4avgPctdsUjBDVNODbWCaKWAjxQfO0vqhrY1Ja1ggpgU/DzvIdNUOCvjYuW
	 deNW6z5WstCbbfeAiIDm+1GPuxpQelUvG8l82wwmx2ewFmlbwFEiByjbQ/8PlvBE7M
	 E+IejAcq7jqMWu65f6WIPvx2vYfLwYYEuOwMQ1NIUaYajqnfbfX6ln/Q+ydL7p8cln
	 EtTiSuWCTyiMw==
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
Subject: Re: [PATCH net-next v2 5/6] pds_core: add host backed memory support for firmware
Date: Wed, 20 May 2026 16:44:35 -0700
Message-ID: <20260520234435.567124-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516-upstream_v2_clean-v2-5-7e0d66bf4020@amd.com>
References: <20260516-upstream_v2_clean-v2-5-7e0d66bf4020@amd.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290138-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 500B859CF9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
pds_core: add host backed memory support for firmware

This patch adds support for the firmware to use host-backed DMA memory
on AMD/Pensando cards with minimal on-card memory. A new set of adminq
opcodes (MEM_GET_COUNT, MEM_QUERY, MEM_ADD, MEM_DEL) coordinate the
allocation, mapping, and teardown of these regions.

> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index 705cab7b0727..215242430b10 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -487,6 +487,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
>  		pdsc->viftype_status = NULL;
>  	}
>  
> +	pdsc_host_mem_free(pdsc);
>  	pdsc_dev_uninit(pdsc);

[High]

Can pdsc_host_mem_free() unmap and free pages while firmware DMA is
still in flight?

pdsc_teardown() runs pdsc_devcmd_reset() earlier, but that command can
itself time out when the firmware is hung, and even on success the PCI
device remains bus-master enabled (pci_disable_device() runs much later
in pdsc_remove(), and pdsc_dev_uninit() only frees IRQ vectors).

Unlike the adminq/notifyq descriptor rings, host-mem buffers are used
asynchronously by firmware for control-plane data, so the exposure
window is much wider. If firmware did not actually halt DMA, can it
continue writing into pages that have already been returned to the page
allocator?

Would it be safer to issue MEM_DEL and verify firmware quiescence (for
example via pci_disable_device() or pcie_flr()) before unmapping and
freeing the pages?

>  
>  	set_bit(PDSC_S_FW_DEAD, &pdsc->state);
> @@ -496,6 +497,7 @@ int pdsc_start(struct pdsc *pdsc)
>  {
>  	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
>  			   PDS_CORE_INTR_MASK_CLEAR);
> +	pdsc_host_mem_add(pdsc);
>  
>  	return 0;
>  }

[High]

Does this introduce a self-deadlock on pdsc->wq during firmware
recovery?

pdsc_start() is invoked on the recovery path from
pdsc_health_thread() -> pdsc_fw_up() -> pdsc_setup() -> pdsc_start().
pdsc_health_thread runs on pdsc->wq, which is created via
create_singlethread_workqueue() (max_active=1).

pdsc_host_mem_add() then posts adminq commands via pdsc_adminq_post(),
which calls wait_for_completion_timeout(). The completion is signaled
only by pdsc_work_thread()/pdsc_process_adminq(), which is queued by
pdsc_adminq_isr() onto the same pdsc->wq:

	queue_work(pdsc->wq, &qcq->work);

Because the wq's only worker is busy running pdsc_health_thread, the
qcq->work item cannot be dispatched, the completion never fires, and
every adminq command (MEM_GET_COUNT, MEM_QUERY, MEM_ADD) times out
after devcmd_timeout.

On top of that, pdsc_adminq_post() does:

	if (err == -ENXIO || err == -ETIMEDOUT)
		queue_work(pdsc->wq, &pdsc->health_work);

which re-queues the currently running work on the same wq.

[Medium]

Could ignoring the result of pdsc_host_mem_add() be a problem?

> @@ -496,6 +497,7 @@ int pdsc_start(struct pdsc *pdsc)
>  {
>  	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
>  			   PDS_CORE_INTR_MASK_CLEAR);
> +	pdsc_host_mem_add(pdsc);
>  
>  	return 0;
>  }

pdsc_host_mem_add() returns void and pdsc_start() always returns 0.
Inside pdsc_host_mem_add() the kzalloc_objs() failure path and the
inner add-loop simply return/break:

	pdsc->host_mem_reqs = kzalloc_objs(*pdsc->host_mem_reqs, count,
					   GFP_KERNEL);
	if (!pdsc->host_mem_reqs) {
		dev_err(pdsc->dev, "failed to alloc host_mem_reqs array\n");
		return;
	}

	for (i = 0; i < count; i++) {
		err = pdsc_host_mem_add_one(pdsc, i);
		if (err)
			break;
	}

The commit message says the firmware needs this memory for control-plane
components, but the driver provides no mechanism to refuse bring-up or
tell firmware "I gave you fewer regions than you requested". Should the
final count be communicated, or should bring-up fail?

Also, count from MEM_GET_COUNT is an le16 (up to 65535), and only
per-region size is sanity-checked. Should there be an aggregate cap as
well?

> @@ -658,3 +660,168 @@ void pdsc_health_thread(struct work_struct *work)
[ ... ]
> +static int pdsc_host_mem_add_one(struct pdsc *pdsc, int index)
> +{
[ ... ]
> +	hm->pa = dma_map_page(pdsc->dev, hm->pg, 0, hm->size,
> +			      DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(pdsc->dev, hm->pa)) {
> +		dev_err(pdsc->dev, "dma map failed for tag %d size %d\n",
> +			hm->tag, hm->size);
> +		__free_pages(hm->pg, hm->order);
> +		hm->pg = NULL;
> +		err = -EIO;
> +		goto err_del;
> +	}
> +
> +	/* Track this allocation so pdsc_host_mem_free() can clean it up */
> +	pdsc->num_host_mem_reqs++;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	memset(&comp, 0, sizeof(comp));
> +	cmd.mem_add.opcode = PDS_AQ_CMD_MEM_ADD;
> +	cmd.mem_add.tag = cpu_to_le16(hm->tag);
> +	cmd.mem_add.size = cpu_to_le32(hm->size);
> +	cmd.mem_add.buf_pa = cpu_to_le64(hm->pa);
> +
> +	dev_dbg(pdsc->dev, "Sending aq cmd for mem add tag %d size %d pa %pad\n",
> +		hm->tag, hm->size, &hm->pa);
> +	err = pdsc_adminq_post(pdsc, &cmd, &comp, false);
> +	if (err || comp.status != PDS_RC_SUCCESS) {
> +		dev_err(pdsc->dev, "mem add failed err %d status %d for tag %d\n",
> +			err, comp.status, hm->tag);
> +		err = err ? err : -EIO;
> +		goto err_del;
> +	}

[Medium]

Can MEM_DEL be sent twice for the same tag here?

num_host_mem_reqs++ runs after dma_map_page() succeeds but before
MEM_ADD is posted. If MEM_ADD then fails, the err_del label calls
pdsc_host_mem_del_one(pdsc, hm->tag, PDS_RC_ENOMEM) immediately, but
the entry is still counted in num_host_mem_reqs.

Later, pdsc_host_mem_del() iterates by num_host_mem_reqs and calls
pdsc_host_mem_del_one() again with the same tag:

	for (i = 0; i < pdsc->num_host_mem_reqs; i++)
		pdsc_host_mem_del_one(pdsc, pdsc->host_mem_reqs[i].tag,
				      PDS_RC_SUCCESS);

The dma_mapping_error() path correctly avoids this by jumping to
err_del before incrementing num_host_mem_reqs, which makes the two
failure paths inconsistent.

[Low]

Is num_host_mem_reqs intended to track "pages to dma_unmap+free" or
"tags to send MEM_DEL for"?

The comment says:

	/* Track this allocation so pdsc_host_mem_free() can clean it up */
	pdsc->num_host_mem_reqs++;

but the same counter also drives pdsc_host_mem_del()'s MEM_DEL loop.
Those have different lifetimes: a successfully mapped page must always
be freed, but MEM_DEL should only be sent for entries whose MEM_ADD was
acknowledged. Correctness here depends on the exact placement of the
increment between dma_map_page() success and MEM_ADD posting. Would
per-entry booleans (mapped, added) make the lifecycle clearer and less
fragile to future edits?

> +
> +void pdsc_host_mem_add(struct pdsc *pdsc)
> +{
[ ... ]
> +	if (!(pdsc->dev_ident.capabilities &
> +	     cpu_to_le64(PDS_CORE_DEV_CAP_HOST_MEM)))
> +		return;
> +
> +	cmd.mem_get_count.opcode = PDS_AQ_CMD_MEM_GET_COUNT;
> +	cmd.mem_get_count.max_contig = cpu_to_le32(PDSC_HOST_MEM_MAX_CONTIG);

[Low]

Does baking PDSC_HOST_MEM_MAX_CONTIG into the firmware ABI cause
problems across kernel builds?

PDSC_HOST_MEM_MAX_CONTIG is defined as:

	#define PDSC_HOST_MEM_MAX_CONTIG ((PAGE_SIZE) << (MAX_PAGE_ORDER))

MAX_PAGE_ORDER varies by architecture and CONFIG_ARCH_FORCE_MAX_ORDER,
so the same firmware will see different "maximum contiguous size"
values depending on which kernel build is loaded. The driver then tries
to satisfy each request with bare:

	hm->pg = alloc_pages(GFP_KERNEL | __GFP_ZERO, hm->order);

which is unreliable for high-order allocations on a fragmented running
system. pdsc_host_mem_add() runs both at probe and on firmware
recovery, where fragmentation is likely.

Also, PDSC_HOST_MEM_MAX_CONTIG is unsigned long while
mem_get_count.max_contig is __le32. On configurations where
(PAGE_SIZE << MAX_PAGE_ORDER) >= 4 GiB, cpu_to_le32() silently
truncates without any BUILD_BUG_ON guarding it. Would advertising a
fixed conservative size, with a compile-time size check, be more
robust?

> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 22db78343eb0..58b4d77f6eca 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -434,7 +436,8 @@ static void pdsc_remove(struct pci_dev *pdev)
>  		pdsc_sriov_configure(pdev, 0);
>  		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>  
> -		timer_shutdown_sync(&pdsc->wdtimer);
> +		pdsc_stop_health_thread(pdsc);
> +		pdsc_host_mem_del(pdsc);
>  		if (pdsc->wq)
>  			destroy_workqueue(pdsc->wq);

[Medium]

Can health_work be re-queued after it has been cancelled here?

The new ordering is:

	pdsc_stop_health_thread(pdsc);  /* cancels health_work */
	pdsc_host_mem_del(pdsc);        /* posts MEM_DEL adminq cmds */
	if (pdsc->wq)
		destroy_workqueue(pdsc->wq);

pdsc_adminq_post() does:

	if (err == -ENXIO || err == -ETIMEDOUT)
		queue_work(pdsc->wq, &pdsc->health_work);

If pdsc_host_mem_del()'s MEM_DEL adminq posts time out (firmware
partially hung), health_work is re-queued and then drained by
destroy_workqueue(). At that point PDSC_S_STOPPING_DRIVER is not yet
set (it is set later, inside config_lock, after destroy_workqueue
returns), so pdsc_health_thread() runs the full health check, sees FW
dead, and dispatches pdsc_fw_down() -> pdsc_stop() +
pdsc_teardown(RECOVERY).

Then the main thread proceeds to call pdsc_stop() +
pdsc_teardown(REMOVING) again. Some inner cleanups are idempotent, but
pci_free_irq_vectors() in pdsc_dev_uninit() is not gated by an
idempotency guard.

Would setting PDSC_S_STOPPING_DRIVER before pdsc_host_mem_del(), or
calling cancel_work_sync() once more after pdsc_host_mem_del(), close
this window?

