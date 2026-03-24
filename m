Return-Path: <netdev+bounces-271190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D+AHJnDwmlflgQAu9opvQ
	(envelope-from <netdev+bounces-271190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:02:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0E4319963
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71ABC305375A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F0339EF14;
	Tue, 24 Mar 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKc66ACI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2793988E8;
	Tue, 24 Mar 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371519; cv=none; b=S9MLEbCLsr3nmUWxxfjNpxT2oKdDA3p9BaVySERFBWDX+jgmHojjFTqvppBcFN12TRytuF5CcTJV21XQItVyfEBe8ofQB/2v6cmqDwmJkxT5ApfKrJwylul0mlvYFM6wElz/fXAfH3Mw9285RXQcRV2DhAyPMlbY6jkzSj7sIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371519; c=relaxed/simple;
	bh=XTX3RY7lgLXPIuC8OIWPU6uF7FH2kNY+iILh8Aykr9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYLxYmv2pYTfV4gTOi2iM2F45h/TuyjBIuP2PH+cPBjyQah1kyAsFOJGnry/s2pZTlWV7SX7d9HdfIplh48OcIgpLp7xHr5uxIx8RVp3cif7qgRkVbJGxyPtb815Xb8jEu1awuGe4Gi0vuUKKcfUVmVQar8P8GCMqs8QXewufDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKc66ACI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F19EC19424;
	Tue, 24 Mar 2026 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774371519;
	bh=XTX3RY7lgLXPIuC8OIWPU6uF7FH2kNY+iILh8Aykr9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKc66ACIVg0DMObY7mYeEgbbYlwLWvGU2c2JLYflggsoa+sRKJ/wwQUy1JGBXocBC
	 AD4JqBTcSW0NwMq8szw8olUqMB43x3FpezZASqKUmSyDmHtBBCQ2iVpP6P/mVFzfdU
	 CTxAS3J+MYl7n3Ka7tbXRN/ehxVUjANMaGV/pVh3v0D7LhBIfxyF55ywOdI+0Q5NFm
	 Mc4fkj3s+oM3rMvggMKHFtHMZWB+KE6al6bh8Z1Ws3DDXAVBSm7pa2zJBs5uihcyaK
	 dxO83w/ddPbDzgZIGtZsarGjGDJQTX2mdDEY+aBAZIvBrXD6MIwcZ7+4OHMfa4DNmG
	 gVVOCNQ4PBv9A==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	frank.li@nxp.com,
	devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	kuba@kernel.org,
	claudiu.manoil@nxp.com,
	andrew@lunn.ch,
	krzk+dt@kernel.org,
	linux@armlinux.org.uk,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	f.fainelli@gmail.com,
	imx@lists.linux.dev,
	chleroy@kernel.org,
	netdev@vger.kernel.org,
	robh@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	xiaoning.wang@nxp.com,
	davem@davemloft.net
Subject: Re: [PATCH v2 net-next 08/14] net: enetc: add multiple command BD rings support
Date: Tue, 24 Mar 2026 16:58:04 +0000
Message-ID: <20260324165804.245011-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323060752.1157031-9-wei.fang@nxp.com>
References: <20260323060752.1157031-9-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271190-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[linux.dev:query timed out];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,vger.kernel.org,lunn.ch,lists.infradead.org,armlinux.org.uk,google.com,redhat.com,gmail.com,lists.linux.dev,lists.ozlabs.org,davemloft.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: EE0E4319963
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: enetc: add multiple command BD rings support

This patch adds support for multiple command BD rings to the NTMP driver.
The switch has two command BD rings, and netc_select_cbdr() is added to
select an appropriate ring when the current one is busy.

> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
> --- a/drivers/net/ethernet/freescale/enetc/ntmp.c
> +++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
> @@ -117,6 +117,25 @@ static void ntmp_clean_cbdr(struct netc_cbdr *cbdr)
>  	cbdr->next_to_clean = i;
>  }
>
> +static struct netc_cbdr *netc_select_cbdr(struct ntmp_user *user)
> +{
> +	int cpu, i;
> +
> +	for (i = 0; i < user->cbdr_num; i++) {
> +		if (spin_is_locked(&user->ring[i].ring_lock))
> +			continue;
> +
> +		return &user->ring[i];
> +	}

Frank Li raised a concern about the use of spin_is_locked() here. Is this
lockless check reliable across all architectures? spin_is_locked() behavior
varies across configurations - it can return false negatives on UP builds and
may not provide the ordering guarantees needed for lockless checks.

Would spin_trylock() be more appropriate here? Or if this racy check is
intentional and acceptable, should it be documented why the potential race is
safe in this context?

> +
> +	/* If all the command BDRs are busy now, we select
> +	 * one of them, but need to wait for a while to use.
> +	 */
> +	cpu = raw_smp_processor_id();
> +
> +	return &user->ring[cpu % user->cbdr_num];
> +}
> +
>  static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
>  {
>  	union netc_cbd *cur_cbd;
> @@ -125,10 +144,10 @@ static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
>  	u16 status;
>  	u32 val;
>
> -	/* Currently only i.MX95 ENETC is supported, and it only has one
> -	 * command BD ring
> -	 */
> -	cbdr = &user->ring[0];
> +	if (user->cbdr_num == 1)
> +		cbdr = &user->ring[0];
> +	else
> +		cbdr = netc_select_cbdr(user);

This isn't a bug, but Frank Li suggested that the special case for
cbdr_num == 1 might be redundant. Since netc_select_cbdr() would handle the
single ring case correctly (the loop would find the only ring on the first
iteration), would it be simpler to just unconditionally call:

    cbdr = netc_select_cbdr(user);

>
>  	spin_lock_bh(&cbdr->ring_lock);
>

