Return-Path: <netdev+bounces-261872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFFHEy+zoWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:07:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FE41B96E5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D25F730C8649
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707E942B73E;
	Fri, 27 Feb 2026 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1lXGSng"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48636334C1F
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204350; cv=none; b=RZ+VXFLgCze55iS8jYKJ/hpxKip1Ln3/G1/zW8n9q9wT+JbS/ZVmuOaXYv/fCYT13yt0AYYt+6lLKLWhENJOtp1iXkIjPg+0rdoSByH8wZu9tNuc6uRfU/g2n3jxXzpM5lw0Z3UiVuL9IMnyelmS9S0WCBcAxF3Tq9g3mO/Z04U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204350; c=relaxed/simple;
	bh=Ze3Tlx1rfj2vQ6VRFOEvKX5Ou9wh4/kQWNcFUOsRXos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hv42qa5NwFDduZqR2K9Qc7Rft8zEec8TkaU91LKBMEBbWSbimqmNiRTjzkANrMBvsSt3+7b11S5Qgly72CoZze75QJSkOLHlNcQlxn0qGMmUhUCJ92p7eg7JuBMwDfH3wZJqh7ZAWtvwg7Lg0CyHw9SgDyeo1J9mTXHCCL70Y5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1lXGSng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7725EC116C6;
	Fri, 27 Feb 2026 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772204349;
	bh=Ze3Tlx1rfj2vQ6VRFOEvKX5Ou9wh4/kQWNcFUOsRXos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o1lXGSngusKW/YLNSoosQsLzyTCvdwtJCst/ahfLIkoxeS3nbf1FiVHHniCZyjJuR
	 IcJhkEZ5PJYLRg0jHdYdrIQ8rsOJJ05pEZn3tZIaWxAyuyuYrIntskHZp5a7QkKpQ2
	 1ewnvxkCqkaCtm1tsaxwgEUG6t0L26uwYhYzGVfZUcMccMgUYINXS9sGLmrykW5fsO
	 k/59YB9sRUNCvJNkE5dkz6aU9U0pMyhhJcdcaxPTENm9eGICPLMxyFtipnVY7qXYuQ
	 3MWkFmpzM42YAIEHe8a7orTyI2DEpcbW+EHxkA8jA3CiGdrtCXL+pPZQ+wPmCGo/6S
	 A257+DG5DkwhQ==
Date: Fri, 27 Feb 2026 06:59:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: <netdev@vger.kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v2 3/3] macsec: Support VLAN-filtering lower
 devices
Message-ID: <20260227065908.6dda892c@kernel.org>
In-Reply-To: <20260227090227.1552512-4-cratiu@nvidia.com>
References: <20260227090227.1552512-1-cratiu@nvidia.com>
	<20260227090227.1552512-4-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261872-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5FE41B96E5
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 11:02:27 +0200 Cosmin Ratiu wrote:
> VLAN-filtering is done through two netdev features
> (NETIF_F_HW_VLAN_CTAG_FILTER and NETIF_F_HW_VLAN_STAG_FILTER) and two
> netdev ops (ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid).
> 
> Implement these and advertise the features if the lower device supports
> them. This allows proper VLAN filtering to work on top of macsec
> devices, when the lower device is capable of VLAN filtering.
> As a concrete example, having this chain of interfaces now works:
> vlan_filtering_capable_dev(1) -> macsec_dev(2) -> macsec_vlan_dev(3)
> 
> Before commit [1] this used to accidentally work because the macsec
> device (and thus the lower device) was put in promiscuous mode and the
> VLAN filter was not used. But after commit [1] correctly made the macsec
> driver expose the IFF_UNICAST_FLT flag, promiscuous mode was no longer
> used and VLAN filters on dev 1 kicked in. Without support in dev 2 for
> propagating VLAN filters down, the register_vlan_dev -> vlan_vid_add ->
> __vlan_vid_add -> vlan_add_rx_filter_info call from dev 3 is silently
> eaten (because vlan_hw_filter_capable returns false and
> vlan_add_rx_filter_info silently succeeds).
> 
> For macsec, VLAN filters are only relevant for offload, otherwise
> the VLANs are encrypted and the lower devices don't care about them. So
> VLAN filters are only passed on to lower devices in offload mode.
> Flipping between offload modes now needs to offload/unoffload the
> filters with vlan_{get,drop}_rx_*_filter_info().

AI says:

This commit implements VLAN-filtering support for macsec devices by
adding ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid callbacks and
advertising the appropriate netdev features when the lower device
supports VLAN filtering.

> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index f6cad0746a02..73e0b75d9b69 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -2616,7 +2616,17 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
>  	if (!ops)
>  		return -EOPNOTSUPP;
>
> +	/* Remove VLAN filters when disabling offload. */
> +	if (offload == MACSEC_OFFLOAD_OFF) {
> +		vlan_drop_rx_ctag_filter_info(dev);
> +		vlan_drop_rx_stag_filter_info(dev);
> +	}
>  	macsec->offload = offload;
> +	/* Add VLAN filters when enabling offload. */
> +	if (prev_offload == MACSEC_OFFLOAD_OFF) {
> +		vlan_get_rx_ctag_filter_info(dev);
> +		vlan_get_rx_stag_filter_info(dev);
> +	}
>
>  	ctx.secy = &macsec->secy;
>  	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
> @@ -2633,6 +2643,11 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
>
>  	if (ret) {
>  		macsec->offload = prev_offload;
> +		if (offload == MACSEC_OFFLOAD_OFF && prev_offload == MACSEC_OFFLOAD_MAC) {
> +			vlan_get_rx_ctag_filter_info(dev);
> +			vlan_get_rx_stag_filter_info(dev);
> +		}
> +
>  		return ret;
>  	}

Does the error path properly restore VLAN filter state when enabling offload
fails? When prev_offload is MACSEC_OFFLOAD_OFF and the code calls
vlan_get_rx_ctag_filter_info(dev) and vlan_get_rx_stag_filter_info(dev) to
push VLAN filters to the lower device, but then macsec_offload() fails and
returns an error:

	ctx.secy = &macsec->secy;
	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
					    : macsec_offload(ops->mdo_add_secy, &ctx);
	if (ret)
		goto rollback;

	...

rollback:
	if (ret) {
		macsec->offload = prev_offload;
		return ret;
	}

The error path restores macsec->offload to prev_offload (MACSEC_OFFLOAD_OFF)
but doesn't call vlan_drop_rx_ctag_filter_info(dev) and
vlan_drop_rx_stag_filter_info(dev) to remove the VLAN filters that were
already pushed to the lower device. This leaves stale VLAN filter entries on
real_dev.

Since macsec->offload is now back to MACSEC_OFFLOAD_OFF, future calls to
macsec_vlan_rx_kill_vid will return early without removing these VIDs, so the
leaked state persists until the lower device is brought down.

[ ... ]



