Return-Path: <netdev+bounces-45869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF88A7DFFAB
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 09:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C2B21240
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3E79F7;
	Fri,  3 Nov 2023 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0vlmdsyn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568779D1
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 08:17:50 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDE3112
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 01:17:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so5703a12.1
        for <netdev@vger.kernel.org>; Fri, 03 Nov 2023 01:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698999462; x=1699604262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ2vonYqLXWoChIhs/SILWPblBf4zAlg0q/QTxk0xTE=;
        b=0vlmdsyn1BiDb8Bknr/EGolpCIq3nAnupw0osa+3js2vfAQ5RP1XOjL41emkqdrE+L
         paV9THenk5tTNivmrXVhk3nKQ1z8bKamBIi+zwshlnL2215oposqrW3QqOjXnqzyOzQx
         Q4NhnrnXW0QkfflB6YnZNy1N9YI4PKyfSbf84/b424oTPItscsKXN+LWEYMzLsLGI4UT
         vHFhmcqTEESXjj53ezwoubrkAYsm/dieJcRhDwAWTKI/BmbCQIJPe6L6V0vTt8XluH0Q
         91mooY7VAmLDv0rYxUyr1BVhm3+Y5aHqu6bxYiUhQCrS+rhFvPHlh+y77Cpujcd4Lf9D
         xnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698999462; x=1699604262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZ2vonYqLXWoChIhs/SILWPblBf4zAlg0q/QTxk0xTE=;
        b=wLxBRpcrRfloJxEHrplL7VrMe61y/x4enH6Q/hE0l0LEJZ6pFBYxjuSRRcBDRcke0V
         aK4NCT8KUTG3as/H52qTzhsjex2qkfX3738fmazBPdA9Yemi8/S+t04ZhEazR4La/QWL
         lft6QlOGCD1kfH1mft7hGduef1j8S+6kfltlxh5AJgVlfByDtmWv/8NJhqSF+smDDx/s
         5/mHqMqW9gd/KsHWPbeWo5yD9XnNsWrbrpoJfg7e9K1UJgsUsftvwOJDGDpSuQTZaYTy
         cw2oFHmoLx6c+FyMnNe7AF1H12lzWa/JpFVbN0y48hK/nDrQMObt4VIboCB4L6mc8jJ6
         +aAg==
X-Gm-Message-State: AOJu0YxcmmE01nqw19bDQ+CRab56EDv9yPnsiWwF4Y1Ah6rNbD8COMA5
	d3zM2C+dJ/h0nID0ehpmVIt35N7xYh9o9G8iWRcy6oMAQSfzNKBU45oFQQ==
X-Google-Smtp-Source: AGHT+IFCBvCYo9esyBIEErUjDll/9Oup/vxiRlndq+6TGhkS0JjOM3uk8+zBGrp0+D7C1Ad8miDkLFhkv1LPJRQ56FI=
X-Received: by 2002:a05:6402:501c:b0:543:fa43:a361 with SMTP id
 p28-20020a056402501c00b00543fa43a361mr183002eda.1.1698999461890; Fri, 03 Nov
 2023 01:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717152917.751987-1-edumazet@google.com> <738bb6a1-4e99-4113-9345-48eea11e2108@kernel.org>
 <c798f412-ac14-4997-9431-c98d1b8e16d8@kernel.org> <875400ba-58d8-44a0-8fe9-334e322bd1db@kernel.org>
