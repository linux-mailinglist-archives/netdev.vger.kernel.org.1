Return-Path: <netdev+bounces-295548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h6lhLN0pImprTQEAu9opvQ
	(envelope-from <netdev+bounces-295548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:43:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8726447CE
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:43:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ax4bKV0M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295548-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295548-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB97B309F255
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0457F31ED83;
	Fri,  5 Jun 2026 01:29:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389036C9E5;
	Fri,  5 Jun 2026 01:29:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622983; cv=none; b=BNXOQFwFTf/5fMwpaKYW1jbO4LTKaT1UgIykKacm9Lm6+VtOGcntgzTtlVG8Rhnwg3wylpXvKHD9aKnEddU868zvSzzjdEOFsCqNQCMQbDxGGiZ65mzaUNb5dKrvb0II6oQmv/IhkAMekgBRt/a9bZsaqrdmyzYfEJPkA8fgRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622983; c=relaxed/simple;
	bh=VUhyteRVUzzjPEHSwnJbJ/0iIURQ8mdgJk97i9yOLdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwgXXPm9MD063YTVpjVxCixj921+xqm+qvQzncqPH7qVJLKfXDd+C6KDcix0OIKwxsk3ZaqJKltWOqvMCEfhe0WNctJ7/roNZ/u2/xbQjdxwxDMMQ9lP8Bu9l54AD0HE8kQhS1BYsSLomnEB9omVIiU5YPla/B5Nkxk2FaNVA3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax4bKV0M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709551F00893;
	Fri,  5 Jun 2026 01:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622978;
	bh=RT2Ua12gFzg2G0PJ7gFPsaenJC9WjR3Xva24P4Q+ghg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ax4bKV0Mqa4CJLpzLjT/VHypCEr6iyjG1WRCtyY8tVBh9oFgjOs0TVLXFrknRhs6m
	 H1nHShHsRtk5+TwoDyUp3Qk1qeieiySa1bbyaXjUR0a0fl8+fmz0vdWWCkocdBab2q
	 zwDm03nd2L6FqnWDKHphzc0VlzyQeYy1t1Ill7IhpJzJhM7a/GpcBhDYqZooqM5AOK
	 q3wnfY0INFdjCz2cvxHxoXOo9wdfmrh8tam3O7BWKhSOYN0AXTLYATBX/nCZQU55kZ
	 IpYvfMHvVph+g/9p41YUqTP+H2bc1QZm1TEN1PaVKVUVl+O3vl94eguCXisu6tccLf
	 ZpLVGaJOUZosg==
From: Jakub Kicinski <kuba@kernel.org>
To: mmyangfl@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	hongson.hn@gmail.com
Subject: Re: [PATCH net-next v5 2/2] net: dsa: yt921x: Add ACL support
Date: Thu,  4 Jun 2026 18:29:35 -0700
Message-ID: <20260605012935.3527092-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602083755.79411-3-mmyangfl@gmail.com>
References: <20260602083755.79411-3-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-295548-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:mmyangfl@gmail.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:hongson.hn@gmail.com,m:hongsonhn@gmail.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D8726447CE

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: yt921x: Add ACL support

Enable filtering of incoming traffics. Note that custom filters are yet
to be utilized, and thus not all flow dissectors are implemented.

> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index a652599a4561b..8afeffcc77579 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c

[ ... ]

> @@ -1457,6 +1467,1017 @@ yt921x_dsa_port_setup_tc(struct dsa_switch *ds, int port,

[ ... ]

> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_TCP)) {
> +		struct flow_match_tcp match;
> +
> +		flow_rule_match_tcp(rule, &match);
> +
> +		if (match.mask->flags) {
> +			entry = yt921x_acl_entries_find(entries, &size,
> +							YT921X_ACL_TYPE_MISC);
> +			if (!entry)
> +				goto err;
> +
> +			entry->key[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.key->flags));
> +			entry->mask[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.mask->flags));

[Severity: High]
Does this code silently truncate the 16-bit TCP flags to 8 bits?

The hardware field for TCP flags YT921X_ACL_BINa_MISC_TCP_FLAGS_M is 8 bits
wide, but standard TCP flags in flow_match_tcp are 16 bits. If a user provides
a mask containing bits beyond the lower 8 bits, it seems the FIELD_PREP macro
will silently truncate the upper bits, causing the hardware rule to match and
permit more traffic than intended by the firewall policy.

Should this validate that ntohs(match.mask->flags) & ~0xFF is zero before
applying the rule?

> +		}
> +	}

[ ... ]

> +static int
> +yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,

[ ... ]

