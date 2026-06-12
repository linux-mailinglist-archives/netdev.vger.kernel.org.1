Return-Path: <netdev+bounces-298713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lWqJCOUuLGpiNAQAu9opvQ
	(envelope-from <netdev+bounces-298713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:08:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A5E67AB8D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:08:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GoFSUE26;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298713-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298713-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BEE2301FD70
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B77391822;
	Fri, 12 Jun 2026 16:07:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B84135CBC3;
	Fri, 12 Jun 2026 16:07:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280470; cv=none; b=s0CXXekvVv9hSIU0eIgJ9SV1cqe++MgUSxREllz7jkgv4UVEfGtAr3YB4YLnprq8PnUtq94a9Uzo1MWjen834mZPmQaQdnHhJTT5dLPnbINoqIM5vC5b66emZcCgQjPsWJRL/ObjpP3yPfwb1ILp51AfHGV4lvh/R8ZZKtIgRIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280470; c=relaxed/simple;
	bh=PM7ZGiMgqzvDevJ43e24iFiCX3mlYcDvWstcDsODdT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqK/0y5SCM9LX7zFT1tKlhKcKhlIjd4x5vWizKwD+HeFob+BmQSoeWOKg9v5x8ydyxH2AGb/AIZekz7slR/Rg6MocUAChvcU9fZI24e8/lizaPVs4FJOtD+NIUvnK5Yo/XruTQVgGm+iwI9rHYUzgK0yJcZUwKuLGvbBe/fDzHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoFSUE26; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28621F000E9;
	Fri, 12 Jun 2026 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280467;
	bh=F8HKmkgMfnWSpRy+B4aGMkwUWIdFXIhB0ADkhsPsHow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GoFSUE26dIRsAC/9P56FPrymI4gJRC+ATFFDJnH89jw4DVDJVylmCR3i0mQjYJQJ/
	 SfxVNnDYPCD68SP/yhS5qOr76wrbyPr9weSDd2qxznCS45UkYtnC+udKLstQ/Z+NdA
	 SZIdP+Yu2R/s/kT6NxDVOvAxHaNxTg89vJ8vzTlte48tUhkCzYsvIgpZEDtffKE3wq
	 nQo/4XWW7KUWxPUW/wVu4LVHtyRlkPLWeVONcWfW/374nVQHbfy24VjrbBO7QANUMK
	 5Bdf5vuA/VG5cT/vra0El0LlW3KqoVksdARH513TFCB3nQ75/+O7sAizXjUGL8kpKa
	 LGufhvmrjEIeQ==
From: Simon Horman <horms@kernel.org>
To: gongfan1@huawei.com
Cc: Simon Horman <horms@kernel.org>,
	wudi234@huawei.com,
	tengpeisen@huawei.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	ioana.ciornei@nxp.com,
	mohsin.bashr@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	luosifu@huawei.com,
	guoxin09@huawei.com,
	zhoushuai28@huawei.com,
	wulike1@huawei.com,
	shijing34@huawei.com,
	zhengjiezhen@h-partners.com,
	maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v09 1/5] hinic3: Add ethtool queue ops
Date: Fri, 12 Jun 2026 17:06:53 +0100
Message-ID: <20260612160653.690379-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <02e87952a65aa268526ade2f03de6c76fbc1fe9d.1781062575.git.wudi234@huawei.com>
References: <02e87952a65aa268526ade2f03de6c76fbc1fe9d.1781062575.git.wudi234@huawei.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298713-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gongfan1@huawei.com,m:horms@kernel.org,m:wudi234@huawei.com,m:tengpeisen@huawei.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:ioana.ciornei@nxp.com,m:mohsin.bashr@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:luosifu@huawei.com,m:guoxin09@huawei.com,m:zhoushuai28@huawei.com,m:wulike1@huawei.com,m:shijing34@huawei.com,m:zhengjiezhen@h-partners.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,vger.kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,nxp.com,gmail.com,h-partners.com,bootlin.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74A5E67AB8D

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
hinic3: Add ethtool queue ops

This commit implements ethtool callback functions .get_ringparam and
.set_ringparam. These callbacks allow users to utilize ethtool for detailed
queue depth configuration and monitoring.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index 90fc16288de95..be9992a235f7b 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
[ ... ]
> @@ -409,6 +410,96 @@ hinic3_get_link_ksettings(struct net_device *netdev,
>  	return 0;
>  }
>  
> +static void hinic3_get_ringparam(struct net_device *netdev,
> +				 struct ethtool_ringparam *ring,
> +				 struct kernel_ethtool_ringparam *kernel_ring,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +
> +	ring->rx_max_pending = HINIC3_MAX_RX_QUEUE_DEPTH;
> +	ring->tx_max_pending = HINIC3_MAX_TX_QUEUE_DEPTH;
> +	ring->rx_pending = nic_dev->q_params.rq_depth;
> +	ring->rx_pending = nic_dev->q_params.sq_depth;

[Severity: High]
Does this code accidentally assign rx_pending twice and omit tx_pending?
Querying the interface will return 0 for the Tx queue depth and an
incorrect value for the Rx queue depth, which also breaks partial
ring updates.

> +}
> +
[ ... ]
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> index e7d6c2033b451..bc4d879f9be4e 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> @@ -137,7 +137,8 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
>  	struct hinic3_interrupt_info info = {};
>  	int err;
>  
> -	if (q_id >= nic_dev->q_params.num_qps)
> +	if (q_id >= nic_dev->q_params.num_qps ||
> +	    !mutex_trylock(&nic_dev->change_res_mutex))
>  		return 0;

