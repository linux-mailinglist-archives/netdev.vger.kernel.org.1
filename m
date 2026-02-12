Return-Path: <netdev+bounces-258465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGyOJsDrjWnG8gAAu9opvQ
	(envelope-from <netdev+bounces-258465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:03:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDBF12EBC5
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C6CC30B6085
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6DF35D5E9;
	Thu, 12 Feb 2026 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqeu9frs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576E35CB8C;
	Thu, 12 Feb 2026 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908494; cv=none; b=dbh6shPgcYJOXFA+kBaEjqya1OKIszk65XDtAPCNV68qf7HFpJoz1nvObpUJGN+xOjZOYBSruSQoqcJXpglmuF6O/UdkdW2NqmkXckNmve4yW6F9dOUAG6806ZQAmjVJjR1At7BayP170NKyygWiDjHCzt8LgmdCv4D1YBgNaEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908494; c=relaxed/simple;
	bh=Kb982x1GUO7vXVuKBOhiQzpM4sv3ErXgtaGOIxfCrX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEvLxwUslKOQlS+w5be4Eko0bPmLd9pe3yta/P5KqscLLHoYimemCvC4ie/fu2guHJDvCmM0Q7u7yAVIu/cjJUDz4pIOYehECzcRucxfRsa5xoXKNoHkW6qJffRakmG83ruHEXCzOmp7H/9iiIPav1BnnMKvLyh53/Xz/NzNEQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqeu9frs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EFFC4CEF7;
	Thu, 12 Feb 2026 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770908494;
	bh=Kb982x1GUO7vXVuKBOhiQzpM4sv3ErXgtaGOIxfCrX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqeu9frsvPkfQERhH/YwdTJRxR/6s8PpYCpGVxuDA9wWSZbaDxAmwpXRuTkXqaTMQ
	 g0/q/HaWB1cBpwp6Ym0p234e3YvjvMdsRbwjLR6gMTB9dzy6eP4/owZcctGycQedSZ
	 Epmu2O1VNoFs9PeANmdLZvIIDXecMhnXBGyvWW8Aw/jqRHl8pDvbGdJacaIDku7naX
	 S4qMCyea68B5bJCXqZCO7IGu6WkzkV+R39ej/KpvfbdKR3xWDbgbZV/h+1UsqxFd46
	 rClKJ3vSmo+zEHJbQbQJEVuXz6Zwp36Lr7e8obZYpc2klR2h7QVfVVPoTEpoXgOuoD
	 ULLElTSLHMlNQ==
Date: Thu, 12 Feb 2026 15:01:29 +0000
From: Simon Horman <horms@kernel.org>
To: Pin-yen Lin <treapking@google.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] selftests: netconsole: Increase port listening
 timeout
Message-ID: <aY3rSceyDJ2j3UAN@horms.kernel.org>
References: <20260210005939.3230550-1-treapking@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210005939.3230550-1-treapking@google.com>
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
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-258465-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0DDBF12EBC5
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 04:59:36PM -0800, Pin-yen Lin wrote:
> wait_for_port() can wait up to 2 seconds with the sleep and the polling
> in wait_local_port_listen() combined. So, in netcons_basic.sh, the socat
> process could die before the test writes to the netconsole.
> 
> Increase the timeout to 3 seconds to make netcons_basic.sh pass
> consistently.
> 
> Fixes: 3dc6c76391cb ("selftests: net: Add IPv6 support to netconsole basic tests")
> Signed-off-by: Pin-yen Lin <treapking@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


