Return-Path: <netdev+bounces-273418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOlfOYAcy2kEEAYAu9opvQ
	(envelope-from <netdev+bounces-273418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:59:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F0E362EFE
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6230130A1254
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154A1307481;
	Tue, 31 Mar 2026 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzvB/fVj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645A2F0C45
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918540; cv=none; b=PKstUeC1M1AUlwiC7u472kb/H3OIeQln0+1XCQnUz8YkORnkCTuDgYyzDLGt9GxSChxHmkT2v5S60gdphukVSs0dwmOtnnXAGM1T8o7jS/CQ/ziW0tByZsXcDDeQU7lBgXiMF2t4LmJGrizJiPfLQg/kDagemFlvDCiZ95nEqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918540; c=relaxed/simple;
	bh=6sc8ttC8N8vNp1AJG9OUX/1f21JbdxjB/0eiATQjnzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP+UKJajIqJkEewZLWKkfTh7+slYBhy4T2bJgojc+q17MC0tJFUTAoZCY/sIqnErFDQtRNKTCIj7UyvwZGgUDeUPP6iPd62d+Vq7CMBLe5QDm1tOD7ysFPe/BOoaZtKTV5s9FtvxEoXn88CgST6zxO5L/KkCtMFD8bK8m883GJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzvB/fVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF7CC4CEF7;
	Tue, 31 Mar 2026 00:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774918539;
	bh=6sc8ttC8N8vNp1AJG9OUX/1f21JbdxjB/0eiATQjnzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzvB/fVjbKIH5QsO9cwaeKK0cHMw3gOyemS59Xz+c5Rp/09TH0hGw7Qa+uh56i1tR
	 wkviDnGgbz8vB2RMJAiBGPWXfEszAsrARW4mNttbNl7JBwkznXFDROyEQzYoatcDMx
	 dOjaiiYNJWyqJ9KdLAPJLHQq+EVGZNsQSXiAMDOvXNsGwQbWsl7uXWvp13FOhgnN6w
	 hMSrKoUw38MCe3oCwW0TLsIpL05E0z7cSJiwObVevdnqLj10vKoW2H/N3orrblAWgH
	 Qh7rmppDJ1sxuZAZ9xpFUw4qB3Afs5OyFeHIo88KMgqRkYfEkAWI4nH0duqGlf2bsW
	 FMTd6kb6ByhjA==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com,
	jacob.e.keller@intel.com,
	kees@kernel.org,
	joe@dama.to,
	larysa.zaremba@intel.com,
	abdun.nihaal@gmail.com,
	leitao@debian.org
Subject: Re: [PATCH net-next v6 06/11] net: txgbe: add power management support
Date: Mon, 30 Mar 2026 17:55:38 -0700
Message-ID: <20260331005538.3459665-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326021406.30444-7-jiawenwu@trustnetic.com>
References: <20260326021406.30444-7-jiawenwu@trustnetic.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-273418-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42F0E362EFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: txgbe: add power management support

This commit adds power management support to the txgbe driver, including
.suspend, .resume, and Wake-on-LAN functionality. It updates the pci_driver
struct to use libwx suspend, resume, and shutdown callbacks.

[ ... ]
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index 30f66507809bd..ddc7cea9d7c28 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
[ ... ]
> @@ -975,7 +960,9 @@ static struct pci_driver txgbe_driver = {
>  	.id_table = txgbe_pci_tbl,
>  	.probe    = txgbe_probe,
>  	.remove   = txgbe_remove,
> -	.shutdown = txgbe_shutdown,
> +	.suspend  = wx_suspend,
> +	.resume   = wx_resume,
> +	.shutdown = wx_shutdown,
>  	.sriov_configure = wx_pci_sriov_configure,
>  };

When Wake-on-LAN is enabled, do wx_shutdown() or wx_suspend() cause a
NULL pointer dereference regression?

If the interface is running, wx_dev_shutdown() calls txgbe_close_suspend(),
which frees the RX and TX rings via wx_free_resources().

wx_free_resources() calls kvfree(rx_ring->rx_buffer_info) and sets it to
NULL. It also calls dma_free_coherent() for rx_ring->desc but leaves
rx_ring->dma holding a stale IOVA.

Later in wx_dev_shutdown(), since Wake-on-LAN is enabled, it calls
wx_configure_rx() which loops over the rings and calls
wx_configure_rx_ring().

wx_configure_rx_ring() explicitly programs the hardware with the stale
DMA address ring->dma, which might lead to memory corruption. Furthermore,
it calls memset(ring->rx_buffer_info, 0, ...), which causes an unconditional
NULL pointer dereference.

Is there also a potential data race regression when configuring Wake-on-LAN
during suspend/shutdown?

In wx_dev_shutdown(), rtnl_lock() is explicitly unlocked right before
checking if Wake-on-LAN is enabled. If it is enabled, the driver calls
wx_set_rx_mode(netdev).

Inside wx_set_rx_mode(), the driver accesses the netdev's unicast and
multicast address lists. Since neither rtnl_lock() nor netif_addr_lock()
is held here, could concurrent list modifications cause list corruption?

Could the wx->service_task workqueue remain uncancelled during suspend and
shutdown?

The driver initializes a work item wx->service_task that runs periodically
via wx->service_timer. During suspend or shutdown, txgbe_disable_device()
deletes the timer with timer_delete_sync(), but
cancel_work_sync(&wx->service_task) is never called.

If the timer fired just before being deleted, the work item could execute
txgbe_service_task() in the background while the PCI device is placed into
D3hot or its PCI master bit is disabled, which might trigger PCI target
aborts or lockups.

Lastly, is the device missing a transition to PCI_D3hot during system
suspend?

The patch adds the .suspend = wx_suspend callback using the legacy PCI
power management API. Legacy PCI PM callbacks do not automatically invoke
pci_prepare_to_sleep() or pci_set_power_state() to place the device into
a low-power state.

While the wx_shutdown() path explicitly calls
pci_set_power_state(pdev, PCI_D3hot), wx_suspend() does not. Consequently,
the device appears to be left in PCI_D0 during system suspend.

