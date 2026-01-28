Return-Path: <netdev+bounces-254074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKyIALp0eWkSxQEAu9opvQ
	(envelope-from <netdev+bounces-254074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:30:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE979C44C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF3283026599
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7264B29BD90;
	Wed, 28 Jan 2026 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVPne6+s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FACD29B781;
	Wed, 28 Jan 2026 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567366; cv=none; b=nuJod+Zax55cqi49Ftp5KbYkIgQxq2dJDzPhrNH+5rLddkh04fnntfSp9RJuNqQl0bWdUceyIE1VyefUtSMroESFQgzTVu04qcVJi7wjU5kuHZtNzshmAnXafObONcYOT0hjhYw9fKf2/fFmNOc2HREX+M/hdN3aLSYWevy13b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567366; c=relaxed/simple;
	bh=VUTA3Nhyp0Bo1yq2A9JQM8pU5flm+MGlo1MHsfQqxds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rfc/uas0qsPAPD2fvHsSmJXYV/POrRF1wi3AcKg8nc0IG473twTqMdtNwPpD+Twbzb0Edl0RWmrjFhDUjxcDJUKDUijvLDNxrsIGF7xgeyzdipGbnpHL8Tn5y40RKy76TRRt95lKyMDVgxTjcVFxW8tgz6wDdeDaq5Qj4U6w9Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVPne6+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E06C2BC87;
	Wed, 28 Jan 2026 02:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769567366;
	bh=VUTA3Nhyp0Bo1yq2A9JQM8pU5flm+MGlo1MHsfQqxds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVPne6+sqXsa2b4wcSL9woOcpl6sjSmuKtKp1hzt/+XTIAIMPsaPOdLun/Sq/MqbG
	 KgIaXEEjWzwbeE//vwHiRWF5enE7Oa3n339NWIuJ5dxqwcnLmg3GWt8Kk9VWyp+yAo
	 l8LvOaCbGo4zF9Xc7RqtsXkP6D4yjkiaI/cmDARmIdjcsajhoOG0ao+rZeXil0rCcb
	 q0e+G0oVYeh7vg+IGxHQr027OFxCyHApJqVX4aMrPX106q+Xos8e9sDcpghumycvd2
	 PNQQaxMdxD3iPdwkWNt5AxsPabycCdpqg85NjEdRutRSAv53M5Tjlpqtv2oo9EuUBw
	 C8sP2gPhyaCRA==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sbhatta@marvell.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	sgoutham@marvell.com,
	sumang@marvell.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v5,06/13] octeontx2-af: npc: cn20k: Use common APIs
Date: Tue, 27 Jan 2026 18:29:24 -0800
Message-ID: <20260128022924.4152852-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126123254.1000480-7-rkannoth@marvell.com>
References: <20260126123254.1000480-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254074-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 4BE979C44C
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Use common APIs

This patch updates the common NPC APIs to support both cn20k and previous
silicon variants by adding cn20k-specific register access and dispatching
to cn20k-specific routines for MCAM entry operations.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 246f3568a795..59988a54506a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c

[ ... ]

> @@ -2063,15 +2154,13 @@ static void rvu_npc_setup_interfaces(struct rvu *rvu, int blkaddr)
>  	struct npc_mcam *mcam = &rvu->hw->mcam;
>  	struct rvu_hwinfo *hw = rvu->hw;
>  	u64 nibble_ena, rx_kex, tx_kex;
> -	u64 *keyx_cfg;
> +	u64 *keyx_cfg, reg;
>  	u8 intf;
>
> -	if (is_cn20k(rvu->pdev)) {
> +	if (is_cn20k(rvu->pdev))
>  		keyx_cfg = mkex_extr->keyx_cfg;
> -		goto skip_miss_cntr;
> -	}
> -
> -	keyx_cfg = mkex->keyx_cfg;
> +	else
> +		keyx_cfg = mkex->keyx_cfg;
>
>  	/* Reserve last counter for MCAM RX miss action which is set to
>  	 * drop packet. This way we will know how many pkts didn't match
> @@ -2080,7 +2169,6 @@ static void rvu_npc_setup_interfaces(struct rvu *rvu, int blkaddr)
>  	mcam->counters.max--;
>  	mcam->rx_miss_act_cntr = mcam->counters.max;
                   ^^^^^^^^^^

Was the removal of "goto skip_miss_cntr" intentional for cn20k? Previously,
cn20k would skip the counter reservation here. Now cn20k reserves a counter
via mcam->counters.max-- but never programs NPC_AF_INTFX_MISS_STAT_ACT (due
to the "continue" later in the RX interface loop). This appears to waste
one counter on cn20k.

> -skip_miss_cntr:
>  	rx_kex = keyx_cfg[NIX_INTF_RX];
>  	tx_kex = keyx_cfg[NIX_INTF_TX];
>

