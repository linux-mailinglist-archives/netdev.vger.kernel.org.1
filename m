Return-Path: <netdev+bounces-271186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAzXER3CwmmjlQQAu9opvQ
	(envelope-from <netdev+bounces-271186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:55:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E13723197C0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 716A5302E32A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DCE3D7D77;
	Tue, 24 Mar 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTiI3B0t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F49E38F92A;
	Tue, 24 Mar 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371268; cv=none; b=tOqplr+9IWiR5PwQFOZaLW2Sr76MYO6f3WTa80C7qknvTUc2e4kcp81VqS9v8eCiSK56YYE/r1Ul7GwSO+M5/hNhDPO4bt+eDlKvOH9NWTA09hHCEn7pcGE9wgheIsCXIKA+gUhe2VxJcJsHUHRW/axUcKzR3iNLtLYUsUGz94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371268; c=relaxed/simple;
	bh=6XwTfsRWoS93cnxOuZ3FgxopYlNBweflJgztMgNywtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r285Ml2UmlwOmyGKoaycXIObA044009SOxX5IVw7oV4F02HfXkAcvFZkJtoI2HopKBCVmD4g2T/nscm7crbD2O+4RMNbXl0BZ/s1unyi9qy1NkzeHhnFom0LJgB/dmRQmbuQqrJw4EKaQ4sKxQoCJPFWf3y6TX48ZtIyCtbGxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTiI3B0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D065C19424;
	Tue, 24 Mar 2026 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774371268;
	bh=6XwTfsRWoS93cnxOuZ3FgxopYlNBweflJgztMgNywtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTiI3B0tekb0ODeo1RRtl5msPPkbfMkXmTJ3L5ORFH0Itzy3wlIM6tAAVk5QydB4B
	 KaEOgbhfEsTubYPztwrfV8TY2GzNK2kaGJhKFBK8P9ajQPv6TPESIT5cEiYhpX4vMs
	 xJSTkDI/eiuQOmX5b4SLYwqM2m2DXtgflsXglqPxTRwxXHmGiNDdeORax6MiiZBbvQ
	 QfwBicuahSCqk0hOc/D7Gzvq83/OgDVE9irHbTzKBnK/mW9buEG3HVRovKQC+Nzn+F
	 2pk4cJMey8KfztKJEuaqv8pziQvEaBid24S6q+oZU+7Rptxc7EbtGiaLNQ7t0sjOw3
	 PpfVdS4/xXupw==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	andrew@lunn.ch,
	vladimir.oltean@nxp.com,
	frank.li@nxp.com,
	pabeni@redhat.com,
	conor+dt@kernel.org,
	xiaoning.wang@nxp.com,
	davem@davemloft.net,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kuba@kernel.org,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	f.fainelli@gmail.com,
	claudiu.manoil@nxp.com,
	netdev@vger.kernel.org,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 net-next 09/14] net: dsa: add NETC switch tag support
Date: Tue, 24 Mar 2026 16:54:15 +0000
Message-ID: <20260324165415.243214-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323060752.1157031-10-wei.fang@nxp.com>
References: <20260323060752.1157031-10-wei.fang@nxp.com>
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
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,nxp.com,redhat.com,davemloft.net,lists.infradead.org,lists.linux.dev,google.com,armlinux.org.uk,gmail.com,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-271186-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: E13723197C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: add NETC switch tag support

This commit introduces support for the NXP NETC switch tag protocol,
a proprietary header used by NETC switches. The tag supports three
types (Forward, To_Port, and To_Host) with variable length (6-14 bytes).

> diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
> new file mode 100644
> index 000000000000..fe964722e5b0
> --- /dev/null
> +++ b/include/linux/dsa/tag_netc.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright 2025-2026 NXP
> + */
> +
> +#ifndef __NET_DSA_TAG_NETC_H
> +#define __NET_DSA_TAG_NETC_H
> +
> +#include <linux/skbuff.h>
> +#include <net/dsa.h>
> +
> +#define NETC_TAG_MAX_LEN			14
> +
> +#endif

[ ... ]

> diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
> new file mode 100644
> index 000000000000..15b0dd5c5408
> --- /dev/null
> +++ b/net/dsa/tag_netc.c

[ ... ]

> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025-2026 NXP
> + */
> +
> +#include <linux/dsa/tag_netc.h>
> +
> +#include "tag.h"
> +
> +#define NETC_NAME			"nxp_netc"
> +
> +/* Forward NXP switch tag */
> +#define NETC_TAG_FORWARD		0
> +
> +/* To_Port NXP switch tag */
> +#define NETC_TAG_TO_PORT		1
> +/* SubType0: No request to perform timestamping */
> +#define NETC_TAG_TP_SUBTYPE0		0
> +
> +/* To_Host NXP switch tag */
> +#define NETC_TAG_TO_HOST		2
> +/* SubType0: frames redirected or copied to CPU port */
> +#define NETC_TAG_TH_SUBTYPE0		0
> +/* SubType1: frames redirected or copied to CPU port with timestamp */
> +#define NETC_TAG_TH_SUBTYPE1		1
> +/* SubType2: Transmit timestamp response (two-step timestamping) */
> +#define NETC_TAG_TH_SUBTYPE2		2
> +
> +/* NETC switch tag lengths */
> +#define NETC_TAG_FORWARD_LEN		6
> +#define NETC_TAG_TP_SUBTYPE0_LEN	6
> +#define NETC_TAG_TH_SUBTYPE0_LEN	6
> +#define NETC_TAG_TH_SUBTYPE1_LEN	14
> +#define NETC_TAG_TH_SUBTYPE2_LEN	14
> +#define NETC_TAG_CMN_LEN		5
> +
> +#define NETC_TAG_SUBTYPE		GENMASK(3, 0)
> +#define NETC_TAG_TYPE			GENMASK(7, 4)
> +#define NETC_TAG_QV			BIT(0)
> +#define NETC_TAG_IPV			GENMASK(4, 2)
> +#define NETC_TAG_SWITCH			GENMASK(2, 0)
> +#define NETC_TAG_PORT			GENMASK(7, 3)
> +
> +struct netc_tag_cmn {
> +	__be16 tpid;
> +	u8 type;
> +	u8 qos;
> +	u8 switch_port;
> +} __packed;

