Return-Path: <netdev+bounces-259421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IuQJbzblmlJpgIAu9opvQ
	(envelope-from <netdev+bounces-259421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:45:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE16015D7B9
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9245C30659D5
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE475325488;
	Thu, 19 Feb 2026 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tybd3Tfz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE3BC8E6;
	Thu, 19 Feb 2026 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494197; cv=none; b=Fcp/cHV3TEeKoUdVUdcQ54+B8ib7fwGfwKEZVFezL0prGirLWzId5rMjS5RM+fabdspVgrjPADIhm0992BM/qwMXernubYjZD/s9haGe8aS++dZ5skUNKuDEEDU9D5VS8JKQPpw0C15317U/ZI9WAki99ddI5OMUJe6mepEWEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494197; c=relaxed/simple;
	bh=GjEiwksgH3xDHUGckHAT4l/tbka0q/6pPMY1uo6BDDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6lEl4nHl72ST/5itCN4ctv9w1BtupKi3Hld/NekngBp4rYBSYcyOa6xWY24j15KuYut/4lmTQ15GRlfRf7O4Z5px6rkVUG7XalnGJN/JAlIfqWaPG3n6TzBhupG6gnZKRJAcDRDGtg+oxoO7DfwR7WvsST9/TXDGCI7n+VqkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tybd3Tfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00EFC19421;
	Thu, 19 Feb 2026 09:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771494197;
	bh=GjEiwksgH3xDHUGckHAT4l/tbka0q/6pPMY1uo6BDDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tybd3Tfz+ei3J7wOvTXa/H2SkqRCm3giBP/c1muGe0ThngxK+p8Hk+Qig7GHmYBw9
	 hIppfPzdZ7ce6h0K2rl6647re61CIqXegHaIhUlZ8vwackWFZ558Nj1UJ5grPCQQSH
	 4UGJBF+oqMiAufFFxDEsj31C4BqnG1u0xXHC8g7nDsGHfeU2qQDsmJNzp5XYfLwx/c
	 9wx5SKydnekRiKxfnsH4OR7jCF/DP2qsBWfO6TXSoxHeuLjmvae+ub7U1PGeNEVTfP
	 DPcJKqxVak6P4J/i/0ZQG9+Qo29/vck6nV4KcCN4EVjSgCI+YKQ1YQUyXBy4VsETWg
	 YRb8IbLmmcyWg==
Date: Thu, 19 Feb 2026 09:43:12 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, ivecera@redhat.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: fix missing dpll notification for SW pins
Message-ID: <aZbbMGERNIYn68W4@horms.kernel.org>
References: <20260218211414.1411163-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218211414.1411163-1-poros@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259421-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE16015D7B9
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:14:14PM +0100, Petr Oros wrote:
> ice_dpll_notify_changes() sends dpll_pin_change_ntf() only for the
> direct CGU input pin stored in d->active_input. Software-controlled
> pins (SMA/U.FL) are separate dpll_pin objects that wrap a backing CGU
> input, but they never receive a change notification. As a result,
> userspace consumers such as synce4l that monitor SMA pins via dpll
> netlink never learn when the pin state transitions (e.g. from
> SELECTABLE to CONNECTED), even though 'dpll pin show' reports the
> correct state on demand.
> 
> When the active input changes, also send dpll_pin_change_ntf() for any
> registered SMA/U.FL input pin whose backing CGU input matches the old
> or new active input.
> 
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index c2ad39bfe177db..6f855fe4c78d62 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2470,13 +2470,17 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
>   */
>  static void ice_dpll_notify_changes(struct ice_dpll *d)
>  {
> +	struct ice_dplls *dplls = &d->pf->dplls;
>  	bool pin_notified = false;
> +	int i;
>  
>  	if (d->prev_dpll_state != d->dpll_state) {
>  		d->prev_dpll_state = d->dpll_state;
>  		dpll_device_change_ntf(d->dpll);
>  	}
>  	if (d->prev_input != d->active_input) {
> +		struct dpll_pin *old = d->prev_input;

nit: For consistency I think you can reduce the scope of i to this block.
     Or even declare it inside for().

> +
>  		if (d->prev_input)
>  			dpll_pin_change_ntf(d->prev_input);
>  		d->prev_input = d->active_input;
> @@ -2484,6 +2488,20 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
>  			dpll_pin_change_ntf(d->active_input);
>  			pin_notified = true;
>  		}
> +		for (i = 0; i < ICE_DPLL_PIN_SW_NUM; i++) {
> +			if (dplls->sma[i].pin &&
> +			    dplls->sma[i].direction ==
> +			    DPLL_PIN_DIRECTION_INPUT &&
> +			    (dplls->sma[i].input->pin == d->active_input ||
> +			     dplls->sma[i].input->pin == old))
> +				dpll_pin_change_ntf(dplls->sma[i].pin);
> +			if (dplls->ufl[i].pin &&
> +			    dplls->ufl[i].direction ==
> +			    DPLL_PIN_DIRECTION_INPUT &&
> +			    (dplls->ufl[i].input->pin == d->active_input ||
> +			     dplls->ufl[i].input->pin == old))
> +				dpll_pin_change_ntf(dplls->ufl[i].pin);

The condition above is pretty dense. And repeated.
I wonder if a helper would improve readability here.

> +		}
>  	}
>  	if (d->prev_phase_offset != d->phase_offset) {
>  		d->prev_phase_offset = d->phase_offset;
> -- 
> 2.52.0
> 

