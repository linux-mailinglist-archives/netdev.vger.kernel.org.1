Return-Path: <netdev+bounces-299113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oo5IFLL5LWpxnwQAu9opvQ
	(envelope-from <netdev+bounces-299113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 02:45:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 963D7680210
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 02:45:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZPJMkIwU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299113-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299113-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EBD130071E7
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3AA23F431;
	Sun, 14 Jun 2026 00:45:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358579CD;
	Sun, 14 Jun 2026 00:45:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781397935; cv=none; b=QqPIhESkVfn56Y9hjPr/Wac3hJt2ZiDSccFCAxA2/p/GE5go5bRJeB8fMbAvAIsMsNON9HIWUW8IkouKWnKbRQvEc/fnR+JgB71KMa/O286wvhRuTFZ+pC5Nds7CgfwSTa1+jtdwp5N/WlH9j5fVZcpChnHlnc5yQKWqWqhzCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781397935; c=relaxed/simple;
	bh=boMDR9bjcDPU5LuFb6qMWs0TEKNGsZ0Q47rf+QtHsUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJmWAF8wCRdQZ5dU3j27BnunQ8O+wgKvyZqx3WutQcr+rtMb6LTIOLnkWsnkvRA9HrVRtpqWwGUQPOgeXlJIm9DRFULXqBwUGNzDmLGNSMHeL7XEdl0p10BqHMBEJeG86utdoSxWfePiiGnRlxgrWHVoJUmWv6lWEztT4aOVo0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPJMkIwU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8601F000E9;
	Sun, 14 Jun 2026 00:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781397933;
	bh=q82UhnH2/37BeKpgQc37emUrKfiMBuo2xB8o8TlUGN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZPJMkIwU9KO4R/Rk2Q/Wuu8jssf1EAZPICzXov+y2MIzXDYnNGvt/9REFHCXgU6nr
	 3ycb8sssP+ALwv5cNX6L7hqncfO5uTD0Oy3ccArb6h5I1y1NrRIxhuq48hMyzgG0Mp
	 GAhqwiXZSDbOUnvVAYUUnTPZB91qp0B2GSVVLl1pVzBapv8kPKy3GjZ0DrX+LoBT19
	 scz5LgVswo1vjYSxNvREyx4UwZpmdcLyNACcE9eRlzKxIFiQQIpcJsHdl2svN3wKDO
	 L4fwq/Lx3QLy299vJS3tx8KCQFOizPRyL6qiIUFPAG2ydTw69gXq8/JSO6ODeyoUas
	 5JeDgfKVfey5w==
From: Jakub Kicinski <kuba@kernel.org>
To: mmyangfl@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: yt921x: Add limited ACL flow statistics support
Date: Sat, 13 Jun 2026 17:45:30 -0700
Message-ID: <20260614004530.402503-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610202508.845328-1-mmyangfl@gmail.com>
References: <20260610202508.845328-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299113-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mmyangfl@gmail.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 963D7680210

This is an AI-generated review of your patch. The human sending this
email says "I thought this is a false positive and the register is
Clear-on-Read but you seem to be writing 0 to it when allocating."
---
net: dsa: yt921x: Add limited ACL flow statistics support

This commit adds .cls_flower_stats() support to the yt921x DSA driver,
backed by a pool of 64 hardware flow counters configured in byte mode.
A counter is allocated at rule-install time and read on demand via
yt921x_acl_stat().

> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index 159b16606f6c..7919afcb8136 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c
> @@ -373,6 +373,11 @@ yt921x_regs_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
>  	return yt921x_regs_write(priv, reg, vs, num_regs);
>  }
>  
> +static int yt921x_reg64_read(struct yt921x_priv *priv, u32 reg, u32 *vals)
> +{
> +	return yt921x_regs_read(priv, reg, vals, 2);
> +}
> +

[Low]
yt921x_reg64_read() reads the 64-bit FLOWSTATn_STAT register as two
independent 32-bit transactions, one for each word, and combines them
in yt921x_acl_stat() with:

	*statp = ((u64)vals[1] << 32) | vals[0];

The hardware counter is live and can increment between the two reads.
If the low word wraps from ~0xffffffff to a small value while the high
word increments between the two transactions, the recombined value
becomes (new_high << 32) | old_low, producing a spurious ~4 GiB jump.

Does the chip provide a latch/snapshot register, or a documented
read-low/high/low retry protocol, that should be used here instead of
two independent reads?