[ ... ]

> +static int netc_get_rx_tag_len(int rx_type)
> +{
> +	int type = FIELD_GET(NETC_TAG_TYPE, rx_type);
> +
> +	if (type == NETC_TAG_TO_HOST) {
> +		u8 subtype = rx_type & NETC_TAG_SUBTYPE;
> +
> +		if (subtype == NETC_TAG_TH_SUBTYPE1)
> +			return NETC_TAG_TH_SUBTYPE1_LEN;
> +		else if (subtype == NETC_TAG_TH_SUBTYPE2)
> +			return NETC_TAG_TH_SUBTYPE2_LEN;
> +		else
> +			return NETC_TAG_TH_SUBTYPE0_LEN;
> +	}
> +
> +	return NETC_TAG_FORWARD_LEN;
> +}
> +
> +static struct sk_buff *netc_rcv(struct sk_buff *skb,
> +				struct net_device *ndev)
> +{
> +	struct netc_tag_cmn *tag_cmn = dsa_etype_header_pos_rx(skb);
> +	int tag_len = netc_get_rx_tag_len(tag_cmn->type);
                                             ^^^^^^^^^^^^

Is the tag header guaranteed to be in the linear region of the skb?
Looking at other EtherType-based DSA tag drivers (tag_ar9331, tag_lan9303,
tag_dsa, tag_edsa, tag_a5psw, tag_brcm_legacy, tag_mxl-gsw1xx,
tag_gswip, and tag_mtk), they all call pskb_may_pull() before accessing
tag data to ensure the header is linearized.

For example, tag_ar9331.c:

static struct sk_buff *ar9331_tag_rcv(struct sk_buff *skb,
                                      struct net_device *ndev)
{
    if (unlikely(!pskb_may_pull(skb, AR9331_HDR_LEN)))
        return NULL;
    ...
}

Similarly, tag_lan9303.c:

static struct sk_buff *lan9303_rcv(struct sk_buff *skb,
                                   struct net_device *ndev)
{
    if (unlikely(!pskb_may_pull(skb, LAN9303_TAG_LEN)))
        return NULL;
    ...
}

Without this check, netc_rcv() accesses tag_cmn->type, tag_cmn->tpid,
tag_cmn->qos, and tag_cmn->switch_port before verifying these bytes are
linearized. The struct netc_tag_cmn is 5 bytes, with 3 bytes at
skb->data through skb->data+2 that may not be guaranteed to be in the
linear region.

Additionally, netc_get_rx_tag_len() can return up to 14 bytes
(NETC_TAG_TH_SUBTYPE1_LEN or NETC_TAG_TH_SUBTYPE2_LEN), and this value
is passed directly to skb_pull_rcsum():

> +	int tag_len = netc_get_rx_tag_len(tag_cmn->type);
> +	int sw_id, port;
> +
> +	if (ntohs(tag_cmn->tpid) != ETH_P_NXP_NETC) {
> +		dev_warn_ratelimited(&ndev->dev, "Unknown TPID 0x%04x\n",
> +				     ntohs(tag_cmn->tpid));
> +
> +		return NULL;
> +	}
> +
> +	if (tag_cmn->qos & NETC_TAG_QV)
> +		skb->priority = FIELD_GET(NETC_TAG_IPV, tag_cmn->qos);
> +
> +	sw_id = NETC_TAG_SWITCH & tag_cmn->switch_port;
> +	/* ENETC VEPA switch ID (0) is not supported yet */
> +	if (!sw_id) {
> +		dev_warn_ratelimited(&ndev->dev,
> +				     "VEPA switch ID is not supported yet\n");
> +
> +		return NULL;
> +	}
> +
> +	port = FIELD_GET(NETC_TAG_PORT, tag_cmn->switch_port);
> +	skb->dev = dsa_conduit_find_user(ndev, sw_id, port);
> +	if (!skb->dev)
> +		return NULL;
> +
> +	if (tag_cmn->type == NETC_TAG_FORWARD)
> +		dsa_default_offload_fwd_mark(skb);
> +
> +	/* Remove Switch tag from the frame */
> +	skb_pull_rcsum(skb, tag_len);
                     ^^^^^^^^^^^^^^^^^^

The skb_pull_rcsum() function contains BUG_ON(len > skb->len). If a
truncated or malformed packet arrives with fewer than tag_len bytes
remaining, the kernel will panic rather than gracefully handling the
error.

Should a check like this be added at the beginning of netc_rcv():

if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN - 2)))
    return NULL;

The -2 would account for the EtherType bytes already consumed by
eth_type_trans().

> +	dsa_strip_etype_header(skb, tag_len);
> +
> +	return skb;
> +}

[ ... ]

