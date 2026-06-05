Return-Path: <netdev+bounces-295595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fpdONQw3Imq0TwEAu9opvQ
	(envelope-from <netdev+bounces-295595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:40:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E01E644B75
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:40:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eNAAwSOY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295595-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295595-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDB25302BBCE
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5103C345A;
	Fri,  5 Jun 2026 02:38:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82E3BB677;
	Fri,  5 Jun 2026 02:38:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627127; cv=none; b=DyPb98y+6kv60UfQifKYcbjyx1TrTaNqu4zAxrVImrNYXizY9ZfP+XMoQYANAEa+kh6KeJdw2ERGdyegrNUg+WYY5XJACUxndSO71hdTA/P9oOcRXCQrAX8Chr9Iitj9Xtk1+OaxRQwOvp12H09PUelfrX5MOp0LsNFGkxrw3tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627127; c=relaxed/simple;
	bh=LtCEhE69OZJMIcZijTbLlsQmWABBDJJa4xvGMBjZVwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehs9zpDDQVoNA5Anv3nlO1UURiiPt59qH0npwxe3rTEyfPivHETaIMfEVaCSJ383dyU/6TeaKSVbuTc142UHhVqiN64TCKmOAOvbMNLokBovdxTpm5ByShFNopFzVnV4sV62b8SlgCCWRBKxU2XsTvIxp3f64NtpKQ4PTBwVi8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNAAwSOY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B911F00899;
	Fri,  5 Jun 2026 02:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780627117;
	bh=6QbMMTu+jWsY7A9wTECEYRZhP1wOEcjM9sT+lCNHMvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eNAAwSOYmLUFwVpM0NAJF+gh8Gb4hpQd407JIu/5Pps4+lcubloiSNrqcnBQpugBv
	 jAxSN2OM1kUO4K1ME1IvMw6edMYFBJIKQ3rCXaiL0AzdGl6pg9T1xcCK6fgBx9cdBP
	 Na+pzk+ngKsHB027nd6jEBVu74ZRCRMqa2qPFvQ7n7CipQvjslJCULYZ7IKq1p/kIk
	 QsIA7g7B+96iz7/CTKAHRZrkEQqQppca7RPvF2Fz4uThi/Lf/xgK/WRC1OnFpCvItz
	 A2RtdC4olCLS7yNTUFsEQJ1J77Cf7mFf8W3mpDOTr1+dcH5CYmi3wXrAZRhciSkl6o
	 IQDtCtrqZ/gUw==
From: Jakub Kicinski <kuba@kernel.org>
To: sukhdeeps@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v4 7/12] net: atlantic: implement AQC113 L2/L3/L4 RX filter ops
Date: Thu,  4 Jun 2026 19:38:33 -0700
Message-ID: <20260605023833.3629131-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602135452.516-8-sukhdeeps@marvell.com>
References: <20260602135452.516-8-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295595-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sukhdeeps@marvell.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E01E644B75

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: atlantic: implement AQC113 L2/L3/L4 RX filter ops

This patch adds tag-based L2/L3/L4 RX filter management for AQC113,
including reference-counted L3 and L4 filter slots, an ART-based L3L4
configuration helper, and L2 ethertype set/clear, and wires the new
ops into hw_atl2_ops.

[Low]
The commit message describes hw_atl2_filter_tag_get/put as:

    Add tag-based filter policy with reference-counted sharing
    (hw_atl2_filter_tag_get/put), allowing multiple filter rules to share
    the same L3 or L4 hardware filter when their match criteria are
    identical.

In the patch, hw_atl2_filter_tag_get/put operate only on
priv->etype_policy[] and are called only from hw_atl2_hw_fl2_set/clear.
The L3 and L4 sharing is implemented separately via the usage field on
hw_atl2_l3_filter / hw_atl2_l4_filter and hw_atl2_rxf_l3_get/put /
hw_atl2_rxf_l4_get/put.

Could the description be reworded so it does not conflate the etype tag
policy with the L3/L4 filter refcounts?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 27a62fffbc29..a07a3dbddefe 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> @@ -87,6 +87,38 @@ const struct aq_hw_caps_s hw_atl2_caps_aqc116c = {
>  			  AQ_NIC_RATE_10M,
>  };
>  
> +/* Find tag with the same action or new free tag
> + *  top - top inclusive tag value
> + *  action - action for ActionResolverTable
> + */
> +static int hw_atl2_filter_tag_get(struct hw_atl2_tag_policy *tags,
> +				  int top, u16 action)
> +{
> +	int i;
> +
> +	for (i = 1; i <= top; i++)
> +		if (tags[i].usage > 0 && tags[i].action == action) {
> +			tags[i].usage++;
> +			return i;
> +		}
> +
> +	for (i = 1; i <= top; i++)
> +		if (tags[i].usage == 0) {
> +			tags[i].usage = 1;
> +			tags[i].action = action;
> +			return i;
> +		}
> +
> +	return -1;

[Low]
Sibling helpers introduced in this patch (hw_atl2_new_fl3l4_find_l3 /
_find_l4) return -ENOSPC on the no-free-slot path, but this helper
returns the bare value -1.

The current caller hw_atl2_hw_fl2_set() translates it into -ENOSPC
manually, but if a future caller propagates the value unchanged it
becomes -EPERM. Would returning -ENOSPC here directly be more
consistent?

> +}

