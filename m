Return-Path: <netdev+bounces-279166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMwGB0BS4Wl5rwAAu9opvQ
	(envelope-from <netdev+bounces-279166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 23:18:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA531414DCF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 23:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EFC530197DE
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A63837AA78;
	Thu, 16 Apr 2026 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PifkCV//"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E5374E6F;
	Thu, 16 Apr 2026 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776374332; cv=none; b=Ua2yKqq5xU3+71LEo9ezXCuc1P71s4HgBDM2w/lAuTmxomrX/VkQOI43w0iADCaaxmetSI1z5b9H/EJtA+QhvLQrX2L8bBVVMPWCQXSzSMK4uwKy1EmkVli79awaU1QL527j97SJW7wMDCF9N2QGICJ5tjlI0ai7M99upsDTo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776374332; c=relaxed/simple;
	bh=Ot/OP0n7GGNEXBiUyjbk6BVR9H1rqvpMKqIPKFie3m0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=pOSNhSc3PqkrqovQHkCM2zvqRqlk7IQ6/zZIeVTHN3uKRzXJEz7p1G6nDJlkY8VZAcnstE9SKFSNI9XGARNNI4rgcaADl2f1oLrA1zSIBebsvbKG1koMNwSv5Q3w7S15E1FlGCjCNvGzEXF3zuBSc87b+D56V/46uL8UEhWwNuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PifkCV//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802F6C2BCAF;
	Thu, 16 Apr 2026 21:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776374331;
	bh=Ot/OP0n7GGNEXBiUyjbk6BVR9H1rqvpMKqIPKFie3m0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PifkCV//P1Rjt0kI38wms0x542ZigsIYuDcPHIHoHvXTC9CHH8djgf6a7Xx0ef7bA
	 YXRkAIfRHsmwiRMhW8AAmQerDbwd0SVKUW8O3uqP0O7mRtNVeV1HmORPNvD+wSS1T5
	 1fSiD+9GFBgaxVUEfQJMIX2CkBlF+iJIVmbv2MyyhiiwMueyL/ZD6PZUV3gd8WDjlW
	 ZIq9crMHfMzEiMkHgl/4WWhXxcQjBo9wijLAadSZWZunnGViqHjE3s+pShQDekpjHY
	 oq6FGkFZYv9qJdBH3Zy8L93NAgblX0il+VK80X2LzvowPEWCWiVpgAapHpRCL5N0KE
	 AkHHg7dTX+d/g==
Date: Thu, 16 Apr 2026 23:18:42 +0200
From: Matthieu Baerts <matttbe@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	ncardwell@google.com, dsahern@kernel.org, martineau@kernel.org,
	geliang@kernel.org, daniel@iogearbox.net, kafai@fb.com,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, caoruide123@gmail.com, enjou1224z@gmail.com
Message-ID: <cb1c7e8e-2d64-4a2d-9862-e5c4f544144e@kernel.org>
In-Reply-To: <CAAVpQUDzh-dGsQpBCZjN3rUsoDc2QjzWh-o5yVWoBWDQNXbjmQ@mail.gmail.com>
References: <cover.1776149210.git.caoruide123@gmail.com> <86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com> <5f06a4e8-0b49-4119-94f9-3a8a1e430e0d@kernel.org> <CAAVpQUDzh-dGsQpBCZjN3rUsoDc2QjzWh-o5yVWoBWDQNXbjmQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] mptcp: hold subflow request owners when cloning
 reqsk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <cb1c7e8e-2d64-4a2d-9862-e5c4f544144e@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279166-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,lists.linux.dev,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fb.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AA531414DCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuniyuki,

Thank you for your reply!

16 Apr 2026 20:48:58 Kuniyuki Iwashima <kuniyu@google.com>:

> On Thu, Apr 16, 2026 at 10:45=E2=80=AFAM Matthieu Baerts <matttbe@kernel.=
org> wrote:
>>
>> Hi Ren,
>>
>> On 15/04/2026 11:31, Ren Wei wrote:
>>> From: Ruide Cao <caoruide123@gmail.com>
>>>
>>> TCP request migration clones pending request sockets with
>>> inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
>>> subflow_req->msk, but the cloned request does not take a new reference.
>>>
>>> Both the original and the cloned request can later drop the same msk in
>>> subflow_req_destructor(), and a migrated request may keep a dangling ms=
k
>>> pointer after the original owner has already been released.
>>>
>>> Add a request_sock clone callback and let MPTCP grab a reference for cl=
oned
>>> subflow requests that carry an msk. This keeps ownership balanced acros=
s
>>> both successful migrations and failed clone/insert paths without changi=
ng
>>> other protocols.

(...)

>>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection=
_sock.c
>>> index e961936b6be7..140a9e96ad58 100644
>>> --- a/net/ipv4/inet_connection_sock.c
>>> +++ b/net/ipv4/inet_connection_sock.c
>>> @@ -954,6 +954,9 @@ static struct request_sock *inet_reqsk_clone(struct=
 request_sock *req,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sk->sk_protocol =3D=3D IPPROTO_TCP &=
& tcp_rsk(nreq)->tfo_listener)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
>>
>> (Maybe TCP with fastopen could be this other user to call
>> rcu_assign_pointer()? (net-next material))
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (req->rsk_ops->init_clone)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 req->rsk_ops->init_clone(req, nreq);
>
> I think a simple direct call is better.
>
> #ifdef CONFIG_MPTCP
> =C2=A0=C2=A0=C2=A0 if (tcp_rsk(req)->is_mptcp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_reqsk_clone(nreq);
> #endif

Fine by me!

I guess it is needed to check the protocol, similar to what is fine with
TFO above:

=C2=A0 if (sk->sk_protocol =3D=3D IPPROTO_TCP) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if TFO
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if MPTCP (+ifdef)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
=C2=A0 }

Cheers,
Matt

