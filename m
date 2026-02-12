Return-Path: <netdev+bounces-258399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOfNMgcrjWl8zgAAu9opvQ
	(envelope-from <netdev+bounces-258399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 02:21:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E796128F2F
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 02:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 705B8300D155
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 01:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264871F12E0;
	Thu, 12 Feb 2026 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="B81WG3z6"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA15919B5A7;
	Thu, 12 Feb 2026 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770859242; cv=none; b=PB++GNdfXJaTdbZjdObhh0uzOFnz3T4jNNA6pEqCFtPlGuIN5qxLlUWWLUHV0Kp03xFkArSCuQFDgcUMj0VEB6I6Lo4bUVQdHaXds84v0z5x0tHO3PFPB55U018ugAjQmGc/W5QNJuHDp2Vu6PHSryMCjQT374+3Go5iXyydis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770859242; c=relaxed/simple;
	bh=6rqLxMkniNBazqn99BelJAYnwzNF0Wuf1Mb7ntcTVtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qkXB4qFesGN4RTTQ5oHGwF1t2939cS94PqRDOfXG7zZe4NDY/YwMlbciq9OSaITtIm3F9qE7d7zmmwv8b2zaHw70V2Kg4tphwJXnynIqQ90DWyBX5/+tpsCGBzsCwRm99rXpxoh0V8qoqJy7fg6WX/PSDoHZs2S2slLomk2K9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=B81WG3z6; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=blwWghHyZP7KBJITugnpbrb/9shthLQW5Bm6sJwJnv4=;
	b=B81WG3z6bjv8h6pPHYZcNO+8PJJqQWV69xT0SJdO3XTwT0WN5W0f9LlnqsfXwoNdvDFRvaUT6
	aBM0q8ErOwKQaVlgi2K5gSTWB5g0QH7D4LQBLsPGb3aYhaRYJqDRgi96cAOAtJu+KXBdDnKI0Z/
	eG58ljeSYWW/TDm83pl0ZcQ=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fBHRz0FMgzRhRT;
	Thu, 12 Feb 2026 09:15:59 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AA7440569;
	Thu, 12 Feb 2026 09:20:37 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Feb 2026 09:20:36 +0800
Message-ID: <34e17499-e385-4017-801c-332c9c40d484@huawei.com>
Date: Thu, 12 Feb 2026 09:20:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: lib: Fix jq parsing error
To: Petr Machata <petrm@nvidia.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <shuah@kernel.org>,
	<razor@blackwall.org>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260211022146.190948-1-yuehaibing@huawei.com>
 <87qzqr5ktl.fsf@nvidia.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <87qzqr5ktl.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,huawei.com:email];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuehaibing@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-258399-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+]
X-Rspamd-Queue-Id: 5E796128F2F
X-Rspamd-Action: no action

On 2026/2/12 0:01, Petr Machata wrote:
> 
> Yue Haibing <yuehaibing@huawei.com> writes:
> 
>> The testcase failed as below:
>> $./vlan_bridge_binding.sh
>> ...
>> + adf_ip_link_set_up d1
>> + local name=d1
>> + shift
>> + ip_link_is_up d1
>> + ip_link_has_flag d1 UP
>> + local name=d1
>> + shift
>> + local flag=UP
>> + shift
>> ++ ip -j link show d1
>> ++ jq --arg flag UP 'any(.[].flags.[]; . == $flag)'
>> jq: error: syntax error, unexpected '[', expecting FORMAT or QQSTRING_START
>>  (Unix shell quoting issues?) at <top-level>, line 1:
>> any(.[].flags.[]; . == $flag)
>> jq: 1 compile error
>>
>> Remove the extra dot (.) after flags array to fix this.
>>
>> Fixes: 4baa1d3a5080 ("selftests: net: lib: Add ip_link_has_flag()")
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> Interesting, both work for me on 1.7.1. What jq version do you use?

I run this on Ubuntu 23.04,
jq - commandline JSON processor [version 1.6]
> 
> Nevertheless, I believe the fix is correct.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> 
>> ---
>>  tools/testing/selftests/net/lib.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
>> index 0ec131b339bc..b40694573f4c 100644
>> --- a/tools/testing/selftests/net/lib.sh
>> +++ b/tools/testing/selftests/net/lib.sh
>> @@ -577,7 +577,7 @@ ip_link_has_flag()
>>  	local flag=$1; shift
>>  
>>  	local state=$(ip -j link show "$name" |
>> -		      jq --arg flag "$flag" 'any(.[].flags.[]; . == $flag)')
>> +		      jq --arg flag "$flag" 'any(.[].flags[]; . == $flag)')
>>  	[[ $state == true ]]
>>  }
> 