[ ... ]

> @@ -823,6 +855,489 @@ static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
>  	return &self->curr_stats;
>  }
>  
> +static bool hw_atl2_rxf_l3_is_equal(struct hw_atl2_l3_filter *f1,
> +				    struct hw_atl2_l3_filter *f2)
> +{
> +	if (f1->cmd != f2->cmd)
> +		return false;
> +
> +	if (f1->cmd & HW_ATL2_RPF_L3_CMD_SA_EN)
> +		if (f1->srcip[0] != f2->srcip[0])
> +			return false;
> +
> +	if (f1->cmd & HW_ATL2_RPF_L3_CMD_DA_EN)
> +		if (f1->dstip[0] != f2->dstip[0])
> +			return false;
> +
> +	if (f1->cmd & (HW_ATL2_RPF_L3_CMD_PROTO_EN |
> +		       HW_ATL2_RPF_L3_V6_CMD_PROTO_EN))
> +		if (f1->proto != f2->proto)
> +			return false;

[Low]
Where is l3.proto ever populated? In hw_atl2_new_fl3l4_configure() the
local l3 is memset to 0 and the protocol value is encoded into the upper
bits of l3.cmd via:

    l3.cmd |= IPPROTO_TCP << (data->is_ipv6 ? 0x18 : 8);

hw_atl2_rxf_l3_get() then copies _l3->proto (=0) into the tracked slot,
so this proto comparison appears to be 0 == 0 in all cases. The actual
protocol comparison happens implicitly via the f1->cmd != f2->cmd check
above.

Should l3.proto be removed, or populated consistently from the cmd
encoding, so future code that begins setting one but not the other does
not silently produce false negatives in the sharing check?

> +
> +	if (f1->cmd & HW_ATL2_RPF_L3_V6_CMD_SA_EN)
> +		if (memcmp(f1->srcip, f2->srcip, 16))
> +			return false;
> +
> +	if (f1->cmd & HW_ATL2_RPF_L3_V6_CMD_DA_EN)
> +		if (memcmp(f1->dstip, f2->dstip, 16))
> +			return false;
> +
> +	return true;
> +}

[ ... ]

> +static void hw_atl2_rxf_l3_get(struct aq_hw_s *self,
> +			       struct hw_atl2_l3_filter *l3, int idx,
> +			       const struct hw_atl2_l3_filter *_l3)
> +{
> +	int i;
> +
> +	l3->usage++;
> +	if (l3->usage == 1) {
> +		l3->cmd = _l3->cmd;
> +		for (i = 0; i < 4; i++) {
> +			l3->srcip[i] = _l3->srcip[i];
> +			l3->dstip[i] = _l3->dstip[i];
> +		}
> +		l3->proto = _l3->proto;
> +
> +		if (l3->cmd & HW_ATL2_RPF_L3_CMD_EN) {
> +			hw_atl2_rpf_l3_v4_cmd_set(self, l3->cmd, idx);
> +			hw_atl2_rpf_l3_v4_tag_set(self, idx + 1, idx);
> +			hw_atl2_rpf_l3_v4_dest_addr_set(self,
> +							idx,
> +							l3->dstip[0]);
> +			hw_atl2_rpf_l3_v4_src_addr_set(self,
> +						       idx,
> +						       l3->srcip[0]);
> +		} else {
> +			hw_atl2_rpf_l3_v6_cmd_set(self, l3->cmd, idx);
> +			hw_atl2_rpf_l3_v6_tag_set(self, idx + 1, idx);
> +			hw_atl2_rpf_l3_v6_dest_addr_set(self,
> +							idx,
> +							l3->dstip);
> +			hw_atl2_rpf_l3_v6_src_addr_set(self,
> +						       idx,
> +						       l3->srcip);
> +		}
> +	}
> +}

[Medium]
Is the ordering of the MMIO writes here intentional?

The cmd word containing the EN/SA_EN/DA_EN/PROTO_EN bits is committed
first via hw_atl2_rpf_l3_v4_cmd_set() (the v4 mask is 0xFFFF and
includes the EN bit), and only afterwards are the destination and
source address registers programmed.

