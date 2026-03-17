Return-Path: <netdev+bounces-268420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uORxN7TNuGlfjgEAu9opvQ
	(envelope-from <netdev+bounces-268420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:42:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD302A34A1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27D043012A82
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908C330C37A;
	Tue, 17 Mar 2026 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1QAP4Bk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB23093DD;
	Tue, 17 Mar 2026 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773718959; cv=none; b=KLinjcTdo0nfp8kn8DRK1Fb+dwsqEs0YZgjcn7TzFpkcmYgUpO/HYbha07zAPyWQt8CV8oWVpZrPRt2r7aT0CYPgOO+vohJuOSNb0E3ShcLYNdMnFKexrPiufrsXlQRajg8mIAi4/qNuqfxuqQ8Gu6LiQxf6GwZoYBpQPvCgEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773718959; c=relaxed/simple;
	bh=rVtlUnIE/I9+LBGM7c6x3GSDJbwpRv2KUWn1ZMlGJt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cF7XvWMnugownaB3zoQFBFCR5RNPWSVBa+N7tRQSJ4uXZrq+p5qpOY2FIBbb+nRtgxP/brG4X+Mm4VjdRarS2yE9WW+7+d4pzMHZrS3iW3XaowRELg+puS09pYxFK2DxUeQjp/q26Pie6X29k4L5OTGjD5TJof0CvByQFE1Kt2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1QAP4Bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF88C19421;
	Tue, 17 Mar 2026 03:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773718959;
	bh=rVtlUnIE/I9+LBGM7c6x3GSDJbwpRv2KUWn1ZMlGJt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q1QAP4BkEmdMfst44YchNEUCfZcImJPpYGzWIWlPeUeBIPKJx+C7f3jFUcxHNzOWj
	 ejvqmAF/NnQBomjzj7VUL7JkXgFsGXELF4rDENOazyuLo2i91jOwByV/08udIOCwDL
	 ygs6+6qpiwhngwRV7JjuX7p5YjYpVp7PsVMsjV2QYIzOs5/LLfCUvm7j+t0PixKXlV
	 PV14t4SMG4TlYwBwcNIZM7f5PdplpZpVPGCMzYrz9nP/vEPF4G/KZi6j032ZyhZ4o+
	 VBDrLi7YYguIGWOX1RIgtd3YfDSs/6kTKBoYYuJqOihOevWG3SfU2D4qzpwE1XxJ8b
	 Nz8WQIa7oN8nA==
Date: Mon, 16 Mar 2026 20:42:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: dpaa2-mac: export standard
 statistics
Message-ID: <20260316204238.6017858d@kernel.org>
In-Reply-To: <20260312142249.297192-4-ioana.ciornei@nxp.com>
References: <20260312142249.297192-1-ioana.ciornei@nxp.com>
	<20260312142249.297192-4-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268420-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBD302A34A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 16:22:49 +0200 Ioana Ciornei wrote:
> +	dpaa2_mac_get_standard_stats(mac, &mac->rmon_stats, DPAA2_MAC_NUM_RMON_STATS,
> +				     dpaa2_mac_rmon_stats, s);
> +
> +	*ranges = dpaa2_mac_rmon_ranges;
> +}
> +
> +void dpaa2_mac_get_pause_stats(struct dpaa2_mac *mac, struct ethtool_pause_stats *s)
> +{
> +	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
> +		return;
> +
> +	dpaa2_mac_get_standard_stats(mac, &mac->pause_stats, DPAA2_MAC_NUM_PAUSE_STATS,
> +				     dpaa2_mac_pause_stats, s);
> +}
> +
> +void dpaa2_mac_get_ctrl_stats(struct dpaa2_mac *mac, struct ethtool_eth_ctrl_stats *s)
> +{
> +	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
> +		return;
> +
> +	dpaa2_mac_get_standard_stats(mac, &mac->eth_ctrl_stats, DPAA2_MAC_NUM_ETH_CTRL_STATS,
> +				     dpaa2_mac_eth_ctrl_stats, s);
> +}
> +
> +void dpaa2_mac_get_eth_mac_stats(struct dpaa2_mac *mac, struct ethtool_eth_mac_stats *s)
> +{
> +	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
> +		return;
> +
> +	dpaa2_mac_get_standard_stats(mac, &mac->eth_mac_stats, DPAA2_MAC_NUM_ETH_MAC_STATS,
> +				     dpaa2_mac_eth_mac_stats, s);
> +}

these lines really want to be wrapped at 80

