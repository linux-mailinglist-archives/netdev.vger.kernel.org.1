Return-Path: <netdev+bounces-295598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 75pLEak3ImrLTwEAu9opvQ
	(envelope-from <netdev+bounces-295598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:42:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C949C644B9D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:42:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S0VEU1UB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295598-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295598-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0648930767B0
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21E3EDE77;
	Fri,  5 Jun 2026 02:38:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A33E9C2C;
	Fri,  5 Jun 2026 02:38:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627135; cv=none; b=Ld9GF/8FOS9kIG3ozdXl/2T83Xx/PhWexS6o1hP3WhMe+Z32zIEXWofvK7IRPnDgmsbFySJWc5f3NwfDyLiRgbLaj0dNhFkl7ULFtiMJe/IQz8cwVVNT99YlvFykBCJ2u1fMr0dqmurIxJq9NeU1iT7pqlZWwaiPFAmGoLOu0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627135; c=relaxed/simple;
	bh=aSFqxKOAh+N+pvFyHscgGdCc6LgSQwnG0vfNZiiyWD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbmghPWaBfnHnE6u+E93HtaIF9lCysuXzBZzLvBgPw/ytzM0dOeB1koKgqI0QNunc/16LvF/Cjm6XL9pJ8l5DWkAEVAjXCjAnr9LHi/IMkhAcYxITTFdlHGQmgE2jmaPPuGJbjGNLsnfRo/Y+en0N/dw6PT2Z/PbYzpQNkMTvT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0VEU1UB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023291F00893;
	Fri,  5 Jun 2026 02:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780627122;
	bh=kmJIVdddbWcKHCvqPod9ZDh3ILGwa9lU4SlqBqoW0AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S0VEU1UB/K48QHR8vmFAi3lCmls7FmWdu8nxzbUKxFmjp7PKxs0bo9vgleRpVObXn
	 KYsec7ltrZnOowWujjzXCmuIaPxxfFGCk5h8/vFdL7y3FuclxJq3fbo2oaGcyq5nmt
	 pvo29CM+8l8p9SQRtD4sJNTZSpwXaZyiMg143ZuMRDHcJRLKsgCfwAfOxBXspxWu/F
	 Vs8UFM9Hk4viuODzedXzc0QZ/72QpRqqjs7j1Vl+xRniqbr0uqXnkgLU+At0l/9iPR
	 8bj9XnHPD1guW6MZCCgQswDofrE8ogQEjuYjnMqpg/EH78RCXODLK3ZwOjnhtibBeb
	 X6vU8eH7CjBWw==
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
Subject: Re: [PATCH net-next v4 12/12] net: atlantic: add AQC113 PTP support in aq_ptp and driver core
Date: Thu,  4 Jun 2026 19:38:41 -0700
Message-ID: <20260605023841.3629304-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602135452.516-13-sukhdeeps@marvell.com>
References: <20260602135452.516-13-sukhdeeps@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-295598-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C949C644B9D

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: atlantic: add AQC113 PTP support in aq_ptp and driver core

This patch extends the atlantic driver's PTP support to AQC113 (Antigua)
hardware: it adds a per-instance PTP offset table, replaces the single
L3/L4 filter with an array of 4 multicast filter slots, introduces an
aq_ptp_state enum so link-change events can be distinguished from first
init, and reworks vector accounting for the new PTP IRQ count.

Thanks for the patch. A few questions follow inline.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> index 09c90c969fb1..d6cb2c509950 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c

[ ... ]

> @@ -172,7 +180,11 @@ static int aq_nic_update_link_status(struct aq_nic_s *self)
>  		aq_nic_update_interrupt_moderation_settings(self);
>  
>  		if (self->aq_ptp) {
> -			aq_ptp_clock_init(self);
> +			/* PTP does not work in some modes even if physical link is up */
> +			bool ptp_link_good = (self->aq_hw->aq_link_status.mbps >= 100 &&
> +					      self->aq_hw->aq_link_status.full_duplex);
> +
> +			aq_ptp_clock_init(self, ptp_link_good ? AQ_PTP_LINK_UP : AQ_PTP_NO_LINK);

[Low]
Could the comment here be expanded to record which modes are
unsupported and why?  PTP is silently disabled below 100 Mbps and for
any half-duplex configuration, but the predicate has no reference to a
datasheet section, errata, or test result, so a future maintainer adding
a new link speed cannot validate or update it.

>  			aq_ptp_tm_offset_set(self,
>  					     self->aq_hw->aq_link_status.mbps);
>  			aq_ptp_link_change(self);

[ ... ]

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> index 7486a28d7ff8..3ebd5e66ca2d 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c

[ ... ]

> +static int aq_ptp_add_a2_filter(struct aq_ptp_s *aq_ptp,
> +				struct ethtool_rx_flow_spec *fsp,
> +				int *flt_idx)
> +{
> +	struct aq_nic_s *aq_nic = aq_ptp->aq_nic;
> +	int err;
> +
> +	err = aq_set_data_fl3l4(fsp,
> +				&aq_ptp->udp_filter[*flt_idx],
> +				aq_ptp->udp_filter[*flt_idx].location,
> +				true);
> +	if (!err) {
> +		netdev_dbg(aq_nic->ndev,
> +			   "PTP MC filter prepared. Loc: %x\n",
> +			   aq_ptp->udp_filter[*flt_idx].location);
> +		(*flt_idx)++;
> +	}
> +	return err;
> +}

[Low]
Can aq_set_data_fl3l4() ever return non-zero?  Looking at its body it
has only one return statement at the end returning 0, which means the
caller's "UDPv4/UDPv6 filter prepare failed" debug paths and the
flt_idx++ guard here are unreachable.  Was the helper expected to
validate input (e.g., bad ring_cookie or oversized fields) and reject
it?

> +
> +static int aq_ptp_dpath_enable(struct aq_ptp_s *aq_ptp,
> +			       int enable_flags, u16 rx_queue)
> +{

[ ... ]

> +	if (enable_flags) {
> +		/* Clear all existing L4 filters before applying new config */
> +		for (i = 0; i < PTP_UDP_FILTERS_CNT; i++) {
> +			aq_ptp->udp_filter[i].cmd &=
> +				~HW_ATL_RX_ENABLE_FLTR_L3L4;
> +			if (hw_ops->hw_filter_l3l4_set) {
> +				err = hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> +						&aq_ptp->udp_filter[i]);
> +				if (err)
> +					netdev_dbg(aq_nic->ndev,
> +						   "Set UDP filter failed\n");
> +			}
> +		}

[Medium]
Can this loop hide partial failures?  err is overwritten by every
iteration, so if filter[0] or filter[1] fail to clear but filter[3]
succeeds, err is reset to 0 by the last call and the function continues
on to program new filters on top of a partially-stale slot table with
no signal to the caller.

[ ... ]

> +	} else {
> +		/* PTP disabled, clear all UDP/L2 filters */
> +		for (i = 0; i < PTP_UDP_FILTERS_CNT; i++) {
> +			aq_ptp->udp_filter[i].cmd &=
> +				~HW_ATL_RX_ENABLE_FLTR_L3L4;
> +			if (hw_ops->hw_filter_l3l4_set) {
> +				err = hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> +						&aq_ptp->udp_filter[i]);
> +				if (err)
> +					netdev_dbg(aq_nic->ndev,
> +						   "Set UDP filter failed\n");
> +			}
> +		}
> +
> +		if (!err && hw_ops->hw_filter_l2_clear)
> +			err = hw_ops->hw_filter_l2_clear(aq_nic->aq_hw,
> +						&aq_ptp->eth_type_filter);
> +	}
> +
> +	return err;
> +}

