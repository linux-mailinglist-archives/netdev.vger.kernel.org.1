Return-Path: <netdev+bounces-272308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAdGDEPYxWnQCAUAu9opvQ
	(envelope-from <netdev+bounces-272308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:07:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D9133DB89
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57CF530479CE
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF5C25B1D2;
	Fri, 27 Mar 2026 01:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="hPzIoFJd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9EE2DB790
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774573598; cv=pass; b=GGcsL2sTB73iL7RaON0LwMIYF40jAuxmzkqtObLXHKVKBAybxHJWoaNKEmvKnHCeOoxjT2uggoQtrp8Acu0VrB58rnU6TpR+r+GPrayFD9QQdMHMDzCXGyc0ZcMUHo+tHUttg4psDrbdkITvhJXzcJfyjPiKstDGHIKm84EnzMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774573598; c=relaxed/simple;
	bh=+SRCyrUbaMimd/Aa0g9CjXoy6/PQTbHhk3tkhsnd2jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIJKsy63TJD6iJtOTDSR0Y7/8lkFw7OPCCF5DS3tBhScq2iGLuLYR9b2ZsOzd1frkIiLNCBnEIOLDnNIJ6HEqgirH6fkhiCLuAbrLQWBAmxLPgcChJdIkkKTOW6DcAatKuTf2PojzYe5gglkYddTCeOZWzFFj3FG3nfVq5HktUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=hPzIoFJd; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56cc6fe8815so711951e0c.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:06:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774573593; cv=none;
        d=google.com; s=arc-20240605;
        b=H7aMnbwMFxaTt72hobgba5eiykm+DgF62lSH3vgqHy7h/JU6SLYLw/rBiqv/vRevtU
         42gGsEfMwU0AR12+NrcAxwpUvOnNxlnefBA/xOtFBrLsBWx2STrzDnofGhAOpHJAEZCy
         AqLetEgVjJR62VBmEmcaDB9hsAJPWTF1cLhlgEV856EBGXKueWTuUu8e8AAZ60utXOQQ
         mWE9rC21ZaaMz7Bb77kuYX8DuP0sprBE1AxoRKPOqv2hxu7IJmhj5zITfx2WOlUh2z9h
         ob7gj/i0ddv7p8msQPxy95UlUkG2zaFgJZVvdryoBReA/pKdOwYgZyHV5z1afiE1UDz9
         5Jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a/j0+PViRHHjaQqa7PF5VSm6ctiXwCQqdeR9CJmtwlM=;
        fh=RA+Qa+ISJfkVmZv3hENIA3DHpb/w9nUFTEfJNneqZis=;
        b=V42cfTQ1Pzhu8MzNxw/YJt7hoC11i1z6e1UMrbitViKKPc1ROtPt4UGeNjJEpwGZrk
         HhENvu52HdHsdsHoGXVoTMUpIdtxr+PwteqD5hq9Q7MPiOC2J0sqNli6zJNkdxSfgh5K
         sL2FcS1FE+o1zaj337j4oJaXpwi9HY+aO+DUKj/hVxnCjQnQWaP0G/JEIhteBDG3oFiJ
         sf29lqaX134ChBLNAj1Buw9mtpmZT1gpGCYw/85FXb8zfLgHMczLp/RYClwJnMHuaL1I
         sqQDsgbUU6vkt1YLUBW9iyzsfs5QEIO+LEoEBNdO3oclIUnmU6eF8aoKoMiWSaFuAC6P
         AGXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1774573593; x=1775178393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/j0+PViRHHjaQqa7PF5VSm6ctiXwCQqdeR9CJmtwlM=;
        b=hPzIoFJd7F0teQ2wOWN3nlXaqvf0BkBtwbR0x618eYPL6rr3rZqrPT6dUlcXm1ZRUB
         rk0wgWBONDiB6QCkbO8s3CHq4+0UD7vbH0vdBlFXxNhoLNnZcJ3ApEV/r+ekyvSZI1ng
         ldHyRuO843R/JdS/hU6Ndoye0JeLNCyluZrMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774573593; x=1775178393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a/j0+PViRHHjaQqa7PF5VSm6ctiXwCQqdeR9CJmtwlM=;
        b=D7uMiaPPs9H3tqaX6MbemiNIliuz+m+ZgwTWE8ztzQi/4bRNMStSTbLHUMkvodoojk
         YjuNb5D+DaCLSY2+jNgRrkwA6DU27rt9A1p1po4GOifR0Fyf3MAkFUv6lkFizm5mcKRX
         bFbCMbUwmPJeroO4A+hojIC9QO0GyfWElmvjGftCvh7wGnuDTL6JfVE1NTU9cGiXmjsH
         BznkFQuIcw2xB7R/N4XLO3wT+xhtgJumI+EIhqa2s7gj33Z3LULrp/st/YRYI3JckLWx
         OvJVubYACOFzC+B6+yvMy0wtuIAwB2+vumszTwAUhF59pcg+Kk53jDw4ag/6MpfAicCE
         oT7A==
X-Gm-Message-State: AOJu0Yzj3Xs28WZvyoQdv0MA/D5Iux0fv0p0tezThJfRJcDUdOUSNvDX
	Rh/9ay34Ghbi/5xZ0FKWnaEdDKRpk3AOFdiMt3CfFwjoxYIhxae4Lpi+lqBRCSXCSUBdapmvkbs
	Jvd0T4C43Q9VJZwvb0qHw3pASagvDOhqHduu2iO/ifw==
X-Gm-Gg: ATEYQzyM5S+oClymLdd+3kzdsE57kqltvTK4mQ/pzq1XltQ3NET/vII5LRa7CjQ080O
	ECjbrQFe5/W88gOAIgjjNBc8x220yIBhLFnceRiheXnDOWOONVthXC310FBTchSHzIB65pnBACC
	7+ixmVnLwmUsJBlgIAa9cYPzfnJr83avMEoXjygceGhjWuVBbvYgBJf2vnxtMo8qobmYc7leucc
	F5GxmSA1NdbHRI1QFQyQwld5KTsW4aCAttTFPeSdYuKoLqqp+GnpoHMDDExmbFu0XhX8ZelR83o
	EPRDlqu5
X-Received: by 2002:a05:6122:e44b:b0:56b:7a5b:3cee with SMTP id
 71dfb90a1353d-56d4a5f8f00mr253297e0c.12.1774573593441; Thu, 26 Mar 2026
 18:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326131838.634095-1-dhowells@redhat.com> <20260326131838.634095-10-dhowells@redhat.com>
In-Reply-To: <20260326131838.634095-10-dhowells@redhat.com>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Thu, 26 Mar 2026 22:06:22 -0300
X-Gm-Features: AQROBzBSrApkqh5-RU3p-dW15R25sMpm0H938y9vFHuYqB4GYlfJMl-5uJ5Jc9c
Message-ID: <CAPhRvkw8eopbCei6XQY3Fi-nDk+FyuXUWs8ToQyHE9J229_v0Q@mail.gmail.com>
Subject: Re: [PATCH net v3 09/11] rxrpc: Fix keyring reference count leak in rxrpc_setsockopt()
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>, 
	Simon Horman <horms@kernel.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[allelesecurity.com,reject];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272308-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,davemloft.net:email,allelesecurity.com:dkim,allelesecurity.com:email,allelesecurity.com:url]
