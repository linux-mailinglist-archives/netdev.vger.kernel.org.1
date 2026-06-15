Return-Path: <netdev+bounces-299363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GCofMDS8L2pSFQUAu9opvQ
	(envelope-from <netdev+bounces-299363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:47:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F5684B4E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:47:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=IMqqvPu+;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=s+7P86f5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299363-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299363-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85E87304BE68
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AA6383C84;
	Mon, 15 Jun 2026 08:41:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A77D38239F;
	Mon, 15 Jun 2026 08:41:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512865; cv=none; b=SjbqYDwYMRUES656My0rB7itMitiwEbyIgfCrF3mkHj5qn6IThg3erpcpPLqT8VXUN8Exj3RpOJbrOq+SjwHJZv8pVAMgCR55iCO2UmTuaFIqwt3/EhtYqQvhrv2YhhNFgXizfRxCjeftTXz3Ep+lGktxhkDoGqSlhW2JNKihKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512865; c=relaxed/simple;
	bh=fuetLoCOL3PpviDKn7qSR/MJxvtvVE+PhK2KJEnmOJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eGDY3ygKaoMs0tQg5a8Hze2FJGA4AvCTkL5FXeapxRT4zT4o7X08QjQpqZ5zD1qBMIqu/7l2PzZzzioUDPIhcHs6EgCYpETmcuZWlJTIOfO2MD9Z+U/Ww9JyfXPKL2uP7VmLWPTJACCFIO/Q1xyx5HRgFmaqCEt5L0MhkaEY078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IMqqvPu+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s+7P86f5; arc=none smtp.client-ip=193.142.43.55
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781512860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fuetLoCOL3PpviDKn7qSR/MJxvtvVE+PhK2KJEnmOJo=;
	b=IMqqvPu+oEaF0vrE/tA6Gg7LPyg/LJ7LT5TLamUKQT3K8OuMg1pydM13tCpztMgtuJbrzZ
	HDzNw09mYbDz1zoeXsBMo+ju2Ydk4mGGXhvVyyNcoT0kxs/3WyozoZYnt8AwrVUxGlU9lA
	rj0FZa/AwhrtR+JwLxlJ28yST9oAYTJYozU5qLEIrtqH5u9YbYfDyQuEaikbgeBikzrChn
	6F1bLyMY3Omp+gtQHzluAT7ZXm6D+6qKSmyQzUguUm/DQIgSdXa50tARJxSHrnjLzbGNB6
	0PnRkEfeXDAL+zYLSmbd/Nst17VstX4Nc/Q+USRv40BXcQPhevl6Gtycf8718Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781512860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fuetLoCOL3PpviDKn7qSR/MJxvtvVE+PhK2KJEnmOJo=;
	b=s+7P86f5g/Dob7UOn+dkY5V6IHWMvnztmgGotX71reqjUBa6nPqzAtpnMFzJxIUCqW/g0d
	CqgtcJC+P0UV82BA==
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: hellcreek: replace kcalloc with struct_size
In-Reply-To: <87v7bsnnqy.fsf@kurt.kurt.home>
References: <20260608045640.5172-1-rosenp@gmail.com>
 <87v7bsnnqy.fsf@kurt.kurt.home>
Date: Mon, 15 Jun 2026 10:40:58 +0200
Message-ID: <87wlw0i4bp.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299363-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,jax.kurt.home:mid,linutronix.de:dkim,linutronix.de:email,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A1F5684B4E

--=-=-=
Content-Type: text/plain

On Tue Jun 09 2026, Kurt Kanzenbach wrote:
> On Sun Jun 07 2026, Rosen Penev wrote:
>> One fewer allocation for the priv struct.
>>
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> Acked-by: Kurt Kanzenbach <kurt@linutronix.de>
>
> It looks correct, but i'm currently out of office. I'll test it next
> week on hardware.

Tested on hardware. No issues found. Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmovupsTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgsLYD/4iqdWtIYb2dTbJlR0e1fMLPKlQoAUM
6xeHLEWYU5ICeWJ3uJoWez6vGzBzZlHnK0dRThqQ0sXjOfw2WUTqG/vxXV1Isbhj
vdBocWe4qoeIW/aQ+RrNXccKztV4SnMlqaydTidyoBa9POrzrAgv+M64yXTzu02L
UdQ8F3Kms3J5FwI649h9OEhoyRKWzT0aVUPLm2LB7jELf8wN16gfWeW82OZMKy0U
ApU9AbXfl475VkpSRNPTDDfXj6z9P2Ant+mez7drM0zfb/9TKnTFDs83Kg+3LxQm
jkgIKTD98UpvTfNx8IVJeDKaKvcK6JiYwBlNP0OppXQrxZivlpUPAvOgXil00yTG
5s1O1QNebIAPIXfxcymHzYsgqs2pNolC9OwOIOjHGsuVE/g9EMMadthPm3f6mW/t
U8cD9PwafgeRSiSv1MFDEJ61J53FVB43IEcHsi1mzUfrQdLJsd0RKyrlrmi6ivWz
+g/XDOFJGoDvaZThNkrpBZPyiAUuEYtocvxfCArAFMSVc+Hh8jb4LIPeBb7vr2fe
kk1OcPLifgc+z6oW19BoGlGN/UGJ3vLggXW7Ier+tKpDIWgmuBwKUpjzDfDndq+d
kcPAPLeyuOiT2L5t2jUYTeEgLK3LouTNslqCY6Ll7inTdK74XuvHhet87raiZ+47
uPfAgtBbgXd2Qw==
=rc5G
-----END PGP SIGNATURE-----
--=-=-=--

