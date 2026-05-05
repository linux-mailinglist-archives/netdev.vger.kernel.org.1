Return-Path: <netdev+bounces-284114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBchHUk0+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:05:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 036C44C518A
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2BB73017004
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 00:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53211B808;
	Tue,  5 May 2026 00:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC13cDzt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F2EEC0;
	Tue,  5 May 2026 00:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939388; cv=none; b=rN3bRcQ2U2mxsePAEIV/Z0oape68TYX4+YgzCs3p4O3HKUQp0BmGwdHRyPD52bw61tKgHmo73Ktx4n1Sxrr+TA0KXHAOZhxyXGYQ3FSr2ix3+8frtpHzZHGplEMXDW0fSXJAtyklcc5jlHt+kr/k7a1haNjmS3OcsW2u7Cm63Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939388; c=relaxed/simple;
	bh=aXy6Z/Hgj61TCbWjQBYjpxTjhDiemSubJbDoQZ7vIds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdMcNC+j2ZDHJS4EuU+WFppu1fPw3mfVXp4ZswzFCzz2dqTd9POvF+/+75qJ7bN5gNZ70F9O4Lw57pbGy+0KBuIgvJY0URXx2z/QCDx+zmy6mNhZ4mxA9rHtEFIYP9MSxhypJ1mA+Qxt+t/gQ2KP7uGJ8lsEgvlnN0UJeMAwxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC13cDzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C331AC2BCB8;
	Tue,  5 May 2026 00:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777939388;
	bh=aXy6Z/Hgj61TCbWjQBYjpxTjhDiemSubJbDoQZ7vIds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KC13cDztD/0U65hHLB02E0r6/JHTASe3RVXsELcgvuM66f8qdP2NxXpy1gh6vzbRH
	 GuuBK4vsx3RiUcCTQ+cpqITU80VlmYfpHCnsFAusz/LmyMgoTjQtUAfeej9pcc6jZi
	 MZN0PIN8ka9ToQE4Y/rriyRfY9aZ+4RLLq9qk6fqsKJ5IH+A5Pife1mJ4NArjN3pm9
	 p/eAgNg5iQAUbvd0C+SB0D/zDFd5ATeAX3jWMpXCPBbGhl+Uzg+EAESEsZr6Q6mfn6
	 WVxjp55lvrD3vzw1JWOfQORp3GLqsfakZ2AqzSaqbE6ijveQE1fx/7GopIgN4vg13T
	 vuY8F7dqh1dMg==
Date: Mon, 4 May 2026 17:03:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>, Haren Myneni
 <haren@linux.ibm.com>, Eric Biggers <ebiggers@kernel.org>, Julian Braha
 <julianbraha@gmail.com>, Qingfang Deng <qingfang.deng@linux.dev>
Subject: Re: [PATCH v3] tty: synclink_gt: remove broken driver
Message-ID: <20260504170305.06aa591b@kernel.org>
In-Reply-To: <20260504031519.18877-1-enelsonmoore@gmail.com>
References: <20260504031519.18877-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 036C44C518A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284114-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,lwn.net,linuxfoundation.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,garyguo.net,protonmail.com,umich.edu,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun,  3 May 2026 20:14:53 -0700 Ethan Nelson-Moore wrote:
>  drivers/net/ppp/Kconfig                       |    4 +-

Acked-by: Jakub Kicinski <kuba@kernel.org>

