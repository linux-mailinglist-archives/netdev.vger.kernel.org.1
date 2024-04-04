Return-Path: <netdev+bounces-84874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AAD898823
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156911C208B5
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B82F6CDCA;
	Thu,  4 Apr 2024 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="ZrzEDhqj"
X-Original-To: netdev@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965A7492
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234679; cv=none; b=c6SyhkrmE4qqDMjrWd3N+Ghvzj2Xwn/0rYwMhNenaORLo0y0TTXSb94pn//wAUfl+bqaWW3mgBSCdwjGcryngXJtI/BMt3LMzraHrbB0tVB7h+GkivqALKghxJ1mAWFSK2kYkf2a+eEc7tqj8+O6qnX/ukZqrUHsBhOIfV+AYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234679; c=relaxed/simple;
	bh=m3SloXrgO3zj2CZ1/FZFNDAKLdRgp/fJJBN5Y+PmWYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkkqv2q8BMfYKRmXhWzUqoBneioGP7zCf/IDkJRgwSs7DlGD2Yz9EqmKiBR1RASLEQ1bole4kohxv9dQ1Ytr4Nzgl9x4wyIRTNyWMPyFKeBBzcncm5oPMugpi3JjqO3ueWs8LTewUEBkOYsBVYl4O/fHcYu4EswVZr3kkNnNpFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=ZrzEDhqj; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id AAF005A0002;
	Thu,  4 Apr 2024 14:35:18 +0200 (CEST)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LIlzJrAtKiFs; Thu,  4 Apr 2024 14:35:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1712234117;
	bh=m3SloXrgO3zj2CZ1/FZFNDAKLdRgp/fJJBN5Y+PmWYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZrzEDhqjUPdDupl+yjW1QwtgzZuffCwY1v1leABPpxrXdpo1kN4F8h+nTh7fsMQn4
	 QjIYMVe+SoRaoQQHNYGcSz4Mf8WwbI3czTaFvimp6U/vqO1dODnMv8NssSzvrjBbyf
	 zvG9jIf9pR8irMx20zJ6vUKbtqSWowNoCi11ChAbcDucR1ngp3E+rRXRcCkLbHI5Qz
	 7uk0skNNScb+5akgZD0UmRLUiH9hbdrncN9FWqxdI8HotbNSIiVjq1ySRRIlGshJyB
	 Fl2+i4VORQZdrK6y5rYDmE2miNR9CcnME2QYP6jSQ46Ea0+hNN7a7oqsEMrslZs/nC
	 HbVMJ48qP8NQA==
Received: from [IPV6:2a01:8b81:5400:f500:4abe:964f:1d23:3358] (unknown [IPv6:2a01:8b81:5400:f500:4abe:964f:1d23:3358])
	by mail.codelabs.ch (Postfix) with ESMTPSA id 3331B5A0001;
	Thu,  4 Apr 2024 14:35:17 +0200 (CEST)
Message-ID: <07500455-9f33-4588-bb1d-cdd38657caf8@strongswan.org>
Date: Thu, 4 Apr 2024 14:35:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] xfrm: fix source address in icmp error generation
 from IPsec gateway
To: antony.antony@secunet.com, Jakub Kicinski <kuba@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>, devel@linux-ipsec.org
References: <cover.1712226175.git.antony.antony@secunet.com>
 <20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com>
From: Tobias Brunner <tobias@strongswan.org>
Content-Language: en-US, de-CH-frami
Autocrypt: addr=tobias@strongswan.org; keydata=
 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
 tvkh7XWO2ycrW1UlzUzM4KV3SDLIhfOU
