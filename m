Return-Path: <netdev+bounces-290139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QChsDbpJDmoM9gUAu9opvQ
	(envelope-from <netdev+bounces-290139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F15659CFCE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 473AE30604A5
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAEF3D88F1;
	Wed, 20 May 2026 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRLpSTji"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A973D5647;
	Wed, 20 May 2026 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320680; cv=none; b=u0S9EL2elOfogyKR79FeaaDNOyz9bjAkKz6f64Omo7OxTv5KtnpOK0FhaZ+4et4Oy+fOuPyDX2aSk9vvWBWYkSCKREklj+vNqqcga15MwfXzGctR8H5rTbQrXgfm4SEhH0+2FL46bFmet4ma71I/HRrZm6OTKTgwM501R9nEG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320680; c=relaxed/simple;
	bh=ZMRzyAmE/yzg4+0E9u6xce0ReYUWNfyNiVI/OREpeVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXlXHp/6JirM7bDQDro8R3a7+KQzpsf7CO2yXbGXyWy7SHeyezlLEWZzRAcN1a5h0xPwwdbi8tE2OzVYDWGm++0+ytSvl7W9ykf2rDWcw3em7rK91ef4DWBiWYb17IMyLm6vOkhS3be8agQnD+ay+i9H7W8hqXUXZAM2SY0hMNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRLpSTji; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052E71F00A39;
	Wed, 20 May 2026 23:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779320678;
	bh=Y+HcjhdK5Ccx+Qwqnotk+/XYbwyNomlc9/tacwbIlQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fRLpSTjiOkQVs7qRjO3IZt3ZnFC3BL/8LWJgu8xFpVv9yV+8tSd/ZIn6Gb99J3ShV
	 +Vm6FDqDQwcGhgAEETlNV4ZVB73mZr1BZy+wKkaCLL1x4yemNbdGQPGZnluIQQnQbY
	 3FZJHAHFtuJf/Y7fZpos+34TdwjDRYOIAnTnxaLqRGh//letbWrG4tBiIWYmzM3vB1
	 YHjBKjtjH9G4EgDgipW5IMXQdPY5c0omkjn57ehIMnb+Ucr39HnnSrq5wLmlypZq7y
	 0dqZBPw44glO4/BtQ1XLqP+MsH+/EQ/b3d5EyquK8fohxaL0J6wSnJllNu4aJ+F1qY
	 ElI4oz/BmontA==
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
Subject: Re: [PATCH net-next v2 6/6] pds_core: add debugfs support for host backed memory
Date: Wed, 20 May 2026 16:44:37 -0700
Message-ID: <20260520234437.567156-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516-upstream_v2_clean-v2-6-7e0d66bf4020@amd.com>
References: <20260516-upstream_v2_clean-v2-6-7e0d66bf4020@amd.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290139-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 3F15659CFCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
pds_core: add debugfs support for host backed memory

This adds a debugfs file (host_mem) under the pds_core device directory
that displays the tag, size, order, and physical address of each host
memory request tracked in pdsc->host_mem_reqs.

> diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
> index 04c5e3abd8d7..058071f6f17e 100644
> --- a/drivers/net/ethernet/amd/pds_core/debugfs.c
> +++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
> @@ -173,3 +173,53 @@ void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq)
>  	debugfs_remove_recursive(qcq->dentry);
>  	qcq->dentry = NULL;
>  }
> +
> +static int host_mem_show(struct seq_file *seq, void *v)
> +{
> +	struct pdsc *pdsc = seq->private;
> +	struct pdsc_host_mem *hm;
> +	int i;
> +
> +	if (!pdsc->host_mem_reqs || pdsc->num_host_mem_reqs == 0) {
> +		seq_puts(seq, "No host memory allocated\n");
> +		return 0;
> +	}

[High]
Can host_mem_show() race with pdsc_host_mem_free() and end up
dereferencing freed memory?

The reader takes no lock, but the writers in pdsc_host_mem_add() and
pdsc_host_mem_free() are serialized by pdsc->config_lock and run from
pdsc_fw_down()/pdsc_fw_up() during PCI reset_prepare/reset_done, AER
recovery, and the watchdog-triggered pdsc_health_thread workqueue.
pdsc_teardown() ultimately calls pdsc_host_mem_free(), which kfree()s
host_mem_reqs and sets the pointer to NULL.

The initial check is also TOCTOU:

    if (!pdsc->host_mem_reqs || pdsc->num_host_mem_reqs == 0) {

After this passes, host_mem_reqs can be freed and nulled before the
loop body dereferences &pdsc->host_mem_reqs[i].

Could this be addressed by holding pdsc->config_lock around the
iteration, by removing the host_mem dentry from pdsc_fw_down() /
pdsc_teardown() before pdsc_host_mem_free(), or by switching the
array to RCU?

> +
> +	seq_printf(seq, "Host memory requests: %d\n\n",
> +		   pdsc->num_host_mem_reqs);
> +	seq_puts(seq, "Tag    Size         Order  PA\n");
> +	seq_puts(seq, "---    ----         -----  --\n");
> +
> +	for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
> +		hm = &pdsc->host_mem_reqs[i];
> +
> +		if (!hm->pg)
> +			continue;
> +
> +		seq_printf(seq, "%-6d %-12u %-6d 0x%llx\n",
> +			   hm->tag, hm->size, hm->order,
> +			   (unsigned long long)hm->pa);

[Low, Low]
hm->tag is u16 and hm->order is u8, but they are printed with the
signed %-6d specifier while hm->size (u32) uses %-12u. Should the
unsigned types use %u here as well?

Also, the canonical format specifier for dma_addr_t is %pad. Could
hm->pa be printed with &hm->pa and %pad rather than cast to unsigned
long long with 0x%llx?

> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(host_mem);
> +
> +void pdsc_debugfs_add_host_mem(struct pdsc *pdsc)
> +{
> +	struct dentry *dentry;
> +
> +	if (!(pdsc->dev_ident.capabilities &
> +	     cpu_to_le64(PDS_CORE_DEV_CAP_HOST_MEM)))
> +		return;
> +
> +	/* Check if file already exists (e.g., during reset recovery) */
> +	dentry = debugfs_lookup("host_mem", pdsc->dentry);
> +	if (!IS_ERR_OR_NULL(dentry)) {
> +		dput(dentry);
> +		return;
> +	}
> +
> +	debugfs_create_file("host_mem", 0400, pdsc->dentry,
> +			    pdsc, &host_mem_fops);
> +}

[Low]
Is the comment "Check if file already exists (e.g., during reset
recovery)" accurate here?

pdsc_debugfs_add_host_mem() is only called from pdsc_init_pf(), which
is itself only called from pdsc_probe(). The reset and recovery paths
go pdsc_fw_up() -> pdsc_setup() -> pdsc_start() -> pdsc_host_mem_add()
and never re-invoke pdsc_debugfs_add_host_mem().

By contrast, pdsc_debugfs_add_ident() is genuinely called during
recovery via pdsc_dev_init() from pdsc_setup(), so the same idiom
there is meaningful.

Should the dead defensive branch be dropped, or was the intent to
also wire pdsc_debugfs_add_host_mem() into the recovery path so the
file reflects the post-recovery host_mem_reqs array?

> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 58b4d77f6eca..aa7b5ce6f623 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -266,6 +266,8 @@ static int pdsc_init_pf(struct pdsc *pdsc)
>  
>  	mutex_unlock(&pdsc->config_lock);
>  
> +	pdsc_debugfs_add_host_mem(pdsc);
> +
>  	err = pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL, &pdsc->padev);
>  	if (err)
>  		goto err_out_stop;