[Severity: High]
Is it safe to silently return 0 (success) without applying the interrupt
moderation if the mutex is contended? This appears to drop hardware
configuration updates without informing the caller.

>  
>  	info.interrupt_coalesc_set = 1;
[ ... ]
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> index 0a888fe4c975b..c87624a5e5dcd 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
[ ... ]
> @@ -315,6 +316,9 @@ static void hinic3_link_status_change(struct net_device *netdev,
>  {
>  	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
>  
> +	if (!mutex_trylock(&nic_dev->change_res_mutex))
> +		return;
> +

[Severity: High]
Can this usage of mutex_trylock cause physical link status events to be
discarded? If the lock is held (e.g., during an ethtool ring size change),
the OS link state could permanently diverge from the physical link state.

>  	if (link_status_up) {
>  		if (netif_carrier_ok(netdev))
>  			return;

[Severity: Critical]
Does this early return path leak the mutex? We acquired change_res_mutex
earlier, but it looks like we exit without unlocking it, which would
cause subsequent deadlocks.

> @@ -330,6 +334,8 @@ static void hinic3_link_status_change(struct net_device *netdev,
>  		netif_carrier_off(netdev);
>  		netdev_dbg(netdev, "Link is down\n");
>  	}
> +
> +	mutex_unlock(&nic_dev->change_res_mutex);
>  }

[Severity: Critical]
There is another early return just above this code:
        if (!netif_carrier_ok(netdev))
                return;
Similarly, does this early return also forget to call mutex_unlock()?

>  
>  static void hinic3_port_module_event_handler(struct net_device *netdev,
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index da73811641a9d..047214cfc7532 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
[ ... ]
> @@ -428,6 +439,74 @@ static void hinic3_vport_down(struct net_device *netdev)
>  	}
>  }
>  
> +int
> +hinic3_change_channel_settings(struct net_device *netdev,
> +			       struct hinic3_dyna_txrxq_params *trxq_params)
> +{
[ ... ]
> +	err = hinic3_vport_up(netdev);
> +	if (err)
> +		goto err_close_channel;
> +
> +	hinic3_free_channel_resources(netdev, &cur_qp_params, &cur_trxq_params);
> +
> +	mutex_unlock(&nic_dev->change_res_mutex);
> +
> +	return 0;
> +
> +err_close_channel:
> +	hinic3_close_channel(netdev);
> +err_qp_irq_reset:
> +	nic_dev->q_params = cur_trxq_params;
> +
> +	if (trxq_params->num_qps > cur_trxq_params.num_qps)
> +		hinic3_qp_irq_change(netdev, cur_trxq_params.num_qps);
> +	hinic3_free_qp_ctxts(nic_dev);

[Severity: High]
Is hinic3_free_qp_ctxts() called twice sequentially in this error path?
The err_close_channel block calls hinic3_close_channel(), which internally
invokes hinic3_free_qp_ctxts(). The flow then falls through to
err_qp_irq_reset which explicitly calls hinic3_free_qp_ctxts() again.

> +err_uninit_qps:
> +	hinic3_get_cur_qps(nic_dev, &new_qp_params);
> +	hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params);
> +	hinic3_free_channel_resources(netdev, &cur_qp_params, &cur_trxq_params);

[Severity: Critical]
Does this error path destroy both the new and the old working channel
resources? By calling hinic3_free_channel_resources() on cur_qp_params,
we leave dangling pointers in nic_dev->q_params and nic_io. It seems
subsequent packet transmissions would trigger a use-after-free, and
closing the interface later would trigger a double-free.

> +	mutex_unlock(&nic_dev->change_res_mutex);
> +
> +	return err;
> +}
> +
>  static int hinic3_open(struct net_device *netdev)
>  {
>  	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> @@ -458,6 +537,10 @@ static int hinic3_open(struct net_device *netdev)
>  
>  	hinic3_init_qps(nic_dev, &qp_params);
>  
> +	err = hinic3_prepare_channel(netdev, &nic_dev->q_params);
> +	if (err)
> +		goto err_uninit_qps;
> +
>  	err = hinic3_open_channel(netdev);
>  	if (err)
>  		goto err_uninit_qps;

[Severity: High]
Does jumping to err_uninit_qps leak the QP contexts allocated by
hinic3_prepare_channel()?

Since hinic3_prepare_channel() calls hinic3_init_qp_ctxts(), it looks like
we bypass the cleanup that happens inside hinic3_close_channel(), which
would permanently leak the root context configuration and associated DMA
memory.

