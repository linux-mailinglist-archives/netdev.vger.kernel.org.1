Return-Path: <netdev+bounces-34462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27357A43DD
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDD42823D7
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36545134BD;
	Mon, 18 Sep 2023 08:06:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C94C94
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:06:06 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821E1CC1
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 01:05:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41513d2cca7so420351cf.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695024320; x=1695629120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPWRnEDlmzjDvKCuAcepEH2uKQacvVIlU4RvOyhuSnA=;
        b=GllnoLzg7aWr3e6VmVYQq8dkj6H7ipAuoWhjF0SUuytBFGUkhsQpzvh5bffYVy9N9Z
         nRwvXFJGTNlOIAdW/hFIBCEMPAnbCykXKTJVPx1v2eMveiT2QtSAf7Ee+o0tuj1AliLM
         G9qjjgk42Z3zGkmACJDfFfkbhdyUWBPcCYJ3A+XfzkdqufjdSTOE6kSbdZXgbiL078Ao
         3q8oSIFQ11AQsmUP6Z1nB0pfaUOonUtNDqCdsCTvofhgebsV+FDZTE9hkGpO1fMSu6Id
         j5mpkS1g+tp+YVCUhtqoZ5rUAv1JmDbUu0jRzYPsXpSu0GaCfVNDrByjIjZHFWgl/nOC
         nH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695024320; x=1695629120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPWRnEDlmzjDvKCuAcepEH2uKQacvVIlU4RvOyhuSnA=;
        b=TmvXdC3pvk5Zb14/wlHmmJPuBX7QyXAVu1k8Xu3OHukPx6pbcsuVjdvypFp36AhUY8
         vmm5waUtLR1Va+DSNtEmK3/wzhrXtNem5nAsLPaiyPCjT9qLigUedV5NcR5y9jhDQLxg
         rLJ/mzHFne+lgK1aFqgh9aMJ5ORdnEzeC+Lz5pqAL7ytXaZa36CxK/JJ2eAc5R11k4dB
         E/D1giykhjukoNaB0blC/yNa0BHd4DORvdi8MIv9ap+2BB2IHbfHDJjwzgdCoeeWvaER
         kqdpBenChZAa+bja0FNPKjl/szxVYtEGR9MHs6QLhBf1ZxQnZAlzm53mxzs+LVPTxXF+
         CWow==
X-Gm-Message-State: AOJu0YwlBBMjAofbX5j9o98ue6DiAZToa1/V4EQIUjzlgk0O5GEM2rUn
	83S89wyfGllL7gqjpXpHUvIVASlPEZ5pGdAU7PmBJ74sGGYTznvukLI=
X-Google-Smtp-Source: AGHT+IFRIMz0D/vZED3GkAZFZcTtAHDSy2HcE7KbS6iJ5+GbAWb7kjTWJ3WhxNfrV7aD1K21VRYJqOQvJc/7LTZGChc=
X-Received: by 2002:a05:622a:1307:b0:40f:d1f4:aa58 with SMTP id
 v7-20020a05622a130700b0040fd1f4aa58mr316425qtk.8.1695024320296; Mon, 18 Sep
 2023 01:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918014752.1791518-1-guodongtai@kylinos.cn>
In-Reply-To: <20230918014752.1791518-1-guodongtai@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Sep 2023 10:05:09 +0200
Message-ID: <CANn89i+WshtNwNSALCpbQbZFWN41xP85+c8GdHX2DabzQzx+6A@mail.gmail.com>
Subject: Re: [PATCH v1] tcp: enhancing timestamps random algo to address
 issues arising from NAT mapping
To: George Guo <guodongtai@kylinos.cn>, Florian Westphal <fw@strlen.de>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 3:46=E2=80=AFAM George Guo <guodongtai@kylinos.cn> =
wrote:
>
> Tsval=3Dtsoffset+local_clock, here tsoffset is randomized with saddr and =
daddr parameters in func
> secure_tcp_ts_off. Most of time it is OK except for NAT mapping to the sa=
me port and daddr.
> Consider the following scenario:
>         ns1:                ns2:
>         +-----------+        +-----------+
>         |           |        |           |
>         |           |        |           |
>         |           |        |           |
>         | veth1     |        | vethb     |
>         |192.168.1.1|        |192.168.1.2|
>         +----+------+        +-----+-----+
>              |                     |
>              |                     |
>              | br0:192.168.1.254   |
>              +----------+----------+
>          veth0          |     vetha
>          192.168.1.3    |    192.168.1.4
>                         |
>                        nat(192.168.1.x -->172.30.60.199)
>                         |
>                         V
>                        eth0
>                  172.30.60.199
>                        |
>                        |
>                        +----> ... ...    ---->server: 172.30.60.191
>
> Let's say ns1 (192.168.1.1) generates a timestamp ts1, and ns2 (192.168.1=
.2) generates a timestamp
> ts2, with ts1 > ts2.
>
> If ns1 initiates a connection to a server, and then the server actively c=
loses the connection,
> entering the TIME_WAIT state, and ns2 attempts to connect to the server w=
hile port reuse is in
> progress, due to the presence of NAT, the server sees both connections as=
 originating from the
