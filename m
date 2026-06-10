Return-Path: <netdev+bounces-297737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jxfQH0+FKWo9YgMAu9opvQ
	(envelope-from <netdev+bounces-297737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:39:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 502AF66AE40
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:39:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KPKnr69O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297737-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297737-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1F3F3028AD3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2018A3D8918;
	Wed, 10 Jun 2026 15:35:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E530352003;
	Wed, 10 Jun 2026 15:35:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105747; cv=none; b=KJMN9ofmOrrhSWNtlKdwUBLB3GLv3+mP6DbyBKCb4gL1tzzY23rB9beGuSlcj7KFEGCV2gp4acLw/mW56HmwjhYNliEE/yaI3paDU9M7t1m2zyrjjj3Z3HZPC8FMe+JqNLDMd5Xr+DFp5YqcxlsAjVoPkuGqqSMlUkaFp0RESSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105747; c=relaxed/simple;
	bh=VtshOWRTdhBq7cyq4VD6EjdN/YDisPTWdZvCJkgZu88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjBCOSrTtsiB3jlgTua/qyxRa0cLKZ7p1RgI4CJKXqOelEcwwhHQJ/62uZkh9FMZzNRyO18SXMljO0NQ9qBT9467HneU5B7Wm5NNR0vBMy2d8wbg8EPTdAboPTebG+sSSxDayDYRZKRnZiuKOyojo5xjv9icM1/NbYpt1Z93Jzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPKnr69O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F21B1F00893;
	Wed, 10 Jun 2026 15:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105746;
	bh=Ww6bCvxOileVZW2P/NfL7I2CLtavMpnRN0+79/WS85E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KPKnr69OKuGQmKXjEgizX57ZHmcZ6MKWc2WM/2wh/jC17K3xggkah0yN3S7QkFTni
	 kcuDS/umKsyhf0jWFuPZiooZFidqC0bOObcsqiK66qwKQ8T+oAvv6f21tzliMCccSv
	 Unpl3DNgVpfhPx3dleaUknod9SYOBRl1rCXxwGjVeCiVuufQpll/N+14XfOe74fmwE
	 2NCyVIXokoHew5VL0/oFOP11run5iRjAkakUEKkKFy6vWB6MEgXfIaNDegiclp3Uei
	 nL8JDZ19K23SF7jrI+U6NUuCeS+tkWhqtWWkCbe8BdTKYTQUWN6uHNW+/KZiwseNkU
	 w51+tZPO7aXYQ==
Date: Wed, 10 Jun 2026 08:35:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, hariprasad
 <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 <nshettyj@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [PATCH net-next v2] octeontx2-af: Fix PCI device reference
 leaks in debugfs
Message-ID: <20260610083544.0da95356@kernel.org>
In-Reply-To: <20260608165546.61347-1-dbgh9129@gmail.com>
References: <20260608165546.61347-1-dbgh9129@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297737-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dbgh9129@gmail.com,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nshettyj@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 502AF66AE40

On Mon,  8 Jun 2026 12:55:46 -0400 Yuho Choi wrote:
> cgx_print_stats(), cgx_print_dmac_flt(), and cgx_print_fwdata()
> look up the RVU AF device with pci_get_device() and pass the returned
> pointer directly to pci_get_drvdata().  pci_get_device() returns a PCI
> device with an elevated reference count, so the lookup reference is
> leaked on every debugfs read.
> 
> Store the returned PCI device pointer, check it before reading driver
> data, and release the lookup reference after pci_get_drvdata(). In
> cgx_print_dmac_flt(), release the AF lookup reference before reusing
> pdev for pci_get_domain_bus_and_slot().
> 
> Fixes: f967488d095e ("octeontx2-af: Add per CGX port level NIX Rx/Tx counters")
> Fixes: dbc52debf95f ("octeontx2-af: Debugfs support for DMAC filters")
> Fixes: 49f02e6877d1 ("Octeontx2-af: Debugfs support for firmware data")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>

Marvell, please review patches from external contributors promptly.

Review question sort of based on a Sashiko comment - this is part of
the rvu device driver, AFAIU, does anything prevent the AF from getting
removed (via sysfs for instance) while this code is using its priv?

> Changes in v2:
> - Keep using the local RVU AF pdev returned by pci_get_device() instead
>   of cgx->pdev, because cgx->pdev belongs to the CGX/RPM device.
> - Rebase on current net-next so netdev CI can apply the patch.
>  .../marvell/octeontx2/af/rvu_debugfs.c        | 31 +++++++++++++++----
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index fa461489acdd..04ba091773b6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -2838,9 +2838,16 @@ static int cgx_print_stats(struct seq_file *s, int lmac_id)
>  	int stat = 0, err = 0;
>  	u64 tx_stat, rx_stat;
>  	struct rvu *rvu;
> +	struct pci_dev *pdev = NULL;
> +
> +	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
> +			      PCI_DEVID_OCTEONTX2_RVU_AF, NULL);
> +	if (!pdev)
> +		return -ENODEV;
> +
> +	rvu = pci_get_drvdata(pdev);
> +	pci_dev_put(pdev);
>  
> -	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
> -					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
>  	if (!rvu)
>  		return -ENODEV;
>  
> @@ -2958,8 +2965,13 @@ static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
>  	u64 cfg, mac;
>  	int pf;
>  
> -	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
> -					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
> +	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
> +			      PCI_DEVID_OCTEONTX2_RVU_AF, NULL);
> +	if (!pdev)
> +		return -ENODEV;
> +
> +	rvu = pci_get_drvdata(pdev);
> +	pci_dev_put(pdev);
>  	if (!rvu)
>  		return -ENODEV;
>  
> @@ -3014,9 +3026,16 @@ static int cgx_print_fwdata(struct seq_file *s, int lmac_id)
>  	struct phy_s *phy;
>  	struct rvu *rvu;
>  	int cgx_id, i;
> +	struct pci_dev *pdev = NULL;
> +
> +	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
> +			      PCI_DEVID_OCTEONTX2_RVU_AF, NULL);
> +	if (!pdev)
> +		return -ENODEV;
> +
> +	rvu = pci_get_drvdata(pdev);
> +	pci_dev_put(pdev);
>  
> -	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
> -					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
>  	if (!rvu)
>  		return -ENODEV;
>  


