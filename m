Return-Path: <netdev+bounces-295596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FjDNHD43Imq6TwEAu9opvQ
	(envelope-from <netdev+bounces-295596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:41:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E69C0644B80
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:41:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NUyGIfj8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295596-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295596-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2109230515B1
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF9F3E7BD7;
	Fri,  5 Jun 2026 02:38:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E363E3D95;
	Fri,  5 Jun 2026 02:38:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627131; cv=none; b=NMHty+SYSucB4/Oyghg0926A4XCnrmVnRz1FglpZHyqeO3YbH0FRXDsnVNFpY3CO83dJWCPOKiKsrArwua4KkVo31p/KObicEYxV9LvQ1GbGVvK42r+JB6BxB9Q24h6wJK9x+JCKDKaJtELEAozJBLdPSBNeHvljieEfHYdQVZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627131; c=relaxed/simple;
	bh=sn7zpUxy22Hja8bbh+CIF3eXqCMVoy7QnuUYrtejGso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kS0KFXotyX4mluWx5AW9NZIV5JTPEO8lpEJVbh5lh7v3d08LjLoQEjR/DtIhuGNjYyN/O7zTZ1B57cjvyXp25lnP/Z3IVlpIxihjExOjva6NfabGFHGN8bSYLLtqWSECaMeh/mEJyH5NHPPAtc680kX3J6qmrKIioqTt3qHEPfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUyGIfj8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669781F0089B;
	Fri,  5 Jun 2026 02:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780627118;
	bh=MWBOzxBMxgHl6TjAVpvpMpXtUg1vYflz1NEGmnBzG8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NUyGIfj8rP/vZRyeUebx96l9mT024duyBXQJlQTpfchg0jKb8/GDhnhfVLzKd3Du+
	 /KSRcV6F7zq3VZBsiCHWxkuS17b9w99y4TLplz5te066ZfPzt+7Ug/t9dw4IhRjvIu
	 /7Ay34HvTJpdr/wpzssSvcMc+r0jnNnTTVK4b7cmHEFM88e/jlHyb8uyEc2v+HoGvG
	 rCubuwW/VultKfn5E/ZJu7A4K7YnNaEyXL+NqMBWWNAKPNamYLYdaWukAfMtHzRCLx
	 kWbnV0x7nOeQ14haHcT21PrQon8gCQbOWlFNZ58s/0jfwlL8EDSL8HEwWUfHaJcZjl
	 QhVV3ixAmhihQ==
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
Subject: Re: [PATCH net-next v4 10/12] net: atlantic: add AQC113 PTP hardware ops in hw_atl2
Date: Thu,  4 Jun 2026 19:38:37 -0700
Message-ID: <20260605023837.3629173-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602135452.516-11-sukhdeeps@marvell.com>
References: <20260602135452.516-11-sukhdeeps@marvell.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295596-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E69C0644B80

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: atlantic: add AQC113 PTP hardware ops in hw_atl2

This patch wires the AQC113 (Antigua) PTP hardware ops into hw_atl2:
TSG clock setup/adjust, PTP ring init, TX timestamp readback from
descriptor writeback, RX timestamp extraction from packet trailer, and
GPIO pulse / PPS output. It also reduces HW_ATL2_RXBUF_MAX from 192 to
172.

[Low]
On the commit message itself, a couple of descriptions look like they
do not quite match the code that landed in this patch:

   - hw_atl2.h/hw_atl2_utils.h/hw_atl2_internal.h: export PTP function
     prototypes, per-instance aq_ptp_offset arrays, RX timestamp size

Every new hw_atl2 PTP function is static in hw_atl2.c and is reached
only through hw_atl2_ops, so are any prototypes actually being exported
from the headers?  The new HW_ATL2_PTP_OFFSET_* additions in hw_atl2.h
are also individual scalar #defines, not arrays — should the wording be
adjusted?

   - hw_atl2.c: implement hw_atl2_enable_ptp() to program TSG clocks,
     PTP TC receive path and filter ART entries, and re-enable PTP
     state after hardware reset.

The hw_atl2_enable_ptp() body only resets/enables the TSG clocks,
optionally calls hw_atl2_adj_clock_freq(), and toggles
hw_atl2_tpb_tps_highest_priority_tc_enable_set().  Is the "PTP TC
receive path and filter ART entries" claim describing this patch, or
work that lives in another patch in the series?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 6d9ec4072d43..e94627c36163 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c

[ ... ]

> @@ -127,6 +137,7 @@ static u32 hw_atl2_sem_act_rslvr_get(struct aq_hw_s *self)
>  static int hw_atl2_hw_reset(struct aq_hw_s *self)
>  {
>  	struct hw_atl2_priv *priv = self->priv;
> +	s8 clk_sel;
>  	int err;
>  	int i;
>  
> @@ -144,6 +155,13 @@ static int hw_atl2_hw_reset(struct aq_hw_s *self)
>  		priv->l3l4_filters[i].l4_index = -1;
>  	}
>  
> +	clk_sel = READ_ONCE(self->clk_select);
> +	if (clk_sel != -1)
> +		hw_atl2_enable_ptp(self,
> +				   clk_sel,
> +				   aq_utils_obj_test(&self->flags, AQ_HW_PTP_AVAILABLE) ?
> +				   1 : 0);
> +

[Medium]
Where is self->clk_select initialised to -1?

struct aq_hw_s is allocated through kzalloc_obj() in aq_pci_func.c, so
clk_select starts as 0, and 0 is also a valid clock index
(ATL_TSG_CLOCK_SEL_0).  On the very first aq_nic_init()->hw_reset()
the test:

	if (clk_sel != -1)
		hw_atl2_enable_ptp(self, clk_sel, ...);

evaluates true with clk_sel == 0, and AQ_HW_PTP_AVAILABLE is not set
yet at this point in the series (aq_ptp_init() in this tree only sets
it for the a1 PTP path), so hw_atl2_enable_ptp(self, 0, 0) gets
unconditionally called for every hw_atl2 chip including aqc115c and
aqc116c.

That call then does:

	hw_atl2_tsg_clock_reset(self, 0);
	hw_atl2_tsg_clock_en(self, 1, 0);
	hw_atl2_tsg_clock_en(self, 0, 0);
	hw_atl2_tpb_tps_highest_priority_tc_enable_set(self, 0);

on parts that may have no PTP setup at all.  Should the -1 sentinel
initialisation that lives in a later patch in the series be folded
into this commit so each commit is self-contained for bisection?

>  	self->aq_fw_ops->set_state(self, MPI_RESET);
>  
>  	err = aq_hw_err_from_flags(self);
> @@ -725,14 +743,32 @@ static int hw_atl2_hw_ring_rx_init(struct aq_hw_s *self,
>  				   struct aq_ring_s *aq_ring,
>  				   struct aq_ring_param_s *aq_ring_param)
>  {
> -	return hw_atl_b0_hw_ring_rx_init(self, aq_ring, aq_ring_param);
> +	int res = hw_atl_b0_hw_ring_rx_init(self, aq_ring, aq_ring_param);
> +
> +	if (!res && aq_ptp_ring(aq_ring->aq_nic, aq_ring)) {
> +		int rx_err = hw_atl2_hw_rx_ptp_ring_init(self, aq_ring);
> +
> +		if (!res)
> +			res = rx_err;
> +	}
> +
> +	return res;
>  }
>  
>  static int hw_atl2_hw_ring_tx_init(struct aq_hw_s *self,
>  				   struct aq_ring_s *aq_ring,
>  				   struct aq_ring_param_s *aq_ring_param)
>  {
> -	return hw_atl_b0_hw_ring_tx_init(self, aq_ring, aq_ring_param);
> +	int res = hw_atl_b0_hw_ring_tx_init(self, aq_ring, aq_ring_param);
> +
> +	if (!res && aq_ptp_ring(aq_ring->aq_nic, aq_ring)) {
> +		int tx_err = hw_atl2_hw_tx_ptp_ring_init(self, aq_ring);
> +
> +		if (!res)
> +			res = tx_err;
> +	}
> +
> +	return res;
>  }

[Low]
The inner if (!res) check is provably always true here — the outer
if (!res && aq_ptp_ring(...)) already established res == 0 for the
whole block:

	if (!res && aq_ptp_ring(aq_ring->aq_nic, aq_ring)) {
		int rx_err = hw_atl2_hw_rx_ptp_ring_init(self, aq_ring);

		if (!res)         /* always true */
			res = rx_err;
	}

Was the intent to also call the PTP ring init when the b0 init had
already failed (and only then preserve the first error), or is the
inner test simply redundant and meant to be a plain res = rx_err?

[ ... ]

> @@ -892,6 +928,151 @@ static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
>  	return &self->curr_stats;
>  }
>  
> +static void hw_atl2_enable_ptp(struct aq_hw_s *self,
> +			       unsigned int param, int enable)
> +{
> +	WRITE_ONCE(self->clk_select, (s8)param);
> +
> +	/* enable tsg counter */
> +	hw_atl2_tsg_clock_reset(self, self->clk_select);
> +	hw_atl2_tsg_clock_en(self, !self->clk_select, enable);
> +	hw_atl2_tsg_clock_en(self, self->clk_select, enable);
> +
> +	if (enable)
> +		hw_atl2_adj_clock_freq(self, 0);
> +
> +	hw_atl2_tpb_tps_highest_priority_tc_enable_set(self, enable);
> +}

