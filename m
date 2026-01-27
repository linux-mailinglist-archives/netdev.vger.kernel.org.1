Return-Path: <netdev+bounces-253965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNJONJ/8eGmOuQEAu9opvQ
	(envelope-from <netdev+bounces-253965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:57:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4682A98AEA
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F27C8301682D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20082DB79B;
	Tue, 27 Jan 2026 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="EIuC7MJz"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112B3242B1
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536662; cv=none; b=bQV9/kyUwgVkZuq1e0+eEsEyTrsj4oo6FxxJBqNZE1YamqrfqsuJ99VURcphNAMEkIANuu/NXsZSVHXOIM8lu3ncvcDDQMAvDMqr/i+Nb6Tni7qR6Xpy13QqdoUkgAF7CS1zx4bn+erqSs/1yIlmNp6rLBPVnBISAyRZk5Tmjvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536662; c=relaxed/simple;
	bh=ZmUbpYt0h8OB6FNL8iL6ZXUZMWEsMZ7pS0LlZFb26uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nCqbA3Z4T1/1ZNCU13TABOblMoV4LUCFkhhZuAj8tzyKb0Rqbd6hUjwydoMB9d+cQLwEwsgx5jvOV0AVobuERx5iZm4PG3mveTCNVmOfehLoSGpSMTCEOgeJ05NO0rOKmPuQ1UYYeIaZsNBMuuahvSN24YlRBMR3vQC/pGLViVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=EIuC7MJz; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id AA210200AA5B;
	Tue, 27 Jan 2026 18:49:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be AA210200AA5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1769536188;
	bh=Vibqe/KiXQ3Dj5llZDIR1MKDZHA6Cn2HLyE0+erftBY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=EIuC7MJzTj8eEZyvzyQUl+i7OtOCmVGfBYbyqGoDyT0S0fc82v1HW3QuiaQDrs+k3
	 uMvZgIYMeZp050/qfhjwA65RdyAhUTQUs0IWR7ulLidGtia/3CFWRw/2n/rmq6oTd6
	 qPHCF3O3OJrjAa99sMwZUJwiUsvdqapy2PTji4cxWbGl7oK+xc+UjE4DuEBcNa14TG
	 kYNnul0yVWTKLYmAV4vq3BxlTBMMRPubNnLXOWgmcY8kxMOS82YsVlkkDLIiAdJng4
	 p9rSY8Aa54peXr9vUMU4I3mAdgdLJTJvnc4nm2bagVUm9htUbZMWINn6P2dv2RxtHn
	 FLKJkEcI61Rww==
Message-ID: <c405fdc2-89e0-4681-83f4-f0e61a891907@uliege.be>
Date: Tue, 27 Jan 2026 18:49:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/7] ipv6: Check of max HBH or DestOp sysctl
 is zero and drop if it is
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-2-tom@herbertland.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20260126194826.236075-2-tom@herbertland.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uliege.be,none];
	R_DKIM_ALLOW(-0.20)[uliege.be:s=ulg20190529];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253965-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[uliege.be:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@uliege.be,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,herbertland.com:email,uliege.be:mid,uliege.be:dkim]
X-Rspamd-Queue-Id: 4682A98AEA
X-Rspamd-Action: no action

On 1/26/26 20:48, Tom Herbert wrote:
> In IPv6 Destination options processing function check if
> net->ipv6.sysctl.max_dst_opts_cnt is zero up front. If it is zero then
> drop the packet since Destination Options processing is disabled.
> 
> Similarly, in IPv6 hop-by-hop options processing function check if
> net->ipv6.sysctl.max_hbh_opts_cnt is zero up front. If it is zero then
> drop the packet since Hop-by-Hop Options processing is disabled.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>   net/ipv6/exthdrs.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 54088fa0c09d..b9d186784b96 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -301,9 +301,11 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
>   #endif
>   	struct dst_entry *dst = skb_dst(skb);
>   	struct net *net = dev_net(skb->dev);
> -	int extlen;
> +	int extlen, max_opts_cnt;
>   
> -	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
> +	max_opts_cnt = READ_ONCE(net->ipv6.sysctl.max_dst_opts_cnt);
> +	if (!max_opts_cnt ||
> +	    !pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
>   	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
>   				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
>   		__IP6_INC_STATS(dev_net(dst_dev(dst)), idev,
> @@ -322,8 +324,7 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
>   	dstbuf = opt->dst1;
>   #endif
>   
> -	if (ip6_parse_tlv(false, skb,
> -			  READ_ONCE(net->ipv6.sysctl.max_dst_opts_cnt))) {
> +	if (ip6_parse_tlv(false, skb, max_opts_cnt)) {
>   		skb->transport_header += extlen;
>   		opt = IP6CB(skb);
>   #if IS_ENABLED(CONFIG_IPV6_MIP6)
> @@ -1033,7 +1034,7 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
>   {
>   	struct inet6_skb_parm *opt = IP6CB(skb);
>   	struct net *net = dev_net(skb->dev);
> -	int extlen;
> +	int extlen, max_opts_cnt;
>   
>   	/*
>   	 * skb_network_header(skb) is equal to skb->data, and
> @@ -1041,7 +1042,9 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
>   	 * sizeof(struct ipv6hdr) by definition of
>   	 * hop-by-hop options.
>   	 */
> -	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
> +	max_opts_cnt = READ_ONCE(net->ipv6.sysctl.max_hbh_opts_cnt);
> +	if (!max_opts_cnt ||
> +	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
>   	    !pskb_may_pull(skb, (sizeof(struct ipv6hdr) +
>   				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
>   fail_and_free:
> @@ -1054,8 +1057,7 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
>   		goto fail_and_free;
>   
>   	opt->flags |= IP6SKB_HOPBYHOP;
> -	if (ip6_parse_tlv(true, skb,
> -			  READ_ONCE(net->ipv6.sysctl.max_hbh_opts_cnt))) {
> +	if (ip6_parse_tlv(true, skb, max_opts_cnt)) {
>   		skb->transport_header += extlen;
>   		opt = IP6CB(skb);
>   		opt->nhoff = sizeof(struct ipv6hdr);

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

