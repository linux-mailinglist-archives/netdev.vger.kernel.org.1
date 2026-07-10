Return-Path: <netdev+bounces-306560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N2EfEBD0UGoD9AIAu9opvQ
	(envelope-from <netdev+bounces-306560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:30:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A10A73B444
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:30:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=common-net.org header.s=mail header.b=gm2zxTpu;
	dmarc=pass (policy=reject) header.from=common-net.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306560-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306560-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51F8B300F9C6
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9036233722;
	Fri, 10 Jul 2026 13:30:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.common-net.org (mail.common-net.org [139.28.148.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333543B2AA;
	Fri, 10 Jul 2026 13:30:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690217; cv=none; b=f7K7Tuoz4modm1bgutvJM68t5eXtzGc6ku+I9G+Vc4PptAspzMj/DGtSH4UNFmoSKKw3H4oMCRQ7ozUxDWlxoZKXmOoxfgbXqb0rhGU9RXdb0gHz+/BBdMn3KSdpbR4zDCN5Tf4yPCGIV1Yw9BEGvblS2up9fBCUt9Qdi1PRQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690217; c=relaxed/simple;
	bh=37DVLOJ0C/nXxDG2gLv61Y0uJu2i22i2h5bi7umeXyU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GFGg2X6yCa0zVhcE+hJeiw3NHWiF9xxCoR2oYUFaLVYn8Oaf1wVxEDhM2GJ1GXkKjb1E/8xoiU93DUUsKLK4mNOuf/jEjj4216vkAOoXUpgWwnHWgdjtNm1uiZ7tsR6lTAvCV7ccQfTp+920CQOj7L/dr63o/q+MtmvrLT3vjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=common-net.org; spf=pass smtp.mailfrom=common-net.org; dkim=pass (1024-bit key) header.d=common-net.org header.i=@common-net.org header.b=gm2zxTpu; arc=none smtp.client-ip=139.28.148.254
Received: from lubuntu-18.04 (host-82-61-152-174.retail.telecomitalia.it [82.61.152.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.common-net.org (Postfix) with ESMTPSA id 867BE6D20028;
	Fri, 10 Jul 2026 15:22:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=common-net.org;
	s=mail; t=1783689731;
	bh=37DVLOJ0C/nXxDG2gLv61Y0uJu2i22i2h5bi7umeXyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gm2zxTpumybA5osNk06kwG/gShIjRPbJJII6j1nv05DGcMhU3EDPyCmZfqSU0JUaS
	 sdbhV+EJUVX+GT0UMF287GMDwjlwa1BQlthhDKigp72RS27xPesgoe9d2/K6cHTVte
	 mfxacV42SWEcP1PmoDCFIpmbuluTlWn/cFm4r0WU=
Date: Fri, 10 Jul 2026 15:22:11 +0200
From: Andrea Mayer <andrea@common-net.org>
To: Alessio Faina <alessio.faina@canonical.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Po-Hsu Lin
 <po-hsu.lin@canonical.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, stefano.salsano@uniroma2.it, Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next] selftests/net: Skip
 srv6_end_dt46_l3vpn_test::host_vpn_tests if iproute2 too old
Message-Id: <20260710152211.63eb25d604ea0aa2b3707d68@common-net.org>
In-Reply-To: <20260708152745.2430714-1-alessio.faina@canonical.com>
References: <20260708152745.2430714-1-alessio.faina@canonical.com>
Organization: Common Net
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[common-net.org,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[common-net.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306560-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alessio.faina@canonical.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:po-hsu.lin@canonical.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:stefano.salsano@uniroma2.it,m:andrea.mayer@uniroma2.it,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[andrea@common-net.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[common-net.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea@common-net.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,srv6_end_dt46_l3vpn_test.sh:url,canonical.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A10A73B444

On Wed,  8 Jul 2026 17:27:45 +0200
Alessio Faina <alessio.faina@canonical.com> wrote:

> In case iproute2 is older than version 5.14.0, released ~Sept 1, 2021,
> the End.DT46 support is not available and the host_vpn_tests test contained
> in the srv6_end_dt46_l3vpn_test.sh file is failing in some kernel backports.
> This is the result of those tests:
> 
> ################################################################################
> TEST SECTION: SRv6 VPN connectivity test among hosts in the same tenant
> ################################################################################
> 
>     TEST: IPv6 Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)  [ FAIL ]
> 
>     TEST: IPv4 Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)  [ FAIL ]
> 
>     TEST: IPv6 Hosts connectivity: hs-t100-2 -> hs-t100-1 (tenant 100)  [ FAIL ]
> 
>     TEST: IPv4 Hosts connectivity: hs-t100-2 -> hs-t100-1 (tenant 100)  [ FAIL ]
> 
>     TEST: IPv6 Hosts connectivity: hs-t200-3 -> hs-t200-4 (tenant 200)  [ FAIL ]
> 
>     TEST: IPv4 Hosts connectivity: hs-t200-3 -> hs-t200-4 (tenant 200)  [ FAIL ]
> 
>     TEST: IPv6 Hosts connectivity: hs-t200-4 -> hs-t200-3 (tenant 200)  [ FAIL ]
> 
>     TEST: IPv4 Hosts connectivity: hs-t200-4 -> hs-t200-3 (tenant 200)  [ FAIL ]
> 
> To amend this, check the current running iproute2 supports the required
> feature and, if not, just skip the test to avoid a failure.
> 
> 
> Signed-off-by: Alessio Faina <alessio.faina@canonical.com>
> ---
>  .../selftests/net/srv6_end_dt46_l3vpn_test.sh       | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> index a5e959a080bb..406c6a3d253e 100755
> --- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> +++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> @@ -510,12 +510,15 @@ host2gateway_tests()
>  host_vpn_tests()
>  {
>  	log_section "SRv6 VPN connectivity test among hosts in the same tenant"
> +	if ip route add help 2>&1 | grep -q -i End.DT46; then
> +		check_and_log_hs_connectivity 1 2 100
> +		check_and_log_hs_connectivity 2 1 100
>  
> -	check_and_log_hs_connectivity 1 2 100
> -	check_and_log_hs_connectivity 2 1 100
> -
> -	check_and_log_hs_connectivity 3 4 200
> -	check_and_log_hs_connectivity 4 3 200
> +		check_and_log_hs_connectivity 3 4 200
> +		check_and_log_hs_connectivity 4 3 200
> +	else
> +		echo "SKIP: SRv6 End.DT46 is unsupported by the installed iproute2 version"
> +	fi
>  }

Hi Alessio,

Rather than inlining the check inside host_vpn_tests(), I think it would be
better to follow the pattern already used in srv6_hencap_red_l3vpn_test.sh,
where test_iproute2_supp_or_ksft_skip() is called before setup(). A similar
function here could exit the whole script with $ksft_skip if End.DT46 is not
supported by the installed iproute2.

Thanks,

Ciao
Andrea

