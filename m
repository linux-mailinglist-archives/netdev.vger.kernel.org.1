Return-Path: <netdev+bounces-298308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BzYDHjwHK2pq1gMAu9opvQ
	(envelope-from <netdev+bounces-298308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:06:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD0674AAF
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:06:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MtaCS80E;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298308-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298308-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1211307D746
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC21043C04C;
	Thu, 11 Jun 2026 19:06:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7651A9F90;
	Thu, 11 Jun 2026 19:06:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204792; cv=none; b=iAn4FQ8S3/JYFmSXsS9MIfHELM59vgN5ZS9wYQ1zDLXYSa2eyR8u0VDmPuGIlFT1NMbaUiIdKtT7sxfXiQoqsE8QGUYDsYq6+MIZnz34+nnTOV/JxBoxmu0ww6xpOSoYnEfJLqgxXHo1FQaHhYO3h8Oh0wphwAL+SZfHRyugU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204792; c=relaxed/simple;
	bh=FraDEItuikW/FhzXKhz4IgIftCmchrwgFyxTnyOONbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWZJ2mcuDtrGlcpPP+pKg8eBzYBVQATF5SaRrMIlLbIsMRB9iUVHLhmSoFhunNsJcgQKb5N12rdGU5dSzUg1D5TrSDltZFS9tIMPBcAOzAgRN7GYSh8N8bfsyRV9JA15+WnIYnwg283+weh+ySbYMmU6oCl1qw+x7fu3FXP3Za0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtaCS80E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AF01F000E9;
	Thu, 11 Jun 2026 19:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781204791;
	bh=51vlAPXlvhihKGYFaQXJ7Z9mhusBRCWMllOrHPNV+yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MtaCS80EM93wRyNPtd1sCoeEOQ00kugmSVRgCIGFHKtiUdUn3tcTmvpYjhPpKDcJb
	 eT4BPXckAB3/um+jhVAP/16hmZeI/Tv3lBhf7uev//LGXk0LSuheZ0zzmP0p2JS3bF
	 4NNJljwOAn7wI9qnUWHIHiuIMjCiLp2a6a7kZqXdTRE0Uzcg/TawhOa5KhyfWKtDDI
	 Vny3/10uLsKmyTWiKDEH3DZVwRYh9xXX+wHHOwCHvDcpvR8/a1GWcW1r7pMmAJ66lh
	 lDG1N4XjjFhijdgk6JVwPx3Mdu5bLNA/tEwG4cOL6G3Z9WQm1QIm9wZjG6Z7Dv/LTL
	 Yt48YEjuOr8NQ==
From: Simon Horman <horms@kernel.org>
To: tim770802@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	haijun.liu@mediatek.com,
	chandrashekar.devegowda@intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	tim.jh.chen@wnc.com.tw,
	Chih.Hung.Huang@wnc.com.tw
Subject: Re: [PATCH net v4] net: wwan: t7xx: fix race between TX path and system PM suspend
Date: Thu, 11 Jun 2026 20:04:35 +0100
Message-ID: <20260611190433.634941-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610061014.597533-1-tim770802@gmail.com>
References: <20260610061014.597533-1-tim770802@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tim770802@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:haijun.liu@mediatek.com,m:chandrashekar.devegowda@intel.com,m:ricardo.martinez@linux.intel.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:tim.jh.chen@wnc.com.tw,m:Chih.Hung.Huang@wnc.com.tw,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298308-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,mediatek.com,intel.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,wnc.com.tw];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4BD0674AAF

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says:

Hi Tim,

While I think the issues that are flagged as pre-existing below
can be considered in the context of possible follow-up, the other
two issues - the first and last one - do look like they effect this patch.

---
net: wwan: t7xx: fix race between TX path and system PM suspend

This commit addresses a CPU soft lockup that occurs during system suspend
when ASPM L1 is enabled. It aims to quiesce the DPMAIF TX contexts by
using the PM freezer, marking the TX push kthread as freezable and the
TX-done workqueue with WQ_FREEZABLE. This prevents them from touching
hardware while the suspend callback tears it down.

> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
> index 236d632cf591b..804bd730c40fa 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c

[ ... ]

