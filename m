Return-Path: <netdev+bounces-272227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EjDDdiSxWlG/QQAu9opvQ
	(envelope-from <netdev+bounces-272227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:11:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AB033B47A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAEA63008A72
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006AD347BD4;
	Thu, 26 Mar 2026 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNUq4+jm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04BD33DED9;
	Thu, 26 Mar 2026 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555662; cv=none; b=up70nOG2tCmImAjaZ/eK+eqew+STFIgMvfp7fKKXXd+h1SycY7zwcm7TnwjIy1tdWZWNFsvQmbX1deN4C/lltEpmwisyWIN2fgPgGKdGX16pAPXbs9uHRWGYEim+gVxdxFzyOwwP9gNTZ0q3VRSjaUv1bqnLLxg08eGw5rihiK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555662; c=relaxed/simple;
	bh=Zmij4qsy/LNInbgFVfuHxXloLEr8lGElEmtXJi+eSXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N83p/HRUavDoVoXm6RJqasYNCPm1AsDFUW46B9cNDpdHJwte1lAVJJgDDXIMSWP43+CQszDuBUxZdkiu7o3R7rExMhFDRdr3Ib/zefyij4tmu/zQ2Mj/n59DKkyuFZJznNcN4JMPLJT/41kGEcvzD5KfDF8wqce17ncpbIKJyoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNUq4+jm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FFDC2BC87;
	Thu, 26 Mar 2026 20:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774555662;
	bh=Zmij4qsy/LNInbgFVfuHxXloLEr8lGElEmtXJi+eSXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gNUq4+jmj9rEGfjyBMzhOPnu48LzgQ5aGFMLKoGqM6HvQ9uVeOOKYoOY/82JpU716
	 askX+Y+WRlmwieeKTtu4d+vagJXN8+L2ul/rR1/DEFSapYNDlnR6IyrxfkNPzgBX8E
	 JsHZqzyzAejo8PyLswGUlikJciMFIX42kpP49AbsjNNxrj1R3ORwOtlRKmta3VjF6G
	 05Uo09B0CsHzv5XcLyLjJoSs8u8NMQFlP0lxNtaG6uY5dtwRCxJgxZvQ9ckIfoOtMJ
	 oTKGcgnoAt9AhWfMSw5Rnvqo3pgumsyvcxtMTc9pDW1/RXpSKSSwyXXjy4bWnVnqv0
	 Av9UBVJRrFJQw==
Date: Thu, 26 Mar 2026 13:07:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stefan Metzmacher
 <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli
 <tfanelli@redhat.com>, Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz
 <dreibh@simula.no>, linux-cifs@vger.kernel.org, Steve French
 <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara
 <pc@manguebit.com>, Tom Talpey <tom@talpey.com>,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>, Hannes
 Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, David
 Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, John
 Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, "D .
 Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg
 <daniel@haxx.se>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, "Marc E
 . Fiuczynski" <marc@fiuczynski.com>
Subject: Re: [PATCH net-next v11 06/15] quic: add stream management
Message-ID: <20260326130740.74b4c92f@kernel.org>
In-Reply-To: <CADvbK_eXUfnGGQgGc_k-ecCW3-Co1MpGb7UvMgLonPy3HRhyFA@mail.gmail.com>
References: <cover.1774410440.git.lucien.xin@gmail.com>
	<91c6fd0a44eb15a98f945171ead8062badb89a60.1774410440.git.lucien.xin@gmail.com>
	<CADvbK_eXUfnGGQgGc_k-ecCW3-Co1MpGb7UvMgLonPy3HRhyFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-272227-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,google.com,redhat.com,kernel.org,samba.org,openbsd.org,xiaomi.com,simula.no,gmail.com,manguebit.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,fiuczynski.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 83AB033B47A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 11:06:26 -0400 Xin Long wrote:
> The AI report on
> 
>   https://netdev-ai.bots.linux.dev/ai-review.html?id=1624d906-c0b6-4e12-a63f-5cbfc51b660e#patch-5
> 
> is false positive.
> 
> As the sk_alloc() calls sk_prot_alloc() with __GFP_ZERO, and the streams->head
> is always initialized to NULL.

Can you also check the google one?

https://sashiko.dev/#/patchset/4019cfba3ffd6f91aee24713d2adc778f858b4c4.1774410440.git.lucien.xin@gmail.com