>  static int
>  yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
>  {
> @@ -2224,6 +2229,40 @@ yt921x_acl_reserve(struct yt921x_priv *priv, unsigned int entscnt,
>  	return UINT_MAX;
>  }
>  
> +static int
> +yt921x_acl_stat(struct yt921x_priv *priv, enum tc_setup_type type,
> +		unsigned long tag, u64 *statp)
> +{
> +	const struct yt921x_acl_rule *aclrule;
> +	const struct yt921x_acl_blk *aclblk;
> +	unsigned int statid;
> +	unsigned int binid;
> +	unsigned int blkid;
> +	unsigned int entid;
> +	u32 vals[2];
> +	int res;
> +
> +	entid = yt921x_acl_find(priv, type, tag);
> +	if (entid == UINT_MAX)
> +		return -ENOENT;
> +
> +	blkid = entid / YT921X_ACL_ENT_PER_BLK;
> +	binid = entid % YT921X_ACL_ENT_PER_BLK;
> +	aclblk = priv->acl_blks[blkid];
> +	aclrule = aclblk->rules[binid];
> +
> +	if (!(aclrule->action[0] & YT921X_ACL_ACTa_FLOWSTAT_EN))
> +		return -EOPNOTSUPP;
> +
> +	statid = FIELD_GET(YT921X_ACL_ACTa_FLOWSTAT_ID_M, aclrule->action[0]);
> +	res = yt921x_reg64_read(priv, YT921X_FLOWSTATn_STAT(statid), vals);
> +	if (res)
> +		return res;
> +
> +	*statp = ((u64)vals[1] << 32) | vals[0];
> +	return 0;
> +}
> +

[High]
The absolute hardware counter is written directly into cls->stats.bytes,
and the flow_offload framework treats this value as a per-poll delta.
Following the call chain tcf_exts_hw_stats_update() ->
tcf_action_stats_update() -> a->ops->stats_update() -> _bstats_update(),
the framework performs:

	u64_stats_add(&bstats->bytes, bytes);

So if the hardware counter currently shows X bytes, every subsequent
poll of an idle counter adds another X to the kernel running total. After
N polls of an unchanged counter the user-visible "tc -s flower" value
will read N*X instead of X.

Two existing drivers handle this correctly:

  - drivers/net/dsa/sja1105/sja1105_vl.c:sja1105_vl_stats() caches a
    "last reported" value and reports (current - last).
  - drivers/net/ethernet/mscc/ocelot_vcap.c:ocelot_vcap_filter_stats_update()
    clears the hardware counter after each read.

Should yt921x_acl_stat() do something similar, either by tracking the
previously reported value per-rule, or by clearing FLOWSTATn_STAT after
the read?

[Medium]
cls->stats.pkts and cls->stats.lastused are never populated. The
hardware is hardwired to byte mode (YT921X_FLOWSTAT_CTRL_TYPE_FLOW with
PKT_MODE cleared), so no packet count is available, but the driver still
sets:

	cls->stats.used_hw_stats = FLOW_ACTION_HW_STATS_IMMEDIATE;
	cls->stats.used_hw_stats_valid = true;

Combined with the additive _bstats_update() semantics above, "tc -s
flower" will always show 0 packets even under traffic. Similarly
flow_stats->lastused stays 0, and any rule-aging logic that consults
lastused (it is updated via max_t(u64, ...)) will see the rule as never
used. For comparison, sja1105_vl_stats() passes
(jiffies - rule->vl.stats.lastused) as a delta.

Should the commit message and/or used_hw_stats_valid acknowledge that
pkts and lastused are not being reported?

>  static int
>  yt921x_acl_commit(struct yt921x_priv *priv, unsigned int entid, u8 entsmask)
>  {
> @@ -2336,6 +2375,10 @@ yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
>  		clear_bit(FIELD_GET(YT921X_ACL_ACTa_METER_ID_M,
>  				    aclrule->action[0]),
>  			  priv->meters_map);
> +	if (aclrule->action[0] & YT921X_ACL_ACTa_FLOWSTAT_EN)
> +		clear_bit(FIELD_GET(YT921X_ACL_ACTa_FLOWSTAT_ID_M,
> +				    aclrule->action[0]),
> +			  priv->flowstats_map);

[Low]
On rule delete the priv->flowstats_map bit is cleared, but
YT921X_FLOWSTATn_CTRL(statid) is not written to clear FLOWSTAT_CTRL_EN.
The counter remains physically enabled with TYPE_FLOW until something
else reprograms it.

Today this is benign because acl_commit() zeros the action register so
no rule references the counter, and reuse rewrites CTRL. However, the
header file enumerates other types (TYPE_CPU_CODE, TYPE_DROP_CODE,
TYPE_PORT) for the same slot pool. If a future caller picks one of
these types without first disabling the slot, could it observe stale
counts from the previous flow user?

>  	priv->acl_masks[blkid] &= ~aclrule->mask;
>  	kvfree(aclrule);
>  	if (!priv->acl_masks[blkid]) {
> @@ -2355,11 +2398,13 @@ yt921x_acl_add(struct yt921x_priv *priv,
>  	struct yt921x_acl_blk *aclblk;
>  	bool use_trap = false;
>  	unsigned int meterid;
> +	unsigned int statid;
>  	unsigned long mask;
>  	unsigned int binid;
>  	unsigned int blkid;
>  	unsigned int entid;
>  	unsigned int o;
> +	u32 ctrl;
>  	int res;
>  
>  	/* Allocate resources */
> @@ -2386,6 +2431,22 @@ yt921x_acl_add(struct yt921x_priv *priv,
>  		}
>  	}
>  
> +	statid = find_first_zero_bit(priv->flowstats_map, YT921X_FLOWSTAT_NUM);
> +	if (statid < YT921X_FLOWSTAT_NUM) {
> +		u32 zeros[2] = {};
> +
> +		ctrl = YT921X_FLOWSTAT_CTRL_EN | YT921X_FLOWSTAT_CTRL_TYPE_FLOW;
> +		res = yt921x_reg_write(priv, YT921X_FLOWSTATn_CTRL(statid),
> +				       ctrl);
> +		if (res)
> +			return res;
> +
> +		res = yt921x_reg64_write(priv, YT921X_FLOWSTATn_STAT(statid),
> +					 zeros);
> +		if (res)
> +			return res;
> +	}
> +

[Medium]
This block runs unconditionally for every ACL rule, regardless of
whether the user requested statistics. When all 64 counters are in use
(statid >= YT921X_FLOWSTAT_NUM), the rule is still installed but
silently without stats; the user only learns by querying and getting
-EOPNOTSUPP from yt921x_acl_stat().

There is no NL_SET_ERR_MSG_MOD() at install time and no kernel log
message. The same function explicitly emits

	NL_SET_ERR_MSG_MOD(extack, "No more meters available");

for the meter pool right above this hunk.

Should the flow-stat path either be gated on whether the rule actually
needs stats (so unrelated rules do not consume counters), or surface a
diagnostic via extack when the pool is exhausted? Otherwise an old set
of un-queried rules can starve newer rules that do need stats.

[Low]
After the YT921X_FLOWSTATn_CTRL write succeeds, the bare "return res;"
on a failing YT921X_FLOWSTATn_STAT write leaves the counter enabled in
hardware while priv->flowstats_map remains clear. Likewise, if any
later step (kvmemdup, yt921x_acl_commit) fails, the err: label does not
unwind the CTRL write or the meter configuration done in the prior
hunk.

The same asymmetric rollback pre-exists for meters and is implicitly
healed by the next allocation reprogramming the slot, but the new
flow-stat path's bare returns bypass the err: label entirely. Should
this teardown path be made symmetric?

>  	/* Prepare acl block ctrlblk */
>  	blkid = entid / YT921X_ACL_ENT_PER_BLK;
>  	binid = entid % YT921X_ACL_ENT_PER_BLK;
> @@ -2426,6 +2487,9 @@ yt921x_acl_add(struct yt921x_priv *priv,
>  		aclrule->action[0] |= YT921X_ACL_ACTa_METER_ID(meterid);
>  	else
>  		aclrule->action[0] &= ~YT921X_ACL_ACTa_METER_EN;
> +	if (statid < YT921X_FLOWSTAT_NUM)
> +		aclrule->action[0] |= YT921X_ACL_ACTa_FLOWSTAT_EN |
> +				      YT921X_ACL_ACTa_FLOWSTAT_ID(statid);
>  
>  	/* Write rules */
>  	aclblk->rules[binid] = aclrule;

[ ... ]
-- 
pw-bot: cr

