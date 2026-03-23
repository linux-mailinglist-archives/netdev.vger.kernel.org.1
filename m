Return-Path: <netdev+bounces-270352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOTnNmOzwGm5KAQAu9opvQ
	(envelope-from <netdev+bounces-270352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 04:28:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B4D2EC356
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 04:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F20B43006B25
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 03:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3472228A72F;
	Mon, 23 Mar 2026 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="x9eUR1eN";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="ZPFkn2fZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3465514A8B;
	Mon, 23 Mar 2026 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774236513; cv=none; b=Nb90GU5D+r4H+agjjd8tkL9MiFX7hBon0ICV4JP2/BmVhNNBnb476zH07gNhDzUaN1knIvOriwd2/nFtwe6K6RrmXjTrIIvP+f6TAoRhKxSuqnDN2fwLCVczDIbnP2VJbp2OckySmMnBWrJUOlu3+oGnIIhCowIFlV3MfIUOxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774236513; c=relaxed/simple;
	bh=Sn6pgn/s2mMkX7BiFMErMdr5jHdl+ItW30IpGkIo06Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Jg7T0LDZAdU2/l56elrkEwuJKHosS4kkZNlUGoz3NBfXDwxQ/iAIfbKs/ZUSC24NygMUU1QQgYKk3ZemywAvs6pNyp5xOzP9zBFkcJnUddReeOqbvZvOnkG76s51RmZ35tzg8u/WWCBTd8o0+s56AD+s+K1J+zxws3NEOxuaduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=x9eUR1eN; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=ZPFkn2fZ; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62N3Rmbd017285;
	Mon, 23 Mar 2026 04:27:53 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id E69F3120844;
	Mon, 23 Mar 2026 04:27:42 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1774236463; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDA4Zszh+SLz2dylLYODjcbCOuO0Q/OgtLgx6KJVhAw=;
	b=x9eUR1eNQnPGRe7+LjWrgOCpFzJZYdf3E1vsW34ROCjI8QxEAjJdnwkKVYBXxog94Aajtr
	YxujGB8jxgVbyQDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1774236463; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDA4Zszh+SLz2dylLYODjcbCOuO0Q/OgtLgx6KJVhAw=;
	b=ZPFkn2fZo0yMAxqJ8YI7oVK/lhMMDaN8D/dpgyQoCLpAjEwtONo2RrLFD2oA1IgN3gnZ+w
	omtzQbWNBStb98aQ5SdnYHkAGxGj0kFNhQb7PD3tXkfxQgGjZ9eBO3LKUr03zvaaOR5quw
	BHWAjucYV/0QC1GBhfykVsZvXLPbViOVXtKkrlqubHYD9eUIBf+G7eeeTEZJ8IIQSZJnVq
	56YHhW0wT50KB6Anegduq+CHWCMV6haI9YNdV7i5ecIilOmlaq3XgaBPDF42k5z3LUZG9P
	icIPhx6P07VyidgPNKtJGQ4yEuix6vk3Ru19vq0ZuSZD4av8qW4dlH8BeOsAOg==
Date: Mon, 23 Mar 2026 04:27:42 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Justin Iurman <justin.iurman@6wind.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        justin.iurman@gmail.com, nicolas.dichtel@6wind.com,
        stefano.salsano@uniroma2.it, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next v4 2/2] selftests: add check for seg6 tunsrc
Message-Id: <20260323042742.1097eb845dba645864e3f84c@uniroma2.it>
In-Reply-To: <20260320135909.1729313-3-justin.iurman@6wind.com>
References: <20260320135909.1729313-1-justin.iurman@6wind.com>
	<20260320135909.1729313-3-justin.iurman@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,uniroma2.it];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270352-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6wind.com:email,encap.red:url]
X-Rspamd-Queue-Id: 46B4D2EC356
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 14:59:09 +0100
Justin Iurman <justin.iurman@6wind.com> wrote:

> Extend srv6_hencap_red_l3vpn_test.sh to include checks for the new
> "tunsrc" feature. If there is no support for tunsrc, it silently
> falls back to the encap config without tunsrc.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
> ---
>  .../net/srv6_hencap_red_l3vpn_test.sh         | 95 ++++++++++++++++---
>  1 file changed, 82 insertions(+), 13 deletions(-)
> 

Hi Justin,

Thanks for the v4. Good job on the fallback logic.

However, while reviewing and testing this v4 on a mixed setup (older 
kernel, newer iproute2), I noticed a specific case that slips through, 
unfortunately causing the baseline SRv6 tunnel tests to fail.

Kernels that do not support tunsrc simply ignore the SEG6_IPTUNNEL_SRC 
attribute. If iproute2 sends it, the kernel installs the route without 
the tunsrc and returns 0 (success). As a result, check_tunsrc_support() 
ends up setting HAS_TUNSRC=true and installs DROP rules that block the 
baseline SRv6 traffic (please see below).


> diff --git a/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh b/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh
> index 6a68c7eff1dc..a6e32279a1f7 100755
> --- a/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh
> +++ b/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh
> @@ -193,6 +193,8 @@ ret=${ksft_skip}
>  nsuccess=0
>  nfail=0
>  
> +HAS_TUNSRC=false
> +
>
> [snip]
>  
> +# Before enabling tunsrc tests, make sure tunsrc and ip6tables are supported.
> +check_tunsrc_support()
> +{
> +	setup_ns tunsrc_ns
> +
> +	ip -netns "${tunsrc_ns}" link add veth0 type veth \
> +		peer name veth1 netns "${tunsrc_ns}"
> +
> +	ip -netns "${tunsrc_ns}" link set veth0 up
> +
> +	if ! ip -netns "${tunsrc_ns}" -6 route add fc00::dead:beef/128 \
> +			encap seg6 mode encap.red tunsrc fc00::1 segs fc00::2 \
> +			dev veth0 &>/dev/null; then
> +		cleanup_ns "${tunsrc_ns}"
> +		return
> +	fi
> +

The easiest thing that comes to mind to solve this case is something 
like this (just an idea, feel free to adapt it, so we can be sure 
tunsrc was actually set):

	if ! ip -netns "${tunsrc_ns}" -6 route show | grep -q "tunsrc"; then
		cleanup_ns "${tunsrc_ns}"
		return
	fi


> +	if ! ip netns exec "${tunsrc_ns}" ip6tables -t raw -A PREROUTING \
> +			-d fc00::dead:beef -j DROP &>/dev/null; then
> +		cleanup_ns "${tunsrc_ns}"
> +		return
> +	fi
> +
> +	cleanup_ns "${tunsrc_ns}"
> +	HAS_TUNSRC=true
> +}
> +
> [snip]
> 


To close the loop, it makes sense to send a v5 to fully implement the 
fallback policy. 

There are also a couple of non-blocking nits you might want to consider 
for the v5 (they seem harmless anyway):

1) When $HAS_TUNSRC is false, adding the ::dead: addresses to the 
   interfaces could be avoided;
2) There are duplicate DROP rules when __setup_rt_policy() is called 
   multiple times for the same router.


We are almost there. Thanks for your work on this!

Ciao,
Andrea

