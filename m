Return-Path: <netdev+bounces-45865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5AD7DFF58
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 08:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346C3B211C6
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 07:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FED1C08;
	Fri,  3 Nov 2023 07:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A707E
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 07:07:29 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947C6DC
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 00:07:24 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9d10f94f70bso251482166b.3
        for <netdev@vger.kernel.org>; Fri, 03 Nov 2023 00:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698995243; x=1699600043;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnG3uiwRjY499FWg5jUAUVrQFNqGdh77qSopIVCNGHo=;
        b=weaccncV0dWtOwg7X3dN/QYlF/6RQTgDDuA4Q14lhP5JfqJUgCI3NIWoZmIdT4yXiH
         gRVZFCrOfdy9ZIgWWaxRl3ncGt0mh3DXW7rUsGyyIUHc7ge5BWXyspKbChK6yCEo3aE5
         f83lLZ/O09onB9P5nLVydGAkNfHeJvL9ZiHEB5t5qE2o/NOYAwli+Y03Fk8ZH3G0w521
         aPWmY3hVvUJw62VtjDzR3T3EKIMTSJkFcl8EkTv+FgWae4ftw6AEmAQYWw77f4f4zjsM
         L//1xBRXKQJPdwXiT0J4abgwiBtx2sctD6m47q2h4TA8g72pxBxsG/bun0V5jUWWpj94
         ZpSA==
X-Gm-Message-State: AOJu0YweMZL6LB5lGBaHnlYfwM9d1CZM+c1Mva7GT06BWWArJYqWy6ms
	6TgHO7yL0ZH3/7Z5EHhy/nM=
X-Google-Smtp-Source: AGHT+IG7ZRiuM/vtp21AapMX0SBRMPxs0tNNyqAruKjv36I7JYWljfIUTJWA0sD2yVi4Ukfz3ESD7A==
X-Received: by 2002:a17:907:3203:b0:9b2:982e:339a with SMTP id xg3-20020a170907320300b009b2982e339amr6249020ejb.22.1698995242606;
        Fri, 03 Nov 2023 00:07:22 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id eg38-20020a05640228a600b0053ff311f388sm616975edb.23.2023.11.03.00.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 00:07:22 -0700 (PDT)
Message-ID: <875400ba-58d8-44a0-8fe9-334e322bd1db@kernel.org>
Date: Fri, 3 Nov 2023 08:07:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Soheil Hassas Yeganeh <soheil@google.com>,
 Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
 eric.dumazet@gmail.com
References: <20230717152917.751987-1-edumazet@google.com>
 <738bb6a1-4e99-4113-9345-48eea11e2108@kernel.org>
 <c798f412-ac14-4997-9431-c98d1b8e16d8@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <c798f412-ac14-4997-9431-c98d1b8e16d8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03. 11. 23, 7:56, Jiri Slaby wrote:
