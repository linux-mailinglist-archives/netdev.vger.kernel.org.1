Return-Path: <netdev+bounces-295594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q0+8Dr42ImqpTwEAu9opvQ
	(envelope-from <netdev+bounces-295594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:38:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A391D644B5E
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:38:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=c3QN+yvT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295594-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295594-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51647301F484
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6956F3E8341;
	Fri,  5 Jun 2026 02:38:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7D391507;
	Fri,  5 Jun 2026 02:38:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627120; cv=none; b=aZF9wMrnfLRQoxV2BH4r/JeO5sPtQYy2KV0KwXixFeptd+hdCooilEux3qQ9xSE/Lb5d7zeLstv6lOrXeHVBaTfFrINXbIz4NCpFzKXk0IXeKOdhybFVW6ZOrQQlBuo1SnOUUW2lcgR60H6VJoqYFW7PynnEErI5fh9EonwEE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627120; c=relaxed/simple;
	bh=m9BSIbIw4s7WJIctrYVCa4WXUj1lnuXHCZm8JrFTj+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAePND5cY0bty4rK7+syW7SO18oPDMQHnPvjYdyFZMuhaKL5ronklqXjDRRgHuiYZEfbx/Cj2AD8nY7XyokZAfcLkoBHMARLHmKJuMkUw1N2/yzxzMOb6v8Y8flhVXSv7nMfVWxGycNf7p5RkX99kREqIUnkClRlbzaSzaqacN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3QN+yvT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81A01F00893;
	Fri,  5 Jun 2026 02:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780627111;
	bh=Hg+fGRs9zH/4yImd4sjINVXE++n8vPxI/VvGaadI6/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c3QN+yvTFPkDEHAS0/9lqCPy7IUnhIEe4hPsqi+1q2zCXsed7fVPl0GfaSgZS5/KS
	 xXS5VVMKTWy5M4E+SgiZimhDhwZ8m5Ow/IaQYjPRnaAB84yx/P6IRLaIOHsYUfSg7N
	 iH+7x+8n/FeUg1KYUmNnOLySzgwVv1Fz/dI6+dVEiCStxI9QU7kBAJi/oByk+/RE/P
	 gTTC3c0ZtfyJ9CsE7zlXteLwvxliDs+Qw7+BhQbB6XA3rFyYia6geKcwPx9b02Qavk
	 DTBcTQyYhnTCVaSw1GLmoiSdU2NMdia1P/cusTvMI5Cz13ZxOwreBac9gNr+jREwQy
	 y6D4wrzEO2XpA==
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
Subject: Re: [PATCH net-next v4 5/12] net: atlantic: add AQC113 filter data structures and firmware query
Date: Thu,  4 Jun 2026 19:38:28 -0700
Message-ID: <20260605023828.3629062-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602135452.516-6-sukhdeeps@marvell.com>
References: <20260602135452.516-6-sukhdeeps@marvell.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-295594-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sukhdeeps@marvell.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A391D644B5E

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: atlantic: add AQC113 filter data structures and firmware query

This patch adds L3/L4/L3L4 and ethertype tag filter data structures to
hw_atl2_priv, defines RPF L3/L4 command bits and several filter count
constants, and queries filter capabilities from firmware shared memory
during aq_a2_fw_init().  It also adds an unrelated MAC register dump
helper hw_atl2_utils_hw_get_regs().

A few questions inline.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
> index 5a89bb8722f9..fc086d84fb91 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h

[ ... ]

> @@ -94,6 +106,12 @@ enum HW_ATL2_RPF_ART_INDEX {
>  #define HW_ATL2_ACTION_DISABLE HW_ATL2_ACTION(0, 0, 0, 0)
>  #define HW_ATL2_ACTION_ASSIGN_QUEUE(QUEUE) HW_ATL2_ACTION(1, 0, (QUEUE), 1)
>  #define HW_ATL2_ACTION_ASSIGN_TC(TC) HW_ATL2_ACTION(1, 1, (TC), 1)
> +#define HW_ATL2_RPF_L3L4_FILTERS 8
> +#define HW_ATL2_RPF_L3V4_FILTERS 8
> +#define HW_ATL2_RPF_L4_FILTERS 8
> +#define HW_ATL2_RPF_VLAN_FILTERS 16
> +#define HW_ATL2_RPF_ETYPE_FILTERS 16
> +#define HW_ATL2_RPF_ETYPE_TAGS 7

[Low]
HW_ATL2_RPF_L3V4_FILTERS and HW_ATL2_RPF_L4_FILTERS look unused.

Every array in hw_atl2_priv (l3_v4_filters[], l3_v6_filters[],
l4_filters[], l3l4_filters[]) is sized with HW_ATL2_RPF_L3L4_FILTERS, and
the bounds clamps in hw_atl2_utils_get_filter_caps() also compare against
HW_ATL2_RPF_L3L4_FILTERS.  HW_ATL2_RPF_L3V4_FILTERS and
HW_ATL2_RPF_L4_FILTERS appear nowhere else in tree, and there is no
symmetric HW_ATL2_RPF_L3V6_FILTERS even though the commit message
enumerates IPv4 and IPv6 as distinct categories.

Should the unused names be dropped, or should the arrays and clamps be
switched to use them so that, for example, lowering
HW_ATL2_RPF_L4_FILTERS in the future actually has effect?

[ ... ]

> +struct hw_atl2_l3_filter {
> +	u8 proto;
> +	u8 usage;
> +	u32 cmd;
> +	u32 srcip[4];
> +	u32 dstip[4];
> +};
> +
> +struct hw_atl2_l4_filter {
> +	u8 usage;
> +	u32 cmd;
> +	u16 sport;
> +	u16 dport;
> +};

[Low]
The commit message says these structures provide "reference-counted
sharing support", but the only field that looks like a refcount is a
plain u8 usage with no atomic_t, refcount_t, or paired inc/dec helpers
in this commit.  Could the wording in the commit message be tightened
to match what is actually added (a serialized usage counter, not a
refcount)?

[ ... ]

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
> index 0fe6257d9c08..ef549e172dd9 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
> @@ -128,3 +128,37 @@ int hw_atl2_utils_soft_reset(struct aq_hw_s *self)
>  err_exit:
>  	return err;
>  }
> +
> +static const u32 hw_atl2_utils_hw_mac_regs[] = {

[Low]
The subject and body describe filter data structures and firmware
capability discovery, but the diff also adds a 72-entry MAC register
table and the new register-dump helper hw_atl2_utils_hw_get_regs().  The
register dump utility is unrelated to filter discovery and is not
mentioned in the subject.

Would it be better to split this into a separate patch (or fold it into
the follow-up commit that wires hw_atl2_utils_hw_get_regs() into
hw_atl2_ops) so that this patch is one logical change?

[ ... ]

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
> index 7370e3f76b62..3011c7cd5259 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c

[ ... ]

> +int hw_atl2_utils_get_filter_caps(struct aq_hw_s *self)
> +{
> +	struct hw_atl2_priv *priv = self->priv;
> +	struct filter_caps_s filter_caps;
> +	u32 tag_top;
> +	int err;
> +	u32 min_val;
> +
> +	err = hw_atl2_shared_buffer_read_safe(self, filter_caps, &filter_caps);
> +	if (err)
> +		return err;
> +
> +	priv->art_base_index = filter_caps.rslv_tbl_base_index * 8;
> +	priv->art_count = filter_caps.rslv_tbl_count * 8;
> +	if (priv->art_count == 0)
> +		priv->art_count = 128;

[Low]
What does the literal 128 represent here?  It has no #define, no comment,
and no log message.  If firmware legitimately reports a 0 count (feature
unavailable, FW bug, restricted SKU), this silently substitutes 128 ART
entries and the driver could later program slots beyond what the part
actually has.

Could this be promoted to a named macro alongside HW_ATL2_RPF_ART_INDEX
with a short rationale, and possibly a netdev_warn() noting that the
firmware did not advertise an ART count?

[Low]
priv->art_base_index now has two writers reading the same firmware
field.  This function sets:

	priv->art_base_index = filter_caps.rslv_tbl_base_index * 8;

while the pre-existing helper

	int hw_atl2_utils_get_action_resolve_table_caps(struct aq_hw_s *self,
							u8 *base_index, u8 *count);

is still called from hw_atl2.c, which then assigns
priv->art_base_index = base_index * 8 from its out-parameter.

Is one of these now redundant?  Should callers move to consume the
cached priv->art_base_index, or is there a reason to keep both
sources of truth?

> +	priv->l2_filters_base_index = filter_caps.l2_filters_base_index;
> +	priv->l2_filter_count = filter_caps.l2_filter_count;
> +	priv->etype_filter_base_index = filter_caps.ethertype_filter_base_index;
> +	priv->etype_filter_count = filter_caps.ethertype_filter_count;
> +	priv->etype_filter_tag_top =
> +		(priv->etype_filter_count >= HW_ATL2_RPF_ETYPE_TAGS) ?
> +		 (HW_ATL2_RPF_ETYPE_TAGS) : (HW_ATL2_RPF_ETYPE_TAGS >> 1);

[Low]
The L3 and L4 paths below clamp base_index against HW_ATL2_RPF_L3L4_FILTERS
and use min_t() on the count, but the etype, l2 and vlan_filter_base_index
fields are copied verbatim from filter_caps_s u8 values (range 0..255).

Is that asymmetry intentional?  It would be easier for future consumers
to reason about if every firmware-supplied capability field were
range-checked against its compile-time array bound (etype_policy[] is
sized HW_ATL2_RPF_ETYPE_FILTERS, etc.) at the FW boundary, in this one
place.

> +	priv->vlan_filter_base_index = filter_caps.vlan_filter_base_index;
> +	/* 0 - no tag, 1 - reserved for vlan-filter-offload filters */
> +	tag_top =
> +		  (filter_caps.vlan_filter_count == HW_ATL2_RPF_VLAN_FILTERS) ?
> +		  (HW_ATL2_RPF_VLAN_FILTERS - 2) :
> +		  (HW_ATL2_RPF_VLAN_FILTERS / 2 - 2);
> +
> +	if (filter_caps.vlan_filter_count > 2)
> +		priv->vlan_filter_count = min_t(u32,
> +						filter_caps.vlan_filter_count - 2,
> +						tag_top);
> +	else
> +		priv->vlan_filter_count = 0;

[Low]
When firmware reports filter_caps.vlan_filter_count of 1 or 2, the
"> 2" gate forces priv->vlan_filter_count to 0 silently, with no
netdev_dbg()/netdev_warn().  The comment only documents the 2-entry
reservation when the count is large.

Is the silent disable on a small but nonzero count intentional, and
worth a short log line so users can tell why VLAN filtering came up
disabled?

> +	priv->l3_v4_filter_base_index = filter_caps.l3_ip4_filter_base_index;
> +	if (priv->l3_v4_filter_base_index >= HW_ATL2_RPF_L3L4_FILTERS) {
> +		priv->l3_v4_filter_base_index = 0;
> +		priv->l3_v4_filter_count = 0;
> +	} else {
> +		min_val = HW_ATL2_RPF_L3L4_FILTERS - 1 - priv->l3_v4_filter_base_index;
> +		priv->l3_v4_filter_count = min_t(u32,
> +						 filter_caps.l3_ip4_filter_count,
> +						 min_val);
> +	}

[Medium]
Is the "- 1" in this clamp intentional?

The arrays are sized HW_ATL2_RPF_L3L4_FILTERS (= 8), and consumers in
the follow-up patch "net: atlantic: implement AQC113 L2/L3/L4 RX filter
ops" iterate over priv->l3_v4_filters[] / l3_v6_filters[] / l4_filters[]
as a half-open range:

	for (i = base; i < base + count; i++)

With base_index = 0 and firmware reporting count = 8 (the natural
maximum for a 4-bit field):

	min_val = 8 - 1 - 0 = 7
	priv->l3_v4_filter_count = min_t(u32, 8, 7) = 7

so slot 7 is permanently unreachable.  With base_index = 7 (still
in-range, since the validity check is ">= HW_ATL2_RPF_L3L4_FILTERS"):

	min_val = 8 - 1 - 7 = 0
	priv->l3_v4_filter_count = 0

so the entire pool reports zero filters even though slot 7 exists.

For the half-open consumer convention, the formula that exactly fills
the array is:

	min_val = HW_ATL2_RPF_L3L4_FILTERS - priv->l3_v4_filter_base_index;

The same pattern is duplicated in the l3_v6 and l4 blocks below, and
unlike the VLAN logic in this same function (which has the "- 2"
comment explaining its reservation), the "- 1" here is undocumented.

> +
> +	priv->l3_v6_filter_base_index = filter_caps.l3_ip6_filter_base_index;
> +	if (priv->l3_v6_filter_base_index >= HW_ATL2_RPF_L3L4_FILTERS) {
> +		priv->l3_v6_filter_base_index = 0;
> +		priv->l3_v6_filter_count = 0;
> +	} else {
> +		min_val = HW_ATL2_RPF_L3L4_FILTERS - 1 - priv->l3_v6_filter_base_index;
> +		priv->l3_v6_filter_count = min_t(u32,
> +						 filter_caps.l3_ip6_filter_count,
> +						 min_val);
> +	}
> +
> +	priv->l4_filter_base_index = filter_caps.l4_filter_base_index;
> +	if (priv->l4_filter_base_index >= HW_ATL2_RPF_L3L4_FILTERS) {
> +		priv->l4_filter_base_index = 0;
> +		priv->l4_filter_count = 0;
> +	} else {
> +		min_val = HW_ATL2_RPF_L3L4_FILTERS - 1 - priv->l4_filter_base_index;
> +		priv->l4_filter_count = min_t(u32,
> +					      filter_caps.l4_filter_count,
> +					      min_val);
> +	}
> +
> +	return 0;
> +}

Same "- 1" question as above for the l3_v6 and l4 blocks.

