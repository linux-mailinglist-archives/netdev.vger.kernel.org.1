Return-Path: <netdev+bounces-269044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDddF8q3umlWawIAu9opvQ
	(envelope-from <netdev+bounces-269044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:33:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 450532BD34D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A22A03008D43
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8E73DB62B;
	Wed, 18 Mar 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM08xmyS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA63D9026;
	Wed, 18 Mar 2026 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844396; cv=none; b=a6cJo5J7+1Q6n6nhFoJqQHno6Z8mJWhLRLAmWDS6GzhHivUJPFajJMawOFoR40FJRLU02UFhvTuSRE6wtsJtnCf0hiN3XvuBMHoXPFfec91h1SizwoOBv9uR9oM9O1fj6pcesOJbn3RQebhR2EjnlDWgAFiWYP+OwN5a2TWH7oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844396; c=relaxed/simple;
	bh=zo3ppbbm5CmklykDDi884bR6RTstjwQ6rqH+FoHduP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxb3jAR5S4FNBXrL6oqrN9b1YcSzKN/ifp06HVnhZUUuEfi3CKiB2yeqre/pubBmFjsbP5fusm3sAOujHBpraByX4kzcNzwueNY9fGNyxUG/ItjtHSSWBiglNHNIEYK+SK0dVnGu8V2R9N5vMNCDK1OxwXDSgw/FndIP8ybNap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM08xmyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8659C19421;
	Wed, 18 Mar 2026 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844395;
	bh=zo3ppbbm5CmklykDDi884bR6RTstjwQ6rqH+FoHduP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM08xmySH7oe0eBpsBAOY5KZgan8agd14IQH9AEUXTTlIjc++KVnE27u4klJ7exp6
	 iSxgw0UgKZFjmuzvnq8pGmMnU7sYrV22yPxVZqvBP/3eOiQ06RkiiJZyTUVym12D/b
	 qwjnXVnEFP+UlccWeJHv6dkR0KHBEXOdBPF7bQkprBv4s90mV8byr4pK0FePE6/xct
	 ACvVieZuJk9YngFGZy29Ai+Rs6KXeQ24KjtsY9vxRSmhDTte1IrFeMyVgEZ6Ne8spX
	 DjMbphLvIZ5D8ccyW3UVFHq2BbcezXkg8bmVUrKe273ekwz08eS7h33zQwnKgq/Jej
	 ZMeh6QQOxhnFA==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	edumazet@google.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	imx@lists.linux.dev,
	f.fainelli@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux@armlinux.org.uk,
	linuxppc-dev@lists.ozlabs.org,
	xiaoning.wang@nxp.com,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	robh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org,
	kuba@kernel.org
Subject: Re: [net-next,08/14] net: enetc: add multiple command BD rings support
Date: Wed, 18 Mar 2026 14:32:01 +0000
Message-ID: <20260318143201.1888252-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316094152.1558671-9-wei.fang@nxp.com>
References: <20260316094152.1558671-9-wei.fang@nxp.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,google.com,lists.linux.dev,gmail.com,lunn.ch,davemloft.net,vger.kernel.org,armlinux.org.uk,lists.ozlabs.org,redhat.com,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-269044-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.938];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 450532BD34D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: enetc: add multiple command BD rings support

This commit adds support for multiple command BD rings in the NTMP
driver. When the NETC switch has multiple command BD rings and one is
busy, the driver can select an alternate ring to execute commands.

> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
> index 9fc3422137fc..e23a32946762 100644
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
> +
> +	/* If all the command BDRs are busy now, we select
> +	 * one of them, but need to wait for a while to use.
> +	 */
> +	cpu = smp_processor_id();
> +
> +	return &user->ring[cpu % user->cbdr_num];
> +}
> +

Can this trigger a preemption warning? netc_select_cbdr() is called from
netc_xmit_ntmp_cmd() before spin_lock_bh() is acquired, and the callers
(ntmp_maft_add_entry, ntmp_fdbt_add_entry, etc.) run in process context
with preemption enabled.

Using smp_processor_id() in preemptible code triggers a
"BUG: using smp_processor_id() in preemptible code" warning under
CONFIG_DEBUG_PREEMPT.

Since the CPU value here is only used as a hint for ring selection and not
for correctness, would raw_smp_processor_id() be more appropriate?

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
>
>  	spin_lock_bh(&cbdr->ring_lock);

