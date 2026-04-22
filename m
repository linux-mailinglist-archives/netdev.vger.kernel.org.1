Return-Path: <netdev+bounces-280509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIVKL2/66GnLSQIAu9opvQ
	(envelope-from <netdev+bounces-280509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:42:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34847448CD4
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C6E93019C97
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24FD37FF5A;
	Wed, 22 Apr 2026 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMLvk9iR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEC8379ED6
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876125; cv=none; b=V6osfO9+z5i1QgNshHvH97PMR7A44qGEmrFiKhg6NWKHBFj0gi4uBe0gUUwcLwTUBAMapaZdBNH9/EQ9e1Gi3KekZpk10xDML2IhUb0GbCMapwfcQFBCdWHdDve5Aiy/O46PcvWYsOCP5rMbUEbok6X0zkEQp/+ElZ7oja3elkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876125; c=relaxed/simple;
	bh=ArRBtXXmLev7uDHjOd7RdB9AcTeBhDxqe4hHfT/kj7k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gWFJiLYf7498wlDPhF5Jchv8Bh7rrLt52BeJn0RHwEXXYworX123v2/B5cnnCFjtcQ6pGxZvUobTAFQJ/jV2HOrYQHzBvpPq83B4gyWJZLAeqn0+WgoL2004zurqn2RT5DTawE17c+yLOjd2kGUtwuBMqgTzY59BBnSKEjN4iC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMLvk9iR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E552C19425;
	Wed, 22 Apr 2026 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876125;
	bh=ArRBtXXmLev7uDHjOd7RdB9AcTeBhDxqe4hHfT/kj7k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VMLvk9iRgKi+rUPQYxVnihL141tI1ivigOVfQ0S+TQ335cVpV4m93G6BxTw2Pyn5Y
	 ft/mgc2pSBaCR5USiynBSqIFT6sImuzhG3b0xfedqZ11M/jFsK/hBnIQJyZbaRQ+ud
	 yIcUTtt+sV9tK0Qo4dHyoPWJ1TVRagMJJIicPz1d5ZfDXMLgNPwauiipzRwh59Vpvh
	 Z4o0PtND6XcSgLju3oDvvShaQ/1avZGE2PSkwH9rNTQD/wPgJ6FS17MEhMLaUDfyIl
	 Z5QqpLwnONXeiYKlffx0mxHWBwpUJM4YZ2SYKfHEwRC4keqTqSyRaFY9dLLzC7+k2m
	 +V9vSmpdzzbGg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 209A1F4006C;
	Wed, 22 Apr 2026 12:42:04 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 22 Apr 2026 12:42:04 -0400
X-ME-Sender: <xms:XProac7b_DlIvkt2SReJ2nBrL95t_iZ7Aq0c3D_WpG6vRwwNxumJ3A>
    <xme:XProaYt-m__B3JT52thv5LsgTqe5Iy4uett7zdQyo39CM6PWg73AM_JjkyEh7aYcL
    u4cHpg5ZjjwsYidPJRbN0SfNnYugqIPU4IDLlTx2Snb31RkD0oAnhab>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhope
    hkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhh
    rghnughshhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuh
    gtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggvpdhrtghpth
    htohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghl
    ihhsthgrihhrrdhfrhgrnhgtihhsseifuggtrdgtohhm
X-ME-Proxy: <xmx:XProaa63nrFW5WOWg0leRddcTiQnPuol0luwAhVeGOkjde9bh3jS2Q>
    <xmx:XProaf6GulLYKCDLYTN0DFMY9XIXdGk7gsQVw-c9pYs60mofHIKbEQ>
    <xmx:XProabr-ngdnyvkpeAvYdtdXLpz6utYb9GbwJXyZKCQf2r5HtvUFVw>
    <xmx:XProaYNxuWmWWcqpvkbkY31rlb21fQaUOHbN3bCJoV8TX-u9K5E_BQ>
    <xmx:XProab3b0mXWua95ZStp9P2hwCGLei7e2DE7A6HZvq7jJIYgcwIzSZ8b>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F32F2780070; Wed, 22 Apr 2026 12:42:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5XFUYgNEVqc
Date: Wed, 22 Apr 2026 12:41:43 -0400
From: "Chuck Lever" <cel@kernel.org>
To: john.fastabend@gmail.com, "Jakub Kicinski" <kuba@kernel.org>,
 "Sabrina Dubroca" <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 "Chuck Lever" <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>,
 "Alistair Francis" <alistair.francis@wdc.com>
Message-Id: <3fc31ab1-23de-4381-b85c-5faa39169ad9@app.fastmail.com>
In-Reply-To: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
References: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
Subject: Re: [PATCH net-next v7 0/5] TLS read_sock performance scalability
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280509-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 34847448CD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sat, Mar 28, 2026, at 11:17 AM, Chuck Lever wrote:
> I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
> NVMe/TCP) to coalesce on the use of read_sock. When I suggested
> this to Hannes, he reported a number of nagging performance
> scalability issues with read_sock. This series is an attempt to
> run these issues down and get them fixed before we convert the
> above sock_recvmsg consumers over to read_sock.
>
> Batch async decryption and its submit/deliver scaffolding were
> dropped from this series because async_capable is always false
> for TLS 1.3, which NFS and NVMe/TCP both require. Async crypto
> support for TLS 1.3 is a prerequisite for revisiting that work.
>
> ---
> Changes since v6:
> - Rebased on net-next, v5's 1/6 was merged upstream
>
> Changes since v5:
> - Patch 6: Set released = true when sk_flush_backlog() returns
>   true, so tls_strp_msg_load() knows the socket lock was
>   released (Sabrina)
> - Patch 6: Drop Fixes tag; submit bug fix separately via net
>   if warranted (Sabrina)
> - Patch 6: Note redundant flush on cold path in commit message
>   (Sabrina)
>
> Changes since v4:
> - Drop batch async decryption and submit/deliver restructure:
>   async_capable is always false for TLS 1.3, so the new code
>   was unreachable for NFS and NVMe/TCP
> - Purge async_hold directly in tls_decrypt_async_wait() and drop
>   the tls_decrypt_async_drain() wrapper
> - Merge tls_strp_check_rcv_quiet() into tls_strp_check_rcv() with
>   a bool wake parameter; fix lost wakeup on the recvmsg exit path
>
> Changes since v3:
> - Clarify why tls_decrypt_async_drain() is separate from _wait()
> - Fold tls_err_abort() into tls_rx_one_record(), drop tls_rx_decrypt_record()
> - Move backlog flush into tls_rx_rec_wait() so all RX paths benefit
>
> Changes since v2:
> - Fix short read self tests
>
> Changes since v1:
> - Add C11 reference
> - Extend data_ready reduction to recvmsg and splice
> - Restructure read_sock and recvmsg using shared helpers
>
> ---
> Chuck Lever (5):
>       tls: Abort the connection on decrypt failure
>       tls: Fix dangling skb pointer in tls_sw_read_sock()
>       tls: Factor tls_strp_msg_release() from tls_strp_msg_done()
>       tls: Suppress spurious saved_data_ready on all receive paths
>       tls: Flush backlog before waiting for a new record
>
>  net/tls/tls.h      |  4 ++--
>  net/tls/tls_main.c |  2 +-
>  net/tls/tls_strp.c | 42 +++++++++++++++++++++++++++++++-----------
>  net/tls/tls_sw.c   | 50 ++++++++++++++++++++++++++++++--------------------
>  4 files changed, 64 insertions(+), 34 deletions(-)
> ---
> base-commit: ced629dc8e5c51ff2b5d847adeeb1035cd655d58
> change-id: 20260317-tls-read-sock-a0022c9df265

I see that this series is currently not in v7.1. What is left to do?


-- 
Chuck Lever

