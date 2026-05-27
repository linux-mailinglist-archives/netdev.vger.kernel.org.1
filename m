Return-Path: <netdev+bounces-292056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPfeDBlPFmqxkgcAu9opvQ
	(envelope-from <netdev+bounces-292056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:55:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 374055DE69B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F5A330055C1
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F773002B3;
	Wed, 27 May 2026 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+rd2iGK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959601DE8BE;
	Wed, 27 May 2026 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846931; cv=none; b=S5/fPCwJPmPZPZBcoyH+P69ndKW7MnelkHsGR2u63wdIx462N9D4WETlSvjjyoHnDnKpj0pUAeURtQtXeaFyZjxu2ecvhH+0weWZxtikWAV0pTHnpQP4LmA1KP5Y+3ll5t/7g5kxbYViyWnJPN6/jo7chOUpVieIG+lk6PEkpWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846931; c=relaxed/simple;
	bh=eeHIn//hSymJGANkZOXokx3u7vbI4MfPEkxeu3jOq94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDCr+/WD4YrbopHHw4VVGz9KvJ8uMUrSCwyJdCyzZQ1g/oKJ3kcWbXC33rWLmARnBNykdA4fcu4sTiVROedOIA8Nv/TtEcuzzl9INShijjHV6kdWyX5sPl/b+JPkxEl38025YvJgWviUzjrPzoACf8fHW8jtE5bq9Cb1MiS+XfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+rd2iGK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1E31F000E9;
	Wed, 27 May 2026 01:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779846929;
	bh=Nas175rcdEQu2O5gpSAlT+fPAtMYmxGk8DidoV8D5Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A+rd2iGKDK75E7NM5XvZAXKSfAUJolUDB6Sa09vCLMqfifVOrFuvaqLbMsnIuJ4zi
	 fkxcyAyXUM2HH7RDdBDqJ0a+nz/0Hax/DqkzUfa+A3y/zhaQLqMvLoSj+pns0ahyZN
	 JW7rs35M04caKepkuGxhcnHSBBgn5GQKrsKOCdNmZjQorkWjO2oVROVsq5CN1ztjse
	 xEN97eAKN9Rkb33JzUQ0tnQfFSuChXX3hxqwCLvVn41bdcR+1D1rH6iZUdp+s98+sG
	 JZ190HPpOVNNF8Mz87uVsRlzwHGQQSz+oVP/N3NSZohfx6OFCDfMie1SdMfCKC37T7
	 4NthhEV0TMg3w==
From: Jakub Kicinski <kuba@kernel.org>
To: mmyangfl@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	hongson.hn@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: dsa: yt921x: Add ACL support
Date: Tue, 26 May 2026 18:55:27 -0700
Message-ID: <20260527015527.3178315-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523020704.503966-1-mmyangfl@gmail.com>
References: <20260523020704.503966-1-mmyangfl@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292056-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 374055DE69B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: yt921x: Add ACL support

This adds tc-flower offload support for the YT921x switch family,
mapping incoming-direction classifiers and a small set of actions onto
the chip's ACL engine. A few questions about the implementation are
inline.

> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index a652599a4561..f645879817db 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c

[ ... ]

> @@ -1457,6 +1467,955 @@ yt921x_dsa_port_setup_tc(struct dsa_switch *ds, int port,
>  	}
>  }
>  
> +/* ACL: 48 blocks * 8 entries
> + *
> + * One rule can span multiple entries, but within a block.
> + */

[ ... ]

> +	want_dport = false;
> +	want_sport = false;
> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
> +		struct flow_match_ports match;
> +
> +		entry = yt921x_acl_entries_find(entries, &size,
> +						YT921X_ACL_TYPE_L4);
> +		if (!entry)
> +			goto err;
> +
> +		flow_rule_match_ports(rule, &match);
> +
> +		want_dport = !!match.mask->dst;
> +		want_sport = !!match.mask->src;

[Low]
Could the L4 entry slot be allocated only when at least one mask is
non-zero?

The IPV4_ADDRS, IPV6_ADDRS and ETH_ADDRS branches above all compute
want_dst/want_src first and only call yt921x_acl_entries_find() when a
mask is set, but here the L4 entry is reserved as soon as the dissector
key is present.

A rule that exposes the PORTS key with both masks zero will consume one
of the eight per-block entry slots with an all-zero key/mask, and force
an L4 type match the user did not request.

