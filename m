Return-Path: <netdev+bounces-286117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK/OCKbw/mkdzwAAu9opvQ
	(envelope-from <netdev+bounces-286117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:30:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 612454FEB0A
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48AAB30166EF
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 08:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F83002A0;
	Sat,  9 May 2026 08:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90B2BEC45
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315427; cv=none; b=QuOWIXgmxhug+jAC93EKumC96moZ/uM4dzyWrsBhVHRc92ecMAVYZP86N3fTbhZMmCgFT3jg/WSujHNOGfjhJ3hnLx21vFsLI++5Vn8h0oOArRM00W9VD4zmeUVGFPvoQ2Xvi5RdcEE8sFArrkGBBQoON6D7iNqnNW4JF/v3loM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315427; c=relaxed/simple;
	bh=UmNvH77b0ZWe9BxJ7SSxG9L7kXqbAAbmUNzkthZ+YcE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QgsJxrVdgCOLZ2uOLUTwWRCPXIosaWQhdKIZ4Pd7O29FB3iRzoFHnHJQrkFPsyVlDeHp83szhjroV/FBvxMl1fEVRny0X2TxH2mhYY7oRwE/HXFImnu/hxbgfs02dRs4rBC5vwUJa+vPuGFFALZZaFCTiF3g3JQdGzmJHa2LP98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas1t1778315377t196t31554
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.204.251.157])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 9874354360371735242
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<kees@kernel.org>,
	<larysa.zaremba@intel.com>,
	<leitao@debian.org>,
	<joe@dama.to>,
	<jacob.e.keller@intel.com>,
	<fabio.baltieri@gmail.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<kees@kernel.org>,
	<larysa.zaremba@intel.com>,
	<leitao@debian.org>,
	<joe@dama.to>,
	<jacob.e.keller@intel.com>,
	<fabio.baltieri@gmail.com>
References: <20260430082517.19612-7-jiawenwu@trustnetic.com> <20260503021538.4127382-1-kuba@kernel.org>
In-Reply-To: <20260503021538.4127382-1-kuba@kernel.org>
Subject: RE: [PATCH net-next v2 6/6] net: wangxun: implement pci_error_handlers ops
Date: Sat, 9 May 2026 16:29:35 +0800
Message-ID: <065501dcdf8d$f8473030$e8d59090$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJ1HK6V4TWBBFraiLZyjmkZRUTH8QMLCIbEtLyDZyA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MMKcwIwa79XO1F13dHrZG1/hzkKmzCaulH1aiBntB7TOFLOTHG8tZ4uh
	Q+8P+kk3Pk5KutzxLqoKUCxYY2F1ErYZa69zRXShoEgoVAVO/JjDoXbvuo20de0QFF/XiRf
	HLD+aVSV+Y/JbcOdn/HkR0vFi6+/5sa3W+t1fV+VC1kjJjOeFfdu1k0QhSnc463cQNgSXIo
	zeH4Cl0q1+PJYGyNrqiU9P8tw3Zi+pVkciCCg62mFLHmn6bYpM8pfps3ESG0c8sNe4ukiTH
	vOqa8kjuk2LgLH01fYuL1JkU5AXR3d7xDWid30K6HjnLH4Bw8RD/qTu2OX8pnzYZyHosyjF
	aE7TNr0Y0ZizZN0mmw4jTP9KoaZMI873IpVDixsjn3zWS79Dup4REPePCuL/iwbqp7tm/Sa
	mO4P2yeReSbKRFUT/hnHr7ezQLaIuoXiLbrBPIJMZ1H881Vb5pmP+EW7CfP0n4jHTspTcQL
	Eb2QtpJYrBrXaArUfdcseWihTi9OALnmTZEhFZK0Z1awYeoiFlOQxqB/vq8DLKyQ5sdicae
	dBszR/8ltz3GKZcr7FXWuYeKiCRTwRFXT8AhFqe1+OSASWoyVXatPkRddPCxlHj2plKERYf
	wfGfL/vacaWa+MwNEDmZ1EaBAVvs23AaQ/kShA2N/tEVdTCmamaGHyr4VZdvCXDSFgWlzdc
	iULxlIQnymb8GmTSpPPQ8EILp/op6dSyQ6/x0Sbiyr+I3DtpM2tq44OhdVmzjTsTFiUlo8U
	KBRNsGFJREk/xGhgfQLoAtaYUdZzaxIDbz6UdhDPM+y45DnP5nkII8yO5mmOJIjeNnlsJUG
	HHrHPtH10PMBaVlVlebASMOeziHq9Bid/9n4nuSNgSfE9rwGUa6UFAsSeCIyh01TLtD/Ew6
	qoqe+AJqNJ+6K7Bqi6Y6RqKmA+rZ1sIsotzclhtVwJnYJ6fqQpioN+WBXmvaQvUrn8TYZ3T
	ux+i4m4nraC5F4B4peQ2qUOcMWbKkdhjKhy2JUItpJWTErEA+WI6xQzE0bZu/QlaaB69V5r
	w9kCACoGcpckPxXrIt7FJjnSREXLcfkL4tjzwocBVeKCLpThEh
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 612454FEB0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286117-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,trustnetic.com:server fail];
	RCPT_COUNT_TWELVE(0.00)[31];
	DMARC_NA(0.00)[trustnetic.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,kernel.org,intel.com,debian.org,dama.to];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 3, 2026 10:16 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: wangxun: implement pci_error_handlers ops
