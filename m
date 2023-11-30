Return-Path: <netdev+bounces-52537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2297FF12C
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1499C282501
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE160487B3;
	Thu, 30 Nov 2023 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJFfWf0V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7504196
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 06:05:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so10579a12.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 06:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701353150; x=1701957950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImwHFURbq6hKN/keUK8aNThOCC0p1tGX8QSbugfi08c=;
        b=mJFfWf0VjcjOkdP3NhxYjD/uRd/zmUyGJozyrEMrbG2d7NBGfFq7tyVwIBfTQDWsHM
         v9sePPmMZfzhgd8K66TL67sEhdMNgn6tWYDY1WrAquPcNFw5lDfWmZUWLRCDPm55ngAj
         JYCZwl6vWXEu/QiqWWJ1k0mXqPLdHL8FzcFbGKonPY+uJMlUupWznE/g9/1wNd1goA1m
         lWlO1BYsKdoa5f58+G3gjN1Gou2d5y9d7eaiI9NKqZMHi0vaKo4t0nadfLBf9PjRePF8
         cNbYBYp7iw5hW4OWH6Smy9Vnk50Wk1iE5VdQfkmS8KFADvenBcheAkH8AzxlSe6tMI/j
         Hsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353150; x=1701957950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImwHFURbq6hKN/keUK8aNThOCC0p1tGX8QSbugfi08c=;
        b=BVYz8C6wkbSlUQNQ2+zdjenuhNmb1BTYhwxVeNhpe/h309+QLJEs4e4JYait/SO4WC
         RummPctw7YA1fquylj8rkBEZfr1fcbN8aFrhTW7xyMhQLT4e3E+NlrYaH1J1KAKox392
         vngsM4O1sQtVzMidCu/jOq1xYLDVHRhgHsyG6+cNkV1mzllsDa396oS1EZ+WjyYTuCXM
         4GRYlWu2HshIwGfJsanQoJ9uq74/lQ+G7X6W4gpkOjCqBTU5yWJmsIqjxsW2tuDkMwL+
         PMY5C27+ZP8bbmgmYJxn/6O3YSyB3QbM5xGjeppTFz6gS0ff44AfxN96xRxX7St+ew0E
         cohw==
X-Gm-Message-State: AOJu0YyHEgvFg3gta6TrTpaFmRBSI39ix/szHgBstoYRKtzokD3Raj7c
	ydKnVvJctpdq2glkevO4QXuaMphCLIiQ9I7B06q6/A==
X-Google-Smtp-Source: AGHT+IGB/oNM3pi5zkTnn2b4TwS9JWsLEAZuZZRjBNgCJybg0ElnesfwqQR+J/SYxkhhj1Qw2OUXTWz61L1kgNY09Ss=
X-Received: by 2002:a05:6402:1cae:b0:54b:81ba:93b2 with SMTP id
 cz14-20020a0564021cae00b0054b81ba93b2mr165225edb.2.1701353150080; Thu, 30 Nov
 2023 06:05:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6564bbd5580de_8a1ac29481@willemb.c.googlers.com.notmuch>
 <20231129.105046.2126277148145584341.syoshida@redhat.com> <CANn89iLxEZAjomWEW4GFJds6kyd6Zf+ed9kx6eVsaQ57De6gMw@mail.gmail.com>
 <20231130.230329.2023533070545022513.syoshida@redhat.com>
