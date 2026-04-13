Return-Path: <netdev+bounces-278036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFYXDHLL3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:54:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840F13EAF11
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31C8530031D0
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79635AC0A;
	Mon, 13 Apr 2026 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa9qG/Ft"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A03BD22C
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077551; cv=none; b=iYd4KlcdjoAst33YBnpxoRhGaTnt1bIIKdZYHjSK1xZG1OPo3fQkO5axvrYjXCZlbJX7LXhg54Zg3Axv8a/Rq4Hco51ZLimuNeFocwdXNI6YY9cYzBGGqSAVJPQceMGf6k7TPl+EBkjgRT/3TVN7G/q2Va05OhFQfB7GjhKunKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077551; c=relaxed/simple;
	bh=/59Z2nIxca4BWCGm41Q6Vv1qVELMXteJ1TzzUL0CZBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIdqkBPgWT+a4xuQNkG+Nh0YLetYvI38unbgVS2kXSmHklmLbOFHtbZoRg2LuRgcZbFJUmtPeNKOlkMDamH0052vqiWSDALQciK0HIjE+J/3jSOgfTOt/F3q7ySfLdn6zgqm1HCeEPEzw38jJT17O8Eh3MtxiresuNQMHaqFGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa9qG/Ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3A7C116C6;
	Mon, 13 Apr 2026 10:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776077551;
	bh=/59Z2nIxca4BWCGm41Q6Vv1qVELMXteJ1TzzUL0CZBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aa9qG/FtFR8PilwlAVTGc2cfRcP/xOxcrUt8dNlp7948fgaf/zaAqfG5vsj5x6EVf
	 keI7k+eYVk6wSRpo/Bj7K4sqjh36TCDmdfoFg2nKtOChlfUzXxt9LEH7AneAM6FKsJ
	 uV6ywKoThT00sSA6HZ8G65p9xRm++NQQI1aGCzP5N+gF8UwnUYsiJ1BHeWgXXV6RLO
	 S0TosDCcHNT/0T/xf/D7x8Cm7aFKHW53Ucde4CW7pQnzeOqa8JicFVZxOq2eG8dB0z
	 y992Opoqf8AYFdS177QYXhKHmseDoUXE0eAsA9IOAbway64CDdOczMjrP2OL2mu+ag
	 lZAG68Czz7Irg==
Date: Mon, 13 Apr 2026 11:52:28 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 1/6] ixgbe: fix SWFW semaphore timeout for
 X550 family
Message-ID: <20260413105228.GM469338@kernel.org>
References: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
 <20260408131154.2661818-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408131154.2661818-2-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278036-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 840F13EAF11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 03:11:49PM +0200, Aleksandr Loktionov wrote:
> According to FW documentation, the most time-consuming FW operation is
> Shadow RAM (SR) dump which takes up to 3.2 seconds.  For X550 family
> devices the module-update FW command can take over 4.5 s.  The default
> semaphore loop runs 200 iterations with a 5 ms sleep each, giving a
> maximum wait of 1 s -- not "200 ms" as previously stated in error.
> This is insufficient for X550 family FW update operations and causes
> spurious EBUSY failures.
> 
> Extend the SW/FW semaphore timeout from 1 s to 5 s (1000 iterations x
> 5 ms) for all three X550 variants: ixgbe_mac_X550, ixgbe_mac_X550EM_x,
> and ixgbe_mac_x550em_a.  All three share the same FW and exhibit the
> same worst-case latency.  Use three explicit mac.type comparisons rather
> than a range check so future MAC additions are not inadvertently
> captured.
> 
> The timeout variable is set immediately before the loop so the intent
> is clear, with an inline comment stating the resulting maximum delay.
> 
> Suggested-by: Soumen Karmakar <soumen.karmakar@intel.com>
> Cc: stable@vger.kernel.org
> Suggested-by: Marta Plantykow <marta.a.plantykow@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2:
>  - Squash with 0015 (X550EM extension); fix commit message ("200ms" was
>    wrong, actual default is 1 s); replace >= / <= range check with three
>    explicit mac.type == comparisons per Tony Nguyen.

Reviewed-by: Simon Horman <horms@kernel.org>


