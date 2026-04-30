Return-Path: <netdev+bounces-283020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMsVNk7q82kV8wEAu9opvQ
	(envelope-from <netdev+bounces-283020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:48:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 528AA4A8F30
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 982693046243
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C4D3DA7F8;
	Thu, 30 Apr 2026 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="husW4Mm2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031373D9DB3;
	Thu, 30 Apr 2026 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592877; cv=none; b=Deyr5DBaLmYufhpvCqXJgR/4gURmegJLsKc+lH8FnOjTzvRIPPzbUd2MobxjGABHmy6okXzc9H8iaBlD/X3+Aseo1ItN7/SIRYkCgZbZKOlGr2pGXiXMHdng7sy5/nMNv0rj1QPL+zHpTXHNKdEt0zcd4/M3T7j5H+inXj1frqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592877; c=relaxed/simple;
	bh=KzItX7D0DETnI7kvK48l6Sd22H/WVKXoB+vV9TlwaKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpl87zNN7GQ8p+D38mW3RPCvt21nbkYWp6LAbT2wMVzjL3p0il5skDChoPoHpAGZg5YUXbCe+/Y18MNjoKhz9xI26mJalB1B2wNK4wu9Q3j9tH/srhaF0B/wiBVfcoRrI7jgSjywyUTfaQY0AJjkn3SsTHHdjYUvySPgEds+oGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=husW4Mm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAA0C2BCB8;
	Thu, 30 Apr 2026 23:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777592876;
	bh=KzItX7D0DETnI7kvK48l6Sd22H/WVKXoB+vV9TlwaKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=husW4Mm2LO1Kkij+2ogpVzVO/QupBqQbJ6krzE9mW3TuyUsDnHwdgaSqJfcZuvu8r
	 8HW3dWH3phaTi5AmcgVCvcQrPcCivv0BLY9nXxsym1/uj+VYAXeHBN/uw0lkRKVB9b
	 NOe7iyfRXs4rWHqP8wCWdtACBnkj3MTie54+Y4Ks7WvSlDJde3lQ2jnYWHVhaKvGMr
	 as+SO/eXks5ksAr+4j1zJHZLIi2Dq+GoGXrT0P6lrl/ZBbCLJN0jn3DmPM1Mzsm1u3
	 zpLKQWVvQT3Md+FI5yYNjql83sV6xoDIkc7UEPe1FtOOTt/njpdXEZSWKvZk7mFN9J
	 P3HudVKWOR/wQ==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 net-next 11/11] net/nebula-matrix: add common dev start/stop operation
Date: Thu, 30 Apr 2026 16:47:52 -0700
Message-ID: <20260430234754.3074773-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428114910.2616-12-illusion.wang@nebula-matrix.com>
References: <20260428114910.2616-12-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 528AA4A8F30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283020-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: add common dev start/stop operation

This commit adds start/stop operations for the common device: it
configures the MSI-X map table, allocates and enables MSI-X vectors,
registers the mailbox ISR and enables the mailbox IRQ. It also switches
the module from module_pci_driver() to explicit init/exit that creates
and destroys a workqueue around pci_register_driver().

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index f10bb9460774..e814ffbb978d 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> +static int nbl_dev_request_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +	struct nbl_common_info *common = dev_mgt->common;
> +	u16 local_vec_id;
> +	u32 irq_num;
> +	int err;
> +
> +	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
> +		return 0;
> +
> +	local_vec_id =
> +		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
> +	irq_num = pci_irq_vector(common->pdev, local_vec_id);

Can the return value of pci_irq_vector() be handled here?  It is
declared as:

    int pci_irq_vector(struct pci_dev *dev, unsigned int nr);

and can return a negative errno (for example -EINVAL, including the
CONFIG_PCI=n stub).  The value is stored into a u32 irq_num and passed
directly to request_irq() without a range check, so a negative return
would be silently converted into a very large positive number.

Would declaring irq_num as int and testing for irq_num < 0 before
calling request_irq() be more appropriate?

> +
> +	snprintf(dev_common->mailbox_name, sizeof(dev_common->mailbox_name),
> +		 "nbl_mailbox@pci:%s", pci_name(common->pdev));
> +	err = request_irq(irq_num, nbl_dev_clean_mailbox, 0,
> +			  dev_common->mailbox_name, dev_mgt);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static void nbl_dev_free_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +	struct nbl_common_info *common = dev_mgt->common;
> +	u16 local_vec_id;
> +	u32 irq_num;
> +
> +	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
> +		return;
> +
> +	local_vec_id =
> +		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
> +	irq_num = pci_irq_vector(common->pdev, local_vec_id);

Same question as above: pci_irq_vector() can return a negative errno,
and irq_num is a u32.  Should this be validated before calling
free_irq()?

> +
> +	free_irq(irq_num, dev_mgt);
> +}

[ ... ]