X-Rspamd-Queue-Id: 86D9133DB89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:19=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> From: Anderson Nascimento <anderson@allelesecurity.com>
>
> In rxrpc_setsockopt(), the code checks 'rx->key' when handling the
> RXRPC_SECURITY_KEYRING option.  However, this appears to be a logic error=
.
> The code should be checking 'rx->securities' to determine if a keyring ha=
s
> already been defined for the socket.
>
> Currently, if a user calls setsockopt(RXRPC_SECURITY_KEYRING) multiple
> times on the same socket, the check 'if (rx->key)' fails to block
> subsequent calls because 'rx->key' has not been defined by the function.
> This results in a reference count leak on the keyring.
>
> This patch changes the check to 'rx->securities' to correctly identify if
> the socket security keyring has already been configured, returning -EINVA=
L
> on subsequent attempts.
>
> Before the patch:
>
> It shows the keyring reference counter elevated.
>
> $ cat /proc/keys | grep AFSkeys1
> 27aca8ae I--Q--- 24469721 perm 3f010000  1000  1000 keyring   AFSkeys1: e=
mpty
> $
>
> After the patch:
>
> The keyring reference counter remains stable and subsequent calls return =
an
> error:
>
> $ ./poc
> setsockopt: Invalid argument
> $
>
> Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by=
 userspace and kernel both")
> Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org
> cc: stable@kernel.org
> ---
>  net/rxrpc/af_rxrpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
> index 0f90272ac254..0b7ed99a3025 100644
> --- a/net/rxrpc/af_rxrpc.c
> +++ b/net/rxrpc/af_rxrpc.c
> @@ -665,7 +665,7 @@ static int rxrpc_setsockopt(struct socket *sock, int =
level, int optname,
>
>                 case RXRPC_SECURITY_KEYRING:
>                         ret =3D -EINVAL;
> -                       if (rx->key)
> +                       if (rx->securities)
>                                 goto error;
>                         ret =3D -EISCONN;
>                         if (rx->sk.sk_state !=3D RXRPC_UNBOUND)
>

I am following this patchset along with sashiko's comments. This time,
it flagged this patch for an API order dependency. The setsockopt
RXRPC_SECURITY_KEY option checks for rx->securities before proceeding,
but after this change, the RXRPC_SECURITY_KEYRING option doesn't check
for rx->key. Consequently, it's possible to set both keys on a socket
depending on the setsockopt call order.

I noticed this and wondered about it before sending the patch, but I
decided to keep the patch as concise as possible rather than assuming
too much and potentially breaking code. To make the logic more
coherent, what if we check if (rx->key || rx->securities) in both
options and remove the rx->securities check from rxrpc_request_key()?

Based on my check, rxrpc_request_key() and rxrpc_server_keyring() are
only called by their setsockopt options. We could also add a comment
to rxrpc_request_key() and rxrpc_server_keyring() noting that key
validation should be handled by the caller. Is the -EINVAL error
appropriate for this case?

--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

