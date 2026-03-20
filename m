Return-Path: <netdev+bounces-270042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGH3JAOevWmW/gIAu9opvQ
	(envelope-from <netdev+bounces-270042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:20:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E91212DFD85
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8DE530214F9
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11829337BB5;
	Fri, 20 Mar 2026 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ti0NtSVD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C418871F
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034433; cv=none; b=YjTk5Hdxc0VyThxVT9amdXImFfZhn+D+88Oljupj5b2+D9dABpmjYyh4mqJsk77DXp7X14DbR0VUhitR5Oc4VsPQTgag2zw0HHQJts91D+lQVQAr7czZEESXGP+npvN6NqnYnPVWECJ6NHJPQ/OWeQn6QuNNstG7DRvCCWWJtGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034433; c=relaxed/simple;
	bh=OhEVl68IJXW23s3giI06+FZaV7LwoTDtzK/9RZFAhsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaD49AecSep9w564dzHFtRuYSA2jnkNs1jlFQtrG5wUtel6HlLzVwJumdB5TXiG8yAdAx7LztQcMzLrnSCyzuaHtSDnouvu8kx+TMldb/DiVvCwCmW29VZU5CmVy8atV3aqdbxQtQaoEUwgXg1PgIlSlwWGMZ7Jw598B9/LW1Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ti0NtSVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313B4C4CEF7;
	Fri, 20 Mar 2026 19:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774034432;
	bh=OhEVl68IJXW23s3giI06+FZaV7LwoTDtzK/9RZFAhsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ti0NtSVDUyLBzfZ+62YK5zqAfPsUiJgWDPmFm6Bh3YGi4F55eWMokv+C4kcoIGY87
	 M3GCy5VgEVaGwYwScNb0F0N4Sx6H0GQJ44aCfgwAo/aWbjYGkgq32z4gjm+f6/DG4+
	 cP7gykXyWr7VPiKXyBor0vCrUBsgGEPsCNsnqsQnn89xIoUhsRAy+AUAB8pb+uzCNd
	 JuXSV81Kevn5NnyWgH434bbVgNllO0OwT8oyZUi6pgpbVF+uuAOK0Fov60PRmvHY/D
	 /M3iRZaryh3FIYmVD4IJvpV+grZoYyK+U5d5LShNB7soT9cjlkQhVXURLOqEramwgZ
	 1oQGfRpISOkzQ==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	paul.greenwalt@intel.com,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-next] ice: update ice_link_mode_str_high() with 200G
Date: Fri, 20 Mar 2026 19:19:04 +0000
Message-ID: <20260320191903.161126-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320050552.422715-1-aleksandr.loktionov@intel.com>
References: <20260320050552.422715-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270042-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.970];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E91212DFD85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: update ice_link_mode_str_high() with 200G

This patch adds string entries to ice_link_mode_str_high[] for 200G and
400GBASE-FR8 PHY types to fix ice_dump_phy_type() debug output for E825C
hardware.

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

Are entries [13], [14], and [15] missing their corresponding hardware
definitions?

The patch adds strings for indices 13-15, but ICE_PHY_TYPE_HIGH_MAX_INDEX
remains defined as 12 in ice_adminq_cmd.h (line 1047), and no
ICE_PHY_TYPE_HIGH_* bit definitions exist for these three types.

Other driver code uses MAX_INDEX as a bound:

drivers/net/ethernet/intel/ice/ice_common.c:ice_get_phy_type_high() {
    for (index = 0; index <= ICE_PHY_TYPE_HIGH_MAX_INDEX; index++)
        ...
}

This creates an inconsistency where ice_dump_phy_type() can print these
strings via debug output, but code checking PHY types based on MAX_INDEX
will not recognize indices 13-15.

If E825C hardware truly supports these PHY types, should this patch also
include the hardware definitions (ICE_PHY_TYPE_HIGH_200G_AUI8_AOC_ACC =
BIT_ULL(13), etc.) and update MAX_INDEX to 15?