> @@ -447,19 +448,28 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
>  	struct dpmaif_ctrl *dpmaif_ctrl = arg;
>  	int ret;
>  
> +	set_freezable();
> +
>  	while (!kthread_should_stop()) {
>  		if (t7xx_tx_lists_are_all_empty(dpmaif_ctrl) ||
>  		    dpmaif_ctrl->state != DPMAIF_STATE_PWRON) {
> -			if (wait_event_interruptible(dpmaif_ctrl->tx_wq,
> -						     (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) &&
> -						     dpmaif_ctrl->state == DPMAIF_STATE_PWRON) ||
> -						     kthread_should_stop()))
> +			if (wait_event_freezable(dpmaif_ctrl->tx_wq,
> +						 (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) &&
> +						  dpmaif_ctrl->state == DPMAIF_STATE_PWRON) ||
> +						 kthread_should_stop()))
>  				continue;
>  
>  			if (kthread_should_stop())
>  				break;
>  		}
>  
> +		/* Freeze here, outside the runtime-PM and MMIO section below, so
> +		 * the system suspend freezer parks this thread before the device
> +		 * suspend callbacks tear the DPMAIF hardware down.
> +		 */
> +		if (try_to_freeze())
> +			continue;
> +

[Severity: High]
Does this setup cause a freeze deadlock?

Since the tx worker queue is now freezable, if the worker freezes first, it
stops processing TX completions. The DRB ring stays full and no space is freed.

Meanwhile, if there are pending skbs, t7xx_do_tx_hw_push() repeatedly calls
t7xx_txq_burst_send_skb(), which returns 0 when the ring is full:

t7xx_do_tx_hw_push() {
    ...
    drb_send_cnt = t7xx_txq_burst_send_skb(txq);
    if (drb_send_cnt <= 0) {
        usleep_range(10, 20);
        cond_resched();
        continue;
    }
    ...
}

Because this do-while loop inside t7xx_do_tx_hw_push() never exits when the
DRB ring is full, the kthread never loops back to reach this try_to_freeze()
call. Will this cause the freezer to time out and abort the system suspend?

>  		ret = pm_runtime_resume_and_get(dpmaif_ctrl->dev);
>  		if (ret < 0 && ret != -EACCES)
>  			return ret;

[Severity: High]
This is a pre-existing issue, but does this lead to a runtime PM usage
counter underflow when pm_runtime_resume_and_get() returns -EACCES?

pm_runtime_resume_and_get() internally decrements the usage counter back to
its original value if it returns an error. By ignoring -EACCES here, the
code proceeds and unconditionally executes pm_runtime_put_autosuspend() at
the end of the loop, dropping the usage count a second time.

A similar issue exists in t7xx_dpmaif_tx_done() where the TX done work item
also ignores -EACCES and continues. Could this lead to a negative reference
count when runtime PM is disabled?

[Severity: High]
This is a pre-existing issue, but does returning early here cause a
use-after-free later?

If pm_runtime_resume_and_get() returns an error other than -EACCES, the
function returns early. This terminates the kthread and invokes do_exit(),
which frees the task_struct since kthread_run() does not hold an extra
reference.

Later, when the device is unbound, t7xx_dpmaif_tx_thread_rel() calls
kthread_stop(dpmaif_ctrl->tx_thread) on the freed task pointer:

t7xx_dpmaif_tx_thread_rel() {
    ...
    if (dpmaif_ctrl->tx_thread)
        kthread_stop(dpmaif_ctrl->tx_thread);
    ...
}

Will this cause a panic?

[ ... ]

> @@ -617,7 +627,7 @@ int t7xx_dpmaif_txq_init(struct dpmaif_tx_queue *txq)
>  	}
>  
>  	txq->worker = alloc_ordered_workqueue("md_dpmaif_tx%d_worker",
> -				WQ_MEM_RECLAIM | (txq->index ? 0 : WQ_HIGHPRI),
> +				WQ_MEM_RECLAIM | WQ_FREEZABLE | (txq->index ? 0 : WQ_HIGHPRI),
>  				txq->index);
>  	if (!txq->worker)
>  		return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but are there other hardware-accessing workqueues
that also need to be marked as freezable to prevent this system suspend race?

For example, the bat_release_wq is allocated without WQ_FREEZABLE:

t7xx_dpmaif_bat_rel_wq_alloc() {
    ...
    dpmaif_ctrl->bat_release_wq = alloc_workqueue("dpmaif_bat_release_work_queue",
                                                  WQ_MEM_RECLAIM | WQ_PERCPU, 1);
    ...
}

And its worker ignores -EACCES from runtime PM and accesses the hardware
directly:

t7xx_dpmaif_bat_release_work() {
    ...
    if (ret < 0 && ret != -EACCES)
        return;

    t7xx_pci_disable_sleep(dpmaif_ctrl->t7xx_dev);
    ...
}

Similarly, the CLDMA TX and RX workqueues are allocated without WQ_FREEZABLE
in t7xx_cldma_init(). Could these unfrozen workers execute pending work
against a suspended or torn-down device and cause the same soft lockups?