> +		default:
> +fallback:
> +			if (cls->common.skip_sw) {
> +				NL_SET_ERR_MSG_FMT_MOD(extack,
> +						       "Action not supported when skip_sw: %s",
> +						       reason);
> +				return -EOPNOTSUPP;
> +			}
> +			fallthrough;
> +		case FLOW_ACTION_TRAP:
> +			redir_act = FLOW_ACTION_TRAP;
> +
> +			action[2] &= ~YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M &
> +				     ~YT921X_ACL_ACTc_FWD_M;
> +			action[2] |= YT921X_ACL_ACTc_FWD_EN |
> +				     YT921X_ACL_ACTc_FWD_REDIR;

[Severity: High]
Does this configure the hardware to silently drop packets instead of trapping
them to the CPU?

By setting the YT921X_ACL_ACTc_FWD_REDIR action flag and completely clearing
the destination ports mask, directing a packet to a zero port mask instructs
the hardware to silently drop it. This sequence appears identical to
FLOW_ACTION_DROP.

Should the driver use the dedicated YT921X_ACL_ACTc_FWD_TRAP hardware action
instead?

> +			break;
> +		}

[ ... ]

> +static int
> +yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
> +	       unsigned long tag)
> +{

[ ... ]

> +	aclblk->rules[binid] = NULL;
> +	res = yt921x_acl_commit(priv, entid, aclrule->mask);
> +	if (res) {
> +		aclblk->rules[binid] = aclrule;
> +		return res;
> +	}

[Severity: Medium]
Can this leak software state and memory for ACL rules if the hardware deletion
fails?

If yt921x_acl_commit() fails, the function restores the pointer and returns
early without freeing the software state (aclrule, aclblk, and meters_map).
Because the TC subsystem ignores errors from hardware .cls_flower_del
callbacks and unconditionally destroys the generic software filter anyway, the
driver will permanently leak its internal tracking structures for this rule.

> +
> +	if (aclrule->action[0] & YT921X_ACL_ACTa_METER_EN)
> +		clear_bit(FIELD_GET(YT921X_ACL_ACTa_METER_ID_M,
> +				    aclrule->action[0]),
> +			  priv->meters_map);
> +	priv->acl_masks[blkid] &= ~aclrule->mask;
> +	devm_kfree(dev, aclrule);

[Severity: Medium]
Does this cause devres list bloat and spinlock contention?

Calling devm_kfree() on every rule deletion requires acquiring the devres_lock
spinlock and performing an O(N) linear search through the device's managed
resource list. Since TC rules are dynamically added and removed, it might be
better to use standard kzalloc/kfree.

> +	if (!priv->acl_masks[blkid]) {
> +		devm_kfree(dev, aclblk);
> +		priv->acl_blks[blkid] = NULL;
> +	}
> +	return 0;
> +}
> +
> +static int
> +yt921x_acl_add(struct yt921x_priv *priv,
> +	       const struct yt921x_acl_rule_ext *ruleext,
> +	       struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	if (use_meter) {
> +		meterid = find_first_zero_bit(priv->meters_map,
> +					      YT921X_METER_NUM);
> +		if (meterid < YT921X_METER_NUM) {
> +			res = yt921x_meter_config(priv, meterid,
> +						  &ruleext->marker);
> +			if (res)
> +				return res;
> +		} else if (ruleext->r.sw_assisted) {
> +			use_meter = false;

[Severity: High]
Does this silently bypass hardware policing when hardware meters are exhausted?

When a rule has a police action but no hardware meters are available, and
software assistance is allowed, setting use_meter = false installs the rule
into hardware without the meter action.

Since the hardware applies the remaining actions (e.g., forwarding) at line
rate without trapping the packet to the CPU, the software TC datapath never
sees the traffic, completely bypassing the requested rate limit.

If a rate limit cannot be offloaded, should the driver either reject the
offload or explicitly trap matching packets to the CPU?

> +		} else {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "No more meters available");
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	/* Prepare acl block ctrlblk */
> +	blkid = entid / YT921X_ACL_ENT_PER_BLK;
> +	binid = entid % YT921X_ACL_ENT_PER_BLK;
> +	aclblk = priv->acl_blks[blkid];
> +	if (!aclblk) {
> +		aclblk = devm_kzalloc(dev, sizeof(*aclblk), GFP_KERNEL);

[Severity: Medium]
Is devm_kzalloc() appropriate for allocating dynamic TC offload rules?

The devm_* APIs are designed for device lifecycle management (probe/remove),
not for dynamic, user-driven allocations like network flows. As mentioned
above regarding devm_kfree, this will bloat the devres list and cause
significant spinlock contention.

> +		if (!aclblk)
> +			return -ENOMEM;
> +		priv->acl_blks[blkid] = aclblk;
> +	}
-- 
pw-bot: cr

