Return-Path: <netdev+bounces-266028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOwFG2QCsGnOeQIAu9opvQ
	(envelope-from <netdev+bounces-266028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:37:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F524B1EA
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40E7F30D8618
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA11438A71E;
	Tue, 10 Mar 2026 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iaqdFc3R"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F483876D0
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142121; cv=none; b=lZUvlyJcj9klIiZjx0dx3WJDf9kBNjM11b84FuZE89Ht/si2XgwY1/tgzBMtS1OZQhoiHDOxRnpCc+hfRwlm/zQmoDDezZnrrHYzon/3LLfiHWblDKBPOwfoDL6349JYcNmzuaJ1SGvmFI/GBha9ir8d22wDn44X2kl53nT4b1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142121; c=relaxed/simple;
	bh=KQqnhr6YlAa/gpy+sTU5GHwCZhZ6qW8rmLEx/uTsI6M=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=fxmqUmJ9fTZ1W6yEjEmjN6DmNlxx0EDbUoPSbrLBwqtBOt1jx+v7EaMEnSj5nGUwPXPIdOz2FMnnrDKmgYZ/b5owksXxBRO9I2QcmlR9G+IPJqwdTZXB0a73bj/FE3YCWgOUHWaA9TmbVneNxSHQ0xgFVIovORNLMjrobPVpO2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iaqdFc3R; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773142108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEgXSRi8An7XY2t213VJlqkfT5N4BKHBSmPFM54cjbw=;
	b=iaqdFc3RsLQKWQKQN/Dj5JCr7ZNoeWvtHZhT7DR5h1QYm2oa4XgZvbw4/kPBEWPd89jzwA
	0gP34tz/uVYgVBFIgPMRmTV3V7rgQhBJ19wM5DjxuFlL1/L572bIg2VeFVMWWrBNrZQNMx
	LClaA0J8SKfUHY/P7jBfYRlDUzZRa50=
Date: Tue, 10 Mar 2026 11:28:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <215d34adafe389a6792b2ca111ac3ec7ccc079ca@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v1] net/rose: fix NULL pointer dereference in
 rose_transmit_link on reconnect
To: "Eric Dumazet" <edumazet@google.com>
Cc: netdev@vger.kernel.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+d00f90e0af54102fb271@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Kees Cook"
 <kees@kernel.org>, "Takamitsu Iwai" <takamitz@amazon.co.jp>, "Pwnverse"
 <stanksal@purdue.edu>, "Ingo Molnar" <mingo@kernel.org>,
 linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CANn89iL3g7+MpkDrY8-v+Zswy5Woe_VvEMqbvHYRxQGpk_OSEQ@mail.gmail.com>
References: <20260310101349.50993-1-jiayuan.chen@linux.dev>
 <CANn89iL3g7+MpkDrY8-v+Zswy5Woe_VvEMqbvHYRxQGpk_OSEQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: DC7F524B1EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266028-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,d00f90e0af54102fb271];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,syzkaller.appspot.com:url,appspotmail.com:email,linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

March 10, 2026 at 18:24, "Eric Dumazet" <edumazet@google.com mailto:eduma=
zet@google.com?to=3D%22Eric%20Dumazet%22%20%3Cedumazet%40google.com%3E > =
wrote:


>=20
>=20On Tue, Mar 10, 2026 at 11:14 AM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>=20
>=20>=20
>=20> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20
>=20>  syzkaller reported a bug [1], and the reproducer is available at [=
2].
> >=20
>=20>  When rose_connect() is called a second time on an already-connecti=
ng
> >  socket, it overwrites rose->neighbour with the result of rose_get_ne=
igh()
> >  without releasing the previous reference. If rose_get_neigh() return=
s
> >  NULL, the socket is left in an inconsistent state: rose->state remai=
ns
> >  ROSE_STATE_1 from the first connect while rose->neighbour is NULL.
> >=20
>=20>  When the socket is subsequently closed, rose_release() sees ROSE_S=
TATE_1
> >  and calls rose_write_internal() -> rose_transmit_link(skb, NULL), ca=
using
> >  a NULL pointer dereference when accessing neigh->loopback.
> >=20
>=20>  Fix this by:
> >  1. Releasing the old neighbour reference before attempting a reconne=
ct
> >  2. Resetting rose->state to ROSE_STATE_0 before the new connect atte=
mpt,
> >  so a failure leaves the socket in a clean state
> >  3. Setting rose->neighbour to NULL in all error paths after
> >  rose_neigh_put() to prevent use-after-free on subsequent reconnects
> >=20
>=20>  [1] https://syzkaller.appspot.com/bug?extid=3Dd00f90e0af54102fb271
> >  [2] https://gist.github.com/mrpre/9e6779e0d13e2c66779b1653fef80516
> >=20
>=20>  Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >  Reported-by: syzbot+d00f90e0af54102fb271@syzkaller.appspotmail.com
> >  Closes: https://lore.kernel.org/all/69694d6f.050a0220.58bed.0027.GAE=
@google.com/T/
> >  Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >  ---
> >  net/rose/af_rose.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
>=20Normally, a connect() on a socket already connected should return an =
error.
>=20
>=20disconnect is a special operation involving AF_UNSPEC
>=20
>=20man connect
> ...
>  Some protocol sockets (e.g., TCP sockets as well as datagram
> sockets in the UNIX and Internet domains) may dissolve the association
> by
>  connecting to an address with the sa_family member of sockaddr
> set to AF_UNSPEC; thereafter, the socket can be connected to another
> ad=E2=80=90
>  dress. (AF_UNSPEC is supported since Linux 2.2.)
>

Thanks for pointing this out. I should have checked the man page earlier.

diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 841d62481048..ba56213e0a2a 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -811,6 +811,11 @@ static int rose_connect(struct socket *sock, struct =
sockaddr_unsized *uaddr, int
                goto out_release;
        }

+       if (sk->sk_state =3D=3D TCP_SYN_SENT) {
+               err =3D -EALREADY;
+               goto out_release;
+       }
+
        sk->sk_state   =3D TCP_CLOSE;
        sock->state =3D SS_UNCONNECTED;


Tested and the panic is gone. Will send v2 after the cool-down period.

