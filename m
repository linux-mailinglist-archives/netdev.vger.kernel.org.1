Return-Path: <netdev+bounces-283454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFXBDG419mk5TAIAu9opvQ
	(envelope-from <netdev+bounces-283454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:33:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 323844B3140
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4C7030055E4
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F663876A1;
	Sat,  2 May 2026 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKkRYvVN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A038758F;
	Sat,  2 May 2026 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777743194; cv=none; b=Br1+A0pt3C+Kl1b1qYsnLrILfZIhcXiBgsEMcqDMwkFHN5jmlWBy9nlvuzPfT0ubml1KH0f4bvliU+UC6msMUFPCIqznjWSuHDzGF6negyftpHVm55vQsUNKB3267kwD+wXkpnULM8LGYWwoRRWiGhg2pEGYSIXMbOCq0QUCxIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777743194; c=relaxed/simple;
	bh=W5YQwY+NaEOTeucgKLvW84thEHUjrp0B5t7n8D+dVpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxmikWr6uvGIBz4ZsOwXLkbl3Kt/UqO57GbkhNlXv0EtFCXWd7JLus6MT+DNdkBMY2Sabe+Sz8wiisSSP1z7Yy/mzkMBpQsp1Ryx5scHqRhMnUHNuGuxyIlQFitP836LrtSuIsggbiHsqlSAu6Ge0b+s2SV7AaxRbU0XhegJNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKkRYvVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395ADC2BCC7;
	Sat,  2 May 2026 17:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777743194;
	bh=W5YQwY+NaEOTeucgKLvW84thEHUjrp0B5t7n8D+dVpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKkRYvVNJSnZJKkxuYjDY/9XCVLKWGLnF5R3qC4CTKWbUbmbTJ5c+yKLnfTjk29Uy
	 VoJU/KD1CcvXtQ6Mucf73EiHhzhD+pmZkipqptFzDsN0V07DhMulbR+OftXMaPvQMA
	 rCYkGxOrk1J8NfODLKr0LvlVml72lmvjMdzBxUp7AnnWTYYlf8luhG+wkrNHTVSwm2
	 fJNfjWzxHGfSli7/OU3VIv6e+4v1jvh9F+ZQ9LUkElCUMM3at7zTm26ga45/7HgHbQ
	 lMFpPpH//F3j1v+HvnXNp1CaIAbPTltFtikLxsVDbiRsypGlvMvZrsJrrQCH7dqUze
	 +gzxQ9EsQeE2g==
From: Jakub Kicinski <kuba@kernel.org>
To: grzegorz.nitka@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	ivecera@redhat.com,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	edumazet@google.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	donald.hunter@gmail.com,
	linux-kernel@vger.kernel.org,
	arkadiusz.kubalewski@intel.com,
	andrew+netdev@lunn.ch,
	intel-wired-lan@lists.osuosl.org,
	horms@kernel.org,
	Prathosh.Satish@microchip.com,
	anthony.l.nguyen@intel.com,
	pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [PATCH v7 net-next 5/8] ice: introduce TXC DPLL device and TX ref clock pin framework for E825
Date: Sat,  2 May 2026 10:33:11 -0700
Message-ID: <20260502173312.3849706-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430094238.987976-6-grzegorz.nitka@intel.com>
References: <20260430094238.987976-6-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 323844B3140
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,linux.dev,resnulli.us,google.com,intel.com,gmail.com,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-283454-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ice: introduce TXC DPLL device and TX ref clock pin framework for E825

This patch adds a new TXC DPLL device of DPLL_TYPE_GENERIC for E825
devices, together with a TXCLK pin type and two TX reference pins
(EXT_EREF0 and a fwnode-described SYNCE pin). Pin state callbacks and
TXC lock status are placeholders at this stage.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 62f75701d652..d839b50187ba 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c

[ ... ]

> @@ -3199,19 +3276,40 @@ static bool ice_dpll_is_fwnode_pin(struct ice_dpll_pin *pin)
>  	return !IS_ERR_OR_NULL(pin->fwnode);
>  }
>  
> +static bool ice_dpll_fwnode_eq(const struct fwnode_handle *a,
> +			       const struct fwnode_handle *b)
> +{
> +	return a && b && a == b;
> +}
> +
>  static void ice_dpll_pin_notify_work(struct work_struct *work)
>  {
>  	struct ice_dpll_pin_work *w = container_of(work,
>  						   struct ice_dpll_pin_work,
>  						   work);
>  	struct ice_dpll_pin *pin, *parent = w->pin;
> +	bool is_tx_synce_parent = false;
>  	struct ice_pf *pf = parent->pf;
> +	bool is_rclk_parent = false;
>  	int ret;
>  
>  	wait_for_completion(&pf->dplls.dpll_init);
>  	if (!test_bit(ICE_FLAG_DPLL, pf->flags))
>  		goto out; /* DPLL initialization failed */
>  
> +	/* Decide which parent we are handling, defensively checking FWNs */

[ ... ]

> +		} else if (is_tx_synce_parent) {
> +			/* Register TX-CLK SYNCE pin directly to TXC DPLL */
> +			pin = &pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX];
> +			ret = dpll_pin_register(pf->dplls.txc.dpll, pin->pin,
> +						&ice_dpll_txclk_ops, pin);
> +			if (ret) {
> +				dev_err(ice_pf_to_dev(pf),
> +					"TX SYNCE pin register failed: %pe\n",
> +					ERR_PTR(ret));
> +				goto drop_parent_ref;
> +			}
>  		}
>  		break;

