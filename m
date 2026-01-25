Return-Path: <netdev+bounces-253241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJvRChKYdmnmSgEAu9opvQ
	(envelope-from <netdev+bounces-253241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:24:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D3582AE8
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECE973004236
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3E830CDB0;
	Sun, 25 Jan 2026 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIjzzD21"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CE32066F7;
	Sun, 25 Jan 2026 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769379854; cv=none; b=MwFRcip4lexnVCYSTOnxyh5HJJrCTIrOeKNaBAoSk/t5IWDiuiXd/N0KmoDGIkygDH8TqFPs/toiVImW9VC13FwQWAeJLIV6Spn4UqlvwAY8VWFYBTbGqGuWYnCV4BOfAsDsumv0o5tP5oKcp5MuQmW4SjMdlN8owbH49AxbzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769379854; c=relaxed/simple;
	bh=aqwDfEl3OsQCXcTsY1GsUP9RGTeKfiCCD49yw57iyfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y81RZSsLSbPkoGPT+iD7vl0yZtJ4l4LnFtdDihpJqc5nJ7jmtAiS6RbQV61E/sjrXcP46GofPXH8M5RXL5LQVaaMEEaPyLJPz7wi7KH+zo7Ff/yhnBwRkalKqH0jseCHAYOgaUVBM58dXJUs70uJx9r9OPCbaD+Vm90szpvn7lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIjzzD21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EEBC4CEF1;
	Sun, 25 Jan 2026 22:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769379854;
	bh=aqwDfEl3OsQCXcTsY1GsUP9RGTeKfiCCD49yw57iyfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QIjzzD21vmrnh2B23r9Ih6f75xFIQZWCsaKAzh1sqQgTp+BXZk6C5C2lvGWWGDjWH
	 PkNgs06x+V2oyyR3FTMxS32H+LCyxDgc+wBZwGwFhpWqvRorcH9Y5+aZlZuZWRpT3B
	 Pkk03Wz0aJlJ7iluDCvLJ+heAu3lmPTun3t0ZC0sLHUBkkeij6hvFdxJ2RD3ut+7id
	 mEy6txeUt9bMTtgvXrtzKzcP3V0MH9xFtdOjRSBWhbiwz1Kbm6JP1OQC5nVNkaBJKy
	 XG/6bf7JqzcHTz3lD1IKeHetMF775oaGDk4xwU6D9x1wqkCegB2H1BKKsIdrcO0v8t
	 R2wgNDye6tDuw==
Date: Sun, 25 Jan 2026 14:24:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <sgoutham@marvell.com>, <gakula@marvell.com>,
 <jerinj@marvell.com>, <lcherian@marvell.com>, <sbhatta@marvell.com>,
 <naveenm@marvell.com>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <bbhushan2@marvell.com>
Subject: Re: [net-next PatchV4 2/2] Octeontx2-pf: Add support for
 DMAC_FILTER trap
Message-ID: <20260125142412.20b37981@kernel.org>
In-Reply-To: <20260123104731.2710019-3-hkelam@marvell.com>
References: <20260123104731.2710019-1-hkelam@marvell.com>
	<20260123104731.2710019-3-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253241-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85D3582AE8
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 16:17:31 +0530 Hariprasad Kelam wrote:
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -3282,6 +3282,10 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (err)
>  		goto err_mcam_flow_del;
>  
> +	err = otx2_devlink_traps_register(pf);
> +	if (err)
> +		goto err_unregister_dl;
> +
>  	/* Initialize SR-IOV resources */
>  	err = otx2_sriov_vfcfg_init(pf);
>  	if (err)
> @@ -3314,6 +3318,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	otx2_sriov_vfcfg_cleanup(pf);
>  err_pf_sriov_init:
>  	otx2_shutdown_tc(pf);
> +err_unregister_dl:
> +	otx2_unregister_dl(pf);

Hm, you're still not calling otx2_devlink_traps_unregister()
anywhere in this unwind ladder. If the missing otx2_unregister_dl()
is a pre-existing bug please send a separate fix (to net?) to address
that, and then this series on top.

>  err_mcam_flow_del:
>  	otx2_mcam_flow_del(pf);
>  err_unreg_netdev:
> @@ -3514,6 +3520,7 @@ static void otx2_remove(struct pci_dev *pdev)
>  	/* Disable link notifications */
>  	otx2_cgx_config_linkevents(pf, false);
>  
> +	otx2_devlink_traps_unregister(pf);
>  	otx2_unregister_dl(pf);
-- 
pw-bot: cr

