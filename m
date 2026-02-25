Return-Path: <netdev+bounces-260869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGuXGovPnmnwXQQAu9opvQ
	(envelope-from <netdev+bounces-260869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:31:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C47195C92
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5735F30420A9
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1090392830;
	Wed, 25 Feb 2026 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzt5lNi2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A915A86D;
	Wed, 25 Feb 2026 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015331; cv=none; b=fpGncvJ7echfQ4+ibZU/YBg/LSLgjkJKc5XTJ9KSwDPJ6WDjTqGiRBrGDN2lBoa5dQqOeGejU0J/UQKvabREVtyJlPR6HGvZduDDnMZpD4lj57b2l55HQbXqlWIB/NNVb7eNo69KMWV9HHR40XZSa7Du+bSyM0OiFzIQFabWD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015331; c=relaxed/simple;
	bh=lq3b8BduZCpi8O0DlQWm6T4JJHOVeZL+j/YOabPb0Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P08jodtuKXu4gejGRCJ2KTuFkRyXQ0W9KndgutfINgSfetcfkUBZXLjiqmnuj4zhdkTJOvMpz0Ojm9pNGCMSoAVSTsTjVyj4ko+xr6Zs4MI0XnS4e3AcX0NnvD6XzRgrFUahiuPzf0yW3Gjp6Mog5UAuO3bX48CWsqlYNiommss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzt5lNi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339FEC19423;
	Wed, 25 Feb 2026 10:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772015331;
	bh=lq3b8BduZCpi8O0DlQWm6T4JJHOVeZL+j/YOabPb0Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nzt5lNi2bF9n1jopImFCzolRPSFRboNA7MgpUEk+KuoT+u3B4JBxNT2Ybk595qfmg
	 eistXvwyWeM1C3m9kSVstNAp+Zdmwl2P36jSbFLuRYOqRCqdi+f3AqWCqkW4YdsyQq
	 wNjWcNKeBln1fmc3fqrFPoDpi8Csw23IW0h2SSULwjUDW+v5efyPs+zT0Z0kcPi/IO
	 mH/5W/TwMMfgVC7gEz78QDRiY1NKejNcCgzTWcX4mZvBtZcxuVnD3Uy05kJo+QQUpC
	 NqZlexX3+kpmZ3rLeqAyoj3KlpYSDJepsd6uXBPeVTJzIIvrncbJaPz4jT18hxy5sM
	 VXZSFXmjopLWQ==
From: Simon Horman <horms@kernel.org>
To: cedric.jehasse@luminex.be
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net
Subject: Re: [net-next,v3] net: dsa: mv88e6xxx: Add partial support for TCAM entries
Date: Wed, 25 Feb 2026 10:25:29 +0000
Message-ID: <20260225102528.177319-2-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224-net-next-mv88e6xxx-tcam-v3-1-dc18887d71f2@luminex.be>
References: <20260224-net-next-mv88e6xxx-tcam-v3-1-dc18887d71f2@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lunn.ch,vger.kernel.org,gmail.com,redhat.com,armlinux.org.uk,davemloft.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260869-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7C47195C92
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: mv88e6xxx: Add partial support for TCAM entries

This patch adds partial TCAM support for mv88e6390 and mv88e6393 family
switches, allowing the switch to match frame headers and take actions on
matched frames via tc flower offload. It supports matching on IP
addresses and protocol, and trapping packets to the CPU.

> diff --git a/drivers/net/dsa/mv88e6xxx/tcam.c b/drivers/net/dsa/mv88e6xxx/tcam.c
> new file mode 100644
> index 000000000000..ed02c8798200
> --- /dev/null
> +++ b/drivers/net/dsa/mv88e6xxx/tcam.c

[ ... ]

> +/* insert tcam entry in ordered list and move existing entries if necessary */
> +static int mv88e6xxx_tcam_insert_entry(struct mv88e6xxx_chip *chip,
> +				       struct mv88e6xxx_tcam_entry *entry)
> +{
> +	struct mv88e6xxx_tcam_entry *elem;
> +	struct list_head *hpos;
> +	int err;
> +
> +	list_for_each_prev(hpos, &chip->tcam.entries) {
> +		u8 move_idx;
> +
> +		elem = list_entry(hpos, struct mv88e6xxx_tcam_entry, list);
> +		if (entry->prio >= elem->prio)
> +			break;
> +
> +		move_idx = elem->hw_idx + 1;
> +
> +		err = mv88e6xxx_tcam_flush_entry(chip, move_idx);
> +		if (err)
> +			return err;
> +
> +		err = chip->info->ops->tcam_ops->entry_add(chip, elem,
> +							   move_idx);
> +		if (err)
> +			return err;
> +
> +		elem->hw_idx = move_idx;
> +	}

If entry_add() fails after some entries have already been moved to new
hardware positions (with their hw_idx updated), doesn't the function
return without rolling back those partial moves? The software list would
then have some entries pointing to their new positions while the gap for
the new entry is only partially created, leaving the TCAM in an
inconsistent state for subsequent operations.

[ ... ]

> +int mv88e6xxx_tcam_entry_del(struct mv88e6xxx_chip *chip,
> +			     struct mv88e6xxx_tcam_entry *entry)
> +{
> +	struct mv88e6xxx_tcam_entry *elem = entry;
> +	u8 move_idx = entry->hw_idx;
> +	int err;
> +
> +	err = mv88e6xxx_tcam_flush_entry(chip, entry->hw_idx);
> +
> +	/* move entries that come after the deleted entry forward */
> +	list_for_each_entry_continue(elem, &chip->tcam.entries, list) {
> +		u8 tmp_idx = elem->hw_idx;
> +
> +		err = chip->info->ops->tcam_ops->entry_add(chip, elem,
> +							   move_idx);
> +
> +		elem->hw_idx =  move_idx;
> +		move_idx = tmp_idx;
> +
> +		/* flush the last entry after moving entries */
> +		if (list_is_last(&elem->list, &chip->tcam.entries))
> +			err = mv88e6xxx_tcam_flush_entry(chip, tmp_idx);
> +	}
> +
> +	list_del(&entry->list);
> +	return err;
> +}

Can errors be silently lost in mv88e6xxx_tcam_entry_del()? The initial
mv88e6xxx_tcam_flush_entry() result is stored in err, but then err is
unconditionally overwritten by entry_add() and the final flush_entry()
in the loop.

If the initial flush fails but subsequent operations succeed, the error
is lost and success is returned. Additionally, elem->hw_idx is updated
even when entry_add() fails, so the software model diverges from the
hardware state.

> diff --git a/drivers/net/dsa/mv88e6xxx/tcflower.c b/drivers/net/dsa/mv88e6xxx/tcflower.c
> new file mode 100644
> index 000000000000..693f4ad8f32f
> --- /dev/null
> +++ b/drivers/net/dsa/mv88e6xxx/tcflower.c

[ ... ]

> +static int mv88e6xx_flower_parse_key(struct mv88e6xxx_chip *chip,
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
> +	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
> +	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS))) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Unsupported keys used");
> +		return -EOPNOTSUPP;
> +	}