[ ... ]

> @@ -3401,6 +3524,19 @@ ice_dpll_deinit_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
>  	destroy_workqueue(pf->dplls.wq);
>  }
>  
> +static int ice_dpll_deinit_txclk_pins(struct ice_pf *pf)
> +{
> +	struct ice_dpll_pin *synce_pin = &pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX];
> +	struct ice_dpll *dt = &pf->dplls.txc;
> +
> +	ice_dpll_unregister_pins(dt->dpll, pf->dplls.txclks,
> +				 &ice_dpll_txclk_ops,
> +				 ARRAY_SIZE(pf->dplls.txclks));
> +	ice_dpll_release_pins(&pf->dplls.txclks[E825_EXT_EREF_PIN_IDX], 1);
> +	ice_dpll_deinit_fwnode_pin(synce_pin);
> +	return 0;
> +}

Is there a teardown race between this function and a concurrent
ice_dpll_pin_notify_work() that is about to register the SYNCE pin on
the TXC DPLL?

The work's registration path runs:

	parent->pin = fwnode_dpll_pin_find(parent->fwnode,
					   &parent->tracker);
	...
	} else if (is_tx_synce_parent) {
		pin = &pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX];
		ret = dpll_pin_register(pf->dplls.txc.dpll, pin->pin,
					&ice_dpll_txclk_ops, pin);

while ice_dpll_deinit_txclk_pins() first scans pf->dplls.txclks[] with
ice_dpll_unregister_pins(), which skips any slot where pins[i].pin is
still NULL:

	for (i = 0; i < count; i++) {
		if (pins[i].hidden)
			continue;
		if (IS_ERR_OR_NULL(pins[i].pin))
			continue;
		dpll_pin_unregister(dpll, pins[i].pin, ops, &pins[i]);
	}

Only afterward does it call ice_dpll_deinit_fwnode_pin(synce_pin), which
unregisters the notifier and flushes pf->dplls.wq.

If an external fwnode DPLL provider emits a DPLL_PIN_CREATED for
clk_ref_synce between the two steps, can this sequence occur?

  deinit thread                    notifier work
  -------------                    -------------
  ice_dpll_unregister_pins(txclks)
     sees txclks[1].pin == NULL
     skips SYNCE slot
                                   parent->pin = fwnode_dpll_pin_find()
                                   dpll_pin_register(txc->dpll,
                                       pin->pin, &ops, pin)
                                     -> adds to txc->dpll->pin_refs
                                        and pin->dpll_refs
  ice_dpll_release_pins(EREF0, 1)
  ice_dpll_deinit_fwnode_pin(synce_pin)
     unregister_dpll_notifier()
     flush_workqueue()   /* no work pending */
     dpll_pin_put(synce_pin->pin, ...)

After this, dpll_pin_put() only drops the pin refcount; it does not call
dpll_pin_unregister(). So the TXC dpll's pin_refs still contains the
SYNCE entry when ice_dpll_deinit_dpll(pf, &pf->dplls.txc, false) later
runs dpll_device_unregister() and dpll_device_put(). Does this trip
WARN_ON_ONCE(!xa_empty(&dpll->pin_refs)) in __dpll_device_put() and then
free the dpll_device while pin->dpll_refs still references it, leaving a
use-after-free on any subsequent walk of pin->dpll_refs?

Would it be safer to call ice_dpll_deinit_fwnode_pin(synce_pin) first so
the notifier is torn down and pf->dplls.wq drained before txclks[] is
scanned, or to hold pf->dplls.lock across both the deinit scan and the
work's parent->pin = ...; dpll_pin_register(...) sequence?

A similar structural race exists for the rclk path via
dpll_pin_on_pin_register(), but this patch introduces a new instance on
the direct-on-TXC SYNCE registration. The ordering in
ice_dpll_deinit_txclk_pins() appears unchanged by later patches in the
series, so the same race seems to persist beyond this commit.

