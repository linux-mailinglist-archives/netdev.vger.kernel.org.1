Return-Path: <netdev+bounces-305855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ccPKFCNmTmrZLwIAu9opvQ
	(envelope-from <netdev+bounces-305855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:00:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 078B3727B53
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:00:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YBNNycRn;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305855-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305855-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AB4F3114FFE
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D990F299937;
	Wed,  8 Jul 2026 14:36:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26115FA81
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 14:36:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521400; cv=none; b=khqRiPaiR/FU8NY6Y+goNhTKn3Of1D7ZT6k+bA4m5mWpGBdLDQf5n/hKwo5ILEfETbmc95KOfpxKOTMnCJ0GVwdaLiZcON0xtzbEGn+tLd+aJpPKBQLq6pInnbpGt8TVsSsGFTx3rV06c2zEPkmwC3fD/bXQVQLsh1D8TDEHY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521400; c=relaxed/simple;
	bh=e7CsZdXBNm4jSvihEswzJs+yRhoQ2Lnrx69XW2/Igd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ci51/sillfF2FpfhURmb9/wgWU/Yzf2V6KMsovjKlhC4OBX2Dyg3bWjg6sAfnWXUuYsGg+ImZsaBCROfQl4JfemQ1DrNS2ky4eNahAFkoLMovpmG3iXuYTLgSikgs7ER7rh4sPc0wPELhdY0KBQMBezgqux31HoVEc+oqgv2i6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBNNycRn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E16F1F00A3A;
	Wed,  8 Jul 2026 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783521399;
	bh=+sg0cd/dOtDSeooJg4oAtROLzWI4irmZPtRfZt3Xg10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YBNNycRn/HVArimdqvQVG4cesmyWfHBX8eimHeL+dpAPEbq1wd0Etn0ggTXixdepX
	 LakOxAH1a/MpcAynAKGAKGL7wofGaH5cyk/+RQ1BW7YRYZIIOCpRaE5rpzZBozdD9J
	 4WYfeWT3JIY00jASrSQLGOuk7ce3jcyYi++hT3tuHpOeQgffT8mixCleLJWzqtxK4x
	 iQD33PxJtLJRCBcigs/Fvd+FonAACgGKhQgSvHAswQrz7Bpa3g02MQb/jNTqkQ1Izi
	 6DGRyEZqZzW87Q6t2A2XzB0ugroPFEMl/fLT7n1JddWKhSrYDLtohNbJKl19h8AXQj
	 Qz0ELMY7WW3eg==
From: Simon Horman <horms@kernel.org>
To: mheib@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH iwl-next v2 1/2] i40e: move ATR sample rate from ring to PF level
Date: Wed,  8 Jul 2026 15:36:01 +0100
Message-ID: <20260708143601.1491656-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701093830.948756-1-mheib@redhat.com>
References: <20260701093830.948756-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305855-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mheib@redhat.com,m:horms@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corbet@lwn.net,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 078B3727B53

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
i40e: move ATR sample rate from ring to PF level

This commit moves the ATR sample rate configuration from the per-ring level
to the PF level. It initializes the sample rate globally during software init
and updates the fast path to reference the PF structure.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index a04683004a567..4d4d4b07a0f3a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
[ ... ]
> @@ -3454,12 +3454,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
>  		ring->xsk_pool = i40e_xsk_pool(ring);
>  
>  	/* some ATR related tx ring init */
> -	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
> -		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
> -		ring->atr_count = 0;
> -	} else {
> -		ring->atr_sample_rate = 0;
> -	}
> +	ring->atr_count = 0;

[Severity: High]
Does removing this per-ring initialization remove the protection against
dynamic ethtool flag toggles?

Previously, if the ring was configured while Flow Director ATR was disabled,
the ring's sample rate was cached to 0 in i40e_configure_tx_ring(). This
prevented descriptor injection even if the PF flag was later toggled on
without a ring reset.

[ ... ]
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 894f2d06d39d0..b36e0fc9b31d2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
[ ... ]
> @@ -2879,7 +2879,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
>  		return;
>  
>  	/* if sampling is disabled do nothing */
> -	if (!tx_ring->atr_sample_rate)
> +	if (!pf->atr_sample_rate)
>  		return;

[Severity: High]
Can this global check lead to a hardware Malicious Driver Detection (MDD)
event if ethtool flags are modified dynamically?

If an administrator performs the following sequence:

1. Disables flow-director-atr via ethtool.
2. Disables ntuple (which resets the ring and sets tx_ctx.fd_ena = 0).
3. Re-enables flow-director-atr.

The final step does not trigger a ring reset, so fd_ena remains 0 in the
hardware queue context.

However, I40E_FLAG_FD_ATR_ENA is now true, and pf->atr_sample_rate is
globally set to a non-zero value.

Will i40e_atr() now proceed and inject FDIR descriptors into a TX queue
that is not configured for FDIR?

If so, does this cause the hardware to trigger an MDD event and hang the
TX queue?

