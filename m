Return-Path: <netdev+bounces-62637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA4828457
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 11:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE951F250E9
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 10:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32942364CD;
	Tue,  9 Jan 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZR/4A7Be"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F7D364D1
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so6670a12.1
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 02:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704797513; x=1705402313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiwbQNCGqwvkwVGIyxOERPHojQ0ySbwGZlUkLfThSSk=;
        b=ZR/4A7Beb1Xwuc6mLAl2arCfpS7gqba0glgeCWkM9306jplN2IXMH6TGdzPJp6brIT
         AqZNE00Ai3anQIAvweLn34fKnDJnsk5Euq39055ksZz0Eq1nsY9XutvOxOfe+kloefbd
         jTTCATFkXjn+oCrrZ2xnzaOHwcoWaIsVbcULKT5rIHvIObtLBBvBTNXI6jlvCteAQ/B9
         SMGdlEpuNkjPmfkughJb55MlDAZGBXIqJXSoQdecVOoQ4eTsyOhKhGWO1HtsZP75aPK2
         Tq1qXbob03p9pkX9gO6qp1AXPhJdUgxVp+IgqJrYbY18KAb/9o3Mdc5cR8fY5tMDleqJ
         93ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704797513; x=1705402313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiwbQNCGqwvkwVGIyxOERPHojQ0ySbwGZlUkLfThSSk=;
        b=geUCRlpkyWKZtJdH+Tn6cktPIYKLUeFJdyVSSnyKGqmp9Oe0jdlfoRIdB0DU89uhGq
         io+ZL2XS6ll+IydWxaKBKWobU0AWDRH1YdjLEWtUqp01CBM8Z+9k8SNMEQ2e5Nv9F2RL
         kCyflQqkPzqh0OsHYkbaLT2hkSBfDJ5K+HZ2Y6vHGszRqvJA8q3VN6Ss27+b1cb+TkNd
         8FuFL3Ox42n8eYZMkL6q6SEUuzkPLlJLy7qjrX9JARHabeZbA0ekaE0u3940fAYBGmYF
         K3KRyIx4pzYOzPBfvaWkFm8J+FldKv6g3CTxJXykMZvr6AQ4veZhz8qK1zFLLWCEFq4U
         8hvw==
X-Gm-Message-State: AOJu0Yx1lA5GS/njpLlcZPNFXpOXoCDz3kCz8TDPkvQu+lsVS23ZGdNZ
	/27gxbj2ye8glkz/dnDCAze3Gx9u2ENoLgfvw9tQ061zyZju
X-Google-Smtp-Source: AGHT+IEfdAEQsKgMz9EBx9oYhy6URxgl9oe/+rXcuKg7ikGBOGRnh+CBkwfsyFrh8IeIsRiIA/1ZvT+fjIyzaaacPi0=
X-Received: by 2002:a50:cd45:0:b0:553:9d94:9f6a with SMTP id
 d5-20020a50cd45000000b005539d949f6amr58420edj.7.1704797512617; Tue, 09 Jan
 2024 02:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108231349.9919-1-jmaxwell37@gmail.com> <72f54aa95c3fad328b00b8196ca7f878c5d0a627.camel@redhat.com>
 <CANn89iLn0VK2kfq2m56kcaLGE6U-=p5eOr8=EFUqTr5bkONDiA@mail.gmail.com>
In-Reply-To: <CANn89iLn0VK2kfq2m56kcaLGE6U-=p5eOr8=EFUqTr5bkONDiA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jan 2024 11:51:41 +0100
Message-ID: <CANn89iLrU57dmE2ezdFPwLTVgo2kcVFcGGSQrbON-o7s2Tfy9g@mail.gmail.com>
Subject: Re: [net-next] tcp: Avoid sending an erroneous RST due to RCU race
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 11:36=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jan 9, 2024 at 8:24=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >
> > On Tue, 2024-01-09 at 10:13 +1100, Jon Maxwell wrote:
> > > There are 2 cases where a socket lookup races due to RCU and finds a
> > > LISTEN socket instead of an ESTABLISHED or a TIME-WAIT socket. As the=
 ACK flag
> > > is set this will generate an erroneous RST.
> > >
> > > There are 2 scenarios, one where 2 ACKs (one for the 3 way handshake =
and
> > > another with the same sequence number carrying data) are sent with a =
very
> > > small time interval between them. In this case the 2 ACKs can race wh=
ile being
> > > processed on different CPUs and the latter may find the LISTEN socket=
 instead
> > > of the ESTABLISHED socket. That will make the one end of the TCP conn=
ection
> > > out of sync with the other and cause a break in communications. The o=
ther
> > > scenario is a "FIN ACK" racing with an ACK which may also find the LI=
STEN
> > > socket instead of the TIME_WAIT socket. Instead of getting ignored th=
at
> > > generates an invalid RST.
> > >
> > > Instead of the next connection attempt succeeding. The client then ge=
ts an
> > > ECONNREFUSED error on the next connection attempt when it finds a soc=
ket in
> > > the FIN_WAIT_2 state as discussed here:
> > >
> > > https://lore.kernel.org/netdev/20230606064306.9192-1-duanmuquan@baidu=
.com/
> > >
> > > Modeled on Erics idea, introduce __inet_lookup_skb_locked() and
> > > __inet6_lookup_skb_locked()  to fix this by doing a locked lookup onl=
y for
> > > these rare cases to avoid finding the LISTEN socket.
> >
> > I think Eric's idea was to keep the bucket lock held after such lookup,
> > to avoid possibly re-acquiring it for time-wait sockets.
>
> Yes, I think a real fix needs more work/refactoring, I can work on
> this in the next cycle.

BTW,  a way to work around the issue on a network device without RSS
is to enable RPS
to make sure all packets of a flow are handled by the same cpu.

For instance for loopback device

cat /sys/class/net/lo/queues/rx-0/rps_cpus|tr '[0-9a-f]' f
>/sys/class/net/lo/queues/rx-0/rps_cpus

