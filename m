Return-Path: <netdev+bounces-288498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNLpD8OkB2rP/QIAu9opvQ
	(envelope-from <netdev+bounces-288498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:57:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03005559229
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 949FE3041A2B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684873EE1C0;
	Fri, 15 May 2026 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncLKCtDL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440883EC2FF;
	Fri, 15 May 2026 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885467; cv=none; b=eywDvajSpe0thGN4g5Zpo6evAxcYNexMfAZ2TYUaTlei4PyHzr0OJhtJQRvdCpsCHD6W8N0P43mK9hqW78HiVyu438edoghnWA1TdH4PuJwcKuooIqgko0OXpd+/v/KFEUL+zuNSYDhtYtfLC1231//YVrvJWi7TSJjPDdkM4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885467; c=relaxed/simple;
	bh=wVfO0gE3m0UYUZcGPsl3M/Uxe7YMqqLtXybLl9PHyYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7dSzyPRaVzStcrVFZNQ1dEIR5T4iWSmS4NqEHvmZGEV5QXhtb6yjTcgAHPvNr4fEDoQtF5hiAdtqMdaQkZn6SroUBWIo2H6aPjKNeBiienOU/V5/WuaHVjFBjsgpQlxAhFv2YLQfGnpoJwseZBdGjHDyFAHjsTAa6WdBdYTsq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncLKCtDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A87C2BCB0;
	Fri, 15 May 2026 22:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778885466;
	bh=wVfO0gE3m0UYUZcGPsl3M/Uxe7YMqqLtXybLl9PHyYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ncLKCtDLSB5osBKxm3z+Zqp9EOVWa/LSmory/5sDfCL003KNloJgSiZ/eLYV3iBOc
	 kkJxNgZvGG7AuDBD6rmT5+AcTXikHQ38B6tllyNYtVUt3N1fGDhEcRy6c/bWeQvaP2
	 g1qPY/U+/e8rE0zxfiWE0WYcA0n9NJ5PmpN8LJuuqX5h+q0zoAdLr4BhzSDknivhyY
	 IaCwnsUE/0FIsnHA9pRpOEYcaPNInIQCCqUFVA3hP4R6ZSCxp55vL3XyxyjrgiaqCx
	 k0quJM/II0YRZEEd16E2KvzmIxgs/4almk16xjwemE2Dw5htzJs1vQVmMqfggOpKdp
	 i3mOI3O+6XOWA==
Date: Fri, 15 May 2026 15:51:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Shabanov <mail@etehtsea.me>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] docs: netlink: Correct buffer sizing info
Message-ID: <20260515155105.77ce437a@kernel.org>
In-Reply-To: <20260515155741.25082-1-mail@etehtsea.me>
References: <20260512172757.10c43c86@kernel.org>
	<20260515155741.25082-1-mail@etehtsea.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 03005559229
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288498-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 15 May 2026 22:57:41 +0700 Konstantin Shabanov wrote:
> The problem is that according to the comment, kernel isn't going to send
> more than 8K in a single reply and the documentation is currently recommends the opposite:
> to create _at least_ 8K buffer what looks excessive.

Got it.

