Return-Path: <netdev+bounces-271222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCKlLdPVwmllmgQAu9opvQ
	(envelope-from <netdev+bounces-271222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:20:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CDC31AA7E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2515C305260C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A300338C2BA;
	Tue, 24 Mar 2026 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeutO9Ei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED063783AC
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376043; cv=none; b=DhV1ghc/DLglNZ/7m0jpnSuGVhT4Sbs3o2+trQKiPDISretdlvwqrhx8eyaP0wab2igLxwYwPQGuGGakd5EFa+X/P67i57A4PaftnFOHODHSovBYgXJNiYUFVV+SWC6LccXy3wiLfz3g6BizTTl8SKt1MUu8kLm0FDr3/LHdr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376043; c=relaxed/simple;
	bh=IK2MYu+66ej+vDgIMcdiT/wi63TmFYueZ62knQD/j4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miHhO7C4geDA8P9aPyiYNw25aa/yL/7ILL97S6Fh0jjL+XXOqX8WlOrA7QT9W34iMGYneTvEActvRZT2cMfu8j96kCUntfMGSvez7NXBmHtIKGFkoF/MhLyPLQ7W5cBrKd8svVj1aKChvuk/o0qcNVhKfcLH9bqtlWsvHYKs1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeutO9Ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B672EC19424;
	Tue, 24 Mar 2026 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774376043;
	bh=IK2MYu+66ej+vDgIMcdiT/wi63TmFYueZ62knQD/j4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZeutO9EihSRBje8rAj9PU/NE0i0v3N/RXPzXM1zWSU1jY3irq9s0PTpZVdEgLVuoD
	 m8q7XP45UdWh1oOZf8Z/3LVzyFJ4LCuaYE1n4uuISQmwCYO/MWLDFCVOVqrDCXRHGV
	 LMKNkYgjuPTYCpUH5x8McVmmYZGzJIdGBYKLOELX4AMgckSkxfE/bLiNjk13pOlifJ
	 NQww8F0PiWMiUe5RoKYxfitxfgMYEcs7042/1DqKbkHXd2joCv6bbE27CaZYXKnKA/
	 dR2WKHIKQq4rBSuPT3k/yOEwFUjG4lR8tNCputAK4lYvi4xmCrpD0ENarqtbpsv2PN
	 cH1g58uYCXNdA==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	paul.greenwalt@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] ice: update ice_link_mode_str_high() with 200G
Date: Tue, 24 Mar 2026 18:13:37 +0000
Message-ID: <20260324181337.264904-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323085840.3272274-1-aleksandr.loktionov@intel.com>
References: <20260323085840.3272274-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271222-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 19CDC31AA7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: update ice_link_mode_str_high() with 200G

This patch updates ice_link_mode_str_high() to add strings for 200G PHY
types supported by E825C hardware. It also adds three new PHY type bit
definitions for indices 13-15 and increases ICE_PHY_TYPE_HIGH_MAX_INDEX
from 12 to 15.

> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 859e9c66f3e7..f64d2efdc478 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -1044,7 +1044,10 @@ struct ice_aqc_get_phy_caps {
>  #define ICE_PHY_TYPE_HIGH_200G_KR4_PAM4		BIT_ULL(10)
>  #define ICE_PHY_TYPE_HIGH_200G_AUI4_AOC_ACC	BIT_ULL(11)
>  #define ICE_PHY_TYPE_HIGH_200G_AUI4		BIT_ULL(12)
> -#define ICE_PHY_TYPE_HIGH_MAX_INDEX		12
> +#define ICE_PHY_TYPE_HIGH_200G_AUI8_AOC_ACC	BIT_ULL(13)
> +#define ICE_PHY_TYPE_HIGH_200G_AUI8		BIT_ULL(14)
> +#define ICE_PHY_TYPE_HIGH_400GBASE_FR8		BIT_ULL(15)
> +#define ICE_PHY_TYPE_HIGH_MAX_INDEX		15

The new PHY types added here (bits 13-15) will now be iterated by
ice_update_phy_type() when it loops from 0 to ICE_PHY_TYPE_HIGH_MAX_INDEX,
calling ice_get_link_speed_based_on_phy_type() for each index. However,
does ice_get_link_speed_based_on_phy_type() have cases for these three new
PHY types?

Looking at ice_get_link_speed_based_on_phy_type() in ice_common.c, the
switch statement has cases for 200G PHY types like ICE_PHY_TYPE_HIGH_200G_CR4_PAM4
through ICE_PHY_TYPE_HIGH_200G_AUI4 (indices 5-12) that return ICE_AQ_LINK_SPEED_200GB.

But the three newly added PHY types aren't present:
- ICE_PHY_TYPE_HIGH_200G_AUI8_AOC_ACC (bit 13)
- ICE_PHY_TYPE_HIGH_200G_AUI8 (bit 14)
- ICE_PHY_TYPE_HIGH_400GBASE_FR8 (bit 15)

Without these cases, won't they fall through to the default case and return
ICE_AQ_LINK_SPEED_UNKNOWN? The first two appear to be 200G types based on
their naming, so shouldn't they be added to the switch statement to return
ICE_AQ_LINK_SPEED_200GB?

For ICE_PHY_TYPE_HIGH_400GBASE_FR8, is there an ICE_AQ_LINK_SPEED_400GB
constant defined? Looking at ice_adminq_cmd.h, the link speed constants go
from ICE_AQ_LINK_SPEED_200GB (BIT(11)) directly to ICE_AQ_LINK_SPEED_UNKNOWN
(BIT(15)). Without an ICE_AQ_LINK_SPEED_400GB constant, how should the 400G
PHY type be mapped?

This appears to leave the new PHY types non-functional for speed
determination, even though the commit message states they are needed for
E825C hardware support.

>
>  struct ice_aqc_get_phy_caps_data {
>  	__le64 phy_type_low; /* Use values from ICE_PHY_TYPE_LOW_* */
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index ce11fea122d0..7cdd6a043d86 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -84,6 +84,17 @@ static const char * const ice_link_mode_str_high[] = {
>  	[2] = "100G_CAUI2",
>  	[3] = "100G_AUI2_AOC_ACC",
>  	[4] = "100G_AUI2",
> +	[5] = "200G_CR4_PAM4",
> +	[6] = "200G_SR4",
> +	[7] = "200G_FR4",
> +	[8] = "200G_LR4",
> +	[9] = "200G_DR4",
> +	[10] = "200G_KR4_PAM4",
> +	[11] = "200G_AUI4_AOC_ACC",
> +	[12] = "200G_AUI4",
> +	[13] = "200G_AUI8_AOC_ACC",
> +	[14] = "200G_AUI8",
> +	[15] = "400GBASE_FR8",
>  };
>
>  /**

