Return-Path: <netdev+bounces-43485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A177D3924
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C634281242
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA3A1B286;
	Mon, 23 Oct 2023 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXqtsBl0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080F11CB7
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 14:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AD9C433C7;
	Mon, 23 Oct 2023 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698070738;
	bh=XKHA+o3oAqp09heCyRAIPWkyf94HR5PsGQ+iB2G7+R4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=SXqtsBl0acWkhV/sCPXQG+Utt7JaB3KYlIbEyxJC+W54DIqmBKHov+jQIjMU/UItE
	 010fYFXToKgIPVNKJXUv2n0OEiBkHvLzMYGp23QH/MVdRaGyJOHDX4dCYJkwDJRF9t
	 1O307y6lQQE+RArvnyI0aLLf7tGu5L4bA04vkiwnYAZamzJE9AeTiN45mexw0eavih
	 PhUGyPbtMth/t6p6eLmDjDdvFaBPEIJZLOkIBYI4KKoDqV8QjGDWscPiEcDHqsOzF2
	 H/UnTpi8unNmg2OUn0Vm3JIXIi+I9Zj/5ij+WrBli8OwrfGwACHmg/hpr4o4BZURKr
	 T+05CXxngK04g==
Message-ID: <df63abf1-90cc-4f94-90e4-0ffb44c914f2@kernel.org>
Date: Mon, 23 Oct 2023 08:18:57 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests:net change ifconfig with ip command
Content-Language: en-US
To: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
 davem@davemloft.net, jiri@resnulli.us, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <ZTYc04N9VK7EarHY@nanopsycho>
 <20231023123422.2895-1-swarupkotikalapudi@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231023123422.2895-1-swarupkotikalapudi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/23 6:34 AM, Swarup Laxman Kotiaklapudi wrote:
> Change ifconfig with ip command,
> on a system where ifconfig is
> not used this script will not
> work correcly.
> 
> Test result with this patchset:
> 
> sudo make TARGETS="net" kselftest
> ....
> TAP version 13
> 1..1
>  timeout set to 1500
>  selftests: net: route_localnet.sh
>  run arp_announce test
>  net.ipv4.conf.veth0.route_localnet = 1
>  net.ipv4.conf.veth1.route_localnet = 1
>  net.ipv4.conf.veth0.arp_announce = 2
>  net.ipv4.conf.veth1.arp_announce = 2
>  PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84)
>   bytes of data.
>  64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.038 ms
>  64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.068 ms
>  64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.068 ms
>  64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.068 ms
>  64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.068 ms
> 
>  --- 127.25.3.14 ping statistics ---
>  5 packets transmitted, 5 received, 0% packet loss, time 4073ms
>  rtt min/avg/max/mdev = 0.038/0.062/0.068/0.012 ms
>  ok
>  run arp_ignore test
>  net.ipv4.conf.veth0.route_localnet = 1
>  net.ipv4.conf.veth1.route_localnet = 1
>  net.ipv4.conf.veth0.arp_ignore = 3
>  net.ipv4.conf.veth1.arp_ignore = 3
>  PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84)
>   bytes of data.
>  64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.032 ms
>  64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.065 ms
>  64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.066 ms
>  64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.065 ms
>  64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.065 ms
> 
>  --- 127.25.3.14 ping statistics ---
>  5 packets transmitted, 5 received, 0% packet loss, time 4092ms
>  rtt min/avg/max/mdev = 0.032/0.058/0.066/0.013 ms
>  ok
> ok 1 selftests: net: route_localnet.sh
> ...
> 
> Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> ---
>  tools/testing/selftests/net/route_localnet.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/route_localnet.sh b/tools/testing/selftests/net/route_localnet.sh
> index 116bfeab72fa..e08701c750e3 100755
> --- a/tools/testing/selftests/net/route_localnet.sh
> +++ b/tools/testing/selftests/net/route_localnet.sh
> @@ -18,8 +18,10 @@ setup() {
>      ip route del 127.0.0.0/8 dev lo table local
>      ip netns exec "${PEER_NS}" ip route del 127.0.0.0/8 dev lo table local
>  
> -    ifconfig veth0 127.25.3.4/24 up
> -    ip netns exec "${PEER_NS}" ifconfig veth1 127.25.3.14/24 up
> +    ip address add 127.25.3.4/24 dev veth0
> +    ip link set dev veth0 up
> +    ip netns exec "${PEER_NS}" ip address add 127.25.3.14/24 dev veth1
> +    ip netns exec "${PEER_NS}" ip link set dev veth1 up
>  
>      ip route flush cache
>      ip netns exec "${PEER_NS}" ip route flush cache

Reviewed-by: David Ahern <dsahern@kernel.org>


