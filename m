Return-Path: <netdev+bounces-288529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id totKNVDDB2qoHgMAu9opvQ
	(envelope-from <netdev+bounces-288529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:07:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB24559AB6
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB97E301AB8A
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A27A2236E8;
	Sat, 16 May 2026 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCpI3KF4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECC19D8A8
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893646; cv=none; b=Fg52YnUr57l5NCuHu5UkHsYld+Wc8P5zNDvIXpUfZfze+RSIdAXnN03RQ+tE+9lhkLdrtbF3M/LUObYw3xsurJEKuZiNBJwWtCB0Ni0HVDFGacuhD0J9RSZIdbu8Zf+OZWm3hR0dHAm4eBApnBYAKgN1gM4Xv9rXf4YtUnuJNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893646; c=relaxed/simple;
	bh=Rml405qsQ1dbSfa+bw/hAgsel/2EdmQOwMdNhZ9upR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlIdR+Wtyc0Ygu9X5/VOUi4nXCQLPwHVmEknCvllYWVGQmbD+7nx5nXOVVSIjUa8TkK6/6qvhnR4mMzyBSeLTbcesQUsEEbTl/Ux4Kjv1m0Y5KR5pYOsU1cdP4gTii6wY30+UbPxr5I+xH5MUIzrAKcRw5W3NGuQwPPxMR8nG+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCpI3KF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7376BC2BCB0;
	Sat, 16 May 2026 01:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893645;
	bh=Rml405qsQ1dbSfa+bw/hAgsel/2EdmQOwMdNhZ9upR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bCpI3KF4+QEnovYSrOBg1om+J2gITlE05BPAqUlmns4O07nBIQjroWlaJCYMkKj3t
	 9t5tUiZZKSjlW+EL1KRN9dsnt3B21GB2vojIIeeCFfY2ppM7KC/SHo1qGxz+HgJT1o
	 jNhZhsc+9j9X3x0hmLdt8F1JUqumoLUrE3ujErw31wK5VF7Nv68Jm3E5Y9QwLibKP3
	 TetqsbG6X7WWuk9WHKq9xmIiueOTKsDHFNhkfXfAb7iPO/D3xj6tfabZEqsqVvtyzp
	 GxwtOii98yJpLNpn31sl9uA8hc0EzRV4ExiWjwINU1Bftd4VSNgjQXsWgzJC9bDxbq
	 RIOFlu4tb3Esw==
Date: Fri, 15 May 2026 18:07:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next 3/3] net: libwx: support vf hardware statistics
Message-ID: <20260515180724.796b1ebc@kernel.org>
In-Reply-To: <20260514103405.42175-4-mengyuanlou@net-swift.com>
References: <20260514103405.42175-1-mengyuanlou@net-swift.com>
	<20260514103405.42175-4-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4CB24559AB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288529-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 14 May 2026 18:34:05 +0800 Mengyuan Lou wrote:
> +static const struct wx_stats wx_gstrings_stats_vf[] = {
> +	WX_STAT("tx_busy", tx_busy),
> +	WX_STAT("non_eop_descs", non_eop_descs),
> +	WX_STAT("rx_csum_offload_good_count", hw_csum_rx_good),
> +	WX_STAT("rx_csum_offload_errors", hw_csum_rx_error),
> +	WX_STAT("alloc_rx_buff_failed", alloc_rx_buff_failed),

Please use standard stats defined in include/net/netdev_queues.h

