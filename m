Return-Path: <netdev+bounces-282571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPWnKKqq8mm8tQEAu9opvQ
	(envelope-from <netdev+bounces-282571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:04:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF9849BE9D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6729301F4B6
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EF7223336;
	Thu, 30 Apr 2026 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2VPMHjQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86921A9FA4;
	Thu, 30 Apr 2026 01:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777511006; cv=none; b=sQpTRvetCr8vcrCmJtjDmIihiPZOFDnIc+1aKA+aaG7IkHMZz3aIPiJZcd0jRqVJoyAHCDLj3sMzwyOvWhz513oao37C4WQocSIa0vfFyeDJv4X1X8c/xpLrgEgWd9QITVJ9lcDqPz7Et8TalMGxlp1BUQgKtcPYnEETDJugH58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777511006; c=relaxed/simple;
	bh=JbFNcbiAuQHSN10MkBynRl4jTPI/nckdEueAPnmUMHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VA0lz3hH8AF7jqNGjWMkGHp6oUZQGLdX1Azgnm4d2XgECrzUPVXDmUzXAP9RES3Zhmq7mqP/Pnz0r+yNia65Gs4wAonlAZryPbx5LBXR1WVG7JkkHoDeXL448odgAMn67aCKYoWcH5W1qjdB+x4bohiEV+hwYR4bRvS8/cJiUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2VPMHjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4FFC19425;
	Thu, 30 Apr 2026 01:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777511005;
	bh=JbFNcbiAuQHSN10MkBynRl4jTPI/nckdEueAPnmUMHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2VPMHjQmLfxGZMrISEvmPddqTLuus3rZWYlh9AfnWnfyR8yNAZUBLp+H4DplBuId
	 /eoJYWQ/aAdiEvFS5UVGIpIz+0bxSSrtfdlRRCQUNxTPtZHkHDY498ac7C10jkT4Mk
	 gQWQ/3eXFuc6hSCv0p+pfBl7aUtRNPRrs1IqJ3Amr+TGa/W2DjznvIERAm3IcFD/qA
	 gPUqfAfSeXw2JfmJYKt9b3iWmehWoorpx7pEUqbn7CNaM73wrqS1VsLsXMvtNXePJp
	 pTQE0ycJ6lgtOTNIZpsXRpl8yv869H5qhLnGxyx9FI7B+tDOHCYYCAPYKgSvfSq+Qc
	 /eF3rOh+MCNkw==
From: Jakub Kicinski <kuba@kernel.org>
To: j.raczynski@samsung.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH RESEND net-next] net/sun: Fix multiple typos in comments
Date: Wed, 29 Apr 2026 18:03:22 -0700
Message-ID: <20260430010322.2326574-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428101728.3537456-1-j.raczynski@samsung.com>
References: <20260428101728.3537456-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4CF9849BE9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282571-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/sun: Fix multiple typos in comments

This patch fixes various typos in comments across the sun ethernet
drivers. A couple of the replacements may warrant a second look.

> diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
> index fe00e7dd3fe4..74fb0de12d21 100644
> --- a/drivers/net/ethernet/sun/cassini.c
> +++ b/drivers/net/ethernet/sun/cassini.c

[ ... ]

> @@ -4547,7 +4547,7 @@ static int cas_get_link_ksettings(struct net_device *dev,
>  	}
>  	if (linkstate != link_up) {
>  		/* Force these to "unknown" if the link is not up and
> -		 * autonogotiation in enabled. We can set the link
> +		 * autonegotiation in enabled. We can set the link

The "autonogotiation" to "autonegotiation" change looks correct, but
the neighbouring "in enabled" in the same sentence appears to be a
leftover grammar slip (should it read "is enabled"?).  Since this
sentence is already being touched as part of the typo cleanup, would
it make sense to fix that at the same time?

>  		 * speed to 0, but not cmd->duplex,
>  		 * because its legal values are 0 and 1.  Ethtool will
>  		 * print the value reported in parentheses after the

[ ... ]

> diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
> index 4c9d5d4dd8a0..efbf042e9352 100644
> --- a/drivers/net/ethernet/sun/sunhme.c
> +++ b/drivers/net/ethernet/sun/sunhme.c
> @@ -1118,7 +1118,7 @@ static void happy_meal_transceiver_check(struct happy_meal *hp, void __iomem *tr
>   *
>   * We use skb_reserve() to align the data block we get in the skb.  We
>   * also program the etxregs->cfg register to use an offset of 2.  This
> - * imperical constant plus the ethernet header size will always leave
> + * emperical constant plus the ethernet header size will always leave

Neither "imperical" nor "emperical" is a correct English word; the
intended word is "empirical".  Was the replacement here meant to be
"empirical"?

>   * us with a nicely aligned ip header once we pass things up to the
>   * protocol layers.
>   *
-- 
pw-bot: cr

