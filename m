Return-Path: <netdev+bounces-264985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFlgLWV6q2kSdgEAu9opvQ
	(envelope-from <netdev+bounces-264985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:07:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7FD2293E5
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17D38302254C
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 01:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B78328488D;
	Sat,  7 Mar 2026 01:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQw9Ptko"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDF2283CB5;
	Sat,  7 Mar 2026 01:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845635; cv=none; b=q3JGbD44gyvJ2uO7KDCTQxpQQsS2Z3zrSG6HMdqRsIarobRRqIuE7tnsMGEiiQSO00Q7vWQnt8GW08EurFMGlL08bIjw/Dfh9uXzXZ0rIs8WFU+RjkfnkJa1ZeTBYLmIfdxG1Id1Z4syr403Pn+F+bx6imhKLunPZ+qWhjbUH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845635; c=relaxed/simple;
	bh=Z3YZwyJrXN/NeYMO6VTjbYDWD/KaZW0vv2xGuqUVEug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTmdrc7J8oWl3LZiGvZD6NNWpDi5iLzznf+82smkR6yEfFa6pKb/L0gjPulv/Yttcuku2P1bwlWvvY1Le/8IazHs5Bfew19PGBJQKULGdpT61MvbpT+tF6q+0TIPVI3d3DB8lP3/0nps5JYgeXvPQHcOwGKFcPnQGEm9XWRGLFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQw9Ptko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08492C4CEF7;
	Sat,  7 Mar 2026 01:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772845634;
	bh=Z3YZwyJrXN/NeYMO6VTjbYDWD/KaZW0vv2xGuqUVEug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQw9Ptko/8layZyOD5EIeuzG4MBD2Yuwej6mZsOY1D/jGynMzSmJ5SnOxn7xqaLE4
	 0LREWuIJFdloGclTGEs5bq2fwAp0IPs1hqD9pJlXl/Rk1qHBb3a8alLPDgcVLynRnQ
	 V49jOnInv2o6s9pDajLgQpuxGFScLRn1d1ItMuPwxLrBVel8zV+qBz8jhSpn/myOII
	 KW+pXuLDvwuxapUf8nng3CUCctOQlOCIez80s0ResjuxNMYTyMLGEOxdiRfc9vDwb7
	 CmLWYPDOEHLBz9KpYenQ7H6XGQ1ux7RxdhC1XD2cQUd3bS6veLd38Ehj9mhWlGwofs
	 t3hp7cDBLt4SA==
From: Jakub Kicinski <kuba@kernel.org>
To: cedric.jehasse@luminex.be
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	pabeni@redhat.com,
	horms@kernel.org,
	edumazet@google.com,
	olteanv@gmail.com,
	jiri@resnulli.us,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	jhs@mojatatu.com,
	davem@davemloft.net
Subject: Re: [net-next,v6,2/2] net: dsa: mv88e6xxx: Add partial support for TCAM entries
Date: Fri,  6 Mar 2026 17:07:12 -0800
Message-ID: <20260307010712.1201087-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305-net-next-mv88e6xxx-tcam-v6-2-32c7fbac129d@luminex.be>
References: <20260305-net-next-mv88e6xxx-tcam-v6-2-32c7fbac129d@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3A7FD2293E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,redhat.com,google.com,gmail.com,resnulli.us,armlinux.org.uk,vger.kernel.org,mojatatu.com,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264985-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: mv88e6xxx: Add partial support for TCAM entries

This patch adds partial Ternary Content Addressable Memory (TCAM) for
the mv88e6390 and mv88e6393 family of switches, allowing the switch to
match the first 48 or 96 bytes of a frame and take actions on matched
frames. This introduces a subset of TCAM functionality: matching on IP
addresses/protocol and trapping to the cpu.

> diff --git a/drivers/net/dsa/mv88e6xxx/Makefile b/drivers/net/dsa/mv88e6xxx/Makefile
> index dd961081d631..b0b08c6f159c 100644
> --- a/drivers/net/dsa/mv88e6xxx/Makefile
> +++ b/drivers/net/dsa/mv88e6xxx/Makefile
> @@ -21,6 +21,8 @@ mv88e6xxx-objs += serdes.o
>  mv88e6xxx-objs += smi.o
>  mv88e6xxx-objs += switchdev.o
>  mv88e6xxx-objs += trace.o
> +mv88e6xxx-objs += tcflower.o
> +mv88e6xxx-objs += tcam.o

[ ... ]

> diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
> index 66b1b7277281..38616a2f8de3 100644
> --- a/drivers/net/dsa/mv88e6xxx/port.c
> +++ b/drivers/net/dsa/mv88e6xxx/port.c
> @@ -1380,7 +1380,32 @@ int mv88e6xxx_port_disable_learn_limit(struct mv88e6xxx_chip *chip, int port)
>
>  int mv88e6xxx_port_disable_pri_override(struct mv88e6xxx_chip *chip, int port)
>  {
> -	return mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_PRI_OVERRIDE, 0);
> +	u16 reg;
> +	int err;
> +
> +	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_PRI_OVERRIDE,
> +				  &reg);
> +	if (err)
> +		return err;
> +
> +	reg &= MV88E6XXX_PORT_PRI_OVERRIDE_TCAM_MODE_MASK;
> +	return mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_PRI_OVERRIDE,
> +				    reg);
> +}
> +
> +int mv88e6xxx_port_enable_tcam(struct mv88e6xxx_chip *chip, int port)
> +{
> +	u16 reg;
> +	int err;
> +
> +	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_PRI_OVERRIDE,
> +				  &reg);
> +	if (err)
> +		return err;
> +
> +	reg |= MV88E6XXX_PORT_PRI_OVERRIDE_TCAM_MODE_96_BYTE;
                ^^^

