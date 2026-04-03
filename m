Return-Path: <netdev+bounces-274829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBX7M2gVz2k2swYAu9opvQ
	(envelope-from <netdev+bounces-274829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:18:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C638FF02
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F8BD303F0AA
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D344279DC2;
	Fri,  3 Apr 2026 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpOM3hIz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B423AB81;
	Fri,  3 Apr 2026 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179058; cv=none; b=jDAcjl0zd4D5g8+y92dm/24oxc/HJsQnbnRQALtrqel0URg0sVexmFYpIFpKLaagHjyt4+VQ9+qyaZt3PFsey+M4Pgl2ZdynvDOi5DRoi67Ppz2Amdic2LeLUsYkK7IOgoYt14TB/wdiWx25cHeSHnaP7wHnOdrVSQYgKvDb9Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179058; c=relaxed/simple;
	bh=kf7UcGQnEKNIFCT4+nJ9PJ/iFdOs9gmUphhDLwEs43I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHOIecvcB6T/VrT4rGvoypFE/jqgJbPs9VXmkPoFC58SPu9uMGR43yXQ4UzmY/0pmhxeM+7PeXWmy7Q3fUx/oGGqnhiYyzdXFggIfG6PZxqFWguJt1kR2PNTD2XUGqJygz4+WFtM58jBFPsTA8YA5ssQislQcgk7HQu4RhtXufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpOM3hIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB46C2BCB1;
	Fri,  3 Apr 2026 01:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179058;
	bh=kf7UcGQnEKNIFCT4+nJ9PJ/iFdOs9gmUphhDLwEs43I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EpOM3hIzOgHfn6BQXuMgZDbLHnn+GT4ShSxODfekzqn5lthwCbFfoafksregEhLy4
	 cCeTkVP8+P2uUqAlLBtV0nQ4ibPJZhB+4gbXEorFRyBI1jKWj7XzfsbPd+Pj9IeuAM
	 sf4dcNEpyFJQ6mYLe+2XAEV3+b1oBeByK0k/DKWPJexgN0GhJmF7JXi7EOc9TvO5ql
	 dfaDKDEZ8c5TDEzZQiqZAVhN1YZbqhogFhp/vbRRIvZBk23bZBJYv6cQEwGldeFhH4
	 1j+y31+Kf55F59Vv2VrNs5IDW01YKEAmS3uVQd59pQhiWiazc1QsboJ6QNFljy9F7R
	 uTy2lZeSSyX4A==
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
Subject: Re: [PATCH v4 net-next 09/14] net: dsa: add NETC switch tag support
Date: Thu,  2 Apr 2026 18:17:36 -0700
Message-ID: <20260403011736.1795610-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-10-wei.fang@nxp.com>
References: <20260331113025.1566878-10-wei.fang@nxp.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-274829-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D45C638FF02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: add NETC switch tag support

Adds support for the proprietary NXP NETC switch tag used in NXP NETC
switches version 4.3 or later. The tag has 3 types (Forward, To_Port,
To_Host) and supports a varying length between 6 and 14 bytes.

> diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
> new file mode 100644
> index 000000000000..addd41f7f1b6
> --- /dev/null
> +++ b/net/dsa/tag_netc.c
[ ... ]
> +static void *netc_fill_common_tp_tag(struct sk_buff *skb,
> +				     struct net_device *ndev,
> +				     u8 subtype, int tag_len)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(ndev);
> +	u16 queue = skb_get_queue_mapping(skb);
> +	u8 ipv = netdev_txq_to_tc(ndev, queue);

What happens here if the interface doesn't have traffic classes configured?

By default, netdev_txq_to_tc() returns -1. Because ipv is an unsigned 8-bit
integer, this casts to 255.

When this is later passed to FIELD_PREP(NETC_TAG_IPV, ipv) in
netc_fill_common_tag(), the macro blindly masks the variable, silently
forcing the IPV field to 7 (the maximum priority) for all default,
unconfigured traffic. Valid TC values greater than 7 would also be silently
truncated.

Does this code bypass the intended QoS mechanisms?

> +	void *tag;
> +
> +	skb_push(skb, tag_len);
> +	dsa_alloc_etype_header(skb, tag_len);
> +
> +	tag = dsa_etype_header_pos_tx(skb);
> +	memset(tag + NETC_TAG_CMN_LEN, 0, tag_len - NETC_TAG_CMN_LEN);
> +	netc_fill_common_tag(tag, NETC_TAG_TO_PORT, subtype,
> +			     dp->ds->index, dp->index, ipv);

Will this break communication for standard single-switch setups?

The driver passes dp->ds->index as the hardware switch ID here, which
defaults to 0 for the first switch in a DSA tree. However, on the receive
path, frames stamped with switch ID 0 are rejected.

If the physical switch hardware uses an ID greater than 0, frames will fail
the lookup in dsa_conduit_find_user() on receive because the software index
is 0.

> +
> +	return tag;
> +}
[ ... ]
> +static struct sk_buff *netc_rcv(struct sk_buff *skb,
> +				struct net_device *ndev)
> +{
> +	struct netc_tag_cmn *tag_cmn;
> +	int tag_len, sw_id, port;
[ ... ]
> +	if (tag_cmn->qos & NETC_TAG_QV)
> +		skb->priority = FIELD_GET(NETC_TAG_IPV, tag_cmn->qos);
> +
> +	sw_id = NETC_TAG_SWITCH & tag_cmn->switch_port;

This isn't a bug, but is there a reason to use a raw bitwise AND for sw_id
instead of using FIELD_GET(NETC_TAG_SWITCH, ...) to match how the port
field is extracted just below this?

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
[ ... ]

