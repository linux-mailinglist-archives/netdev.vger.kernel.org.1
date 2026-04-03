Return-Path: <netdev+bounces-274830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDv1J/wVz2lQswYAu9opvQ
	(envelope-from <netdev+bounces-274830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:21:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A8D38FFA8
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 757773088E84
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F3D27FD76;
	Fri,  3 Apr 2026 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5kzfYmJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568E3273D76;
	Fri,  3 Apr 2026 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179058; cv=none; b=WQCIdTLZfE4p3Qn1kZ9se9MtWggUHgsIqDBM65WIq8WFvRpIjj6dWCkaIHBtYgI3G8xT+wsdPEWEL1im5wds1ity5FYx56xi6EEx+40YWn7pB1+SaE6IBVT9+O7Qp6Wl71suLLyt4eGD/cXGd5d9vsjsnEUnOMhB/SBry9tK5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179058; c=relaxed/simple;
	bh=Cge0Op8XIjIL/FzyaMsXywj9bmxHOydn7s7dSUzb2ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uchYg6YQ7USgoJazxIf+Sjg8DMSNJCqd9oJVdQ5eFflgeQhS4EDuSxsUT++9OH8/caqvttcyw0G7PTWi85NlIne6blrB23xBXJ5DHRY7xR9eOr5pFGWVG9yLvVURzly3MjZRgOFfeSvgyxHLB5rnTOwmNNFTbkNvaOXO4sJ+oK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5kzfYmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC915C116C6;
	Fri,  3 Apr 2026 01:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179056;
	bh=Cge0Op8XIjIL/FzyaMsXywj9bmxHOydn7s7dSUzb2ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5kzfYmJPKBNdvO3nSJvsyoJ+PIyPCXGESJxAhYTppge05ohd0x0Wt2nOzWHT8HpD
	 G/sNU1YrW1igNY4qpp3/oDubDsCWQ5VlEJNCuQ6EDkf7VCDmVu/HWtLZuf+RZ8DqMz
	 pG3xZBdt9MPpY6CLzz/SXzaiiBW+u8IRILNPbOS54Zsc4DbVFfCW+MXe7T6oX1EoDl
	 4cMjrv26Aj4zKWKrj6rLudiYP+3gDzLA4GmnKMNL4Fi2V4EYRDpM2shV3fyvtaR/yX
	 VS1PRrC+gvrDGDFpS2SzA+EGwM1HEgW0Q5vA/St5Hxd4xKwe7jNAbklo1alVpWM6wC
	 SfLNbxj5oarTw==
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
Subject: Re: [PATCH v4 net-next 07/14] net: enetc: add support for "Add" and "Delete" operations to IPFT
Date: Thu,  2 Apr 2026 18:17:34 -0700
Message-ID: <20260403011734.1795551-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-8-wei.fang@nxp.com>
References: <20260331113025.1566878-8-wei.fang@nxp.com>
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
	TAGGED_FROM(0.00)[bounces-274830-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 17A8D38FFA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: enetc: add support for "Add" and "Delete" operations to IPFT

This commit adds support for the "Add" and "Delete" operations to the
ingress port filter table (IPFT). These interfaces will be used by both
the ENETC driver and the NETC switch driver.

> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
> index 3c59b355c142..960d5be8ec42 100644
> --- a/drivers/net/ethernet/freescale/enetc/ntmp.c
> +++ b/drivers/net/ethernet/freescale/enetc/ntmp.c

[ ... ]

> @@ -468,6 +471,79 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
>  }
>  EXPORT_SYMBOL_GPL(ntmp_rsst_query_entry);
>  
> +/**
> + * ntmp_ipft_add_entry - add an entry into the ingress port filter table
> + * @user: target ntmp_user struct
> + * @entry: the entry data, entry->cfge (configuration element data) and
> + * entry->keye (key element data) are used as input. Since the entry ID
> + * is assigned by the hardware, so entry->entry_id is a returned value
> + * for the driver to use, the driver can update/delete/query the entry
> + * based on the entry_id.
> + *
> + * Return: 0 on success, otherwise a negative error code
> + */
> +int ntmp_ipft_add_entry(struct ntmp_user *user,
> +			struct ipft_entry_data *entry)
> +{
[ ... ]
> +	err = ntmp_alloc_data_mem(&data, (void **)&req);
> +	if (err)
> +		return err;
> +
> +	ntmp_fill_crd(&req->crd, user->tbl.ipft_ver, NTMP_QA_ENTRY_ID,
> +		      NTMP_GEN_UA_CFGEU | NTMP_GEN_UA_STSEU);
> +	req->ak.keye = entry->keye;
> +	req->cfge = entry->cfge;

The request sets NTMP_GEN_UA_STSEU to indicate statistics data is present,
but struct ipft_req_ua does not appear to contain a match_count or STSE data
field before cfge.

Since the hardware expects STSE data before CFGE data (as seen in
struct ipft_resp_query), will this cause the hardware to misinterpret the
first 8 bytes of cfge as the match_count, and then read the actual filter
configuration from out-of-bounds or uninitialized memory?

> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> index 7d50af7745c7..6d519d59a433 100644
> --- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> +++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h

[ ... ]

> +/* Ingress Port Filter Table Request Data Buffer Format of Update and
> + * Add actions
> + */
> +struct ipft_req_ua {
> +	struct ntmp_cmn_req_data crd;
> +	union ipft_access_key ak;
> +	struct ipft_cfge_data cfge;
> +};

Does this struct need an STSE data field before cfge to match the request
header flags?

> diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
> index a54945dcdc61..efda35e5e22c 100644
> --- a/include/linux/fsl/ntmp.h
> +++ b/include/linux/fsl/ntmp.h

[ ... ]

> @@ -66,6 +68,94 @@ struct maft_entry_data {
>  	struct maft_cfge_data cfge;
>  };
>  
> +struct ipft_pld_byte {
> +	u8 data;
> +	u8 mask;
> +};
> +
> +struct ipft_keye_data {
> +	__le16 precedence;
> +	__le16 resv0[3];
> +	__le16 frm_attr_flags;
> +#define IPFT_FAF_OVLAN		BIT(2)
> +#define IPFT_FAF_IVLAN		BIT(3)
> +#define IPFT_FAF_IP_HDR		BIT(7)
> +#define IPFT_FAF_IP_VER6	BIT(8)
> +#define IPFT_FAF_L4_CODE	GENMASK(11, 10)
> +#define  IPFT_FAF_TCP_HDR	1
> +#define  IPFT_FAF_UDP_HDR	2
> +#define  IPFT_FAF_SCTP_HDR	3
> +#define IPFT_FAF_WOL_MAGIC	BIT(12)
> +	__le16 frm_attr_flags_mask;
> +	__le16 dscp;
> +#define IPFT_DSCP		GENMASK(5, 0)
> +#define IPFT_DSCP_MASK		GENMASK(11, 0)

Does IPFT_DSCP_MASK completely overlap with IPFT_DSCP?

If it is defined as GENMASK(11, 0) instead of GENMASK(11, 6), using
FIELD_PREP with this mask will not shift the value into the upper bits,
which might overwrite the actual DSCP value in bits 0-5.

