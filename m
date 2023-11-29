Return-Path: <netdev+bounces-52074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AC07FD361
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF0CB21215
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 09:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693E110A3E;
	Wed, 29 Nov 2023 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTANzMCh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018EE1990
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 01:57:03 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so7235a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 01:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701251822; x=1701856622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXYNQrSbVTf8zEsnX55zuu3kq6c/d0O7iO32AeRZ+No=;
        b=TTANzMChzHSN9nPR9iKCCG2LK8QA2Ju6QgHHtKATcoOGO22/ysM0hlfnTqCzowhZMQ
         gVN0Hm0K/BxL6Pf27mfgprCooNxjCB8cPrAckID2/rcoOt6ar9Dn68qj0KHgpovhTq/h
         CD25SRGBE1xVMMD44K3XVUOIwv08y4wUfDNCMRFdvQPHlKIFD3UiYTj2KXzWt+nJV7GJ
         TNeeZsMRwb+kVmkgUr1/hDLNX/DDSNiq48tIbv+xHMj75lW3pPTgvtdMlMFpQ7MPrO3X
         htDI5qlCUnK7VLrbd48G8AvjgqnBy80sKUhg5uZVnGUR3+pXjRAF/uRYd+7b0FQkPmxl
         mJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701251822; x=1701856622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXYNQrSbVTf8zEsnX55zuu3kq6c/d0O7iO32AeRZ+No=;
        b=PEjsyJVBxf1fEKWcjfMJ2+lRNh7Pg4xZwT8xzM1Qes2LLpRjfU/f+H3u1ATg+hbPdg
         9RLHKzb68aK+GE+qb/Cy6BcKBW5qrLpQ3CLOQ4SoY4Di4cOactG3LHP9Z48i/0XlHN2Z
         rRYmxzNSqbZvZoTSxlkUWRpdySWEcO5rRChfB/zGH77ngZ6MmI9nXXuCmOoMF7LqSRSV
         Q+lThclJS3TiBe85uEyL0dL3AO31sbFO5cT0p+3GfIh9MdaryEwrKja3DPAfKbatG/0M
         XV4c9CJ2obHEQvyJjHK1TxJF2J7lOUbFqq+zAdcAVDJJXvj+22/1QLX3cRUXxC6sysxi
         4i5A==
X-Gm-Message-State: AOJu0Yy1/wNxcnaoa4J5PfRrYYQEh1J977zfCFkMtM5uSawxeYPh2KqY
	3FI4X0Jk4Nzsi7gy0nEjTotf3lvL7VlK/rRe1zFbTw==
X-Google-Smtp-Source: AGHT+IHveQYEKya0SCKajXcGkmUIMdtuTLMoi09hQlloekWCp80aSgQvXbxLSLje6eiqLFEcWi2oHI3l/+A/YZuMcIA=
X-Received: by 2002:a05:6402:430e:b0:54b:67da:b2f with SMTP id
 m14-20020a056402430e00b0054b67da0b2fmr561416edc.7.1701251822078; Wed, 29 Nov
 2023 01:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126151652.372783-1-syoshida@redhat.com> <6564bbd5580de_8a1ac29481@willemb.c.googlers.com.notmuch>
 <20231129.105046.2126277148145584341.syoshida@redhat.com>
In-Reply-To: <20231129.105046.2126277148145584341.syoshida@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Nov 2023 10:56:47 +0100
Message-ID: <CANn89iLxEZAjomWEW4GFJds6kyd6Zf+ed9kx6eVsaQ57De6gMw@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in ipgre_xmit()
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 2:51=E2=80=AFAM Shigeru Yoshida <syoshida@redhat.co=
m> wrote:
>
> On Mon, 27 Nov 2023 10:55:01 -0500, Willem de Bruijn wrote:
> > Shigeru Yoshida wrote:
> >> In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() retu=
rns
> >> true. For example, applications can create a malformed packet that cau=
ses
> >> this problem with PF_PACKET.
> >
> > It may fail because because pskb_inet_may_pull does not account for
> > tunnel->hlen.
> >
> > Is that what you are referring to with malformed packet? Can you
> > eloborate a bit on in which way the packet has to be malformed to
> > reach this?
>
> Thank you very much for your prompt feedback.
>
> Actually, I found this problem by running syzkaller. Syzkaller
> reported the following uninit-value issue (I think the root cause of
> this issue is the same as the one Eric mentioned):

