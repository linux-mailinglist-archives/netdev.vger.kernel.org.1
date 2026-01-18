Return-Path: <netdev+bounces-250766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24610D391F2
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA2663029554
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63E21A2545;
	Sun, 18 Jan 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNHXXVHI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B68500972;
	Sun, 18 Jan 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696824; cv=none; b=PEPruSrqrThqTrcflGVdETkTGJRW+n8hJ6TfkN4h+oO0JW4DSut6zw68cdZKPRf1Gcms1sATZoBdZVxVs07oj9/4vA7EcLvz/YIw8B2P3bVk63oanqQZiC/aFQpjJpnRuXsnLJgv7dS0qfDG+We7NAplKexYkGCXUlKQxtp7aTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696824; c=relaxed/simple;
	bh=fBo0I3nk6trs1EcB9s0Z7h1kvRRIIrBVcSX7PXD0Jf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Te1DzvNFxKhCppz+nDKUTSSl2vHt8xmNitvVLlPyXDXE5LWpB8MAr2mGPwtMadvtC7EXJlETLRSIzbWPDs0BM/V/RtZlpf3vSBzT7ye/UU1xywuL9kGXLaNShx3bAUHb0j8evfpd0WVguYFGXwZEWqTNdT611pNC63NrXKwReII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNHXXVHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6875BC4CEF7;
	Sun, 18 Jan 2026 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768696824;
	bh=fBo0I3nk6trs1EcB9s0Z7h1kvRRIIrBVcSX7PXD0Jf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LNHXXVHIrpbFtQY/FMePIWeARo+jC1FG6sTxL2nPBSSSMNVUsX5ePim5N6D/I7rYr
	 UQBoX74Dww2zM9xPukhBhOjEJse0gJb9TZFrPzuVzcOrZ32UUYa/7cxhXUBaZ/oSqj
	 IWslUR7XqFBRTO4tRFyX0CeyzWddhoMzeeyeaB0udF4dzl5prRUwTEiM2mwLDDLdfd
	 iSbCLfXRDcGg/Aa0fEpd5XBfm1//JdqQoDCNEIbJqyPDoeVu/2PMeVbP3av/BXgttz
	 ADKi57VoGV9Du/LuXVliE57SXf6i+qksNj4N09i5uqJB/KTNOxgqszhKscwXp8iAO6
	 kQoPczXfR1IOw==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next,v4,04/13] ocetontx2-af: npc: cn20k: MKEX profile support
Date: Sat, 17 Jan 2026 16:40:20 -0800
Message-ID: <20260118004020.1044336-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113101658.4144610-5-rkannoth@marvell.com>
References: <20260113101658.4144610-5-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ocetontx2-af: npc: cn20k: MKEX profile support

This patch adds MKEX (MicroCode Key EXtraction) profile support for the
CN20K silicon variant, introducing a new parser profile with 24 extractors
per packet parsing profile instead of the previous two layer-data
information per key field type.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 0717fd66e8a1..c3f41f4ea99c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> +static u8 npc_map2cn20k_flag(u8 flag)
> +{
> +	switch (flag) {
> +	case NPC_F_LC_U_IP_FRAG:
> +		return NPC_CN20K_F_LC_L_IP_FRAG;
> +
> +	case NPC_F_LC_U_IP6_FRAG:
> +		return NPC_CN20K_F_LC_L_IP6_FRAG;
> +
> +	case NPC_F_LC_L_6TO4:
> +		return NPC_CN20K_F_LC_L_6TO4;
> +
> +	case NPC_F_LC_L_MPLS_IN_IP:
> +		return NPC_CN20K_F_LC_U_MPLS_IN_IP;
> +
> +	case NPC_F_LC_L_IP6_TUN_IP6:
> +		return NPC_CN20K_F_LC_U_IP6_TUN_IP6;
> +
> +	case NPC_F_LC_L_IP6_MPLS_IN_IP:
> +		return NPC_CN20K_F_LC_U_IP6_MPLS_IN_IP;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -1;
> +}

[ ... ]

> +int npc_cn20k_apply_custom_kpu(struct rvu *rvu,
> +			       struct npc_kpu_profile_adapter *profile)
> +{

[ ... ]

> +	for (kpu = 0; kpu < fw->kpus; kpu++) {
> +		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);

[ ... ]

> +		npc_cn20k_update_action_entries_n_flags(rvu, profile);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Is it intentional to call npc_cn20k_update_action_entries_n_flags() inside
the kpu loop? This function iterates through all kpus in the profile and
remaps flag values from the old enum to the CN20K enum. When called
multiple times, the mapping appears to be bidirectional:

  First call:  NPC_F_LC_L_MPLS_IN_IP (2) -> NPC_CN20K_F_LC_U_MPLS_IN_IP (0x20)
  Second call: 0x20 matches NPC_F_LC_U_IP_FRAG -> NPC_CN20K_F_LC_L_IP_FRAG (2)

The old and new enum values overlap (2,3,4 map to 0x20,0x40,0x80 and
vice-versa), so calling this function fw->kpus times will flip-flop the
flag values. If fw->kpus is even, the flags will have incorrect values
after the loop completes.

Should the call be moved outside the loop, or should there be a guard to
ensure it only runs once?

> +
> +		for (entry = 0; entry < entries; entry++) {
> +			profile->kpu[kpu].cam[entry] = cam[entry];
> +			profile->kpu[kpu].action[entry] = action[entry];
> +		}
> +	}
> +
> +	return 0;
> +}

