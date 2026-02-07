Return-Path: <netdev+bounces-257698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLzKAoijhmkPPgQAu9opvQ
	(envelope-from <netdev+bounces-257698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:29:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C5E104A80
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF6B330A94A4
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 02:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436EA3321BE;
	Sat,  7 Feb 2026 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUNABPud"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810B3314B9;
	Sat,  7 Feb 2026 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770431106; cv=none; b=VeMDu6J+9bYIMznmmGW2+96tyOMP9t03549vcpp04fohptplq3BjiYgX4Fy4UswE9Nymrs58bD2R0RWEKSW0ND6t0W77n2oqLY8ZKs0uL9p9OwnFn+Ns0BbSCP+JMXFY9mZ1itcbIp2urDlTeI7nzDSBIKYM/5aENAd0fcUpi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770431106; c=relaxed/simple;
	bh=O5RxZKcWfHCwHkoJgJXfTdfLHf0/gYoaNp18myJOvQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cs22GXR96wL2vgALF/DGADvZpM8OWl2VvcNR1qqZR6LdA5nlGMnptOalSpXsORvEc57fosXL2Sp2yijTZL2baQ059PbwZ4/CTGneZVJc1ril6B2b4dtDQ/VDE3hXr6FdxrZRNVmOqaCauCAmnariN1PAlkQPqeforhhlc7Fgvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUNABPud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B923C116C6;
	Sat,  7 Feb 2026 02:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770431105;
	bh=O5RxZKcWfHCwHkoJgJXfTdfLHf0/gYoaNp18myJOvQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUNABPud0UlM4VE6XfTRrAPtzDeo2yoRYuj0YfQ6SpiGEBiocep3qMvkGGhREEQ/0
	 lk3WAV+ChzxGEs9NCIs4ba+V7rHBkNR5AK/7VJRSy5kVL3li8KRjXsIWEIutnsg5Mr
	 D3Tq+Q6nCJtIssCN/FFtcR3YKAghePpDHd3yr/S4lJXyJODRBaCVUYI9ID++U8bZhL
	 vPTO0L0InWN5ioX00iaSROy4j3Y4EzqvPncseRNe8om0pTorUsJDF0D064xHw23MF3
	 KqupMeRRx3KcshQHgjL39in7rb7clyUekBXcSQpGwvDZg6tMP10muOILjmYm39fOAM
	 gFa8JfHk8MFaQ==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sam.chen@nebula-matrix.com,
	lukas.bulwahn@redhat.com,
	dimon.zhao@nebula-matrix.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org (open list),
	corbet@lwn.net,
	lorenzo@kernel.org,
	alvin.wang@nebula-matrix.com,
	andrew+netdev@lunn.ch,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org
Subject: Re: [v4,net-next,11/11] net/nebula-matrix: add common dev start/stop operation
Date: Fri,  6 Feb 2026 18:25:03 -0800
Message-ID: <20260207022504.4018024-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206021608.85381-12-illusion.wang@nebula-matrix.com>
References: <20260206021608.85381-12-illusion.wang@nebula-matrix.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-257698-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: A8C5E104A80
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "This is an automated AI code reviewer, please treat what
it says with a grain of salt."

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/nebula-matrix: add common dev start/stop operation

This commit adds MSI-X interrupt initialization for the common device
layer, including configuring MSI-X vector mappings, allocating interrupt
resources, and registering mailbox interrupt handlers.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index 9927dd3a1791..59d23e93e923 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> @@ -14,6 +25,179 @@ static void nbl_dev_register_common_irq(struct nbl_dev_mgt *dev_mgt)
>  	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
>  }
>
> +static int nbl_dev_request_mailbox_irq(struct nbl_dev_mgt *dev_mgt)

[ ... ]

> +static int nbl_dev_configure_msix_map(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +	bool mask_en = msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en;
> +	u16 msix_net_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
> +	u16 msix_not_net_num = 0;
> +	int err, i;
> +
> +	for (i = NBL_MSIX_NET_TYPE; i < NBL_MSIX_TYPE_MAX; i++)
> +		msix_info->serv_info[i].base_vector_id =
> +			msix_info->serv_info[i - 1].base_vector_id +
> +			msix_info->serv_info[i - 1].num;
             ^^^^^^

Does this loop cause an array underflow? NBL_MSIX_NET_TYPE equals 0 (from
the enum in nbl_dev.h), so on the first iteration i=0 and the code accesses
serv_info[-1].

The serv_info array is declared with NBL_MSIX_TYPE_MAX (2) elements in
struct nbl_msix_info, giving valid indices [0,1]. Accessing index -1 reads
uninitialized memory before the array start.

Call chain: nbl_core_start()->nbl_dev_start()->nbl_dev_start_common_dev()
->nbl_dev_configure_msix_map() guarantees this occurs during device start.

Should the loop start at i=1 (NBL_MSIX_MAILBOX_TYPE) instead, or should
serv_info[0].base_vector_id be initialized before the loop?

> +
> +	for (i = NBL_MSIX_MAILBOX_TYPE; i < NBL_MSIX_TYPE_MAX; i++) {

[ ... ]

> +static int nbl_dev_alloc_msix_intr(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +	struct nbl_common_info *common = dev_mgt->common;
> +	int needed = 0;
> +	int err;
> +	int i;
> +
> +	for (i = 0; i < NBL_MSIX_TYPE_MAX; i++)
> +		needed += msix_info->serv_info[i].num;
> +
> +	err = pci_alloc_irq_vectors(common->pdev, needed, needed,
> +				    PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
> +	if (err < 0) {
> +		pr_err("pci_enable_msix_range failed, err = %d.\n", err);
                       ^^^^^^^^

This isn't a bug, but the error message says "pci_enable_msix_range failed"
while the actual function being called is pci_alloc_irq_vectors.

> +		goto enable_msix_failed;
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index a16a685e4f29..55ed560624d3 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> @@ -283,7 +283,38 @@ static struct pci_driver nbl_driver = {
>  	.remove = nbl_remove,
>  };
>
> -module_pci_driver(nbl_driver);
> +static int __init nbl_module_init(void)
> +{
> +	int status;
> +
> +	status = nbl_common_create_wq();
> +	if (status) {
> +		pr_err("Failed to create wq, err = %d\n", status);
> +		goto wq_create_failed;
> +	}
> +	status = pci_register_driver(&nbl_driver);
> +	if (status) {
> +		pr_err("Failed to register PCI driver, err = %d\n", status);
> +		goto pci_register_driver_failed;
> +	}
> +	pr_info("nbl module loaded\n");
> +	return 0;

Previous review feedback from Andrew Lunn on v3 noted that the config is
named 'NBL_CORE' and the module is named 'nbl_core'. He pointed out that
'_CORE' naming is unusual for a driver - CORE is typically a library shared
by multiple drivers. The Kconfig still shows:

config NBL_CORE
	tristate "Nebula-matrix Ethernet Controller m18100 Family support"

Should this be renamed to follow the naming convention for standalone
drivers?

Link: https://lore.kernel.org/netdev/88c7e349-f941-4216-89ca-70a49e82b378@lunn.ch/


Andrew Lunn also noted in v3 that variable declarations should follow
reverse Christmas tree ordering (longest line first). Looking at functions
in this commit like nbl_dev_request_mailbox_irq():

	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
	struct nbl_msix_info *msix_info = &dev_common->msix_info;
	struct nbl_common_info *common = dev_mgt->common;

the declarations are not in reverse Christmas tree order.

Link: https://lore.kernel.org/netdev/c6d37ecd-7dc6-4f83-b76c-2735a5f116fd@lunn.ch/