FLOW_DISSECTOR_KEY_IPV6_ADDRS is included in the allowed keys bitmask
but there is no code below to parse IPv6 addresses into the TCAM key.
If a user creates a tc flower rule with IPv6 addresses, the rule passes
this validation check but the addresses are never programmed into the
TCAM, causing the hardware entry to match broader traffic than intended.

Should FLOW_DISSECTOR_KEY_IPV6_ADDRS be removed from the allowed keys
until IPv6 parsing is implemented?

[ ... ]

> +int mv88e6xxx_cls_flower_add(struct dsa_switch *ds, int port,
> +			     struct flow_cls_offload *cls, bool ingress)
> +{

[ ... ]

> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry) {
> +		err = -EEXIST;
> +		goto err_unlock;
> +	}

Should this be -ENOMEM instead of -EEXIST? When kzalloc() fails, the
error code tells callers the entry already exists rather than reporting
the actual memory allocation failure. This appears to be a copy-paste
from the cookie-exists check immediately above. Note that this was
correct (-ENOMEM) in v2 of this patch and changed to -EEXIST in v3.

[ ... ]

> +	err = mv88e6xxx_tcam_entry_add(chip, entry);
> +	mv88e6xxx_reg_unlock(chip);
> +	if (err)
> +		goto err_free_entry;
> +
> +	mv88e6xxx_reg_unlock(chip);
> +	return  0;
> +
> +err_free_entry:
> +	kfree(entry);
> +err_unlock:
> +	mv88e6xxx_reg_unlock(chip);
> +	return err;
> +}

Does this double unlock chip->reg_lock? On the success path,
mv88e6xxx_reg_unlock(chip) is called after mv88e6xxx_tcam_entry_add(),
and then called again before returning 0.

On the error path from mv88e6xxx_tcam_entry_add(), the unlock fires,
then goto err_free_entry falls through to err_unlock which unlocks a
second time.

mv88e6xxx_reg_lock/unlock wrap mutex_lock/mutex_unlock. Double
mutex_unlock causes undefined behavior and corrupts the mutex state.
chip->reg_lock is the central serialization mutex used by the entire
mv88e6xxx driver, so this corruption would affect all subsequent
register access operations. Andrew Lunn raised the locking pattern
as suspicious during the v2 review:
https://lore.kernel.org/netdev/ab9b4278-2c0a-4ed5-9da0-2a7a3f928ed7@lunn.ch/

This bug appears to have been introduced in v3 when restructuring the
lock/unlock calls.

