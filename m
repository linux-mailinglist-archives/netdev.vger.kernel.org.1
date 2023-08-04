Return-Path: <netdev+bounces-24459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035BD7703B6
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5381C21898
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCC9CA65;
	Fri,  4 Aug 2023 14:57:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD9FBA3B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:57:19 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA0B49CB
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:57:17 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40a47e8e38dso274341cf.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691161036; x=1691765836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIj/5qOXOWHYZDvOUWxDE4VdyMbKcD7v4NwJ57K3rsI=;
        b=yD1vDb7aJaPo+HSzz0ZVdYK27ZHgy+w782h29+AWpc2l5sl4WSOZWvNqSN4O0QaijY
         /KIe2poQ4LSNyH3kETGmS1BHXiFdvNL1eMv8fDh9njX3JlWExUAaf2TCm0ctvJTpeYWi
         7IQ+LA0rfh6byDK3/4EJgEpDsPX6cCqNJRhFNaHyv3JSx8ubUFTQ0JNYHIgl4cKqh1kT
         pzI49vrd2/izhrkC/jUe9bZVZbmIgS9clB2wV7wIOYobK+YyxlpNVx8m72xyNGfsRcwS
         x8B+1bjqYWHD00qFpO0FVLoIQcKrGY3OrTXntn3EvfOBxb7xST+EIzi3Dd3ToAAX3AJH
         6Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691161036; x=1691765836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIj/5qOXOWHYZDvOUWxDE4VdyMbKcD7v4NwJ57K3rsI=;
        b=DX1q1htTmOXwMM1Bh+084NTdAUr9zXLi4um36COwe+tSuEfDThaKbJZLNCJtyi4+Fp
         kqpBWhUbDBkIk/blT1yW8jzYnfHwHBthCmd4PVyFaox12XxzJLVcrDQYBlZj564DmLTg
         zYnzj03q2DwZDRKozUeAeWoGDEpEeAIc1Ranr/B+m8u7fIjIurCvvgLT7sSKYIP8/L5C
         fpObdT3R4Hxj/sQZ5VeF49T6HaY74J/3BtRyon9X1F1XpKU5DXhafpmrOwyS803t+qZl
         m5M4arN+ZE9Kz8Q7k4xNvZBxtx9ee3frsE7zLXlArp7JBbNPIiqOosQP9imlB11EWsKG
         AyDQ==
X-Gm-Message-State: AOJu0YzGO2acZuyE5/ViiT9W/MwOMIlLJgOrfbzHePhR/pkZO0Yxlw0N
	g7g23Gu27YwY5czqB5rDjsDXMCRlVK5tRidyOc+vqA==
X-Google-Smtp-Source: AGHT+IGUb+P7BI+xJfbpoAcIwwnKkZIVeZz+H+2L6kUpQhI8/LIgmU/zWKpLAd44s1ArcA6M0FkMDZ+7aAymIh86xtE=
X-Received: by 2002:a05:622a:1648:b0:3f8:5b2:aef5 with SMTP id
 y8-20020a05622a164800b003f805b2aef5mr180951qtj.29.1691161036209; Fri, 04 Aug
 2023 07:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <16be6307909b25852744a67b2caf570efbb83c7f.1684502478.git.asml.silence@gmail.com>
 <ZM0QHZNKLQ9kVlJ8@zx2c4.com>
In-Reply-To: <ZM0QHZNKLQ9kVlJ8@zx2c4.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Aug 2023 16:57:04 +0200
Message-ID: <CANn89i+_DoEDcFY9SfNqQ+8bqJ0kFpt4waQ8CSvhchE4aP2Dhw@mail.gmail.com>
Subject: Re: [PATCH net-next] net/tcp: refactor tcp_inet6_sk()
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 4, 2023 at 4:51=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com>=
 wrote:
