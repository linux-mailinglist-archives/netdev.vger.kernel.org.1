Return-Path: <netdev+bounces-274828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJV7De0Vz2lQswYAu9opvQ
	(envelope-from <netdev+bounces-274828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:20:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 885C538FF98
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ABD83080FAC
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5165D267AF2;
	Fri,  3 Apr 2026 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhn8oIIZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72C1F3D56;
	Fri,  3 Apr 2026 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179058; cv=none; b=ciFD1zEJRA6CxBnsYHS3ao7blnoG561dlZE/0tWP1qxXfzG+y+7n/AsK9TKWzardpca+VLseSwX7yVWi1dUqYuPh+Z9ZLtOfZvvxApWGnVOB4T+k9gOf/GEqO0PkbHgw1dmZywdXJdJr2koWpczo6/AmmZzwSnSOGwQVRmH/bnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179058; c=relaxed/simple;
	bh=IjIkp8FIjKATBd7jIiPxzeFBb13nS3nzbxHI2WLxLcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foxIq2VlkIZt7W3MgruzflSZIzFYTcqm6v5Rj+N6/x7O8zlHJzJnQTtJwU84jh457TZNlqiHiGpdF+v0MsGP9+Op0aQDbl4R99vxXbJPvxnYhARQXUjdbqR8U+A2JnzbpXKVCxvpdg1TIXJ88BytWuQonjeJWKZ/vs7xisQTAko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhn8oIIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBD8C2BCB0;
	Fri,  3 Apr 2026 01:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179053;
	bh=IjIkp8FIjKATBd7jIiPxzeFBb13nS3nzbxHI2WLxLcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bhn8oIIZoi0uI1nny0o2U/uU6bOCJ18EbsQFHJ0o0GygSh3+ENa6fhY3GkI0iCyrk
	 hvVgRxi2ktGgQpzlhRDKy98XX4MVSOAfFRM+p4jch8H2GsIVb9dzK1cGJCOUi5ygf2
	 /zOVHYommileHwaqOG+qtdlo3PjQgRKaJZmBdONj2ZpJKjMzVjNCNRSSYy7nlRanPt
	 ephSAaiMHZ5HoXUqb6WA18U3xq4DgD7nCALIJx9ExdA/06yMAS/aIwjVovYbnsafvJ
	 3F3sK3c3VM8Lr6N0yIRau3XhtEvyeowJ7vTYz5vsTyZehYj057yx8SK4Z0NoGIaukV
	 n1lmuT0ONOs7A==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 net-next 06/14] net: enetc: add support for the "Update" operation to buffer pool table
Date: Thu,  2 Apr 2026 18:17:31 -0700
Message-ID: <20260403011731.1795517-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-7-wei.fang@nxp.com>
References: <20260331113025.1566878-7-wei.fang@nxp.com>
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
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-274828-lists,netdev=lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 885C538FF98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: enetc: add support for the "Update" operation to buffer pool table

This patch adds the ntmp_bpt_update_entry() helper function to support
updating a specified entry in the buffer pool table. It provides the
ability to update buffer pool configuration data.

> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> --- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> +++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h

[ ... ]

> +/* Buffer Pool Table Request Data Buffer Format of Update action */
> +struct bpt_req_update {
> +	struct ntmp_req_by_eid rbe;
> +	struct bpt_cfge_data cfge;
> +};
> +

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
> --- a/drivers/net/ethernet/freescale/enetc/ntmp.c
> +++ b/drivers/net/ethernet/freescale/enetc/ntmp.c

[ ... ]

> @@ -702,5 +708,38 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
>  }
>  EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
>  
> +int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
> +			  const struct bpt_cfge_data *cfge)
> +{
> +	struct ntmp_dma_buf data = {
> +		.dev = user->dev,
> +		.size = sizeof(struct bpt_req_update),
> +	};
> +	struct bpt_req_update *req;
> +	union netc_cbd cbd;
> +	int err;
> +
> +	err = ntmp_alloc_data_mem(&data, (void **)&req);
> +	if (err)
> +		return err;
> +
> +	ntmp_fill_crd_eid(&req->rbe, user->tbl.bpt_ver, 0,
> +			  NTMP_GEN_UA_CFGEU | BPT_UA_BPSEU, entry_id);

Does this update action mask match the size of the request buffer?

The mask includes both NTMP_GEN_UA_CFGEU and BPT_UA_BPSEU, which instructs
the hardware to update both the configuration entry and the status entry.
However, struct bpt_req_update only contains the configuration data,
omitting the status data.

If the hardware attempts to read the missing BPSE data, could it reject
the command due to an undersized request length, or read beyond the
intended payload into zero-initialized DMA padding? This might overwrite
critical buffer pool tracking variables like amount_used_hwm.

If only the configuration is being updated, should the BPT_UA_BPSEU flag
be removed?

> +	req->cfge = *cfge;
> +	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(data.size, 0),
> +			      NTMP_BPT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
> +
> +	err = netc_xmit_ntmp_cmd(user, &cbd);
> +	if (err)
> +		dev_err(user->dev,
> +			"Failed to update %s entry 0x%x, err: %pe\n",
> +			ntmp_table_name(NTMP_BPT_ID), entry_id, ERR_PTR(err));
> +
> +	ntmp_free_data_mem(&data);

Can this result in a DMA use-after-free if the hardware command times out?

If netc_xmit_ntmp_cmd() times out waiting for the hardware to process the
command, it returns -ETIMEDOUT without resetting the hardware ring or
explicitly cancelling the command.

The descriptor remains active in the ring, and ntmp_free_data_mem()
unconditionally frees the DMA-mapped buffer. If the hardware eventually
processes the descriptor, it will read from the now-freed DMA memory.

Could this lead to an IOMMU fault or cause the hardware to read garbage
data if the page has been reallocated?

> +
> +	return err;
> +}

