Return-Path: <netdev+bounces-45860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE22E7DFF0C
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 07:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097BEB211DD
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 06:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1D6D3F;
	Fri,  3 Nov 2023 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CB1FCE
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 06:10:40 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38347CA
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 23:10:35 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9a6190af24aso254540066b.0
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 23:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698991833; x=1699596633;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afwW0sM4eAa1MuLvL02pz/Q5SOwgU658NZNLDy/KwoA=;
        b=eOZahD5ROFR7uJ7gRM+OQY4EHxwoGVHvnc0cUia78xItZEPf1EGk9YYw3l8zKYXsbK
         7es+5WgVP8vbn2flHeSLr9zbmdIcdiPXcJYZd9mdkFQelCGxtl3nuPEgfnZCfNhtfXRJ
         Y1pRkQZRCqnyaL2yRF1jY/RPlta+LGJy+cy/RctQysYne5VGJ2b/8z3lS8PAYv0rr2tb
         x5ZfhvGFujSFrKvzU3DrFbb4Rh4d/nLebhnQ3kSdDydzpdFEGJW1JcUoC38iKlyS0gP1
         RXG/xzRFuzFXATOzpLjbJtcRE5k/Ds4r0VZ8T8BLgUh3lYHgQDH28n/58BfTUnG3qMs2
         ymyQ==
X-Gm-Message-State: AOJu0Yxf5On26VoMrEy7W5slb9IiUXNs0zoohwcWSo93xAE9t2gDqwqb
	X5J6t9BGezaY9iPv143PrGU=
X-Google-Smtp-Source: AGHT+IFFU/yDZfJ+f840/67WFRxotY47gL+NEdfZE1pGgSyZB2y07Ciud/SFJKo7KhTDKdjhDePDeQ==
X-Received: by 2002:a17:907:1c17:b0:9d0:e4a1:2826 with SMTP id nc23-20020a1709071c1700b009d0e4a12826mr6495795ejc.67.1698991833326;
        Thu, 02 Nov 2023 23:10:33 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709067c8800b009dbe08bc793sm524409ejo.18.2023.11.02.23.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 23:10:32 -0700 (PDT)
Message-ID: <738bb6a1-4e99-4113-9345-48eea11e2108@kernel.org>
Date: Fri, 3 Nov 2023 07:10:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Soheil Hassas Yeganeh <soheil@google.com>,
 Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
 eric.dumazet@gmail.com
References: <20230717152917.751987-1-edumazet@google.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20230717152917.751987-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17. 07. 23, 17:29, Eric Dumazet wrote:
> With modern NIC drivers shifting to full page allocations per
> received frame, we face the following issue:
> 
> TCP has one per-netns sysctl used to tweak how to translate
> a memory use into an expected payload (RWIN), in RX path.
> 
> tcp_win_from_space() implementation is limited to few cases.
> 
> For hosts dealing with various MSS, we either under estimate
> or over estimate the RWIN we send to the remote peers.
> 
> For instance with the default sysctl_tcp_adv_win_scale value,
> we expect to store 50% of payload per allocated chunk of memory.
> 
> For the typical use of MTU=1500 traffic, and order-0 pages allocations
> by NIC drivers, we are sending too big RWIN, leading to potential
> tcp collapse operations, which are extremely expensive and source
> of latency spikes.
> 
> This patch makes sysctl_tcp_adv_win_scale obsolete, and instead
> uses a per socket scaling factor, so that we can precisely
> adjust the RWIN based on effective skb->len/skb->truesize ratio.
> 
> This patch alone can double TCP receive performance when receivers
> are too slow to drain their receive queue, or by allowing
> a bigger RWIN when MSS is close to PAGE_SIZE.

Hi,

I bisected a python-eventlet test failure:
 > =================================== FAILURES 
===================================
 > _______________________ TestGreenSocket.test_full_duplex 
_______________________
 >
 > self = <tests.greenio_test.TestGreenSocket testMethod=test_full_duplex>
 >
 >     def test_full_duplex(self):
 > ...
 > >       large_evt.wait()
 >
 > tests/greenio_test.py:424:
 > _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
_ _ _ _ _
 > eventlet/greenthread.py:181: in wait
 >     return self._exit_event.wait()
 > eventlet/event.py:125: in wait
 >     result = hub.switch()
...
 > E       tests.TestIsTakingTooLong: 1
 >
 > eventlet/hubs/hub.py:313: TestIsTakingTooLong

to this commit. With the commit, the test takes > 1.5 s. Without the 
commit it takes only < 300 ms. And they set timeout to 1 s.

The reduced self-stadning test case:
#!/usr/bin/python3
import eventlet
from eventlet.green import select, socket, time, ssl

