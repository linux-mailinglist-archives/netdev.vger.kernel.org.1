Return-Path: <netdev+bounces-256589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mtZ4HxHjgmnXeAMAu9opvQ
	(envelope-from <netdev+bounces-256589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 07:11:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7CEE233F
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 07:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1588D300A62F
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 06:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E145C37416D;
	Wed,  4 Feb 2026 06:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF6E21ADA4
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185484; cv=none; b=IGhSHILinMuTANeMTyvRBIC/+InZG7xYS2goXiuJiYq2jMB7DXoaohBt7tOQjE53RP/ssf7AU3sitcAbAwXinGMHV5DXHzfPIvuNfgZpnzgTk/8kSALvqme/9M3ZUcZVaWia3EVoTZ1HugqGzGOsfy+Mc/rt8Iof+4T7VXXnD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185484; c=relaxed/simple;
	bh=gMfPcmOEGO3dTyXENGot+hkigQgIMegRgneUxq6h4iw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=r+g6BeCUuVGUJ00BY4nimg5MvNbgEFKUw6ELrQL5KRK8m9w0r7KGDAvg2Rne/xjAGIarrl9fZVuByIGIskbDcjHc06A4qOD5Ww7FCYUFH8R0JKq6a3xlEtTxWD23hATx2+WBbTyQo/Bj9RwOMru3gA50BlLfCjfzJILf2wYz1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas3t1770185413t261t32344
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.47.234])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 16790881139121144632
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <mengyuanlou@net-swift.com>,
	<horms@kernel.org>,
	<netdev@vger.kernel.org>,
	<edumazet@google.com>,
	<davem@davemloft.net>,
	<andrew+netdev@lunn.ch>,
	<pabeni@redhat.com>,
	<mengyuanlou@net-swift.com>,
	<horms@kernel.org>,
	<netdev@vger.kernel.org>,
	<edumazet@google.com>,
	<davem@davemloft.net>,
	<andrew+netdev@lunn.ch>,
	<pabeni@redhat.com>
