Return-Path: <netdev+bounces-268556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGGkOC8zuWnsuQEAu9opvQ
	(envelope-from <netdev+bounces-268556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:55:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7EF2A8594
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13E3C301BDE1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101C237418F;
	Tue, 17 Mar 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="w7DMCo8n";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="JIwOoIsn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95333262A;
	Tue, 17 Mar 2026 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744941; cv=none; b=sceV43QATc3R62OcyyETZVm3CSNKtPT7dygjntuO98HQg/ax8lsd6W783MFF94UUOK2dQEO6NCyt80OCFGwhvjYbojGZZadpMrgWuw70INMR+iNSK0luZ0FL2rbvR7oxRkdml5jBQfXEeE8zBNtP9AzKhgwptu32xBX9tPUFK3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744941; c=relaxed/simple;
	bh=YI/w6nfDdCbXO0EA3R5fmwBo0cUSoPGyuU4HBe/Pbj8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OXX5bcwRIEx/XhafyHbljwCM3AFxjI95TZ/gfDvQPp6wlrh9pE9o3N4zW2kzCtbCWoMQPIJIq4oA2Jb9VaRTFaJElnIsunTqyK3uzQneQrpqzvncEeu+DypEcRaUz8VMb/XxEDyhhfXjaa1MhLHKxkAh4WJ0wuScVhDtJcN5W2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=w7DMCo8n; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=JIwOoIsn; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62HAsbMB022753;
	Tue, 17 Mar 2026 11:54:43 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id BA9041207BB;
	Tue, 17 Mar 2026 11:54:31 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1773744873; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPxFLRiGvPATYnRDpR7bBlwf0G1fS8MUdK3iJAuB190=;
	b=w7DMCo8nlQ+jkMBk/GipDjQTMsdix78M1XCxb9SvwX3AN4ir5NDYyNiBlqXYHxVZKYOy0t
	t8W8MCHDfuIdLEAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1773744873; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPxFLRiGvPATYnRDpR7bBlwf0G1fS8MUdK3iJAuB190=;
	b=JIwOoIsn4NB9ZrLgMhtgmpPMbYSOVI5z2AwWpZgdHPu8yyiJtqJ7muA/ttJRqs8chm98Ln
	o288G8rE/EhfJ7Q/9ZZ14tLaItB7I2C1jZNq/RTzMLDUVI7Ry+lPrBQB/1cLBVSobgQU0u
	IltiCxSGHvRTzakV8Mmn0/jrVeEd04nh9Oklymuun3fP2bg6CS6hNCNKEQtFHKOxP+8Cmw
	037i5AV/No7oSyE/ZRCGjP77SVb9Nf9sD7SSsFG2TOlJlIj+mZxqOafRQH/S4OToeE2As/
	nlhAGx5idY76exbVmvm/NK+42olmybC18HlJCniKE/WDRqXgIi9wYoKXTpLPkg==
Date: Tue, 17 Mar 2026 11:54:30 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Justin Iurman <justin.iurman@6wind.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        justin.iurman@gmail.com, nicolas.dichtel@6wind.com,
        stefano.salsano@uniroma2.it, paolo.lungaroni@uniroma2.it,
        ahabdels@cisco.com, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next v3 2/2] selftests: add check for seg6 tunsrc
Message-Id: <20260317115430.cfd3846b20c1e2314d468b5d@uniroma2.it>
In-Reply-To: <20260316162955.1253225-3-justin.iurman@6wind.com>
References: <20260316162955.1253225-1-justin.iurman@6wind.com>
	<20260316162955.1253225-3-justin.iurman@6wind.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,uniroma2.it,cisco.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268556-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,6wind.com:email,srv6_hencap_red_l3vpn_test.sh:url,uniroma2.it:dkim,uniroma2.it:mid]
X-Rspamd-Queue-Id: 7A7EF2A8594
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 17:29:55 +0100
Justin Iurman <justin.iurman@6wind.com> wrote:

> Extend srv6_hencap_red_l3vpn_test.sh to include checks for the new
> "tunsrc" feature.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
> ---
>  .../net/srv6_hencap_red_l3vpn_test.sh         | 65 ++++++++++++++-----
>  1 file changed, 50 insertions(+), 15 deletions(-)
> 

Hi Justin,
 
Thanks for working on this!
I'll focus on a couple of design aspects for now, and we can look at the
details once we settle on those.