[Medium]
Same pattern repeats here on the disable path: an early failing slot is
masked by a later successful one, so the function can return success
while leaving the L3/L4 slot table partially programmed.

[ ... ]

>  int aq_ptp_hwtstamp_config_set(struct aq_ptp_s *aq_ptp,
>  			       struct kernel_hwtstamp_config *config)
>  {
> +	unsigned int ptp_en_flags = aq_ptp_parse_rx_filters(config->rx_filter);
>  	struct aq_nic_s *aq_nic = aq_ptp->aq_nic;
> -	const struct aq_hw_ops *hw_ops;
>  	int err = 0;
>  
> -	hw_ops = aq_nic->aq_hw_ops;
> -	if (config->tx_type == HWTSTAMP_TX_ON ||
> -	    config->rx_filter == HWTSTAMP_FILTER_PTP_V2_EVENT) {
> -		aq_ptp_prepare_filters(aq_ptp);
> -		if (hw_ops->hw_filter_l3l4_set) {
> -			err = hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> -							 &aq_ptp->udp_filter);
> -		}
> -		if (!err && hw_ops->hw_filter_l2_set) {
> -			err = hw_ops->hw_filter_l2_set(aq_nic->aq_hw,
> -						       &aq_ptp->eth_type_filter);
> -		}
> +	if (aq_ptp->hwtstamp_config.rx_filter != config->rx_filter) {
> +		mutex_lock(&aq_ptp->ptp_filter_lock);
> +		err = aq_ptp_dpath_enable(aq_ptp,
> +					  ptp_en_flags,
> +					  aq_ptp->ptp_rx.idx);
> +		if (!err)
> +			aq_ptp->hwtstamp_config = *config;
> +		mutex_unlock(&aq_ptp->ptp_filter_lock);
> +	}
> +
> +	if (ptp_en_flags != AQ_HW_PTP_DISABLE)
>  		aq_utils_obj_set(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
> -	} else {
> -		aq_ptp->udp_filter.cmd &= ~HW_ATL_RX_ENABLE_FLTR_L3L4;
> -		if (hw_ops->hw_filter_l3l4_set) {
> -			err = hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> -							 &aq_ptp->udp_filter);
> -		}
> -		if (!err && hw_ops->hw_filter_l2_clear) {
> -			err = hw_ops->hw_filter_l2_clear(aq_nic->aq_hw,
> -							&aq_ptp->eth_type_filter);
> -		}
> +	else
>  		aq_utils_obj_clear(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
> -	}
>  
>  	if (err)
>  		return -EREMOTEIO;
>  
> -	aq_ptp->hwtstamp_config = *config;
> -
>  	return 0;
>  }

