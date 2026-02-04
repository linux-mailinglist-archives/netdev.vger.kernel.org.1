Return-Path: <netdev+bounces-256517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN8AMsKtgmliYAMAu9opvQ
	(envelope-from <netdev+bounces-256517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:24:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CF7E0CDE
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B54E3015FF6
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 02:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC8A2C21F4;
	Wed,  4 Feb 2026 02:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEiFP84c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6902D3EC1
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770171771; cv=none; b=bCa6WgKBgTHPe3Ew+BeL/20DbDljjeuPGiZNnHmlZIBgQqzN0JEBENhJ7nCl8RTad/UM5ToN60ilFKeu84WgxZNhOMVrGcV0Q5JZg8XcKoM13lovghmps0o2thssBef9LqXVE3/cfEimGGe9mi2NqBT1qenkOpCJMEsKSKITPOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770171771; c=relaxed/simple;
	bh=SViS4lZ0xq0E4xAxfJXUr87PRZ3PH8y2ZoVq4TmAE+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqnNfSXiuP3w3Gr4gVS4DCHT+v8K8GsiX95jQTFI/DRKxiNEokbDH1xjWxuSNRDSL6hKFYIEygT3Qxh5aLxbKxUdpXOZLGALaTbrSBUeW+os+ZEcbPkeFzoKxh8ZjBqmgLl9kskqn3NOu8F8eiAIArF2hE+vyo4xanI6L7I9KS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEiFP84c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A013C2BC86;
	Wed,  4 Feb 2026 02:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770171770;
	bh=SViS4lZ0xq0E4xAxfJXUr87PRZ3PH8y2ZoVq4TmAE+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEiFP84c06JjltiLCGENv6ioFwWgBW6983tGfEqFJZsKrX3KffJkA67T8d8L3RZPi
	 evTh0rC7FeqYasEEOJ/3FD5Tj22jsXwT/KQuGMtsPbw7wzWd9fbh73ZPlPTLgfG2Tl
	 U7RKg1QChiKXsRkE6tZy1OEqUJvGxF77iCBbepepFtqlxdhk0fc/kB0Gl1yPuls2SS
	 KqSeBsDCFBvqZqbTpdVMc3XFIgkBbj/GHpcILzN8In/cApqSM0HIvGlK90ktPTglOB
	 Frs2Le00in1WIa5vYgLtbFKbgCkHYjxx3l0ftnz08vNcJfHcWe5/5VPhomUTDRmo5+
	 nss4d9yedP/5w==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	mengyuanlou@net-swift.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com
Subject: Re: [net-next,v1,7/7] net: wangxun: add pcie error handler
Date: Tue,  3 Feb 2026 18:22:49 -0800
Message-ID: <20260204022249.1573252-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203075759.5852-8-jiawenwu@trustnetic.com>
References: <20260203075759.5852-8-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256517-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 43CF7E0CDE
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "Sending this out without checking since you have to
repost. Please note that the AI code review may be wrong especially
around defensive programming (which we recommend against)."

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: wangxun: add pcie error handler

Support to check pcie error and invoke aer driver to recover pcie.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> index bb77bdce69d2..36eb06bd1798 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c

[ ... ]

> @@ -3,10 +3,228 @@
>
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
> +#include <linux/aer.h>
>
>  #include "wx_type.h"
>  #include "wx_lib.h"
>  #include "wx_err.h"
> +#include "wx_hw.h"
> +
> +/**
> + * wx_io_error_detected - called when PCI error is detected
> + * @pdev: Pointer to PCI device
> + * @state: The current pci connection state
> + *
> + * This function is called after a PCI bus error affecting
> + * this device has been detected.
> + */
> +static pci_ers_result_t wx_io_error_detected(struct pci_dev *pdev,
> +					     pci_channel_state_t state)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	struct net_device *netdev;
> +
> +	netdev = wx->netdev;
> +	if (!netif_device_present(netdev))
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	rtnl_lock();
> +	netif_device_detach(netdev);
> +
> +	wx->io_err = true;
> +	if (netif_running(netdev))
> +		wx->close_suspend(wx);
> +
> +	if (state == pci_channel_io_perm_failure) {
> +		rtnl_unlock();
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +
> +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> +		pci_disable_device(pdev);
> +	rtnl_unlock();
> +
> +	/* Request a slot reset. */
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}
> +
> +/**
> + * wx_io_slot_reset - called after the pci bus has been reset.
> + * @pdev: Pointer to PCI device
> + *
> + * Restart the card from scratch, as if from a cold-boot.
> + */
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
> +		pci_save_state(pdev);
> +		pci_wake_from_d3(pdev, false);
> +
> +		wx->do_reset(wx->netdev, false);
> +		result = PCI_ERS_RESULT_RECOVERED;
> +	}
> +
> +	pci_aer_clear_nonfatal_status(pdev);
> +
> +	return result;
> +}
> +
> +/**
> + * wx_io_resume - called when traffic can start flowing again.
> + * @pdev: Pointer to PCI device
> + *
> + * This callback is called when the error recovery driver tells us that
> + * its OK to resume normal operation.
> + */
> +static void wx_io_resume(struct pci_dev *pdev)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	struct net_device *netdev;
> +
> +	netdev = wx->netdev;
> +	rtnl_lock();
> +	if (netif_running(netdev))
> +		netdev->netdev_ops->ndo_open(netdev);
> +
> +	wx->io_err = false;
> +	netif_device_attach(netdev);
> +	rtnl_unlock();
> +}
> +
> +const struct pci_error_handlers wx_err_handler = {
> +	.error_detected = wx_io_error_detected,
> +	.slot_reset = wx_io_slot_reset,
> +	.resume = wx_io_resume,
> +};
> +EXPORT_SYMBOL(wx_err_handler);
> +
> +static bool wx_check_pcie_error(struct wx *wx)
> +{
> +	u16 vid, pci_cmd, devctl2;
> +	u32 value;
> +
> +	pci_read_config_word(wx->pdev, PCI_VENDOR_ID, &vid);
> +	wx_warn(wx, "PCI vendor id is 0x%x\n", vid);
> +	pci_read_config_word(wx->pdev, PCI_COMMAND, &pci_cmd);
> +	wx_warn(wx, "PCI command reg is 0x%x\n", pci_cmd);
> +	pcie_capability_read_word(wx->pdev, PCI_EXP_DEVCTL2, &devctl2);
> +	wx_warn(wx, "Device Control2 Register: 0x%04x\n", devctl2);
> +
> +	value = rd32(wx, WX_MIS_PWR);
> +	wx_warn(wx, "MIS_PWR value is 0x%08x\n", value);
> +	value = rd32(wx, WX_PX_IMS(0));
> +	wx_warn(wx, "PX_IMS0 value is 0x%08x\n", value);
> +	if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
> +		value = rd32(wx, WX_PX_IMS(1));
> +		wx_warn(wx, "PX_IMS1 value is 0x%08x\n", value);
> +	}
> +	value = rd32(wx, WX_TDB_TFCS);
> +	wx_warn(wx, "Tx flow control Status[TDB_TFCS 0xCE00]: 0x%x\n", value);
> +
> +	/* PCIe link loss or memory space can't access */
> +	if (vid == WX_FAILED_READ_CFG_WORD || !(pci_cmd & 0x2))
> +		return true;
> +
> +	return false;
> +}
> +
> +static void wx_check_error_subtask(struct wx *wx)
> +{
> +	u32 sm;
> +
> +	if (test_bit(WX_FLAG_ERROR_CHECK, wx->flags)) {
> +		/* get PF semaphore */
> +		wr32(wx, WX_MIS_PF_SM, 1);
> +		clear_bit(WX_FLAG_ERROR_CHECK, wx->flags);
> +	}
> +
> +	sm = rd32(wx, WX_MIS_PF_SM);
> +	/* PCIe memory space access error */
> +	if (sm == U32_MAX)
> +		goto out;
> +
> +	/* PCIe error may be occurred in another port */
> +	if ((sm == 1 && wx_check_first_lan_up(wx)))
> +		goto out;
> +
> +	return;
> +out:
> +	set_bit(WX_FLAG_NEED_PCIE_RECOVER, wx->flags);
> +	wx_warn(wx, "Set PCIe recover on LAN %d\n", wx->bus.func);
> +}
> +
> +static bool wx_check_recovery_capability(struct pci_dev *dev)
> +{
> +#if defined(__i386__) || defined(__x86_64__)
> +	return true;
> +#else
> +	/* check upstream bridge is root or PLX bridge,
> +	 * or if CPU is kunpeng 920
> +	 */
> +	if (dev->bus->self->vendor == PCI_VENDOR_ID_PLX ||
> +	    dev->bus->self->vendor == PCI_VENDOR_ID_HUAWEI)

Can this dereference dev->bus->self without checking if it's NULL first?

When the PCI device is directly attached to the root bus, dev->bus->self
is NULL. On non-x86 platforms, this code checks the upstream bridge
vendor without verifying that an upstream bridge exists.

The function comment states "check upstream bridge is root or PLX bridge"
but the code doesn't actually check for the root bus case. The x86 path
returns true unconditionally, but the non-x86 path assumes dev->bus->self
is non-NULL.

> +		return true;
> +	else
> +		return false;
> +#endif
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 3171a98d81a6..653a98d9835b 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -234,6 +234,12 @@ static irqreturn_t __ngbe_msix_misc(struct wx *wx, u32 eicr)
>  	if (eicr & NGBE_PX_MISC_IC_VF_MBOX)
>  		wx_msg_task(wx);
>
> +	if (eicr & NGBE_PX_MISC_PCIE_REQ_ERR) {
> +		wx_warn(wx, "PCIe Request Error founded on Lan %d\n",
> +			wx->bus.func);

This isn't a bug, but there's a typo: 'founded' should be 'found'.

> +		wx_pcie_error_handler(wx);
> +	}
> +
>  	if (unlikely(eicr & NGBE_PX_MISC_IC_TIMESYNC))
>  		wx_ptp_check_pps_event(wx);
>

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> index aa14958d439a..c832100bcb61 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> @@ -6,6 +6,7 @@
>
>  #include "../libwx/wx_type.h"
>  #include "../libwx/wx_lib.h"
> +#include "../libwx/wx_err.h"
>  #include "../libwx/wx_ptp.h"
>  #include "../libwx/wx_hw.h"
>  #include "../libwx/wx_sriov.h"
> @@ -178,6 +179,12 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
>  		handle_nested_irq(sub_irq);
>  		nhandled++;
>  	}
> +	if (eicr & TXGBE_PX_MISC_PCIE_REQ_ERR) {
> +		wx_warn(wx, "PCIe Request Error founded on Lan %d\n",
> +			wx->bus.func);

This isn't a bug, but there's a typo: 'founded' should be 'found'.

> +		wx_pcie_error_handler(wx);
> +		nhandled++;
> +	}
>  	if (unlikely(eicr & TXGBE_PX_MISC_IC_TIMESYNC)) {
>  		wx_ptp_check_pps_event(wx);
>  		nhandled++;

