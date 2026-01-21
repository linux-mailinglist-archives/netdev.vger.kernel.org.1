Return-Path: <netdev+bounces-251947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LC2LxPxcGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:30:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5E759341
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2E5A54F6C5
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9595649250C;
	Wed, 21 Jan 2026 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCRWD+mF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FBA4921A2
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007231; cv=pass; b=hupECv6iFCiOT6fB2FO4UaZdgVZ0sYYlSiZ2KqpTw03WmTQMc5niBXDgJDyrORUCnplfrHGVL23quXZxx8UFQtmN8wMCQQLfDA/K0I1j5b4V31U3KSTCKkjJFb5RR5dPvtVHQ00Sk/w14O09tw61QrXryEInIc4z+KFs6fO/ENk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007231; c=relaxed/simple;
	bh=fzzbb3QnFJsxDqCdwHKZh0HE+sgF9Ktls9W4VFfaNa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQbkuEuqfB+L3CQpypitQGNXGob+reLyAYITTkdhAhA/tGLbQbvLVbToRjkrDts8vG4NgZwjgtqvT5jsH8URX0bIdsPAgWkdB0vsg7ASBf0G3XmhYWFSugseGUS1GbMOz/aAD3VePMxjWA4ooxfMBJnfUp7eQuW5NKQOwZoW3Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCRWD+mF; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a2fe9e200so61420366d6.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 06:53:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769007227; cv=none;
        d=google.com; s=arc-20240605;
        b=TipJbEchkm5ts7/6gfJPLH0guSUO+HfL8LAzpbAQDJSZZeuDNU6HG36W/HhW0iD3Sh
         w65UxU1cUi1rMzIi33RUZD6eI8TnCLfYKLfgUEVy7F6NSscvRThsxILlDsui2HSvVOsk
         hwG1Vpv4zL19TmoKSKCiaXUs6djxnkpclsp6sWzglWa5OF7Y/Yb1qKlcrH7qemonCpQk
         J15GgMZlHdG2VxfKZbHBrsvHkUmTWEkd2ee71dKiZJROZGgtJztpYuD8z+GnNVXlXXJW
         TNXQVgdwsG/onO8d/cg2/4xG8rBcD/QW1VRmDh89LPxte6cDN5K2kwJtVEFXcfoz64wS
         wfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c9qXnOSUTaJRqoKVmmvJ/aC55OLxhDJSo/Of+Pk4eZE=;
        fh=3COc+ie51acMPQDWAuZqebie+gyVLYtILNS0CjIQ0us=;
        b=k6FZ/PWzTJAIEXcRPIPEEXU0naAL5BqNXtjyi9QuGQPJGwa8FnWuUSVokw+JRf197H
         Md6vf+3d2ZgDiovEXY+L5oZ0s/qfpma5Hn4XC4PEbcVPSt9p/JHOkaJKZ3rSC1LroLWf
         ezAgJwwF4NL7m+K+NbbFSDFLNqIq7Fsd2mhLf0usEKpjiMMqWAMnXdOF4eEs5o7z7gb0
         ELg4PRpZNMnSCmlVMpu7TTMhoupiVrXfDrGydD0Sb5ffMYmFCgsqbMSQ8gKTccA8fAAo
         j9+oK7faifCTyW5LYIJ2H6dGaId5jk32eOrrQ3BfPdQXnDPrv72yK35nZ06AjEVRc263
         Bygw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769007227; x=1769612027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9qXnOSUTaJRqoKVmmvJ/aC55OLxhDJSo/Of+Pk4eZE=;
        b=YCRWD+mFIOKM5HQ3+01g/xz3wtxwx5SlnwrWw6d/uiMV6QbsHYC00G3TdvAI9D0ZxM
         DDAs26O+GVH632Ai3G0rxdJK2k7b1gR2EgCcyoyQpQiYjvtH1NdsL3wEJXulolQM7nlh
         zJoNwGDfmclV1Hw/rkc+dDMIvZjqhgs0SWN2m2fHpsBcbTBwCH7LoLI1QjeWR6r3rkKL
         91yrpTuIjkt2VCPGbo1eMBFcxaRqd5GoW9M9f0pdCnp74lTJtSxaGRjJra76P1NPxq9u
         71ENWv4plPZmGy8AZDgxGA1kIKBSuIc9HaHDoS6ntwNsa2zKFDddEg7JxbvquIyEa0MO
         qO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007227; x=1769612027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c9qXnOSUTaJRqoKVmmvJ/aC55OLxhDJSo/Of+Pk4eZE=;
        b=uDVFdlNZ2d7j8ImyXfjpk3Wtu/9WMr9x7teJYxoA+pGo5//t3WAvbZBdaDUmktjeQp
         o/lhcUpWM9LXX5cMaS25IOodpGbZe4f/vTTy2xrIy9ZG8FWLTNC7q2ue0lmr6Yi4oLs5
         HStMbJlmpkvImBrqjA7aYUvYKD+ZRyyy5Ja5jzwTZS2+32PfWvduXNOYycrSYNoE5OAM
         CGugmWVE9I7MzCEWwkc8pBFF93M91ZzMISsV+uMgjR+g7RD4EuJfTTzwb1mwgbB+YhN2
         0eQQrURTXm4/SS2wnMBusLu7/zX7zwFX1gH4QpS/DNa/hvZBQ0WKs9DtCeVn15GxToWA
         89ew==