In-Reply-To: <20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04.04.24 12:31, Antony Antony wrote:
> When enabling support for XFRM lookup using reverse ICMP payload, we
> have identified an issue where the source address of the IPv4, e.g.,
> "Destination Host Unreachable" message, is incorrect. The error message
> received by the sender appears to originate from a 
> non-existing/unreachable host.  IPv6 seems to behave correctly; respond 
> with an existing source address from the gateway.
> 
> Here is example of incorrect source address for ICMP error response.
> When sending a ping to an unreachable host, the sender would receive an
> ICMP unreachable response with a fake source address. Rather the address
> of the host that generated ICMP Unreachable message. This is confusing
> and incorrect.
> 
> Example:
> ping -W 9 -w 5 -c 1 10.1.4.3
> PING 10.1.4.3 (10.1.4.3) 56(84) bytes of data.
> From 10.1.4.3 icmp_seq=1 Destination Host Unreachable
> 
> Notice : packet has the source address of the ICMP "Unreachable host!"
> 
> This issue can be traced back to commit
> 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
> which introduced a change that copied the source address from the ICMP
> payload.
> 
> This commit would force to use source address from the gatway/host.
> The ICMP error message source address correctly set from the host.
> 
> After fixing:
> ping -W 5 -c 1 10.1.4.3
> PING 10.1.4.3 (10.1.4.3) 56(84) bytes of data.
> From 10.1.3.2 icmp_seq=1 Destination Host Unreachable
> 
> Here is an snippt to reporduce the issue.
> 
> export AB="10.1"
> for i in 1 2 3 4 5; do
>         h="host${i}"
>         ip netns add ${h}
>         ip -netns ${h} link set lo up
>         ip netns exec ${h} sysctl -wq net.ipv4.ip_forward=1
>         if [ $i -lt 5 ]; then
>                 ip -netns ${h} link add eth0 type veth peer name eth10${i}
>                 ip -netns ${h} addr add "${AB}.${i}.1/24" dev eth0
>                 ip -netns ${h} link set up dev eth0
>         fi
> done
> 
> for i in 1 2 3 4 5; do
>         h="host${i}"
>         p=$((i - 1))
>         ph="host${p}"
>         # connect to previous host
>         if [ $i -gt 1 ]; then
>                 ip -netns ${ph} link set eth10${p} netns ${h}
>                 ip -netns ${h} link set eth10${p} name eth1
>                 ip -netns ${h} link set up dev eth1
>                 ip -netns ${h} addr add "${AB}.${p}.2/24" dev eth1
>         fi
>         # add forward routes
>         for k in $(seq ${i} $((5 - 1))); do
>                 ip -netns ${h} route 2>/dev/null | (grep "${AB}.${k}.0" 2>/dev/null) || \
>                 ip -netns ${h} route add "${AB}.${k}.0/24" via "${AB}.${i}.2" 2>/dev/nul
>         done
> 
>         # add reverse routes
>         for k in $(seq 1 $((i - 2))); do
>                 ip -netns ${h} route 2>/dev/null | grep "${AB}.${k}.0" 2>/dev/null || \
>                 ip -netns ${h} route add "${AB}.${k}.0/24" via "${AB}.${p}.1" 2>/dev/nul
>         done
> done
> 
> ip netns exec host1 ping -q -W 2 -w 1 -c 1 10.1.4.2 2>&1>/dev/null && echo "success 10.1.4.2 reachable" || echo "ERROR"
> ip netns exec host1 ping -W 9 -w 5 -c 1 10.1.4.3 || echo  "note the source address of unreachble of gateway"
> ip -netns host1 route flush cache
> 
> ip netns exec host3 nft add table inet filter
> ip netns exec host3 nft add chain inet filter FORWARD { type filter hook forward priority filter\; policy drop \; }
> ip netns exec host3 nft add rule inet filter FORWARD counter ip protocol icmp drop
> ip netns exec host3 nft add rule inet filter FORWARD counter ip protocol esp accept
> ip netns exec host3 nft add rule inet filter FORWARD counter drop
> 
> ip -netns host2 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir out \
>         flag icmp tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 1 mode tunnel
> 
> ip -netns host2 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir in \
>         tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 2 mode tunnel
> 
> ip -netns host2 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir fwd \
>         flag icmp tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 2 mode tunnel
> 
> ip -netns host2 xfrm state add src 10.1.2.1 dst 10.1.3.2 proto esp spi 1 \
>         reqid 1 replay-window 1  mode tunnel aead 'rfc4106(gcm(aes))' \
>         0x1111111111111111111111111111111111111111 96 \
>         sel src 10.1.1.0/24 dst 10.1.4.0/24
> 
> ip -netns host2 xfrm state add src 10.1.3.2 dst 10.1.2.1 proto esp spi 2 \
>         flag icmp reqid 2 replay-window 10 mode tunnel aead 'rfc4106(gcm(aes))' \
>         0x2222222222222222222222222222222222222222 96
> 
> ip -netns host4 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir out \
>         flag icmp tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 1 mode tunnel
> 
> ip -netns host4 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir in \
>         tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 2  mode tunnel
> 
> ip -netns host4 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir fwd \
>                 flag icmp tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 2 mode tunnel
> 
> ip -netns host4 xfrm state add src 10.1.3.2 dst 10.1.2.1 proto esp spi 2 \
>         reqid 1 replay-window 1 mode tunnel aead 'rfc4106(gcm(aes))' \
>         0x2222222222222222222222222222222222222222 96
> 
> ip -netns host4 xfrm state add src 10.1.2.1 dst 10.1.3.2 proto esp spi 1 \
>         reqid 2 replay-window 20 flag icmp  mode tunnel aead 'rfc4106(gcm(aes))' \
>         0x1111111111111111111111111111111111111111 96 \
>         sel src 10.1.1.0/24 dst 10.1.4.0/24
> 
> ip netns exec host1 ping -W 5 -c 1 10.1.4.2 2>&1 > /dev/null && echo ""
> ip netns exec host1 ping -W 5 -c 1 10.1.4.3 || echo "note source address of gateway 10.1.3.2"
> 
> Again before the fix
> ping -W 5 -c 1 10.1.4.3
> From 10.1.4.3 icmp_seq=1 Destination Host Unreachable
> 
> After the fix
> From 10.1.3.2 icmp_seq=1 Destination Host Unreachable
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
>  net/ipv4/icmp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index e63a3bf99617..bec234637122 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -555,7 +555,6 @@ static struct rtable *icmp_route_lookup(struct net *net,
>  					    XFRM_LOOKUP_ICMP);
>  	if (!IS_ERR(rt2)) {
>  		dst_release(&rt->dst);
> -		memcpy(fl4, &fl4_dec, sizeof(*fl4));
>  		rt = rt2;
>  	} else if (PTR_ERR(rt2) == -EPERM) {
>  		if (rt)

Acked-by: Tobias Brunner <tobias@strongswan.org>