[Low]
Is mixing one WRITE_ONCE store with three plain reads of the same
field intentional?

The other accessors in this file (hw_atl2_hw_reset(), aq_get_ptp_ts(),
hw_atl2_adj_sys_clock(), hw_atl2_adj_clock_freq(),
hw_atl2_hw_get_clk_sel()) consistently use READ_ONCE(self->clk_select),
suggesting the field is treated as concurrent state.  Here the three
plain reads after WRITE_ONCE() defeat that protocol and KCSAN will
flag the inconsistent annotations.

Would using the local param value (which is what was just stored) be
clearer, e.g.:

	s8 sel = (s8)param;

	WRITE_ONCE(self->clk_select, sel);
	hw_atl2_tsg_clock_reset(self, sel);
	hw_atl2_tsg_clock_en(self, !sel, enable);
	hw_atl2_tsg_clock_en(self, sel, enable);

> +
> +static void aq_get_ptp_ts(struct aq_hw_s *self, u64 *stamp)
> +{
> +	s8 clk_sel = READ_ONCE(self->clk_select);
> +
> +	if (clk_sel < 0)
> +		return;
> +	if (stamp)
> +		*stamp = hw_atl2_tsg_clock_read(self, clk_sel);
> +}

[Medium]
Can this leave *stamp uninitialised on the early return?

