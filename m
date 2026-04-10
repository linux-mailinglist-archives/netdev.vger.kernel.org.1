Return-Path: <netdev+bounces-277564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ1aOt5Z2WksowgAu9opvQ
	(envelope-from <netdev+bounces-277564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:13:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 601AC3DC691
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 089273045254
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DD536C5BB;
	Fri, 10 Apr 2026 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg1FWXdq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C433E377;
	Fri, 10 Apr 2026 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851873; cv=none; b=Gwx6zYFpIO1zpiBy8DelTTOodOh7nFYPYcrG42kPrUc0JdJQcLSurOREDcHrvded5vfvvfWtKaoLc58/a2cbVrP6Kk1bTuCEft4v1vk+h18NOszk97DJ87HKrxtqlBI90M1cjHNhR1i6znO7ZKyHpgOTk5GfJbBUTAH70ZnUamo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851873; c=relaxed/simple;
	bh=BjlXT6HlEb/UCpkPS+IpqA3/G7HGsO5U4VHHD8uy/j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=So81FlAG7ar5K47xmbhKLDUQhg74k7kGScai/ab8E8AijbzM8zgUoRtY7mQbytJt+5+zDwEn62S+9JfYjmxcvCj8kE5e8N1n3ZHq/uc2WwORjzryFOgroLUiUCzlv/zrNpTvW5ZFy1m3ji6SdFAkVfeKo9k7BUAcjIeqH+v++0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg1FWXdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A67C19421;
	Fri, 10 Apr 2026 20:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775851872;
	bh=BjlXT6HlEb/UCpkPS+IpqA3/G7HGsO5U4VHHD8uy/j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wg1FWXdqWnOPCwkhwFQIow5PEZMMjnF4vE6KagAJD/SelKUMemaeHSoOUO8EPNxk7
	 a4cg8Ae7xEt8V9PaA2SWj07hQ2UmD9sSZQbE11OAaK6dz8F0GjTUoIPrJy0g2k8hhc
	 Ay2NdIQU/ggvvbUMwt1qgKIlJWp4s3tsZkFPPtMYShyj/O4IZZcj/9VGTGkSvD9fqu
	 7pnKSUNMZU2qyr2WiBZhL7t+6g5oUv0z9opW8sFyLuWPqRfR7lEiYIDsbOIoF+mqqP
	 YuznuubUC+JEcxnIWqwYEYWgyCpRkNPG5sasNQXV4dJxLvuCyPNA7Q3D/fO9knU7eL
	 rlKQxPwE9Ghqw==
From: Simon Horman <horms@kernel.org>
To: gongfan1@huawei.com
Cc: Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com,
	zhoushuai28@huawei.com,
	kuba@kernel.org,
	shijing34@huawei.com,
	pabeni@redhat.com,
	wulike1@huawei.com,
	mohsin.bashr@gmail.com,
	zhuyikai1@h-partners.com,
	edumazet@google.com,
	guoxin09@huawei.com,
	netdev@vger.kernel.org,
	zhengjiezhen@h-partners.com,
	linux-doc@vger.kernel.org,
	ioana.ciornei@nxp.com,
	luosifu@huawei.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net
Subject: Re: [PATCH net-next v04 1/6] hinic3: Add ethtool queue ops
Date: Fri, 10 Apr 2026 21:10:50 +0100
Message-ID: <20260410201050.651345-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7deda08d48b7f894c5aa0537f70897871e11d012.1775618798.git.zhuyikai1@h-partners.com>
References: <7deda08d48b7f894c5aa0537f70897871e11d012.1775618798.git.zhuyikai1@h-partners.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,bootlin.com,huawei.com,redhat.com,gmail.com,h-partners.com,google.com,nxp.com,lunn.ch,davemloft.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-277564-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 601AC3DC691
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
hinic3: Add ethtool queue ops

This commit implements .get_ringparam and .set_ringparam ethtool callbacks,
allowing users to configure and monitor queue depths.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index 90fc16288de9..e47c3f43e7b9 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c

[ ... ]

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> index e7d6c2033b45..d3b3927b5408 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c

[ ... ]

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> index 0a888fe4c975..3b470978714a 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c

[ ... ]

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index da73811641a9..cec501a9dd43 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> @@ -428,6 +428,84 @@ static void hinic3_vport_down(struct net_device *netdev)
>  	}
>  }
>
> +int
> +hinic3_change_channel_settings(struct net_device *netdev,
> +			       struct hinic3_dyna_txrxq_params *trxq_params)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_dyna_txrxq_params old_qp_params = {};
> +	struct hinic3_dyna_qp_params new_qp_params = {};
> +	struct hinic3_dyna_qp_params cur_qp_params = {};
> +	bool need_teardown = false;
> +	unsigned long flags;
> +	int err;
> +
> +	mutex_lock(&nic_dev->channel_cfg_lock);
> +
> +	hinic3_config_num_qps(netdev, trxq_params);
> +
> +	err = hinic3_alloc_channel_resources(netdev, &new_qp_params,
> +					     trxq_params);
> +	if (err) {
> +		netdev_err(netdev, "Failed to alloc channel resources\n");
> +		mutex_unlock(&nic_dev->channel_cfg_lock);
> +		return err;
> +	}
> +
> +	spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
> +	if (!test_and_set_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags))
> +		need_teardown = true;
> +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> +
> +	if (need_teardown) {
> +		hinic3_vport_down(netdev);
> +		hinic3_close_channel(netdev);
> +		hinic3_uninit_qps(nic_dev, &cur_qp_params);
> +		hinic3_free_channel_resources(netdev, &cur_qp_params,
> +					      &nic_dev->q_params);
> +	}
> +
> +	if (nic_dev->num_qp_irq > trxq_params->num_qps)
> +		hinic3_qp_irq_change(netdev, trxq_params->num_qps);
> +
> +	spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
> +	old_qp_params = nic_dev->q_params;
> +	nic_dev->q_params = *trxq_params;
> +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> +
> +	hinic3_init_qps(nic_dev, &new_qp_params);
> +
> +	err = hinic3_open_channel(netdev);
> +	if (err)
> +		goto err_uninit_qps;
> +
> +	err = hinic3_vport_up(netdev);
> +	if (err)
> +		goto err_close_channel;
> +
> +	spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
> +	clear_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags);
> +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> +
> +	mutex_unlock(&nic_dev->channel_cfg_lock);
> +
> +	return 0;
> +
> +err_close_channel:
> +	hinic3_close_channel(netdev);
> +err_uninit_qps:
> +	spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
> +	nic_dev->q_params = old_qp_params;
> +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> +
> +	hinic3_uninit_qps(nic_dev, &new_qp_params);
> +	hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params);
> +
> +	mutex_unlock(&nic_dev->channel_cfg_lock);
> +
> +	return err;
> +}

