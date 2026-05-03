Return-Path: <netdev+bounces-283527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNBQJAGw9mlyXgIAu9opvQ
	(envelope-from <netdev+bounces-283527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:16:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F1E4B41F9
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F08FE30182AD
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 02:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00F435DA61;
	Sun,  3 May 2026 02:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slI1z2sl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9AB35E549
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 02:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777774540; cv=none; b=OnDOcZYYMw0zm9HtHaVw6aQ+gnQZV8I04thSnRIbKp6A8POdVpqxIOYLZkmyzh6kRB0/pc2pceGiGWBDeQ37mc34Yf+KqLLfqr0u5bC3CeVmB5N77cKzjxh+SGDG7UX7p3j/W4SbPngptUzG5gsg3Anqd+Xya7gdjRrK/U8y4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777774540; c=relaxed/simple;
	bh=XcIkrF9u8KEvBcFwQuOzXM8O898ziH5rvIIDFJaig0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lmo9iZMh1mVR1XR4gmu7kzuAOVP6g/4mo9u912uLE1RgAhDx77t6j/9zrpuZPHQd2b8n8X8120l13PPTMCuwfckdmGAFRcx10GWibDLU6t9vxcDDO407hI0gBGVNwnMqNflZDhEzVFV4Kltz51JFiWgiKaOHDXY4C0Ed0gnaE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slI1z2sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79186C19425;
	Sun,  3 May 2026 02:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777774540;
	bh=XcIkrF9u8KEvBcFwQuOzXM8O898ziH5rvIIDFJaig0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slI1z2slKAhZnLWsMYeu3pu9OphAl8v1dMPebwvW05KWQXWk3+RUqp1j74PZs336y
	 O3Nj1QxUM0ERFlkV/8B9dfJoTC1j6fGn4i1wT/4MZ1swlFA8LlqyaCLibR+8XyIYqD
	 PhDvVTvKyMsF8mdf6zP6heMimsHpyifhqTK5k1Ey7wfUGlz2lhx1O5C9GQrT20Ecjb
	 Br2ws6zgn1llHuKoyNWE8dgrrnqxmgOaXCpncdoYMwSu5P9ty/fIUPf9oLCwtXffV6
	 Qa6yIw7zpgAQPZcesYbpWkgqQwpDuiyI6vEb7iOVEm1N3bRbV1a5M85Tma7tDOtSyL
	 pu7PC8/pz1Uww==
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
	kees@kernel.org,
	larysa.zaremba@intel.com,
	leitao@debian.org,
	joe@dama.to,
	jacob.e.keller@intel.com,
	fabio.baltieri@gmail.com
Subject: Re: [PATCH net-next v2 6/6] net: wangxun: implement pci_error_handlers ops
Date: Sat,  2 May 2026 19:15:38 -0700
Message-ID: <20260503021538.4127382-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430082517.19612-7-jiawenwu@trustnetic.com>
References: <20260430082517.19612-7-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0F1E4B41F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-283527-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wangxun: implement pci_error_handlers ops

Support AER driver to handle the PCIe errors.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
[ ... ]
> +static pci_ers_result_t wx_io_error_detected(struct pci_dev *pdev,
> +					     pci_channel_state_t state)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	struct net_device *netdev;
> +
> +	netdev = wx->netdev;

If an AER event triggers during ngbe_probe() or txgbe_probe() before
pci_set_drvdata() is called, wx will be NULL here.

Could this lead to a NULL pointer dereference when accessing wx->netdev?

Should the handler validate the wx pointer, or should pci_set_drvdata()
be moved earlier in the probe sequence?

> +	if (!netif_device_present(netdev))
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	rtnl_lock();
> +	netif_device_detach(netdev);
> +
> +	if (netif_running(netdev))
> +		wx->close_suspend(wx);
> +
> +	if (state == pci_channel_io_perm_failure) {
> +		rtnl_unlock();
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}

Does calling wx->close_suspend(wx) before checking for
pci_channel_io_perm_failure cause illegal MMIO accesses?

If the device is in a permanent failure state, it is physically
disconnected, and MMIO accesses could result in Master Aborts or system
lockups.

Should the check for permanent failure precede the hardware teardown?

> +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> +		pci_disable_device(pdev);
> +	rtnl_unlock();
> +
> +	/* Request a slot reset. */
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}

Should the background service task (wx->service_task) be canceled here
using cancel_work_sync()?

Since WX_STATE_DISABLED is not checked within the service task's
execution path, it appears the task could wake up and attempt to interact
with the device while its MMIO space is disabled.

[ ... ]
> +static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	pci_ers_result_t result;
> +
> +	if (pci_enable_device_mem(pdev)) {
> +		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
> +		result = PCI_ERS_RESULT_DISCONNECT;
> +	} else {
> +		/* make all bar access done before reset. */
> +		smp_mb__before_atomic();
> +		clear_bit(WX_STATE_DISABLED, wx->state);
> +		pci_set_master(pdev);
> +		pci_restore_state(pdev);
> +		pci_wake_from_d3(pdev, false);
> +
> +		wx->do_reset(wx->netdev, false);

Is it safe to call wx->do_reset() here without holding the rtnl_lock()?

Other paths that reset the hardware (such as wx_reset_subtask()) appear
to acquire rtnl_lock() to serialize against concurrent network
configurations.

Could failing to hold the lock here allow concurrent userspace requests
to access hardware registers while the device is in a reset state?

> +		result = PCI_ERS_RESULT_RECOVERED;
> +	}
> +
> +	pci_aer_clear_nonfatal_status(pdev);
> +
> +	return result;
> +}
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

By calling ndo_open() directly instead of dev_open(), is there a risk of
bypassing the core network state machine?

If ndo_open() fails, it cleans up its allocations, but the core network
stack's __LINK_STATE_START bit remains set.

If a user subsequently administratively downs the interface, the network
core might unconditionally call ndo_stop(), potentially leading to a
double-free when it attempts to clean up the already-freed resources.

> +		if (err) {
> +			wx_err(wx, "Failed to open netdev after reset\n");
> +			goto out;
> +		}
> +	}
> +	netif_device_attach(netdev);
> +out:
> +	rtnl_unlock();
> +}
[ ... ]
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
[ ... ]
> @@ -900,6 +901,7 @@ static int txgbe_probe(struct pci_dev *pdev,
>  		goto err_remove_phy;
>  
>  	pci_set_drvdata(pdev, wx);
> +	pci_save_state(pdev);
>  
>  	netif_tx_stop_all_queues(netdev);

This isn't a bug introduced by this patch, but does the ordering here
expose the interface to userspace before queue initialization?

Since register_netdev() is called prior to this code, the interface
becomes visible to userspace.

If a management daemon immediately brings the interface UP, invoking
ndo_open() and waking the TX queues, could this netif_tx_stop_all_queues()
erroneously stop the queues of the logically UP interface, resulting in a
silent TX hang?

