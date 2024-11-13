Return-Path: <netdev+bounces-144260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5279C6676
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A221B283CB8
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 01:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56BC134A8;
	Wed, 13 Nov 2024 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="f/TOpQhj"
X-Original-To: netdev@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031F2AD24
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460127; cv=none; b=OAyjEGhzBNZ5Vj/owI0mD6JyoBLENluXQQCI50WoDITZXZ70/vVFj07tdsjXkHGWlfnS+cWTNoIzBxCyPQTjiVsVZbovHiKlsGOS+1fa0kGiSCgeYQ2A1OocJHHfY3uJuDx3bjrRWAsa3QmaWI4/5Yy7smMWZVcucQsCiJ9++H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460127; c=relaxed/simple;
	bh=e2q7MxvGZdJLXiB+3IUNQaYHOzFNtf7lsxszy3S4Ws8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T7LhskpnnV+foH3L03reK4gK6d/FeHQO7yoqW1ZsgzjqlzChDbVMXENLv+fj/fZxSDdlYCuoOOEDHgm6LVNaOzkcXNaumGeWeze0ZYtYYQZ+6PgVcjySqPEaxBZXAVcK87T6AVIozrIIAiD12Nl4Mq2g7CHbmYaujhkAktZSt/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=f/TOpQhj; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id AX9FtYLZkumtXB1sDtz8J1; Wed, 13 Nov 2024 01:08:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id B1sCtzQjxWvXpB1sCtj49L; Wed, 13 Nov 2024 01:08:45 +0000
X-Authority-Analysis: v=2.4 cv=LtdZyWdc c=1 sm=1 tr=0 ts=6733fc1d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7T7KSl7uo7wA:10 a=PeOOapuUAAAA:8
 a=kARa8BiYBvYMqBh4rAwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=0BaqRfgCL6CLbWgV2pdm:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xXm4z4ddRPqAvfWilgUzgfk96JDKPImd8ktkXzI6+Vc=; b=f/TOpQhjLuaU3hSN5yDIeaKMpl
	cDuIe/wGcz12a504x2D6ZOzfEhLAy3X1pLfj9r6OeY+hSCifmjjS27v0Ikm6FE9l9AmYa4B7EY2qx
	zP6frS8aKVbUVWaBHe4j7qGjtVrOMQ7RAdvKVLi2quaBaiX9vT9Me50idZxQC+AVAkHAmP4As5Eh3
	kSdAYEWUTxcfopBtv+cRF47j+lXIu7XCDJcJHDVJpg4ULx69CEvnfP933k2NMeLUJxXrhkmNS1AF7
	7ufkegwwVBqtzHpn+NvpD4Tr2/CQlviU+YLvqzhO9PD6BWP258d1JEaju1eTwNtb+ozWtMBME5NXU
	25uBJi3w==;
Received: from [177.238.21.80] (port=51906 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tB1sA-002vYr-0q;
	Tue, 12 Nov 2024 19:08:42 -0600
Message-ID: <55d62419-3a0c-4f26-a260-06cf2dc44ec1@embeddedor.com>
Date: Tue, 12 Nov 2024 19:08:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2][next] UAPI: ethtool: Use __struct_group() in
 struct ethtool_link_settings
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <cover.1730238285.git.gustavoars@kernel.org>
 <9e9fb0bd72e5ba1e916acbb4995b1e358b86a689.1730238285.git.gustavoars@kernel.org>
 <20241109100213.262a2fa0@kernel.org>
 <d4f0830f-d384-487a-8442-ca0c603d502b@embeddedor.com>
Content-Language: en-US
In-Reply-To: <d4f0830f-d384-487a-8442-ca0c603d502b@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tB1sA-002vYr-0q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:51906
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD2xrLzuGd8l4F0uYoPRgRxFZFGG0a9/OGWcslAyNoO5a0IHaDifiHQuui07Ys7ze4IYSRtjiOsqXYxTHzP1dT3Y+rw1snB0NQoPIl6877Eu3OcNmLMA
 GevJ/t8tJv6CysF53eblbsC14McbOF8+A8+Ahr4Jn5Ju81J0HsOSPdnZzVLHHZuwBNLlcoJlLeC6AtvdKybOAwHC7PK60I5M4jQ=



On 11/11/24 16:22, Gustavo A. R. Silva wrote:
> 
> 
> On 09/11/24 12:02, Jakub Kicinski wrote:
>> On Tue, 29 Oct 2024 15:55:35 -0600 Gustavo A. R. Silva wrote:
>>> Use the `__struct_group()` helper to create a new tagged
>>> `struct ethtool_link_settings_hdr`. This structure groups together
>>> all the members of the flexible `struct ethtool_link_settings`
>>> except the flexible array. As a result, the array is effectively
>>> separated from the rest of the members without modifying the memory
>>> layout of the flexible structure.
>>>
>>> This new tagged struct will be used to fix problematic declarations
>>> of middle-flex-arrays in composite structs[1].
>>
>> Possibly a very noob question, but I'm updating a C++ library with
>> new headers and I think this makes it no longer compile.
>>
>> $ cat > /tmp/t.cpp<<EOF
>> extern "C" {
>> #include "include/uapi/linux/ethtool.h"
>> }
>> int func() { return 0; }
>> EOF
>>
>> $ g++ /tmp/t.cpp -I../linux -o /dev/null -c -W -Wall -O2
>> In file included from /usr/include/linux/posix_types.h:5,
>>                   from /usr/include/linux/types.h:9,
>>                   from ../linux/include/uapi/linux/ethtool.h:18,
>>                   from /tmp/t.cpp:2:
>> ../linux/include/uapi/linux/ethtool.h:2515:24: error: ‘struct ethtool_link_settings::<unnamed union>::ethtool_link_settings_hdr’ invalid; an anonymous union 
>> may only have public non-static data members [-fpermissive]
>>   2515 |         __struct_group(ethtool_link_settings_hdr, hdr, /* no attrs */,
>>        |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
>>
>>

This seems to work with Clang:

$ clang++-18 -fms-extensions /tmp/t.cpp -I../linux -o /dev/null -c -W -Wall -O2

However, `-fms-extensions` doesn't seem to work for this case with GCC:

https://godbolt.org/z/1shsPhz3s


-Gustavo


>> I don't know much about C++, tho, so quite possibly missing something
>> obvious.
> 
> We are in the same situation here.
> 
> It seems C++ considers it ambiguous to define a struct with a tag such
> as `struct TAG { MEMBERS } ATTRS NAME;` within an anonymous union.
> 
> Let me look into this further...
> -- 
> Gustavo
> 


