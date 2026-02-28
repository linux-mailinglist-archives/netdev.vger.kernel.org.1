Return-Path: <netdev+bounces-262224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEWIGfpao2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:15:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9951C8E2A
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF7B8301389F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279FF175A80;
	Sat, 28 Feb 2026 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L43Cl8Qo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0472C54774
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772313336; cv=none; b=lxW/bUlX/58S5jCqOmpbHFUutWF7tzBXLWJVsl6zSYINIeDYG+RzrSLZwFCWIoLUklQD7sgKXMhFeq6xS1CXFuVrfIYakGy0S84rxcpP2fOElky/c+B9SZ8VMkQLNk1Fj+Vdc5BwDe62QieWWHDYUk1jq5zusKE2geHuASropzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772313336; c=relaxed/simple;
	bh=ZM+Q4+cXcZWFlK0LhZBKVDX7ap5Vx1ZW1beG94PD7D0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MiF5J+nwmTe9ccTDtzblZJerlsZZMlu+DrG0MrB62bfUS4pZlZNKjpuQyImEjuI3tqyBzdT5K2ycQESwhvOdA8I/Lf7r1kcxVTux/FASACJHrBkeZj4Fj40xsJjzI3HSiJr0sXBWY4ReMQnH8/muhjcUYZIA5mvGtLi5yb1SYw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L43Cl8Qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA37C116D0;
	Sat, 28 Feb 2026 21:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772313335;
	bh=ZM+Q4+cXcZWFlK0LhZBKVDX7ap5Vx1ZW1beG94PD7D0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L43Cl8QoJNB/ubguvlqvbX5bEa+HAtcPPnPUBstK/G3bMWPQCcQAOMLeXgogil8aZ
	 mwbdibxoitF3v0UgdRjYaKfF0xfkX+K5bzO2bSmAgMOOY+7893PUvATFhvdIWB73mI
	 VB9lnF1XTzffuPIbz++ug3gLh12iYHhCNng/6KT0HvSs2E4bMeRWMzaC09zuc6YOqw
	 N6qBtaBrITG5ZH5urO0GEtANGowFEpA3CbVy8t+Fg9HAEGHNoCdtE9HtRyttveKq74
	 ccEJoZzIxXH2Za3st6s9oug6QKnGyV29DOZvnc3r7G0MpoBNyvI+8A2tIcsNVDKpB6
	 40YxQ8r1V7EHA==
Date: Sat, 28 Feb 2026 13:15:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mengyuan Lou
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v2 0/8] Wangxun improvement and new support
Message-ID: <20260228131534.35c5727b@kernel.org>
In-Reply-To: <20260227073450.23680-1-jiawenwu@trustnetic.com>
References: <20260227073450.23680-1-jiawenwu@trustnetic.com>
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
	TAGGED_FROM(0.00)[bounces-262224-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB9951C8E2A
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 15:34:42 +0800 Jiawen Wu wrote:
> Implement power management function for txgbe. Clean up the same code in
> the two drivers, to make more use of lib functions.
> 
> Add Tx timeout process and pci_error_handlers ops, to recover the devices.

Please make sure you CC people pointed out by get_maintainers
There are MAINTAINERS entries matching on keywords / APIs you
use. Other time it's just nice to CC people who previously reviewed
some code base. The only exception is the linux-kernel@ mailing list,
you can skip that one.