In-Reply-To: <875400ba-58d8-44a0-8fe9-334e322bd1db@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Nov 2023 09:17:27 +0100
Message-ID: <CANn89iJOwQUwAVcofW+X_8srFcPnaWKyqOoM005L6Zgh8=OvpA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
To: Jiri Slaby <jirislaby@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 8:07=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> wr=
ote:
>
> On 03. 11. 23, 7:56, Jiri Slaby wrote:
> > On 03. 11. 23, 7:10, Jiri Slaby wrote:
> >> On 17. 07. 23, 17:29, Eric Dumazet wrote:
> >>> With modern NIC drivers shifting to full page allocations per
> >>> received frame, we face the following issue:
> >>>
> >>> TCP has one per-netns sysctl used to tweak how to translate
> >>> a memory use into an expected payload (RWIN), in RX path.
> >>>
> >>> tcp_win_from_space() implementation is limited to few cases.
> >>>
> >>> For hosts dealing with various MSS, we either under estimate
> >>> or over estimate the RWIN we send to the remote peers.
> >>>
> >>> For instance with the default sysctl_tcp_adv_win_scale value,
> >>> we expect to store 50% of payload per allocated chunk of memory.
> >>>
> >>> For the typical use of MTU=3D1500 traffic, and order-0 pages allocati=
ons
> >>> by NIC drivers, we are sending too big RWIN, leading to potential
> >>> tcp collapse operations, which are extremely expensive and source
> >>> of latency spikes.
> >>>
> >>> This patch makes sysctl_tcp_adv_win_scale obsolete, and instead
> >>> uses a per socket scaling factor, so that we can precisely
> >>> adjust the RWIN based on effective skb->len/skb->truesize ratio.
> >>>
> >>> This patch alone can double TCP receive performance when receivers
> >>> are too slow to drain their receive queue, or by allowing
> >>> a bigger RWIN when MSS is close to PAGE_SIZE.
> >>
> >> Hi,
> >>
> >> I bisected a python-eventlet test failure:
> >>  > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>  > _______________________ TestGreenSocket.test_full_duplex
> >> _______________________
> >>  >
> >>  > self =3D <tests.greenio_test.TestGreenSocket
> >> testMethod=3Dtest_full_duplex>
> >>  >
> >>  >     def test_full_duplex(self):
> >>  > ...
> >>  > >       large_evt.wait()
> >>  >
> >>  > tests/greenio_test.py:424:
> >>  > _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
> >> _ _ _ _ _ _
> >>  > eventlet/greenthread.py:181: in wait
> >>  >     return self._exit_event.wait()
> >>  > eventlet/event.py:125: in wait
> >>  >     result =3D hub.switch()
> >> ...
> >>  > E       tests.TestIsTakingTooLong: 1
> >>  >
> >>  > eventlet/hubs/hub.py:313: TestIsTakingTooLong
> >>
> >> to this commit. With the commit, the test takes > 1.5 s. Without the
> >> commit it takes only < 300 ms. And they set timeout to 1 s.
> >>
> >> The reduced self-stadning test case:
> >> #!/usr/bin/python3
> >> import eventlet
> >> from eventlet.green import select, socket, time, ssl
> >>
> >> def bufsized(sock, size=3D1):
> >>      """ Resize both send and receive buffers on a socket.
> >>      Useful for testing trampoline.  Returns the socket.
> >>
> >>      >>> import socket
> >>      >>> sock =3D bufsized(socket.socket(socket.AF_INET,
> >> socket.SOCK_STREAM))
> >>      """
> >>      sock.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, size)
> >>      sock.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, size)
> >>      return sock
> >>
> >> def min_buf_size():
> >>      """Return the minimum buffer size that the platform supports."""
> >>      test_sock =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
> >>      test_sock.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, 1)
> >>      return test_sock.getsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF)
> >>
> >> def test_full_duplex():
> >>      large_data =3D b'*' * 10 * min_buf_size()
> >>      listener =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
> >>      listener.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
> >>      listener.bind(('127.0.0.1', 0))
> >>      listener.listen(50)
> >>      bufsized(listener)
> >>
> >>      def send_large(sock):
> >>          sock.sendall(large_data)
> >>
> >>      def read_large(sock):
> >>          result =3D sock.recv(len(large_data))
> >>          while len(result) < len(large_data):
> >>              result +=3D sock.recv(len(large_data))
> >>          assert result =3D=3D large_data
> >>
> >>      def server():
> >>          (sock, addr) =3D listener.accept()
> >>          sock =3D bufsized(sock)
> >>          send_large_coro =3D eventlet.spawn(send_large, sock)
> >>          eventlet.sleep(0)
> >>          result =3D sock.recv(10)
> >>          expected =3D b'hello world'
> >>          while len(result) < len(expected):
> >>              result +=3D sock.recv(10)
> >>          assert result =3D=3D expected
> >>          send_large_coro.wait()
> >>
> >>      server_evt =3D eventlet.spawn(server)
> >>      client =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
> >>      client.connect(('127.0.0.1', listener.getsockname()[1]))
> >>      bufsized(client)
> >>      large_evt =3D eventlet.spawn(read_large, client)
> >>      eventlet.sleep(0)
> >>      client.sendall(b'hello world')
> >>      server_evt.wait()
> >>      large_evt.wait()
> >>      client.close()
> >>
> >> test_full_duplex()
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> I speak neither python nor networking, so any ideas :)? Is the test
> >> simply wrong?
> >
> > strace -rT -e trace=3Dnetwork:
> >
> > GOOD:
> >  > 0.000000 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 3
> > <0.000063>
> >  > 0.000406 setsockopt(3, SOL_SOCKET, SO_SNDBUF, [1], 4) =3D 0 <0.00004=
2>
> >  > 0.000097 getsockopt(3, SOL_SOCKET, SO_SNDBUF, [4608], [4]) =3D 0
> > <0.000012>
> >  > 0.000101 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 3
> > <0.000015>
> >  > 0.000058 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0 <0.00=
0009>
> >  > 0.000035 bind(3, {sa_family=3DAF_INET, sin_port=3Dhtons(0),
> > sin_addr=3Dinet_addr("127.0.0.1")}, 16) =3D 0 <0.000027>
> >  > 0.000058 listen(3, 50)       =3D 0 <0.000014>
> >  > 0.000029 setsockopt(3, SOL_SOCKET, SO_SNDBUF, [1], 4) =3D 0 <0.00000=
9>
> >  > 0.000023 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1], 4) =3D 0 <0.00000=
8>
> >  > 0.000052 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 5
> > <0.000014>
> >  > 0.000050 getsockname(3, {sa_family=3DAF_INET, sin_port=3Dhtons(44313=
),
> > sin_addr=3Dinet_addr("127.0.0.1")}, [16]) =3D 0 <0.000011>
> >  > 0.000037 connect(5, {sa_family=3DAF_INET, sin_port=3Dhtons(44313),
> > sin_addr=3Dinet_addr("127.0.0.1")}, 16) =3D -1 EINPROGRESS (Operation n=
ow in
> > progress) <0.000070>
> >  > 0.000210 accept4(3, {sa_family=3DAF_INET, sin_port=3Dhtons(56062),
> > sin_addr=3Dinet_addr("127.0.0.1")}, [16], SOCK_CLOEXEC) =3D 6 <0.000012=
>
> >  > 0.000040 getsockname(6, {sa_family=3DAF_INET, sin_port=3Dhtons(44313=
),
> > sin_addr=3Dinet_addr("127.0.0.1")}, [128 =3D> 16]) =3D 0 <0.000007>
> >  > 0.000062 setsockopt(6, SOL_SOCKET, SO_SNDBUF, [1], 4) =3D 0 <0.00000=
7>
> >  > 0.000020 setsockopt(6, SOL_SOCKET, SO_RCVBUF, [1], 4) =3D 0 <0.00000=
7>
> >  > 0.000082 getsockopt(5, SOL_SOCKET, SO_ERROR, [0], [4]) =3D 0 <0.0000=
07>
> >  > 0.000023 connect(5, {sa_family=3DAF_INET, sin_port=3Dhtons(44313),
> > sin_addr=3Dinet_addr("127.0.0.1")}, 16) =3D 0 <0.000008>
> >  > 0.000022 setsockopt(5, SOL_SOCKET, SO_SNDBUF, [1], 4) =3D 0 <0.00002=
0>
> >  > 0.000036 setsockopt(5, SOL_SOCKET, SO_RCVBUF, [1], 4) =3D 0 <0.00000=
7>
> >  > 0.000061 sendto(6, "********************************"..., 46080, 0,
> > NULL, 0) =3D 32768 <0.000049>
> >  > 0.000135 sendto(6, "********************************"..., 13312, 0,
> > NULL, 0) =3D 13312 <0.000017>
> >  > 0.000087 recvfrom(6, 0x7f78e58af890, 10, 0, NULL, NULL) =3D -1 EAGAI=
N
> > (Resource temporarily unavailable) <0.000010>
> >  > 0.000125 recvfrom(5, "********************************"..., 46080, 0=
,
> > NULL, NULL) =3D 32768 <0.000032>
> >  > 0.000066 recvfrom(5, 0x55fdb41bb880, 46080, 0, NULL, NULL) =3D -1
> > EAGAIN (Resource temporarily unavailable) <0.000011>
> >  > 0.000075 sendto(5, "hello world", 11, 0, NULL, 0) =3D 11 <0.000023>
> >  > 0.000117 recvfrom(6, "hello worl", 10, 0, NULL, NULL) =3D 10 <0.0000=
15>
> >  > 0.000050 recvfrom(6, "d", 10, 0, NULL, NULL) =3D 1 <0.000011>
> >  > 0.000212 recvfrom(5, "********************************"..., 46080, 0=
,
> > NULL, NULL) =3D 13312 <0.000019>
> >  > 0.050676 +++ exited with 0 +++
> >
> >
> > BAD:
> >  > 0.000000 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 3
> > <0.000045>
> >  > 0.000244 setsockopt(3, SOL_SOCKET, SO_SNDBUF, [1], 4) =3D 0 <0.00001=
5>
> >  > 0.000057 getsockopt(3, SOL_SOCKET, SO_SNDBUF, [4608], [4]) =3D 0
> > <0.000013>
> >  > 0.000104 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 3
> > <0.000016>
> >  > 0.000065 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0 <0.00=
0010>
> >  > 0.000038 bind(3, {sa_family=3DAF_INET, sin_port=3Dhtons(0),
> > sin_addr=3Dinet_addr("127.0.0.1")}, 16) =3D 0 <0.000031>
> >  > 0.000068 listen(3, 50)       =3D 0 <0.000014>
> >  > 0.000032 setsockopt(3, SOL_SOCKET, SO_SNDBUF, [1], 4) =3D 0 <0.00001=
0>
> >  > 0.000030 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1], 4) =3D 0 <0.00001=
8>
> >  > 0.000060 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 5
> > <0.000023>
> >  > 0.000071 getsockname(3, {sa_family=3DAF_INET, sin_port=3Dhtons(45901=
),
> > sin_addr=3Dinet_addr("127.0.0.1")}, [16]) =3D 0 <0.000019>
> >  > 0.000068 connect(5, {sa_family=3DAF_INET, sin_port=3Dhtons(45901),
> > sin_addr=3Dinet_addr("127.0.0.1")}, 16) =3D -1 EINPROGRESS (Operation n=
ow in
> > progress) <0.000074>
> >  > 0.000259 accept4(3, {sa_family=3DAF_INET, sin_port=3Dhtons(35002),
> > sin_addr=3Dinet_addr("127.0.0.1")}, [16], SOCK_CLOEXEC) =3D 6 <0.000014=
>
> >  > 0.000051 getsockname(6, {sa_family=3DAF_INET, sin_port=3Dhtons(45901=
),
> > sin_addr=3Dinet_addr("127.0.0.1")}, [128 =3D> 16]) =3D 0 <0.000010>
> >  > 0.000082 setsockopt(6, SOL_SOCKET, SO_SNDBUF, [1], 4) =3D 0 <0.00000=
9>
> >  > 0.000040 setsockopt(6, SOL_SOCKET, SO_RCVBUF, [1], 4) =3D 0 <0.00000=
9>
> >  > 0.000104 getsockopt(5, SOL_SOCKET, SO_ERROR, [0], [4]) =3D 0 <0.0000=
09>
> >  > 0.000028 connect(5, {sa_family=3DAF_INET, sin_port=3Dhtons(45901),
> > sin_addr=3Dinet_addr("127.0.0.1")}, 16) =3D 0 <0.000009>
> >  > 0.000026 setsockopt(5, SOL_SOCKET, SO_SNDBUF, [1], 4) =3D 0 <0.00000=
9>
> >  > 0.000024 setsockopt(5, SOL_SOCKET, SO_RCVBUF, [1], 4) =3D 0 <0.00000=
8>
> >  > 0.000071 sendto(6, "********************************"..., 46080, 0,
> > NULL, 0) =3D 16640 <0.000026>
> >  > 0.000117 sendto(6, "********************************"..., 29440, 0,
> > NULL, 0) =3D 16640 <0.000017>
> >  > 0.000041 sendto(6, "********************************"..., 12800, 0,
> > NULL, 0) =3D -1 EAGAIN (Resource temporarily unavailable) <0.000009>
> >  > 0.000075 recvfrom(6, 0x7f4db88a38c0, 10, 0, NULL, NULL) =3D -1 EAGAI=
N
> > (Resource temporarily unavailable) <0.000010>
> >  > 0.000086 recvfrom(5, "********************************"..., 46080, 0=
,
> > NULL, NULL) =3D 16640 <0.000018>
> >  > 0.000044 recvfrom(5, 0x55a64d59b2a0, 46080, 0, NULL, NULL) =3D -1
> > EAGAIN (Resource temporarily unavailable) <0.000009>
> >  > 0.000059 sendto(5, "hello world", 11, 0, NULL, 0) =3D 11 <0.000018>
> >  > 0.000093 recvfrom(6, "hello worl", 10, 0, NULL, NULL) =3D 10 <0.0000=
09>
> >  > 0.000029 recvfrom(6, "d", 10, 0, NULL, NULL) =3D 1 <0.000009>
> >  > 0.206685 recvfrom(5, "********************************"..., 46080, 0=
,
> > NULL, NULL) =3D 16640 <0.000116>
> >  > 0.000306 recvfrom(5, 0x55a64d5a7600, 46080, 0, NULL, NULL) =3D -1
> > EAGAIN (Resource temporarily unavailable) <0.000013>
> >  > 0.000208 sendto(6, "********************************"..., 12800, 0,
> > NULL, 0) =3D 12800 <0.000025>
> >  > 0.206317 recvfrom(5, "********************************"..., 46080, 0=
,
> > NULL, NULL) =3D 2304 <0.000171>
> >  > 0.000304 recvfrom(5, 0x55a64d597170, 46080, 0, NULL, NULL) =3D -1
> > EAGAIN (Resource temporarily unavailable) <0.000029>
> >  > 0.206161 recvfrom(5, "********************************"..., 46080, 0=
,
> > NULL, NULL) =3D 2304 <0.000082>
> >  > 0.000212 recvfrom(5, 0x55a64d5a0ed0, 46080, 0, NULL, NULL) =3D -1
> > EAGAIN (Resource temporarily unavailable) <0.000034>
> >  > 0.206572 recvfrom(5, "********************************"..., 46080, 0=
,
> > NULL, NULL) =3D 2304 <0.000146>
> >  > 0.000274 recvfrom(5, 0x55a64d597170, 46080, 0, NULL, NULL) =3D -1
> > EAGAIN (Resource temporarily unavailable) <0.000029>
> >  > 0.206604 recvfrom(5, "********************************"..., 46080, 0=
,
> > NULL, NULL) =3D 2304 <0.000162>
> >  > 0.000270 recvfrom(5, 0x55a64d5a20d0, 46080, 0, NULL, NULL) =3D -1
> > EAGAIN (Resource temporarily unavailable) <0.000016>
> >  > 0.206164 recvfrom(5, "********************************"..., 46080, 0=
,
> > NULL, NULL) =3D 2304 <0.000116>
> >  > 0.000291 recvfrom(5, "********************************"..., 46080, 0=
,
> > NULL, NULL) =3D 1280 <0.000038>
> >  > 0.052224 +++ exited with 0 +++
> >
> > I.e. recvfrom() returns -EAGAIN and takes 200 ms.
>
> Ah, no, those 200 ms are not spent in recvfrom() but in poll:
>  > 0.000029 recvfrom(6, "d", 10, 0, NULL, NULL) =3D 1 <0.000009>
>  > 0.000040 epoll_wait(4, [{events=3DEPOLLIN, data=3D{u32=3D5,
> u64=3D139942919405573}}], 1023, 60000) =3D 1 <0.204038>
>  > 0.204258 epoll_ctl(4, EPOLL_CTL_DEL, 5, 0x7ffd49b4049c) =3D 0 <0.00004=
5>
>  > 0.000104 recvfrom(5, "********************************"..., 46080, 0,
> NULL, NULL) =3D 16640 <0.000078>
>  > 0.000264 recvfrom(5, 0x5603425f3550, 46080, 0, NULL, NULL) =3D -1
> EAGAIN (Resource temporarily unavailable) <0.000025>
>  > 0.000127 epoll_ctl(4, EPOLL_CTL_ADD, 5,
> {events=3DEPOLLIN|EPOLLPRI|EPOLLERR|EPOLLHUP, data=3D{u32=3D5,
> u64=3D94570884890629}}) =3D 0 <0.000031>
>  > 0.000112 epoll_wait(4, [{events=3DEPOLLOUT, data=3D{u32=3D6,
> u64=3D139942919405574}}], 1023, 60000) =3D 1 <0.000026>
>  > 0.000083 epoll_ctl(4, EPOLL_CTL_DEL, 6, 0x7ffd49b404fc) =3D 0 <0.00002=
5>
>  > 0.000063 sendto(6, "********************************"..., 12800, 0,
> NULL, 0) =3D 12800 <0.000028>
>  > 0.000226 epoll_wait(4, [], 1023, 0) =3D 0 <0.000007>
>  > 0.000029 epoll_wait(4, [{events=3DEPOLLIN, data=3D{u32=3D5,
> u64=3D94570884890629}}], 1023, 60000) =3D 1 <0.205476>
>  > 0.205728 epoll_ctl(4, EPOLL_CTL_DEL, 5, 0x7ffd49b404fc) =3D 0 <0.00007=
7>
>  > 0.000157 recvfrom(5, "********************************"..., 46080, 0,
> NULL, NULL) =3D 2304 <0.000066>
>  > 0.000180 recvfrom(5, 0x5603425e30c0, 46080, 0, NULL, NULL) =3D -1
> EAGAIN (Resource temporarily unavailable) <0.000026>
>  > 0.000139 epoll_ctl(4, EPOLL_CTL_ADD, 5,
> {events=3DEPOLLIN|EPOLLPRI|EPOLLERR|EPOLLHUP, data=3D{u32=3D5, u64=3D5}})=
 =3D 0