> On 03. 11. 23, 7:10, Jiri Slaby wrote:
>> On 17. 07. 23, 17:29, Eric Dumazet wrote:
>>> With modern NIC drivers shifting to full page allocations per
>>> received frame, we face the following issue:
>>>
>>> TCP has one per-netns sysctl used to tweak how to translate
>>> a memory use into an expected payload (RWIN), in RX path.
>>>
>>> tcp_win_from_space() implementation is limited to few cases.
>>>
>>> For hosts dealing with various MSS, we either under estimate
>>> or over estimate the RWIN we send to the remote peers.
>>>
>>> For instance with the default sysctl_tcp_adv_win_scale value,
>>> we expect to store 50% of payload per allocated chunk of memory.
>>>
>>> For the typical use of MTU=1500 traffic, and order-0 pages allocations
>>> by NIC drivers, we are sending too big RWIN, leading to potential
>>> tcp collapse operations, which are extremely expensive and source
>>> of latency spikes.
>>>
>>> This patch makes sysctl_tcp_adv_win_scale obsolete, and instead
>>> uses a per socket scaling factor, so that we can precisely
>>> adjust the RWIN based on effective skb->len/skb->truesize ratio.
>>>
>>> This patch alone can double TCP receive performance when receivers
>>> are too slow to drain their receive queue, or by allowing
>>> a bigger RWIN when MSS is close to PAGE_SIZE.
>>
>> Hi,
>>
>> I bisected a python-eventlet test failure:
>>  > =================================== FAILURES 
>> ===================================
>>  > _______________________ TestGreenSocket.test_full_duplex 
>> _______________________
>>  >
>>  > self = <tests.greenio_test.TestGreenSocket 
>> testMethod=test_full_duplex>
>>  >
>>  >     def test_full_duplex(self):
>>  > ...
>>  > >       large_evt.wait()
>>  >
>>  > tests/greenio_test.py:424:
>>  > _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
>> _ _ _ _ _ _
>>  > eventlet/greenthread.py:181: in wait
>>  >     return self._exit_event.wait()
>>  > eventlet/event.py:125: in wait
>>  >     result = hub.switch()
>> ...
>>  > E       tests.TestIsTakingTooLong: 1
>>  >
>>  > eventlet/hubs/hub.py:313: TestIsTakingTooLong
>>
>> to this commit. With the commit, the test takes > 1.5 s. Without the 
>> commit it takes only < 300 ms. And they set timeout to 1 s.
>>
>> The reduced self-stadning test case:
>> #!/usr/bin/python3
>> import eventlet
>> from eventlet.green import select, socket, time, ssl
>>
>> def bufsized(sock, size=1):
>>      """ Resize both send and receive buffers on a socket.
>>      Useful for testing trampoline.  Returns the socket.
>>
>>      >>> import socket
>>      >>> sock = bufsized(socket.socket(socket.AF_INET, 
>> socket.SOCK_STREAM))
>>      """
>>      sock.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, size)
>>      sock.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, size)
>>      return sock
>>
>> def min_buf_size():
>>      """Return the minimum buffer size that the platform supports."""
>>      test_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
>>      test_sock.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, 1)
>>      return test_sock.getsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF)
>>
>> def test_full_duplex():
>>      large_data = b'*' * 10 * min_buf_size()
>>      listener = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
>>      listener.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
>>      listener.bind(('127.0.0.1', 0))
>>      listener.listen(50)
>>      bufsized(listener)
>>
>>      def send_large(sock):
>>          sock.sendall(large_data)
>>
>>      def read_large(sock):
>>          result = sock.recv(len(large_data))
>>          while len(result) < len(large_data):
>>              result += sock.recv(len(large_data))
>>          assert result == large_data
>>
>>      def server():
>>          (sock, addr) = listener.accept()
>>          sock = bufsized(sock)
>>          send_large_coro = eventlet.spawn(send_large, sock)
>>          eventlet.sleep(0)
>>          result = sock.recv(10)
>>          expected = b'hello world'
>>          while len(result) < len(expected):
>>              result += sock.recv(10)
>>          assert result == expected
>>          send_large_coro.wait()
>>
>>      server_evt = eventlet.spawn(server)
>>      client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
>>      client.connect(('127.0.0.1', listener.getsockname()[1]))
>>      bufsized(client)
>>      large_evt = eventlet.spawn(read_large, client)
>>      eventlet.sleep(0)
>>      client.sendall(b'hello world')
>>      server_evt.wait()
>>      large_evt.wait()
>>      client.close()
>>
>> test_full_duplex()
>>
>> =====================================
>>
>> I speak neither python nor networking, so any ideas :)? Is the test 
>> simply wrong?
> 
> strace -rT -e trace=network:
> 
> GOOD:
>  > 0.000000 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 3 
> <0.000063>
>  > 0.000406 setsockopt(3, SOL_SOCKET, SO_SNDBUF, [1], 4) = 0 <0.000042>
>  > 0.000097 getsockopt(3, SOL_SOCKET, SO_SNDBUF, [4608], [4]) = 0 
> <0.000012>
>  > 0.000101 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 3 
> <0.000015>
>  > 0.000058 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000009>
>  > 0.000035 bind(3, {sa_family=AF_INET, sin_port=htons(0), 
> sin_addr=inet_addr("127.0.0.1")}, 16) = 0 <0.000027>
>  > 0.000058 listen(3, 50)       = 0 <0.000014>
>  > 0.000029 setsockopt(3, SOL_SOCKET, SO_SNDBUF, [1], 4) = 0 <0.000009>
>  > 0.000023 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1], 4) = 0 <0.000008>
>  > 0.000052 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 5 
> <0.000014>
>  > 0.000050 getsockname(3, {sa_family=AF_INET, sin_port=htons(44313), 
> sin_addr=inet_addr("127.0.0.1")}, [16]) = 0 <0.000011>
>  > 0.000037 connect(5, {sa_family=AF_INET, sin_port=htons(44313), 
> sin_addr=inet_addr("127.0.0.1")}, 16) = -1 EINPROGRESS (Operation now in 
> progress) <0.000070>
>  > 0.000210 accept4(3, {sa_family=AF_INET, sin_port=htons(56062), 
> sin_addr=inet_addr("127.0.0.1")}, [16], SOCK_CLOEXEC) = 6 <0.000012>
>  > 0.000040 getsockname(6, {sa_family=AF_INET, sin_port=htons(44313), 
> sin_addr=inet_addr("127.0.0.1")}, [128 => 16]) = 0 <0.000007>
>  > 0.000062 setsockopt(6, SOL_SOCKET, SO_SNDBUF, [1], 4) = 0 <0.000007>
>  > 0.000020 setsockopt(6, SOL_SOCKET, SO_RCVBUF, [1], 4) = 0 <0.000007>
>  > 0.000082 getsockopt(5, SOL_SOCKET, SO_ERROR, [0], [4]) = 0 <0.000007>
>  > 0.000023 connect(5, {sa_family=AF_INET, sin_port=htons(44313), 
> sin_addr=inet_addr("127.0.0.1")}, 16) = 0 <0.000008>
>  > 0.000022 setsockopt(5, SOL_SOCKET, SO_SNDBUF, [1], 4) = 0 <0.000020>
>  > 0.000036 setsockopt(5, SOL_SOCKET, SO_RCVBUF, [1], 4) = 0 <0.000007>
>  > 0.000061 sendto(6, "********************************"..., 46080, 0, 
> NULL, 0) = 32768 <0.000049>
>  > 0.000135 sendto(6, "********************************"..., 13312, 0, 
> NULL, 0) = 13312 <0.000017>
>  > 0.000087 recvfrom(6, 0x7f78e58af890, 10, 0, NULL, NULL) = -1 EAGAIN 
> (Resource temporarily unavailable) <0.000010>
>  > 0.000125 recvfrom(5, "********************************"..., 46080, 0, 
> NULL, NULL) = 32768 <0.000032>
>  > 0.000066 recvfrom(5, 0x55fdb41bb880, 46080, 0, NULL, NULL) = -1 
> EAGAIN (Resource temporarily unavailable) <0.000011>
>  > 0.000075 sendto(5, "hello world", 11, 0, NULL, 0) = 11 <0.000023>
>  > 0.000117 recvfrom(6, "hello worl", 10, 0, NULL, NULL) = 10 <0.000015>
>  > 0.000050 recvfrom(6, "d", 10, 0, NULL, NULL) = 1 <0.000011>
>  > 0.000212 recvfrom(5, "********************************"..., 46080, 0, 
> NULL, NULL) = 13312 <0.000019>
>  > 0.050676 +++ exited with 0 +++
> 
> 
> BAD:
>  > 0.000000 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 3 
> <0.000045>
>  > 0.000244 setsockopt(3, SOL_SOCKET, SO_SNDBUF, [1], 4) = 0 <0.000015>
>  > 0.000057 getsockopt(3, SOL_SOCKET, SO_SNDBUF, [4608], [4]) = 0 
> <0.000013>
>  > 0.000104 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 3 
> <0.000016>
>  > 0.000065 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000010>
>  > 0.000038 bind(3, {sa_family=AF_INET, sin_port=htons(0), 
> sin_addr=inet_addr("127.0.0.1")}, 16) = 0 <0.000031>
>  > 0.000068 listen(3, 50)       = 0 <0.000014>
>  > 0.000032 setsockopt(3, SOL_SOCKET, SO_SNDBUF, [1], 4) = 0 <0.000010>
>  > 0.000030 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1], 4) = 0 <0.000018>
>  > 0.000060 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 5 
> <0.000023>
>  > 0.000071 getsockname(3, {sa_family=AF_INET, sin_port=htons(45901), 
> sin_addr=inet_addr("127.0.0.1")}, [16]) = 0 <0.000019>
>  > 0.000068 connect(5, {sa_family=AF_INET, sin_port=htons(45901), 
> sin_addr=inet_addr("127.0.0.1")}, 16) = -1 EINPROGRESS (Operation now in 
> progress) <0.000074>
>  > 0.000259 accept4(3, {sa_family=AF_INET, sin_port=htons(35002), 
> sin_addr=inet_addr("127.0.0.1")}, [16], SOCK_CLOEXEC) = 6 <0.000014>
>  > 0.000051 getsockname(6, {sa_family=AF_INET, sin_port=htons(45901), 
> sin_addr=inet_addr("127.0.0.1")}, [128 => 16]) = 0 <0.000010>
>  > 0.000082 setsockopt(6, SOL_SOCKET, SO_SNDBUF, [1], 4) = 0 <0.000009>
>  > 0.000040 setsockopt(6, SOL_SOCKET, SO_RCVBUF, [1], 4) = 0 <0.000009>
>  > 0.000104 getsockopt(5, SOL_SOCKET, SO_ERROR, [0], [4]) = 0 <0.000009>
>  > 0.000028 connect(5, {sa_family=AF_INET, sin_port=htons(45901), 
> sin_addr=inet_addr("127.0.0.1")}, 16) = 0 <0.000009>
>  > 0.000026 setsockopt(5, SOL_SOCKET, SO_SNDBUF, [1], 4) = 0 <0.000009>
>  > 0.000024 setsockopt(5, SOL_SOCKET, SO_RCVBUF, [1], 4) = 0 <0.000008>
>  > 0.000071 sendto(6, "********************************"..., 46080, 0, 
> NULL, 0) = 16640 <0.000026>
>  > 0.000117 sendto(6, "********************************"..., 29440, 0, 
> NULL, 0) = 16640 <0.000017>
>  > 0.000041 sendto(6, "********************************"..., 12800, 0, 
> NULL, 0) = -1 EAGAIN (Resource temporarily unavailable) <0.000009>
>  > 0.000075 recvfrom(6, 0x7f4db88a38c0, 10, 0, NULL, NULL) = -1 EAGAIN 
> (Resource temporarily unavailable) <0.000010>
>  > 0.000086 recvfrom(5, "********************************"..., 46080, 0, 
> NULL, NULL) = 16640 <0.000018>
>  > 0.000044 recvfrom(5, 0x55a64d59b2a0, 46080, 0, NULL, NULL) = -1 
> EAGAIN (Resource temporarily unavailable) <0.000009>
>  > 0.000059 sendto(5, "hello world", 11, 0, NULL, 0) = 11 <0.000018>
>  > 0.000093 recvfrom(6, "hello worl", 10, 0, NULL, NULL) = 10 <0.000009>
>  > 0.000029 recvfrom(6, "d", 10, 0, NULL, NULL) = 1 <0.000009>
>  > 0.206685 recvfrom(5, "********************************"..., 46080, 0, 
> NULL, NULL) = 16640 <0.000116>
>  > 0.000306 recvfrom(5, 0x55a64d5a7600, 46080, 0, NULL, NULL) = -1 
> EAGAIN (Resource temporarily unavailable) <0.000013>
>  > 0.000208 sendto(6, "********************************"..., 12800, 0, 
> NULL, 0) = 12800 <0.000025>
>  > 0.206317 recvfrom(5, "********************************"..., 46080, 0, 
> NULL, NULL) = 2304 <0.000171>
>  > 0.000304 recvfrom(5, 0x55a64d597170, 46080, 0, NULL, NULL) = -1 
> EAGAIN (Resource temporarily unavailable) <0.000029>
>  > 0.206161 recvfrom(5, "********************************"..., 46080, 0, 
> NULL, NULL) = 2304 <0.000082>
>  > 0.000212 recvfrom(5, 0x55a64d5a0ed0, 46080, 0, NULL, NULL) = -1 
> EAGAIN (Resource temporarily unavailable) <0.000034>
>  > 0.206572 recvfrom(5, "********************************"..., 46080, 0, 
> NULL, NULL) = 2304 <0.000146>
>  > 0.000274 recvfrom(5, 0x55a64d597170, 46080, 0, NULL, NULL) = -1 
> EAGAIN (Resource temporarily unavailable) <0.000029>
>  > 0.206604 recvfrom(5, "********************************"..., 46080, 0, 
> NULL, NULL) = 2304 <0.000162>
>  > 0.000270 recvfrom(5, 0x55a64d5a20d0, 46080, 0, NULL, NULL) = -1 
> EAGAIN (Resource temporarily unavailable) <0.000016>
>  > 0.206164 recvfrom(5, "********************************"..., 46080, 0, 
> NULL, NULL) = 2304 <0.000116>
>  > 0.000291 recvfrom(5, "********************************"..., 46080, 0, 
> NULL, NULL) = 1280 <0.000038>
>  > 0.052224 +++ exited with 0 +++
> 
> I.e. recvfrom() returns -EAGAIN and takes 200 ms.

