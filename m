Return-Path: <netdev+bounces-294433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LK2rEyNPH2oskAAAu9opvQ
	(envelope-from <netdev+bounces-294433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:46:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEEA6322EF
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:46:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RRSfuTQS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294433-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294433-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 613B330C3941
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E8A3AEB39;
	Tue,  2 Jun 2026 21:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F93AB285;
	Tue,  2 Jun 2026 21:40:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436428; cv=none; b=lZZ7L1GmvI5abA0S9wRdxBONFJDtX3NnCAv2su+3FxqMGJrL7zOipwZWN3uyyjPHTkCfS8b8ec8/nBUu5NyhDBY0UNG2AJ1eWFse57wDJiSIH9pVcKRUIgJtCmwIJQvGeIV8Nxs1On41WzE8TqGY0wnEW2TeujMCSMkbwCqnWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436428; c=relaxed/simple;
	bh=Drc9yMy0GDazP8peWsxvLIMM6q9DZatzZAaX4UBE+qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZgYCop82LAegWwc/CjIXkXdu4Ng6tiCOPAnm2LOHqbh/twPMrbf5x7BHXdT7cqKyp64exYBxzssOPH7qPWDSVUJ3lyxmFCHAFI/dxki5H7/uw5ddxduPxPHMs0hWhqlQXs2VGHi9p/OYaJB63+6UlQUCmP7Ss4K4g4sRPncvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRSfuTQS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0B01F00898;
	Tue,  2 Jun 2026 21:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780436426;
	bh=+RE5t9kn+dYM0CLftJT7Wzq4dMTlXY0Pwl692tdQ+ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RRSfuTQSr8jn+ZJeWyk/Sm5FZQDXKbLauPOzt5dxH9naBNaH0PTXOiwiRYVvUrHMQ
	 RsGvapSWsQLatQ5p4v9M19TqNYTmb+mBcm0ARaGXi7WIPscp7oyE202sQfdSQv/sIt
	 xgC9xJz9NB/C7dB4xGKWo4hKyMvp2rowmJV0GE84XLNTQKBeZpSxpUvjQ1z641F2+M
	 46eInfG1F92hXmM1incPgyNA6rGiv0e3Kl/Ny4BtJY/oa6cOfSh5uAu3Wymah36MMw
	 XxeredFFPi2ZwaiA8TDheFeYCngstwPKMkg82GcnfwDMizJzz7b7uczQKqXiS50Z0j
	 wVf7ExfAYBpdA==
From: Jakub Kicinski <kuba@kernel.org>
To: gongfan1@huawei.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	zhuyikai1@h-partners.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
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
Subject: Re: [PATCH net-next v07 1/6] hinic3: Add ethtool queue ops
Date: Tue,  2 Jun 2026 14:38:24 -0700
Message-ID: <20260602213825.2083877-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <1323cad7ba784efa29a3fd1475b744974e0a0cf5.1779940072.git.zhuyikai1@h-partners.com>
References: <1323cad7ba784efa29a3fd1475b744974e0a0cf5.1779940072.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294433-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gongfan1@huawei.com,m:kuba@kernel.org,m:zhuyikai1@h-partners.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:ioana.ciornei@nxp.com,m:mohsin.bashr@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:luosifu@huawei.com,m:guoxin09@huawei.com,m:zhoushuai28@huawei.com,m:wulike1@huawei.com,m:shijing34@huawei.com,m:zhengjiezhen@h-partners.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,h-partners.com,vger.kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,nxp.com,gmail.com,huawei.com,bootlin.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AEEA6322EF

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
hinic3: Add ethtool queue ops

This patch implements .get_ringparam and .set_ringparam for hinic3,
introduces a hinic3_change_channel_settings() helper plus a new
HINIC3_CHANGE_RES_INVALID flag, and refactors hinic3_open_channel() into
a hinic3_prepare_channel()/hinic3_open_channel() pair.

A few observations and questions on the patch as posted.

> hinic3: Add ethtool queue ops

Could the subject line be more accurate? The patch also introduces
hinic3_change_channel_settings(), the HINIC3_CHANGE_RES_INVALID flag with
checks injected into hinic3_link_status_change() and
hinic3_set_interrupt_moder(), splits hinic3_open_channel() into
hinic3_prepare_channel()+hinic3_open_channel(), renames hinic3_uninit_qps()
to hinic3_get_cur_qps(), and adds new hinic3_free_nicio_res() and
hinic3_destroy_num_qps() calls in hinic3_close() that look like a
pre-existing leak fix. Could these be split into separate commits, with
the leak fix carrying a Fixes: tag so it can be backported?

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index 90fc16288de9..e594bcbc8153 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> @@ -10,6 +10,7 @@
>  #include <linux/etherdevice.h>
>  #include <linux/netdevice.h>
>  #include <linux/ethtool.h>
> +#include <net/devlink.h>

[Low]
Is net/devlink.h actually needed here? The new code uses
NL_SET_ERR_MSG_MOD / NL_SET_ERR_MSG_FMT_MOD (from linux/netlink.h) and
netif_running() / netdev_info(), none of which require devlink.

> @@ -409,6 +410,103 @@ hinic3_get_link_ksettings(struct net_device *netdev,
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
> +	ring->rx_pending = nic_dev->rxqs[0].q_depth;
> +	ring->tx_pending = nic_dev->txqs[0].q_depth;
> +}

[Low]
Should the getter and setter consult the same canonical depth field? The
getter reads nic_dev->rxqs[0].q_depth / nic_dev->txqs[0].q_depth, while
hinic3_set_ringparam() compares against and updates
nic_dev->q_params.sq_depth / rq_depth. They are kept consistent today by
hinic3_alloc_rxqs() and hinic3_update_qp_depth(), but the asymmetry is
fragile to future refactors. Would it be clearer to read q_params here too?

[ ... ]

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> index e7d6c2033b45..cc43773c1984 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> @@ -137,7 +137,8 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
>  	struct hinic3_interrupt_info info = {};
>  	int err;
>  
> -	if (q_id >= nic_dev->q_params.num_qps)
> +	if (test_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags) ||
> +	    q_id >= nic_dev->q_params.num_qps)
>  		return 0;

