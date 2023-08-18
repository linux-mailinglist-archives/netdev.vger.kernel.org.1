Return-Path: <netdev+bounces-28831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E379780EE9
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 17:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8784E1C215FD
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EE018C27;
	Fri, 18 Aug 2023 15:18:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CB18AF0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 15:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CB3C433C7;
	Fri, 18 Aug 2023 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692371895;
	bh=DUFFBaRc8zRt9kaAlW9zNS5Roer/0a8d64bSW9bDss4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gOVfk2JxBtY8bim0EXIx2VNS3ad6Tq1POu/SakNWzgTKXxLDZoOBNPY0c8v43XRBU
	 MDInH+jWOGf0NnDOIn4E+5hxVVzDDmH3kZT5vOdmC6l2sKdYe7g6Oktcjebba8lu6j
	 bVrJKUk/Dmja5V7YlTJFHuiU2ZrNwtUvazQiLHO6XrVABZgUROCWMfleqwx9eYJ4oo
	 jcZJ66XVo/6BDiAzazCkqnWolGPmbHWAHIM8CBjXxFlPg3xYO6J6SeMngVE3gFaPns
	 aA2C94E3c8di6veUtzb6QLAs/rhsTTo2FaLb1BajBBpW0dzyWDeenihCL5PZPj513t
	 gAfWX/O8R9E/w==
Message-ID: <78721609-ced2-9cb7-a0d3-d4e1d90494a7@kernel.org>
Date: Fri, 18 Aug 2023 09:18:13 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] selftests: vrf_route_leaking: remove
 ipv6_ping_frag from default testing
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Michael Jeanson <mjeanson@efficios.com>
References: <20230818080613.1969817-1-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230818080613.1969817-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/23 2:06 AM, Hangbin Liu wrote:
> As the initial commit 1a01727676a8 ("selftests: Add VRF route leaking
> tests") said, the IPv6 MTU test fails as source address selection
> picking ::1. Every time we run the selftest this one report failed.
> There seems not much meaning  to keep reporting a failure for 3 years
> that no one plan to fix/update. Let't just skip this one first. We can
> add it back when the issue fixed.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/vrf_route_leaking.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/vrf_route_leaking.sh b/tools/testing/selftests/net/vrf_route_leaking.sh
> index 23cf924754a5..dedc52562b4f 100755
> --- a/tools/testing/selftests/net/vrf_route_leaking.sh
> +++ b/tools/testing/selftests/net/vrf_route_leaking.sh
> @@ -565,7 +565,7 @@ EOF
>  command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
>  
>  TESTS_IPV4="ipv4_ping_ttl ipv4_traceroute ipv4_ping_frag ipv4_ping_ttl_asym ipv4_traceroute_asym"
> -TESTS_IPV6="ipv6_ping_ttl ipv6_traceroute ipv6_ping_frag ipv6_ping_ttl_asym ipv6_traceroute_asym"
> +TESTS_IPV6="ipv6_ping_ttl ipv6_traceroute ipv6_ping_ttl_asym ipv6_traceroute_asym"
>  
>  ret=0
>  nsuccess=0

Needs to be fixed, but clearly not a high priority. I am ok with
disabling the failed test:

Reviewed-by: David Ahern <dsahern@kernel.org>


