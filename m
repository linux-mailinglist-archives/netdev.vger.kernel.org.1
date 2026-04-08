Return-Path: <netdev+bounces-276239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA4qNwK41WnM9AcAu9opvQ
	(envelope-from <netdev+bounces-276239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:05:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0313B62C4
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9640300F79D
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBD32EBBA9;
	Wed,  8 Apr 2026 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxHrx0il"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10140DFD4;
	Wed,  8 Apr 2026 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775613949; cv=none; b=s9ePOlGi9dq+AGlx7zB8t+kx2zTEnhHX/Kjd/qSwOY28gY79FnhjU7eEMMzvzizUTxMCUknTCxS8Peo9vRAjhRAM2BImOAfg3ArPWk4W+us6sd4XPHnSPph52w2IDpnW32HChh4GfOfDE1Vj7pvnFUaA36t/ZfTyQ/Jsj6VwCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775613949; c=relaxed/simple;
	bh=+S192f3QP9XZqLQ97QB/j90cy/1VAHKN3hjjmXLtlec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXqhc7rc+OgP+/HtHWm0XbY6qjvym9Xk0BeFghGC/97R36skRyDWyBLcjTnd4FxN/GMewF2YJmdumTZ+OYj2/ot6vOh3ssWp4XsYX1vk+tR6/pvlrjfQZ38mjHJwEMrlC06qlCZWp6mrVXWLnXgZx1k2RkHZfsuXx+OshSN45Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxHrx0il; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE4DC116C6;
	Wed,  8 Apr 2026 02:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775613949;
	bh=+S192f3QP9XZqLQ97QB/j90cy/1VAHKN3hjjmXLtlec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DxHrx0ilVSVXvTlIo6hw6GCfdCU+tBKVSvENWmSBsMsWA2WyI9ojKwN13y4mfwm+0
	 /1wH0WtcpTZWQQXp13Rk9EA286PWYBs2/vfFDXPiQos2hPSmzVmVOnJeQq7CmOZ4ob
	 3L9UjKXaAaAFd5kdZpMzqZWGkYxMBcmt4L4UYBy31rIcQ9KYyP8lFbp6G/uMP4Fzlt
	 Q65j4B+GtRto17SA6i22B5+cMLcllJNtjG+5ZFmI/IaEP0/DYMTMmVa8VIOqm3ShPS
	 295Uq4WXLZndRJzxcg1zdi1NTNNPrXTbrtwBioHoR+VOprM8+1pcfmpwZmK+UrpuEN
	 yISSkyKKEeV7Q==
Date: Tue, 7 Apr 2026 19:05:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chris J Arges <carges@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: Add net_cookie to Dead loop messages
Message-ID: <20260407190547.4225c1f4@kernel.org>
In-Reply-To: <20260403221352.186383-1-carges@cloudflare.com>
References: <20260403221352.186383-1-carges@cloudflare.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-276239-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A0313B62C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri,  3 Apr 2026 17:13:39 -0500 Chris J Arges wrote:
> Network devices can have the same name within different network namespaces.
> To help distinguish these devices, add the net_cookie value which can be
> used to identify the netns.

Doesn't apply, please respin?

Applying: net: Add net_cookie to Dead loop messages
Using index info to reconstruct a base tree...
M	net/core/dev.c
M	net/ipv4/ip_tunnel_core.c
Falling back to patching base and 3-way merge...
Auto-merging net/core/dev.c
CONFLICT (content): Merge conflict in net/core/dev.c
Auto-merging net/ipv4/ip_tunnel_core.c
Recorded preimage for 'net/core/dev.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0001 net: Add net_cookie to Dead loop messages
-- 
pw-bot: cr

