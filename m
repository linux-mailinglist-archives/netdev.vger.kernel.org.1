Return-Path: <netdev+bounces-261226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLEZNIkAoGlrfQQAu9opvQ
	(envelope-from <netdev+bounces-261226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:12:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A691A259A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3072300F129
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CA8387599;
	Thu, 26 Feb 2026 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ReGgoH+y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t4ArF0xq"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1795137880E
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772093481; cv=none; b=nzg0s7ibILvCFwJOzuCkz3JCYBPdmcCu7SdMN4BuY4oy2cgoDfZ3vqU/DEs0Ti/OZ4jFN486jSMP7sUlAuNlq8Yw5gg5Tl7T91hkhsLRfTIhjCmXEN4VHtK/Bjq+QqIQONMUZeESda+K+V1vepOt6Zs+dq5tQNmspGnaNjhel+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772093481; c=relaxed/simple;
	bh=EEyCUYAIX5Uwr9+fHgE9Jif0O5SXtYu+RME7yHDx3tk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZSFBEpLghM/AtkLVQ3H5utwFUQHJpdk7LHd69TGj/H3llPU4J1AXi3iErH6uJq7lDogWIKSzz3/fLxnlb+HIBcPRIJvbVbnM0KbyUPU98/a3uaFoXpgs5kfqTO44QqlwbbqekvGWq6BGCNOuJVMHE+Dou3FJL+zcW2+nI9GD0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ReGgoH+y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t4ArF0xq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772093478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9iIOV5FqFnR5rXzWQNPd5xi9vS2oDBpKRTfshCc/ng=;
	b=ReGgoH+yEM0Td8voIBrsDgdswzcQO3FyqZh9k1ps2Sab0wY/Wltrq8Sy4lDUFY9Qr4gls3
	usY3r9eZA/BZDZqfJyRr1/Y9UsRlWlCWCUrBwp+4MVB1y0i2cxttSdAkKKUSOTTStrEiOC
	FK/ezrokY6Yu5AIMdiucVrH46t4KlK4HIClD9aRqgrZHRYWXvReAobeZDXtdGT+RQPs3KH
	m+e8Sm+X4RrrlQobdkNqCcHetoLJdsTbgmTO1TEpuomtocWMTKahIfH4rWTbZ0ywSfNfd4
	P9chTmZAiM3YTw3m2pyi7/nLL15kmpR0mUZvvINx42VLSpfuWvPJh4Db+sRIsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772093478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9iIOV5FqFnR5rXzWQNPd5xi9vS2oDBpKRTfshCc/ng=;
	b=t4ArF0xqa0hgs0ePn9L2RUsdULHRws9w8O2LUVZkv/d01Sj61letT523rCAzDy3WKuXCIi
	GmRC9EmFOOg0BnAA==
To: patchwork-bot+netdevbpf@kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com
Subject: Re: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
In-Reply-To: <177193020629.3444651.13248671448207071630.git-patchwork-notify@kernel.org>
References: <20260220183858.N4ERjFW6@linutronix.de>
 <177193020629.3444651.13248671448207071630.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 09:11:16 +0100
Message-ID: <87jyvzvs9n.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261226-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev,netdevbpf];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,jax.kurt.home:mid]
X-Rspamd-Queue-Id: 38A691A259A
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue Feb 24 2026, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
>
> This patch was applied to netdev/net.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
>
> On Fri, 20 Feb 2026 19:38:58 +0100 you wrote:
>> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
>> not be taken in IRQ context, only softirq is okay. A few drivers receive
>> the timestamp via a dedicated interrupt and complete the TX timestamp
>> from that handler. This will lead to a deadlock if the lock is already
>> write-locked on the same CPU.
>>=20
>> Taking the lock can be avoided. The socket (pointed by the skb) will
>> remain valid until the skb is released. The ->sk_socket and ->file
>> member will be set to NULL once the user closes the socket which may
>> happen before the timestamp arrives.
>> If we happen to observe the pointer while the socket is closing but
>> before the pointer is set to NULL then we may use it because both
>> pointer (and the file's cred member) are RCU freed.
>>=20
>> [...]
>
> Here is the summary with links:
>   - [net,v2] net: Drop the lock in skb_may_tx_timestamp()
>     https://git.kernel.org/netdev/net/c/983512f3a87f
>
> You are awesome, thank you!

Hi maintainers,

thanks for applying the patch.

What's your preferred solution for igb? Can we do the time stamping from
IRQ context now [1] or should we switch to BH workqueue [2]?

Thanks,
Kurt

[1] - https://lore.kernel.org/intel-wired-lan/20260205-igb_irq_ts-v3-1-2efc=
7bc4b885@linutronix.de/
[2] - https://lore.kernel.org/intel-wired-lan/20260211134436.1e623034@kerne=
l.org/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmmgACQTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgp8yEACpKGuvtHWD9jBdkIbi371SJZAGASYv
Ndc7BTPHhLabi4whGR5S5cRiVKUPex7qNhs7h4dnzsBI2TcSMMll0z83xxmHl7uL
PUcXCCfUUW4xgRhNH6ddUr5Ss/IiiDDPJgtJbnoYjmFJX3keXA8qK4Gzs0ZJHjNX
WWNvptxS32TipFuBHcojXvgtBuJ40owuga8qw3jrS/CIW6QkQM7FtvLex180rfjJ
liJ3MVYgxZg3Jg9QUIfvI0Sk97Zjm+f7Xo9pXdqNYn6hV48xY1BbNXFUPe5qDT4b
RB1u8BtWLx2i8eFenykBUlmv3VPlLMuPwYPa5TRHxD9mKhwaTRUgvSJgM/yrFQqN
5QBX+fIbBYzRaPSwSabOLQrKqOe2KNRmo0Byprt5AaJe/by8YHRKQxwYxNs4za0S
IaFrFeF84CyeP9OdZbvOohsaQ90G2yFSN3EP7MP44BMaW0T88i5t0muoMWTGxHig
gdrOAfbs16+mk0YluvPszndMfaTlitfLwFTo3iPaELW3k+3pImNViXS05G+mnDpH
/AQCFiSoWYDSf3prN4Wh5dSsxsE4sgvOKNlQJ3YzYSD1s/dCPtKKJP6T2lCCa5i0
tNOI5xIuEW4f1uojWjGjuUG8mefZa9rUFFGqIChGeHkC2hHLiAJ28cua+jjG4QLS
EWGhXSFbfUg6aA==
=n5sV
-----END PGP SIGNATURE-----
--=-=-=--