[High]
Is HINIC3_CHANGE_RES_INVALID being used as an ad-hoc lock to coordinate
readers (this function, hinic3_link_status_change(), hinic3_close()) with
the teardown path in hinic3_change_channel_settings()?

The networking subsystem guidance flags exactly this pattern — bit flags
with set_bit()/test_bit()/clear_bit() guarding code sections rather than
expressing state — and recommends a real lock or RCU.

Concretely for hinic3_link_status_change(), can this race happen?

  CPU0 (auxiliary event)              CPU1 (set_ringparam under RTNL)
  test_bit(...) -> 0
  fall through                        test_and_set_bit(...) was 0, now 1
                                      hinic3_vport_down()
                                        netif_carrier_off()
                                        msleep(100)
  netif_carrier_on()
  nic_dev->link_status_up = true

End state would be carrier reported up while the device is mid-reconfigure
with the old channel torn down. The validation check runs outside any
exclusion region with the writer.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> index 0a888fe4c975..8cf605a0a5d2 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> @@ -315,6 +315,9 @@ static void hinic3_link_status_change(struct net_device *netdev,
>  {
>  	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
>  
> +	if (test_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags))
> +		return;
> +

(see comment above on the bit-as-lock pattern.)

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index da73811641a9..b7f9ba8ce43f 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c

[ ... ]

> @@ -428,6 +439,72 @@ static void hinic3_vport_down(struct net_device *netdev)
>  	}
>  }
>  
> +int
> +hinic3_change_channel_settings(struct net_device *netdev,
> +			       struct hinic3_dyna_txrxq_params *trxq_params)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_dyna_txrxq_params cur_trxq_params = {};
> +	struct hinic3_dyna_qp_params new_qp_params = {};
> +	struct hinic3_dyna_qp_params cur_qp_params = {};
> +	int err;
> +
> +	cur_trxq_params = nic_dev->q_params;
> +
> +	hinic3_config_num_qps(netdev, trxq_params);
> +
> +	err = hinic3_alloc_channel_resources(netdev, &new_qp_params,
> +					     trxq_params);
> +	if (err) {
> +		netdev_err(netdev, "Failed to alloc channel resources\n");
> +		return err;
> +	}
> +
> +	if (!test_and_set_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags)) {
> +		hinic3_vport_down(netdev);
> +		hinic3_close_channel(netdev);
> +		hinic3_get_cur_qps(nic_dev, &cur_qp_params);
> +	}
> +
> +	hinic3_init_qps(nic_dev, &new_qp_params);
> +
> +	err = hinic3_prepare_channel(netdev, trxq_params);
> +	if (err)
> +		goto err_uninit_qps;
> +
> +	if (nic_dev->num_qp_irq > trxq_params->num_qps)
> +		hinic3_qp_irq_change(netdev, trxq_params->num_qps);
> +
> +	nic_dev->q_params = *trxq_params;
> +
> +	err = hinic3_open_channel(netdev);
> +	if (err)
> +		goto err_qp_irq_reset;
> +
> +	err = hinic3_vport_up(netdev);
> +	if (err)
> +		goto err_close_channel;
> +
> +	hinic3_free_channel_resources(netdev, &cur_qp_params, &cur_trxq_params);
> +
> +	clear_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags);
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
> +err_uninit_qps:
> +	hinic3_get_cur_qps(nic_dev, &new_qp_params);
> +	hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params);
> +
> +	return err;
> +}

[High]
Do the error paths leak the OLD QP resources?