> +
> +		entry->key[0] |= (ntohs(match.key->dst) << 16) |
> +				 ntohs(match.key->src);
> +		entry->mask[0] |= (ntohs(match.mask->dst) << 16) |
> +				  ntohs(match.mask->src);
> +	}
> +
> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS_RANGE)) {
> +		struct flow_match_ports_range match;
> +
> +		entry = yt921x_acl_entries_find(entries, &size,
> +						YT921X_ACL_TYPE_L4);
> +		if (!entry)
> +			goto err;
> +
> +		flow_rule_match_ports_range(rule, &match);
> +
> +		if ((want_dport && !!match.mask->tp.dst) ||
> +		    (want_sport && !!match.mask->tp.src)) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Ports and ports range are mutually exclusive");
> +			return -EINVAL;
> +		}
> +
> +		entry->key[0] |= (ntohs(match.key->tp_min.dst) << 16) |
> +				 ntohs(match.key->tp_min.src);
> +		if (match.mask->tp.dst)
> +			entry->key[1] |= YT921X_ACL_KEYb_L4_DPORT_RANGE_EN;
> +		if (match.mask->tp.src)
> +			entry->key[1] |= YT921X_ACL_KEYb_L4_SPORT_RANGE_EN;
> +		entry->mask[0] |= (ntohs(match.mask->tp_max.dst) << 16) |
> +				  ntohs(match.mask->tp_max.src);
> +	}

[High]
Is the source for the upper bound of the port range correct here?

Looking at fl_set_key_port_range() in net/sched/cls_flower.c, the
high port number is stored in key->tp_max while mask->tp_max is filled
with 0xff bytes when the corresponding TCA attribute is present:

    fl_set_key_val(tb, &key->tp_max.dst, TCA_FLOWER_KEY_PORT_DST_MAX,
                   &mask->tp_max.dst, TCA_FLOWER_UNSPEC,
                   sizeof(key->tp_max.dst));

So mask->tp_max.{dst,src} is 0xffff whenever the attribute exists, not
the high port number. Other drivers that consume PORTS_RANGE (for
example mlxsw_sp_flower_parse_ports_range() in
drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c) read
match.key->tp_max.{src,dst} for the upper bound.

Given the comment "Range: turn KEY:MASK into MIN:MAX" in yt921x.h, would
a tc-flower rule like dst_port 1000-2000 not end up programmed as
min=1000, max=0xffff in hardware?

[ ... ]

