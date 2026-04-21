Return-Path: <netdev+bounces-280173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yqO3Bo6a52lj+QEAu9opvQ
	(envelope-from <netdev+bounces-280173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:41:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5EB43CDE0
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C21F0301DA63
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6613C29B78B;
	Tue, 21 Apr 2026 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjAiXWPy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A0A286881;
	Tue, 21 Apr 2026 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785624; cv=none; b=UGTg/hh/4osM3mdRHr0VFmv8d5BEMmguQY/0KRuV7C2DVFom2w6dTaks2RjFv+alvK7TAQnfOfoy1k8T12c0ACy5w6zT+WIBoTQ1bN6K7wANC99grERt5ezHCO19x/cAdGG+BQkLOdVqQ3ZCVWo5JKHyTAjW4kZpPJiv5renn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785624; c=relaxed/simple;
	bh=4Sszmzpx2V2BISCajffDCQWp9Gs+6VxwpTPPb6dPOnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHWZ5ZmojmGceE3MFmvc5V4GU6XEBqP+zLqdj20t9wjsVbpy6AfyfS+Tha5ZHDHcu3RR2wiQKZs2pzhau/0GFSzszHYvD4KBm8QuyJJ5B4OU11KmOauxbQK/bhwDu2lRUV5cuKwFJxrOVnsY1+y/XwDJddhQmcFx6tjKrPRhFRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjAiXWPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8282C2BCB6;
	Tue, 21 Apr 2026 15:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776785623;
	bh=4Sszmzpx2V2BISCajffDCQWp9Gs+6VxwpTPPb6dPOnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjAiXWPyToc6ocG6wDa5HYqD30waqeTHTI9NHRDj6hImxKtYWPXR4KFQ9bvNqPia8
	 wdtrfNUytrHLt/UgALusMo6SxDEyBttKN/MMjbGMErgy2Om6Pz9LG1AKOv6iefMPcc
	 Ja0X2M/Ozi6rQQIIfrtLhYueFAgBe3rkTVWO7SsdRC7DTOl7R4kiCSAt7XF/gvU7NY
	 12RyM4rf5tPG/tqgA26sblilo759thMlb9KlrE81/Ngt/GYPouaPUpd6miWmGmseyC
	 NvA0sgmD6HOa5HI2mEmRQ7v/42G66zEQzDJcAGIz8AXa36ifPHpqdzwtqaYtpFoEQu
	 aVMkXxKE1p1LQ==
Date: Tue, 21 Apr 2026 16:33:38 +0100
From: Simon Horman <horms@kernel.org>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>, Taegyu Kim <tmk5904@psu.edu>
Subject: Re: [PATCH v1] net: liquidio: resolve VF pci_dev on demand for FLR
 requests
Message-ID: <20260421153338.GE651125@horms.kernel.org>
References: <20260420023304.57105-1-dbgh9129@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420023304.57105-1-dbgh9129@gmail.com>
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[psu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280173-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,lunn.ch,google.com,bootlin.com,linux.dev,suse.com,gmail.com,psu.edu];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.829];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[psu.edu:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: AE5EB43CDE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 10:33:04PM -0400, Yuho Choi wrote:
> The PF SR-IOV enable path caches VF pci_dev pointers in
> dpiring_to_vfpcidev_lut[] by iterating with pci_get_device(). Those
> entries do not own a reference, because the iterator drops the previous
> device reference on each step. The cached pointer is then dereferenced
> later when handling OCTEON_VF_FLR_REQUEST.
> 
> This can leave stale VF pci_dev pointers in the lookup table and makes
> the FLR path rely on a PCI device object whose lifetime is not pinned.
> 
> Drop the long-lived lookup table and resolve the VF pci_dev only when an
> FLR request arrives. Use the PF's SR-IOV metadata to derive the VF's
> bus/devfn, get a referenced pci_dev for immediate use, issue the FLR,
> and then drop the reference.
> 
> Fixes: ca6139ffc67ee ("liquidio CN23XX: sysfs VF config support")
> Fixes: 8c978d059224 ("liquidio CN23XX: Mailbox support")
> Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
> Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>

As this fixes code present in the net tree, it should be targeted
at that tree, like this:

Subject: [PATCH net] ...

In this case the CI defaulted to the net-next tree.
Which might be harmless. But please keep this in mind for next time.

...

> diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
> index ad685f5d0a136..b967c7928b4a7 100644
> --- a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
> +++ b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
> @@ -26,6 +26,29 @@
>  #include "octeon_mailbox.h"
>  #include "cn23xx_pf_device.h"
>  
> +static struct pci_dev *lio_vf_pci_dev_by_qno(struct octeon_device *oct, u32 q_no)
> +{
> +	int vfidx, bus, devfn;
> +
> +	if (!oct->sriov_info.rings_per_vf)
> +		return NULL;
> +
> +	if (q_no % oct->sriov_info.rings_per_vf)
> +		return NULL;
> +
> +	vfidx = q_no / oct->sriov_info.rings_per_vf;
> +	if (vfidx >= oct->sriov_info.num_vfs_alloced)
> +		return NULL;
> +
> +	bus = pci_iov_virtfn_bus(oct->pci_dev, vfidx);

When applied against net-next this causes a linker error with x86_64
allmodconfig (at least) because pci_iov_virtfn_bus is not defined.

> +	devfn = pci_iov_virtfn_devfn(oct->pci_dev, vfidx);
> +	if (bus < 0 || devfn < 0)
> +		return NULL;
> +
> +	return pci_get_domain_bus_and_slot(pci_domain_nr(oct->pci_dev->bus),
> +					   bus, devfn);
> +}
> +
>  /**
>   * octeon_mbox_read:
>   * @mbox: Pointer mailbox

-- 
pw-bot: changes-requested

