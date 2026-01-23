Return-Path: <netdev+bounces-252919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIAmEUi6c2kmyQAAu9opvQ
	(envelope-from <netdev+bounces-252919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:13:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2149A796D2
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CCD230015BA
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9039D270575;
	Fri, 23 Jan 2026 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt6ZswL7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF6C1E32D6;
	Fri, 23 Jan 2026 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192002; cv=none; b=UDWO4dGfFl07VqAtUyhV1Mr6m0iSejOqj2M0sZktHP8LPGdcbOhDxjhe+mChbajFGTsvCdz8ZOhbNpWCxtt6GHCZfrHNXEz1ETMOobsqOvV8pCr77QpqTa5Km4f0pFwamg1KaZ94rnMXbW/ZQwTJILX6bZ1VHC5rv66t4pVr3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192002; c=relaxed/simple;
	bh=+gkrszEJouEqkSHnS+5c3fmq3T/Xs3A55L3n1IwX7QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lca57E8C+4qGnSxinFcxCp8ziP6u+r0D4+oaXWag9H1FoE/KlNB0XDasuRoupUuwZhzYo5f1J65KXnAQ3Ic+uVRzttEGw3Hyw7G84mwW4biGCfaEwKF0b9aAZCLadCdsR4yOKj+3NOGtY3qABDikDOUr6GCd9g3WpYzh2Owd/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt6ZswL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FFAC4CEF1;
	Fri, 23 Jan 2026 18:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769192002;
	bh=+gkrszEJouEqkSHnS+5c3fmq3T/Xs3A55L3n1IwX7QY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nt6ZswL7RUs+sVW7a68TlRfDV61/3LipvYOULhiuKLK4N9fQKOL83P7VKFz8D/8xi
	 1zd5K5pkcOnQmcT8EdMwdCli8w6FrwRdcwphJ0XMyNFlF1TzfyBeQBRM4o+MhjUOLK
	 bBD0k9uKA2AGtML5dw9NhYPKAx4xv/Ewp/BhAQ+m2o5lYEkjlOLYlDBwvciScNgf9H
	 dk58qMxaPiebT6L7ugn5BeTCmtwE/X1uWtup0UJbidlnwz12aoll/c2meC8uWJEG/r
	 Qq39VFLxv+Hhx6pdnj4Ho9GTwASdsCLvlxF7TQ5NrSpTJIhBHXVBcMyZbEKZkA/N+c
	 fEfZEkQmy7b4w==
Message-ID: <5a86e98f-66c1-4dfb-9e3f-4990bff4bf70@kernel.org>
Date: Fri, 23 Jan 2026 11:13:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next v3] selftests: net: add ipv6 ping to local
 address from localhost
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 haleyb.dev@gmail.com
References: <20260121194409.6749-1-fmancera@suse.de>
 <20260121194409.6749-2-fmancera@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260121194409.6749-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-252919-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email,fcnal-test.sh:url]
X-Rspamd-Queue-Id: 2149A796D2
X-Rspamd-Action: no action

On 1/21/26 12:44 PM, Fernando Fernandez Mancera wrote:
> Test ipv6 pinging to local configured address and linklocal address from
> localhost with -I ::1.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: shellcheck fixes, added VRF based tests and simplified linklocal
> address parsing
> v3: extend existing test in fcnal-test.sh instead of creating a new one,
> notice some shellcheck warnings but I prefer to follow the style of the
> existing code. It can be fixed if it is a requirement.
> ---
>  tools/testing/selftests/net/fcnal-test.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
> index 844a580ae74e..890c3f8e51bb 100755
> --- a/tools/testing/selftests/net/fcnal-test.sh
> +++ b/tools/testing/selftests/net/fcnal-test.sh
> @@ -2327,6 +2327,13 @@ ipv6_ping_novrf()
>  		log_test_addr ${a} $? 2 "ping local, device bind"
>  	done
>  
> +	for a in ${NSA_LO_IP6} ${NSA_LINKIP6}%${NSA_DEV} ${NSA_IP6}
> +	do
> +		log_start
> +		run_cmd ${ping6} -c1 -w1 -I ::1 ${a}
> +		log_test_addr ${a} $? 0 "ping local, from localhost"
> +	done
> +
>  	#
>  	# ip rule blocks address
>  	#

Reviewed-by: David Ahern <dsahern@kernel.org>


