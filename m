Return-Path: <netdev+bounces-56909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EB3811451
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 782FDB20A1A
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670C02E82E;
	Wed, 13 Dec 2023 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zjUO/Mrd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F718CD
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 06:10:17 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-551d5cd1c42so13078a12.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 06:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702476616; x=1703081416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkvZdjkITKzZk+PDPL8mxOdsbJl23s0fR/ZmiXVX/vA=;
        b=zjUO/MrdDJoS3FLhGXVK2iAlpSgd9TW93OVE4idbZn6Vcie7nc+Vc9lW046jB1MakR
         q3u+WKGomx3eBNkPwtXXS8aQNb2+McJhTFMZRS4BYxwBas9q/q9uJky1aCLbcY/lOhMT
         q7oWV9D6GteI5pVQuTzvmcFvBr+kKtbZTjQ6ZAK5Bn0LVPA4wgu8JavXHfcz+z5oRke0
         3p8uOILQqHQ9xCLi+vKfJGO1lb+NFE+yGYXkDBEcQKu5v8UNicJ9MaWiSBBPU/pGgBx0
         XDyTgX3TgVxemeRB9FEMADfF08dcP+CaX9ykAR1RqG8/Nc1A8i3NL9EQ1w+VBov79US1
         vqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476616; x=1703081416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkvZdjkITKzZk+PDPL8mxOdsbJl23s0fR/ZmiXVX/vA=;
        b=QCB2KCY+T0i66oHF5jQUJnTSdsUonhRxqb92uldM8Fr6KNjX8fpy3d+mlbVYnYucxS
         L5k36gz4Rmynh4VW/SMPaiuEJQE2b4q9owx4vqo3cSfverlFTpRnPTwc7ZK3uvjwjp2i
         /4ln18y6S2ciQ0+wvlFss/h64FzZDPOBMjC5AE2TvSULYjju8j88eMEIRXpRNEZXWFJ0
         mO6Qn/kFhBShUif19lQdPLWO3R9lWYYFZG7zQb9LglkThMcmunmTnjm8RclPv826cTs8
         KN7ojRhggbRPCxSX9YLC1DhCNLkOZs6THY5qGPOPagxxU5eX2RNKQrkJfSohAQeqiun6
         pKjA==
X-Gm-Message-State: AOJu0YwFOAc53wo0sCAzNx2plM8LZ9ZITKSHQtoM261hS5nIzVmW/QDV
	843hFxNTHxJYPaV+6cS1BvL/4DHjhDoQtBfFY2SETA==
X-Google-Smtp-Source: AGHT+IEAP1fLcVKois5qurFru/5v3RuGjAYPwc5C0FkLdqaYJqaEGyBf73TPRFCW4r6J/HG7eYKr1XsTrkErY8v8pLw=
X-Received: by 2002:a50:d643:0:b0:54b:321:ef1a with SMTP id
 c3-20020a50d643000000b0054b0321ef1amr495043edj.6.1702476615342; Wed, 13 Dec
 2023 06:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208182049.33775-1-dipiets@amazon.com> <0d30d5a41d3ac990573016308aaeacb40a9dc79f.camel@redhat.com>
In-Reply-To: <0d30d5a41d3ac990573016308aaeacb40a9dc79f.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Dec 2023 15:10:00 +0100
Message-ID: <CANn89i+98ifRj9SJQbK+QJrCde2UJvWr1h31gAZSuxt4i_U=iw@mail.gmail.com>
Subject: Re: [PATCH] tcp: disable tcp_autocorking for socket when TCP_NODELAY
 flag is set
To: Paolo Abeni <pabeni@redhat.com>
Cc: Salvatore Dipietro <dipiets@amazon.com>, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, blakgeof@amazon.com, 
	alisaidi@amazon.com, benh@amazon.com, dipietro.salvatore@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:58=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Fri, 2023-12-08 at 10:20 -0800, Salvatore Dipietro wrote:
