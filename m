Return-Path: <netdev+bounces-246678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 825C5CF0506
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 20:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 713683007228
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E86930F538;
	Sat,  3 Jan 2026 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxNDb/ti"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CBF30F522;
	Sat,  3 Jan 2026 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767468610; cv=none; b=cPv7N/dAle8A7ioMUM6pgQg/N2PS+nB16rwjBlKnERX8ki1Ozjm9bgfFnN9nflRPjFL5voqVDE7yEUEVsVaey/7OlVPNiBLvVsqiCNtPuqnmJloR2Vwb861Ixucv1vCRAAQuCfKLA79DAZpftrKYvMNzZKQVYnxrys0PjuTKh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767468610; c=relaxed/simple;
	bh=Vw0CSYs8ZRkyhGGBdWqeozUHGguxua25NRiezzbXUrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEiTj/4Zysb7lq+YQDXMUbH+4HQ9SyVnepqzVpXRoyUU8knVsuvYJt7PpCSRLW3ET1kApuC+K6oMx7G3wCSonKy8AHIrd5+Cj0QnVZl4KCUB+u1g2tC12vS/KN9oAaqWD6moY/EhLPomoqD/l2UdKr9V0Bq7QT18GnNblO6y6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxNDb/ti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8A5C113D0;
	Sat,  3 Jan 2026 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767468609;
	bh=Vw0CSYs8ZRkyhGGBdWqeozUHGguxua25NRiezzbXUrs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mxNDb/tiulVEVHsTMBerD96HPEwq+MX48PgQ/xjZqBlP+0XY5qY9dQ044l8xRU2wE
	 K5WR9ArGjmJxyl/HwRsMiPKhB+74gz7R2/wNlPrdYEFPg3H17W05stdbCzkKLT4H7X
	 jcL2EPlkT8O05zmOOLun8XxMC9KAZzy9cb2J8HKGorrpr7AG0kGGcmIVdvDSGnc5gM
	 TY4HlfVJR/izOmXO54RZeKR82FdTmeCdrMoLypUPgV6/dZvSveUTqD0mwRwHnT3dN/
	 gtFWrhm1R2MAUNVLa7rZRnc75Ml22cUm8qkG/lXTILjIiM/Y/+Uo7ntpVlq3woM5Jj
	 ybS0joUVwqG6A==
Message-ID: <c269cd25-9e77-4b8c-9cf6-8f2cc86296e7@kernel.org>
Date: Sat, 3 Jan 2026 12:30:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv4: Improve martian logs
Content-Language: en-US
To: Clara Engler <cve@cve.cx>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
References: <20260101125114.2608-1-cve@cve.cx>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260101125114.2608-1-cve@cve.cx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/1/26 5:51 AM, Clara Engler wrote:
> At the current moment, the logs for martian packets are as follows:
> ```
> martian source {DST} from {SRC}, on dev {DEV}
> martian destination {DST} from {SRC}, dev {DEV}
> ```
> 
> These messages feel rather hard to understand in production, especially
> the "martian source" one, mostly because it is grammatically ambitious
> to parse which part is now the source address and which part is the
> destination address.  For example, "{DST}" may there be interpreted as
> the actual source address due to following the word "source", thereby
> implying the actual source address to be the destination one.
> 
> Personally, I discovered this bug while toying around with TUN
> interfaces and using them as a tunnel (receiving packets via a TUN
> interface and sending them over a TCP stream; receiving packets from a
> TCP stream and writing them to a TUN).[^1]
> 
> When these IP addresses contained local IPs (i.e. 10.0.0.0/8 in source
> and destination), everything worked fine.  However, sending them to a
> real routable IP address on the internet led to them being treated as a
> martian packet, obviously.  Using a few sysctl(8) and iptables(8)
> settings[^2] fixed it, but while debugging I found the log message
> starting with "martian source" rather confusing, as I was unsure on
> whether the packet that gets dropped was the packet originating from me
> or the response from the endpoint, as "martian source <ROUTABLE IP>"
> could also be falsely interpreted as the response packet being martian,
> due to the word "source" followed by the routable IP address, implying
> the source address of that packet is set to this IP, as explained above.
> In the end, I had to look into the source code of the kernel on where
> this error message gets generated, which is usually an indicator of
> there being room for improvement with regard to this error message.
> 
> In terms of improvement, this commit changes the error messages for
> martian source and martian destination packets as follows:
> ```
> martian source (src={SRC}, dst={DST}, dev={DEV})
> martian destination (src={SRC}, dst={DST}, dev={DEV})
> ```
> 
> These new wordings leave pretty much no room for ambiguity as all
> parameters are prefixed with a respective key explaining their semantic
> meaning.
> 
> See also the following thread on LKML.[^3]
> 
> [^1]: <https://backreference.org/2010/03/26/tuntap-interface-tutorial>
> [^2]: sysctl net.ipv4.ip_forward=1 && \
>       iptables -A INPUT -i tun0 -j ACCEPT && \
>       iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
> [^3]: <https://lore.kernel.org/all/aSd4Xj8rHrh-krjy@4944566b5c925f79/>
> 
> Signed-off-by: Clara Engler <cve@cve.cx>
> ---
>  net/ipv4/route.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


