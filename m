Return-Path: <netdev+bounces-276650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDiSHfeG1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:48:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C801A3BF131
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 254DF3085D87
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E4C3D1CD1;
	Wed,  8 Apr 2026 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi6Y+dCZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446DD3BAD8F;
	Wed,  8 Apr 2026 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666622; cv=none; b=CRx4uIdebpY06TX12TdTS7TsJw/WWbCsOcM/Vj0rbB44CMg9J/JUsKf8pwwauPF+nGUIkEJjYz/L8VdQDq5qcBKR6caPSd4vk4Q4xP/HP13ZO7a6GCO4ERKsJdCHG+QW1P3Je8nG4BLFJ/Z/QVltv3ev1iOJak0UUBOh0DemGwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666622; c=relaxed/simple;
	bh=eNSN/V9iAtKNk8c2W5CzcVUiXUpEq+bFtvJet1Q0okg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ga0W1lRe6Il6d9BlkjxElIJFvx9Y7ASjMEIKg9J7dRdOjYMNVGfU8BrvkYc8oYQiusYcqnKLD7RqkASQfOnZVrZhupclIWmzrTr7aJlgOfAg4C1cb8poJhlIs8hvFFFAPL8c0OTaGPhRO6khmnKqsh3ArAxIwCoGfX6yqB2YV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi6Y+dCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9739C2BC87;
	Wed,  8 Apr 2026 16:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775666621;
	bh=eNSN/V9iAtKNk8c2W5CzcVUiXUpEq+bFtvJet1Q0okg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fi6Y+dCZw7beSP7hoLO4/f+j/kmY2B4HKmpTOIl1qVd4Yo4Unft05aUKJ8RZCIp3X
	 TUcgAb7xY9k1kHb6BdsLemkvVAUgFWhTFl1NWNq43Gmot65D8TCAlJNX8f3V5+RDWQ
	 vdGwODiPd0ZVHZTvDKdyJeGUntz1d9MzNqwb8lfsigtyODnJ8Z28f6tDkpBsf5ZXlF
	 7KBz72qbQs7VGhqheouTTo0xL3MD61EPDCJlNZq2hAxglULRUhhWRnBTcaktmj+hri
	 rQCovgqsoZuPtPRHZ1E6Y0yBVF/H9Ke68tflwCP2F4XVXNZ/wOaxTAbe70G8Vqdrxp
	 zSrWtriiEh5Dg==
Message-ID: <8d216893-1e0b-4e3c-8609-eb3de5da02cf@kernel.org>
Date: Wed, 8 Apr 2026 18:43:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: linux-next: manual merge of the net-next tree with the netfilter
 tree
Content-Language: fr
To: Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Networking <netdev@vger.kernel.org>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
 Justin Iurman <justin.iurman@6wind.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <adZhwtOYfo-0ImSa@sirena.org.uk>
 <729b748b-e00b-475e-81e0-a666eab24fc6@sirena.org.uk>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <729b748b-e00b-475e-81e0-a666eab24fc6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276650-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C801A3BF131
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On 08/04/2026 17:08, Mark Brown wrote:
> On Wed, Apr 08, 2026 at 03:10:10PM +0100, Mark Brown wrote:
>> Hi all,
>>
>> Today's linux-next merge of the net-next tree got a conflict in:
>>
>>   net/ipv6/seg6_iptunnel.c
>>
>> between commit:
>>
>>   c3812651b522f ("seg6: separate dst_cache for input and output paths in seg6 lwtunnel")
>>
>> from the netfilter tree and commit:
>>
>>   78723a62b969a ("seg6: add per-route tunnel source address")
>>
>> from the net-next tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.

Thank you for having fixed the conflict on linux-next!

>> diff --cc net/ipv6/seg6_iptunnel.c
>> index d6a0f7df90807,e76cc0cc481ec..0000000000000
>> --- a/net/ipv6/seg6_iptunnel.c
>> +++ b/net/ipv6/seg6_iptunnel.c
>> @@@ -48,8 -48,8 +48,9 @@@ static size_t seg6_lwt_headroom(struct 
>>   }
>>   
>>   struct seg6_lwt {
>>  -	struct dst_cache cache;
>>  +	struct dst_cache cache_input;
>>  +	struct dst_cache cache_output;
>> + 	struct in6_addr tunsrc;
>>   	struct seg6_iptunnel_encap tuninfo[];
>>   };
>>   
> 
> This also needs a fixup for a new jump to the error handling paths that
> was added in seg6_build_state().

I also had this other conflict there, and I did this when resolving it
in MPTCP tree:

--------------------- 8< ---------------------
diff --cc net/ipv6/seg6_iptunnel.c
index e76cc0cc481e,d6a0f7df9080..97b50d9b1365
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@@ -48,8 -48,8 +48,9 @@@ static size_t seg6_lwt_headroom(struct 
  }
  
  struct seg6_lwt {
- 	struct dst_cache cache;
+ 	struct dst_cache cache_input;
+ 	struct dst_cache cache_output;
 +	struct in6_addr tunsrc;
  	struct seg6_iptunnel_encap tuninfo[];
  };
  
@@@ -726,18 -712,6 +731,18 @@@ static int seg6_build_state(struct net 
  
  	memcpy(&slwt->tuninfo, tuninfo, tuninfo_len);
  
 +	if (tb[SEG6_IPTUNNEL_SRC]) {
 +		slwt->tunsrc = nla_get_in6_addr(tb[SEG6_IPTUNNEL_SRC]);
 +
 +		if (ipv6_addr_any(&slwt->tunsrc) ||
 +		    ipv6_addr_is_multicast(&slwt->tunsrc) ||
 +		    ipv6_addr_loopback(&slwt->tunsrc)) {
 +			NL_SET_ERR_MSG(extack, "invalid tunsrc address");
 +			err = -EINVAL;
- 			goto free_dst_cache;
++			goto err_destroy_output;
 +		}
 +	}
 +
  	newts->type = LWTUNNEL_ENCAP_SEG6;
  	newts->flags |= LWTUNNEL_STATE_INPUT_REDIRECT;
  
@@@ -750,9 -724,9 +755,11 @@@
  
  	return 0;
  
- free_dst_cache:
- 	dst_cache_destroy(&slwt->cache);
- free_lwt_state:
++err_destroy_output:
++	dst_cache_destroy(&slwt->cache_output);
+ err_destroy_input:
+ 	dst_cache_destroy(&slwt->cache_input);
+ err_free_newts:
  	kfree(newts);
  	return err;
  }
--------------------- 8< ---------------------

I took the liberty to add the err_destroy_output label, similar to the
new err_destroy_input one.

Just in case, rerere cache file is available there:

 https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/dbb6675

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