X-Forwarded-Encrypted: i=1; AJvYcCU8oYxzQ5IzRNiUYGSVOKla+Ic15avuQpJfX2DARG2Irmz4j6XIpMRsRfDXnzxJLl/rE0FHt8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4/giVDdwnG24mDamm65b420cLeDiRbOT+wO1ZTcbUK/C50BM
	9LXe41Lw8yoqwi2WIxFLQBrfrlkGgu5ImyE1Pj+3OXV5KsPiG40jay3RHqUb/x7AD+IgFpIDLFB
	I9BHSSEKaz5VCuT5KcDTft+0jv3bJHg8cKMZ5XqUt
X-Gm-Gg: AZuq6aIiqIQu8c0y4LNL61UTe7LWe+qoM1MK9gL2VoGwl7/XDoijnNYL64vf83zFyA7
	GQB6+1nKXHv9Be51q8Hr7w9wssB7JylyTfVpm8PrJF9G5o9qypph+9VtYjy+hDEmGCGCyKpyr1E
	E9AMSn4/rfYlrm0XA0kH/EJjp5GPqqy5Xt2yI8Z9k5m+UQsYkydon/SQ5GwW9ivtkjJiKQedAru
	N2cp+fp0acv8omiZxklxjQ4wUwcY+VHZZXbG2h2N73nfsDTIHwDVC/BvR7VYphbp8cc2FY=
X-Received: by 2002:a05:622a:11ce:b0:4ed:a7ba:69c with SMTP id
 d75a77b69052e-502a17dbec7mr276708241cf.83.1769007227139; Wed, 21 Jan 2026
 06:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com> <20260121143215.14717-13-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260121143215.14717-13-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 15:53:36 +0100
