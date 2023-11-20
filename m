Return-Path: <netdev+bounces-49101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEBA7F0D41
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525782818F2
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C7DDDD0;
	Mon, 20 Nov 2023 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1pcShc/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1902CBF
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:13:42 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40a426872c6so74035e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700468020; x=1701072820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySw0qtg+WxhKLGI52I8kF3Irzl2p1qKlTqN2J/L3ZEY=;
        b=F1pcShc/E9pTjouRr3oAjozw1km843+oW21ak3cOV1eMVDvKfTYHrHEY8wvZrONvNC
         0swgsd+mt+LpFTOVJ5tSOFEO2+9SNyu+w455gAHRxGlhLqEJ22NiB/oJepjpQqvkWhe8
         4LZrd9U1ig9H0o250kqG5LztaOzEYg5TIK1zH5jvrMs/vdpkL2/0ssWw6XdAaosbqT68
         tjhGqlI6mhkqk3zJmTQBGWVs5H875p9qsGhra1I6ChR7pOfzQNfQG0YwsIBxcqaZl1OU
         1u+4SikG+ofkBD9JZXHdrwiwBSiXdO7aKVrbnzmzDwmqQw0cyb/v2WaVGvzDvVQHvh/0
         opiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700468020; x=1701072820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySw0qtg+WxhKLGI52I8kF3Irzl2p1qKlTqN2J/L3ZEY=;
        b=Ym7yYJdGJEBkZz8/4A7UNsSDMnOY0ODUqon1mULEopI8UxdiMmFt9IPfoAVZaEQDwm
         vGg+cbDfT9/NWCCd8QLHYRtcvBtujopoeAjIPG+9G8FWW5jGiyH7duGYGANAFzDxOVvb
         0ttmCn04onsPUDGh7x7Jd5siolgwexF+gxXTXG/IFwQDn5VBmgE9RnZVBzLZxIcnvat/
         LJeqp9n1mnx9CG9mGTK18DI31OP2g7WrO/nJWA2yearXb0p8ew85q/5fc5EOKAWFhzsp
         vfE8bQlUAh4ZhIBT/zxtksywQqxvKZfYmTJg266E31RCOwcnzJoDs3DgEJz1Ukr0VFPW
         xlgg==
X-Gm-Message-State: AOJu0YzqUFOMCRE9kUGS0coM6uhoKZ1zRV+pVQhY+NIAoXoU+byrnsRp
	UAiYazL1iIBI3b81tlPJHC+uOhjfUvpLe3/klPIfJw==
X-Google-Smtp-Source: AGHT+IGruP2/Cey+KzuQd6wI8ibOlce8NTI4ucuag38htThS4b+/fELbYPTj62639XqqIaMhc8GkZVGHtAkTy0dlOwE=
X-Received: by 2002:a05:600c:5013:b0:405:35bf:7362 with SMTP id
 n19-20020a05600c501300b0040535bf7362mr364310wmr.0.1700468020195; Mon, 20 Nov
 2023 00:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117141733.3344158-1-edumazet@google.com> <170042342319.11006.13933415217196728575.git-patchwork-notify@kernel.org>
 <CAHmME9q4uSKxtEnRmcM2h2GGSBcq9Hu_9tk3EX2_EVGFXr6KnQ@mail.gmail.com> <CANn89iLm0SX4dF1Y29ui=SxO5ut=v66S6SvgFsD2cjU=JN1pmA@mail.gmail.com>
In-Reply-To: <CANn89iLm0SX4dF1Y29ui=SxO5ut=v66S6SvgFsD2cjU=JN1pmA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Nov 2023 09:13:29 +0100
Message-ID: <CANn89iJx-fbmd2v6PaKKSNY30X7Wz-TwM_ZxPs=5aNMV51x+iw@mail.gmail.com>
Subject: Re: [PATCH v2 net] wireguard: use DEV_STATS_INC()
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzkaller@googlegroups.com, liuhangbin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 8:56=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>

> Jason, I was in week end mode, so could not reply to your message.
>
> This fix is rather obvious to me. I do not want to spend too much time on=
 it,
> and you gave an ACK if I am not mistaken.
>
> If you prefer not letting syzbot find other bugs in wireguard (because
> hitting this issue first),
> this is fine by me. We can ask syzbot team to not include wireguard in
> their kernels.

BTW, while cooking the patch I found that wireguard was incorrectly
using dev_kfree_skb() instead of kfree_skb().

dev_kfree_skb() is really a consume_skb(), which gives different drop
monitor signals

(perf record -a -e skb:kfree_skb)  vs (perf record -a -e skb:consume_skb)

I would suggest you take a look.

Ideally, using kfree_skb_reason(skb, reason) (for net-next tree) would
help future diagnostics.

For net tree I would suggest

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.=
c
index 258dcc1039216f311a223fd348295d4b5e03a3ed..0b0e2a9fd14d14fb3c77004074e=
2b088364d332a
100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -209,7 +209,7 @@ static netdev_tx_t wg_xmit(struct sk_buff *skb,
struct net_device *dev)
         * we don't remove GSO segments that are in excess.
         */
        while (skb_queue_len(&peer->staged_packet_queue) > MAX_STAGED_PACKE=
TS) {
-               dev_kfree_skb(__skb_dequeue(&peer->staged_packet_queue));
+               kfree_skb(__skb_dequeue(&peer->staged_packet_queue));
                ++dev->stats.tx_dropped;
        }
        skb_queue_splice_tail(&packets, &peer->staged_packet_queue);
diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receiv=
e.c
index 0b3f0c843550957ee1fe3bed7185a7d990246c2b..a9e76722b22cad65bda91f306fa=
d11cdb6acff09
100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -432,7 +432,7 @@ static void wg_packet_consume_data_done(struct
wg_peer *peer,
        ++dev->stats.rx_length_errors;
        goto packet_processed;
 packet_processed:
-       dev_kfree_skb(skb);
+       kfree_skb(skb);
 }

 int wg_packet_rx_poll(struct napi_struct *napi, int budget)
@@ -478,7 +478,7 @@ int wg_packet_rx_poll(struct napi_struct *napi, int bud=
get)
                wg_noise_keypair_put(keypair, false);
                wg_peer_put(peer);
                if (unlikely(free))
-                       dev_kfree_skb(skb);
+                       kfree_skb(skb);

                if (++work_done >=3D budget)
                        break;
@@ -536,7 +536,7 @@ static void wg_packet_consume_data(struct
wg_device *wg, struct sk_buff *skb)
 err_keypair:
        rcu_read_unlock_bh();
        wg_peer_put(peer);
-       dev_kfree_skb(skb);
+       kfree_skb(skb);
 }

 void wg_packet_receive(struct wg_device *wg, struct sk_buff *skb)
@@ -582,5 +582,5 @@ void wg_packet_receive(struct wg_device *wg,
struct sk_buff *skb)
        return;

 err:
-       dev_kfree_skb(skb);
+       kfree_skb(skb);
 }
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.=
c
index 0414d7a6ce74141cd2ca365bfd1da727691e27ec..7e773a2c8a8532caef06205f53e=
6b505dbe9ff57
100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -178,7 +178,7 @@ int wg_socket_send_skb_to_peer(struct wg_peer
*peer, struct sk_buff *skb, u8 ds)
                ret =3D send6(peer->device, skb, &peer->endpoint, ds,
                            &peer->endpoint_cache);
        else
-               dev_kfree_skb(skb);
+               kfree_skb(skb);
        if (likely(!ret))
                peer->tx_bytes +=3D skb_len;
        read_unlock_bh(&peer->endpoint_lock);

