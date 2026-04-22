Return-Path: <netdev+bounces-280454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLx3Lrzo6Gl4RgIAu9opvQ
	(envelope-from <netdev+bounces-280454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:26:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D882447E19
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C451F3070ACE
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB19633C1B4;
	Wed, 22 Apr 2026 15:22:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 20.mo581.mail-out.ovh.net (20.mo581.mail-out.ovh.net [46.105.49.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB2332EBB
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.49.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871358; cv=none; b=AjnW3HNhaPbvtuAC2WqTEe/woRwIoOx9hQZQt8jXtzoPUghTT42E6qJE7YQvgZic1vNMgZ//R/9eYlZklRG0kT2Wh/ME3wbP/EdWEprHPLBZKCauuL6tplypAbUoqJdlg/VwuSBmvnSSeqf6xlTVYpK9MijZc27UdXI7jI6kUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871358; c=relaxed/simple;
	bh=sU3DTkNexIWUYOoGKggdnAW3V/g3KBQ/sxSUjVw7qsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIFlM0P3ihLlBKSN9Y4TIbufyea9/kW9VkBz2hyQlY0e5rXLZet2kxIl30lo/9+yNsjXw5Ht3Yioxp97eLBVGl6sB6rptEo1l1x04VzqYrhBCd8ipZmi1LYoQmR1bSY3TGUz/Y9tgPEfekGGinZyME5mDJYLiloE33jAbv5OhJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=46.105.49.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from director8.ghost.mail-out.ovh.net (unknown [10.110.0.129])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4g12mx2Dkfz5yXt
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 15:13:53 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-st2nk (unknown [10.111.182.110])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id ED9CAC0167;
	Wed, 22 Apr 2026 15:13:51 +0000 (UTC)
Received: from courmont.net ([37.59.142.100])
	by ghost-submission-7d8d68f679-st2nk with ESMTPSA
	id VRmGK6/l6GmGWQwAqxBLcg
	(envelope-from <remi@remlab.net>); Wed, 22 Apr 2026 15:13:51 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-100R003c8cb7736-6058-46d1-bedc-9cbb91f5e008,
                    14B14BC8C77B9486866D902178DE58E78B326C1C) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp:87.94.153.51
From: =?UTF-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>
To: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 Deepanshu Kartikey <kartikey406@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Deepanshu Kartikey <kartikey406@gmail.com>,
 syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: phonet: fix BUG_ON() in pn_socket_autobind()
Date: Wed, 22 Apr 2026 18:13:50 +0300
Message-ID: <2493746.XLGD3V4XZc@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20260422021533.16987-1-kartikey406@gmail.com>
References: <20260422021533.16987-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
x-ovh-tracer-id: 16551010105893405648
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG2Nb2IOQQkyz5XOn5WmFHmBuMkJ3XqXf6ad9mGrNbCaO5vLNMhM04cM+jxKuJtmN0KRoodhSstc9MGd0fOYBZZzM+/s4nCPL/HdASVvRW/qBBs+nQWABfSD6udFKGZhYh8xVuIebAhD4oiwfEe8OjSvOcd7Kvw16qWHOuQVybCI12Nu0uQUNH2QzKoMTDhqyAVXqEzd/p5UNY6RdwltP43xxGKoPXOdgqWkbux4TmFYAln0kXKleauKxX2nRBxuzgj/LeOGKha1sZm9lzrLYMbI+bZyyIZ8Te/qgwE1VGTfRN5i0qA+9JTSjI/aJWHAjShHhJXtj6U9PvMmpBAJCX3Kzt6RdZUJY4gypXWVMqg3oWo7kTlBoz+fq9vpXEYGwcZfmCJMkZm0NT27DPhKtPIgVLCDtw8inO877hJpkXTSxPZt330ODyNONdneWc2O+u+cC3PdXMNXIEQz/iJZJk3mh9t5uKvD7MlmzfOqtoHNW0zWYi659CHncBUyUXfM2WLZOhqFw8fJ046kTZzyl7r8/JG2pQhm+2goZ0O0yxbbNsgRgl2aHqqF337IPrBhnLFcoyH+vBPLY0RiFxf9gmwB4X1pENxgpU82MusWHpwqlGbJnkwxTLLg1Lkzv8M3mVRqieYFvaVpw6ZqnBdle01GdAxLyGDaOhYZLa7oIp42A
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-280454-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[remlab.net];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[remi@remlab.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,706f5eb79044e686c794];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 1D882447E19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Le keskiviikkona 22. huhtikuuta 2026, 5.15.33 It=C3=A4-Euroopan kes=C3=A4ai=
ka Deepanshu=20
Kartikey a =C3=A9crit :
> pn_socket_autobind() calls pn_socket_bind() and treats
> -EINVAL as a signal that the socket was already bound,
> then uses BUG_ON() to verify it:
>=20
>     if (err !=3D -EINVAL)
>         return err;
>     BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
>=20
> However, pn_socket_bind() returns -EINVAL in multiple
> cases:
>=20
>   1. address length too short
>   2. socket not in TCP_CLOSE state
>   3. socket already bound  <- only intended case
>=20
> When -EINVAL comes from cases 1 or 2, sobject is still
> zero (never assigned), causing BUG_ON to fire and crash
> the kernel.
>=20
> Fix this by checking the bound state directly via
> pn_port(sobject) BEFORE calling pn_socket_bind(),
> eliminating the ambiguous -EINVAL interpretation
> entirely.
>=20
> Reported-by: syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D706f5eb79044e686c794
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  net/phonet/socket.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/phonet/socket.c b/net/phonet/socket.c
> index c4af26357144..5a55e7d14e85 100644
> --- a/net/phonet/socket.c
> +++ b/net/phonet/socket.c
> @@ -204,14 +204,14 @@ static int pn_socket_autobind(struct socket *sock)
>  	struct sockaddr_pn sa;
>  	int err;
>=20
> +	if (pn_port(pn_sk(sock->sk)->sobject))
> +		return 0; /* socket was already bound */
> +

This was almost 20 years ago, but IIRC, we did not do it that way back then=
=20
because it results in a data race on sobject if another task binds the sock=
et=20
in parallel.
=20
>  	memset(&sa, 0, sizeof(sa));
>  	sa.spn_family =3D AF_PHONET;
>  	err =3D pn_socket_bind(sock, (struct sockaddr_unsized *)&sa,
>  			     sizeof(struct sockaddr_pn));
> -	if (err !=3D -EINVAL)
> -		return err;
> -	BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
> -	return 0; /* socket was already bound */
> +	return err;
>  }
>=20
>  static int pn_socket_connect(struct socket *sock, struct sockaddr_unsized
> *addr,


=2D-=20
=E5=BE=B7=E5=B0=BC-=E5=BA=93=E5=B0=94=E8=92=99=E2=80=A7=E9=9B=B7=E7=B1=B3
https://www.remlab.net/




