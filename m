Return-Path: <netdev+bounces-273208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AeHKHCGymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:19:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676EA35CB3D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 447FE307A32F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E7A3BED7B;
	Mon, 30 Mar 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6bspWjP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24233A1A5F
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879809; cv=none; b=EH4Ja12gppRFJxgX9bnyprARu78SvrvTeyR5v4nWOBScFIgPIirM2y5ckt3sfoOZoJz2FLWSYg2UhMgxv/jUtQu1SkCsbfZHNDmAE4iIqI7mKPTpKCeR207S6Gkn7dF0F4x7CDtd2Oqg29rVz6uqBSyrwBKW8pOL0fXFjKPtT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879809; c=relaxed/simple;
	bh=TKj9GNExlWWPaDPbWxwv57iLTnSKtKkez/z8ajsOgMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZD/Eo0my77adJw7CI0CzM0LHeYhvgHNt1dUA3nS95yBqs/PkQu+u0ALiRHv+CqWnLrprYLHprKRwJPcohk7epIeEV8ZCrDm5UHvq+p64VmIi3AV8cAC7tUNdfav1WUm922/xiBt19WyJLaKr2INHa9FnqSFkKAblQ+wvKYBRhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6bspWjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DE1C4CEF7;
	Mon, 30 Mar 2026 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774879809;
	bh=TKj9GNExlWWPaDPbWxwv57iLTnSKtKkez/z8ajsOgMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n6bspWjP0M59V+qvkDDcwNZ2eRYFOLeFHRA3NvkPTIh2dSjdXG8hwNjWV6+wqggwz
	 +TbquFopTvP7BwXRsDMpRNufnjZPXWLX5xQ1rhWzI8+qjVJUEPkfF7FiDm/nyAkPsl
	 sfXDkiFg+SfnHNi26+fcKzqNAw4lM78dpnjsvTo7lCgjtZ/qafyDA2ftpNcgwrhLk/
	 lGmlqPPHM+a7TOFWDts2LkjP9vU9K6PsM7B7oa4EjLfcjuygcp9gYkQ7kdQym2NZmQ
	 trubAWUho+mhkEKw1Sh4HWV63U+PPpmB8LA/wNtAgfMi5KTOpINKSq3yrWV+fMXcBl
	 V73OF04oxghmA==
Date: Mon, 30 Mar 2026 07:10:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net 0/5] net/sched: netem: bug fixes found during
 AI-assisted review
Message-ID: <20260330071008.3c6cf42f@kernel.org>
In-Reply-To: <20260328182336.392817-1-stephen@networkplumber.org>
References: <20260328182336.392817-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273208-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 676EA35CB3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 11:21:44 -0700 Stephen Hemminger wrote:
> These bugs were identified while using AI-assisted code review of
> sch_netem.c to analyze the packet duplication re-entrancy problem
> (CVE-2025-37890, CVE-2025-38001), which are addressed in a separate
> series.

TDC still failing after dropping the net-next series so I swapped
it for this one.