Would ORing the TCAM mode work correctly if the firmware has already
configured the port to 48-byte mode? The TCAM mode field (bits 1:0) in
the Priority Override register is a 2-bit enumeration where 0=disabled,
1=48-byte, 2=96-byte, and 3=reserved.

If bit 0 is already set (48-byte mode with value 0x0001), ORing with
0x0002 produces 0x0003 (reserved mode) instead of the intended 0x0002
(96-byte mode). The standard pattern for setting an enumerated register
field is clear-then-set:

    reg &= ~MV88E6XXX_PORT_PRI_OVERRIDE_TCAM_MODE_MASK;
    reg |= MV88E6XXX_PORT_PRI_OVERRIDE_TCAM_MODE_96_BYTE;

In normal operation (hardware reset value 0x0000), the current OR
produces the correct result. The issue only occurs if firmware or a
bootloader has pre-configured 48-byte TCAM mode before the Linux driver
initializes.

> +	return mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_PRI_OVERRIDE,
> +				    reg);
> +}

[ ... ]

> diff --git a/drivers/net/dsa/mv88e6xxx/tcflower.c b/drivers/net/dsa/mv88e6xxx/tcflower.c
> new file mode 100644
> index 000000000000..c28282ead486
> --- /dev/null
> +++ b/drivers/net/dsa/mv88e6xxx/tcflower.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Marvell 88E6xxx Switch flower support
> + *
> + * Copyright (c) 2026 Luminex Network Intelligence
> + */
> +
> +#include "chip.h"
> +#include "tcflower.h"
> +#include "tcam.h"
> +
> +#define MV88E6XXX_ETHTYPE_OFFSET 16
> +#define MV88E6XXX_IP_PROTO_OFFSET 27
> +#define MV88E6XXX_IPV4_SRC_OFFSET 30
> +#define MV88E6XXX_IPV4_DST_OFFSET 34
> +
> +static int mv88e6xx_flower_parse_key(struct mv88e6xxx_chip *chip,
                    ^^^

This isn't a bug, but the function name uses prefix mv88e6xx (two x's)
instead of mv88e6xxx (three x's). Every other function in the mv88e6xxx
driver uses the mv88e6xxx_ prefix, including the caller
mv88e6xxx_cls_flower_add in the same file.

> +				     struct netlink_ext_ack *extack,
> +				     struct flow_cls_offload *cls,
> +				     struct mv88e6xxx_tcam_key *key)
> +{
> +	struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
> +	struct flow_dissector *dissector = rule->match.dissector;
> +	u16 addr_type = 0;
> +
> +	if (dissector->used_keys &
> +	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
> +	      BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
> +	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS))) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Unsupported keys used");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
> +		struct flow_match_control match;
> +
> +		flow_rule_match_control(rule, &match);
> +		addr_type = match.key->addr_type;
> +
> +		if (flow_rule_has_control_flags(match.mask->flags,
> +						cls->common.extack))
> +			return -EOPNOTSUPP;
> +	}
> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
> +		struct flow_match_basic match;
> +
> +		flow_rule_match_basic(rule, &match);
> +		mv88e6xxx_tcam_match_set(key, MV88E6XXX_ETHTYPE_OFFSET,
> +					 match.key->n_proto,
> +					 match.mask->n_proto);
> +		mv88e6xxx_tcam_match_set(key, MV88E6XXX_IP_PROTO_OFFSET,
> +					 match.key->ip_proto,
> +					 match.mask->ip_proto);
> +	}
> +
> +	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
> +		struct flow_match_ipv4_addrs match;
> +
> +		flow_rule_match_ipv4_addrs(cls->rule, &match);
> +		mv88e6xxx_tcam_match_set(key, MV88E6XXX_IPV4_SRC_OFFSET,
> +					 match.key->src,
> +					 match.mask->src);
> +		mv88e6xxx_tcam_match_set(key, MV88E6XXX_IPV4_DST_OFFSET,
> +					 match.key->dst,
> +					 match.mask->dst);
> +	}
> +
> +	return 0;
> +}

[ ... ]
-- 
pw-bot: cr

