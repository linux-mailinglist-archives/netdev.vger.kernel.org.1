Return-Path: <netdev+bounces-267845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCGHKvy8tWlD4QAAu9opvQ
	(envelope-from <netdev+bounces-267845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:54:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8A728EB03
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF09D30060BB
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70221346E5D;
	Sat, 14 Mar 2026 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXOpG0pa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD701A2545;
	Sat, 14 Mar 2026 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773518070; cv=none; b=r/zsM2/zkwUMGhTljKU6hMAmd53VNy9yYq+oDDewiZrFFFt5mjOCJlge6c820+tHu6DCYhwbaY6zzUopj/pkZe0vsdY4acebYdqIY8DoPXbFSsfCUtqN1rYkIA85kpscjX1uYcbmXo7/Y8itoUstCt2yWNcnXlnatyDxcTKNVLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773518070; c=relaxed/simple;
	bh=bJuGitTBA6p6rQY56Y79glcnOKva1Edg3uB876JYbo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh0HKd48PtwBO4ZRzRIuFn+hZC8oYRmwgMBdCGiBJQMupg7DXCeB4FmlYyCVTaWss6I+vzca1JWZnFv8NfVLhZHslJbWtq74vqSv60uupaniTw+Fmib+mZSvcoICVIqhOOSb/bCI4LekFRN00G0mxURJ0RTlU2HLw8gwqUGgfAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXOpG0pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B40C116C6;
	Sat, 14 Mar 2026 19:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773518069;
	bh=bJuGitTBA6p6rQY56Y79glcnOKva1Edg3uB876JYbo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXOpG0paxGYARHEzxEVC/LBjfeV0FO3VeDg6NdKuRawWE1FyY6cKVnR8eqMT8VdJr
	 yFdcODMNeO+/In3O8+7r+m3CpAVt02Rt1/DoPSkpZEgCtanTT2Rk3tyGR0HOxMHkLZ
	 Byb4BfGPMG8IC+aYxKDxpP/3T0h9KvrMm7DEa0xpsYP5GfdV0/vzhfIiC7bLnAwk0p
	 bWEFUVBXLQXqcDNCBt4BRrmQSLSpnggcltihc9ly0OWGzMbFGVOteJLolJfE/XR5AA
	 vgmurXGKJdc5YZWelA9yp3eUDeWHrmi0ingYZjQjIr/n7rvJa9L0UQAxrNozmGLAsq
	 XeZZNTwn+FnlA==
From: Jakub Kicinski <kuba@kernel.org>
To: ivecera@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	mschmidt@redhat.com,
	linux-kernel@vger.kernel.org,
	Prathosh.Satish@microchip.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	poros@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [net-next,5/6] dpll: zl3073x: add reference priority to zl3073x_chan
Date: Sat, 14 Mar 2026 12:53:59 -0700
Message-ID: <20260314195358.2710968-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311190055.139006-6-ivecera@redhat.com>
References: <20260311190055.139006-6-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267845-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE8A728EB03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email says "Is this legit? Quite hard to follow the logic of this change :/"

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
dpll: zl3073x: add reference priority to zl3073x_chan

This commit caches the ZL_REG_DPLL_REF_PRIO registers in the zl3073x_chan
cfg group, adding a ref_prio[] array and inline helpers for accessing
priority values. It extends state_fetch and state_set with DPLL mailbox
operations to read and write these priority registers.

> diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
> index 10189c8a5ded..74d00cee624e 100644
> --- a/drivers/dpll/zl3073x/chan.c
> +++ b/drivers/dpll/zl3073x/chan.c

[ ... ]

> @@ -85,7 +102,9 @@ const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
>   * @chan: desired channel state
>   *
>   * Skips the HW write if the configuration is unchanged, and otherwise
> - * writes the mode_refsel register to hardware.
> + * writes only the changed registers to hardware. The mode_refsel register
> + * is written directly, while the reference priority registers are written
> + * via the DPLL mailbox interface.
>   *
>   * Return: 0 on success, <0 on HW error
>   */
> @@ -93,14 +112,48 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
>  			   const struct zl3073x_chan *chan)
>  {
>  	struct zl3073x_chan *dchan = &zldev->chan[index];
> -	int rc;
> +	int rc, i;
>
>  	/* Skip HW write if configuration hasn't changed */
>  	if (!memcmp(&dchan->cfg, &chan->cfg, sizeof(chan->cfg)))
>  		return 0;
>
> -	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
> -			      chan->mode_refsel);
> +	/* Direct register write for mode_refsel */
> +	if (dchan->mode_refsel != chan->mode_refsel) {
> +		rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
> +				      chan->mode_refsel);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	/* Mailbox write for ref_prio if changed */
> +	if (!memcmp(dchan->ref_prio, chan->ref_prio, sizeof(chan->ref_prio))) {
> +		dchan->cfg = chan->cfg;
> +		return 0;
> +	}
> +
> +	guard(mutex)(&zldev->multiop_lock);
> +
> +	/* Read DPLL configuration into mailbox */
> +	rc = zl3073x_mb_op(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_RD,
> +			   ZL_REG_DPLL_MB_MASK, BIT(index));
> +	if (rc)
> +		return rc;
> +
> +	/* Update changed ref_prio registers */
> +	for (i = 0; i < ARRAY_SIZE(chan->ref_prio); i++) {
> +		if (dchan->ref_prio[i] != chan->ref_prio[i]) {
> +			rc = zl3073x_write_u8(zldev,
> +					      ZL_REG_DPLL_REF_PRIO(i),
> +					      chan->ref_prio[i]);
> +			if (rc)
> +				return rc;
> +		}
> +	}
> +
> +	/* Commit DPLL configuration */
> +	rc = zl3073x_mb_op(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_WR,
> +			   ZL_REG_DPLL_MB_MASK, BIT(index));
>  	if (rc)
>  		return rc;
>

Could this function leave the cache and hardware out of sync?

When both mode_refsel and ref_prio have changed, the function writes
mode_refsel to hardware first. If the subsequent mailbox operation fails
(during the mailbox read, a ref_prio write, or the mailbox commit), the
function returns an error without executing 'dchan->cfg = chan->cfg'.

This leaves dchan->mode_refsel cached at the old value while the hardware
has the new value:

zl3073x_chan_state_set()
    dchan->mode_refsel != chan->mode_refsel is true
    zl3073x_write_u8(... mode_refsel) succeeds
        hardware now has new mode_refsel value
    zl3073x_mb_op(...READ...) fails
    return rc without updating dchan->cfg
        dchan->mode_refsel still has old value

Later calls that get state via zl3073x_chan_state_get() will see the stale
cached mode_refsel. If they try to set mode_refsel back to the old value,
the comparison 'dchan->mode_refsel != chan->mode_refsel' evaluates to false
(both match the old value), skipping the write, while hardware retains the
new value.

Before this patch, mode_refsel was written in a single atomic step with no
possibility of partial failure, so this desynchronization scenario couldn't
occur.

