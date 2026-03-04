Return-Path: <netdev+bounces-263577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFyZFD6qp2lTjAAAu9opvQ
	(envelope-from <netdev+bounces-263577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 04:42:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA4F1FA79B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 04:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E51C6303D5C7
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 03:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58855375F73;
	Wed,  4 Mar 2026 03:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y7uEbuEs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D73644CF
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 03:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595769; cv=pass; b=XQNHxmdAFze1NvdHuIdn6PKY0prkcRuGg4UY8VT9CKKkyRWvzlffzIVqcYuVVqyTtUTwEJ7PiwTTkZreBWXgQY1KlB3ovuuywzOi573oDrtAVd8gRbsThaT+RccgDDAUm7cRrQajNb6iIlYnMTmvthWjmOkTidcFkywOMOyXZIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595769; c=relaxed/simple;
	bh=BMZ8+WwvHOo+DARZ7HAtbF14sxNv5XMh47hjsqNStAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N30WvdjyPiQasf0gTBJ5MJfP8Jx/pxozCCbtwXJlS/hyiTrckioQH8eOSHTsen+WSd24L+tuiArLKNtH7LRp/rNdXx7qOShMIG9OiQIVOqenL3UEHXHnxWpn1LAEod1E4RnWhfCOrieVi1m+6jO1I45QFY8IuEQWom1YXAKxyJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y7uEbuEs; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-127380532eeso1447752c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 19:42:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772595766; cv=none;
        d=google.com; s=arc-20240605;
        b=B/eHXmqosTxASNXv/McZfie3T8Lw/Ll+lbn24su4A3k+rX7vwwdrAzs5oegV2c5Wic
         drgsq9m+tY8poGE0+ILNRIinPs697kvy+KPuYoNXR39ROgj8uuedzcOXERaMCNMoCSwF
         0gusD1JOQ9yhASzKODFysFSo1CZ4SkiP+UXdypbJ758c0xdnNJS4a3/bzuFTEIA8gJ83
         7/MmXFC9yyKEst9OHGOS065lTfEKTZltBo0CwcQCYLnP2z3Q3ln3poncNcGwOORIF8dU
         /m7G1l7Lm4x7qDIrN7N8OYNfqId/L5jm315GNd36+O/NcLUnl6YclWAGkJxafB/c/wjN
         nq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qPRhEDMKlKWef+jdKZufOay/jK45cFzqGUCjfnB8wXM=;
        fh=stN00hlXptXC2HnWTmPdIo48m2M7co0Yp9WxFKJaVzc=;
        b=AuQgJO+b7DlrqTxqerLaq2Sf1bTWEOGmnXtf5jxjV+B8++9c0aPG55i4cKi7CuCggu
         eTSWIQmxNnHTnYTNk8d5cuiD4KDjHnxQ6bTO37mZE/WtKsnEbYhJlQVEfjFJD46k3jaW
         soO2SOxpGuAOwxX9jkgKinQb3jjqfHVl6nQDQ10rbe2FhJWRu1Tv/KtgR69bUrN7Vkpg
         TMBleMTUubqHHpnzC+PEUo6dqx40mHxApjC5HrHZ8PqyWvTLMS50KVh6xngdyNVFKARW
         WOLoBto8U8NU1Wy5NiZYPCVkPl5v60yWNZHaSx2suZYOTEGMjgxwyi87xHiyAYCsHQoJ
         k2xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772595766; x=1773200566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPRhEDMKlKWef+jdKZufOay/jK45cFzqGUCjfnB8wXM=;
        b=y7uEbuEsOgu8qYI5qMO+DCPF0ky0CN0w83dbTFV6/YRBNmiQw0cUXdNomoRP5ayAiM
         CyM8MQkvfwDgDnxL4S9srXwrFrZaxne5/NNvQrY3I2lA9YErrPVGARygSS3yGByzXvYC
         hqZiUNhf2VReTKActZwVXb64vsFkC7xdVAFuIWurS25mrYm4QXbBJQA5BU2uky6FT7Iy
         vtBAuk6eP6gdmbjxR/aXH1l7N5ISmmSiUDzdm4LLlkq2SBZboKfwlnzhsDgR3+OXBzar
         wRHMinbWK68tF/CqWqFV0Rfj9XhStRqx4C7RSLOyeOqDiZYS6/DT7UmJm564a3I3QLUh
         u9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595766; x=1773200566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qPRhEDMKlKWef+jdKZufOay/jK45cFzqGUCjfnB8wXM=;
        b=u0wnajIZ1jBVLj1aeo8fXoLlBSmhwfijrBkiTnELtlchz6fpbf+KL3Fco+njUV0UPI
         9knLJEPs5Dp6zoUPxG8uouAvzfTWTgJZEy7d5B1AV/+SyD6skRNmT1XhlxB3kqB1BaKf
         m9TwppBYSOU6Vnw7qZmMCSz2sXML1oBqVGMtq0MbT/HzZDwOA22uvWh/UdtUoPVzXhG2
         5dfY2W6KK/VUlYldevQpQOcLrpvQkbeIwO30/8Tny41UHyXc0IHaZMoA46o+wgpdXy+k
         2OsPGJbHOCqGO714023gvMvSR0uKA5qgTQVzszBLaWyydQV/4zO6yY0TmE6qNQJ+L5CA
         Z3TA==
X-Gm-Message-State: AOJu0YyYTeQ7iTX7RBUrrp9Fy10BCcwZBpQ4Rod68UOhkXfe1J11pj+i
	R6UIvNI8TslkzbGRdVKO/f04UahyiFyGLV5swSBwJml4K+wxsOgzdVlqPY0VU3SwWSl1z4zNZcL
	PfmYOArD9bny8C66LhybYdyyISVYSsIWK5HeWVO0l
X-Gm-Gg: ATEYQzy4DY+n6ADYBYh3ROElpWfZXSUh/fNdeNhh0ablLO9emjkheLu8YWF3DVFTxul
	BimgWuwp0szWottL4hGXS0L8shC0u+4um5Iu0ElQu9pMRLmVaLuvafNv+gCSA5qQIS82mLefWjA
	8uuAbf5vHr3dICWkjR5pSlFZQ89MvEFu3844jNz+/fkUWQ8z2ALD+8k39cvCcvQBYFAUWpQLIDk
	/iC2N87Wp0ypARY3rO33LYlPN7Uo3n94x7Hqxi5w8Fbo91IytcHzaOWbucLdqanQOmWq87izQJM
	GZcPr7e1lvwMRLStQFGu15YiU9JmUDG4fqDbLm/Sfv/Gu65u2F0p4Ws2cwhkxz3QHdAiJikB
X-Received: by 2002:a05:7022:6629:b0:127:9f6f:436f with SMTP id
 a92af1059eb24-128b70dc371mr183272c88.35.1772595765587; Tue, 03 Mar 2026
 19:42:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304031626.356955-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260304031626.356955-1-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Mar 2026 19:42:33 -0800
X-Gm-Features: AaiRm53iF5LrLKXCGdBpw_EH00x7Xj1qc8aeBLaTbHOapeWFVmD_rVyMt_gSLrU
Message-ID: <CAAVpQUBn7zmPvJB+P0pyD8BAaWdc+g3warvPjahYd_Qb7x54UQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: annotate data races around sk->sk_prot
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EDA4F1FA79B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263577-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 7:16=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> inet_sendmsg(), inet_recvmsg() and sock_common_recvmsg() access
> sk->sk_prot without lock_sock() or any other synchronization.
>
> sock_replace_proto() (used by sockmap), TLS and MPTCP can change
> sk->sk_prot under us, so these functions need READ_ONCE() to avoid
> load tearing.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/core/sock.c    | 2 +-
>  net/ipv4/af_inet.c | 8 ++++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index f4e2ff23d60e..79b659cebbb1 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3968,7 +3968,7 @@ int sock_common_recvmsg(struct socket *sock, struct=
 msghdr *msg, size_t size,
>  {
>         struct sock *sk =3D sock->sk;
>
> -       return sk->sk_prot->recvmsg(sk, msg, size, flags);
> +       return READ_ONCE(sk->sk_prot)->recvmsg(sk, msg, size, flags);
>  }
>  EXPORT_SYMBOL(sock_common_recvmsg);

None of users seems to be supported by SOCKMAP,
or am I missing something ?

include/net/sock.h:1963:int sock_common_recvmsg(struct socket *sock,
struct msghdr *msg, size_t size,
net/core/sock.c:3966:int sock_common_recvmsg(struct socket *sock,
struct msghdr *msg, size_t size,
net/core/sock.c:3973:EXPORT_SYMBOL(sock_common_recvmsg);
net/l2tp/l2tp_ip6.c:774: .recvmsg   =3D sock_common_recvmsg,
net/l2tp/l2tp_ip.c:645: .recvmsg   =3D sock_common_recvmsg,
net/ipv6/raw.c:1292: .recvmsg   =3D sock_common_recvmsg, /* ok */
net/ieee802154/socket.c:427: .recvmsg   =3D sock_common_recvmsg,
net/ieee802154/socket.c:989: .recvmsg   =3D sock_common_recvmsg,
net/phonet/socket.c:441: .recvmsg =3D sock_common_recvmsg,
net/phonet/socket.c:461: .recvmsg =3D sock_common_recvmsg,



>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index babcd75a08e2..e95ffa070568 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -852,11 +852,13 @@ EXPORT_SYMBOL_GPL(inet_send_prepare);
>  int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  {
>         struct sock *sk =3D sock->sk;
> +       const struct proto *prot;
>
>         if (unlikely(inet_send_prepare(sk)))
>                 return -EAGAIN;
>
> -       return INDIRECT_CALL_2(sk->sk_prot->sendmsg, tcp_sendmsg, udp_sen=
dmsg,
> +       prot =3D READ_ONCE(sk->sk_prot);
> +       return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udp_sendmsg,
>                                sk, msg, size);
>  }
>  EXPORT_SYMBOL(inet_sendmsg);
> @@ -882,11 +884,13 @@ int inet_recvmsg(struct socket *sock, struct msghdr=
 *msg, size_t size,
>                  int flags)
>  {
>         struct sock *sk =3D sock->sk;
> +       const struct proto *prot;
>
>         if (likely(!(flags & MSG_ERRQUEUE)))
>                 sock_rps_record_flow(sk);
>
> -       return INDIRECT_CALL_2(sk->sk_prot->recvmsg, tcp_recvmsg, udp_rec=
vmsg,
> +       prot =3D READ_ONCE(sk->sk_prot);
> +       return INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udp_recvmsg,
>                                sk, msg, size, flags);
>  }
>  EXPORT_SYMBOL(inet_recvmsg);
> --
> 2.43.0
>