Yes, I also have a similar syzbot report (but no repro yet) I am
releasing it right now.

>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in __gre_xmit net/ipv4/ip_gre.c:469 [inline]
> BUG: KMSAN: uninit-value in ipgre_xmit+0xdf4/0xe70 net/ipv4/ip_gre.c:662
>  __gre_xmit net/ipv4/ip_gre.c:469 [inline]
>



> The simplified version of the repro is shown below:
>
> #include <linux/if_ether.h>
> #include <sys/ioctl.h>
> #include <netinet/ether.h>
> #include <net/if.h>
> #include <sys/socket.h>
> #include <netinet/in.h>
> #include <string.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <linux/if_packet.h>
>
> int main(void)
> {
>         int s, s1, s2, data =3D 0;
>         struct ifreq ifr;
>         struct sockaddr_ll addr =3D { 0 };
>         unsigned char mac_addr[] =3D {0x1, 0x2, 0x3, 0x4, 0x5, 0x6};
>
>         s =3D socket(AF_PACKET, SOCK_DGRAM, 0x300);
>         s1 =3D socket(AF_PACKET, SOCK_RAW, 0x300);
>         s2 =3D socket(AF_NETLINK, SOCK_RAW, 0);
>
>         strcpy(ifr.ifr_name, "gre0");
>         ioctl(s2, SIOCGIFINDEX, &ifr);
>
>         addr.sll_family =3D AF_PACKET;
>         addr.sll_ifindex =3D ifr.ifr_ifindex;
>         addr.sll_protocol =3D htons(0);
>         addr.sll_hatype =3D ARPHRD_ETHER;
>         addr.sll_pkttype =3D PACKET_HOST;
>         addr.sll_halen =3D ETH_ALEN;
>         memcpy(addr.sll_addr, mac_addr, ETH_ALEN);
>
>         sendto(s1, &data, 1, 0, (struct sockaddr *)&addr, sizeof(addr));
>
>         return 0;
> }
>
> The repro sends a 1-byte packet that doesn't have the correct IP
> header. I meant this as "malformed pachet", but that might be a bit
> confusing, sorry.
>
> I think the cause of the uninit-value access is that ipgre_xmit()
> reallocates the skb with skb_cow_head() and copies only the 1-byte
> data, so any IP header access through `tnl_params` can cause the
> problem.
>
> At first I tried to modify pskb_inet_may_pull() to detect this type of
> packet, but I ended up doing this patch.

Even after your patch, __skb_pull() could call BUG() and crash.

I would suggest using this fix instead.

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 22a26d1d29a09d234f18ce3b0f329e5047c0c046..5169c3c72cffe49cef613e69889=
d139db867ff74
100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -635,15 +635,18 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
        }

        if (dev->header_ops) {
+               int pull_len =3D tunnel->hlen + sizeof(struct iphdr);
+
                if (skb_cow_head(skb, 0))
                        goto free_skb;

                tnl_params =3D (const struct iphdr *)skb->data;

-               /* Pull skb since ip_tunnel_xmit() needs skb->data pointing
-                * to gre header.
-                */
-               skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
+               if (!pskb_network_may_pull(skb, pull_len))
+                       goto free_skb;
+
+               /* ip_tunnel_xmit() needs skb->data pointing to gre header.=
 */
+               skb_pull(skb, pull_len);
                skb_reset_mac_header(skb);

                if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&