References: <20260203075759.5852-8-jiawenwu@trustnetic.com> <20260204022249.1573252-1-kuba@kernel.org>
In-Reply-To: <20260204022249.1573252-1-kuba@kernel.org>
Subject: RE: [net-next,v1,7/7] net: wangxun: add pcie error handler
Date: Wed, 4 Feb 2026 14:10:12 +0800
Message-ID: <06f201dc959c$ec2b74e0$c4825ea0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKPat9jSedrtKLh0tR0z/2qWgGxxwHDrDINs/5DS8A=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MvyKdZyVtFx3CDHJzTucclEQcIP4e+VPrER/UK+LlBDgXaDt3MguqxAl
	D9m8E3pZkxjVN/AUzXrFRUV2CLa9FfR0Ndr6Dwqxd7DQxlArw/ZoGi+9K/DAK+cVdh3yScU
	r4hwL3m/FIFNgGhQlw0tJFJmPNr/CHR9fvJdVfF7XsJ0rGhOV4JNQ7ftE0F5ZTLG5ljAabi
	zbniFCBC2IBpoXg7G+AcVWlDy3TbDM2pK7d+sEhvKP9/51faGDicr3jx7RlsEVYwJW+KP+4
	iwvhVuqbZTUoNCaB/oN41QK+T2BkjMoNRktNyRmZga/XZd1QFIPkxAtFuyWBAj0njTgAPbJ
	wowyMOj9oabjle/uVehNlwC3+JpnyRChJ/k/NwQZ6K9fq1WO2U9pVwvzPxE5I+trMt4T/ZW
	C3z1abR7ZKZn8AGdK2WcLm08sJz0V0N+9XQJsOHpRxKssb8lw0qkaFo7P/0zP5HHoZ/c3v6
	9j/gm4GkAS2NyoWtdSLb0WARBFBXs5qWWFALg6mk32r/KuuoyeSnvQ43DcVBsmKxOcCdVzJ
	NU5dVmK2NDdJl+4SC3ygKAiyYtQD/L4UUW/2/glnEBAVg+xtdnJKC0jVTHgIXuK+EXK9o2N
	iqVmL5iPxj3r9VkIkN+llNOmuxaHL1tpawSi80EGXGfCILuHc+SGAmeoso8klW91dEvTVZE
	kkGCYMgKieyiyeXDmk5NrCYiDD81E59XPG8rfK9pSUIYouVGbkzrAwFfGjZYMY12CXB5QIL
	4BMkgXjtM6wd+fVynz9LxJzoRo3RgJPNuFmOJ3G39nQvyqM9KxpRYteph0fo+h7nKOKPN+C
	NySdT7csVP/A535WPbh3YoLecnQSyvcdvagCo/ZZSIHIo8a8V3CdW2GA6IHe3sDY3p0pEPT
	H5bK99MNmUlncGlTk44Cof/AS0q5e/ajBN2NLWZZisJcUxCAxxwGGrRJ9DQ5WHamc4ghm+2
	v5jEqh8XvGx3Ss4DfW/Y6CgcKyz8h3a+lj0SkXyYQ/WyumKYQRL+g0JkoOQuTIrsSGZR71m
	ImeB6vN5I1LUSXMbLSfB48VGuYiInsc9vyAiaRz+iZAF2kPt2p4+hdspCWRfCVq6dSEaV4g
	PkLeKmHyXXF
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256589-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid]
X-Rspamd-Queue-Id: 7C7CEE233F
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 10:23 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "Sending this out without checking since you have to
> repost. Please note that the AI code review may be wrong especially
> around defensive programming (which we recommend against)."
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: wangxun: add pcie error handler
> 
> Support to check pcie error and invoke aer driver to recover pcie.
> 
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > index bb77bdce69d2..36eb06bd1798 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> 
> [ ... ]
> 
> > @@ -3,10 +3,228 @@
> >
> >  #include <linux/netdevice.h>
> >  #include <linux/pci.h>
> > +#include <linux/aer.h>
> >
> >  #include "wx_type.h"
> >  #include "wx_lib.h"
> >  #include "wx_err.h"
> > +#include "wx_hw.h"
> > +
> > +/**
> > + * wx_io_error_detected - called when PCI error is detected
> > + * @pdev: Pointer to PCI device
> > + * @state: The current pci connection state
> > + *
> > + * This function is called after a PCI bus error affecting
> > + * this device has been detected.
> > + */
> > +static pci_ers_result_t wx_io_error_detected(struct pci_dev *pdev,
> > +					     pci_channel_state_t state)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +	struct net_device *netdev;
> > +
> > +	netdev = wx->netdev;
> > +	if (!netif_device_present(netdev))
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +	rtnl_lock();
> > +	netif_device_detach(netdev);
> > +
> > +	wx->io_err = true;
> > +	if (netif_running(netdev))
> > +		wx->close_suspend(wx);
> > +
> > +	if (state == pci_channel_io_perm_failure) {
> > +		rtnl_unlock();
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +	}
> > +
> > +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> > +		pci_disable_device(pdev);
> > +	rtnl_unlock();
> > +
> > +	/* Request a slot reset. */
> > +	return PCI_ERS_RESULT_NEED_RESET;
> > +}
> > +
> > +/**
> > + * wx_io_slot_reset - called after the pci bus has been reset.
> > + * @pdev: Pointer to PCI device
> > + *
> > + * Restart the card from scratch, as if from a cold-boot.
> > + */
> > +static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +	pci_ers_result_t result;
> > +
> > +	if (pci_enable_device_mem(pdev)) {
> > +		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
> > +		result = PCI_ERS_RESULT_DISCONNECT;
> > +	} else {
> > +		/* make all bar access done before reset. */
> > +		smp_mb__before_atomic();
> > +		clear_bit(WX_STATE_DISABLED, wx->state);
> > +		pci_set_master(pdev);
> > +		pci_restore_state(pdev);
> > +		pci_save_state(pdev);
> > +		pci_wake_from_d3(pdev, false);
> > +
> > +		wx->do_reset(wx->netdev, false);
> > +		result = PCI_ERS_RESULT_RECOVERED;
> > +	}
> > +
> > +	pci_aer_clear_nonfatal_status(pdev);
> > +
> > +	return result;
> > +}
> > +
> > +/**
> > + * wx_io_resume - called when traffic can start flowing again.
> > + * @pdev: Pointer to PCI device
> > + *
> > + * This callback is called when the error recovery driver tells us that
> > + * its OK to resume normal operation.
> > + */
> > +static void wx_io_resume(struct pci_dev *pdev)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +	struct net_device *netdev;
> > +
> > +	netdev = wx->netdev;
> > +	rtnl_lock();
> > +	if (netif_running(netdev))
> > +		netdev->netdev_ops->ndo_open(netdev);
> > +
> > +	wx->io_err = false;
> > +	netif_device_attach(netdev);
> > +	rtnl_unlock();
> > +}
> > +
> > +const struct pci_error_handlers wx_err_handler = {
> > +	.error_detected = wx_io_error_detected,
> > +	.slot_reset = wx_io_slot_reset,
> > +	.resume = wx_io_resume,
> > +};
> > +EXPORT_SYMBOL(wx_err_handler);
> > +
> > +static bool wx_check_pcie_error(struct wx *wx)
> > +{
> > +	u16 vid, pci_cmd, devctl2;
> > +	u32 value;
> > +
> > +	pci_read_config_word(wx->pdev, PCI_VENDOR_ID, &vid);
> > +	wx_warn(wx, "PCI vendor id is 0x%x\n", vid);
> > +	pci_read_config_word(wx->pdev, PCI_COMMAND, &pci_cmd);
> > +	wx_warn(wx, "PCI command reg is 0x%x\n", pci_cmd);
> > +	pcie_capability_read_word(wx->pdev, PCI_EXP_DEVCTL2, &devctl2);
> > +	wx_warn(wx, "Device Control2 Register: 0x%04x\n", devctl2);
> > +
> > +	value = rd32(wx, WX_MIS_PWR);
> > +	wx_warn(wx, "MIS_PWR value is 0x%08x\n", value);
> > +	value = rd32(wx, WX_PX_IMS(0));
> > +	wx_warn(wx, "PX_IMS0 value is 0x%08x\n", value);
> > +	if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
> > +		value = rd32(wx, WX_PX_IMS(1));
> > +		wx_warn(wx, "PX_IMS1 value is 0x%08x\n", value);
> > +	}
> > +	value = rd32(wx, WX_TDB_TFCS);
> > +	wx_warn(wx, "Tx flow control Status[TDB_TFCS 0xCE00]: 0x%x\n", value);
> > +
> > +	/* PCIe link loss or memory space can't access */
> > +	if (vid == WX_FAILED_READ_CFG_WORD || !(pci_cmd & 0x2))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static void wx_check_error_subtask(struct wx *wx)
> > +{
> > +	u32 sm;
> > +
> > +	if (test_bit(WX_FLAG_ERROR_CHECK, wx->flags)) {
> > +		/* get PF semaphore */
> > +		wr32(wx, WX_MIS_PF_SM, 1);
> > +		clear_bit(WX_FLAG_ERROR_CHECK, wx->flags);
> > +	}
> > +
> > +	sm = rd32(wx, WX_MIS_PF_SM);
> > +	/* PCIe memory space access error */
> > +	if (sm == U32_MAX)
> > +		goto out;
> > +
> > +	/* PCIe error may be occurred in another port */
> > +	if ((sm == 1 && wx_check_first_lan_up(wx)))
> > +		goto out;
> > +
> > +	return;
> > +out:
> > +	set_bit(WX_FLAG_NEED_PCIE_RECOVER, wx->flags);
> > +	wx_warn(wx, "Set PCIe recover on LAN %d\n", wx->bus.func);
> > +}
> > +
> > +static bool wx_check_recovery_capability(struct pci_dev *dev)
> > +{
> > +#if defined(__i386__) || defined(__x86_64__)
> > +	return true;
> > +#else
> > +	/* check upstream bridge is root or PLX bridge,
> > +	 * or if CPU is kunpeng 920
> > +	 */
> > +	if (dev->bus->self->vendor == PCI_VENDOR_ID_PLX ||
> > +	    dev->bus->self->vendor == PCI_VENDOR_ID_HUAWEI)
> 
> Can this dereference dev->bus->self without checking if it's NULL first?
> 
> When the PCI device is directly attached to the root bus, dev->bus->self
> is NULL. On non-x86 platforms, this code checks the upstream bridge
> vendor without verifying that an upstream bridge exists.
> 
> The function comment states "check upstream bridge is root or PLX bridge"
> but the code doesn't actually check for the root bus case. The x86 path
> returns true unconditionally, but the non-x86 path assumes dev->bus->self
> is non-NULL.

I think the comment here should be revised. On the non-x86 path, it should
returns true only when the upstream bridge is PLX or CPU is Kunpeng 920.
When dev->bus->self is null, it is necessary to return false. Although in reality,
it is not null either when device is directly attached to the root bus.

> 
> > +		return true;
> > +	else
> > +		return false;
> > +#endif
> > +}
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > index 3171a98d81a6..653a98d9835b 100644
> > --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > @@ -234,6 +234,12 @@ static irqreturn_t __ngbe_msix_misc(struct wx *wx, u32 eicr)
> >  	if (eicr & NGBE_PX_MISC_IC_VF_MBOX)
> >  		wx_msg_task(wx);
> >
> > +	if (eicr & NGBE_PX_MISC_PCIE_REQ_ERR) {
> > +		wx_warn(wx, "PCIe Request Error founded on Lan %d\n",
> > +			wx->bus.func);
> 
> This isn't a bug, but there's a typo: 'founded' should be 'found'.
> 
> > +		wx_pcie_error_handler(wx);
> > +	}
> > +
> >  	if (unlikely(eicr & NGBE_PX_MISC_IC_TIMESYNC))
> >  		wx_ptp_check_pps_event(wx);
> >
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> > index aa14958d439a..c832100bcb61 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> > @@ -6,6 +6,7 @@
> >
> >  #include "../libwx/wx_type.h"
> >  #include "../libwx/wx_lib.h"
> > +#include "../libwx/wx_err.h"
> >  #include "../libwx/wx_ptp.h"
> >  #include "../libwx/wx_hw.h"
> >  #include "../libwx/wx_sriov.h"
> > @@ -178,6 +179,12 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
> >  		handle_nested_irq(sub_irq);
> >  		nhandled++;
> >  	}
> > +	if (eicr & TXGBE_PX_MISC_PCIE_REQ_ERR) {
> > +		wx_warn(wx, "PCIe Request Error founded on Lan %d\n",
> > +			wx->bus.func);
> 
> This isn't a bug, but there's a typo: 'founded' should be 'found'.
> 
> > +		wx_pcie_error_handler(wx);
> > +		nhandled++;
> > +	}
> >  	if (unlikely(eicr & TXGBE_PX_MISC_IC_TIMESYNC)) {
> >  		wx_ptp_check_pps_event(wx);
> >  		nhandled++;
> 


