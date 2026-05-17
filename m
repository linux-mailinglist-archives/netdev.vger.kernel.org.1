Return-Path: <netdev+bounces-288677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLQvDM4kCWpNLAQAu9opvQ
	(envelope-from <netdev+bounces-288677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 04:15:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7DC55F017
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 04:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 789B43007B0F
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 02:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985F31E857;
	Sun, 17 May 2026 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpAwFuKi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDFF155757
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778984128; cv=pass; b=LG1+/Ki+QkEaUMf1mhHQOyApjL3EuDj3RtOXzFMUHPlDc0Umv2pUq8VwW0GIj2UoPVV+6IAq5GeZh9NWyXXui4mYWQJ/BRT6hlX97nJYcYrKI/Aid1KBe/6IzCuQZCJ7Y5kfvgXoYeLcRD4P2j1DkoYWtV4pgkLGqRIKjtFuF0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778984128; c=relaxed/simple;
	bh=s4aBkOwe/bEHdXcFLk9eHUTCRUaU0m6NZrnmTx8tBpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQtKJbKy+gPUDF/my3tKXRW4VoJ+b4sE/sVU48gYmI8eN5hXHxMfM1hBBo0Qz2jql6LmsqZRDYulUjDasBAXuB6A3GVDMqnATqPSSt33UHbcDC7LlSdmnPoWeQ/SBpO5b3065ds0J1Ef4Wu9XLdEsEwSEZ5viHV1ABWSltraRzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mpAwFuKi; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-132c338a537so1416324c88.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 19:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778984125; cv=none;
        d=google.com; s=arc-20240605;
        b=WoPCZJUYaBFpZBMIlTM811vMkUiAdzh4JJ+BVrT9qSho8Ut6aXVgHXd4g6ZSaFz/x/
         Dg1zqBcEZ/+ltZ5a392mVLvh3CIFkVJ/ZWKoruiOkpINH8ihVp/YDh3fOvGzpPxp0cYs
         l0KPPWRhJ9sXZsbL0PW/gBzfZG3+lB7r/afMTbSPI3Qbadyix70+eOEQ71YWGc/9KHuW
         owqLWaDeWarcGzmwd9EGLkcmGPOwNxT06N68TwbZzKpZitNFqHqeBfyLryqmcZhvhv3x
         mwsJMfTpKGhkjdYwVJ6+P9P9dYr9k5mle1xEyRC6zB0HBpQfFlFBcLV4dOFfaDpQIUM8
         ofOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gvxpVRNFP1DdRYSBauluNbrj8hxlaOMbOPtS5FXUigM=;
        fh=m5S2GNen6C9s4X/WpfSgt6ZhIztnCgnc9OlqDkrueeI=;
        b=JJo5NdSD5IwqtkajvTWD9P85QmSdRieVDjyi6CZ3lWfSElfe43OYZOyT6H0KTnEZo0
         se2R0PSibMXTX28NYm1BMlwSzwVAxmFyr1sjAIQ/CCjUaHBZUKeVkE8p3gJ4AXcOHu5d
         vUlioLEUD/fuPj7r5u+gZkz42/BuRWP0droG6UsVJL9oMPSjyA3rY1mG0BfON+9/uyvQ
         0QVGd+IrJQIFyZg+hA15CbUTOPHXgDksH+zRfizoD4TY0airn10zTzZIfnU8cjIb861b
         WCrdnoMeXIZBdgsTh2J5uTnYlxCxWPHlpfi7lrWpANW15j23JosylIxb0YF2ZayNpgn7
         /FIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778984125; x=1779588925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvxpVRNFP1DdRYSBauluNbrj8hxlaOMbOPtS5FXUigM=;
        b=mpAwFuKiqnMhR8XJYkdULIrhRm+7RaWr7uvcdq2gbp2EcpFYmTWx/pbSkIxK18nJFj
         HHWqHJfe+o0NygFBU3xP6CwHdGVUsI0mBYxYbNPzCQpmf3BvN3opU4+KWkaPAF2tsIP5
         YRQAl+tFETysS1an887/o3TDu/qMTBXp2/3qdKR+/FQagUDKXTeHLZ2KnVYUgNYZSDS7
         m1giilCC7KODnpXVuJhWV1+tnetQEeQVHxIHcrDkI38wdb125SQBQD6G9uqs54FkB1j+
         L83eAftiYgd9JhL/E2hK6kmHdDNdo2kuPrs2N8gBZhp1WnK6TuSNsgkEKDckdydPV2UO
         +jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778984125; x=1779588925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gvxpVRNFP1DdRYSBauluNbrj8hxlaOMbOPtS5FXUigM=;
        b=Suyo7rnOK4comhHt7uw3PnkwUEebpyUlyFHRqKFz+mXszCcarWySF+BPdD0c7g+RgV
         Bd1IpITvOd6Nte/ugmPYwHHVawgNBI/lxKhTnzhSWUkmFeCNEZVz8iSZEbaOUvbBQZ4y
         kwUjmgCWAbZBL8E01egLn3mYI01ge/ttfFNl805nfX5cXXOefFzJ30x8rkn/7+96hMdG
         ezm/k34VEOJLUFVGEDBFvt9WVhPW6yl0NloAIVH7nnKFgBfthp6ZlNiC8bpcxA2GL3ny
         cwMac1jDK+IH2Vmy6xQ/qXYw+tgpUeOn6J3sFrmY8d0p1rf2aFTeakwSA9Yd0J+EMoEd
         A1GA==
X-Forwarded-Encrypted: i=1; AFNElJ+1Hqwra3UnUnkGRTeaytc56RLt2EPRLYOE690sCx3LGgaVJFdUNSsPMNQFA+nB6TUNxwYnTlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaaIgBlWvCiDCreRN9UNs4tzXG+TAVNsYjPXevpAp4zQjDpzln
	OgRVbaQlaUyZg0v1rzIk3l8FbF5a8axRL3kcmBMYV0X5FhqVwIEf6iXm7x2hiWwSrmYXMEUuj0+
	ddL6DLMNnUhsbpAhvpeo6tUwM2jFpne4nsZ8b6d7l
X-Gm-Gg: Acq92OFR246OSTQnenhI5YoV25zS0RO72kKuMviyB7aaX4ssWtdxv5Pj5ythP4iz6ye
	84qR0C5P8GdTEQc+12hzKaK3/fhXQfi2rb6g2Qsyp4xc9bkpgOC/5pwVF5qPPANEKWBPkaEv2T3
	AVzz0P7laWDaZsXXXmG9xB7zv0ZbXZh0nWk5nMzze3WgbkTwmWNbul8tu/7gH51m6xBYS5Q747Z
	XdguSWyUZFLcpKMeOhYStyf5oe/lgBNvFCSWxWDwGC4u7fOHx1xzVt6f68BDdkUsIX+bFe5X+/i
	AG+MxZbsGMVr30a57opoAprcdC1BBHGVI7zz5lSG6KGe9okh0UV2A/iUXe3TqOpxcQnqQooGNri
	ndBIivlN1AgG7I4Gzsiyj+DbUKYXaqNk=
X-Received: by 2002:a05:7022:426:b0:133:39b9:9720 with SMTP id
 a92af1059eb24-134fffa3c72mr4307593c88.16.1778984124131; Sat, 16 May 2026
 19:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_0106C0D2EA464109986EE86EF40CB5E7D406@qq.com>
 <tencent_330636464A367423778966A63DD1360E9609@qq.com> <13bc2e56-ea61-4cde-896f-c10636b29e9d@linux.dev>
In-Reply-To: <13bc2e56-ea61-4cde-896f-c10636b29e9d@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 16 May 2026 19:15:12 -0700
X-Gm-Features: AVHnY4K3feYplgIFcIrl5ySgvS6ZwJ9OXyz1asrE5oS9XWtIIXfR4EDtj2LbnTw
Message-ID: <CAAVpQUB6eRRRpapTxXmidO4ADtFc-ZBA+zwfPFb4dyX55UD4JQ@mail.gmail.com>
Subject: Re: [PATCH RDMA v2] RDMA/rxe: add mutual exclusion in rxe_net_del()
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: Edward Adam Davis <eadavis@qq.com>, akpm@linux-foundation.org, arjan@linux.intel.com, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	hdanton@sina.com, horms@kernel.org, jgg@ziepe.ca, kuba@kernel.org, 
	leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6A7DC55F017
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288677-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[qq.com,linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,d8f76778263ab65c2b21];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,mail.gmail.com:mid,syzkaller.appspot.com:url,qq.com:email,linux.dev:email]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 4:40=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev> w=
rote:
>
>
> On 5/16/26 7:00 AM, Edward Adam Davis wrote:
> > We must serialize calls to rxe_net_del() or risk a crash as syzbot
> > reported:
> >
> > KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> > Call Trace:
> >   udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
> >   rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inlin=
e]
> >   rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
> >   rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
> >   rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
> >
> > Jason Gunthorpe suggest placing the lock within rxe to protect its racy
> > implementation of rxe_net_del(), which looks like it is possibly also
> > triggered by NETDEV_UNREGISTER.
> >
> > The patch addressing this issue in nldev_dellink() has already been
> > applied(0b28000b64f4); however, since the fix has now been relocated
> > to rxe, the corresponding remedial code in nldev has been removed.
> >
> > Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruct=
ion per net namespace")
> > Fixes: 0b28000b64f4 ("RDMA/nldev: Add mutual exclusion in nldev_dellink=
()")
> > Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dd8f76778263ab65c2b21
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> > v1 -> v2: serialize calls to rxe net del
> >
> >   drivers/infiniband/core/nldev.c     | 4 ----
> >   drivers/infiniband/sw/rxe/rxe_net.c | 7 ++++++-
> >   2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/=
nldev.c
> > index 3cb3cb7629fe..96c745d5bac4 100644
> > --- a/drivers/infiniband/core/nldev.c
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -1816,8 +1816,6 @@ static int nldev_newlink(struct sk_buff *skb, str=
uct nlmsghdr *nlh,
> >       return err;
> >   }
> >
> > -static DEFINE_MUTEX(nldev_dellink_mutex);
> > -
> >   static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
> >                         struct netlink_ext_ack *extack)
> >   {
> > @@ -1848,9 +1846,7 @@ static int nldev_dellink(struct sk_buff *skb, str=
uct nlmsghdr *nlh,
> >        * implicitly scoped to the driver supporting dynamic link deleti=
on like RXE.
> >        */
> >       if (device->link_ops && device->link_ops->dellink) {
> > -             mutex_lock(&nldev_dellink_mutex);
> >               err =3D device->link_ops->dellink(device);
> > -             mutex_unlock(&nldev_dellink_mutex);
> >               if (err)
> >                       return err;
> >       }
> > diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/s=
w/rxe/rxe_net.c
> > index 50a2cb5405e2..92847e955ca2 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > @@ -642,6 +642,8 @@ static void rxe_sock_put(struct sock *sk,
> >       }
> >   }
> >
> I read this commit carefully. There are two paths that can invoke
> rxe_net_del().
>
> One is through the rdma link del xxx command, while the other is through
> the netdevice notification chain.
>
> In the netdevice notification chain path, rtnl_lock is already held, and
> rxe_net_del() is called under that lock.
>
> However, in the rdma link del xxx path, no rtnl_lock is taken.
>
> Because of this, I would like to use the existing rtnl_lock to serialize
> calls to rxe_net_del().

-1 for this.

It's a global mutex and heavily contended because many
components use it without much care.  We are working
to reduce the RTNL pressure for years by converting such
users with a dedicated lock or per-netns RTNL mutex.

RTNL is not needed here at all, so please use a dedicated lock.


>
> My proposed commit is shown below. I am not sure whether it fully
> resolves the problem.
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.c
> b/drivers/infiniband/sw/rxe/rxe.c
> index b0714f9abe3d..84266dc416c4 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -251,7 +251,9 @@ static int rxe_newlink(const char *ibdev_name,
> struct net_device *ndev)
>
>   static int rxe_dellink(struct ib_device *dev)
>   {
> +       rtnl_lock();
>          rxe_net_del(dev);
> +       rtnl_unlock();
>
>          return 0;
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
> b/drivers/infiniband/sw/rxe/rxe_net.c
> index 50a2cb5405e2..ac53ea73996d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -649,6 +649,8 @@ void rxe_net_del(struct ib_device *dev)
>          struct sock *sk;
>          struct net *net;
>
> +       ASSERT_RTNL();
> +
>          ndev =3D rxe_ib_device_get_netdev(&rxe->ib_dev);
>          if (!ndev)
>                  return;
>
> Zhu Yanjun
>
> > +static DEFINE_MUTEX(rxe_net_del_mutex);
> > +
> >   void rxe_net_del(struct ib_device *dev)
> >   {
> >       struct rxe_dev *rxe =3D container_of(dev, struct rxe_dev, ib_dev)=
;
> > @@ -649,9 +651,10 @@ void rxe_net_del(struct ib_device *dev)
> >       struct sock *sk;
> >       struct net *net;
> >
> > +     mutex_lock(&rxe_net_del_mutex);
> >       ndev =3D rxe_ib_device_get_netdev(&rxe->ib_dev);
> >       if (!ndev)
> > -             return;
> > +             goto out;
> >
> >       net =3D dev_net(ndev);
> >
> > @@ -664,6 +667,8 @@ void rxe_net_del(struct ib_device *dev)
> >               rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
> >
> >       dev_put(ndev);
> > +out:
> > +     mutex_unlock(&rxe_net_del_mutex);
> >   }
> >
> >   static void rxe_port_event(struct rxe_dev *rxe,

