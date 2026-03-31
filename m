Return-Path: <netdev+bounces-273422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHfsBLcby2kEEAYAu9opvQ
	(envelope-from <netdev+bounces-273422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:56:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FEE362E5C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32A1230197C1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5723033E9;
	Tue, 31 Mar 2026 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiL7mWmr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D04302756
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918553; cv=none; b=kyIi0WxNc/oBrczLlQ6IL/bTpW2Bro5BF3+wAyzPyTMcTAEx3FJCLWbfqITpOh62Ho0T3uhWYIckQDcyhm8OTTVynLqY7yIncYsjKbl9j+ZPiR4Prp+rqIgso9Tln2h7ZiwbnpN2nRQX2uDJaw62ghyBdv94Q3/gNxTWhuB0LTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918553; c=relaxed/simple;
	bh=/G4BfT6kJGkx/O87btMe/6GcimNnuxzeJ1d4cXHPB4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5xybCGbiKkTxXSQv6/lf3qFAFsFtMkuKJjUfN4SiGX9yOKehnobjA1UP4D5zm7XZUXYh8HkDaX7+tH2w8NfxOqmKeKZ7G4f4vf715GsjW/mlE1UM7pnquXMHrOO8sKNR+dDu/smhugoa7CS33KKZKPQ2EDpF0eeqlqebpu2cXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiL7mWmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97259C4CEF7;
	Tue, 31 Mar 2026 00:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774918553;
	bh=/G4BfT6kJGkx/O87btMe/6GcimNnuxzeJ1d4cXHPB4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YiL7mWmrRzkiPViiHvMrHIccoy/szDnS4ZhCdm7FCbXhOi4NP3oprmHtdNI9JiZmy
	 shgn5s2XO9g42+nSiU7q5G9qhMhK9//Rp2DcTX1eH1vELdev9rki9G46vVlD+lzdYa
	 ivDS/DBQO0GaBNq6ABSgMUBmHzhiL+2GH69OUqJkBN51dkAxNgr1MSKhtRytCeJBw1
	 OEnXyfA96XaRMwJwQGuHw1ry6hBKg/lJxHA5Cw9RC9TgGcTmFJlardPrBFfNwMTZpq
	 3tEd5URsprQO2ZAM9uWROITNnNRgzwypNtBx3B1Yb1vhI6aEE77KZtGdSgbQX7jNUH
	 RkAA8LiNAWX/g==
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
Subject: Re: [PATCH net-next v6 11/11] net: wangxun: implement pci_error_handlers ops
Date: Mon, 30 Mar 2026 17:55:51 -0700
Message-ID: <20260331005551.3459846-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326021406.30444-12-jiawenwu@trustnetic.com>
References: <20260326021406.30444-12-jiawenwu@trustnetic.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-273422-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51FEE362E5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wangxun: implement pci_error_handlers ops

Support AER driver to handle the PCIe errors for Wangxun devices.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> index bb77bdce69d22..86b318647a3ca 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
[ ... ]
> @@ -3,11 +3,113 @@
>  
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
> +#include <linux/aer.h>
>  
>  #include "wx_type.h"
>  #include "wx_lib.h"
>  #include "wx_err.h"
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
> +		pci_save_state(pdev);
> +		pci_wake_from_d3(pdev, false);
> +
> +		wx->do_reset(wx->netdev, false);

Is it possible that the ngbe driver ignores this hardware reset request?

If ngbe_do_reset() only performs an action when reinit is true, it appears it
would be a no-op when called with false from this AER recovery path. Will
this leave the ngbe MAC hardware uninitialized after the PCI slot reset and
break the device when traffic resumes?

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

Does this code need to check the return value of ndo_open()?

If ndo_open() fails due to memory allocation or IRQ request failures, the
resources will remain unallocated. Because the failure is ignored and
netif_device_attach() is called unconditionally below, will the networking
stack invoke the transmit handler and dereference the unallocated rings?

> +
> +	netif_device_attach(netdev);
> +	rtnl_unlock();
> +}

