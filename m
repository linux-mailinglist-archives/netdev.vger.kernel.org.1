Return-Path: <netdev+bounces-281529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBA4G4rp72m+HgEAu9opvQ
	(envelope-from <netdev+bounces-281529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:56:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DABD947BA68
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FD323019126
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C74F3A6EE7;
	Mon, 27 Apr 2026 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIv+uftT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E937702E
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330567; cv=none; b=kF3vKUJY5jTuPEVGKN5BD2eLVDyjuOSjKTbCBg3g1WAaArkVPeUxCjr9eSFQWEH1ZmgBtUjWJxGiICJMihSM0DH+2ymMG9OqX3mH8UHnpjrrIynR3JF6HjpLY+wAIO+LEF9VRO065pEFfF3HORaDnAA5NTsQK9M5dGM8pUnQyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330567; c=relaxed/simple;
	bh=ATdi7eZjzFuZdSvVO4LVj2u+loo05yMSYksyz4Qa9lA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFiSM0/w2l5f5/XBPAMNGyjZkdBUZH2VoYPcBKtxRM0NwPb9i3jJyOeNcnBC1ILSnUT4Q2hxUcmSLFy1cIyflj1037xCADAn4j0mwa3ZK6iVnAWpq7CagVFNRzaq7YgjGUXW8/QBvGQ7kPB7FaiJFij+8aay6u/TZEpioXd4t2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIv+uftT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B486C19425;
	Mon, 27 Apr 2026 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777330567;
	bh=ATdi7eZjzFuZdSvVO4LVj2u+loo05yMSYksyz4Qa9lA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EIv+uftTF20JgDCxj4yyNeZpQ9RllFZgetziL3L8lUpJMyj5rClQSRjwfYK5adYZJ
	 EIk2Kqqn5OZCeRtiBvQqvfylbDwdp66/UKGA4qN5TaxFkB6fh0TMAElxgL/kHkG9F5
	 boa8rXKGTOqsNThqWDgGvfRxOf0AFLxIVZnO5m6UIfPPcCLRBTRE9O6vmZaeTYVD3X
	 BBJuuuIlPx9BjFfH0g01ooYgFdI5/rOGt8Ir+592VFJX39No7ASnjjUSDM/1QPNOfB
	 gUsdWKcFEKtCoLCZq0w9jWstxkHJ3v+R6QwYz/7z85I6JnPIzImvW815SWCzq9Br5s
	 r6oWA/yokrYYQ==
Date: Mon, 27 Apr 2026 15:56:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Dimitri Daskalakis
 <daskald@meta.com>, David Wei <dw@davidwei.uk>, Joe Damato <joe@dama.to>,
 Dragos Tatulea <dtatulea@nvidia.com>, Vishwanath Seshagiri <vishs@fb.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Simon Horman <horms@kernel.org>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan
 <michael.chan@broadcom.com>, Gal Pressman <gal@nvidia.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: Enable ntuple-filters if
 supported
Message-ID: <20260427155605.1bc9201c@kernel.org>
In-Reply-To: <20260427165829.3898229-1-dimitri.daskalakis1@gmail.com>
References: <20260427165829.3898229-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DABD947BA68
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281529-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,meta.com,davidwei.uk,dama.to,nvidia.com,fb.com,gmail.com,broadcom.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 09:58:29 -0700 Dimitri Daskalakis wrote:
> Certain devices which support ntuple-filters do not enable the feature
> by default. The existing tests will skip (if they check for the feature),
> or fail if they blindly attempt to install rules. Therefore, attempt to turn
> on ntuple-filters if the device supports them.

net-next wasn't open yet, when you posted.
Please resubmit in a couple of days.
-- 
pw-bot: defer

