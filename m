Return-Path: <netdev+bounces-259051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJYnI5l6lGkfFAIAu9opvQ
	(envelope-from <netdev+bounces-259051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:26:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA20F14D230
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E968E3018AE9
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6A636C580;
	Tue, 17 Feb 2026 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m7eipzqK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03E936B07A;
	Tue, 17 Feb 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338377; cv=none; b=rOatrDPW7XuFgs4WiPHu8p5kkscFCufFwQLbqkQMs8enPooDx6a3hFAY5ZbkwSYm6SIBVRAH0RUoFkujHyC1YmlSLvsS7I/NKChosof+7wwhUKR6aM6ugjWbisCVLVIEUH75c2p1iCb8r7ZKF0km9zhmQ8wXXAS9m2kkRZY83EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338377; c=relaxed/simple;
	bh=LIbabJNTlM49M72B+3r9Bx7zIBIkbANEIwJtf8aslEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvQl3tWwj0QYTcZcShvLabSJG1w7fkEx0BPA8hXUsZ+u0DjA+dw6a6AmKrY79q1tsB/l5k3qNT0jGXh8BG5Tbc9yINsOgBn7rOCe/+MFWvAfyl/ykZ7wqfN5c8SqrxduBDd48iSSwt5Bfhjxrqq/daFLm0+t2sEaTEg7F0DIbyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m7eipzqK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=37hIoo1tEWLQYJyuAVH/jvXzzyVYg6it1VHYb5lTFN0=; b=m7eipzqKpduLsvXR+V9a1Cj/ST
	GE9keg2laYvkLTV+aROa7f/PudC7nA0Y9Qep1RRYcD8RKfNWDoi+SVRrrTMEEYKtaneIw85YYRdXj
	dqHdn8RTVOq10iT6R6NY7x0EoXEXdkxUiyyup0sZ95tpQFDKrvIL2xKGhmKJfpi/2hiM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vsM1d-007eLJ-5x; Tue, 17 Feb 2026 15:26:05 +0100
Date: Tue, 17 Feb 2026 15:26:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: cedric.jehasse@luminex.be
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2] net: dsa: mv88e6xxx: Add partial support
 for TCAM entries
Message-ID: <ab9b4278-2c0a-4ed5-9da0-2a7a3f928ed7@lunn.ch>
References: <20260217-net-next-mv88e6xxx-tcam-v2-1-d84cf420da46@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217-net-next-mv88e6xxx-tcam-v2-1-d84cf420da46@luminex.be>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259051-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: DA20F14D230
X-Rspamd-Action: no action

> +static int mv88e6xxx_tcam_read_page(struct mv88e6xxx_chip *chip, u8 page, u8 entry)
> +
> +{
> +	u16 val = MV88E6XXX_TCAM_OP_BUSY | MV88E6XXX_TCAM_OP_OP_READ | (page & 0x3) << 10 | entry;
> +	int rc;

This driver pretty consistently uses err for error codes. There are a
small number of cases of using ret, but not many. rc is not used at
all.

This driver also uses 80 character line lengths, which is still the
default for netdev.

> +/* insert tcam entry in ordered list and move existing entries if necessary */
> +static int mv88e6xxx_tcam_insert_entry(struct mv88e6xxx_chip *chip,
> +				       struct mv88e6xxx_tcam_entry *entry)
> +{
> +	struct mv88e6xxx_tcam_entry *elem;
> +	struct list_head *hpos;
> +	int rc;
> +
> +	list_for_each_prev(hpos, &chip->tcam.entries) {
> +		elem = list_entry(hpos, struct mv88e6xxx_tcam_entry, list);
> +		if (entry->prio >= elem->prio)
> +			break;
> +
> +		u8 move_idx = elem->hw_idx + 1;

Please don't create variables mid block.

> +
> +		mv88e6xxx_reg_lock(chip);
> +		rc = mv88e6xxx_tcam_flush_entry(chip, move_idx);
> +		mv88e6xxx_reg_unlock(chip);
> +		if (rc)
> +			return rc;
> +		mv88e6xxx_reg_lock(chip);

and it would be normal to have a blank like after a return.


> +		rc = chip->info->ops->tcam_ops->entry_add(chip, elem, move_idx);
> +		mv88e6xxx_reg_unlock(chip);

These mv88e6xxx_reg_lock()/mv88e6xxx_reg_unlock() are also
suspicious. Generally, the top level functions of the driver do this
locking. So the tc entry points into the driver. The lower level code
just assumes the lock is held, and the lowest level then has a debug
test to ensure it is held. The exception is interrupt handling, which
is a bit messy due to re-entrance.

There is also the advantage of the top level locking that your list
manipulation is then thread safe.

> +#define mv88e6xxx_tcam_match_set(key, _offset, data, mask) \
> +	do { \
> +		typeof(_offset) (offset) = (_offset); \
> +		BUILD_BUG_ON((offset) + sizeof((data)) > TCAM_MATCH_SIZE); \
> +		__mv88e6xxx_tcam_match_set(key, offset, sizeof(data), \
> +					   (u8 *)&(data), (u8 *)&(mask)); \
> +	} while (0)
> +
> +static inline void __mv88e6xxx_tcam_match_set(struct mv88e6xxx_tcam_key *key, unsigned int offset,
> +					      size_t size, u8 *data, u8 *mask)
> +{
> +	memcpy(&key->frame_data[offset], data, size);
> +	memcpy(&key->frame_mask[offset], mask, size);
> +}

I want to look at these two in more detail, i don't like macros like
this, nor inline functions in header files. But maybe they are needed.

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
> +		dev_warn(chip->dev, "used_keys: 0x%llx", dissector->used_keys);

This dev_warn seems like debug?

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

Missing blank line have }

> +		struct flow_match_basic match;
> +
> +		flow_rule_match_basic(rule, &match);
> +		// ethertype
> +		mv88e6xxx_tcam_match_set(key, 16, match.key->n_proto, match.mask->n_proto);
> +		mv88e6xxx_tcam_match_set(key, 27, match.key->ip_proto, match.mask->ip_proto);

What are these magic numbers?

> +int mv88e6xxx_cls_flower_add(struct dsa_switch *ds, int port,
> +			     struct flow_cls_offload *cls, bool ingress)
> +{
> +	struct mv88e6xxx_chip *chip = ds->priv;
> +	struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
> +	struct netlink_ext_ack *extack = cls->common.extack;
> +	unsigned long cookie = cls->cookie;
> +	const struct flow_action_entry *act;
> +	struct mv88e6xxx_tcam_key key = { 0 };
> +	struct mv88e6xxx_tcam_entry *entry;
> +	int rc, i;

Reverse Christmass tree. This applies everywhere in the patch.

> +	flow_action_for_each(i, act, &rule->action) {
> +		switch (act->id) {
> +		case FLOW_ACTION_TRAP: {
> +			int cpu = dsa_upstream_port(ds, port);
> +
> +			entry->action.dpv_mode = DPV_MODE_REPLACE;
> +			entry->action.dpv = BIT(cpu);
> +			break;
> +		}
> +		default: {
> +			NL_SET_ERR_MSG_MOD(extack, "action not supported");
> +			rc = -EOPNOTSUPP;
> +			goto err_free_entry;
> +		}
> +		}

Two } on the same level suggests the indentation is broken.

	Andrew