Between the cmd write and the address writes, the filter is enabled
while its DA/SA registers still hold whatever value they had before
(stale, zero, or a previously programmed filter's addresses).

The IPv6 path is worse because hw_atl2_rpf_l3_v6_dest_addr_set() and
_src_addr_set() each issue four separate register writes (one per
dword), so the filter is enabled with a partially-programmed address
for several MMIO cycles.

The same pattern is in hw_atl2_rxf_l4_get() below. Would it be safer to
program the addresses (or ports) and tag first and write the cmd word
with EN last?

[ ... ]

> +static void hw_atl2_rxf_l4_get(struct aq_hw_s *self,
> +			       struct hw_atl2_l4_filter *l4, int idx,
> +			       const struct hw_atl2_l4_filter *_l4)
> +{
> +	l4->usage++;
> +	if (l4->usage == 1) {
> +		l4->cmd = _l4->cmd;
> +		l4->sport = _l4->sport;
> +		l4->dport = _l4->dport;
> +
> +		hw_atl2_rpf_l4_cmd_set(self, l4->cmd, idx);
> +		hw_atl2_rpf_l4_tag_set(self, idx + 1, idx);
> +		hw_atl_rpf_l4_spd_set(self, l4->sport, idx);
> +		hw_atl_rpf_l4_dpd_set(self, l4->dport, idx);
> +	}
> +}
> +
> +static int hw_atl2_new_fl3l4_configure(struct aq_hw_s *self,
> +				       struct aq_rx_filter_l3l4 *data)
> +{

[ ... ]

> +	/* convert legacy filter to new */
> +	if (data->cmd & HW_ATL_RX_ENABLE_CMP_PROT_L4) {
> +		l3.cmd |= data->is_ipv6 ? HW_ATL2_RPF_L3_V6_CMD_PROTO_EN :
> +					  HW_ATL2_RPF_L3_CMD_PROTO_EN;
> +		l3.cmd |= data->is_ipv6 ? HW_ATL2_RPF_L3_V6_CMD_EN :
> +					  HW_ATL2_RPF_L3_CMD_EN;
> +		switch (data->cmd & 0x7) {
> +		case HW_ATL_RX_TCP:
> +			l3.cmd |= IPPROTO_TCP << (data->is_ipv6 ? 0x18 : 8);
> +			break;
> +		case HW_ATL_RX_UDP:
> +			l3.cmd |= IPPROTO_UDP << (data->is_ipv6 ? 0x18 : 8);
> +			break;
> +		case HW_ATL_RX_SCTP:
> +			l3.cmd |= IPPROTO_SCTP << (data->is_ipv6 ? 0x18 : 8);
> +			break;
> +		case HW_ATL_RX_ICMP:
> +			l3.cmd |= IPPROTO_ICMP << (data->is_ipv6 ? 0x18 : 8);
> +			break;

[Low]
For the IPv6 branch of HW_ATL_RX_ICMP, should the next-header value be
IPPROTO_ICMPV6 (58) rather than IPPROTO_ICMP (1)? Real ICMPv6 traffic
uses next-header 58, so this branch will not match ICMPv6 packets.

The aq_set_data_fl3l4() helper in aq_filters.c does not currently set
HW_ATL_RX_ICMP for any flow type, so the case is not reachable from the
in-tree ethtool ntuple path today, but it is written explicitly here.

[Low]
The shift values 0x18 and 8 are repeated four times here, while the
matching enable bits are named constants (HW_ATL2_RPF_L3_CMD_PROTO_EN
and HW_ATL2_RPF_L3_V6_CMD_PROTO_EN). Would a pair of named shift
macros (for example HW_ATL2_RPF_L3_CMD_PROTO_SHIFT /
HW_ATL2_RPF_L3_V6_CMD_PROTO_SHIFT) make the relationship between the
enable bit and the protocol byte position clearer and harder to
mis-edit?

> +		}
> +	}

[ ... ]

> +	/* find L3 and L4 filters */
> +	if (l3.cmd & (HW_ATL2_RPF_L3_CMD_EN | HW_ATL2_RPF_L3_V6_CMD_EN)) {
> +		l3_idx = hw_atl2_new_fl3l4_find_l3(self, &l3);
> +		if (l3_idx < 0)
> +			return l3_idx;
> +
> +		if (l3.cmd & HW_ATL2_RPF_L3_V6_CMD_EN)
> +			l3_filters = priv->l3_v6_filters;
> +		else
> +			l3_filters = priv->l3_v4_filters;
> +
> +		if (priv->l3l4_filters[data->location].l3_index != l3_idx ||
> +		    old_ipv6 != !!(l3.cmd & HW_ATL2_RPF_L3_V6_CMD_EN))
> +			hw_atl2_rxf_l3_get(self, &l3_filters[l3_idx],
> +					   l3_idx, &l3);
> +	}
> +
> +	if (old_l3_index != -1) {
> +		if (old_ipv6)
> +			l3_filters = priv->l3_v6_filters;
> +		else
> +			l3_filters = priv->l3_v4_filters;
> +
> +		if (!(hw_atl2_rxf_l3_is_equal(&l3,
> +					      &l3_filters[old_l3_index]))) {
> +			hw_atl2_rxf_l3_put(self,
> +					   &l3_filters[old_l3_index],
> +					   old_l3_index);
> +		}
> +	}
> +	if (l3.cmd & HW_ATL2_RPF_L3_V6_CMD_EN)
> +		priv->l3l4_filters[data->location].ipv6 = 1;
> +	else
> +		priv->l3l4_filters[data->location].ipv6 = 0;
> +	priv->l3l4_filters[data->location].l3_index = l3_idx;
> +
> +	if (l4.cmd & HW_ATL2_RPF_L4_CMD_EN) {
> +		l4_idx = hw_atl2_new_fl3l4_find_l4(self, &l4);
> +		if (l4_idx < 0)
> +			return -EINVAL;

[High, Low]
By the time this L4 search runs, hw_atl2_new_fl3l4_configure() has
already mutated state for the new request:

  - hw_atl2_rxf_l3_get() programmed the new L3 hardware filter and
    bumped its refcount,
  - the old L3 filter has typically been released via
    hw_atl2_rxf_l3_put() (clearing its HW slot if it was the last
    user, since match criteria differ), and
  - priv->l3l4_filters[location].l3_index and .ipv6 have been
    overwritten to point at the new L3 slot.

When this branch returns, hw_atl2_hw_fl3l4_set() simply propagates
the error and skips the ART write, so the device is left with the new
L3 filter enabled (refcount 1) but no ART entry referencing its tag,
the old ART entry still pointing at the now-cleared old L3 tag, and
the user's previously-installed working rule effectively destroyed.

Userspace receives an error and will not call the disable path, so
the new L3 slot stays leaked. With only HW_ATL2_RPF_L3L4_FILTERS
slots per family, repeated failures rapidly exhaust the pool.

Could this path roll back the L3-side state (and refcounts) before
returning?

As a separate question, the L3 path uses:

    if (l3_idx < 0)
        return l3_idx;

while the L4 path overwrites the more specific value with -EINVAL:

    if (l4_idx < 0)
        return -EINVAL;

Should the L4 path also propagate l4_idx so userspace can distinguish
-ENOSPC from -EINVAL?

> +
> +		if (priv->l3l4_filters[data->location].l4_index != l4_idx)
> +			hw_atl2_rxf_l4_get(self, &priv->l4_filters[l4_idx],
> +					   l4_idx, &l4);
> +	}

[ ... ]

> +static int hw_atl2_hw_fl2_set(struct aq_hw_s *self,
> +			      struct aq_rx_filter_l2 *data)
> +{

[ ... ]

> +	tag = hw_atl2_filter_tag_get(priv->etype_policy,
> +				     priv->etype_filter_tag_top,
> +				     action);
> +
> +	if (tag < 0)
> +		return -ENOSPC;
> +
> +	req_tag |= tag << HW_ATL2_RPF_TAG_ET_OFFSET;
> +	hw_atl2_rpf_etht_flr_tag_set(self, tag, location);
> +	index = priv->art_base_index + HW_ATL2_RPF_ET_PCP_USER_INDEX +
> +		data->location;
> +	hw_atl2_act_rslvr_table_set(self, index, req_tag, mask, action);
> +
> +	hw_atl_rpf_etht_flr_en_set(self, 1U, location);
> +
> +	return aq_hw_err_from_flags(self);
> +}

[Medium]
Once hw_atl2_filter_tag_get() succeeds, the etype_policy slot's usage
count has been incremented. After that point this function still has
two ways to return an error without releasing that tag:

  - hw_atl2_act_rslvr_table_set() may return an error (semaphore poll
    timeout) — its return value is ignored here, but
  - aq_hw_err_from_flags(self) at the end can return -ENXIO or -EIO if
    AQ_HW_FLAG_ERR_UNPLUG / AQ_HW_FLAG_ERR_HW have been set during the
    register writes above.

Because HW_ATL2_RPF_ETYPE_TAGS is small (7), repeated transient HW
errors would gradually permanently exhaust the etype tag pool until
no L2 filter can be installed. Should a failure path here call
hw_atl2_filter_tag_put() before returning?

