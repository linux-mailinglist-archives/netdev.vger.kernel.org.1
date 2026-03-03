Return-Path: <netdev+bounces-263003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJSsICJMpmnbNgAAu9opvQ
	(envelope-from <netdev+bounces-263003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:49:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB121E8368
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 591F3300B2BE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 02:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D17C375F86;
	Tue,  3 Mar 2026 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJiB144S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28227373BF2;
	Tue,  3 Mar 2026 02:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772506098; cv=none; b=PCNDD+pdSqGdfLpk9nZd29X4UEH7a1FtetA+DFoJ+co1Yyq0CfFREqvFBrcOViDUp8QtNQ1g+u9OQFSCgGKcOIld2a+bhozY0W0PtysdDC7jRJYByoTmrK0L0jWbmVYG1QRoZ0bkciUJfAI2dBbMnN9HDColq3sj/WQ/s01ZvcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772506098; c=relaxed/simple;
	bh=zfB/SGm+FPJf9H8hqCyH1x7P0653o2KTlXZab1qCVP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbqNnzyntBWsNeyylxoXPjRk0miOo0+UxGZmNMpd5LeuwbYhaViGRnu8xWzqD3cXIkFVcj1tWBXDUPsDX/aK4t51y2lSa5I0UWNXuwykNFChP8TB3iMjC5pek19JTRfQCIvJk4/uV54eu5f+E50DpBXgGd9vmfZV9MxNSPQUl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJiB144S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD9CC19423;
	Tue,  3 Mar 2026 02:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772506097;
	bh=zfB/SGm+FPJf9H8hqCyH1x7P0653o2KTlXZab1qCVP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DJiB144SpmrtP34iwqFAlA1Glrt8zm5pQVZw1/1ieCzzwmxLyIV8cXKAZO7Kiy80T
	 Is0WBTM0JY5QEUua/pJE3gMNQl3xDL0Rq7w+rNWr6I3aNy8bvh+kvDHzlfXo4aQTSG
	 U3k8rZajy7NkqHDX23rqvqBYb5wQl4pfWnInJ5XTAWkT5VKDW/amEGq9Fq2PaxAhoN
	 oQRk7V/0ik2s2bPKxfH9yZrnbJ9lo/AaMYRnhUTbibCUH5N0l98zMN+4Kliy7jwqHb
	 3lQaEPFK4Jm3jeO0mQOtVyhhfwsLPMww/idj9p7QJjoTuKGeWGLzOST9ze7HNn0B/1
	 ybBYH0dNAPeXQ==
Date: Mon, 2 Mar 2026 18:48:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Cc: gmbnomis@gmail.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/net: packetdrill: restore
 tcp_rcv_big_endseq.pkt
Message-ID: <20260302184816.44d261c8@kernel.org>
In-Reply-To: <20260301-tcp_rcv_big_endseq-v1-1-86ab7415ab58@gmail.com>
References: <20260301-tcp_rcv_big_endseq-v1-1-86ab7415ab58@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CBB121E8368
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263003-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,gmbnomis.gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, 01 Mar 2026 09:41:33 +0100 Simon Baatz via B4 Relay wrote:
> Commit 1cc93c48b5d7 ("selftests/net: packetdrill: remove tests for
> tcp_rcv_*big") removed the test for the reverted commit 1d2fbaad7cd8
> ("tcp: stronger sk_rcvbuf checks") but also the one for commit
> 9ca48d616ed7 ("tcp: do not accept packets beyond window").

Sorry about that!