> <0.000030>
>  > 0.000104 epoll_wait(4, [{events=3DEPOLLIN, data=3D{u32=3D5, u64=3D5}}]=
, 1023,
> 60000) =3D 1 <0.205881>
>  > 0.206222 epoll_ctl(4, EPOLL_CTL_DEL, 5, 0x7ffd49b404fc) =3D 0 <0.00008=
6>
>  > 0.000189 recvfrom(5, "********************************"..., 46080, 0,
> NULL, NULL) =3D 2304 <0.000027>
>  > 0.000153 recvfrom(5, 0x5603425ece20, 46080, 0, NULL, NULL) =3D -1
> EAGAIN (Resource temporarily unavailable) <0.000017>
>  > 0.000074 epoll_ctl(4, EPOLL_CTL_ADD, 5,
> {events=3DEPOLLIN|EPOLLPRI|EPOLLERR|EPOLLHUP, data=3D{u32=3D5, u64=3D5}})=
 =3D 0
> <0.000018>
>  > 0.000067 epoll_wait(4, [{events=3DEPOLLIN, data=3D{u32=3D5, u64=3D5}}]=
, 1023,
> 60000) =3D 1 <0.205749>
>  > 0.206088 epoll_ctl(4, EPOLL_CTL_DEL, 5, 0x7ffd49b404fc) =3D 0 <0.00019=
7>
>  > 0.000391 recvfrom(5, "********************************"..., 46080, 0,
> NULL, NULL) =3D 2304 <0.000080>
>  > 0.000210 recvfrom(5, 0x5603425e30c0, 46080, 0, NULL, NULL) =3D -1
> EAGAIN (Resource temporarily unavailable) <0.000027>
>  > 0.000174 epoll_ctl(4, EPOLL_CTL_ADD, 5,
> {events=3DEPOLLIN|EPOLLPRI|EPOLLERR|EPOLLHUP, data=3D{u32=3D5, u64=3D5}})=
 =3D 0
> <0.000031>
>  > 0.000127 epoll_wait(4, [{events=3DEPOLLIN, data=3D{u32=3D5, u64=3D5}}]=
, 1023,
> 60000) =3D 1 <0.205471>
>  > 0.205783 epoll_ctl(4, EPOLL_CTL_DEL, 5, 0x7ffd49b404fc) =3D 0 <0.00020=
5>
>

It seems the test had some expectations.

Setting a small (1 byte) RCVBUF/SNDBUF, and yet expecting to send
46080 bytes fast enough was not reasonable.
It might have relied on the fact that tcp sendmsg() can cook large GSO
packets, even if sk->sk_sndbuf is small.

With tight memory settings, it is possible TCP has to resort on RTO
timers (200ms by default) to recover from dropped packets.

What happens if you double /proc/sys/net/ipv4/tcp_wmem  and/or
/proc/sys/net/ipv4/tcp_rmem first value ?
(4096 -> 8192)