def bufsized(sock, size=1):
     """ Resize both send and receive buffers on a socket.
     Useful for testing trampoline.  Returns the socket.

     >>> import socket
     >>> sock = bufsized(socket.socket(socket.AF_INET, socket.SOCK_STREAM))
     """
     sock.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, size)
     sock.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, size)
     return sock

def min_buf_size():
     """Return the minimum buffer size that the platform supports."""
     test_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
     test_sock.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, 1)
     return test_sock.getsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF)

def test_full_duplex():
     large_data = b'*' * 10 * min_buf_size()
     listener = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
     listener.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
     listener.bind(('127.0.0.1', 0))
     listener.listen(50)
     bufsized(listener)

     def send_large(sock):
         sock.sendall(large_data)

     def read_large(sock):
         result = sock.recv(len(large_data))
         while len(result) < len(large_data):
             result += sock.recv(len(large_data))
         assert result == large_data

     def server():
         (sock, addr) = listener.accept()
         sock = bufsized(sock)
         send_large_coro = eventlet.spawn(send_large, sock)
         eventlet.sleep(0)
         result = sock.recv(10)
         expected = b'hello world'
         while len(result) < len(expected):
             result += sock.recv(10)
         assert result == expected
         send_large_coro.wait()

     server_evt = eventlet.spawn(server)
     client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
     client.connect(('127.0.0.1', listener.getsockname()[1]))
     bufsized(client)
     large_evt = eventlet.spawn(read_large, client)
     eventlet.sleep(0)
     client.sendall(b'hello world')
     server_evt.wait()
     large_evt.wait()
     client.close()

test_full_duplex()

=====================================

I speak neither python nor networking, so any ideas :)? Is the test 
simply wrong?

