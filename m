Return-Path: <netdev+bounces-293561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIj+JQohHWqmVwkAu9opvQ
	(envelope-from <netdev+bounces-293561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:04:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FE2619F74
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A137330071DD
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A7834402B;
	Mon,  1 Jun 2026 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYVVWZh6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4C334374
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293892; cv=pass; b=mY+AkUB5xEIqTgrHM0kRkhznbu7NEZjKBDMYzl8iKpoCU98S7GfDPusaQuuGw/d6pKdKYNtKEeC2y0s0gPg3YtP0eBUz2PKUZk7b+ASTmXCcV3LovnIhP2E5+Y06UtRSm9CS3fywzeLnzOCJbEeBcVsjQimfSgC4VLIx5bcj/eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293892; c=relaxed/simple;
	bh=6bjVi+JyhAn9xt4CVOuPiBRy6cmGtTm1pQkNQE6CK/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scVmISf6juZPCozFHux5N+Jt0+FOHzxqfTTDqUxfxvXaAlI+mRuI/5a3UZn5YvtEzyMM9j6DH7aGcAP7o+9YFg5ITfFnVMULXy10UhT8zRofUqr6cHMgZiafyDeYraK97ji19ZPUdif9hJslzTkdGTAfCzOxykSvTZGYBTMAwRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NYVVWZh6; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-914bb8e95c2so545518885a.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 23:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780293889; cv=none;
        d=google.com; s=arc-20240605;
        b=e7zV2mvDmLUawWeo+I/3jh4/FCPpIiTrywRMIrGI1mQnt0YGTnAB5Nk2+qmuN5Gbjd
         cxbu1KPX66oETOterUg8fKNrR8psDpJpyLNML1JFWzM5ketMUI5ivIaQrs5NkUzQWHY0
         eb//4dt5i+x+Z5+pbWTmCGulax2ms48eK6l1vktBwFwm76PE2kzwmQakM5IPSK18yYGg
         XqWUxLeRYCoQ2B+pQKdBCNZfNx0nPrsVz7XXr5sctmgvCH0sbQpef7923lweF9DDvkfF
         VbPIr9VfO9jf3Za8OheZAb77N/CjnoXfYLrBeTo3Nnbiztp0uUeMUt9rUYRdim3bFMcS
         gAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Z0a8kVnogWIFbzVGC1LJ7SgvO4GsxX6zRiRVh/+Z7k=;
        fh=L+WVQ+r5DkZp7AMsnKItt1saAxkOMx0m2kpR1D9urF4=;
        b=fT5p7mxZWj8DApx78F2VtFemTJe6ACZ7nwSblH40aJvyj26LrSF+KteKzOTVXu2aDD
         opCEcAlqTvDDoTJrmSZ9x+/Flr/fo6BXeOhJ0LN1I6QAtBXPVC6COSAyZBQ9QCn3w2tZ
         wWaeoNPDKjMlRHd6Ntil9T6hbrgZjmZSAKxvavpqyBzsjilf/PMwMEc4m388o5zXylIW
         tNXWNfZATXrOFIwiiw+QqWSBEdID28NSw2b1ufZO23LhGRCg122R/knrvtqIzoC6Wqq+
         SJW9PM2Eli8lhWiidAanS+/gMdoAuCQrhhZAPNduqEk6a9rYuxekBeOOWSjVHxAv6jZ9
         Q0Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780293889; x=1780898689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z0a8kVnogWIFbzVGC1LJ7SgvO4GsxX6zRiRVh/+Z7k=;
        b=NYVVWZh6WQazn2Bc1f4PqbVF64PmYIY97LxBVtsBnTraPU4wlsPU02NpSdQuNYFWmB
         OHoJu312FHK0+TWF+jMZe71p0qGMW9DQOyR+HdHRa916NbY0m1uWrmIbY0CHFxY3DzC7
         K0lS1iRI+SM3C4Rw8bGZ0lkSy7bX6A/2j1/AypUpCfhAadn9R6Lt+idUsd2/vki14aom
         qqf1sScN6jW3x1OcbBPIHqOlGS4m7VtBT+QZDbi3pBZImcf6wrYeotu0OWq+I7RW8vV6
         9CGcgsb/J4QV0cyDlfZME+hCeDFGTOw8As1xzUTN56TKZrDF6bkS/3bsF2AD4KjX2KDB
         Cc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780293889; x=1780898689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Z0a8kVnogWIFbzVGC1LJ7SgvO4GsxX6zRiRVh/+Z7k=;
        b=OwmwbT8IanPpHLO4/+HLViyEgYNOHy+SBrkaKphUQhDyG4bD4kJV3NxT9/SOTWfD+6
         HXkuoylA05n96oEdF0UyKDV1SBgmCmZpnY/J0deoDYyqNzc635y5823JYwPgRBvnpOr7
         9t9Cyaa4fdcDQG7kiv4bbDDlpF43agk9dJ47upIpf90Uq8zaGR6/sXJyiai8cTsIjO3R
         i0ifbeL4VAf9KAK1772OH4IfqdXpJLkyjqTu+h543iVjP/eQpv8sRCxZ0p7+zPgkBxtb
         hTVax43FSTJQfRjGJ0RVc/pAwn3eLlIt4fbjHkVtziS3UGpNBkIZ7jWHTYBdqLuFBI4Q
         NUxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8qtcxM1UtO7jQ1nnmxqwpBCsbl3cEaMeO6JZLtrdkU33RClKBoh8iYVw7vrcCsQxrQz7yL1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwFdBR4xjH3ZP2AOqMM0rxcLn+JjdAquxxXL+dWAwB7SHptGe
	dhZZjTMCQ+HDNImfYt9wFPzQ2osXyNB/Y2ITfQ3Tg7/SRF+yVgVWZN9/KwHPvk9srDGR3MKr19J
	UuNo93ySaD+v9AAwHBB1ihW/19XWVjp67DXcPBcY3
X-Gm-Gg: Acq92OF+PZiEFYqfcA+N7enJHl/qcv3hSlove/MAjrdOBLN4leq3YYx0g9gnNAhZoV9
	4VdW4B2UJhgTHawt1EB3T6OZcKGrL8dgUZRS1YKgZTe3FAn7b8QtJYsh0pNg+5FdckfJkBo9YCx
	CMycmnKLX3hoRM9u5cLrRMlaKme0H2gmZcs+S/KuXog1obTtH3vfusqwHRMiQWTZGkrKzhyxl9V
	wyy1B4ow00aYT/Juy687oN/QuJ4/KxBd87pzV8iu2sC4LP+zwNhi4tcNIxusKs+BA8DHoNnINJb
	XzI1znYYx+0cnTYIizlrt0/LwIUDPqA4MNBKMxxRH1US9Mie/uCTpvJUUliUSdx/BQfbvj4+m3m
	psj0tOp+r+IakpFGr/19fHL6prNFpx/IiK3QfwT8=
X-Received: by 2002:a05:620a:6602:b0:914:b850:bbfd with SMTP id
 af79cd13be357-9153db7ef4bmr1371910385a.60.1780293888174; Sun, 31 May 2026
 23:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
 <20260601-net-next-mptcp-add-addr6-port-ts-v1-5-4fc25dfef62e@kernel.org>
In-Reply-To: <20260601-net-next-mptcp-add-addr6-port-ts-v1-5-4fc25dfef62e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 31 May 2026 23:04:37 -0700
X-Gm-Features: AVHnY4KtflEDqDl6QlWBo9xSnuhW72hFLhTRFeEUu4vzlmrsu5ShhS1fhtCWJF4
Message-ID: <CANn89iLdwhhwLyO6zRjWMEY3t9g60ZE8ZhOVx33ucg_uRETbmQ@mail.gmail.com>
Subject: Re: [PATCH net-next 05/11] tcp: allow mptcp to drop TS for some packets
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293561-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 60FE2619F74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 10:25=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
> taking 30 bytes, the 40-byte limit for the TCP options is reached. In
> this case, it is then not possible to send the address signal.
>
> The idea is to let MPTCP dropping the TCP-timestamps option for some
> specific packets, to be able to send some specific pure ACK carrying >28
> bytes of MPTCP options, like with this specific ADD_ADDR. A new
> parameter is passed from tcp_established_options to the MPTCP side to
> indicate if the TCP TS option is used, and if it should be dropped. The
> next commit implements the part on MPTCP side, but split into two
> patches to help TCP maintainers to identify the modifications on TCP
> side. This feature will be controlled by a new add_addr_v6_port_drop_ts
> MPTCP sysctl knob.
>
> It is important to keep in mind that dropping the TCP timestamps option
> for one packet of the connection could eventually disrupt some
> middleboxes: even if it should be unlikely, they could drop the packet
> or even block the connection. That's why this new feature will be
> controlled by a sysctl knob.
>
> Note that it would be technically possible to squeeze both options into
> the header if the ADD_ADDR is first written, and then the TCP timestamps
> without the NOPs preceding it. But this means more modifications on TCP
> side, plus some middleboxes could still be disrupted by that.
>
> About the implementation, instead of passing a new boolean (drop_ts),
> another option would be to pass the whole option structure (opts),
> but 'struct tcp_out_options' is currently defined in tcp_output.c, and
> would need to be exported. Plus that means the removal of the TCP TS
> option would be done on the MPTCP side, and not here on the TCP side.
> It feels clearer to remove other TCP options from the TCP side, than
> hiding that from the MPTCP side.
>
> Yet an other alternative would be to pass the size already taken by the
> other TCP options, and have a way to drop them all when needed. But this
> feels better to target only the timestamps option where dropping it
> should be safe, even if it is currently the only option that would be
> set before MPTCP, when MPTCP is used.
>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> To: Neal Cardwell <ncardwell@google.com>
> To: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/mptcp.h   | 3 ++-
>  net/ipv4/tcp_output.c | 6 +++++-
>  net/mptcp/options.c   | 3 ++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index f7263fe2a2e4..000b6593bfa4 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -151,7 +151,7 @@ bool mptcp_synack_options(const struct request_sock *=
req, unsigned int *size,
>                           struct mptcp_out_options *opts);
>  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>                                unsigned int *size, unsigned int remaining=
,
> -                              struct mptcp_out_options *opts);
> +                              bool *drop_ts, struct mptcp_out_options *o=
pts);
>  bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
>
>  void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock=
 *tp,
