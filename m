Return-Path: <netdev+bounces-272593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPQWKJmYxmnrMQUAu9opvQ
	(envelope-from <netdev+bounces-272593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:47:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 175B23464D5
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D41D53021582
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C09228313D;
	Fri, 27 Mar 2026 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrN6GdQs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF383F8819;
	Fri, 27 Mar 2026 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622845; cv=none; b=KIQsiBR+sCGSIdl25NfgNoikYuQ9zx2NNsCuWaWczmURk31Vge3G1/HG2OdGi6k0r/mwQRpIBMf0Q2hcFzDxhFWAy9S1tioEM7hU/iitIP4OzVCb/9edCyrwbisq1u/UNcs1KoIZZ80su8nscbFb3hQ/O2t02rpgE3nrLrNS5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622845; c=relaxed/simple;
	bh=2rXQs32wqvDW7QSkYIr4YtldGSQDImxafhk89H7DS1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pme1FcFlSt8UUnM8xCDQlgJxTy++egu1L0Jr6OMdoR+8rvwmgWHmpAROtQEslNJp2jORiepnfDbqMpPT7+GSeAaqUu7pIeS/4pjVyXnXS3UlHGypehlV7memYakw5KSMNzco5ysS4T77kmGnf3WbISUSbRxgpRkxKfnUvndppE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrN6GdQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE435C19423;
	Fri, 27 Mar 2026 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774622845;
	bh=2rXQs32wqvDW7QSkYIr4YtldGSQDImxafhk89H7DS1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZrN6GdQs0ktOGev58eAnzNGJtREEZW0v3FXnrZ5tK+XfjF2p9AXjNiEaPH7rWWH7F
	 tW/M1lhVAWLzELJJZWSnJnfCV/omxVDQ/tNNFSd12C9EmcWKrbnKuyYh5Q2AVJFK0f
	 jxd2nKAEjgxMTIMpS03XQ46OPHgUtKj9/szQQc/hWBeO8lkRl7HhHNgbboIcds4bYn
	 jXYMNHp0H4vdN8obwcC6JnRT2AVEH6pF4cX45uLe8drEdHjrMZ5pSb9ZF+Q991QrZn
	 TCQc3R38C9pADyc58aBYfcoUYiu707w2CzWpNuknm/+mBkvArIlzRYSY3CaIRKS0qY
	 Bg1jWsEfBhdhw==
Date: Fri, 27 Mar 2026 07:47:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: fffsqian@163.com
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Qingshuang
 Fu <fuqingshuang@kylinos.cn>
Subject: Re: [PATCH v3] selftests: net: broadcast_pmtu: Fix false failure
 from incorrect ping exit code logic
Message-ID: <20260327074723.26e086d8@kernel.org>
In-Reply-To: <20260327012705.2389814-1-fffsqian@163.com>
References: <20260327012705.2389814-1-fffsqian@163.com>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272593-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcast_pmtu.sh:url]
X-Rspamd-Queue-Id: 175B23464D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 09:27:05 +0800 fffsqian@163.com wrote:
> The broadcast_pmtu.sh test verifies that broadcast route MTU is respected,
> but it uses an incorrect criteria for test success: it relies solely on
> the ping command's exit code, which leads to false failures.
> 
> When the kernel correctly blocks oversized broadcast packets due to the
> configured MTU limit (1500), ping fails to transmit any packets and returns
> exit code 1. The original script interprets this as a test failure, even
> though the kernel is properly enforcing the MTU (the core goal of the test).
> 
> Fix this by checking ping's output for "0 packets transmitted" or
> "message too long" instead of relying on exit code.

Still failing, are you testing this locally before you repost it?
Does it pass for you?
Please do not post another version until someone asks for it.

