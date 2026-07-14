Return-Path: <netdev+bounces-307402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l4UOH+H9VWoMxgAAu9opvQ
	(envelope-from <netdev+bounces-307402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:14:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF913752B5E
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:14:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=U2C2VGDp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307402-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307402-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6ADB303E48A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4DA43C05B;
	Tue, 14 Jul 2026 09:11:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7F32AAA0
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 09:11:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020298; cv=none; b=BW5uPzKQOr+3qaUQfYIWpLdnDUmeNYCW0yVj8QaXOfoqp8mbnw/TpWiS6aWEGa02qyajxqClHzWuzwnf9WQT/mfcJ5UWgc/tR1DwlME5FMQ63+YRNAt3/QLApwPInfPNDL5u05Km7cq6kVXOksLFMhcCVVYtaedn7a2kcSRRS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020298; c=relaxed/simple;
	bh=HPdAQlnMPdudq/CCxqExYCW4QQEZsFbd2zN+BYpyO4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DspLFalTOeel0tz+bbt5+OgcByXa2fdqBdzRyY3pPO8RP06Sr/lwa9R/rmz8U+WJlzeLdyUdaNTr44JZT3ZrVx9fA8Z0JFlC6TANo6BjhH8c380HZ4ZDrWfEedBZjYb7U2Jbwt/eYikiuRyR18lFey0wwBIJ5/aI685VzBhRGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2C2VGDp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EACE1F000E9;
	Tue, 14 Jul 2026 09:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784020296;
	bh=8GSEN31dIhMc8TnKPz0+iVPDekCaH2QphQJRQeIJNBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U2C2VGDpNPl548J9rMQXG824o/QQRu/NYojatKRqM4qbRYFgVVdesLYiSSHPSBzAI
	 klKKdTfFXgxIFn+VHhENvYDhExzUixcgTq6TNYuCn7/uwOn626uz3Y/DKbpicRAxfK
	 2meJQ/E10YJ69fK0B6+OMbgDIGfRpvOz9NZkMmVVAN+6qXrRzMxnpVchJ1RS51Ts1W
	 H4tSX4BfcyFiIkObxSByxP4qWe1VhB5OlY3UIcJr6WT2pBKm3j/9s53VSWB1EHZYiK
	 uCGyeFpnKu+uyENWnEuhojeDmBaVN4w1qktEARMWXDwYv/RepJWlfc6FCb4X0+o9Ds
	 l8ZTxIyLb1g9w==
From: Simon Horman <horms@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	kees@kernel.org,
	joe@dama.to,
	leitao@debian.org,
	shaojijie@huawei.com,
	u.kleine-koenig@baylibre.com,
	weirongguang@kylinos.cn,
	larysa.zaremba@intel.com,
	fabio.baltieri@gmail.com
Subject: Re: [PATCH net-next v10 5/5] net: wangxun: add pcie error handler
Date: Tue, 14 Jul 2026 10:11:29 +0100
Message-ID: <20260714091129.1815871-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707061455.39564-6-jiawenwu@trustnetic.com>
References: <20260707061455.39564-6-jiawenwu@trustnetic.com>
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
	TAGGED_FROM(0.00)[bounces-307402-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:kees@kernel.org,m:joe@dama.to,m:leitao@debian.org,m:shaojijie@huawei.com,m:u.kleine-koenig@baylibre.com,m:weirongguang@kylinos.cn,m:larysa.zaremba@intel.com,m:fabio.baltieri@gmail.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,huawei.com,baylibre.com,kylinos.cn];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF913752B5E

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [5]: [PATCH net-next v10 5/5] net: wangxun: add pcie error handler ---
commit 91baa4e77d07ab6772569a7d37ed86cfda625c00
Author: Jiawen Wu <jiawenwu@trustnetic.com>
Subject: net: wangxun: add pcie error handler

This commit adds PCIe error handling support (AER) to the wangxun drivers
(ngbe and txgbe). It detects hardware errors, attempts to soft quiesce,
and registers standard PCI error handler callbacks.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> index ee27f96735dc7..0cb99e456a1c9 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c

[ ... ]

> +static void wx_io_resume(struct pci_dev *pdev)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	struct net_device *netdev;
> +	int err;
> +
> +	netdev = wx->netdev;
> +	rtnl_lock();
> +	if (netif_running(netdev)) {
> +		err = netdev->netdev_ops->ndo_open(netdev);

[Severity: High]
Does this sequence risk corrupting the hw_tc_lock seqlock?

During AER recovery, wx_io_slot_reset() calls down_suspend(), which bypasses
wx_ptp_stop(). This leaves the PTP clock registered and potentially in use by
userspace.

When wx_io_resume() then calls ndo_open(), this triggers txgbe_up() or
ngbe_up(), which in turn calls wx_ptp_init(). Since wx_ptp_init()
unconditionally calls seqlock_init(&wx->hw_tc_lock), won't this corrupt the
lock if userspace is actively issuing PTP ioctls?

> +		if (err) {
> +			wx_err(wx, "Failed to open netdev after reset\n");

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 92895f5035118..56d4b63387fd6 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c

[ ... ]

> @@ -413,6 +428,9 @@ static void ngbe_disable_device(struct wx *wx)
>  
>  static void ngbe_reset(struct wx *wx)
>  {
> +	if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
> +		return;
> +
>  	wx_flush_sw_mac_table(wx);

[Severity: High]
Is the hardware properly reinitialized here after an AER slot reset?

In wx_io_slot_reset(), the hardware needs to be restarted from scratch.
While txgbe_reset() calls txgbe_reset_hw(), ngbe_reset() only flushes the
software MAC tables and skips calling ngbe_reset_hw(). 

Because this patch registers wx_err_handler for the ngbe driver, won't this
leave the hardware uninitialized and the interface broken after a PCIe slot
reset?

[ ... ]

> @@ -529,12 +548,16 @@ static int ngbe_close(struct net_device *netdev)
>  {
>  	struct wx *wx = netdev_priv(netdev);
>  
> +	if (test_bit(WX_STATE_RES_FREED, wx->state))
> +		goto out;
> +
>  	wx_ptp_stop(wx);

[Severity: High]
Does this early return cause a use-after-free for the PTP clock?

If a PCI error occurs, down_suspend() sets WX_STATE_RES_FREED but
intentionally skips wx_ptp_stop(). If the interface is subsequently closed or
unregistered, ngbe_close() will return early here and never call
wx_ptp_stop().

Because the PTP clock device is never unregistered, it remains exposed to
userspace after the driver's memory is freed. Can this lead to a
use-after-free if userspace interacts with the clock later?

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index a7bde03a98feb..d85ee83192e4f 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c

[ ... ]

> @@ -530,12 +549,16 @@ static int txgbe_close(struct net_device *netdev)
>  {
>  	struct wx *wx = netdev_priv(netdev);
>  
> +	if (test_bit(WX_STATE_RES_FREED, wx->state))
> +		goto out;
> +
>  	wx_ptp_stop(wx);

[Severity: High]
Similar to ngbe_close() above, does this early return skip wx_ptp_stop() and
lead to a use-after-free if the txgbe device is closed after an AER suspend?