Ah, no, those 200 ms are not spent in recvfrom() but in poll:
 > 0.000029 recvfrom(6, "d", 10, 0, NULL, NULL) = 1 <0.000009>
 > 0.000040 epoll_wait(4, [{events=EPOLLIN, data={u32=5, 
u64=139942919405573}}], 1023, 60000) = 1 <0.204038>
 > 0.204258 epoll_ctl(4, EPOLL_CTL_DEL, 5, 0x7ffd49b4049c) = 0 <0.000045>
 > 0.000104 recvfrom(5, "********************************"..., 46080, 0, 
NULL, NULL) = 16640 <0.000078>
 > 0.000264 recvfrom(5, 0x5603425f3550, 46080, 0, NULL, NULL) = -1 
EAGAIN (Resource temporarily unavailable) <0.000025>
 > 0.000127 epoll_ctl(4, EPOLL_CTL_ADD, 5, 
{events=EPOLLIN|EPOLLPRI|EPOLLERR|EPOLLHUP, data={u32=5, 
u64=94570884890629}}) = 0 <0.000031>
 > 0.000112 epoll_wait(4, [{events=EPOLLOUT, data={u32=6, 
u64=139942919405574}}], 1023, 60000) = 1 <0.000026>
 > 0.000083 epoll_ctl(4, EPOLL_CTL_DEL, 6, 0x7ffd49b404fc) = 0 <0.000025>
 > 0.000063 sendto(6, "********************************"..., 12800, 0, 
NULL, 0) = 12800 <0.000028>
 > 0.000226 epoll_wait(4, [], 1023, 0) = 0 <0.000007>
 > 0.000029 epoll_wait(4, [{events=EPOLLIN, data={u32=5, 
u64=94570884890629}}], 1023, 60000) = 1 <0.205476>
 > 0.205728 epoll_ctl(4, EPOLL_CTL_DEL, 5, 0x7ffd49b404fc) = 0 <0.000077>
 > 0.000157 recvfrom(5, "********************************"..., 46080, 0, 
NULL, NULL) = 2304 <0.000066>
 > 0.000180 recvfrom(5, 0x5603425e30c0, 46080, 0, NULL, NULL) = -1 