[High]
Can changes to tx_type now be silently lost?  The pre-patch code
unconditionally cached the new config on success.  The new code only
writes aq_ptp->hwtstamp_config when rx_filter changed:

    if (aq_ptp->hwtstamp_config.rx_filter != config->rx_filter) {
        ...
        if (!err)
            aq_ptp->hwtstamp_config = *config;
        ...
    }

A user calling SIOCSHWTSTAMP with the same rx_filter but a different
tx_type (for example flipping HWTSTAMP_TX_ON) gets a return of 0, but
the new tx_type is never stored, so a follow-up SIOCGHWTSTAMP returns
the stale prior value.

[High]
Does TX-only HW timestamping still work after this change?  Previously
"tx_type == HWTSTAMP_TX_ON" alone was enough to install filters and
assert AQ_NIC_PTP_DPATH_UP.  After the patch, AQ_NIC_PTP_DPATH_UP is
driven solely by aq_ptp_parse_rx_filters(config->rx_filter), so a
request with rx_filter=NONE and tx_type=ON no longer raises that flag.

aq_ndev_start_xmit() in aq_main.c gates its PTP TX redirection on
AQ_NIC_PTP_DPATH_UP, so PTP TX frames are no longer diverted to the PTP
TX ring, and TX hardware timestamping silently breaks in TX-only mode.

[Medium]
Can the rx_filter compare race against itself?  The check

    if (aq_ptp->hwtstamp_config.rx_filter != config->rx_filter)

is performed without holding ptp_filter_lock, while the same field is
written under the lock further down in this function and read by
aq_ptp_clock_init() on the link-change path.

[Medium]
Is the AQ_NIC_PTP_DPATH_UP update safe outside the lock?  The
aq_utils_obj_set/clear calls run unconditionally based on the requested
ptp_en_flags, even when:

  - aq_ptp_dpath_enable() was not invoked at all because rx_filter was
    unchanged, or
  - it was invoked but returned an error and hwtstamp_config was
    therefore not updated.

In the failure case the function still asserts AQ_NIC_PTP_DPATH_UP and
then returns -EREMOTEIO, so userspace is told the operation failed
while the global flag claims the datapath is up and steers transmits
to a PTP ring whose hardware setup may be inconsistent.

[ ... ]

