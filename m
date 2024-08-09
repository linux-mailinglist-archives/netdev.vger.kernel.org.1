Return-Path: <netdev+bounces-117235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEAC94D351
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686701F223F6
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B65B1990DA;
	Fri,  9 Aug 2024 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="qJznsSdi"
X-Original-To: netdev@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8691990D1
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216896; cv=none; b=b+uQowqQZETYQgr4pEUqaNyIkgDUy9HG4jNVQVpYt4MiJ3Y9WFDdXswBMJLrPRnjs0WikvlOxOttBMTAMvQUJxpOo/fOca5lxEOep5vNBOr0FwW34y27Ll1Kws5gT3voKG231eBLfvXMoKdA8JEMmW2mlFZNggqpjDk6IJQyg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216896; c=relaxed/simple;
	bh=YF2j1+300pl2tJxsYrUBAqHlJ5+NsKgS1Kx7u3KmH5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0BH2XlXueIL7l61hPQLnhCKr+XAg0uRB7nInzlCUlN6fqyF9GDLG/8YWrByRVNM9qNtTo2ADjZZSybz7Sz3LlsMxHl1dBDUEJkPJyYSNFqAgUxiLz73s4mowMZX22Gz8cYE4RSPFxLfOcQV9WwxjNzRrYoIcbc0MSGNk16t1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=qJznsSdi; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id cIfUs2oGUjnP5cRQmstBB5; Fri, 09 Aug 2024 15:21:28 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id cRQlsHGvjAJzkcRQlsMYSx; Fri, 09 Aug 2024 15:21:27 +0000
X-Authority-Analysis: v=2.4 cv=RvnDLjmK c=1 sm=1 tr=0 ts=66b633f7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=T-l7Lcn7wvsJkd90kOwA:9
 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ahVHeUMbhgnB+4j25dq8VaYi1sZLU1wW+FemcJlE7HA=; b=qJznsSdiEPtuO2wrUGnlBQKaGZ
	yk58PbqpzGYOPOD62nYNFmqLHJohRgT9AdyvnzFTD+XsyxvR0adWHccEXXLdOLJVjb81UXG3qXHAL
	mxnGSOiNVZTVdve7q/fCKEPhFA5cUkoQALBXkjSpIx0dF322hdy+pywWD2m7bv+tIGNx348LnV3Y6
	oM6qbYHM64w33S2wwl3hMWJcZZ2jfsQinBAdGLjDABBLkPqUlvS8IALblA1b5aWRMMJOdbjz4vVvk
	g4hrDEJZ1+rZ7+t4ZKjOTe6UR+Yzij+kasVhBgUQYb9kZ6QlOqrWgAV88jB+r/COqmpKbS/QvfuxH
	eXyu14vg==;
Received: from [201.172.173.139] (port=54138 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1scRQk-002rcf-2B;
	Fri, 09 Aug 2024 10:21:26 -0500
Message-ID: <cc27ae84-e759-480b-a1ff-2fac4494307b@embeddedor.com>
Date: Fri, 9 Aug 2024 09:21:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] sched: act_ct: avoid -Wflex-array-member-not-at-end
 warning
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZrDxUhm5bqCKU9a9@cute> <20240808194655.6bd39d2e@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240808194655.6bd39d2e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1scRQk-002rcf-2B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:54138
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHWTOupVaMwlz8XMAolBfVP1UnfFitLJSHhVFATpfV/a+6gDkXm7i/iTtfoInRbWUjHUEGxtLmtWHNs4JvSBTBT9pPOCamU5LoDJKePCyzqZda/QeKCn
 Sqyw6s355/FPfefeqUjFhNUzPVxvIpv7FUGSD4HmyVMBln/D+Lfo2MJfu6VDhb5TZimaykFJWYkq92/cMbUNUBwnbQ//ASZtLP0=



On 08/08/24 20:46, Jakub Kicinski wrote:
> On Mon, 5 Aug 2024 09:35:46 -0600 Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declaration to the end of the structure. Notice
>> that `struct zones_ht_key` is a flexible structure --a structure that
>> contains a flexible-array member.
> 
> I think the flex member is there purely to mark the end of the struct.
> You can use offsetofend(zone) instead of offsetof(pad), and delete pad.

Nice! I'll send v2, shortly.

Thanks
--
Gustavo