Does the error path properly clear the HINIC3_CHANGE_RES_INVALID flag?

On the success path, clear_bit(HINIC3_CHANGE_RES_INVALID) is called under
channel_res_lock. However, both error paths (err_close_channel and
err_uninit_qps) skip this, leaving the flag permanently set.

After a failed ring parameter change, the device enters an unrecoverable
state:

1. HINIC3_INTF_UP remains set, HINIC3_CHANGE_RES_INVALID remains set.

2. User does ifdown: hinic3_close() clears HINIC3_INTF_UP but skips
   teardown since HINIC3_CHANGE_RES_INVALID is already set:

   hinic3_close() {
       ...
       spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
       if (!test_and_set_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags))
           need_teardown = true;   // Already set, need_teardown = false
       spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);

       if (need_teardown) {
           // Skipped
       }
   }

3. User does ifup: hinic3_open() allocates fresh resources and sets
   HINIC3_INTF_UP, but never clears HINIC3_CHANGE_RES_INVALID.

4. HINIC3_CHANNEL_RES_VALID() now returns false permanently:

   #define HINIC3_CHANNEL_RES_VALID(nic_dev) \
       (test_bit(HINIC3_INTF_UP, &(nic_dev)->flags) && \
        !test_bit(HINIC3_CHANGE_RES_INVALID, &(nic_dev)->flags))

5. hinic3_link_status_change() in hinic3_main.c silently returns, so the
   link never comes up:

   static void hinic3_link_status_change(struct net_device *netdev,
                                         bool link_status_up)
   {
       ...
       spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
       valid = HINIC3_CHANNEL_RES_VALID(nic_dev);
       spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);

       if (!valid)
           return;   // Always returns here
       ...
   }

6. hinic3_set_interrupt_moder() in hinic3_irq.c returns 0 without
   configuring interrupts:

   static int hinic3_set_interrupt_moder(struct net_device *netdev, ...)
   {
       ...
       spin_lock_irqsave(&nic_dev->channel_res_lock, flags);

       if (!HINIC3_CHANNEL_RES_VALID(nic_dev) ||
           q_id >= nic_dev->q_params.num_qps) {
           spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
           return 0;   // Always returns here
       }
       ...
   }

The device appears up but is permanently non-functional until module reload.

Should the error paths clear HINIC3_CHANGE_RES_INVALID under
channel_res_lock before returning?

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> index 9502293ff710..55b280888ad8 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h

[ ... ]

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
> index 12eefabcf1db..3791b9bc865b 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h

[ ... ]