In-Reply-To: <20231130.230329.2023533070545022513.syoshida@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 15:05:38 +0100
Message-ID: <CANn89i+u6tFJQKESV9DH-HypezVV7Ux+XhnyFGLd833PR9Qpyw@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in ipgre_xmit()
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 3:03=E2=80=AFPM Shigeru Yoshida <syoshida@redhat.co=
m> wrote:
>
> On Wed, 29 Nov 2023 10:56:47 +0100, Eric Dumazet wrote:
> > On Wed, Nov 29, 2023 at 2:51=E2=80=AFAM Shigeru Yoshida <syoshida@redha=
t.com> wrote:
> >>
> >> On Mon, 27 Nov 2023 10:55:01 -0500, Willem de Bruijn wrote:
> >> > Shigeru Yoshida wrote:
> >> >> In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() r=
eturns
> >> >> true. For example, applications can create a malformed packet that =
causes
> >> >> this problem with PF_PACKET.
> >> >
> >> > It may fail because because pskb_inet_may_pull does not account for
> >> > tunnel->hlen.
> >> >
> >> > Is that what you are referring to with malformed packet? Can you
> >> > eloborate a bit on in which way the packet has to be malformed to
> >> > reach this?
> >>
> >> Thank you very much for your prompt feedback.
> >>
> >> Actually, I found this problem by running syzkaller. Syzkaller
> >> reported the following uninit-value issue (I think the root cause of
> >> this issue is the same as the one Eric mentioned):
> >
> > Yes, I also have a similar syzbot report (but no repro yet) I am
> > releasing it right now.
> >
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >> BUG: KMSAN: uninit-value in __gre_xmit net/ipv4/ip_gre.c:469 [inline]
> >> BUG: KMSAN: uninit-value in ipgre_xmit+0xdf4/0xe70 net/ipv4/ip_gre.c:6=
62
> >>  __gre_xmit net/ipv4/ip_gre.c:469 [inline]
> >>
> >
> >
> >
> >> The simplified version of the repro is shown below:
> >>
> >> #include <linux/if_ether.h>
> >> #include <sys/ioctl.h>
> >> #include <netinet/ether.h>
> >> #include <net/if.h>
> >> #include <sys/socket.h>
> >> #include <netinet/in.h>
> >> #include <string.h>
> >> #include <unistd.h>
> >> #include <stdio.h>
> >> #include <stdlib.h>
> >> #include <linux/if_packet.h>
> >>
> >> int main(void)
> >> {
> >>         int s, s1, s2, data =3D 0;
> >>         struct ifreq ifr;
> >>         struct sockaddr_ll addr =3D { 0 };
> >>         unsigned char mac_addr[] =3D {0x1, 0x2, 0x3, 0x4, 0x5, 0x6};
> >>
> >>         s =3D socket(AF_PACKET, SOCK_DGRAM, 0x300);
> >>         s1 =3D socket(AF_PACKET, SOCK_RAW, 0x300);
> >>         s2 =3D socket(AF_NETLINK, SOCK_RAW, 0);
> >>
> >>         strcpy(ifr.ifr_name, "gre0");
> >>         ioctl(s2, SIOCGIFINDEX, &ifr);
> >>
> >>         addr.sll_family =3D AF_PACKET;
> >>         addr.sll_ifindex =3D ifr.ifr_ifindex;
> >>         addr.sll_protocol =3D htons(0);
> >>         addr.sll_hatype =3D ARPHRD_ETHER;
> >>         addr.sll_pkttype =3D PACKET_HOST;
> >>         addr.sll_halen =3D ETH_ALEN;
> >>         memcpy(addr.sll_addr, mac_addr, ETH_ALEN);
> >>
> >>         sendto(s1, &data, 1, 0, (struct sockaddr *)&addr, sizeof(addr)=
);
> >>
> >>         return 0;
> >> }
> >>
> >> The repro sends a 1-byte packet that doesn't have the correct IP
> >> header. I meant this as "malformed pachet", but that might be a bit
> >> confusing, sorry.
> >>
> >> I think the cause of the uninit-value access is that ipgre_xmit()
> >> reallocates the skb with skb_cow_head() and copies only the 1-byte
> >> data, so any IP header access through `tnl_params` can cause the
> >> problem.
> >>
> >> At first I tried to modify pskb_inet_may_pull() to detect this type of
> >> packet, but I ended up doing this patch.
> >
> > Even after your patch, __skb_pull() could call BUG() and crash.
> >
> > I would suggest using this fix instead.
>
> Thank you for your comment.
>
> Your patch ensures that skb_pull() can pull the required size, so it
> looks good to me. Also, I have tested your suggested patch with the
> repro and confirmed that it fixes the issue.
>

This is great, please cook/send a V2 with this updated patch.

I will add a 'Reviewed-by: Eric Dumazet <edumazet@google.com>' then.

Thanks.

