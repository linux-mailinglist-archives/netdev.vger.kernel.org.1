Return-Path: <netdev+bounces-288114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGHYD2RhBmpLjQIAu9opvQ
	(envelope-from <netdev+bounces-288114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:57:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9DE547E12
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 163C1300BEA6
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 23:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D9C38F927;
	Thu, 14 May 2026 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9E9NBPg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EED3016F5;
	Thu, 14 May 2026 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778803036; cv=none; b=iT7+Dtcfm4jrNjzflpP1lZw3cLVyzon8vxOhj8t4oKwYjyOvyqt1uyUmQuPakCtHfJXlNIYh2T4gIH6L5fL2TaCivhDJbun+Im9Fy5AgMdDjeuQCOSQV0beOYWhbrw5hLLbOTmKq8vlMfm+BotEkX3ck5N9yPncfaRbvzmZ0NLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778803036; c=relaxed/simple;
	bh=RWTWIwqVzWQfpAUGzl/eLS/TxSSKAmFWkhFN91IfKCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwcxcSHxqSAKo6/8e94oexzrzLeKB8vU7HYqVQWQX5RTdlyIHYvb0E/GuAAaciqPt8h6EUuwkXckKU2fuKhhJihsNTTYS6virC2PlKtMHF9vuhrRph0TQPniFeAedgiVViv5KaxtwaMpHrirawz68Fo1hBFR89KbTh2i0DhGl6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9E9NBPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04302C2BCB3;
	Thu, 14 May 2026 23:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778803036;
	bh=RWTWIwqVzWQfpAUGzl/eLS/TxSSKAmFWkhFN91IfKCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D9E9NBPg6StkIHoseBj6U2d7fSDfkF/XItVuTpwDb31G+TOpEXS17RKjSxhjDSuH1
	 RS/EOBgoNDgpX6thdkcCK8MrAH1d247Wfs5aAUeNKIxjgLTx8vrQ2YsncJdR0ELKW1
	 DiWXtXWTCuu/0H87bQYGC6DJ49JpdMYngSbnczublC+L67wglPnKkwQ1KTEuq1lqnl
	 dAV6kcNe97e95MnRd0aduso2hNW15HQUqe/o2ENF1M8DFks89O+u61tQbWVY97t/RE
	 EwTqIMjPZNkhAq/TdX5IIRWYMbdzFotYCHZf9fKVbUcZLbD9ieOeJQE57vpBarUUhd
	 ic0vPdl9RcyEg==
Date: Thu, 14 May 2026 16:57:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: netlink: warn on overwriting extack
 message
Message-ID: <20260514165715.3734df47@kernel.org>
In-Reply-To: <20260513143219.3327287-1-mmyangfl@gmail.com>
References: <20260513143219.3327287-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8C9DE547E12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288114-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 13 May 2026 22:32:16 +0800 David Yang wrote:
> When NL_SET_ERR_MSG is called more than once on the same extack, the
> existing message is silently overwritten. This is hard to detect via
> static analysis. Emit a rate-limited warning so these cases become
> visible.

I don't think this is worth the bloat.
There's only so much we can do for poorly written code.
-- 
pw-bot: reject

