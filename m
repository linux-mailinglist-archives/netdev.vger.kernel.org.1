Return-Path: <netdev+bounces-299354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kESAChWvL2r+EQUAu9opvQ
	(envelope-from <netdev+bounces-299354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:51:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC82684530
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:51:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=r31U4Y69;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=fZrsm2y6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299354-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299354-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 896EB3018AD3
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC90279DC8;
	Mon, 15 Jun 2026 07:49:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E1846A
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:49:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509784; cv=none; b=hlvSxrRDYn2UovP7pRRZIkWmYl9xVAfdnF0rFiMHm/10ITKjuv5oXJuy8MYBGKzdgNDygCM3b/Xo+YT8nK1xI1Cxvr1aGtH1yeeWyJ6G2KijDHhGWSI58SV0aP3u4YSvTlnPuPT1PsXZCbl4dxE8pNWsx1HDGzZzPFEmsM4bGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509784; c=relaxed/simple;
	bh=c4JJMwSnvfimUOxJOCW2AajwGbpZVEmZqHtp8aFRfR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=roJpBhvTP4tM8L9Avlw8yH1QkYaXjXr5YOvVnXVeR7oT1Goc9fV+6znlNN/STQ0L9zPRnrZUADysSfMKp/nL4QKfKvhOditb/Jc4AalHuTmEyZIw8hHcsSdBDd76PiD8tLnS9m95t8iRAE7pc/ucG70OQerrwpJxW0doRQuwZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r31U4Y69; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fZrsm2y6; arc=none smtp.client-ip=193.142.43.55
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781509781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0tZ+vl0/oVDDbMO2Jy34aMtjK8zKupQMv0TXrkr5hs=;
	b=r31U4Y69rCu0Z3pPRyorUok3sUV15r6BC11GiUJLhqSda8Sl26klGe50s6rKJbzFJIy7by
	DGppGsl9pDNn8ahXONFznNVDaFcrjFBwGL1QIiXK6vxcNAbgpu1N7aYz5j2MlaWMOYqIRI
	WgtfqpnH4AWfCpwacacLPZXHHqOhprN/jKwzaP8iq3GMH9w6+cAMGPuAfqfPrDAjM6M+G+
	8pVRZas97HL+wLSxWsH0SIfGVkchjGqnXmeR6dcrKTHOGEwo0C2nKiFgRUTgcPLQLJiwcm
	B0tEgy7bVRX0n9wCPhRX9kGjWIdoXWIKSSxDXT8S/qWzpxoA+yhCE0Uy5VPoEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781509781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0tZ+vl0/oVDDbMO2Jy34aMtjK8zKupQMv0TXrkr5hs=;
	b=fZrsm2y6/Lom7XpFP23zlO/qZc6UihB7+BHq4zcz1AyVyjDPYy+0O7S5AqxRI1CMM+iK2O
	kRZ9av8VR6jBlDBA==
To: Jakub Kicinski <kuba@kernel.org>, anthony.l.nguyen@intel.com
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 ade@amicon.ru, dima.ruinskiy@intel.com, jacob.e.keller@intel.com,
 dish@amicon.ru, avigailx.dahan@intel.com
Subject: Re: [PATCH net-next 06/15] igb: Retrieve Tx timestamp from BH
 workqueue
In-Reply-To: <20260613164306.567d1cc6@kernel.org>
References: <20260609213559.178657-7-anthony.l.nguyen@intel.com>
 <20260612095742.662653-3-horms@kernel.org>
 <20260613164306.567d1cc6@kernel.org>
Date: Mon, 15 Jun 2026 09:49:40 +0200
Message-ID: <87zf0wi6p7.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299354-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:anthony.l.nguyen@intel.com,m:horms@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:ade@amicon.ru,m:dima.ruinskiy@intel.com,m:jacob.e.keller@intel.com,m:dish@amicon.ru,m:avigailx.dahan@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,jax.kurt.home:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FC82684530

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat Jun 13 2026, Jakub Kicinski wrote:
> On Fri, 12 Jun 2026 10:57:44 +0100 Simon Horman wrote:
>> >  		/* reschedule to check later */
>> > -		schedule_work(&adapter->ptp_tx_work);
>> > +		queue_work(system_bh_wq, &adapter->ptp_tx_work);=20=20
>>=20
>> [Severity: High]
>> If the hardware timestamp is not yet valid, won't this work item
>> unconditionally reschedule itself to system_bh_wq without delay?=20
>
> This sounds correct, the patch is basically busy polling from a tasklet.
> BH workqueue is not just another work queue.

Indeed, thanks for the report. Please, drop this patch for now. I'll get
an Intel 82576 NIC and see how this can be fixed.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmovrpQTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgkpuD/92xM3i+Fmq8JLdBqzZVzhHHPjT0qMP
zHPePSbTGvLiUfr+fFg8HU9N5nsmlzuvpvvvbK56DCGFOoqLccjyGjgKnNrr3b3N
IG+0P7icchqSgcYRoqDw12aaTaBjd3zfIktFp6L2qw3StsvHumhShqNUNeQAWxC3
3JRHcHxRbs7AFdOXXrHEx0Z3u8KnM2vuaeiIcISe9MHCjeYPXQhVXIF5skDybpbI
37uaQm3wR1ToL4++e7zS3ZhhPEobo7xJx/EmFis7tzQmwAUwHRVNyKH0u5/LfPCu
y/H1mJbxNbLy2zP/yg2jSesiF+oVp2F0piCr0QNNUeAO1wdeLlzpgquxflE0md8f
O6qTO0AWBOwsAR6spb4yT62lYh1bNdmdA8jM6cBSUVX9V2nPVYEDFQgvCmZlRX+f
puKil1ipeKL+3uqeqtL1Mlj0AcsC+Jx4KP5r1fQvT4U1AhdV4gYuLHXnRhlrCJze
SvsEuh6KwZYvf27xVrQBGOqR8TzxbYn7JbZlUEqVZzT5t9F20UOwVc3vltmsI7zc
UsatOAioPuMzZVArZE6BFEAC/4kr19W1RGEMMe0TJJzMrdt+6iuOWFfwLWVN+jcS
43mi1j6pgCzN4J/L3uWADQxWkihDjsZ5qaBDsII0Wx7yDWHbLfk5XivD96PFOqoo
piGpJnDU9r2LLQ==
=gmO8
-----END PGP SIGNATURE-----
--=-=-=--