> same IP address (e.g., 172.30.60.199) and port. However, since ts2 is sma=
ller than ts1, the server
> will respond with the acknowledgment (ACK) for the fourth handshake.
>
>        SERVER                                                   CLIENT
>
>    1.  ESTABLISHED                                              ESTABLISH=
ED
>
>        (Close)
>    2.  FIN-WAIT-1  --> <SEQ=3D100><ACK=3D300><TSval=3D20><CTL=3DFIN,ACK> =
 --> CLOSE-WAIT
>
>    3.  FIN-WAIT-2  <-- <SEQ=3D300><ACK=3D101><TSval=3D40><CTL=3DACK>     =
 <-- CLOSE-WAIT
>
>                                                             (Close)
>    4.  TIME-WAIT   <-- <SEQ=3D300><ACK=3D101><TSval=3D41><CTL=3DFIN,ACK> =
 <-- LAST-ACK
>
>    5.  TIME-WAIT   --> <SEQ=3D101><ACK=3D301><TSval=3D25><CTL=3DACK>     =
 --> CLOSED
>
>   - - - - - - - - - - - - - port reused - - - - - - - - - - - - - - -
>
>    5.1. TIME-WAIT   <-- <SEQ=3D255><TSval=3D30><CTL=3DSYN>             <-=
- SYN-SENT
>
>    5.2. TIME-WAIT   --> <SEQ=3D101><ACK=3D301><TSval=3D35><CTL=3DACK>    =
--> SYN-SENT
>
>    5.3. CLOSED      <-- <SEQ=3D301><CTL=3DRST>                       <-- =
SYN-SENT
>
>    6.  SYN-RECV    <-- <SEQ=3D255><TSval=3D34><CTL=3DSYN>              <-=
- SYN-SENT
>
>    7.  SYN-RECV    --> <SEQ=3D400><ACK=3D301><TSval=3D40><CTL=3DSYN,ACK> =
--> ESTABLISHED
>
>    1.  ESTABLISH   <-- <SEQ=3D301><ACK=3D401><TSval=3D55><CTL=3DACK>     =
<-- ESTABLISHED
>
> This enhancement uses sport and daddr rather than saddr and daddr, which =
keep the timestamp
> monotonically increasing in the situation described above. Then the port =
reuse is like this:
>
>        SERVER                                                   CLIENT
>
>    1.  ESTABLISHED                                              ESTABLISH=
ED
>
>        (Close)
>    2.  FIN-WAIT-1  --> <SEQ=3D100><ACK=3D300><TSval=3D20><CTL=3DFIN,ACK> =
 --> CLOSE-WAIT
>
>    3.  FIN-WAIT-2  <-- <SEQ=3D300><ACK=3D101><TSval=3D40><CTL=3DACK>     =
 <-- CLOSE-WAIT
>
>                                                             (Close)
>    4.  TIME-WAIT   <-- <SEQ=3D300><ACK=3D101><TSval=3D41><CTL=3DFIN,ACK> =
 <-- LAST-ACK
>
>    5.  TIME-WAIT   --> <SEQ=3D101><ACK=3D301><TSval=3D25><CTL=3DACK>     =
 --> CLOSED
>
>   - - - - - - - - - - - - - port reused - - - - - - - - - - - - - - -
>
>    5.1. TIME-WAIT  <-- <SEQ=3D300><TSval=3D50><CTL=3DSYN>               <=
-- SYN-SENT
>
>    6.  SYN-RECV    --> <SEQ=3D400><ACK=3D301><TSval=3D40><CTL=3DSYN,ACK> =
 --> ESTABLISHED
>
>    1.  ESTABLISH   <-- <SEQ=3D301><ACK=3D401><TSval=3D55><CTL=3DACK>     =
 <-- ESTABLISHED
>
> The enhancement lets port reused more efficiently.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
>

CC Florian

I do not think we can 'fix' tcp timestamp vs NAT.
Unless the NAT device makes sure a port is dedicated for a peer,
and/or the NAT rewrites TS values
(which would be bad).

I personally prefer seeing the same timestamps from A to B regardless
of ports, it helps detect various issues.

Also, you seem to forget IPv6.

