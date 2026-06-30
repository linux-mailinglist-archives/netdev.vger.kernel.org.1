Return-Path: <netdev+bounces-303401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3nvmBJhNRGpxsQoAu9opvQ
	(envelope-from <netdev+bounces-303401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:13:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7266E89CF
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:13:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=OrkVn0s2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303401-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303401-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F9BD3039A58
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 23:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D157B3264D0;
	Tue, 30 Jun 2026 23:13:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A02DA749
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 23:13:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782861204; cv=pass; b=d1Yg/2pfwraydvtZMbg5GVNFme6iSX1q9IfSb1+iVNMSWxyUGYKzv5rTOTKLm6+06EkoD7W8HpWFYNxpapSKsecns2yCd6A+Y75KQP6CXzRiOfUupwX9jICW0uK6y6NPdRDkNYbnVmbeAF4PfQoTrxb4Quyc6bcW9I9BbAQbHfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782861204; c=relaxed/simple;
	bh=7GnumVWjcgLJ1YLkkXRvzhPbzF1weVJjREUeBEZEFCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJWpatyBAaPL1Gz4eute1SYtZqTphB853+J4uH+EIxlNtExD7bK7rg4nehMHuZmEp2ad6A1GTaAeqf+gpSl9bmI2hTvR0nOu6faODkdvybL/JZK/l9Yj0iPmTKlm8Cu3VUWNX2ZbynvVEDDiJCCxbYfaDu/IHY3b7HFCFET5PD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrkVn0s2; arc=pass smtp.client-ip=74.125.82.42
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13b2b92b0bfso20963c88.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 16:13:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782861202; cv=none;
        d=google.com; s=arc-20260327;
        b=lAn9EiZysTsm6ZccIvUxWp3I59drO3Zi+bf9WKnt3tKtPh9f0j8ZvDaGrma3qZCP+X
         ydu68XgAdYTf3vh3OQtgpri3KafoH/yCs4mo8XkMpPu1SEvT/3BBDNENcy1MEZ5Z2NCu
         ZjzmL55845y6AREUmgi7wvjEsXskWmumvDv1sYIYjgwUjm1ll3tzXjp4GPTTu3b3irsF
         XHeq/D6ZY2CUrILgH4pMeMzAB1edKjY8yDibrC1unbr1sP1qDQWpEd1nZso11A5TxOgq
         P+6uwijDOA/lZV8Kn5w5sAkNiUAuQuX2mS36kzgBNDbxKLts4Z+TvTeMXlBIVfWqGTeD
         YPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qIwy3Ud/CLLPFGb47ouhwt98bKtOnACrBH237I4eD0o=;
        fh=0Mt7ys5fhCaGjdNkTVQP9wwMa4Zfp1G3J60Fn6miG6Q=;
        b=VvXgQ5Y/PwJioi81cnxJ9jIjfAQMHDmSLT350T3uT0oBKwV7AglZq1EkCcfqDHiSdi
         CvlLKLaa8JqLNXDdPGn9/gcNwkoM3voyKBfUsTReW8Fl5m8QuOqXSQPeyGiTfI5CY1Ts
         v2dxGoACg3ZmkQoZtSdWuz4+M5k5N5GTdupgsNVkWm4DStP61sEC5xU6jmdvkpzG8Wkj
         wqzpQPwvACWfsIJecXNgegTNmDtC+/BD6iqxNFWKDc5jCDo97s9rV8njPgXBm0eTgPgI
         vWOBmviVw8ZMSr3cKRr+b1XFhJU/0yFyWMlhw1bs34leuLEyiKE3Azk5yOZTzf9cscQ/
         wVYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782861202; x=1783466002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIwy3Ud/CLLPFGb47ouhwt98bKtOnACrBH237I4eD0o=;
        b=OrkVn0s2OH3b6VGVAR2IG//clXW64J/0si4BoDqt1S1yW/1xRDCmIayt1fhkHjzLPC
         nsT/+PdsXCIq+9Ro6deVzU7HViqCepcfpmEymsZ3/Cj+jFqNiRa4enNwE43r/LaOgds4
         m77ZUOi8HsXG/OzvmEhqJrVRz/N34X+IBwbVkdkG5csanHSJYr3XZrkd2468pRvUvivl
         h2k5/EGAT4Ad14oe1UE77bKZEQAf4CucMUcFZNc646GvM9ccqXP7YvdtEHQR5elPTu6T
         dns4fV2TkIRe8lk9pV1XgjdItR5ehhbTy/IpBlb5FE3V3cZECJBoxt94f+hUPcNYm6mG
         qGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782861202; x=1783466002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qIwy3Ud/CLLPFGb47ouhwt98bKtOnACrBH237I4eD0o=;
        b=Fb9RfTmhcyT6ZuVSWWVrciwDV6ZKMyrfXbv65cvtke+6W3xmFkxrxfi4/UFz9+RAuB
         TgujCQDhNvG3sWLF1zM5WtHYaudfYwFwfx6FZTnnYGQ54KA6mj8JIJWSvUDPjYBUDE9e
         VF7IR8Q4NTLmg4G1zCGkpgPRZZ8UvXcqHNwQM2/kWumEGPSDhY4A8vjeeo1dkeyCQaRd
         GET7S3MIJvQHBdp8cthUQu+n1+o/yO+qdDdOMl6uzjITk2FztCwgCQ2EL2lWpp89XwqY
         LfMXOXUf2mpfc1IOR9LQqtFp1OSRSqq0ai67hv7fdPjWOpuqU78wJ6ul+o5Seao5iLXI
         vsVg==
X-Forwarded-Encrypted: i=1; AFNElJ8HzMBdEFZ9z5REFWFoHXqZARYMBSB8GbjFNnznfUvqI4xEoxt4eOuNM4Ke/7KRx7y9hH8EBj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM9MXLXHxn5jtw2QT7oGmVosD/nUkyQ5bHazzc1ltek4bIVsrw
	zXMczKJ19W7bprswamKiCT1yDzRUf2IUm8xjNV7R049MWiYchMlGomZZwEVEK4s2mZGGBF7d3pZ
	gHagpe9nPZ3dC6Kylw4Tbf3qzLLV46WtShuxFT7s1
X-Gm-Gg: AfdE7cmnyKIjVrb2fg2Xt7XHNLzazodtuqO78+gpT95a1RZAd1b1EQYS9HMRhO0Qelj
	K6bbqkJCUhT+iGs9kX4GA1Xzj/272aq3y2gmpnUpWpOfa0rl2Xpas2eMQltj/B3NGo9MM+b0Ua/
	pOruO+8PBIOeVyIWYk2otHwpoielAyhVEUDC0r7Uxg6Q9FplPt943IAxyn7eLHugDW3QbSFT9lu
	XRf6C3Kqwr3jnNufi+NPYtBzA9+R41iCrynklykkQruYRG6MHiGq/19dGwDH87S5qfO4pvhZVVU
	O9b7M4ydYyBKxdUCZy4K8GcvYVwot3OqgisTbd+fTfIuqtUohc70TknQb+YCT3DVymcxc79JUum
	E+zK0rZUkpj8ePaPgH4/NYMSBgPevkxQ6uVy+eTFRttxkUW00
X-Received: by 2002:a05:7022:fd0c:b0:139:7a48:fcb5 with SMTP id
 a92af1059eb24-13b2a1db6a1mr3367859c88.34.1782861201392; Tue, 30 Jun 2026
 16:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630114121.26430-1-laoar.shao@gmail.com>
In-Reply-To: <20260630114121.26430-1-laoar.shao@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 30 Jun 2026 16:13:10 -0700
X-Gm-Features: AVVi8CcsvaLS-6YkOytjc16Hnsuo4gnublwI4toVD8cSTSADwW9IdpCH-dOo4a8
Message-ID: <CAAVpQUAwrWkXxjErj8QvXg0DCdPc4zkphB4OSLgDDRmGuSrfxg@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] ss: stop displaying dccp sockets
To: Yafang Shao <laoar.shao@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:laoar.shao@gmail.com,m:stephen@networkplumber.org,m:netdev@vger.kernel.org,m:laoarshao@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303401-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A7266E89CF