> +static int nbl_dev_disable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +	u16 local_vec_id;
> +
> +	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
> +		return 0;
> +
> +	flush_work(&dev_common->clean_mbx_task);
> +	local_vec_id =
> +		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
> +	chan_ops->set_queue_state(dev_mgt->chan_ops_tbl->priv,
> +				  NBL_CHAN_INTERRUPT_READY,
> +				  NBL_CHAN_TYPE_MAILBOX, false);
> +
> +	return disp_ops->enable_mailbox_irq(dev_mgt->disp_ops_tbl->priv,
> +					    local_vec_id, false);
> +}

Is the teardown sequence here in the right order?

flush_work() runs first, but the hardware interrupt source is still
live (set_queue_state(..., false) and enable_mailbox_irq(..., false)
happen after the flush), and free_irq() is not called until the
separate nbl_dev_free_mailbox_irq() step in nbl_dev_stop() (and in the
enable_mailbox_irq_err unwind of nbl_dev_start()).

Between flush_work() returning and the hardware disable step, the
mailbox MSI-X can still fire:

    static irqreturn_t nbl_dev_clean_mailbox(int __always_unused irq, void *data)
    {
            struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)data;

            nbl_dev_clean_mailbox_schedule(dev_mgt);
            return IRQ_HANDLED;
    }

    static int nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt)
    {
            struct nbl_dev_common *common_dev = dev_mgt->common_dev;

            nbl_common_queue_work(&common_dev->clean_mbx_task);
            return 0;
    }

so the work can be re-queued after the flush.

Would the usual order be: first disable the hardware interrupt source,
then free_irq()/synchronize_irq() to guarantee the handler has
finished, then flush_work() / cancel_work_sync() to drain any
already-queued instance?

The worker gates its actual work on NBL_CHAN_INTERRUPT_READY, and
nbl_dev_remove_common_dev() calls cancel_work_sync() later, which
softens the impact, but the ordering still looks inverted versus the
common pattern.

> +
> +static int nbl_dev_configure_msix_map(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +	bool mask_en = msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en;
> +	u16 msix_net_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
> +	u16 msix_not_net_num = 0;
> +	int err, i;
> +
> +	for (i = NBL_MSIX_NET_TYPE; i < NBL_MSIX_TYPE_MAX; i++)
> +		msix_info->serv_info[i].base_vector_id =
> +			msix_info->serv_info[i - 1].base_vector_id +
> +			msix_info->serv_info[i - 1].num;

Is this loop safe against being re-entered?

It recomputes serv_info[i].base_vector_id from serv_info[i - 1], but
serv_info[0] (NBL_MSIX_VIRTIO_TYPE) is never explicitly reset to 0.
On a first call from fresh zero-initialised state that is fine; on a
subsequent call (for example if nbl_dev_start() is ever re-invoked
without reinitialising common_dev->msix_info) the previous
base_vector_id values would accumulate instead of being recomputed
from zero.

Today nbl_dev_start() is only called once from nbl_probe() and
nbl_dev_stop() does not clear these fields, so this is latent, but
would it be worth setting serv_info[0].base_vector_id = 0 before the
loop?

[ ... ]

> @@ -218,9 +401,41 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
>  /* ----------  Dev start process  ---------- */
>  int nbl_dev_start(struct nbl_adapter *adapter)
>  {
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	int ret;
> +
> +	ret = nbl_dev_configure_msix_map(dev_mgt);
> +	if (ret)
> +		goto config_msix_map_err;
> +
> +	ret = nbl_dev_init_interrupt_scheme(dev_mgt);
> +	if (ret)
> +		goto init_interrupt_scheme_err;
> +	ret = nbl_dev_request_mailbox_irq(dev_mgt);
> +	if (ret)
> +		goto mailbox_request_irq_err;
> +	ret = nbl_dev_enable_mailbox_irq(dev_mgt);
> +	if (ret)
> +		goto enable_mailbox_irq_err;
> +
>  	return 0;
> +enable_mailbox_irq_err:
> +	nbl_dev_disable_mailbox_irq(dev_mgt);
> +	nbl_dev_free_mailbox_irq(dev_mgt);
> +mailbox_request_irq_err:
> +	nbl_dev_clear_interrupt_scheme(dev_mgt);
> +init_interrupt_scheme_err:
> +	nbl_dev_destroy_msix_map(dev_mgt);
> +config_msix_map_err:
> +	return ret;
>  }

Is the error unwind here symmetric with nbl_dev_stop()?

If nbl_dev_configure_msix_map() fails, control jumps to
config_msix_map_err and returns immediately, without calling
nbl_dev_destroy_msix_map().  The success teardown path in
nbl_dev_stop() always pairs configure/destroy.  Depending on what
partial state the disp_ops->configure_msix_map() implementation can
leave behind on failure, should the error path mirror the stop path,
or is there a documented contract that configure_msix_map() fully
unwinds its own partial state on error?

The same ordering question applies to the enable_mailbox_irq_err
label, which calls nbl_dev_disable_mailbox_irq() (and therefore
flush_work()) before nbl_dev_free_mailbox_irq() — mirroring the
nbl_dev_stop() sequence discussed above.

[ ... ]

