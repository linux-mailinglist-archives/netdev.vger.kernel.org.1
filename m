Return-Path: <netdev+bounces-255271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNw3Drc/fWmoRAIAu9opvQ
	(envelope-from <netdev+bounces-255271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 00:33:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 946C4BF62C
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 00:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B73B303A87F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 23:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A9637F75C;
	Fri, 30 Jan 2026 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8jb+ZAd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972C436AB6E
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769815963; cv=none; b=n3FF1FhSD/9Xwv5wjNvn7fUhllh+wUB678cXGB+EM48ydDKbZ/cpRNRFr9LUg/3/v/kQ8syI1cH671xYy2R4IBakBfBR71jj7ixz6OPF+IpB+EmWoU+QWS8t5y661BG77R6kKVUbThVJ/4gJeeqt8IWyrFr3e+F0+vd9T4wU/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769815963; c=relaxed/simple;
	bh=6U9OU5A3NjcdwIMlwwJcqoImx31A7Y8n29mJ0r3GYX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckPuZXpSG2Ao49ym8JqCDyAouurcs6U0vvZBpzfRGj5OuFYTHB3ccE9GfoFutqYr6e/jRkrH5V3TVfhrziqirqDhDXLM+nJY2asBDugDDvBvahYtMgFt3VkXdZX0uyKoXC+wHdsut+S8RFLH4dMthlymCBQwJL+EOkMjUsDnd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8jb+ZAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E75C16AAE;
	Fri, 30 Jan 2026 23:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769815963;
	bh=6U9OU5A3NjcdwIMlwwJcqoImx31A7Y8n29mJ0r3GYX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R8jb+ZAdOIN6rkrAOVS6SJX0YQWjwLRgh0bqQImwV90zSu4uxQ4UhjIxWfOa3nup2
	 /kyV0fea5e5I/sZvFqrknvsYsoX0it69RsvCCHv/9S61mB2zp8wXTj+/qGs5VgiClQ
	 GFdSxl7T10wJWt6yp/BPmYod6m/dkVPzqDipp0Iv6UarE/1lrIOEKkmKiRXzC9uXk/
	 1fAfM9EbpoMH/Y53Rzh0G9mX2XgJ2ayLDdaaPPtVrLNIIE+R8KiQ7r1AqMioZyl00T
	 rkl3yClM6c5XUXmR+Is/ihHjiS5MLNPa9fam3pk1F0t3E2Dt+3XKTTG20eGskAYyPD
	 yTQdFOJscBRfw==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	lulie@linux.alibaba.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	guwen@linux.alibaba.com,
	dong100@mucse.com,
	lukas.bulwahn@redhat.com,
	vadim.fedorenko@linux.dev,
	enelsonmoore@gmail.com
Subject: Re: [net-next,v24,2/6] eea: introduce ring and descriptor structures
Date: Fri, 30 Jan 2026 15:32:41 -0800
Message-ID: <20260130233241.923359-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130093412.98407-3-xuanzhuo@linux.alibaba.com>
References: <20260130093412.98407-3-xuanzhuo@linux.alibaba.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,linux.alibaba.com,google.com,davemloft.net,redhat.com,vger.kernel.org,mucse.com,linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-255271-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 946C4BF62C
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
eea: introduce ring and descriptor structures

This commit introduces the ring and descriptor implementations for the
Alibaba Elastic Ethernet Adapter (EEA). These structures and ring APIs
are used by the RX, TX, and admin queues.

> diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/ethernet/alibaba/eea/Makefile
> index cf2acf1733fd..e5e4007810a6 100644
> --- a/drivers/net/ethernet/alibaba/eea/Makefile
> +++ b/drivers/net/ethernet/alibaba/eea/Makefile
> @@ -1,3 +1,4 @@
>
>  obj-$(CONFIG_EEA) += eea.o
> -eea-y := eea_pci.o
> +eea-y :=  eea_ring.o \
> +	eea_pci.o

[ ... ]

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_desc.h b/drivers/net/ethernet/alibaba/eea/eea_desc.h
> new file mode 100644
> index 000000000000..541346a03375
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_desc.h
> @@ -0,0 +1,156 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Driver for Alibaba Elastic Ethernet Adapter.
> + *
> + * Copyright (C) 2025 Alibaba Inc.
> + */
> +
> +#ifndef __EEA_DESC_H__
> +#define __EEA_DESC_H__
> +
> +#define EEA_DESC_TS_MASK GENMASK(47, 0)
> +#define EEA_DESC_TS(desc) (le64_to_cpu((desc)->ts) & EEA_DESC_TS_MASK)
> +
> +struct eea_aq_desc {
> +	__le16 flags;
> +	__le16 id;
> +	__le16 reserved;
> +	u8 classid;
> +	u8 command;
> +	__le64 data_addr;
> +	__le64 reply_addr;
> +	__le32 data_len;
> +	__le32 reply_len;
> +};
> +
> +struct eea_aq_cdesc {
> +	__le16 flags;
> +	__le16 id;
> +#define EEA_OK     0
> +#define EEA_ERR    0xffffffff
> +	__le32 status;
> +	__le32 reply_len;
> +	__le32 reserved1;
> +
> +	__le64 reserved2;
> +	__le64 reserved3;
> +};

[ ... ]

> +struct eea_rx_desc {
> +	__le16 flags;
> +	__le16 id;
> +	__le16 len;
> +	__le16 reserved1;
> +
> +	__le64 addr;
> +
> +	__le64 hdr_addr;
> +	__le32 reserved2;
> +	__le32 reserved3;
> +};

[ ... ]

> +struct eea_rx_cdesc {
> +#define EEA_DESC_F_DATA_VALID	BIT(6)
> +#define EEA_DESC_F_SPLIT_HDR	BIT(5)
> +	__le16 flags;
> +	__le16 id;
> +	__le16 len;
> +#define EEA_NET_PT_NONE      0
> +#define EEA_NET_PT_IPv4      1
> +#define EEA_NET_PT_TCPv4     2
> +#define EEA_NET_PT_UDPv4     3
> +#define EEA_NET_PT_IPv6      4
> +#define EEA_NET_PT_TCPv6     5
> +#define EEA_NET_PT_UDPv6     6
> +#define EEA_NET_PT_IPv6_EX   7
> +#define EEA_NET_PT_TCPv6_EX  8
> +#define EEA_NET_PT_UDPv6_EX  9
> +	/* [9:0] is packet type. */
> +	__le16 type;
> +
> +	/* hw timestamp [0:47]: ts */
> +	__le64 ts;
> +
> +	__le32 hash;
> +
> +	/* 0-9: hdr_len  split header
> +	 * 10-15: reserved1
> +	 */
> +	__le16 len_ex;
> +	__le16 reserved2;
> +
> +	__le32 reserved3;
> +	__le32 reserved4;
> +};

[ ... ]

> +struct eea_tx_desc {
> +#define EEA_DESC_F_DO_CSUM	BIT(6)
> +	__le16 flags;
> +	__le16 id;
> +	__le16 len;
> +	__le16 reserved1;
> +
> +	__le64 addr;
> +
> +	__le16 csum_start;
> +	__le16 csum_offset;
> +	u8 gso_type;
> +	u8 reserved2;
> +	__le16 gso_size;
> +	__le64 reserved3;
> +};
> +
> +struct eea_tx_cdesc {
> +	__le16 flags;
> +	__le16 id;
> +	__le16 len;
> +	__le16 reserved1;
> +
> +	/* hw timestamp [0:47]: ts */
> +	__le64 ts;
> +	__le64 reserved2;
> +	__le64 reserved3;
> +};

[ ... ]

> +struct eea_db_direct {
> +	u8 kick_flags;
> +	u8 reserved;
> +	__le16 idx;
> +
> +	__le16 tx_cq_head;
> +	__le16 rx_cq_head;
> +
> +	u8 desc[24];
> +};
> +
> +static_assert(sizeof(struct eea_rx_desc) == 32, "rx desc size does not match");
> +static_assert(sizeof(struct eea_rx_cdesc) == 32,
> +	      "rx cdesc size does not match");
> +static_assert(sizeof(struct eea_tx_desc) == 32, "tx desc size does not match");
> +static_assert(sizeof(struct eea_tx_cdesc) == 32,
> +	      "tx cdesc size does not match");
> +static_assert(sizeof(struct eea_db_direct) == 32,
> +	      "db direct size does not match");
> +#endif

This isn't a bug, but should there be similar static_assert checks for
struct eea_aq_desc and struct eea_aq_cdesc? The other DMA descriptor
structures (eea_rx_desc, eea_rx_cdesc, eea_tx_desc, eea_tx_cdesc,
eea_db_direct) all have static_assert checks to verify their 32-byte
sizes. The admin queue descriptors are also 32-byte DMA structures with
hardware-defined layouts, so adding the checks would be consistent with
the pattern used for the other descriptors.

[ ... ]