> 
> Support AER driver to handle the PCIe errors.
> 
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> [ ... ]
> > +static pci_ers_result_t wx_io_error_detected(struct pci_dev *pdev,
> > +					     pci_channel_state_t state)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +	struct net_device *netdev;
> > +
> > +	netdev = wx->netdev;
> 
> If an AER event triggers during ngbe_probe() or txgbe_probe() before
> pci_set_drvdata() is called, wx will be NULL here.
> 
> Could this lead to a NULL pointer dereference when accessing wx->netdev?
> 
> Should the handler validate the wx pointer, or should pci_set_drvdata()
> be moved earlier in the probe sequence?

I'll validate the wx pointer first.

> 
> > +	if (!netif_device_present(netdev))
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +	rtnl_lock();
> > +	netif_device_detach(netdev);
> > +
> > +	if (netif_running(netdev))
> > +		wx->close_suspend(wx);
> > +
> > +	if (state == pci_channel_io_perm_failure) {
> > +		rtnl_unlock();
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +	}
> 
> Does calling wx->close_suspend(wx) before checking for
> pci_channel_io_perm_failure cause illegal MMIO accesses?
> 
> If the device is in a permanent failure state, it is physically
> disconnected, and MMIO accesses could result in Master Aborts or system
> lockups.
> 
> Should the check for permanent failure precede the hardware teardown?

I'll fix it.

> 
> > +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> > +		pci_disable_device(pdev);
> > +	rtnl_unlock();
> > +
> > +	/* Request a slot reset. */
> > +	return PCI_ERS_RESULT_NEED_RESET;
> > +}
> 
> Should the background service task (wx->service_task) be canceled here
> using cancel_work_sync()?
> 
> Since WX_STATE_DISABLED is not checked within the service task's
> execution path, it appears the task could wake up and attempt to interact
> with the device while its MMIO space is disabled.

Service task is canceled in the device close path, and no event triggers it
when netif is not running.

> 
> [ ... ]
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
> > +		pci_wake_from_d3(pdev, false);
> > +
> > +		wx->do_reset(wx->netdev, false);
> 
> Is it safe to call wx->do_reset() here without holding the rtnl_lock()?
> 
> Other paths that reset the hardware (such as wx_reset_subtask()) appear
> to acquire rtnl_lock() to serialize against concurrent network
> configurations.

I think there is no need to acquire rtnl_lock().

> 
> Could failing to hold the lock here allow concurrent userspace requests
> to access hardware registers while the device is in a reset state?
> 
> > +		result = PCI_ERS_RESULT_RECOVERED;
> > +	}
> > +
> > +	pci_aer_clear_nonfatal_status(pdev);
> > +
> > +	return result;
> > +}
> [ ... ]
> > +static void wx_io_resume(struct pci_dev *pdev)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +	struct net_device *netdev;
> > +	int err;
> > +
> > +	netdev = wx->netdev;
> > +	rtnl_lock();
> > +	if (netif_running(netdev)) {
> > +		err = netdev->netdev_ops->ndo_open(netdev);
> 
> By calling ndo_open() directly instead of dev_open(), is there a risk of
> bypassing the core network state machine?
> 
> If ndo_open() fails, it cleans up its allocations, but the core network
> stack's __LINK_STATE_START bit remains set.
> 
> If a user subsequently administratively downs the interface, the network
> core might unconditionally call ndo_stop(), potentially leading to a
> double-free when it attempts to clean up the already-freed resources.

If ndo_open() fails, the hardware state must have been wrong beyond
recovery. At this point, all further actions are invalid.

> 
> > +		if (err) {
> > +			wx_err(wx, "Failed to open netdev after reset\n");
> > +			goto out;
> > +		}
> > +	}
> > +	netif_device_attach(netdev);
> > +out:
> > +	rtnl_unlock();
> > +}
> [ ... ]
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> [ ... ]
> > @@ -900,6 +901,7 @@ static int txgbe_probe(struct pci_dev *pdev,
> >  		goto err_remove_phy;
> >
> >  	pci_set_drvdata(pdev, wx);
> > +	pci_save_state(pdev);
> >
> >  	netif_tx_stop_all_queues(netdev);
> 
> This isn't a bug introduced by this patch, but does the ordering here
> expose the interface to userspace before queue initialization?
> 
> Since register_netdev() is called prior to this code, the interface
> becomes visible to userspace.
> 
> If a management daemon immediately brings the interface UP, invoking
> ndo_open() and waking the TX queues, could this netif_tx_stop_all_queues()
> erroneously stop the queues of the logically UP interface, resulting in a
> silent TX hang?

I'll consider this in another patch.
Thanks.