> -void aq_ptp_clock_init(struct aq_nic_s *aq_nic)
> +void aq_ptp_clock_init(struct aq_nic_s *aq_nic, enum aq_ptp_state state)
>  {
>  	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
> -	struct timespec64 ts;
>  
> -	ktime_get_real_ts64(&ts);
> -	aq_ptp_settime(&aq_ptp->ptp_info, &ts);
> +	if (!aq_ptp)
> +		return;
> +
> +	if (aq_ptp->a1_ptp || state == AQ_PTP_FIRST_INIT) {
> +		struct timespec64 ts;
> +
> +		ktime_get_real_ts64(&ts);
> +		aq_ptp_settime(&aq_ptp->ptp_info, &ts);
> +	}
> +
> +	if (!aq_ptp->a1_ptp && state != AQ_PTP_FIRST_INIT) {
> +		unsigned int ptp_en_flags =
> +			aq_ptp_parse_rx_filters(state == AQ_PTP_LINK_UP ?
> +						aq_ptp->hwtstamp_config.rx_filter :
> +						HWTSTAMP_FILTER_NONE);
> +		mutex_lock(&aq_ptp->ptp_filter_lock);
> +		aq_ptp_dpath_enable(aq_ptp, ptp_en_flags, aq_ptp->ptp_rx.idx);
> +		mutex_unlock(&aq_ptp->ptp_filter_lock);
> +	}
>  }

[Medium]
Should the read of aq_ptp->hwtstamp_config.rx_filter happen inside
ptp_filter_lock?  The field is sampled here without holding the lock,
then the lock is acquired to call aq_ptp_dpath_enable() with the value
read.  The same field is mutated under the lock by
aq_ptp_hwtstamp_config_set().

A concurrent SIOCSHWTSTAMP from userspace can race with the link-change
caller (process context: aq_nic_service_task or
aq_linkstate_threaded_isr): the link path reads the old rx_filter,
queues behind the writer for the lock, then applies the old filter set
to hardware after the writer just installed the new one.

The unlocked read is also a data race per the kernel memory model.

[Medium]
Is it intentional that the return value of aq_ptp_dpath_enable() is
discarded here?  The commit message says this path exists to "Re-apply
RX filters on link change (hardware state lost after reset)", so a
silent failure means PTP RX timestamping is silently broken across the
link change.

aq_ptp_hwtstamp_config_set() captures and propagates the same return
value, so the asymmetry looks like an oversight.

[ ... ]

