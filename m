Return-Path: <netdev+bounces-296007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +rNgII9tI2qUtwEAu9opvQ
	(envelope-from <netdev+bounces-296007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 02:45:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8444D64C0C7
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 02:45:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A5F0Vg54;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296007-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296007-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FAF4300C3B5
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 00:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7498B23394E;
	Sat,  6 Jun 2026 00:44:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC57233938;
	Sat,  6 Jun 2026 00:44:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780706698; cv=none; b=by/5nvvOF/lbvvbHDwYLqilt5t0dP0u1CQJ29CxqLnRVEFUhI+/oIwbqY2BIDPB+7lGqVbzCwWNerHxlCbJ88oRfp6viGgHGpAb+xxaGwh7SW9J2/PGbOPqVLi7sYfodFxP18PJBE4I4bYyuljqDrVDSENoVHe2vSwsjnhXvSDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780706698; c=relaxed/simple;
	bh=Y2FFh+aPah8I1Y8ik5nP4QyqDVX9pGTt6sh1NyTglf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYLUVpX3IqUjtv2EcT90lcv48n4qYDirzbLwYyar0PMcUwzAXcu3tml3xNATK18mPX7IaKkcvqlZAWw5kCASqC/Q6x32tbCDFDmH+jb65cJRWPIJVO8IXrvsj7YdJqp1JeHq4wixLSx5p+IOVeZ/+jvfu4qbPqZLeAZnFkOsPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5F0Vg54; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8659C1F00893;
	Sat,  6 Jun 2026 00:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780706697;
	bh=/D+An8IeHhHDaFNnqyy/svJ6dYDVwU/h0zfqDkHVgnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A5F0Vg54I9k9DO3lDluBD+8oTxIZ26bRvSBZJIAi2mSXxGXx0iNPTgJGbh7K/yxDw
	 gtPbFibBQAHC5KGmCx0tI34DRCuNkauCqTxoNqC6AO2txJ2B4RPsTQkJXwnbjyyr+o
	 HrXltTfNc/AXqTU5LAoAS8zDVpoSDuvL28d4LOD9fAd9td9E/6Dot0KOMtp77eUnRV
	 B/A9iJ4on9zdRiLfqCY0BgJ881WtHe+G8A4+Zuj6j/wJSj4o2TTet6vUvTIslJt7Iq
	 VQtluJq+HcE+4JuRlM3/M77mdF2XJWpb4AnXMuMQP/wksMOlaNGQGwAG+A65QwZ8k7
	 JU2+UNkPX5eJg==
From: Jakub Kicinski <kuba@kernel.org>
To: shaojijie@huawei.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shenjian15@huawei.com,
	liuyonglong@huawei.com,
	chenhao418@huawei.com,
	huangdonghua3@h-partners.com,
	yangshuaisong@h-partners.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net-next 4/6] net: hns3: support IP and tunnel VNI dissectors for tc flow
Date: Fri,  5 Jun 2026 17:44:55 -0700
Message-ID: <20260606004455.4016108-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602133337.2216918-5-shaojijie@huawei.com>
References: <20260602133337.2216918-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-296007-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shaojijie@huawei.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8444D64C0C7

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: hns3: support IP and tunnel VNI dissectors for tc flow

This patch adds support for FLOW_DISSECTOR_KEY_IP for ip_tos and 
FLOW_DISSECTOR_KEY_ENC_KEYID for outer_tun_vni in the HNS3 driver's TC flow 
dissection. It also explicitly marks user defined tuples as unused.

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index aa85abda29096..3559b471b3feb 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c

[ ... ]

> @@ -5760,6 +5763,17 @@ static bool hclge_fd_convert_tuple(u32 tuple_bit, u8 *key_x, u8 *key_y,
>  		*(__le32 *)key_x = cpu_to_le32(tmp_x_l);
>  		*(__le32 *)key_y = cpu_to_le32(tmp_y_l);
>  
> +		return true;
> +	case KEY_OPT_VNI:
> +		calc_x(tmp_x_l, *(u32 *)(&p[offset]), *(u32 *)(&p[moffset]));
> +		calc_y(tmp_y_l, *(u32 *)(&p[offset]), *(u32 *)(&p[moffset]));
> +		for (i = 0; i < HCLGE_VNI_LENGTH; i++) {
> +			key_x[i] = ((__force u32)cpu_to_le32(tmp_x_l) >>
> +				    (i * BITS_PER_BYTE)) & 0xFF;
> +			key_y[i] = ((__force u32)cpu_to_le32(tmp_y_l) >>
> +				    (i * BITS_PER_BYTE)) & 0xFF;

[Severity: Medium]
On big-endian architectures, cpu_to_le32() byte-swaps the integer. If we
apply an arithmetic right-shift to a byte-swapped integer here, won't it
extract the bytes in the wrong order and drop the least significant byte?

For example, a 24-bit VNI of 0x123456 becomes 0x56341200 after swapping.
Shifting it right extracts 0x00, 0x12, and 0x34, entirely missing the 0x56
byte. Should this code shift the host-endian integer directly before
applying the mask?

> +		}
> +
>  		return true;
>  	default:
>  		return false;

[ ... ]

> @@ -7340,6 +7354,53 @@ static void hclge_get_cls_key_port(const struct flow_rule *flow,

[ ... ]

> +static void hclge_get_cls_key_ip_tos(const struct flow_rule *flow,
> +				     struct hclge_fd_rule *rule)
> +{
> +	if (flow_rule_match_key(flow, FLOW_DISSECTOR_KEY_IP)) {
> +		struct flow_match_ip match;
> +
> +		flow_rule_match_ip(flow, &match);
> +
> +		rule->tuples.ip_tos = match.key->tos;
> +		rule->tuples_mask.ip_tos = match.mask->tos;
> +		if (!rule->tuples_mask.ip_tos)
> +			rule->unused_tuple |= BIT(INNER_IP_TOS);

[Severity: High]
Since FLOW_DISSECTOR_KEY_IP is now added to the allowed keys list in
hclge_check_cls_flower(), the networking stack could pass rules containing
TTL constraints (match.mask->ttl).

Does this code silently ignore match.mask->ttl?

If the user requests a specific TTL match, the driver appears to successfully
extract the tos field but completely ignores the ttl constraint. Could this
cause the hardware filter to match broader traffic than intended, essentially
bypassing the user's intent? Should it return an error if an unsupported
TTL match is requested?

> +	} else {
> +		rule->unused_tuple |= BIT(INNER_IP_TOS);
> +	}
> +}

