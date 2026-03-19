Return-Path: <netdev+bounces-269583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE/rCOI4vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:56:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 869262D060C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF29F31BAC80
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8586F27A92E;
	Thu, 19 Mar 2026 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLzsGnyW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C7346E72;
	Thu, 19 Mar 2026 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942310; cv=none; b=Yjc6w/aHc0b8W6tOIWruJbgLUqJCgikvRz9HJq+6aLqcWv4leF+VWzij5B5dXLbKsLigOYwU0W7J+qJ8gwpczXDbZz2nb2QyfhydH5ooVvWfdogaQWMel6wlGsx1F3irag0YS1BlAaRiBAhLBF8YC8803ZZpVbhox2GDZMza6+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942310; c=relaxed/simple;
	bh=6CGzvuEPGSvPA+dPivezYFQso4zqZF1AmoyPvpSIKUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoQchQLOPiJL+Tw/l05v4OLl9rYBb1FD26zzbyNxQ13b2DvuQ0bAHJYwYM7n0UMvkXngpYBBiuBvXUSOR0Un9rKnw8xoLWaZy08WIASrkKs9AIkiI4Ql/8KDB5q8xlc1HEyJ8RFLTKheItNZnp4vVsR/x0H2dOMxIPjYfVtpo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLzsGnyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A374C19424;
	Thu, 19 Mar 2026 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773942309;
	bh=6CGzvuEPGSvPA+dPivezYFQso4zqZF1AmoyPvpSIKUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aLzsGnyWnfIxc0yii4POgMlCmyEmqsjjz5FNpgiHFKrD5PottLn2hCw7gRilC/wAg
	 J3nA5q4HyKWtYIdGsSronhYen6j8GdjtcFIN4Sh6bsNqQ4UGiRFJba0KwsYK/ybB/R
	 laluDYr7Y97QGZecW8uNAzneNoHcUGxOeWstN/5SHi9CrBnxz0QNXV3wr6EDGGNTbm
	 WV23wAu1L5jKlqDm7JFl30wOWFqD15cJSL7DyqHWuJmIH72UwsxH6yRwnIlZvlJaI8
	 IHb4g4Jp9l4C+4GsUPAkkZx3bBeiTEly3M5eNbgjNdZIE73zMWAohND94+GNYQrsOA
	 jhCoM5mcYibNA==
Date: Thu, 19 Mar 2026 17:45:03 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, poros@redhat.com,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com, ivecera@redhat.com, jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com, pabeni@redhat.com, kuba@kernel.org,
	davem@davemloft.net,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next 1/8] dpll: add new DPLL type for transmit clock
 (TXC) usage
Message-ID: <20260319174503.GO1753385@horms.kernel.org>
References: <20260318090654.611349-1-grzegorz.nitka@intel.com>
 <20260318090654.611349-2-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318090654.611349-2-grzegorz.nitka@intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269583-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.946];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 869262D060C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:06:47AM +0100, Grzegorz Nitka wrote:
> Extend the DPLL subsystem with a new DPLL type, DPLL_TYPE_TXC,
> representing devices that drive a transmit reference clock. Certain
> PHYs, MACs and SerDes blocks use a dedicated TX reference clock for
> link operation, and this clock domain is distinct from PPS- and
> EEC-driven synchronization sources. Defining a dedicated type allows
> user space and drivers to correctly classify and configure DPLLs
> intended for TX clock generation.
> 
> The corresponding netlink specification is updated to expose "txc"
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  Documentation/netlink/specs/dpll.yaml | 3 +++
>  include/uapi/linux/dpll.h             | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
> index 3dd48a32f783..2a2ee37a1fc0 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -138,6 +138,9 @@ definitions:
>        -
>          name: eec
>          doc: dpll drives the Ethernet Equipment Clock
> +      -
> +        name: txc
> +        doc: dpll drives Tx reference clock
>      render-max: true
>    -
>      type: enum
> diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
> index de0005f28e5c..a277d08ac264 100644
> --- a/include/uapi/linux/dpll.h
> +++ b/include/uapi/linux/dpll.h
> @@ -109,10 +109,12 @@ enum dpll_clock_quality_level {
>   * enum dpll_type - type of dpll, valid values for DPLL_A_TYPE attribute
>   * @DPLL_TYPE_PPS: dpll produces Pulse-Per-Second signal
>   * @DPLL_TYPE_EEC: dpll drives the Ethernet Equipment Clock
> + * @DPLL_TYPE_TXC: dpll drives Tx reference clock signal
>   */
>  enum dpll_type {
>  	DPLL_TYPE_PPS = 1,
>  	DPLL_TYPE_EEC,
> +	DPLL_TYPE_TXC,
>  
>  	/* private: */
>  	__DPLL_TYPE_MAX,

I think that the spec and source code changes are inconsistent in this
patch.

With it applied I see:

./tools/net/ynl/ynl-regen.sh -f && git diff
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index a2b22d492114..4182bdbb6dbb 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -34,7 +34,7 @@ const struct nla_policy dpll_reference_sync_nl_policy[DPLL_A_PIN_STATE + 1] = {
 static const struct nla_policy dpll_device_id_get_nl_policy[DPLL_A_TYPE + 1] = {
        [DPLL_A_MODULE_NAME] = { .type = NLA_NUL_STRING, },
        [DPLL_A_CLOCK_ID] = { .type = NLA_U64, },
-       [DPLL_A_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
+       [DPLL_A_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
 };

 /* DPLL_CMD_DEVICE_GET - do */
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index a277d08ac264..8f6db5d5bf0c 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -109,7 +109,7 @@ enum dpll_clock_quality_level {
  * enum dpll_type - type of dpll, valid values for DPLL_A_TYPE attribute
  * @DPLL_TYPE_PPS: dpll produces Pulse-Per-Second signal
  * @DPLL_TYPE_EEC: dpll drives the Ethernet Equipment Clock
- * @DPLL_TYPE_TXC: dpll drives Tx reference clock signal
+ * @DPLL_TYPE_TXC: dpll drives Tx reference clock
  */
 enum dpll_type {
        DPLL_TYPE_PPS = 1,

-- 
pw-bot: changes-requested

