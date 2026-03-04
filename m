Return-Path: <netdev+bounces-263860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yABVD6NQqGmztAAAu9opvQ
	(envelope-from <netdev+bounces-263860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:32:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8010202C3F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 458FF30A4818
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E6E3385B2;
	Wed,  4 Mar 2026 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzBZ7T2H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA0333441;
	Wed,  4 Mar 2026 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637721; cv=none; b=XpUleBdLU7Zpph+wMCCB8VWBWstzjpgqqC87drr5+TEahnCzni2GP07vsGdco2MxUwqTUtdjTIwvp8o1s+SgLXFICwFlv5W1l1ZIQs2PNIcumywAlaQ35C/5KRhMMaDyvJkxhYkqlZzfolN46uDQqAv37t7gGPNhG/b4A4NDZ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637721; c=relaxed/simple;
	bh=kTu8CJ1qHsUtnK4g50QhfvjQwtH2+08U07yo0LS22nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cML8NZ+bTqPhdWKOWCphyqOJWnIyVH6Xe/8JC9puwrPv2WLiEOf7biqnri2kWJ/GmO9dPEsdhEkL3K3lKhQiVAA4imkb0n6vMdVCT+q8fH1WUQ405bucsg0RawQCnGliOFrkb2TA7FiOSBBaUMcPZmVDDsgAe8+LMr62NvJ9cb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzBZ7T2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3320C4CEF7;
	Wed,  4 Mar 2026 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772637721;
	bh=kTu8CJ1qHsUtnK4g50QhfvjQwtH2+08U07yo0LS22nQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dzBZ7T2Hn/+RnOHiQsA/d+pgTe8aPvfcmX/0YilYy1nlkif6Mz6MKr/Gblc/mk6BQ
	 y/qDLaYsuu6d8/imoTsM3lRleXuehvgOugNkPJtYyYvdCzNBSGe2dmERu5hENmybri
	 4HoTlgM5RiULOwKEv2uli+hW+z4aimSyHxZ54A2barMi640zjKc0O2z+pZwsqUmMXW
	 NPRXg5rKp0bCz6Jms26NtBhLkJiJyKJJMA3V0dqpd8Jv0b1CluOOfuP3V5xaEk5tCQ
	 Ewc4MvYmCOrea6SoYENwI3kTOg8fiscfBU8lz++gn97z4MAiun66w/n0fIyiQxkwaV
	 DK7W9iNYVf4og==
Message-ID: <2148b03c-bd94-4de1-94f3-0978a8dc74b7@kernel.org>
Date: Wed, 4 Mar 2026 08:22:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] selftests: net: add test for IPv4 route with
 loopback IPv6 nexthop
Content-Language: en-US
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 idosch@nvidia.com
Cc: jiayuan.chen@shopee.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260304113817.294966-1-jiayuan.chen@linux.dev>
 <20260304113817.294966-3-jiayuan.chen@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260304113817.294966-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D8010202C3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263860-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,shopee.com:email]
X-Rspamd-Action: no action

On 3/4/26 4:38 AM, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Add a regression test for a kernel panic that occurs when an IPv4 route
> references an IPv6 nexthop object created on the loopback device.
> 
> The test creates an IPv6 nexthop on lo, binds an IPv4 route to it, then
> triggers a route lookup via ping to verify the kernel does not crash.
> 
>   ./fib_nexthops.sh
>   Tests passed: 249
>   Tests failed:   0
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  tools/testing/selftests/net/fib_nexthops.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
> index 21026b667667..6eb7f95e70e1 100755
> --- a/tools/testing/selftests/net/fib_nexthops.sh
> +++ b/tools/testing/selftests/net/fib_nexthops.sh
> @@ -1672,6 +1672,17 @@ ipv4_withv6_fcnal()
>  
>  	run_cmd "$IP ro replace 172.16.101.1/32 via inet6 2001:db8:50::1 dev veth1"
>  	log_test $? 2 "IPv4 route with invalid IPv6 gateway"
> +
> +	# Test IPv4 route with loopback IPv6 nexthop
> +	# Regression test: loopback IPv6 nexthop was misclassified as reject
> +	# route, skipping nhc_pcpu_rth_output allocation, causing panic when
> +	# an IPv4 route references it and triggers __mkroute_output().
> +	run_cmd "$IP -6 nexthop add id 20 dev lo"
> +	run_cmd "$IP ro add 172.20.20.0/24 nhid 20"
> +	run_cmd "ip netns exec $me ping -c1 -W1 172.20.20.1"
> +	log_test $? 1 "IPv4 route with loopback IPv6 nexthop (no crash)"
> +	run_cmd "$IP ro del 172.20.20.0/24"
> +	run_cmd "$IP nexthop del id 20"
>  }
>  
>  ipv4_fcnal_runtime()


Reviewed-by: David Ahern <dsahern@kernel.org>


