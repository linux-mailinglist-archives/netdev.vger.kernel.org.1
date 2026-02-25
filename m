Return-Path: <netdev+bounces-260864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCu8Dh/Lnmm0XQQAu9opvQ
	(envelope-from <netdev+bounces-260864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:12:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2CD19591B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71556301CCC2
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63AB38F94C;
	Wed, 25 Feb 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="P16e9arX"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093836AB6E
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014131; cv=pass; b=iJnlLrkL773grSCu1t/Rlf0icsNosSUEYzTGEd43EvIgFAJUUIFSkIFlRAyYp3wySLtySFWT9LwUSRyOKnphjv1YlPlRHNNdQlkmpOrZ/l6cEhe30vw6yOPMK7NkS+j0EBjziLSK+3dJfShKZJjhBw6MbqgRAp9EsL9KXTyrU+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014131; c=relaxed/simple;
	bh=5Llf5RGVS2PiWoAHFoZm534nyJ1n16ycopcrG1faZG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aoff1rQEJtkLsXh6hzEIidGW0lhcglz+K/u61eOj0QeZPILC8HEDDPE0yu+exDRwvzor0JCQTnPWAACA6uEHZvhAQDfAViMjz+IyyBtlgRTwvsGGceVCkI36Z4ftN6rG7G2x9lPnyA3malGavvuCukStOObLff0H3LgVeAbaPzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=P16e9arX; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1772014117; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kmbKwntLDyFMMeW508Xh3TWkv3u/RIylZdNADPPzFHAHr6xO8I5tBQ1tLsc2IIOamVT9pS5zTNzmZ39W6mx69RS+AT7DR83iE99nlpD9bbQ8HwD8xACJzOnffkV5ao5IDoWFU4WjOv94/qv/Og2A2MyDbegoqs3Ur7QVopQzYdo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772014117; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CIIwU/d6neXz6Y/1lzLpEUmJXgdo+J8pyN5mwzubunI=; 
	b=hJMm1+GbY5NaYpYoNuAVi3fQrYzr2jG62hwdjoQmyR/7jERyDz8lN79tREusRxSpSYEXCBBBHVfajMaiIybCi8NgUF/AoR+8avrhBk0CJOSzA9xzWT7HgZ85S+U2vXbl7nb4C4bYihgOgX0JOgM+GkHjZI36ehgofTbm8f7cFYc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772014117;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CIIwU/d6neXz6Y/1lzLpEUmJXgdo+J8pyN5mwzubunI=;
	b=P16e9arX4NrBc8h9kX372dD9MqiJjKwXLMXjscYcHO2KwosU3BNFncu+NRU+znur
	F2cn0tYl/9N/TugzratK8lVx2LanBlDKDcLMFQYxIGj/ARAXDEekXK/6eZ28CpSWl3p
	KrmKHtUpg35Nz/kdA/9A9x3tf/4sBC9fKesWRjFUx7b2S0qRadFf07j+TZ0MISlFn+d
	r7xFMpaErS6Q4ERodsZilrYa5yUpr2oSNjxqrLcrSauaVkhkTVB+9mUKUXWXoOGPcUB
	JUhZpNX4f+++ttuKgds7MYnB3TB3lrUWROCcU4hMGBO6WV5nn0x2a1MOSA9xTsH13F1
	A9JKSi0RTA==
Received: by mx.zohomail.com with SMTPS id 1772014114658259.36757652459517;
	Wed, 25 Feb 2026 02:08:34 -0800 (PST)
Message-ID: <4358a42d-e382-40e4-8bab-34c9f0faf1b0@machnikowski.net>
Date: Wed, 25 Feb 2026 11:08:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev
References: <20260222094110.127927-1-maciek@machnikowski.net>
 <20260222094110.127927-4-maciek@machnikowski.net>
 <aZ2DYSitNqQwkqCu@horms.kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <aZ2DYSitNqQwkqCu@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260864-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[machnikowski.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,intel.com,lunn.ch,linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,machnikowski.net:mid,machnikowski.net:dkim,machnikowski.net:email]
X-Rspamd-Queue-Id: 8C2CD19591B
X-Rspamd-Action: no action



On 24/02/2026 11:54, Simon Horman wrote:
> On Sun, Feb 22, 2026 at 10:41:10AM +0100, Maciek Machnikowski wrote:
>> Add PTP synchronization test using ptp4l and netdevsim.
>>
>> The test creates two netdevsim adapters, links them together
>> and runs the ptp4l leader and ptp4l follower on two ends
>> of the netdevsim link and waits for the follower to report the
>> synchronized state (s2) in its output log.
>>
>> This implementation runs the test runs over IPv4 link.
>>
>> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
>> ---
>>  tools/testing/selftests/net/ptp.sh | 93 ++++++++++++++++++++++++++++++
>>  1 file changed, 93 insertions(+)
>>  create mode 100755 tools/testing/selftests/net/ptp.sh
> 
> Hi Maciek,
> 
> I'm wondering if you could consider running running shellcheck over this
> and cleaning  things up a little.
> 
> I see SC2086 which I think can be trivially addressed.
> And SC2329, which I think would be best ignored using #shellcheck disable=SC2329
> 
> Also, I think you need to add ptp.sh to tools/testing/selftests/net/Makefile
> 
> Thanks

Thanks for checking - will fix in the next revision