> > Based on the tcp man page, if TCP_NODELAY is set, it disables Nagle's a=
lgorithm
> > and packets are sent as soon as possible. However in the `tcp_push` fun=
ction
> > where autocorking is evaluated the `nonagle` value set by TCP_NODELAY i=
s not
> > considered which can trigger unexpected corking of packets and induce d=
elays.
> >
> > For example, if two packets are generated as part of a server's reply, =
if the
> > first one is not transmitted on the wire quickly enough, the second pac=
ket can
> > trigger the autocorking in `tcp_push` and be delayed instead of sent as=
 soon as
> > possible. It will either wait for additional packets to be coalesced or=
 an ACK
> > from the client before transmitting the corked packet. This can interac=
t badly
> > if the receiver has tcp delayed acks enabled, introducing 40ms extra de=
lay in
> > completion times. It is not always possible to control who has delayed =
acks
> > set, but it is possible to adjust when and how autocorking is triggered=
.
> > Patch prevents autocorking if the TCP_NODELAY flag is set on the socket=
.
> >
> > Patch has been tested using an AWS c7g.2xlarge instance with Ubuntu 22.=
04 and
> > Apache Tomcat 9.0.83 running the basic servlet below:
> >
> > import java.io.IOException;
> > import java.io.OutputStreamWriter;
> > import java.io.PrintWriter;
> > import javax.servlet.ServletException;
> > import javax.servlet.http.HttpServlet;
> > import javax.servlet.http.HttpServletRequest;
> > import javax.servlet.http.HttpServletResponse;
> >
> > public class HelloWorldServlet extends HttpServlet {
> >     @Override
> >     protected void doGet(HttpServletRequest request, HttpServletRespons=
e response)
> >       throws ServletException, IOException {
> >         response.setContentType("text/html;charset=3Dutf-8");
> >         OutputStreamWriter osw =3D new OutputStreamWriter(response.getO=
utputStream(),"UTF-8");
> >         String s =3D "a".repeat(3096);
> >         osw.write(s,0,s.length());
> >         osw.flush();
> >     }
> > }
> >
> > Load was applied using  wrk2 (https://github.com/kinvolk/wrk2) from an =
AWS
> > c6i.8xlarge instance.  With the current auto-corking behavior and TCP_N=
ODELAY
> > set an additional 40ms latency from P99.99+ values are observed.  With =
the
> > patch applied we see no occurrences of 40ms latencies. The patch has al=
so been
> > tested with iperf and uperf benchmarks and no regression was observed.
> >
> > # No patch with tcp_autocorking=3D1 and TCP_NODELAY set on all sockets
> > ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.49.177:8080/hel=
lo/hello'
> >   ...
> >  50.000%    0.91ms
> >  75.000%    1.12ms
> >  90.000%    1.46ms
> >  99.000%    1.73ms
> >  99.900%    1.96ms
> >  99.990%   43.62ms   <<< 40+ ms extra latency
> >  99.999%   48.32ms
> > 100.000%   49.34ms
> >
> > # With patch
> > ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.49.177:8080/hel=
lo/hello'
> >   ...
> >  50.000%    0.89ms
> >  75.000%    1.13ms
> >  90.000%    1.44ms
> >  99.000%    1.67ms
> >  99.900%    1.78ms
> >  99.990%    2.27ms   <<< no 40+ ms extra latency
> >  99.999%    3.71ms
> > 100.000%    4.57ms
> >
> > Signed-off-by: Salvatore Dipietro <dipiets@amazon.com>
> > ---
> >  net/ipv4/tcp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index d3456cf840de..87751a2a6fff 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -716,7 +716,7 @@ void tcp_push(struct sock *sk, int flags, int mss_n=
ow,
> >
> >       tcp_mark_urg(tp, flags);
> >
> > -     if (tcp_should_autocork(sk, skb, size_goal)) {
> > +     if (!nonagle && tcp_should_autocork(sk, skb, size_goal)) {
>
> It looks like the above disables autocorking even after the userspace
> sets TCP_CORK. Am I reading it correctly?Sal Is that expected?
>

Yes, it seems the patch went too far.

Also I wonder about these 40ms delays, TCP small queue handler should
kick when the prior skb is TX completed.

It seems the issue is on the driver side ?

Salvatore, which driver are you using ?