EAGAIN (Resource temporarily unavailable) <0.000026>
 > 0.000139 epoll_ctl(4, EPOLL_CTL_ADD, 5, 
{events=EPOLLIN|EPOLLPRI|EPOLLERR|EPOLLHUP, data={u32=5, u64=5}}) = 0 
<0.000030>
 > 0.000104 epoll_wait(4, [{events=EPOLLIN, data={u32=5, u64=5}}], 1023, 
60000) = 1 <0.205881>
 > 0.206222 epoll_ctl(4, EPOLL_CTL_DEL, 5, 0x7ffd49b404fc) = 0 <0.000086>
 > 0.000189 recvfrom(5, "********************************"..., 46080, 0, 
NULL, NULL) = 2304 <0.000027>
 > 0.000153 recvfrom(5, 0x5603425ece20, 46080, 0, NULL, NULL) = -1 
EAGAIN (Resource temporarily unavailable) <0.000017>
 > 0.000074 epoll_ctl(4, EPOLL_CTL_ADD, 5, 
{events=EPOLLIN|EPOLLPRI|EPOLLERR|EPOLLHUP, data={u32=5, u64=5}}) = 0 
<0.000018>
 > 0.000067 epoll_wait(4, [{events=EPOLLIN, data={u32=5, u64=5}}], 1023, 
60000) = 1 <0.205749>
 > 0.206088 epoll_ctl(4, EPOLL_CTL_DEL, 5, 0x7ffd49b404fc) = 0 <0.000197>
 > 0.000391 recvfrom(5, "********************************"..., 46080, 0, 
NULL, NULL) = 2304 <0.000080>
 > 0.000210 recvfrom(5, 0x5603425e30c0, 46080, 0, NULL, NULL) = -1 
EAGAIN (Resource temporarily unavailable) <0.000027>
 > 0.000174 epoll_ctl(4, EPOLL_CTL_ADD, 5, 
{events=EPOLLIN|EPOLLPRI|EPOLLERR|EPOLLHUP, data={u32=5, u64=5}}) = 0 
<0.000031>
 > 0.000127 epoll_wait(4, [{events=EPOLLIN, data={u32=5, u64=5}}], 1023, 
60000) = 1 <0.205471>
 > 0.205783 epoll_ctl(4, EPOLL_CTL_DEL, 5, 0x7ffd49b404fc) = 0 <0.000205>


-- 
js
suse labs


