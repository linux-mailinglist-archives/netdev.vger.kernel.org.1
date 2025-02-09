Return-Path: <netdev+bounces-164513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43B8A2E050
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 20:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A0A164A6F
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 19:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB101DF255;
	Sun,  9 Feb 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="c5Bl3M6b"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2320136A
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739130742; cv=none; b=Huy5rWQiiPKGjSsypE8Q3HD7gtxn34zdcjPA5gmAVfbtHr94cL1R9hdrndcHcsKk1Hw7l67BYCE/PkJ97rtIMUjQjb6vx7sWuB+UQp+ScXuPl2wU7ohmfXUjCYw8+E8YX1S3gddvBn0zIhHbJ/QJEqgxTrkzL4KfC+ZVNml9oYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739130742; c=relaxed/simple;
	bh=oNvMWtDT7LUxnjcsfHHoc75V6dTkR57frqxfmGO//8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DocTEfB+9PZoW1IQo98vaPv3qkLUNXEJw1DPGyOuvZtI06Ef6b01PQQHfHHlJ/2R8lPgOZ9gGPpZ+flVr+rVnr4noX7a/+qe0MFeBCGuM4RIJsQoAQOGtDvOvyPiqk6XYWmyOrO7E/UBmObwQsm6g5HOTcxmDP6v71SNj5nEUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=c5Bl3M6b; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.144.30] (lfbn-ncy-1-721-166.w86-216.abo.wanadoo.fr [86.216.56.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 05B21200E2B4;
	Sun,  9 Feb 2025 20:52:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 05B21200E2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1739130738;
	bh=A95uyd291WmiDrrL4UHrMnRs1HIjKd5eyo0IN5HhIio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c5Bl3M6b14kTMAyaeghCZU85kdjvw7lwuK7X9sacYjH/nE6ZVl8dsQzj2NGOCelvl
	 +qtS2rEjgOu9ZohbriXjldCGCo1qxF38kdbz7tEG9L6zsFoAnl/S1ZJo3Ui3IIJ5hU
	 rjpnkmHlLNZWSyt7hTCxAQilGkBPdFVeGswPLgv3HkVaAZxbV/F66Gnq/Ac0eJ/N3k
	 pxP8AikRQVGdRoLoPkelFJVXSlrY6E8c3YwmAI1ePbMmieoG5bk1Ybra6Mq7fQxsCU
	 LSsaVt0Jo8EGskC0qI+1f29rY49SLFDReBO1OtI8HTuuSHTzu/HLoCx+tD0AY4IA/l
	 msBlx2XZN/i7g==
Message-ID: <af6c02ca-2f40-4e1a-88d2-89fc8c110756@uliege.be>
Date: Sun, 9 Feb 2025 20:52:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net: ipv6: fix dst ref loops on input in
 lwtunnels
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 Alexander Aring <aahringo@redhat.com>, David Lebrun <dlebrun@google.com>
References: <20250209193840.20509-1-justin.iurman@uliege.be>
 <20250209193840.20509-2-justin.iurman@uliege.be>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250209193840.20509-2-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/25 20:38, Justin Iurman wrote:
> As a follow up to 92191dd10730 ("net: ipv6: fix dst ref loops in rpl,
> seg6 and ioam6 lwtunnels"), we also need a conditional dst cache on
> input for seg6_iptunnel and rpl_iptunnel to prevent dst ref loops (i.e.,
> if the packet destination did not change, we may end up recording a
> reference to the lwtunnel in its own cache, and the lwtunnel state will
> never be freed).
> 
> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> Cc: Alexander Aring <aahringo@redhat.com>
> Cc: David Lebrun <dlebrun@google.com>
> ---
>   net/ipv6/rpl_iptunnel.c  | 14 ++++++++++++--
>   net/ipv6/seg6_iptunnel.c | 14 ++++++++++++--
>   2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
> index 0ac4283acdf2..c26bf284459f 100644
> --- a/net/ipv6/rpl_iptunnel.c
> +++ b/net/ipv6/rpl_iptunnel.c
> @@ -262,10 +262,18 @@ static int rpl_input(struct sk_buff *skb)
>   {
>   	struct dst_entry *orig_dst = skb_dst(skb);
>   	struct dst_entry *dst = NULL;
> +	struct lwtunnel_state *lwtst;
>   	struct rpl_lwt *rlwt;
>   	int err;
>   
> -	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
> +	/* Get the address of lwtstate now, because "orig_dst" may not be there
> +	 * anymore after a call to skb_dst_drop(). Note that ip6_route_input()
> +	 * also calls skb_dst_drop(). Below, we compare the address of lwtstate
> +	 * to detect loops.
> +	 */
> +	lwtst = orig_dst->lwtstate;
> +
> +	rlwt = rpl_lwt_lwtunnel(lwtst);
>   
>   	local_bh_disable();
>   	dst = dst_cache_get(&rlwt->cache);
> @@ -280,7 +288,9 @@ static int rpl_input(struct sk_buff *skb)
>   	if (!dst) {
>   		ip6_route_input(skb);
>   		dst = skb_dst(skb);
> -		if (!dst->error) {
> +
> +		/* cache only if we don't create a dst reference loop */
> +		if (!dst->error && lwtst != dst->lwtstate) {
>   			local_bh_disable();
>   			dst_cache_set_ip6(&rlwt->cache, dst,
>   					  &ipv6_hdr(skb)->saddr);
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 33833b2064c0..6045e850b4bf 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -472,10 +472,18 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>   {
>   	struct dst_entry *orig_dst = skb_dst(skb);
>   	struct dst_entry *dst = NULL;
> +	struct lwtunnel_state *lwtst;
>   	struct seg6_lwt *slwt;
>   	int err;
>   
> -	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
> +	/* Get the address of lwtstate now, because "orig_dst" may not be there
> +	 * anymore after a call to skb_dst_drop(). Note that ip6_route_input()
> +	 * also calls skb_dst_drop(). Below, we compare the address of lwtstate
> +	 * to detect loops.
> +	 */
> +	lwtst = orig_dst->lwtstate;
> +
> +	slwt = seg6_lwt_lwtunnel(lwtst);
>   
>   	local_bh_disable();
>   	dst = dst_cache_get(&slwt->cache);
> @@ -490,7 +498,9 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>   	if (!dst) {
>   		ip6_route_input(skb);
>   		dst = skb_dst(skb);
> -		if (!dst->error) {
> +
> +		/* cache only if we don't create a dst reference loop */
> +		if (!dst->error && lwtst != dst->lwtstate) {
>   			local_bh_disable();
>   			dst_cache_set_ip6(&slwt->cache, dst,
>   					  &ipv6_hdr(skb)->saddr);

... which makes me think while we're at it: should we directly drop the 
packet when dst->error (just like it's already done in output() 
handlers)? Not sure it's useful to send a DestUnreach in this case, 
especially considering that it may leak data. At least, we probably need 
to have consistency between input and output behavior. Thoughts?