> +	/* Misc only */
> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IP)) {
> +		struct flow_match_ip match;
> +
> +		flow_rule_match_ip(rule, &match);
> +		if (match.mask->ttl)
> +			return -EOPNOTSUPP;

[Low]
Should this rejection set an extack message, similar to the
"Unsupported keys used" / "Action not supported" / "Rule too complex"
paths in the same function?

> +
> +		if (match.mask->tos) {

[ ... ]

> +static int
> +yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
> +				      const struct flow_action *flow_action,
> +				      struct netlink_ext_ack *extack,
> +				      struct yt921x_priv *priv, int port)
> +{
> +	const struct flow_action_entry *act;
> +	u32 *action = ruleext->r.action;
> +	int res;
> +	int i;
> +
> +	memset(action, 0, 3 * sizeof(*action));
> +	flow_action_for_each(i, act, flow_action)
> +		switch (act->id) {

[ ... ]

> +		case FLOW_ACTION_ACCEPT:
> +			action[2] |= YT921X_ACL_ACTc_REDIR_EN |
> +				     YT921X_ACL_ACTc_REDIR_FWD;
> +			break;
> +		case FLOW_ACTION_DROP:
> +			action[2] |= YT921X_ACL_ACTc_REDIR_EN |
> +				     YT921X_ACL_ACTc_REDIR_STEER;
> +			break;
> +		case FLOW_ACTION_REDIRECT: {
> +			struct dsa_port *to_dp;
> +
> +			to_dp = dsa_port_from_netdev(act->dev);
> +			if (IS_ERR(to_dp)) {
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "Destination not a switch port");
> +				return -EOPNOTSUPP;
> +			}
> +
> +			action[2] |= YT921X_ACL_ACTc_REDIR_EN |
> +				     YT921X_ACL_ACTc_REDIR_STEER |
> +				     YT921X_ACL_ACTc_REDIR_DPORTn(to_dp->index);
> +			break;
> +		}

[Medium]
Should this also verify that the redirect target lives on the same
switch (to_dp->ds == ds)?

dsa_port_from_netdev() only checks dsa_user_dev_check(); in a multi-
switch DSA tree the returned port can be on a different chip with an
index >= 11. YT921X_ACL_ACTc_REDIR_DPORTn(port) is BIT(port + 10), and
YT921X_ACL_ACTc_REDIR_DPORTS_M is GENMASK(20, 10), so an index of 11
sets bit 21, which is the low bit of YT921X_ACL_ACTc_REDIR_M
(GENMASK(22, 21)). That promotes the encoded REDIR_STEER (value 2) into
REDIR_TRAP (value 3), and higher indices spill further into the CTAG
and STAG fields.

[Low]
With multiple terminal verdicts in a single action list, does the
bitwise OR into action[2] produce a deterministic result?

For example, REDIR_STEER (value 2) OR'd with REDIR_TRAP (value 3) in
the YT921X_ACL_ACTc_REDIR_M field results in REDIR_TRAP, silently
turning a drop into a CPU trap. Should contradictory verdicts be
rejected with an extack message instead?

> +		case FLOW_ACTION_TRAP:
> +			action[2] |= YT921X_ACL_ACTc_REDIR_EN |
> +				     YT921X_ACL_ACTc_REDIR_TRAP;
> +			break;

[ ... ]

> +static int
> +yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
> +			       const struct flow_cls_offload *cls, bool ingress,
> +			       struct yt921x_priv *priv)
> +{
> +	const struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
> +	struct netlink_ext_ack *extack = cls->common.extack;
> +	int res;
> +
> +	if (!ingress || cls->common.chain_index)
> +		return -EOPNOTSUPP;

[Low]
Could this rejection also use NL_SET_ERR_MSG_MOD()?

Other failure paths in this file populate extack ("Unsupported keys
used", "Rule too complex", etc.); a user passing an egress filter or a
non-zero chain index will currently see a bare EOPNOTSUPP without any
diagnostic.

> +
> +	res = yt921x_acl_rule_ext_parse_flow_action(ruleext, &rule->action,
> +						    extack, priv, port);

[ ... ]

> +static unsigned int
> +yt921x_acl_reserve(struct yt921x_priv *priv, unsigned int entscnt,
> +		   struct netlink_ext_ack *extack)
> +{
> +	int candidates[YT921X_ACL_ENT_PER_BLK];
> +	unsigned int acl_used_cnt = 0;
> +
> +	if (WARN_ON(entscnt > YT921X_ACL_ENT_PER_BLK))
> +		return UINT_MAX;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(candidates); i++)
> +		candidates[i] = -1;
> +	for (unsigned int i = 0; i < YT921X_ACL_BLK_NUM; i++) {
> +		unsigned int blk_used_cnt = hweight8(priv->acl_masks[i]);
> +
> +		candidates[blk_used_cnt] = i;
> +		acl_used_cnt += blk_used_cnt;
> +	}

[Critical]
Can this overrun candidates[] when a block is fully populated?

YT921X_ACL_ENT_PER_BLK is 8 and priv->acl_masks[i] is a u8, so
hweight8(priv->acl_masks[i]) ranges over [0..8]. As soon as any block
has all 8 bins in use (acl_masks[i] == 0xff, reachable by adding rules
since priv->acl_masks[blkid] |= aclrule->mask accumulates and a single
rule can have entscnt up to 8), the next call writes:

    candidates[8] = i;

which is one past the end of the eight-element stack array.

Would it work to size the array as YT921X_ACL_ENT_PER_BLK + 1, or to
skip fully-saturated blocks here?

> +
> +	if (acl_used_cnt >= YT921X_ACL_NUM) {
> +		NL_SET_ERR_MSG_MOD(extack, "ACL entry limit reached");
> +		return UINT_MAX;
> +	}

[ ... ]

> +static int
> +yt921x_acl_commit(struct yt921x_priv *priv, unsigned int entid, u8 entsmask)
> +{
> +	const struct yt921x_acl_rule *aclrule;
> +	const struct yt921x_acl_blk *aclblk;
> +	unsigned int blkid;
> +	unsigned int binid;
> +	unsigned long mask;
> +	u32 zeros[3] = {};
> +	unsigned int i;
> +	unsigned int o;
> +	u32 ctrl;
> +	int res;
> +
> +	blkid = entid / YT921X_ACL_ENT_PER_BLK;
> +	binid = entid % YT921X_ACL_ENT_PER_BLK;
> +	aclblk = priv->acl_blks[blkid];
> +	aclrule = aclblk->rules[binid];
> +
> +	/* Open the block */
> +	ctrl = YT921X_ACL_BLK_CMD_MODIFY | YT921X_ACL_BLK_CMD_BLKID(blkid);
> +	res = yt921x_reg_write(priv, YT921X_ACL_BLK_CMD, ctrl);
> +	if (res)
> +		return res;
> +
> +	/* Write keys and masks */

[Medium]
If any of the register writes between the "Open the block" and
"Close the block" sequence fails, the function returns immediately
with the block still latched in MODIFY mode and no compensating close
is performed.

    res = yt921x_reg_write(priv, YT921X_ACL_BLK_CMD, ctrl);
    if (res)
        return res;
    ...
    res = yt921x_reg64_write(priv, YT921X_ACLn_KEYm(blkid, o), ...);
    if (res)
        return res;       /* block still in MODIFY */
    ...

Would a goto-style unwind that always issues the close-block command
and then returns the original error be safer here?

> +	ctrl = 0;
> +	for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++)
> +		ctrl |= YT921X_ACL_BLK_KEEP_KEEPn(i);

[ ... ]

> +	res = yt921x_reg_write(priv, YT921X_ACLn_ENTRY(blkid), ctrl);
> +	if (res)
> +		return res;
> +
> +	/* Close the block */
> +	ctrl = YT921X_ACL_BLK_CMD_BLKID(blkid);
> +	res = yt921x_reg_write(priv, YT921X_ACL_BLK_CMD, ctrl);
> +	if (res)
> +		return res;
> +
> +	/* Write actions */
> +	res = yt921x_reg96_write(priv, YT921X_ACLn_ACT(entid),
> +				 aclrule ? aclrule->action : zeros);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}

[Medium]
Is the activation order between the keys/EN and the action register
intentional?

The new keys, masks, and the per-block YT921X_ACLn_ENTRY register
(holding the EN bits) are written inside the MODIFY-bracketed sequence;
the block is then closed (which is what activates the new keys/EN in
the data path); only after the close is YT921X_ACLn_ACT(entid) written.

Between the close and the ACT write, packets matching the freshly
programmed keys would consult the prior contents of the action slot.
For a freshly allocated entid, that slot is zero, so REDIR_EN is clear
and the rule's intent (DROP/REDIRECT/TRAP) is briefly not enforced. Is
there a way to write the action before the EN bit becomes visible to
the data path?

[ ... ]

> +static int
> +yt921x_acl_add(struct yt921x_priv *priv,
> +	       const struct yt921x_acl_rule_ext *ruleext,
> +	       struct netlink_ext_ack *extack)
> +{
> +	bool want_meter = ruleext->r.action[0] & YT921X_ACL_ACTa_METER_EN;

[ ... ]

> +	if (want_meter) {
> +		meterid = find_first_zero_bit(priv->meters_map,
> +					      YT921X_METER_NUM);
> +		if (meterid >= YT921X_METER_NUM) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "No more meters available");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		res = yt921x_meter_config(priv, meterid, &ruleext->marker);
> +		if (res)
> +			return res;
> +	}
> +
> +	/* Prepare acl block ctrlblk */
> +	blkid = entid / YT921X_ACL_ENT_PER_BLK;
> +	binid = entid % YT921X_ACL_ENT_PER_BLK;
> +	aclblk = priv->acl_blks[blkid];
> +	if (!aclblk) {
> +		aclblk = devm_kzalloc(dev, sizeof(*aclblk), GFP_KERNEL);
> +		if (!aclblk)
> +			return -ENOMEM;
> +		priv->acl_blks[blkid] = aclblk;
> +	}
> +
> +	/* Prepare acl rule ctrlblk */
> +	aclrule = devm_kmemdup(dev, &ruleext->r,
> +			       offsetof(struct yt921x_acl_rule,
> +					entries[entscnt]),
> +			       GFP_KERNEL);
> +	if (!aclrule) {
> +		res = -ENOMEM;
> +		goto err;
> +	}

[Medium]
What happens to a meter that has been programmed in hardware when one
of these later steps fails?

yt921x_meter_config() writes YT921X_METERn_CTRL with METER_EN set
before any of the kernel-side bookkeeping has succeeded. If the
following devm_kzalloc(aclblk), devm_kmemdup(aclrule), or
yt921x_acl_commit() call fails, the function returns or jumps to err:
without:

  - reverting the meter hardware programming, and
  - reserving the meter id in priv->meters_map.

The slot stays active in hardware with the user's policer config, and
only set_bit(meterid, priv->meters_map) on the success path tracks it.
A subsequent successful add will pick the same id from
find_first_zero_bit() and reprogram it, but in the meantime the device
polices traffic through that meter.

[ ... ]

> @@ -3766,6 +4747,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
>  	.port_policer_del	= yt921x_dsa_port_policer_del,
>  	.port_policer_add	= yt921x_dsa_port_policer_add,
>  	.port_setup_tc		= yt921x_dsa_port_setup_tc,
> +	/* acl */
> +	.cls_flower_del		= yt921x_dsa_cls_flower_del,
> +	.cls_flower_add		= yt921x_dsa_cls_flower_add,

[Low]
Is there a reason cls_flower_stats is not implemented?

The action register definitions YT921X_ACL_ACTa_FLOWSTAT_EN and
YT921X_ACL_ACTa_FLOWSTAT_ID_M suggest the hardware can report per-rule
match counters, but the bits are never set and no stats callback is
hooked up, so tc -s filter show will not show match counts for
offloaded rules.

>  	/* hsr */
>  	.port_hsr_leave		= dsa_port_simple_hsr_leave,
>  	.port_hsr_join		= dsa_port_simple_hsr_join,
-- 
pw-bot: cr