After the test_and_set_bit() block runs, hinic3_close_channel() and
hinic3_get_cur_qps(&cur_qp_params) capture the OLD nic_io->sq/rq into
cur_qp_params. hinic3_init_qps(&new_qp_params) then overwrites nic_io with
the NEW pointers.

On the success path, cur_qp_params is freed via:

	hinic3_free_channel_resources(netdev, &cur_qp_params, &cur_trxq_params);

But err_close_channel, err_qp_irq_reset and err_uninit_qps only free
new_qp_params/trxq_params. cur_qp_params is never referenced again on these
paths, so the kzalloc'd sqs/rqs arrays plus the per-QP DMA-coherent WQ pages
created by hinic3_create_qp() appear to leak per failed ringparam change.

[High]
Is HINIC3_CHANGE_RES_INVALID ever cleared on failure?

Only the success path runs:

	clear_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags);

err_close_channel, err_qp_irq_reset and err_uninit_qps return without
clearing. Once stuck high:

  - hinic3_link_status_change() returns immediately on every event, so
    carrier transitions stop propagating;
  - hinic3_set_interrupt_moder() returns 0 without applying changes;
  - hinic3_close() takes the test_and_clear_bit() goto-out branch and
    skips hinic3_vport_down()/hinic3_close_channel()/free_channel_resources
    entirely while still calling hinic3_free_nicio_res() and
    hinic3_destroy_num_qps().

After a failed ethtool -G, would the only recovery be a driver reload or
device reset?

[High]
Does hinic3_free_qp_ctxts() get called when hinic3_open_channel() fails
here?

hinic3_prepare_channel() programs the HW root context via
hinic3_set_root_ctxt() and per-SQ hinic3_set_ci_table(); the matching
teardown is hinic3_free_qp_ctxts() -> hinic3_clean_root_ctxt(). On
hinic3_open_channel() failure this jumps to err_qp_irq_reset ->
err_uninit_qps, which only does hinic3_get_cur_qps() +
hinic3_free_channel_resources(). The latter dma_free's the WQ pages whose
physical addresses the firmware still has.

The pre-patch hinic3_open_channel() had an explicit err_free_qp_ctxts label
covering this case; was the symmetry intentionally dropped?

> @@ -458,6 +535,10 @@ static int hinic3_open(struct net_device *netdev)
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
> @@ -473,7 +554,7 @@ static int hinic3_open(struct net_device *netdev)
>  err_close_channel:
>  	hinic3_close_channel(netdev);
>  err_uninit_qps:
> -	hinic3_uninit_qps(nic_dev, &qp_params);
> +	hinic3_get_cur_qps(nic_dev, &qp_params);
>  	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);

[High]
Same observation as above for the open() path: when hinic3_open_channel()
fails after hinic3_prepare_channel() succeeded, control jumps to
err_uninit_qps which does not call hinic3_free_qp_ctxts(), so the HW root
context and per-SQ CI table programming is left in place while the WQ
pages backing the addresses are freed. Should hinic3_free_qp_ctxts() be
called in this path?

> @@ -493,10 +574,18 @@ static int hinic3_close(struct net_device *netdev)
>  		return 0;
>  	}
>  
> +	if (test_and_clear_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags))
> +		goto out;
> +
>  	hinic3_vport_down(netdev);
>  	hinic3_close_channel(netdev);
> -	hinic3_uninit_qps(nic_dev, &qp_params);
> -	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
> +	hinic3_get_cur_qps(nic_dev, &qp_params);
> +	hinic3_free_channel_resources(netdev, &qp_params,
> +				      &nic_dev->q_params);
> +
> +out:
> +	hinic3_free_nicio_res(nic_dev);
> +	hinic3_destroy_num_qps(netdev);
>  
>  	return 0;
>  }

(see the high-severity comments above on HINIC3_CHANGE_RES_INVALID never
being cleared on failure — the goto-out branch here is the path that
silently skips channel teardown when that happens.)

[ ... ]

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> index 309ab5901379..b5b601469517 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> @@ -541,7 +541,7 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
>  		rq_associate_cqes(rxq);
>  
>  		pkts = hinic3_rx_fill_buffers(rxq);
> -		if (!pkts) {
> +		if (pkts < rxq->q_depth - 1) {
>  			netdev_err(netdev, "Failed to fill Rx buffer\n");
>  			return -ENOMEM;
>  		}

[Medium]
Could this hunk be called out in the commit message? The success criterion
for hinic3_rx_fill_buffers() changes from "any buffers filled" to "almost
all buffers filled" (q_depth - 1). hinic3_rx_fill_buffers() loops up to
q_depth - 1 entries and breaks on the first allocation failure, so any
short fill — for example a single page allocation failure under transient
memory pressure — now returns -ENOMEM and aborts hinic3_open() or
hinic3_change_channel_settings(). This seems unrelated to "Add ethtool
queue ops"; was the behavior change intentional?
-- 
pw-bot: cr

