Return-Path: <netdev+bounces-292902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKbLKFzaGGpDoAgAu9opvQ
	(envelope-from <netdev+bounces-292902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:14:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A759C5FBA52
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB62A3006D7A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4AA2772E;
	Fri, 29 May 2026 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQF0kBZ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6181D555
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013654; cv=none; b=thBjgCdQnj8fLlbmXWGVEEOXoewDOZNgNmq26iicWUKnWskAsUuapgEncHS9Ri6YxwfilyDMkV68tH7rTYVWCHTCpelhQc7t7fxcZbBly3RdiUW94L0p7R/6P4ejPp4A1G5yeFvRoZRZVvAJDYbEP4Wl/zXnQ+vmua8yB1gUe6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013654; c=relaxed/simple;
	bh=DD+rNaGKkxFg/NAxlW0Crae/hjZux4n54f1PywCssCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYFjuTzTSLxamtDA/pngH7PVbfG9XU7KvjM+a1oxzMYBtAK/HDun2eEkDDGe7jJ50Ezzt0oh2xHHyeO8U0AidSAEVj+EMzob5BdkQbR5LfRmZwPeUbNFDhLKJ/YsxlLZGN9l3bWs0orMQNj45LlJ2HqdIePimb2HznMdUTmAOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQF0kBZ6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137561F000E9;
	Fri, 29 May 2026 00:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780013653;
	bh=PZ80I4Q04V8uGwV2eqQomYAEzm5pmWHhpixyf6rW9JI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hQF0kBZ69s7CGcYpW8lZmNXXFoZ3kF6tBjGdGfBG74j1QpNh8VEsdvH17RQqKjnj0
	 aVGWopYfLG12cukp3Am1w475DutCx7etmP+4dlK1MH3/U25itBofX3gq5zzK76Xwpr
	 y+tHrCZUdh75q4TR7szGtOzVrkEMY8EWsI4TXu61oB1BMZuaP11Its48e3dEGw5oSN
	 5kZYzU31cpjqLCDOKJLYRmtvvdK12myX89zpCMucPIb0TjDcPgRVx402mcQ9jE92e0
	 JZ9te3VyEW55/XkhSUKvuOBrSvycmBj+BnTbnIzeAqtj7m/dLqb+vWmR9khQGyaK1g
	 9RQawecTXPyVQ==
Date: Thu, 28 May 2026 17:14:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann
 <sven@narfation.org>
Subject: Re: [PATCH net-next 01/15] batman-adv: drop batman-adv specific
 version
Message-ID: <20260528171412.7a60e8f7@kernel.org>
In-Reply-To: <20260528142924.329658-2-sw@simonwunderlich.de>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
	<20260528142924.329658-2-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-292902-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A759C5FBA52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 16:29:10 +0200 Simon Wunderlich wrote:
> +#define BATADV_SOURCE_VERSION "linux-" UTS_RELEASE

What purpose that does "linux-" prefix serve?
The unwritten rule is that the OOT drivers have to append something 
to their version to distinguish themselves. In-tree version is just
the pure kernel version.

To be clear, definitely a move in the right direction. I hope we can
move _all the way_ in the right direction, tho, without still defining
OOT-feeling version.h file with a dedicated BATADV_SOURCE_VERSION

