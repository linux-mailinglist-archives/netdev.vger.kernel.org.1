Return-Path: <netdev+bounces-269582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDoaKm02vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:46:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A77092D03B2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C86630015A0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE2D391831;
	Thu, 19 Mar 2026 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg3TL/Dy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65D38A719;
	Thu, 19 Mar 2026 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941876; cv=none; b=qmNNT1iMySVER6b618CtC0uATMExdpgumJoWuCDLyn/Cnvt1ewu0EaE2S5vsEk8p9hOIjzU4aZxXmRmwL5HKDq5vqC1Z1c2FfEMe9/MIR6AQbEO9qWNR/J2As44rtCap4A3auvPStfby2bnWDy+h8GcH43DUi0wTUWO/G4b9jW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941876; c=relaxed/simple;
	bh=UpJlN5QiJI2YcSqqnnHxI8WchZ3Wjht+c7y2Lbl/boA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1wdsrh8p7iL62eYdc5mB2HL4V1nYUP3i8NjuVwOqdSQAqwxmX3Uo9I6EP0cPaOczirBTsbObT5RZHpEEyyTA5ew89wDzXsdDMYw6o9qrOIoWX7XhRFS/NdKdI5SWKrbGfIs6JU+xu4DxljklPJ9SH6d9lZOwz6INW+7aqLNWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg3TL/Dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63A6C19424;
	Thu, 19 Mar 2026 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941875;
	bh=UpJlN5QiJI2YcSqqnnHxI8WchZ3Wjht+c7y2Lbl/boA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lg3TL/Dy1/XvD51t7OUfcJXnlrxtgNapvFF4OwpNH4QAHK5u5EGkL3dY4QyGxpBxB
	 gG5YQiXM3DLI0XiTciPWS5T7IiXNDj3HoIA9R3mNxU3ynUa+We/PSl7P6/D1wsI4AN
	 rsYbEEUTJ2FZHCwUYOkc+tqu56x5FPzj9hIe8j0Q1LwCo5PtsUSXzLN7cTQIvCS1LT
	 v3j4ZXkSzUsGdUfv735t8stkHzX4dYMlmxURIpxxmYfJC2d+OiFRCxHrIRGJVTk0Tm
	 nQbRN7UJP4RMW65BTnbG0DjvGi/IAEpu7AIuH158FkvpJyX/O1bV3TagEBbtEi+gL5
	 opn0c3/TWXd/g==
From: Simon Horman <horms@kernel.org>
To: grzegorz.nitka@intel.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	Prathosh.Satish@microchip.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	aleksandr.loktionov@intel.com,
	richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	anthony.l.nguyen@intel.com,
	ivecera@redhat.com,
	donald.hunter@gmail.com,
	intel-wired-lan@lists.osuosl.org,
	davem@davemloft.net,
	arkadiusz.kubalewski@intel.com,
	przemyslaw.kitszel@intel.com,
	poros@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/8] ice: add TX clock (TXC) DPLL interface for E825 devices
Date: Thu, 19 Mar 2026 17:37:34 +0000
Message-ID: <20260319173734.2004456-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318090654.611349-6-grzegorz.nitka@intel.com>
References: <20260318090654.611349-6-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,redhat.com,microchip.com,resnulli.us,intel.com,gmail.com,linux.dev,lists.osuosl.org,davemloft.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-269582-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.926];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: A77092D03B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: add TX clock (TXC) DPLL interface for E825 devices

This commit introduces a TX clock DPLL instance and pins for E825-based
devices. The TXC domain exposes two reference pins: EXT_EREF0 (board
external electrical reference) and SYNCE (port-derived reference,
described via fwnode). A new pin type and pin ops are added to support
TX clock references.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 62f75701d652..a1258f2e03a9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c

[ ... ]

> @@ -3552,6 +3686,39 @@ ice_dpll_init_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
>  	return ret;
>  }
>
> +static int ice_dpll_init_txclk_pins(struct ice_pf *pf, int start_idx)
> +{
> +	struct ice_dpll_pin *ref_pin = pf->dplls.txclks;
> +	struct ice_dpll *txc = &pf->dplls.txc;
> +	int ret = 0;
> +
> +	/* configure EXT_EREF0 pin */
> +	ret = ice_dpll_get_pins(pf, ref_pin, start_idx, 1, pf->dplls.clock_id);
> +	if (ret)
> +		return ret;
> +	ret = dpll_pin_register(txc->dpll, ref_pin->pin, &ice_dpll_txclk_ops,
> +				ref_pin);
> +	if (ret)
> +		return ret;
> +
> +	/* configure EXT_SYNCE pin which is based on fwnode pin */
> +	ref_pin++;
> +	ret = ice_dpll_init_fwnode_pin(ref_pin, ice_dpll_fwnode_ext_synce);
> +	if (ret)
> +		return ret;
> +
> +	ret = dpll_pin_register(txc->dpll, ref_pin->pin, &ice_dpll_txclk_ops,
> +				ref_pin);
> +	if (ret)
> +		return ret;

Does ice_dpll_init_txclk_pins leak the EXT_EREF0 pin on error?

If dpll_pin_register for the EXT_SYNCE pin fails, the function returns
the error without cleaning up the EXT_EREF0 pin that was already
successfully registered. Looking at the call chain:

ice_dpll_init_pins_e825() calls:
    ice_dpll_init_txclk_pins()
        ice_dpll_get_pins() -> acquires pin reference for EXT_EREF0
        dpll_pin_register() -> registers EXT_EREF0 with TXC DPLL
        ice_dpll_init_fwnode_pin() -> may fail here
        dpll_pin_register() -> or may fail here for EXT_SYNCE

If either of the last two steps fail, the function returns the error
directly without calling dpll_pin_unregister or ice_dpll_release_pins
for the EXT_EREF0 pin.

The caller ice_dpll_init_pins_e825() also doesn't compensate - on
txclk init failure it only calls ice_dpll_deinit_rclk_pin() and
ice_dpll_deinit_fwnode_pins(), neither of which clean up txclk
resources.

Compare with ice_dpll_init_fwnode_pins() and ice_dpll_get_pins() which
both have proper error-path rollback using goto labels.

> +
> +	if (IS_ERR_OR_NULL(ref_pin->pin))
> +		dev_dbg(ice_pf_to_dev(pf),
> +			"Tx-clk mux pin not registered yet\n");

Can this cause a NULL pointer dereference?

The IS_ERR_OR_NULL check appears after calling dpll_pin_register with
ref_pin->pin. Looking at the code flow:

ice_dpll_init_fwnode_pin() returns 0 (success) even when
fwnode_dpll_pin_find() returns NULL and sets ref_pin->pin = NULL. This
is the expected case - the commit message states "The SYNCE pin is
registered when its fwnode becomes available" and the code prints "DPLL
pin for %pfwp not registered yet".

However, the code unconditionally calls:

    dpll_pin_register(txc->dpll, ref_pin->pin, ...)

where ref_pin->pin is NULL. Looking at dpll_pin_register in
dpll_core.c:

    int dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin, ...)
    {
        ...
        ret = dpll_pin_fwnode_register(dpll, pin, &ice_dpll_txclk_ops, pin_priv);
        ...
    }

which then calls code that dereferences pin->fwnode without a NULL
check, causing a kernel oops.

The IS_ERR_OR_NULL guard at line 3716 was clearly intended to protect
the dpll_pin_register call but was placed after it instead of before it.

> +
> +	return 0;
> +}

[ ... ]