Thanks.

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   Documentation/networking/ip-sysctl.rst |  1 +
>   include/linux/tcp.h                    |  4 +++-
>   include/net/netns/ipv4.h               |  2 +-
>   include/net/tcp.h                      | 24 ++++++++++++++++++++----
>   net/ipv4/tcp.c                         | 11 ++++++-----
>   net/ipv4/tcp_input.c                   | 19 ++++++++++++-------
>   6 files changed, 43 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 4a010a7cde7f8085db5ba6f1b9af53e9e5223cd5..82f2117cf2b36a834e5e391feda0210d916bff8b 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -321,6 +321,7 @@ tcp_abort_on_overflow - BOOLEAN
>   	option can harm clients of your server.
>   
>   tcp_adv_win_scale - INTEGER
> +	Obsolete since linux-6.6
>   	Count buffering overhead as bytes/2^tcp_adv_win_scale
>   	(if tcp_adv_win_scale > 0) or bytes-bytes/2^(-tcp_adv_win_scale),
>   	if it is <= 0.
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index b4c08ac86983568a9511258708724da15d0b999e..fbcb0ce13171d46aa3697abcd48482b08e78e5e0 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -172,6 +172,8 @@ static inline struct tcp_request_sock *tcp_rsk(const struct request_sock *req)
>   	return (struct tcp_request_sock *)req;
>   }
>   
> +#define TCP_RMEM_TO_WIN_SCALE 8
> +
>   struct tcp_sock {
>   	/* inet_connection_sock has to be the first member of tcp_sock */
>   	struct inet_connection_sock	inet_conn;
> @@ -238,7 +240,7 @@ struct tcp_sock {
>   
>   	u32	window_clamp;	/* Maximal window to advertise		*/
>   	u32	rcv_ssthresh;	/* Current window clamp			*/
> -
> +	u8	scaling_ratio;	/* see tcp_win_from_space() */
>   	/* Information of the most recently (s)acked skb */
>   	struct tcp_rack {
>   		u64 mstamp; /* (Re)sent time of the skb */
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index f003747181593559a4efe1838be719d445417041..7a41c4791536732005cedbb80c223b86aa43249e 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -152,7 +152,7 @@ struct netns_ipv4 {
>   	u8 sysctl_tcp_abort_on_overflow;
>   	u8 sysctl_tcp_fack; /* obsolete */
>   	int sysctl_tcp_max_reordering;
> -	int sysctl_tcp_adv_win_scale;
> +	int sysctl_tcp_adv_win_scale; /* obsolete */
>   	u8 sysctl_tcp_dsack;
>   	u8 sysctl_tcp_app_win;
>   	u8 sysctl_tcp_frto;
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 226bce6d1e8c30185260baadec449b67323db91c..2104a71c75ba7eee40612395be4103ae370b3c03 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1434,11 +1434,27 @@ void tcp_select_initial_window(const struct sock *sk, int __space,
>   
>   static inline int tcp_win_from_space(const struct sock *sk, int space)
>   {
> -	int tcp_adv_win_scale = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_adv_win_scale);
> +	s64 scaled_space = (s64)space * tcp_sk(sk)->scaling_ratio;
>   
> -	return tcp_adv_win_scale <= 0 ?
> -		(space>>(-tcp_adv_win_scale)) :
> -		space - (space>>tcp_adv_win_scale);
> +	return scaled_space >> TCP_RMEM_TO_WIN_SCALE;
> +}
> +
> +/* inverse of tcp_win_from_space() */
> +static inline int tcp_space_from_win(const struct sock *sk, int win)
> +{
> +	u64 val = (u64)win << TCP_RMEM_TO_WIN_SCALE;
> +
> +	do_div(val, tcp_sk(sk)->scaling_ratio);
> +	return val;
> +}
> +
> +static inline void tcp_scaling_ratio_init(struct sock *sk)
> +{
> +	/* Assume a conservative default of 1200 bytes of payload per 4K page.
> +	 * This may be adjusted later in tcp_measure_rcv_mss().
> +	 */
> +	tcp_sk(sk)->scaling_ratio = (1200 << TCP_RMEM_TO_WIN_SCALE) /
> +				    SKB_TRUESIZE(4096);
>   }
>   
>   /* Note: caller must be prepared to deal with negative returns */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e03e08745308189c9d64509c2cff94da56c86a0c..88f4ebab12acc11d5f3feb6b13974a0b8e565671 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -457,6 +457,7 @@ void tcp_init_sock(struct sock *sk)
>   
>   	WRITE_ONCE(sk->sk_sndbuf, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[1]));
>   	WRITE_ONCE(sk->sk_rcvbuf, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[1]));
> +	tcp_scaling_ratio_init(sk);
>   
>   	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>   	sk_sockets_allocated_inc(sk);
> @@ -1700,7 +1701,7 @@ EXPORT_SYMBOL(tcp_peek_len);
>   /* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
>   int tcp_set_rcvlowat(struct sock *sk, int val)
>   {
> -	int cap;
> +	int space, cap;
>   
>   	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
>   		cap = sk->sk_rcvbuf >> 1;
> @@ -1715,10 +1716,10 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
>   	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
>   		return 0;
>   
> -	val <<= 1;
> -	if (val > sk->sk_rcvbuf) {
> -		WRITE_ONCE(sk->sk_rcvbuf, val);
> -		tcp_sk(sk)->window_clamp = tcp_win_from_space(sk, val);
> +	space = tcp_space_from_win(sk, val);
> +	if (space > sk->sk_rcvbuf) {
> +		WRITE_ONCE(sk->sk_rcvbuf, space);
> +		tcp_sk(sk)->window_clamp = val;
>   	}
>   	return 0;
>   }
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 57c8af1859c16eba5e952a23ea959b628006f9c1..3cd92035e0902298baa8afd89ae5edcbfce300e5 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -237,6 +237,16 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
>   	 */
>   	len = skb_shinfo(skb)->gso_size ? : skb->len;
>   	if (len >= icsk->icsk_ack.rcv_mss) {
> +		/* Note: divides are still a bit expensive.
> +		 * For the moment, only adjust scaling_ratio
> +		 * when we update icsk_ack.rcv_mss.
> +		 */
> +		if (unlikely(len != icsk->icsk_ack.rcv_mss)) {
> +			u64 val = (u64)skb->len << TCP_RMEM_TO_WIN_SCALE;
> +
> +			do_div(val, skb->truesize);
> +			tcp_sk(sk)->scaling_ratio = val ? val : 1;
> +		}
>   		icsk->icsk_ack.rcv_mss = min_t(unsigned int, len,
>   					       tcp_sk(sk)->advmss);
>   		/* Account for possibly-removed options */
> @@ -727,8 +737,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
>   
>   	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
>   	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> -		int rcvmem, rcvbuf;
>   		u64 rcvwin, grow;
> +		int rcvbuf;
>   
>   		/* minimal window to cope with packet losses, assuming
>   		 * steady state. Add some cushion because of small variations.
> @@ -740,12 +750,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
>   		do_div(grow, tp->rcvq_space.space);
>   		rcvwin += (grow << 1);
>   
> -		rcvmem = SKB_TRUESIZE(tp->advmss + MAX_TCP_HEADER);
> -		while (tcp_win_from_space(sk, rcvmem) < tp->advmss)
> -			rcvmem += 128;
> -
> -		do_div(rcvwin, tp->advmss);
> -		rcvbuf = min_t(u64, rcvwin * rcvmem,
> +		rcvbuf = min_t(u64, tcp_space_from_win(sk, rcvwin),
>   			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
>   		if (rcvbuf > sk->sk_rcvbuf) {
>   			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);

-- 
js
suse labs