> -int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
> +int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_ptp_vec)
>  {

[ ... ]

>  	aq_ptp->aq_nic = aq_nic;
>  	aq_ptp->a1_ptp = a1_ptp;
> +	aq_ptp->a2_ptp = a2_ptp;
>  
>  	spin_lock_init(&aq_ptp->ptp_lock);
>  	spin_lock_init(&aq_ptp->ptp_ring_lock);
> +	mutex_init(&aq_ptp->ptp_filter_lock);
>  
> +	aq_ptp_offset_init(aq_ptp, &mbox.info.ptp_offset);

[ ... ]

> -	aq_ptp->idx_vector = idx_vec;
> +	aq_ptp->idx_ptp_vector = idx_ptp_vec;
>  
>  	aq_nic->aq_ptp = aq_ptp;
>  
>  	/* enable ptp counter */
> +	aq_ptp->ptp_clock_sel = ATL_TSG_CLOCK_SEL_0;
>  	aq_utils_obj_set(&aq_nic->aq_hw->flags, AQ_HW_PTP_AVAILABLE);
> -	mutex_lock(&aq_nic->fwreq_mutex);
> -	aq_nic->aq_fw_ops->enable_ptp(aq_nic->aq_hw, 1);
> -	aq_ptp_clock_init(aq_nic);
> -	mutex_unlock(&aq_nic->fwreq_mutex);
> +	if (a1_ptp) {
> +		mutex_lock(&aq_nic->fwreq_mutex);
> +		aq_nic->aq_fw_ops->enable_ptp(aq_nic->aq_hw, 1);
> +		mutex_unlock(&aq_nic->fwreq_mutex);
> +	}
> +	if (a2_ptp)
> +		aq_nic->aq_hw_ops->enable_ptp(aq_nic->aq_hw, aq_ptp->ptp_clock_sel, 1);
>  
>  	INIT_DELAYED_WORK(&aq_ptp->poll_sync, &aq_ptp_poll_sync_work_cb);
>  	aq_ptp->eth_type_filter.location =
> -			aq_nic_reserve_filter(aq_nic, aq_rx_filter_ethertype);
> -	aq_ptp->udp_filter.location =
> +		aq_nic_reserve_filter(aq_nic, aq_rx_filter_ethertype);
> +
> +	for (i = 0; i < PTP_UDP_FILTERS_CNT; i++) {
> +		aq_ptp->udp_filter[i].location =
>  			aq_nic_reserve_filter(aq_nic, aq_rx_filter_l3l4);
> +	}
> +
> +	aq_ptp_clock_init(aq_nic, AQ_PTP_FIRST_INIT);

[Low]
Should the TSG clock be initialized with wall-clock time before it is
started?  On AQC113 the call sequence is:

    aq_nic->aq_hw_ops->enable_ptp(aq_nic->aq_hw, aq_ptp->ptp_clock_sel, 1);
    ...
    aq_ptp_clock_init(aq_nic, AQ_PTP_FIRST_INIT);

hw_atl2_enable_ptp(self, 0, 1) zeroes the TSG counter and starts it,
while aq_ptp_clock_init(AQ_PTP_FIRST_INIT) is the only path that calls
aq_ptp_settime() to load wall-clock time.  Between these two steps the
TSG clock is freely incrementing from zero with AQ_HW_PTP_AVAILABLE
already set and aq_nic->aq_ptp already published, so a concurrent
reader observes an enabled-but-uninitialized clock returning a near-
zero value.

[Medium]
On AQC107 (a1_ptp), only a single L3/L4 filter is ever programmed in
aq_ptp_dpath_enable() (the a1_ptp branch installs one UDPv4 filter and
increments flt_idx once), but this loop reserves PTP_UDP_FILTERS_CNT
== 4 slots on every chip:

    for (i = 0; i < PTP_UDP_FILTERS_CNT; i++) {
        aq_ptp->udp_filter[i].location =
            aq_nic_reserve_filter(aq_nic, aq_rx_filter_l3l4);
    }

The L3/L4 slot pool has eight entries
(AQ_RX_LAST_LOC_FL3L4 - AQ_RX_FIRST_LOC_FL3L4 + 1).  Reserving four
instead of one on AQC107 reduces user-visible ethtool ntuple ring-
cookie capacity from seven to four.  Could the reservation count be
gated on a2_ptp?

[Low]
Is the publication order of aq_nic->aq_ptp and AQ_HW_PTP_AVAILABLE
intentional?

    aq_nic->aq_ptp = aq_ptp;
    ...
    aq_utils_obj_set(&aq_nic->aq_hw->flags, AQ_HW_PTP_AVAILABLE);
    ...
    INIT_DELAYED_WORK(&aq_ptp->poll_sync, ...);
    aq_ptp->eth_type_filter.location = ...;
    for (i = 0; i < PTP_UDP_FILTERS_CNT; i++)
        aq_ptp->udp_filter[i].location = ...;

The pointer and the global flag are exposed several statements before
INIT_DELAYED_WORK and before filter slot reservations.  Any future
error-recovery rollback that calls aq_ptp_free() on a partially-
initialized aq_ptp will run cancel_delayed_work_sync() on an
uninitialized struct delayed_work.

>  
>  	return 0;
>  
> @@ -1244,30 +1533,45 @@ void aq_ptp_unregister(struct aq_nic_s *aq_nic)

[ ... ]

>  void aq_ptp_free(struct aq_nic_s *aq_nic)
>  {
>  	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
> +	int i;
>  
>  	if (!aq_ptp)
>  		return;

[ ... ]

>  	kfree(aq_ptp->ptp_info.pin_config);
> +	aq_ptp->ptp_info.pin_config = NULL;
>  
>  	netif_napi_del(&aq_ptp->napi);
>  	kfree(aq_ptp);
> +	aq_utils_obj_clear(&aq_nic->aq_hw->flags, AQ_HW_PTP_AVAILABLE);
>  	aq_nic->aq_ptp = NULL;
>  }

[Low]
A few small issues in this teardown:

  - kfree(aq_ptp) is called before aq_nic->aq_ptp = NULL, leaving
    aq_nic->aq_ptp dangling for the duration of the
    aq_utils_obj_clear() call between them.

  - mutex_destroy(&aq_ptp->ptp_filter_lock) is missing before kfree;
    CONFIG_DEBUG_MUTEXES would have caught this.

