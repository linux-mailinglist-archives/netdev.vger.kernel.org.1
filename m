Return-Path: <netdev+bounces-291026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d0wTFfEmEWqxhwYAu9opvQ
	(envelope-from <netdev+bounces-291026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 06:02:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BA75BD0DC
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 06:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5B643008449
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874CA2D3EF2;
	Sat, 23 May 2026 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GgFqMgCf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68922343890
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779508971; cv=pass; b=AOPuVkKeECNDlkX4xSrpD3l6PhrlK/obxHPdTZjurmc5SrbmFTUph73fArZBpIdsNoQ7tVXNRLG5AxAkHdzupFj2TewzE6YtIY96XOrxJAcuz268YMVLl6OR8ugkTL0G/wjHe2CEJ8O+Uq35Y5vzXljc3HD0YSpGaLDfv3UUWUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779508971; c=relaxed/simple;
	bh=GH6jsum6yrwocICvHo0YbtF4U4fWpG/NcOYCkZzRxYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2WOdbTgNfbBDv+2mRVXwHULqa0T3TBf2inoDi+TNu8DJI+3kzLL7UFXwjzIDGp8UXs8iSGo8Q6xWX6zcHGSs2boa3/+OE39VlN9PkYc4ZYtiHoJc3jUZB4Tlqh6y8E26mqX8FaWEGUk3ufJz+EG2aQNFeEx4as6WtAx2Qj5GaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GgFqMgCf; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1334825de43so7088610c88.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 21:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779508968; cv=none;
        d=google.com; s=arc-20240605;
        b=C3qgwSZr/unDDGiRIMGqS+raxNu5LDREbn9wOmFScEz26AxcReZUZ/enwVkwJFE4pw
         nwtx3iHhE1AF6umsw/B7BJIyNvoJ6zm+0L9e56v8cHONj+h4JE0US/OtQ0+lbDkCab1c
         D41GDYiH5swmP2RblTyMC687NeGIcG1yPaCW12PD1NBNlqTSljAURlOFkIiWIcI+7IWI
         WfKu501ppM9uOAGioAOpoCvPs7mKX8NOim0lQpJWX9mhwx9e2fC7XQqzSdLJ6smo55aQ
         oJnIfduyQR1gx6Vn+mY4tcwgX0OS0VE2Vb6+wWGFxomhbZYXKQpw4ZSIEjNjNHcyZ6uD
         kzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3xcYPdDxJYzV/CmKiBG3CG1YIl4gZbm9+IKFFewBuVc=;
        fh=I+xobC6QkSVfoWRpJk4ZZMJUmyt0U4af6PGVfWamxBU=;
        b=C64nyNX9gF+jLSiw/zn5Vt3tUiUwq9wlD9L/LTIhkOou+KJFnrBHCJ0PWtRqGlPd1+
         vIlX8nAtSsh+4QKofJ+uJJXBR/7vmcCNZKLrlHTTVBuCDb9SZhaNgpuverKkXdtvWYij
         ZuDKHC/bI+8tZbNofW+4vu5AAiawuFPhFnibBrXiLHrnvW0+sBLnkj+0/4cnDKCdLzut
         jxMO8tg9sB3TvXsa+cP6jAuaXoRm7gbew9M4zJuErKchiMjjCvE5ckLYpc/eqW7hl7FB
         S6Pghxp4YfVRPtp3VQUogv6rjSZt8FC8kIonOz17FIu/WaxHsFrCY0IJ6mcmUH4HIKvR
         BS7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779508968; x=1780113768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xcYPdDxJYzV/CmKiBG3CG1YIl4gZbm9+IKFFewBuVc=;
        b=GgFqMgCfAnQC+6+1zN43wZmpXGW+rgJy2VGjp8zPqETqoIYG76FOjtvgLW6q6Hmh8C
         g7Yr712aGBKnG3MN24mjqfpj9eAb+2XPkOzhYqWCFox+koghYdDH9kV0nDTZkDRezbin
         y5Qb2Yu/r5c+9FHuIbtvxCAkkLRuJdlrkHNDodnO+vOGDUZebJQNr2PXDuOess06snaH
         y7J42zjuJziX+mcbVkbSYMKraSl0b4NtUccZMzAvtJOxnELGlY9N+CTjUBD9+B7RyCHI
         IY951yGHAyPq34BqXRCGEXxknUSkvo/uWqZ6iwiIaG2u9A/U25P4iK3lalyFQcyt6fXY
         jfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779508968; x=1780113768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xcYPdDxJYzV/CmKiBG3CG1YIl4gZbm9+IKFFewBuVc=;
        b=lPtHGYs5kHa6QSskQ3DVD7Yasl6s8kuvZ/iOcLshWzdCZhQujf6qsKHwlsNl1M+nYA
         HlNFcGzKoZEnQgm2960V2uKhALfpZQ1vagKAut7BHcvh5jkKtMVSUhUWSQ7g/kF/Dw3W
         Sdiari40wb7GT1kcgomn3JdNQz+kusjedsyPuzBCl1T83sTnrH7cjf+fhe0zx0rBE+oC
         UOCilveX4kr84FWsxQ+rePIF+/qiKS37fNmj4tYu0zwD63YmgB4ufWeH/fFbkN1UqWNv
         +HyUGJ7sR8BXMoXAjv62h+OXMGgmr/cJAOvvJXoJlYI6JFg78sG9UEVCUaQx4t4wcCaT
         TDpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EdaxEpJ2EBB+wqYc/PdkRMgxE1jQERHdFno9kadKcQM1vX9s5avALgf9KFbdjE6ZkeBO9Dmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jJ3lHTpwlD2V2pb4wNVzcDguzFxDXc3KMrZMNen6dr6oo6Qy
	FpQuJC1h5FNgTUQ1avxTA1Ln2bSnoyE6yDzOewU5DLzlskRi2xZ14hJKKt+TPv706B3bAJDiKDH
	s8vwckya/zKuXdP92huboh2A1g6l7aZ8rCDiK/5oj
X-Gm-Gg: Acq92OHXWxDRjYBimnatj2a1MmhMI03oyLmMLK8jldJL8wZF8nmol9svEAVKEo2gk5j
	dmAnp0yK3w5umhF+p+HOIK4tgwT3RrtWJunkfLDx0zNFAgcqf0Yl+NoXzBV0t0P11zCNHp51dCX
	nryrd8HqWt3BhmmUh7mYyaLYHLjgSn+2q38eWEEj/PIbqWUpk4/TXUKsYS43bWeevsT/V+cO1Mv
	mtoOGy6fCIbXZFLARbuBGmhOpQ/DHfPMIDJBSSYm5C/urp0GYftm7gsyHAkNPjEgfwEq5+6DPEu
	D2KFmenn+3/5ETUzXxX6/ooMy5Cs7fsVu8FxvT2mu4Iqv9KPoYxS8EJfth9xaR1KbVcpilu2h5S
	fd18I8asYSr2LOHcXBZ8rbRifqx2w6XHJyPTfVYtHbuvYk+BCvcPWBozdmgV76sY=
X-Received: by 2002:a05:7022:1281:b0:135:3ed5:5e38 with SMTP id
 a92af1059eb24-1365fa38eebmr2273034c88.27.1779508967667; Fri, 22 May 2026
 21:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521135244.40869-1-kerneljasonxing@gmail.com> <20260521135244.40869-4-kerneljasonxing@gmail.com>
In-Reply-To: <20260521135244.40869-4-kerneljasonxing@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 22 May 2026 21:02:35 -0700
X-Gm-Features: AVHnY4I9iRGRBjCTDHtVv6_EN8MVPCUPZvh5e1-44mgNxX4WFKLucU4AFq1u9tQ
Message-ID: <CAAVpQUDQWZSZWamOj4MBVakq52KnLaDAHg7zAV+B1d9kkz9hkw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] bpf: support bpf_setsockopt for bpf
 timestamping rx feature
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291026-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org,tencent.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tencent.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 46BA75BD0DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 6:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Add SK_BPF_CB_RX_TIMESTAMPING callback flag to enable RX timestamping
> via bpf_setsockopt(SK_BPF_CB_FLAGS).
>
> Add SOCK_BPF_TIMESTAMPING_RX into enum sock_flags that is used as
> centralized management of net_enable/disable_timestamp. Note that only
> one of them (timestamp, so_timestamping and bpf timestamping rx) can
> enable and disable the global time record of skbs.
>
> In addition, include SOCK_BPF_TIMESTAMPING_RX in SK_FLAGS_TIMESTAMP so
> that __sk_destruct() calling sock_disable_timestamp() to thoroughly turn
> off the global time record.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/sock.h       | 5 ++++-
>  include/uapi/linux/bpf.h | 5 +++--
>  net/core/filter.c        | 8 ++++++++
>  3 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index a579d5b09207..cf0e82e46482 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1022,9 +1022,12 @@ enum sock_flags {
>         SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
>         SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with pack=
et */
>         SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
> +       SOCK_BPF_TIMESTAMPING_RX, /* BPF RX timestamping enabled */

Just a note, this will be the last bit on 32bit kernel.


>  };
>
> -#define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMES=
TAMPING_RX_SOFTWARE))
> +#define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | \
> +                           (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
> +                           (1UL << SOCK_BPF_TIMESTAMPING_RX))
>  /*
>   * The highest bit of sk_tsflags is reserved for kernel-internal
>   * SOCKCM_FLAG_TS_OPT_ID. There is a check in core/sock.c to control tha=
t
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 552bc5d9afbd..1e09b5cd7a39 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7029,8 +7029,9 @@ enum {
>
>  enum {
>         SK_BPF_CB_TX_TIMESTAMPING       =3D 1<<0,
> -       SK_BPF_CB_MASK                  =3D (SK_BPF_CB_TX_TIMESTAMPING - =
1) |
> -                                          SK_BPF_CB_TX_TIMESTAMPING
> +       SK_BPF_CB_RX_TIMESTAMPING       =3D 1<<1,
> +       SK_BPF_CB_MASK                  =3D (SK_BPF_CB_RX_TIMESTAMPING - =
1) |
> +                                          SK_BPF_CB_RX_TIMESTAMPING
>  };
>
>  /* List of known BPF sock_ops operators.
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714..08ad102f204e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5304,6 +5304,14 @@ static int sk_bpf_set_get_cb_flags(struct sock *sk=
, char *optval, bool getopt)
>         if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
>                 return -EINVAL;
>
> +       if ((sk_bpf_cb_flags ^ sk->sk_bpf_cb_flags) & SK_BPF_CB_RX_TIMEST=
AMPING) {
> +               if (sk_bpf_cb_flags & SK_BPF_CB_RX_TIMESTAMPING)
> +                       sock_enable_timestamp(sk, SOCK_BPF_TIMESTAMPING_R=
X);
> +               else
> +                       sock_disable_timestamp(sk,
> +                                              (1UL << SOCK_BPF_TIMESTAMP=
ING_RX));
> +       }
> +
>         sk->sk_bpf_cb_flags =3D sk_bpf_cb_flags;
>
>         return 0;
> --
> 2.43.7
>

