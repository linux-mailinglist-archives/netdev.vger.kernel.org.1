Return-Path: <netdev+bounces-257431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAGrCVhbhWnNAQQAu9opvQ
	(envelope-from <netdev+bounces-257431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:09:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 844F0F9927
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EF193004607
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0C22FF169;
	Fri,  6 Feb 2026 03:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0eMk5Qg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6022FF147;
	Fri,  6 Feb 2026 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770347346; cv=none; b=RYUqZj5fmSG73CVtXQbMJEw0eqyA94EAIONlxcmVryb3scLzF9eEUzhixjV6npkIIMgSEC8ItxXmAmUmime3+SWkj3N9LfQPcPt0JvQBpmd+L2mSa7OUTE4Ah8YbglKxGk4KlUOWZjq3C/2ZwGDTQxSchW1WhzLRywxGsL8pRrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770347346; c=relaxed/simple;
	bh=CJMXASXpp8OaEfc6cvu1uEe6i3zuz1EC6kzWc16UG5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtBy2QOaG59837wPi8braOqB6w6F/mEzJANw/FfqlB9HBrNywZlAq625twx9RZW2KbEG30VJDCrlxgQwNpZTC7sQbX14kBE8wZWpkwwCyy6uPbauUGLH7qjOKKWLsr4KUZ0G46qe1mKUIsWsry6ScD4AvMFGBRGk7qe5KOnU/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0eMk5Qg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57702C4CEF7;
	Fri,  6 Feb 2026 03:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770347345;
	bh=CJMXASXpp8OaEfc6cvu1uEe6i3zuz1EC6kzWc16UG5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h0eMk5QgLdKwPvLlIRQUH+b9yEyEDBhJWqlRgv4A2FGUzGoerdxSJnyXa3tbcLkrW
	 GHeJ5GkgdZIEj9AkA5UEGixuFpO6TAHeBCHHulKXgWRCcgXEZe3BKLquc5oFs9hSgP
	 UzcXZrkNvgL97Ps+cgYWaOlquWt61hbcTH0GPwRbsy5xHA/i1VJfHakZT8FM7vY5cj
	 XymDQmVDS6vdDXcnzCxVWejQUv296eVGxXlPu9Ib1bolwB77AtIRASwPIqYkfOEU9/
	 WpzcBk8L4tDgubI6jCFOhv6vMAHrpGyJ8ygsBuH0r4tHBvhpFuKwstzyYiRnsfBxnR
	 w+Sqhk+LM1XSQ==
Date: Thu, 5 Feb 2026 19:09:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH net-next v3 0/4] amd-xgbe: add ARP offload and RSS
 self-tests
Message-ID: <20260205190904.78be3190@kernel.org>
In-Reply-To: <20260204145829.801839-1-Raju.Rangoju@amd.com>
References: <20260204145829.801839-1-Raju.Rangoju@amd.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257431-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 844F0F9927
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 20:28:29 +0530 Raju Rangoju wrote:
>   amd-xgbe: do not select NET_SELFTESTS when INET is disabled

I'll apply this one

>   amd-xgbe: add hardware ARP offload support
>   amd-xgbe: add ARP offload ethtool self-test

These two I don't get. The feature is enabled during the test but it
can't be enabled by a normal user. So what's the point of testing it?

>   amd-xgbe: add RSS ethtool self-test

xgbe seems to implement Toeplitz hash, much better to run
tools/testing/selftests/drivers/net/hw/toeplitz.py
than just checking if the hash value != 0..