The existing callers in aq_ptp.c declare an uninitialised stack
variable and pass its address straight in, expecting the callee to
populate it:

aq_ptp_gettime():
	u64 ns;

	aq_ptp_get_sync_time_from_pkt(aq_nic, NULL, &ns);
	...
	hw_get_ptp_ts() variants are called the same way

aq_ptp_settime():
	u64 now;

	aq_nic->aq_hw_ops->hw_get_ptp_ts(aq_nic->aq_hw, &now);

aq_ptp_pps_pin_configure():
	u64 start;

	aq_nic->aq_hw_ops->hw_get_ptp_ts(aq_nic->aq_hw, &start);

When clk_sel < 0 the new aq_get_ptp_ts() returns without touching
*stamp, so the caller then forwards stack garbage as a timestamp
(into ns_to_timespec64() in the gettime path, into hw_adj_sys_clock()
in settime).  Should the early return set *stamp = 0 first, or should
the prototype be changed to return an error?

> +
[ ... ]
> +static int hw_atl2_hw_rx_ptp_ring_init(struct aq_hw_s *self,
> +				       struct aq_ring_s *aq_ring)
> +{
> +	hw_atl2_rpf_rx_desc_timestamp_req_set(self,
> +					      self->clk_select == ATL_TSG_CLOCK_SEL_1 ? 2 : 1,
> +					      aq_ring->idx);
> +	return aq_hw_err_from_flags(self);
> +}

[Low]
This reads self->clk_select with a plain access while every other
reader of the same field in this file uses READ_ONCE().  Should this
also be:

	s8 clk_sel = READ_ONCE(self->clk_select);

	hw_atl2_rpf_rx_desc_timestamp_req_set(self,
					      clk_sel == ATL_TSG_CLOCK_SEL_1 ? 2 : 1,
					      aq_ring->idx);

[ ... ]

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
> index 31d7cae6641a..8da3262c167d 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
> @@ -29,7 +29,8 @@
>  #define HW_ATL2_TXBUF_MAX              128U
>  #define HW_ATL2_PTP_TXBUF_SIZE           8U
>  
> -#define HW_ATL2_RXBUF_MAX              192U
> +/* AQC113 on-chip RX packet buffer available for data TCs */
> +#define HW_ATL2_RXBUF_MAX              172U
>  #define HW_ATL2_PTP_RXBUF_SIZE          16U
>  #define HW_ATL2_RSS_REDIRECTION_MAX 64U

[Medium]
The comment scopes this change to AQC113, but HW_ATL2_RXBUF_MAX is
used unconditionally in hw_atl2_hw_qos_set():

	u32 rx_buff_size = HW_ATL2_RXBUF_MAX;

for hw_atl2_caps_aqc113, hw_atl2_caps_aqc115c and
hw_atl2_caps_aqc116c, with no per-chip selection.  Does the same
on-chip 172 KB limit apply to aqc115c and aqc116c, or does this
silently shrink the RX buffer pool for chips outside the stated
scope of the patch?

The non-PTP path on AQC113 is also affected: hw_atl2_hw_qos_set()
already subtracts HW_ATL2_PTP_RXBUF_SIZE (16) when cfg->is_ptp is
set, so the PTP TC reservation is independent of this base value.
Would it make sense to split the RXBUF_MAX change into its own
commit with a Fixes: tag (if 192 was wrong) or a justification (if
this is a tradeoff for a new TC layout)?

[ ... ]