>
> [snip]
>  
>  setup_hs()
> @@ -567,41 +601,41 @@ setup()
>  	# the network path between hs-1 and hs-2 traverses several routers
>  	# depending on the direction of traffic.
>  	#
> -	# Direction hs-1 -> hs-2 (H.Encaps.Red)
> +	# Direction hs-1 -> hs-2 (H.Encaps.Red + tunsrc)
>  	#  - rt-3,rt-4 (SRv6 End behaviors)
>  	#  - rt-2 (SRv6 End.DT46 behavior)
>  	#
>  	# Direction hs-2 -> hs-1 (H.Encaps.Red)
>  	#  - rt-1 (SRv6 End.DT46 behavior)
> -	setup_rt_policy_ipv6 2 1 "3 4" 2 encap.red
> -	setup_rt_policy_ipv6 1 2 "" 1 encap.red
> +	setup_rt_policy_ipv6 2 1 "3 4" 2 encap.red true
> +	setup_rt_policy_ipv6 1 2 "" 1 encap.red false
>  
>  	# create an IPv4 VPN between hosts hs-1 and hs-2
>  	# the network path between hs-1 and hs-2 traverses several routers
>  	# depending on the direction of traffic.
>  	#
> -	# Direction hs-1 -> hs-2 (H.Encaps.Red)
> +	# Direction hs-1 -> hs-2 (H.Encaps.Red + tunsrc)
>  	# - rt-2 (SRv6 End.DT46 behavior)
>  	#
>  	# Direction hs-2 -> hs-1 (H.Encaps.Red)
>  	#  - rt-4,rt-3 (SRv6 End behaviors)
>  	#  - rt-1 (SRv6 End.DT46 behavior)
> -	setup_rt_policy_ipv4 2 1 "" 2 encap.red
> -	setup_rt_policy_ipv4 1 2 "4 3" 1 encap.red
> +	setup_rt_policy_ipv4 2 1 "" 2 encap.red true
> +	setup_rt_policy_ipv4 1 2 "4 3" 1 encap.red false
>  
>  	# create an IPv6 VPN between hosts hs-3 and hs-4
>  	# the network path between hs-3 and hs-4 traverses several routers
>  	# depending on the direction of traffic.
>  	#
> -	# Direction hs-3 -> hs-4 (H.Encaps.Red)
> +	# Direction hs-3 -> hs-4 (H.Encaps.Red + tunsrc)
>  	# - rt-2 (SRv6 End Behavior)
>  	# - rt-4 (SRv6 End.DT46 behavior)
>  	#
>  	# Direction hs-4 -> hs-3 (H.Encaps.Red)
>  	#  - rt-1 (SRv6 End behavior)
>  	#  - rt-3 (SRv6 End.DT46 behavior)
> -	setup_rt_policy_ipv6 4 3 "2" 4 encap.red
> -	setup_rt_policy_ipv6 3 4 "1" 3 encap.red
> +	setup_rt_policy_ipv6 4 3 "2" 4 encap.red true
> +	setup_rt_policy_ipv6 3 4 "1" 3 encap.red false
>  
>  	# testing environment was set up successfully
>  	SETUP_ERR=0


The paths marked "true" here were testing the encap.red baseline before
this change. They need to stay exactly as they were originally.
Furthermore, if tunsrc is not supported by the kernel running the test,
the ip route command with tunsrc will fail during setup() (since
set -e is used), and the entire script dies before any test runs.
 
The idea here is to avoid duplicating the entire test suite, while still
providing dedicated test cases for the new per-route tunsrc. A reasonable
approach could be adding the tunsrc checks as new, separate test cases
that run after the baseline ones, leaving the existing paths completely
untouched.
 
For example, a dedicated test_tunsrc() function could take care of the
whole thing for a given path: setting up the tunsrc address, installing
the route with tunsrc, verifying the behavior, cleaning up, and finally
restoring the original route.

>
> [snip]
> @@ -819,6 +853,7 @@ test_command_or_ksft_skip ip
>  test_command_or_ksft_skip ping
>  test_command_or_ksft_skip sysctl
>  test_command_or_ksft_skip grep
> +test_command_or_ksft_skip ip6tables
>

This will skip the entire script if ip6tables is not present, which
takes down the baseline tests too.
I think a probe at startup that checks for both tunsrc support and
ip6tables would work well here. If either is missing, we can
just gracefully skip the new tunsrc tests and let the rest of the script
run as usual.

The bottom line is that the script needs to keep working exactly as
before when tunsrc is not supported or its dependencies are missing.
 
Thanks,
Andrea