X-Gm-Features: AZwV_QiGb7YuJm7CkwrDqLPsRX6j1FfwcEyo2MwarcIKsN7ZaUyiwGIstnxbToI
Message-ID: <CANn89iLvMkeKG_VBrJi3vA5agDxc5+VLz_L3JNT0ALsRUF32xg@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 12/15] tcp: accecn: detect loss ACK w/ AccECN
 option and add TCP_ACCECN_OPTION_PERSIST
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TAGGED_FROM(0.00)[bounces-251947-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2F5E759341
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 3:32=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Detect spurious retransmission of a previously sent ACK carrying the
> AccECN option after the second retransmission. Since this might be caused
> by the middlebox dropping ACK with options it does not recognize, disable
> the sending of the AccECN option in all subsequent ACKs. This patch
> follows Section 3.2.3.2.2 of AccECN spec (RFC9768).
>
> Also, a new AccECN option sending mode is added to tcp_ecn_option sysctl:
> (TCP_ECN_OPTION_PERSIST), which ignores the AccECN fallback policy and
> persistently sends AccECN option once it fits into TCP option space.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>
> ---
> v5:
> - Add empty line between variable declarations and code
> ---
>  Documentation/networking/ip-sysctl.rst |  4 +++-
>  include/linux/tcp.h                    |  3 ++-
>  include/net/tcp_ecn.h                  |  2 ++
>  net/ipv4/sysctl_net_ipv4.c             |  2 +-
>  net/ipv4/tcp_input.c                   | 10 ++++++++++
>  net/ipv4/tcp_output.c                  |  7 ++++++-
>  6 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index bc9a01606daf..28c7e4f5ecf9 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -482,7 +482,9 @@ tcp_ecn_option - INTEGER
>         1 Send AccECN option sparingly according to the minimum option
>           rules outlined in draft-ietf-tcpm-accurate-ecn.
>         2 Send AccECN option on every packet whenever it fits into TCP
> -         option space.
> +         option space except when AccECN fallback is triggered.
> +       3 Send AccECN option on every packet whenever it fits into TCP
> +         option space even when AccECN fallback is triggered.
>         =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>         Default: 2
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 683f38362977..32b031d09294 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -294,7 +294,8 @@ struct tcp_sock {
>         u8      nonagle     : 4,/* Disable Nagle algorithm?             *=
/
>                 rate_app_limited:1;  /* rate_{delivered,interval_us} limi=
ted? */
>         u8      received_ce_pending:4, /* Not yet transmit cnt of receive=
d_ce */
> -               unused2:4;
> +               accecn_opt_sent:1,/* Sent AccECN option in previous ACK *=
/
> +               unused2:3;
>         u8      accecn_minlen:2,/* Minimum length of AccECN option sent *=
/
>                 est_ecnfield:2,/* ECN field for AccECN delivered estimate=
s */
>                 accecn_opt_demand:2,/* Demand AccECN option for n next AC=
Ks */
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index bf7d3f9f22c7..41b593ece1dd 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -29,6 +29,7 @@ enum tcp_accecn_option {
>         TCP_ACCECN_OPTION_DISABLED =3D 0,
>         TCP_ACCECN_OPTION_MINIMUM =3D 1,
>         TCP_ACCECN_OPTION_FULL =3D 2,
> +       TCP_ACCECN_OPTION_PERSIST =3D 3,
>  };
>
>  /* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION fla=
g */
> @@ -413,6 +414,7 @@ static inline void tcp_accecn_init_counters(struct tc=
p_sock *tp)
>         tp->received_ce_pending =3D 0;
>         __tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
>         __tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
> +       tp->accecn_opt_sent =3D 0;
>         tp->accecn_minlen =3D 0;
>         tp->accecn_opt_demand =3D 0;
>         tp->est_ecnfield =3D 0;
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index a1a50a5c80dc..385b5b986d23 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -749,7 +749,7 @@ static struct ctl_table ipv4_net_table[] =3D {
>                 .mode           =3D 0644,
>                 .proc_handler   =3D proc_dou8vec_minmax,
>                 .extra1         =3D SYSCTL_ZERO,
> -               .extra2         =3D SYSCTL_TWO,
> +               .extra2         =3D SYSCTL_THREE,
>         },
>         {
>                 .procname       =3D "tcp_ecn_option_beacon",
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 8b774019a3a6..472bd57913ae 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4863,6 +4863,8 @@ static void tcp_dsack_extend(struct sock *sk, u32 s=
eq, u32 end_seq)
>
>  static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_bu=
ff *skb)
>  {
> +       struct tcp_sock *tp =3D tcp_sk(sk);
> +
>         /* When the ACK path fails or drops most ACKs, the sender would
>          * timeout and spuriously retransmit the same segment repeatedly.
>          * If it seems our ACKs are not reaching the other side,
> @@ -4882,6 +4884,14 @@ static void tcp_rcv_spurious_retrans(struct sock *=
sk, const struct sk_buff *skb)
>         /* Save last flowlabel after a spurious retrans. */
>         tcp_save_lrcv_flowlabel(sk, skb);
>  #endif
> +       /* Check DSACK info to detect that the previous ACK carrying the
> +        * AccECN option was lost after the second retransmision, and the=
n
> +        * stop sending AccECN option in all subsequent ACKs.
> +        */
> +       if (tcp_ecn_mode_accecn(tp) &&
> +           TCP_SKB_CB(skb)->seq =3D=3D tp->duplicate_sack[0].start_seq &=
&
> +           tp->accecn_opt_sent)
> +               tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_SEND);
>  }

tcp_rcv_spurious_retrans() has two callers.

tcp_send_dupack() checked dsack is enabled.

tcp_data_queue() : No such check.

So I wonder if tp->duplicate_sack[0].start_seq could contain garbage ?

Perhaps test tp->rx_opt.dsack ?

>
>  static void tcp_send_dupack(struct sock *sk, const struct sk_buff *skb)
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 042e7e9b13cc..0cbba38ea87a 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -713,9 +713,12 @@ static void tcp_options_write(struct tcphdr *th, str=
uct tcp_sock *tp,
>                 if (tp) {
>                         tp->accecn_minlen =3D 0;
>                         tp->accecn_opt_tstamp =3D tp->tcp_mstamp;
> +                       tp->accecn_opt_sent =3D 1;
>                         if (tp->accecn_opt_demand)
>                                 tp->accecn_opt_demand--;
>                 }
> +       } else if (tp) {
> +               tp->accecn_opt_sent =3D 0;
>         }
>
>         if (unlikely(OPTION_SACK_ADVERTISE & options)) {
> @@ -1187,7 +1190,9 @@ static unsigned int tcp_established_options(struct =
sock *sk, struct sk_buff *skb
>         if (tcp_ecn_mode_accecn(tp)) {
>                 int ecn_opt =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_e=
cn_option);
>
> -               if (ecn_opt && tp->saw_accecn_opt && !tcp_accecn_opt_fail=
_send(tp) &&
> +               if (ecn_opt && tp->saw_accecn_opt &&
> +                   (ecn_opt >=3D TCP_ACCECN_OPTION_PERSIST ||
> +                    !tcp_accecn_opt_fail_send(tp)) &&
>                     (ecn_opt >=3D TCP_ACCECN_OPTION_FULL || tp->accecn_op=
t_demand ||
>                      tcp_accecn_option_beacon_check(sk))) {
>                         opts->use_synack_ecn_bytes =3D 0;
> --
> 2.34.1
>