On Tue, Jun 30, 2026 at 4:41=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> DCCP support was retired in kernel commit 2a63dd0edf38 ("net: Retire
> DCCP socket."). However, ss still attempts to query DCCP sockets via
> netlink, which triggers repeated SELinux warnings in dmesg:
>
>   SELinux: unrecognized netlink message: protocol=3D4 nlmsg_type=3D19 \
>     sclass=3Dnetlink_tcpdiag_socket pid=3D188945 comm=3Dss
>
> Stop sending DCCPDIAG_GETSOCK netlink messages to suppress these
> warnings and align ss with the kernel change.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  man/man8/ss.8 |  5 +++--
>  misc/ss.c     | 40 ++++++++--------------------------------
>  2 files changed, 11 insertions(+), 34 deletions(-)
>
> diff --git a/man/man8/ss.8 b/man/man8/ss.8
> index 70e0a566..37dd75a0 100644
> --- a/man/man8/ss.8
> +++ b/man/man8/ss.8
> @@ -378,7 +378,8 @@ Display TCP sockets.
>  Display UDP sockets.
>  .TP
>  .B \-d, \-\-dccp
> -Display DCCP sockets.
> +[Deprecated] DCCP is no longer supported since kernel 6.16.
> +This option is ignored.
>  .TP
>  .B \-w, \-\-raw
>  Display RAW sockets.
> @@ -411,7 +412,7 @@ supported: unix, inet, inet6, link, netlink, vsock, t=
ipc, xdp.
>  .B \-A QUERY, \-\-query=3DQUERY, \-\-socket=3DQUERY
>  List of socket tables to dump, separated by commas. The following identi=
fiers
>  are understood: all, inet, tcp, udp, raw, unix, packet, netlink, unix_dg=
ram,
> -unix_stream, unix_seqpacket, packet_raw, packet_dgram, dccp, sctp, tipc,
> +unix_stream, unix_seqpacket, packet_raw, packet_dgram, sctp, tipc,
>  vsock_stream, vsock_dgram, xdp, mptcp. Any item in the list may optional=
ly be
>  prefixed by an exclamation mark
>  .RB ( ! )
> diff --git a/misc/ss.c b/misc/ss.c
> index 14e9f27a..dae5f282 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -195,7 +195,6 @@ static const char *dg_proto;
>  enum {
>         TCP_DB,
>         MPTCP_DB,
> -       DCCP_DB,
>         UDP_DB,
>         RAW_DB,
>         UNIX_DG_DB,
> @@ -215,7 +214,7 @@ enum {
>  #define PACKET_DBM ((1<<PACKET_DG_DB)|(1<<PACKET_R_DB))
>  #define UNIX_DBM ((1<<UNIX_DG_DB)|(1<<UNIX_ST_DB)|(1<<UNIX_SQ_DB))
>  #define ALL_DB ((1<<MAX_DB)-1)
> -#define INET_L4_DBM ((1<<TCP_DB)|(1<<MPTCP_DB)|(1<<UDP_DB)|(1<<DCCP_DB)|=
(1<<SCTP_DB))
> +#define INET_L4_DBM ((1<<TCP_DB)|(1<<MPTCP_DB)|(1<<UDP_DB)|(1<<SCTP_DB))
>  #define INET_DBM (INET_L4_DBM | (1<<RAW_DB))
>  #define VSOCK_DBM ((1<<VSOCK_ST_DB)|(1<<VSOCK_DG_DB))
>
> @@ -274,10 +273,6 @@ static const struct filter default_dbs[MAX_DB] =3D {
>                 .states   =3D SS_CONN,
>                 .families =3D FAMILY_MASK(AF_INET) | FAMILY_MASK(AF_INET6=
),
>         },
> -       [DCCP_DB] =3D {
> -               .states   =3D SS_CONN,
> -               .families =3D FAMILY_MASK(AF_INET) | FAMILY_MASK(AF_INET6=
),
> -       },
>         [UDP_DB] =3D {
>                 .states   =3D (1 << SS_ESTABLISHED),
>                 .families =3D FAMILY_MASK(AF_INET) | FAMILY_MASK(AF_INET6=
),
> @@ -388,13 +383,12 @@ static int filter_db_parse(struct filter *f, const =
char *s)
>                 int dbs[MAX_DB + 1];
>         } db_name_tbl[] =3D {
>  #define ENTRY(name, ...) { #name, { __VA_ARGS__, MAX_DB } }
> -               ENTRY(all, UDP_DB, DCCP_DB, TCP_DB, MPTCP_DB, RAW_DB,
> +               ENTRY(all, UDP_DB, TCP_DB, MPTCP_DB, RAW_DB,
>                            UNIX_ST_DB, UNIX_DG_DB, UNIX_SQ_DB,
>                            PACKET_R_DB, PACKET_DG_DB, NETLINK_DB,
>                            SCTP_DB, VSOCK_ST_DB, VSOCK_DG_DB, XDP_DB),
> -               ENTRY(inet, UDP_DB, DCCP_DB, TCP_DB, MPTCP_DB, SCTP_DB, R=
AW_DB),
> +               ENTRY(inet, UDP_DB, TCP_DB, MPTCP_DB, SCTP_DB, RAW_DB),
>                 ENTRY(udp, UDP_DB),
> -               ENTRY(dccp, DCCP_DB),
>                 ENTRY(tcp, TCP_DB),
>                 ENTRY(mptcp, MPTCP_DB),
>                 ENTRY(sctp, SCTP_DB),
> @@ -935,8 +929,6 @@ static const char *proto_name(int protocol)
>                 return "mptcp";
>         case IPPROTO_SCTP:
>                 return "sctp";
> -       case IPPROTO_DCCP:
> -               return "dccp";
>         case IPPROTO_ICMPV6:
>                 return "icmp6";
>         }
> @@ -3897,8 +3889,6 @@ static int tcpdiag_send(int fd, int protocol, struc=
t filter *f)
>
>         if (protocol =3D=3D IPPROTO_TCP)
>                 req.nlh.nlmsg_type =3D TCPDIAG_GETSOCK;
> -       else if (protocol =3D=3D IPPROTO_DCCP)
> -               req.nlh.nlmsg_type =3D DCCPDIAG_GETSOCK;
>         else
>                 return -1;
>
> @@ -4134,7 +4124,7 @@ static int inet_show_netlink(struct filter *f, FILE=
 *dump_fp, int protocol)
>
>         /* Suppress netlink errors. Older kernels do not support extended
>          * protocol requests using INET_DIAG_REQ_PROTOCOL, and some proto=
cols
> -        * may not be available in the running kernel (e.g. SCTP, DCCP).
> +        * may not be available in the running kernel (e.g. SCTP).
>          * In both cases the kernel returns EINVAL which would cause
>          * rtnl_dump_error() to print a confusing "RTNETLINK answers" err=
or.
>          */
> @@ -4309,18 +4299,6 @@ static int mptcp_show(struct filter *f)
>         return 0;
>  }
>
> -static int dccp_show(struct filter *f)
> -{
> -       if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
> -               return 0;
> -
> -       if (!getenv("PROC_NET_DCCP") && !getenv("PROC_ROOT")
> -           && inet_show_netlink(f, NULL, IPPROTO_DCCP) =3D=3D 0)
> -               return 0;
> -
> -       return 0;
> -}
> -
>  static int sctp_show(struct filter *f)
>  {
>         if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
> @@ -5779,7 +5757,7 @@ static void _usage(FILE *dest)
>  "   -M, --mptcp         display only MPTCP sockets\n"
>  "   -S, --sctp          display only SCTP sockets\n"
>  "   -u, --udp           display only UDP sockets\n"
> -"   -d, --dccp          display only DCCP sockets\n"
> +"   -d, --dccp          DCCP is no longer supported, option ignored\n"
>  "   -w, --raw           display only RAW sockets\n"
>  "   -x, --unix          display only Unix domain sockets\n"
>  "       --tipc          display only TIPC sockets\n"
> @@ -5795,7 +5773,7 @@ static void _usage(FILE *dest)
>  "       --inet-sockopt  show various inet socket options\n"
>  "\n"
>  "   -A, --query=3DQUERY, --socket=3DQUERY\n"
> -"       QUERY :=3D {all|inet|tcp|mptcp|udp|raw|unix|unix_dgram|unix_stre=
am|unix_seqpacket|packet|packet_raw|packet_dgram|netlink|dccp|sctp|vsock_st=
ream|vsock_dgram|tipc|xdp}[,QUERY]\n"
> +"       QUERY :=3D {all|inet|tcp|mptcp|udp|raw|unix|unix_dgram|unix_stre=
am|unix_seqpacket|packet|packet_raw|packet_dgram|netlink|sctp|vsock_stream|=
vsock_dgram|tipc|xdp}[,QUERY]\n"
>  "\n"
>  "   -D, --diag=3DFILE     Dump raw information about TCP sockets to FILE=
\n"
>  "   -F, --filter=3DFILE   read filter information from FILE\n"
> @@ -5907,7 +5885,7 @@ static const struct option long_opts[] =3D {
>         { "threads", 0, 0, 'T' },
>         { "bpf", 0, 0, 'b' },
>         { "events", 0, 0, 'E' },
> -       { "dccp", 0, 0, 'd' },
> +       { "dccp", 0, 0, 'd' }, /* DCCP retired, kept for compatibility */
>         { "tcp", 0, 0, 't' },
>         { "sctp", 0, 0, 'S' },
>         { "udp", 0, 0, 'u' },
> @@ -5997,7 +5975,7 @@ int main(int argc, char *argv[])
>                         follow_events =3D 1;
>                         break;
>                 case 'd':
> -                       filter_db_set(&current_filter, DCCP_DB, true);
> +                       /* DCCP retired in kernel 6.16, kept for compatib=
ility */

I think it more user-friendly to remove the case and show usage(),
instead of just ignoring the option.


>                         break;
>                 case 't':
>                         filter_db_set(&current_filter, TCP_DB, true);
> @@ -6290,8 +6268,6 @@ int main(int argc, char *argv[])
>                 udp_show(&current_filter);
>         if (current_filter.dbs & (1<<TCP_DB))
>                 tcp_show(&current_filter);
> -       if (current_filter.dbs & (1<<DCCP_DB))
> -               dccp_show(&current_filter);
>         if (current_filter.dbs & (1<<SCTP_DB))
>                 sctp_show(&current_filter);
>         if (current_filter.dbs & VSOCK_DBM)
> --
> 2.50.1 (Apple Git-155)
>

