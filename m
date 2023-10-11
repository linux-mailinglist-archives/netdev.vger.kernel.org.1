Return-Path: <netdev+bounces-40019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A999B7C566C
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64415281353
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2F320312;
	Wed, 11 Oct 2023 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dv3wuSe4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF741F5E1
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:10:54 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ACF9E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 07:10:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so11413a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697033451; x=1697638251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1LLdJ8HtUR2rfStCF961xjiDWazPQlVdM1WZMSbnQ8=;
        b=dv3wuSe4DH3R709Tnt7PqaSe8G2kcqj42krLaD38nBVZG8MvpJhmiYYOuquIA1aiHd
         7EZNpwOfz7PVBHpy0J5glhaf8aErGJwD7xEOZNi/HwlA4MACrbkNtIX/pRvIjxOg+pWi
         wlurMiEXpWgcXghIYVsR9Kfj17jtLyiA4T/ABRu6jzND0Z1TaUqbeHKzCQmyxjmAASyp
         3z5k3k3JPoxoiV3+mCTxyCq8SI+SmSk26jGTwZf8e7XV9Ayif34+oV8nd4jt5X+1q5FQ
         l+568ZAOWRtJYgKhFOJq4k7tv3HdUqIyV163PXLG5vegO79kCBH4OzOavAfKLY47GB39
         Q2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697033451; x=1697638251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1LLdJ8HtUR2rfStCF961xjiDWazPQlVdM1WZMSbnQ8=;
        b=TzbGPdqSUFUKqq6pNSuSv9Gi/At3va28SJ4UEBQ902G1ZTd0dUcLZbiiPg69WNA9XG
         F5mwYJyTZYsU4jxrGnDk+aNI+57lB1j59QDI6VCrwbbxdI4QNDHj0zAsKHOtKKxDlzpA
         I/TRAVOdFXx4ZSwmKI3kL5Z3hcfkEF9Zu3JDM8LBVwRu9p4iQaDpdA6mCVygClY3CMGm
         cRK3DfZuPvVqnVrSvGAq8siNcjwAsrjUUEWj4ygHzNWiTa9ERs+yqCiPOgK8mZJar02e
         Ywel24D7Cu6aR55HIi/U9vpEufemOesWWFQeF2IX6n+ADcpZ64WKFA2uMYvjzRtMS8pX
         GOkw==
X-Gm-Message-State: AOJu0YzxLjn+WhvXla0pxjg/wUFM9L848MhjF4Jb49HySOgHmxyEm/zX
	5Hsqm4POgYUn4IIjVNzbKkAkuKYs3W0c6Dq0Zt+RTw==
X-Google-Smtp-Source: AGHT+IHjsAagw8GPbwBZ8LvLEZZnBHlc8tW15ZQxPcAikXo9oTr5M5S5Y/Gdsi2FcRoWzZHvDsjwQNAlemW0r2j2Uk4=
X-Received: by 2002:a50:8ad1:0:b0:538:5f9e:f0fc with SMTP id
 k17-20020a508ad1000000b005385f9ef0fcmr155118edk.0.1697033450668; Wed, 11 Oct
 2023 07:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011140126.800508-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20231011140126.800508-1-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Oct 2023 16:10:39 +0200
Message-ID: <CANn89iJ23Mz3tUXCdoLAHhNv0KKqRLG3k0J6aGVBio0bPyV-Bw@mail.gmail.com>
Subject: Re: [PATCH net] net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, andrew@daynix.com, jasowang@redhat.com, 
	Willem de Bruijn <willemb@google.com>, syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com, 
	syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 4:01=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> Syzbot reported two new paths to hit an internal WARNING using the
> new virtio gso type VIRTIO_NET_HDR_GSO_UDP_L4.
>
>     RIP: 0010:skb_checksum_help+0x4a2/0x600 net/core/dev.c:3260
>     skb len=3D64521 gso_size=3D344
> and
>
>     RIP: 0010:skb_warn_bad_offload+0x118/0x240 net/core/dev.c:3262
>
> Older virtio types have historically had loose restrictions, leading
> to many entirely impractical fuzzer generated packets causing
> problems deep in the kernel stack. Ideally, we would have had strict
> validation for all types from the start.
>
> New virtio types can have tighter validation. Limit UDP GSO packets
> inserted via virtio to the same limits imposed by the UDP_SEGMENT
> socket interface:
>
> 1. must use checksum offload
> 2. checksum offload matches UDP header
> 3. no more segments than UDP_MAX_SEGMENTS
> 4. UDP GSO does not take modifier flags, notably SKB_GSO_TCP_ECN
>
> Fixes: 860b7f27b8f7 ("linux/virtio_net.h: Support USO offload in vnet hea=
der.")
> Reported-by: syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/0000000000005039270605eb0b7f@googl=
e.com/
> Reported-by: syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/0000000000005426680605eb0b9f@googl=
e.com/
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>  include/linux/virtio_net.h | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 7b4dd69555e49..27cc1d4643219 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -3,8 +3,8 @@
>  #define _LINUX_VIRTIO_NET_H
>
>  #include <linux/if_vlan.h>
> +#include <linux/udp.h>
>  #include <uapi/linux/tcp.h>
> -#include <uapi/linux/udp.h>
>  #include <uapi/linux/virtio_net.h>
>
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_=
type)
> @@ -151,9 +151,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_bu=
ff *skb,
>                 unsigned int nh_off =3D p_off;
>                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
>
> -               /* UFO may not include transport header in gso_size. */
> -               if (gso_type & SKB_GSO_UDP)
> +               switch (gso_type & ~SKB_GSO_TCP_ECN) {
> +               case SKB_GSO_UDP:
> +                       /* UFO may not include transport header in gso_si=
ze. */
>                         nh_off -=3D thlen;
> +                       break;
> +               case SKB_GSO_UDP_L4:
> +                       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> +                               return -EINVAL;
> +                       if (skb->csum_offset !=3D offsetof(struct udphdr,=
 check))
> +                               return -EINVAL;
> +                       if (skb->len - p_off > gso_size * UDP_MAX_SEGMENT=
S)
> +                               return -EINVAL;
> +                       if (gso_type !=3D SKB_GSO_UDP_L4)
> +                               return -EINVAL;
> +                       break;
> +               }
>

Very nice, thanks Willem !

Reviewed-by: Eric Dumazet <edumazet@google.com>