>
> Hi Pavel,
>
> On Fri, May 19, 2023 at 02:30:36PM +0100, Pavel Begunkov wrote:
> > Don't keep hand coded offset caluclations and replace it with
> > container_of(). It should be type safer and a bit less confusing.
> >
> > It also makes it with a macro instead of inline function to preserve
> > constness, which was previously casted out like in case of
> > tcp_v6_send_synack().
> >
> > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > ---
> >  net/ipv6/tcp_ipv6.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 7132eb213a7a..d657713d1c71 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -93,12 +93,8 @@ static struct tcp_md5sig_key *tcp_v6_md5_do_lookup(c=
onst struct sock *sk,
> >   * This avoids a dereference and allow compiler optimizations.
> >   * It is a specialized version of inet6_sk_generic().
> >   */
> > -static struct ipv6_pinfo *tcp_inet6_sk(const struct sock *sk)
> > -{
> > -     unsigned int offset =3D sizeof(struct tcp6_sock) - sizeof(struct =
ipv6_pinfo);
> > -
> > -     return (struct ipv6_pinfo *)(((u8 *)sk) + offset);
> > -}
> > +#define tcp_inet6_sk(sk) (&container_of_const(tcp_sk(sk), \
> > +                                           struct tcp6_sock, tcp)->ine=
t6)
> >
> >  static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff =
*skb)
> >  {
> > @@ -533,7 +529,7 @@ static int tcp_v6_send_synack(const struct sock *sk=
, struct dst_entry *dst,
> >                             struct sk_buff *syn_skb)
> >  {
> >       struct inet_request_sock *ireq =3D inet_rsk(req);
> > -     struct ipv6_pinfo *np =3D tcp_inet6_sk(sk);
> > +     const struct ipv6_pinfo *np =3D tcp_inet6_sk(sk);
> >       struct ipv6_txoptions *opt;
> >       struct flowi6 *fl6 =3D &fl->u.ip6;
> >       struct sk_buff *skb;
> > --
> > 2.40.0
>
> This patch broke the WireGuard test suite on 32-bit platforms:
>
> https://build.wireguard.com/wireguard-linux-stable/bf400e83708d055bdf4425=
77ed2f2a8eb87a06f2/i686.log
> https://build.wireguard.com/wireguard-linux-stable/bf400e83708d055bdf4425=
77ed2f2a8eb87a06f2/arm.log
> https://build.wireguard.com/wireguard-linux-stable/bf400e83708d055bdf4425=
77ed2f2a8eb87a06f2/armeb.log
> https://build.wireguard.com/wireguard-linux-stable/bf400e83708d055bdf4425=
77ed2f2a8eb87a06f2/powerpc.log
> https://build.wireguard.com/wireguard-linux-stable/bf400e83708d055bdf4425=
77ed2f2a8eb87a06f2/mips.log
> https://build.wireguard.com/wireguard-linux-stable/bf400e83708d055bdf4425=
77ed2f2a8eb87a06f2/mipsel.log
>
> The common point of failure in each of these is something like:
>
> [+] NS1: iperf3 -s -1 -B fd00::1
> [+] NS1: wait for iperf:5201 pid 115
> -----------------------------------------------------------
> Server listening on 5201 (test #1)
> -----------------------------------------------------------
> [+] NS2: iperf3 -Z -t 3 -c fd00::1
> [    8.908396] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from=
 peer 1 (127.0.0.1:2)
> [    9.955882] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from=
 peer 1 (127.0.0.1:2)
> [   10.994917] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from=
 peer 1 (127.0.0.1:2)
> [   12.034269] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from=
 peer 1 (127.0.0.1:2)
> [   13.073905] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from=
 peer 1 (127.0.0.1:2)
> [   14.114022] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from=
 peer 1 (127.0.0.1:2)
> [   16.194810] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from=
 peer 1 (127.0.0.1:2)
> [   19.074925] wireguard: wg0: Sending keepalive packet to peer 1 (127.0.=
0.1:2)
> [   19.075934] wireguard: wg0: Receiving keepalive packet from peer 2 (12=
7.0.0.1:1)
> [   20.273212] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from=
 peer 1 (127.0.0.1:2)
> [   28.682020] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from=
 peer 1 (127.0.0.1:2)
> [   30.593430] wireguard: wg0: Sending keepalive packet to peer 1 (127.0.=
0.1:2)
> [   30.595999] wireguard: wg0: Receiving keepalive packet from peer 2 (12=
7.0.0.1:1)
> [   45.315640] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from=
 peer 1 (127.0.0.1:2)
> [   55.560359] wireguard: wg0: Sending keepalive packet to peer 1 (127.0.=
0.1:2)
> [   55.561675] wireguard: wg0: Receiving keepalive packet from peer 2 (12=
7.0.0.1:1)
> [   77.961218] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from=
 peer 1 (127.0.0.1:2)
> [   88.200150] wireguard: wg0: Sending keepalive packet to peer 1 (127.0.=
0.1:2)
> [   88.201031] wireguard: wg0: Receiving keepalive packet from peer 2 (12=
7.0.0.1:1)
> iperf3: error - unable to connect to server: Operation timed out
>
> For some strange reason, the packets appear to have a src IP of
> "::2:0:0" instead of fd00::2. It looks like some kind of offset issue, I
> suppose. So you may want to revert this or reevaluate the calculation of
> `offset` here, as there's something screwy happening on 32-bit systems.
>
> Jason

I think my patch fixed this issue, can you double check ?

f5f80e32de12fad2813d37270e8364a03e6d3ef0 ipv6: remove hard coded
limitation on ipv6_pinfo

I was not sure if Pavel was problematic or not, I only guessed.

