Return-Path: <netdev+bounces-263615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNIsDAPcp2kRkQAAu9opvQ
	(envelope-from <netdev+bounces-263615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:15:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 849FE1FB729
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA51F3018D7A
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B95136D4E5;
	Wed,  4 Mar 2026 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cgq8sdP+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACB2364948
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608329; cv=pass; b=oSRClrEpLZXXyUNAt/Wn44owdXbu1fVcnb3pFzqo5gO9/LScmm1elJ8aHW7e3NARSwQQdO9FzKjxwF9lRfmxZb0Ag18WLMY7JoCqjSfUkbLk3Y1ucTO9ZlwUCY2uErX7sd3CFTFKOHrd+A4SsItLUv8at/d3vbwU1wwg5Z5ew5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608329; c=relaxed/simple;
	bh=S42nxpf2vyFeGVg/1apMy54suE56EafKYScUH1/h7nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuAcUF6gbLenbp6zytl/Er927dq+xyoHM8DgFXPQn/UVzmPo2jyivluwlzcHIoPVC0QSmkoIlOkeO1mioXP5eXu2rcxG172g9Cr/q2T1o0gnjnrhAl0629sTYnC4iexoi1WT19CIM0vLqD9U2mOvVbL77Sc4C3aKs/o+X66cmGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cgq8sdP+; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a23cf08e0so21021631fa.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 23:12:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772608325; cv=none;
        d=google.com; s=arc-20240605;
        b=NKve93UikFCY1wQeNbQbiNngyv76fKaXRkl0frFq71gZMSVEF9rj9gHI5GgvS+P3fv
         csBj0QYfCr+lcomrPjVSTCFLAPpycpKM40TZijhoKqw2FxUYSvtD0akxLEKOWQZxT9cY
         jRkMkpcQAP8N6NrkwD07LFuwdrd+yH0U9+8HAHCl1WICDnL+i4Cj+Y0SC3haZHbe6Pf3
         1tgkYFlIdKTyXJ4RwADzujOdaPMB7JYnloe3lOCnPY333m8eF/ZDB0mshTTTWwq5N9rZ
         jBvJgpbWXMfDsOWpDg6A1x8bp8jHKAKBsBHOR9Wasyh3mMn5ygcECyjxuPDmOGYgwF6e
         eshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YgkN6svd9VZ3fa/mTr1q1azCw6Pvya2/98BHswww60I=;
        fh=qGJyNuBVWwAWkhzAWqBSnF0jHp2z/IPzXsNZLEwupkI=;
        b=bLmNJh1ZeWvzklfJrIY602nPpaFUM1kKkt2OIwVS8LrgiluPtbEwIsnR0cu6ehDfkm
         7Ol9nwKab2jD5e0zbpwmuG8KbhlcuKlMST2WFLJKtxNCOZH1Ne3bPz/c5W8QSDuso27x
         63ZLtGVY6SPvnK1dH+KC4Qdb1prJTc352pd6/NRs5vV9Iq6rnBFv5ih1QWzmKdbstC69
         vibGMV7vC0s5HzdiIIC0MFC9pj60JFD1Af7uPxt+gZhFk2Xvpwsd5VQjL2djJEZm0QCq
         wdXqmMDXpqiqnawKEImEcCDG60edSftYIUZT4Sc4HaSqpOnfoY8Cgvnz9X4+El1FlHy0
         acmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772608325; x=1773213125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgkN6svd9VZ3fa/mTr1q1azCw6Pvya2/98BHswww60I=;
        b=Cgq8sdP+CQXIBdXjgqoB/zYA6v4hNIvFNn0Z1AE8HTWJeK8wHKrw4Jy4GT3ohdrCzT
         zYeGnvy1jnWFXPYvoVI5e29J5T3WZn37Xsod9AWRvQMY7mfPfSGUUKrnEfSEqKHwQOQ4
         Qgt/i3peeMXJpN+4dwGxHIUgRrOVAxrur7SF04TOe4kysRXGOfRtBILxAgZuhoe+BG0f
         3rNurSzHYZFwhtL4i/RwN15EIcbH3TV/LGTbau0m/yHFhSfcqBqzqJD4bO5lolrVJkvv
         Z/kEl1Czpe2u+qBqjKUtl+i0GJqASFltd7dxl6Thbf+vVQlMRUgYPf4IxnAf1DP8uAqW
         wIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608325; x=1773213125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YgkN6svd9VZ3fa/mTr1q1azCw6Pvya2/98BHswww60I=;
        b=RP89lwhzoaiDWm46a9hT42V1W1VcPRREt4u4k1qHYIPfcVAvtTzID1czpq0y29URR3
         1Not7aACgzn5bkiSelPFXcjkBgMMritv/q2s0XZH094E1JLMGYb+YobzvqZsqEFQMwpf
         W4Z5DUN8phzZfCUi33d5zVJ2+tKWJmdSFN1ZnzSFhnDq8b6cSAwl61lxqZrHxT290fG1
         auwk2Za+wgpJl+P75YezgXg6qOBMgosWX960gmVQrQYqrBTRkrxYJ+trVoi325JfjeAK
         Ec6CqyuNxhcfpxPlvFyvmAhMoPI+cq+L48KFQZsntef3BoCuE4HoQ9KkumRwIt0klKLa
         fYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoiItS6XKD0x6ahzwpO655vlHZfyx9oQSSjXZMHa00QU3KiQ7llkdL1Y0X+IYO7zpOkf5lhrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywvOgnROYRcij8l+6ir6vqJ40fMENHZgaP5zF6YFb5CEtyZmyA
	pHogpNIB2sEiVOwvTw/9cTB01PHrHSqxobkHvq06U4NPDmfA3RFoJ7O2GO0YKjoFZg7jxXvKTWp
	8p2aztUJvmXzs/BrJoSkHaOPgKFC07g0=
X-Gm-Gg: ATEYQzx3MVbN+kRaczuovs+goOk6S6xt//mbeDt5y4hPT61b6/bPFsTRzN7xF6cAcDq
	UYuNyNgOzA6QfUWsZoFc2xcwF1BdOvsGFkYySc58D11+sqC8vikUUQ/4vdN5XglnZ/JgTdmPX87
	1AR5HUreoE0BulLZNsVOveLpgfBu9SHKp48kh73H1uGlUNVyiBs07qvUjE0m7Nrz+Zowvme6HlC
	//P9jyTPDkVOKlM8QgUx572AzzhBsu9EhdPitvPe2h+W5qoygHD5lEUIq1RoDmbJHlQdFTxB9G7
	Rjh5/0+J
X-Received: by 2002:a05:651c:440a:10b0:389:e6d4:e7cb with SMTP id
 38308e7fff4ca-38a2c6af5b4mr7145821fa.22.1772608325093; Tue, 03 Mar 2026
 23:12:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304012747.881644-1-edumazet@google.com>
In-Reply-To: <20260304012747.881644-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 4 Mar 2026 15:11:26 +0800
X-Gm-Features: AaiRm50Psj7-GF7E8fJWRIYTDUOsL7y3u0NcUD7I2NwQiwBLpNIjpiJUXEuAe7o
Message-ID: <CAL+tcoC=0mGFBiOpo4Zbf5u3CkJRkp55x6sqFy47yeAbTECO2w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: use ktime_t in struct scm_timestamping_internal
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 849FE1FB729
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263615-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 9:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Instead of using struct timespec64 in scm_timestamping_internal,
> use ktime_t, saving 24 bytes in kernel stack.
>
> This makes tcp_update_recv_tstamps() small enough to be inlined.
>
> The ktime_t -> timespec64 conversions happen after socket lock
> has been released in tcp_recvmsg(), and only if the application
> requested them.
>
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux
> add/remove: 0/2 grow/shrink: 5/4 up/down: 146/-277 (-131)
> Function                                     old     new   delta
> tcp_zerocopy_receive                        2383    2425     +42
> mptcp_recvmsg                               1565    1607     +42
> tcp_recvmsg_locked                          3797    3823     +26
> put_cmsg_scm_timestamping64                  131     149     +18
> put_cmsg_scm_timestamping                    131     149     +18
> __pfx_tcp_update_recv_tstamps                 16       -     -16
> do_tcp_getsockopt                           4024    4006     -18
> tcp_recv_timestamp                           474     430     -44
> tcp_zc_handle_leftover                       417     371     -46
> __sock_recv_timestamp                       1087    1031     -56
> tcp_update_recv_tstamps                       97       -     -97
> Total: Before=3D25223788, After=3D25223657, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  include/linux/socket.h |  2 +-
>  include/net/tcp.h      | 11 ++++++--
>  net/core/scm.c         | 12 ++++++---
>  net/ipv4/tcp.c         | 61 +++++++++++++++---------------------------
>  net/socket.c           | 23 ++++++++--------
>  5 files changed, 51 insertions(+), 58 deletions(-)
>
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index ec715ad4bf25f5f759d2cab3c6b796fed84df932..ec4a0a0257939a5363c55bed3=
ccb20182965b2e3 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -415,7 +415,7 @@ struct __kernel_timespec;
>  struct old_timespec32;
>
>  struct scm_timestamping_internal {
> -       struct timespec64 ts[3];
> +       ktime_t ts[3];
>  };
>
>  extern void put_cmsg_scm_timestamping64(struct msghdr *msg, struct scm_t=
imestamping_internal *tss);
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 9cf8785ef0b42460a2389b4aa75570b3aa31cbb4..fea6081cf6c798fe5f3f3b3ab=
3335619d7324f6e 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -503,8 +503,15 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg,=
 size_t len,
>                 int flags);
>  int tcp_set_rcvlowat(struct sock *sk, int val);
>  int tcp_set_window_clamp(struct sock *sk, int val);
> -void tcp_update_recv_tstamps(struct sk_buff *skb,
> -                            struct scm_timestamping_internal *tss);
> +
> +static inline void
> +tcp_update_recv_tstamps(struct sk_buff *skb,
> +                       struct scm_timestamping_internal *tss)
> +{
> +       tss->ts[0] =3D skb->tstamp;
> +       tss->ts[2] =3D skb_hwtstamps(skb)->hwtstamp;
> +}
> +
>  void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
>                         struct scm_timestamping_internal *tss);
>  void tcp_data_ready(struct sock *sk);
> diff --git a/net/core/scm.c b/net/core/scm.c
> index a29aa8fb8065665f8a8f2255ec3e55df973a6b0a..eec13f50ecaf6fa7caf9316bf=
17ab401d98d0efc 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -318,8 +318,10 @@ void put_cmsg_scm_timestamping64(struct msghdr *msg,=
 struct scm_timestamping_int
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(tss.ts); i++) {
> -               tss.ts[i].tv_sec =3D tss_internal->ts[i].tv_sec;
> -               tss.ts[i].tv_nsec =3D tss_internal->ts[i].tv_nsec;
> +               struct timespec64 tv =3D ktime_to_timespec64(tss_internal=
->ts[i]);
> +
> +               tss.ts[i].tv_sec =3D tv.tv_sec;
> +               tss.ts[i].tv_nsec =3D tv.tv_nsec;
>         }
>
>         put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPING_NEW, sizeof(tss), &tss)=
;
> @@ -332,8 +334,10 @@ void put_cmsg_scm_timestamping(struct msghdr *msg, s=
truct scm_timestamping_inter
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(tss.ts); i++) {
> -               tss.ts[i].tv_sec =3D tss_internal->ts[i].tv_sec;
> -               tss.ts[i].tv_nsec =3D tss_internal->ts[i].tv_nsec;
> +               struct timespec64 tv =3D ktime_to_timespec64(tss_internal=
->ts[i]);
> +
> +               tss.ts[i].tv_sec =3D tv.tv_sec;
> +               tss.ts[i].tv_nsec =3D tv.tv_nsec;
>         }
>
>         put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPING_OLD, sizeof(tss), &tss)=
;
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 1790d2fa75ade77cda8d0a593e689ea4432734dd..3d77d90c14fe13777d17563e1=
7596066c44c66bd 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1871,20 +1871,6 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
>  }
>  EXPORT_IPV6_MOD(tcp_set_rcvlowat);
>
> -void tcp_update_recv_tstamps(struct sk_buff *skb,
> -                            struct scm_timestamping_internal *tss)
> -{
> -       if (skb->tstamp)
> -               tss->ts[0] =3D ktime_to_timespec64(skb->tstamp);
> -       else
> -               tss->ts[0] =3D (struct timespec64) {0};
> -
> -       if (skb_hwtstamps(skb)->hwtstamp)
> -               tss->ts[2] =3D ktime_to_timespec64(skb_hwtstamps(skb)->hw=
tstamp);
> -       else
> -               tss->ts[2] =3D (struct timespec64) {0};
> -}
> -
>  #ifdef CONFIG_MMU
>  static const struct vm_operations_struct tcp_vm_ops =3D {
>  };
> @@ -2376,22 +2362,23 @@ void tcp_recv_timestamp(struct msghdr *msg, const=
 struct sock *sk,
>  {
>         int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
>         u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> -       bool has_timestamping =3D false;
>
> -       if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
> +       if (tss->ts[0]) {
>                 if (sock_flag(sk, SOCK_RCVTSTAMP)) {
> +                       struct timespec64 tv =3D ktime_to_timespec64(tss-=
>ts[0]);
> +
>                         if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
>                                 if (new_tstamp) {
>                                         struct __kernel_timespec kts =3D =
{
> -                                               .tv_sec =3D tss->ts[0].tv=
_sec,
> -                                               .tv_nsec =3D tss->ts[0].t=
v_nsec,
> +                                               .tv_sec =3D tv.tv_sec,
> +                                               .tv_nsec =3D tv.tv_nsec,
>                                         };
>                                         put_cmsg(msg, SOL_SOCKET, SO_TIME=
STAMPNS_NEW,
>                                                  sizeof(kts), &kts);
>                                 } else {
>                                         struct __kernel_old_timespec ts_o=
ld =3D {
> -                                               .tv_sec =3D tss->ts[0].tv=
_sec,
> -                                               .tv_nsec =3D tss->ts[0].t=
v_nsec,
> +                                               .tv_sec =3D tv.tv_sec,
> +                                               .tv_nsec =3D tv.tv_nsec,
>                                         };
>                                         put_cmsg(msg, SOL_SOCKET, SO_TIME=
STAMPNS_OLD,
>                                                  sizeof(ts_old), &ts_old)=
;
> @@ -2399,41 +2386,37 @@ void tcp_recv_timestamp(struct msghdr *msg, const=
 struct sock *sk,
>                         } else {
>                                 if (new_tstamp) {
>                                         struct __kernel_sock_timeval stv =
=3D {
> -                                               .tv_sec =3D tss->ts[0].tv=
_sec,
> -                                               .tv_usec =3D tss->ts[0].t=
v_nsec / 1000,
> +                                               .tv_sec =3D tv.tv_sec,
> +                                               .tv_usec =3D tv.tv_nsec /=
 1000,
>                                         };
>                                         put_cmsg(msg, SOL_SOCKET, SO_TIME=
STAMP_NEW,
>                                                  sizeof(stv), &stv);
>                                 } else {
> -                                       struct __kernel_old_timeval tv =
=3D {
> -                                               .tv_sec =3D tss->ts[0].tv=
_sec,
> -                                               .tv_usec =3D tss->ts[0].t=
v_nsec / 1000,
> +                                       struct __kernel_old_timeval otv =
=3D {
> +                                               .tv_sec =3D tv.tv_sec,
> +                                               .tv_usec =3D tv.tv_nsec /=
 1000,
>                                         };
>                                         put_cmsg(msg, SOL_SOCKET, SO_TIME=
STAMP_OLD,
> -                                                sizeof(tv), &tv);
> +                                                sizeof(otv), &otv);
>                                 }
>                         }
>                 }
>
> -               if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> +               if (!(tsflags & SOF_TIMESTAMPING_SOFTWARE &&
>                     (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> -                    !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER)))
> -                       has_timestamping =3D true;
> -               else
> -                       tss->ts[0] =3D (struct timespec64) {0};
> +                    !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))))
> +                       tss->ts[0] =3D 0;
>         }
>
> -       if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
> -               if (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
> +       if (tss->ts[2]) {
> +               if (!(tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
>                     (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||
> -                    !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER)))
> -                       has_timestamping =3D true;
> -               else
> -                       tss->ts[2] =3D (struct timespec64) {0};
> +                    !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))))
> +                       tss->ts[2] =3D 0;
>         }
>
> -       if (has_timestamping) {
> -               tss->ts[1] =3D (struct timespec64) {0};
> +       if (tss->ts[0] | tss->ts[2]) {

Maybe use tss->ts[0] || tss->ts[2]? It's a bit weird to use a single |
as to readability.

> +               tss->ts[1] =3D 0;
>                 if (sock_flag(sk, SOCK_TSTAMP_NEW))
>                         put_cmsg_scm_timestamping64(msg, tss);
>                 else
> diff --git a/net/socket.c b/net/socket.c
> index 05952188127f5bce41494e99e86418249e9022f2..68829d09bcf1468dee49864c5=
e4ea52362c3c6c7 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -912,11 +912,10 @@ void __sock_recv_timestamp(struct msghdr *msg, stru=
ct sock *sk,
>  {
>         int need_software_tstamp =3D sock_flag(sk, SOCK_RCVTSTAMP);
>         int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
> -       struct scm_timestamping_internal tss;
> -       int empty =3D 1, false_tstamp =3D 0;
>         struct skb_shared_hwtstamps *shhwtstamps =3D
>                 skb_hwtstamps(skb);
> -       int if_index;
> +       struct scm_timestamping_internal tss;
> +       int if_index, false_tstamp =3D 0;
>         ktime_t hwtstamp;
>         u32 tsflags;
>
> @@ -961,12 +960,12 @@ void __sock_recv_timestamp(struct msghdr *msg, stru=
ct sock *sk,
>
>         memset(&tss, 0, sizeof(tss));
>         tsflags =3D READ_ONCE(sk->sk_tsflags);
> -       if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> -            (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> -             skb_is_err_queue(skb) ||
> -             !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
> -           ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
> -               empty =3D 0;
> +       if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> +           (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> +           skb_is_err_queue(skb) ||
> +           !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER)))
> +               tss.ts[0] =3D skb->tstamp;
> +
>         if (shhwtstamps &&
>             (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
>              (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||
> @@ -983,15 +982,15 @@ void __sock_recv_timestamp(struct msghdr *msg, stru=
ct sock *sk,
>                         hwtstamp =3D ptp_convert_timestamp(&hwtstamp,
>                                                          READ_ONCE(sk->sk=
_bind_phc));
>
> -               if (ktime_to_timespec64_cond(hwtstamp, tss.ts + 2)) {
> -                       empty =3D 0;
> +               if (hwtstamp) {
> +                       tss.ts[2] =3D hwtstamp;
>
>                         if ((tsflags & SOF_TIMESTAMPING_OPT_PKTINFO) &&
>                             !skb_is_err_queue(skb))
>                                 put_ts_pktinfo(msg, skb, if_index);
>                 }
>         }
> -       if (!empty) {
> +       if (tss.ts[0] | tss.ts[2]) {

Same here.

Thanks,
Jason

>                 if (sock_flag(sk, SOCK_TSTAMP_NEW))
>                         put_cmsg_scm_timestamping64(msg, &tss);
>                 else
> --
> 2.53.0.473.g4a7958ca14-goog
>
>

