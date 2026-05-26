Return-Path: <netdev+bounces-291498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOdrEAL/FGp2SAcAu9opvQ
	(envelope-from <netdev+bounces-291498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 04:01:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8E35CFA5F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 04:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A98C3019922
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 01:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D1B2DECBF;
	Tue, 26 May 2026 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrDDNp8J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC922E1EE7;
	Tue, 26 May 2026 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760570; cv=none; b=ANlmjT5eleIkmE6q+ifMSaAN0A1uAqbK9ug7rhjHaJM5tM6Ocmv03Hv9vwTgfCi7eJchbXo2OFgdi1tj/E9lK6yb+R1+psqQB6hmtwmsFt9vxu77A+ldfgCq08mGwnn6TXzWx/6f5yZ9am6JsvtJixUIsUPXyiznHNnAMqQCPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760570; c=relaxed/simple;
	bh=6os/Xfj3SzbXje4NUPmryhL7exGQHfw4jvft+lClqyo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Upd0zwND7FE6gaql3qWvbGWLO0soQyKPK4hq3eDc2Nucinurk9rVwmOuvROBIhxDY8DgjBWxayv3gLvT+EcQhzauKgN3eAVbAqs3onjgfUG4Jvv2cWmBO2cIT9Hw5nohVvCrfUZimubJcPVEEHQDsKkpy0iJpVMHQWa6FnCO6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrDDNp8J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9136E1F00A3C;
	Tue, 26 May 2026 01:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779760560;
	bh=Jjaxy3vPb3Iq0OfsTFhVODUECJM4OU1Hc8Vi+5XFf3E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=JrDDNp8JfycFbJ3a+MnTil4yhOmh1BsqhYFxVFOpQCSVX26YCDkz6b8qLAGxVqla+
	 B9FGfa9MuV9/8jFiz5fJiTO3JSii4hkuyioB1k374jZSxlvZxWIwq7bZDhv4XArqgV
	 GKhq1mSK6ZcWZ1b1bDe8H6rCKWVyf1kVHRtC/AChsmTA0VahwASduKzxB1v6WMcpDP
	 sIJJss4nCD0ArSQd+wp0n+baKfOkUuSqWWPn0ZKDYWxFivE/hacB5MTvIrdEUcOHbx
	 SpL+yLSic6DJMTh5hk2LnAougnvfxV9hMRLQ6d5oovGWHr/Wh0vQblN9qSHx2/MLt0
	 cJCejMkaN13UA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C0E83F40070;
	Mon, 25 May 2026 21:55:58 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 25 May 2026 21:55:58 -0400
X-ME-Sender: <xms:rv0UakhIEp1UNd3GE6bVzjXuI7KBQN-kN-hv7URAP9TWLkKoh8U_Bw>
    <xme:rv0Uan1KqDsTaFCUzTRDPmntBf9YjHcQgDJZkB0RWEHFGVsBOIGQ9_YYiI37gfwrh
    OGuXDhwb614nwTKSYR4ryWSLSHuXDAna1NDB8zrDK5eI6mX1hmuVA>
X-ME-Proxy-Cause: dmFkZTGXsvjcirJAQreEsH50lgfnh9IpoZLP114BrPQUZNXxaqSPq+f513h0UYwF8aVf11
    VMXwH/tS5V9kixZmjUn5S1rbgJRYgGwsPwtUiwHQJMRk5HF+MmmZ9ZlfqFPuMzX67RbeA8
    aaBPTONFldqn+HnYtbV7GKS77P275ZRiHZPC9xMHR586n2on9uDoZVzwqVfjm39DN1ty8f
    PGW/OpeK6NaEe3At+fcVXYwSPadYXROvOJxgEuPt0+5SN3uCla/tQKOwQAge9bVFfflPu3
    7iMYAWTOt5UQZp6SzJsR/PZWzi8wc+DPqP3QokILfOGQeBOvADTj5/9DvCiD4BVwDFFehh
    bbox9RZvW0g2KBkMHLrBdd8Plm8AlFNyCzsnNkvtgk/lty0zvKjSi6WpOCX82bSasJgSQf
    MqX4EeUEPICzilTCqauFaJEpYgdCbG2vl73CTtkVDU4aaci6tOwYtMEx3kXzAeGQqfb+eF
    KuuYvjJokwFx5SKDd6dpnLGymJlAuC6rnYonmMuyXJ2CgBQSIt2lzYZbvnhXUwEkEF4we7
    sP5XGvQo2Z7/qAtFzmlZdiCGdHOnQC2bnohrdlYuSYCc1ix5GFZfDs2jOrpsgMP8FJ+Ou9
    GMssxbyF9Gq35VyctIHo/MXqUqm73i2D/NAC/q9uqOUGAKoxd25CH4zRLGAA
X-ME-Proxy: <xmx:rv0UatS8R7Hg0zIMAVWWzide51QsjwSsQxL1hXH17YhJiA1g2QD9Tw>
    <xmx:rv0UaqfRZ3i6JEl5zco1PUiq-b4aBvuGoBYuQtfhM2xSlnYicggyPg>
    <xmx:rv0Uareb-2kyh6Pu9ezpjgnkqwQIhtYHdT5UwJeByMjw-GnmN-bPzw>
    <xmx:rv0Uamb-O53YBad3ufcnxoNeZfMkC_aTZpn5WS4EMwNFXSDEPgkt_g>
    <xmx:rv0Uan59jfLVG1K-5oWxsWQd3LMsuv0xQPHsXI2YYZzPd_P0qjRvAM7Y>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9C44478007B; Mon, 25 May 2026 21:55:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 May 2026 21:55:38 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Chris Mason" <clm@meta.com>,
 "Christian Brauner" <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
 "Hannes Reinecke" <hare@kernel.org>,
 "Alistair Francis" <alistair.francis@wdc.com>
Message-Id: <f7aaa5b3-5447-4f32-89e7-4e9e9ce01c6d@app.fastmail.com>
In-Reply-To: <20260525113533.6405efa0@kernel.org>
References: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
 <20260525113533.6405efa0@kernel.org>
Subject: Re: [PATCH net v2 0/7] net/handshake: anchor request lifetime to a pinned file
 reference
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291498-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9B8E35CFA5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, May 25, 2026, at 2:35 PM, Jakub Kicinski wrote:
> On Thu, 21 May 2026 10:47:06 -0400 Chuck Lever wrote:
>> Three things in this restructuring want a careful look.  In
>> handshake_complete(), the fput() of the request's file
>> reference has to come after hp_done() -- fput() can transitively
>> run handshake_sk_destruct() and free the request, so the patch
>> stashes hr_file in a local first.  handshake_sk_destruct()
>> itself is kept on purpose: it owns rhashtable removal and
>> kfree, and remains the backstop if a consumer path bypasses
>> handshake_complete() entirely.  Third, handshake_req_next() now
>> returns its request with an extra get_file() held under
>> hn_lock; accept_doit must consume that reference (FD_PREPARE on
>> success, explicit fput on the fdf.err path), and any future
>> caller has to honor the same contract.
>
> Sashiko indicates races with handshake_req_cancel() remain,
> and impact the code re-written by this series. What's your take?

I examined the v2 reviews over the weekend and reworked the series
to address those concerns. v3 was posted earlier today, but sashiko
has it marked embargoed at the moment.

I=E2=80=99m aware of a couple of pre-existing issues that are not addres=
sed,
as they are a bit out of scope.


--=20
Chuck Lever

