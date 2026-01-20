Return-Path: <netdev+bounces-251590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJZ/Hh/fb2n8RwAAu9opvQ
	(envelope-from <netdev+bounces-251590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:01:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A02A4AF0E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C623192EECB
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A530B4418F9;
	Tue, 20 Jan 2026 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svJ/oT0U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F813E9F76
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935550; cv=none; b=NPwxMj/NSqlt/xWciaK+Q93CwXqvGYb1sVBgAjG0yl1U2JDQpxPcPtEj6Y4Ye3ZOT8lAKQarZYSJG10EIpfeWDyHlO/OZnaebjZKiWixbcE15ZTnBjs7Wbt1hEG762H2cdkkMvFPwG3hJTLxjNSDpn0tP7VRn++rEnWrg5qM1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935550; c=relaxed/simple;
	bh=sNF+4UH648u/wGI//NQ15yZFfgeJJkGIgaXk9Hs94i8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRiu0o66vRE1KlJ3QvPvPbj85oov35YRt08d/0EjUPyRjsBFurYYtp3R1xyp1YGhGogwYYWC76fsHkJZPZdR2/1JKZpx2ZJWHpoZdp4KJiol3Tw2wfMXdYs1ZXuMKy/MxXC9fkdkTXaFcXz9mHGd9pS6cc0Fl6kR7Lwhw4arGM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svJ/oT0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B82C16AAE;
	Tue, 20 Jan 2026 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768935550;
	bh=sNF+4UH648u/wGI//NQ15yZFfgeJJkGIgaXk9Hs94i8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=svJ/oT0U3+ZD2/Y5seL3yCHOvuOrIeBeSRd+lDLBDJJyd2Heq5xhFLGwv0I/mEbAJ
	 oDRVBVvzLsQsLzCgHQY6CpRE4+mvTrisyyhiIfbYAmxNQDD72YwRtuFG2HucmnOvyx
	 cPQSw9VldaNf+oHrIMOhliwXiSKTQ7N3jfOExnGkMWLjs9xITkR/ao6IPxnpzZDgv4
	 vkHqtwf09qxhn9uGbAFhs9NsOxVfEvyhvNeB4SAN5bfJf01u3lURjanP/EmL7COvkX
	 sFy3KJYuAeTwcae4v/NayZ6mT6D4dlBzEAOyDxkQIMnPymP9ZOlzsZ7/LQbuyYkZVL
	 2TLEpIQVXMQHQ==
Date: Tue, 20 Jan 2026 10:59:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Skorodumov <dskr99@gmail.com>
Cc: netdev@vger.kernel.org, Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Subject: Re: [PATCH net 0/3] ipvlan: Deduplicate ipv4/ipv6
 addr_validator_event code
Message-ID: <20260120105909.4e52de08@kernel.org>
In-Reply-To: <20260120161852.639238-1-skorodumov.dmitry@huawei.com>
References: <20260120161852.639238-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251590-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1A02A4AF0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 19:18:33 +0300 Dmitry Skorodumov wrote:
> This is a bit stylish patches: The code to handle ipv4 and ipv6
> address change are exactly the same. We don't need separate
> functions for them. Just look whether we are called
> with ipvlan_addr4_notifier_block or with ipvlan_addr6_notifier_block

[PATCH net] is for fixes, please use [PATCH net-next] for cleanups.
If these patches depend on your locking fix you'll need to wait
with reposting until the fix appears in net-next (Thu afternoon).
-- 
pw-bot: cr