> @@ -270,6 +270,7 @@ static inline bool mptcp_established_options(struct s=
ock *sk,
>                                              struct sk_buff *skb,
>                                              unsigned int *size,
>                                              unsigned int remaining,
> +                                            bool *drop_ts,
>                                              struct mptcp_out_options *op=
ts)
>  {
>         return false;
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index ef0c10cd31c7..53ee4c8f5f8c 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1181,12 +1181,16 @@ static unsigned int tcp_established_options(struc=
t sock *sk, struct sk_buff *skb
>          */
>         if (sk_is_mptcp(sk)) {
>                 unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> +               bool drop_ts =3D opts->options & OPTION_TS;
>                 unsigned int opt_size =3D 0;
>
>                 if (mptcp_established_options(sk, skb, &opt_size, remaini=
ng,
> -                                             &opts->mptcp)) {
> +                                             &drop_ts, &opts->mptcp)) {
>                         opts->options |=3D OPTION_MPTCP;
>                         size +=3D opt_size;
> +
> +                       if (drop_ts)
> +                               opts->options &=3D ~OPTION_TS;
>                 }
>         }

Passing local variables' addresses forces the compiler to use a stack
canary in this hot function, even for non-MPTCP flows.

I was about to test the following patch, which removes the current
stack canary caused by MPTCP :/

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-92 (-92)
Function                                     old     new   delta
tcp_options_write.isra                      1423    1407     -16
mptcp_established_options                   2746    2720     -26
tcp_established_options                      553     503     -50
Total: Before=3D22110750, After=3D22110658, chg -0.00%

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f7263fe2a2e40b507257c3720cc2d78d37357d6d..f55838fd6cca308908607243735=
f8768540bb419
100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -149,9 +149,9 @@ bool mptcp_syn_options(struct sock *sk, const
struct sk_buff *skb,
                       unsigned int *size, struct mptcp_out_options *opts);
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
                          struct mptcp_out_options *opts);
-bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
-                              unsigned int *size, unsigned int remaining,
-                              struct mptcp_out_options *opts);
+u32 mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+                             unsigned int remaining,
+                             struct mptcp_out_options *opts);
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);

 void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *=
tp,
@@ -266,13 +266,13 @@ static inline bool mptcp_synack_options(const
struct request_sock *req,
        return false;
 }

-static inline bool mptcp_established_options(struct sock *sk,
-                                            struct sk_buff *skb,
-                                            unsigned int *size,
-                                            unsigned int remaining,
-                                            struct mptcp_out_options *opts=
)
+static inline u32 mptcp_established_options(struct sock *sk,
+                                           struct sk_buff *skb,
+                                           unsigned int *size,
+                                           unsigned int remaining,
+                                           struct mptcp_out_options *opts)
 {
-       return false;
+       return 0;
 }

 static inline bool mptcp_incoming_options(struct sock *sk,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ef0c10cd31c71ff585a937fde37f2b08b1214b5a..594ec6ba02d5413d43842f79aef=
bf4d8355c4f3f
100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1183,10 +1183,11 @@ static unsigned int
tcp_established_options(struct sock *sk, struct sk_buff *skb
                unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
                unsigned int opt_size =3D 0;

-               if (mptcp_established_options(sk, skb, &opt_size, remaining=
,
-                                             &opts->mptcp)) {
+               opt_size =3D mptcp_established_options(sk, skb, remaining,
+                                                    &opts->mptcp);
+               if (opt_size) {
                        opts->options |=3D OPTION_MPTCP;
-                       size +=3D opt_size;
+                       size +=3D (opt_size & 63);
                }
        }

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index d96130e49942e2fb878cd1897ad43c1d420fb233..503ebd71d562134431cf0ea3327=
6c035bddae00c
100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -49,7 +49,7 @@ static struct mptcp_pernet *mptcp_get_pernet(const
struct net *net)

 int mptcp_is_enabled(const struct net *net)
 {
-       return mptcp_get_pernet(net)->mptcp_enabled;
+       return READ_ONCE(mptcp_get_pernet(net)->mptcp_enabled);
 }

 unsigned int mptcp_get_add_addr_timeout(const struct net *net)
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983cff3082d68290626dd8f1e044527f..4ac01cecb6bd965f1f95f6f2342=
515eb2b7591f5
100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -836,15 +836,15 @@ static bool
mptcp_established_options_mp_fail(struct sock *sk,
        return true;
 }

-bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
-                              unsigned int *size, unsigned int remaining,
-                              struct mptcp_out_options *opts)
+u32 mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+                             unsigned int remaining,
+                             struct mptcp_out_options *opts)
 {
        struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
        struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
        unsigned int opt_size =3D 0;
+       u32 total_size =3D 0;
        bool snd_data_fin;
-       bool ret =3D false;

        opts->suboptions =3D 0;

@@ -852,34 +852,33 @@ bool mptcp_established_options(struct sock *sk,
struct sk_buff *skb,
         * option space.
         */
        if (unlikely(__mptcp_check_fallback(msk) &&
!mptcp_check_infinite_map(skb)))
-               return true;
+               return 64;

        if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
                if (mptcp_established_options_fastclose(sk, &opt_size,
remaining, opts) ||
                    mptcp_established_options_mp_fail(sk, &opt_size,
remaining, opts)) {
-                       *size +=3D opt_size;
+                       total_size +=3D opt_size;
                        remaining -=3D opt_size;
                }
                /* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if
there is room */
                if (mptcp_established_options_rst(sk, skb, &opt_size,
remaining, opts)) {
-                       *size +=3D opt_size;
+                       total_size +=3D opt_size;
                        remaining -=3D opt_size;
                }
-               return true;
+               return 64 + total_size;;
        }

        snd_data_fin =3D mptcp_data_fin_enabled(msk);
        if (mptcp_established_options_mp(sk, skb, snd_data_fin,
&opt_size, opts))
-               ret =3D true;
+               total_size +=3D 64;
        else if (mptcp_established_options_dss(sk, skb, snd_data_fin,
&opt_size, opts)) {
                unsigned int mp_fail_size;

-               ret =3D true;
                if (mptcp_established_options_mp_fail(sk, &mp_fail_size,
                                                      remaining -
opt_size, opts)) {
-                       *size +=3D opt_size + mp_fail_size;
+                       total_size +=3D opt_size + mp_fail_size;
                        remaining -=3D opt_size - mp_fail_size;
-                       return true;
+                       return total_size;
                }
        }

@@ -887,27 +886,24 @@ bool mptcp_established_options(struct sock *sk,
struct sk_buff *skb,
         * TCP option space would be fatal
         */
        if (WARN_ON_ONCE(opt_size > remaining))
-               return false;
+               return 0;

-       *size +=3D opt_size;
+       total_size +=3D opt_size;
        remaining -=3D opt_size;
        if (mptcp_established_options_add_addr(sk, skb, &opt_size,
remaining, opts)) {
-               *size +=3D opt_size;
+               total_size +=3D opt_size;
                remaining -=3D opt_size;
-               ret =3D true;
        } else if (mptcp_established_options_rm_addr(sk, &opt_size,
remaining, opts)) {
-               *size +=3D opt_size;
+               total_size +=3D opt_size;
                remaining -=3D opt_size;
-               ret =3D true;
        }

        if (mptcp_established_options_mp_prio(sk, &opt_size, remaining, opt=
s)) {
-               *size +=3D opt_size;
+               total_size +=3D opt_size;
                remaining -=3D opt_size;
-               ret =3D true;
        }

-       return ret;
+       return total_size;
 }

 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,

