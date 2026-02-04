Return-Path: <netdev+bounces-256533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +5zyM1q6gmmYZQMAu9opvQ
	(envelope-from <netdev+bounces-256533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:17:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB9DE134D
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABD0D303C527
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F08289E06;
	Wed,  4 Feb 2026 03:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQP9sxCO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E01CAA78
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 03:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770175062; cv=none; b=FureKByQGigI7CHH45w1aQEVjEIeiOfniRgWQBHQDjD2kaSZApEeVj8COnvcJ+BLQkOCq0lryJtQzYDkz1Aqv+QIkEdLJab968fagc3xzSgBc7majPqf7+kTPheP2U7z94swaj1NRhgzkywbjF006h4BcRzXXAGJbnOJHrpaTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770175062; c=relaxed/simple;
	bh=l0F7Ms9ZqYA86BYadsP1gpUptbU4m0N3ul42adQfls0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwoUGPT3oEPR3v3U5a39vndH1G/nY0NJnMcLOT198ywn6OHTKWpf0zpCeXQtTKKmUNN4B4Msni3a7OYa0L4eSMYLtlF0Ac1jc/Z6ho+mGyd7QlepjPXDoHWwDvlYcPm9ZTAcCuQP+dtEJM4s7NPkKr0wVhEAmZ5yA0Xq8ByLqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQP9sxCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CACC116D0;
	Wed,  4 Feb 2026 03:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770175062;
	bh=l0F7Ms9ZqYA86BYadsP1gpUptbU4m0N3ul42adQfls0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pQP9sxCOyC6sPpYpzvSkqKilD+xQajqkXZ/QKu+xAEFoZQD98wulnTYuvfC+iy0DP
	 OFCYEIhs42OYuduzgRNymym6wmyrSxRwDicm+s7pWMi9+WlNi4lPWddwp4L+Lqo1i4
	 olbUoqB82aRY//JaYdEtGG6QqpL0uoPVveXGhVXVXeFRG/wZL7Z733HDoqvyj6qaj/
	 LeR5MhbYAWcIeRg038cGudjXagj5YJjO0yptBv0cNTS+tUfVx/rAHGzyXDJz5VXmBP
	 WHzmnkELt+2rGas4g1gX1n0juaUjeo7GNUQPtbok0p1qO07PRZfODeabC0uKi67xHS
	 axJi8G5RJaoqw==
Date: Tue, 3 Feb 2026 19:17:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: add vlan_get_protocol_offset_inline()
 helper
Message-ID: <20260203191740.2404d44c@kernel.org>
In-Reply-To: <20260202082200.650516-1-edumazet@google.com>
References: <20260202082200.650516-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256533-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DB9DE134D
X-Rspamd-Action: no action

On Mon,  2 Feb 2026 08:22:00 +0000 Eric Dumazet wrote:
> +struct type_depth {
> +	__be16 type;
> +	u16 depth;
> +};

Should we prefix the struct name with vlan_
Seeing type_depth made me think the function is returning some compiler
metadata :S Maybe it's just me.

