Return-Path: <netdev+bounces-284508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDe4ASsa+mlYJQMAu9opvQ
	(envelope-from <netdev+bounces-284508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:26:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDB54D13DC
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38680303F259
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC543161A3;
	Tue,  5 May 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="m6dvPtit"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82957480958
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998150; cv=pass; b=CS6hecYfi+G9/npJvckaWJ5UJEm8tF/7r30uGTil2PT63JOCV9yqkVbWFz/SiChQLt8uznLjUOiSGNnGwEZLxh5ooYBjM/Un2uinGmyUCIOldOfzKFFM16nZtGm6TPYEOE2d0YuFcN/Sd5BtTG5oKtxm+590q7jrtIQMoEuLZds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998150; c=relaxed/simple;
	bh=LOE0vBIyMRu63W+d7n46aiGDnXbBbDNI6QI3il0m+Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3C7u6bgZhO3O/UhJL458l9cL7SYhasPWfdseEug+reu2VQ928APf4FBQ0w9Sk3ma1JGfCgs6XiPJZ/2iTw7cUMv4LKrJ9ckLLB3HZ0++PsQRRxrCo1CUJgVxUQTwxYRnCLgKrhqrzYlp4dyHqwKI9Spm4fty00QUGLSIcnpq1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=m6dvPtit; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1777998138; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j4zQ2SrEV1rirzwRxcaNEK2ee8NK352LDoulvVL0XLN5Tox7laYykNxiekGKPnnyf5Idmgah84h1b3Qye8LsLGjA03ABGq5fFZb8QmApv7NV9I2ZMhKj2jaV/g/1TzXY6mR9UJ8y4ybf5Y7Iiu1YwEZ8gUFZ33Z89eXmBC5C9cc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777998138; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xW5DL1V7XNxiGERUpoHJKx75SVeA/WDeAyi44HNEggU=; 
	b=A0cYQ+uXUPMmaa6yk9pcFF6ChDjMW59DUf0dPKZmRpeaTLuTLF020IB4cYxpT/P2jJ6k69G3fLH1tBtcWznDqHzQpUz+JFdlVKHshK+5o6F66rblzVIuhVQieFmlDll0nswDQXTE5NrBJAgQTE8qovFKn/8AHGAuc5Y8lINfpsc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777998138;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xW5DL1V7XNxiGERUpoHJKx75SVeA/WDeAyi44HNEggU=;
	b=m6dvPtithfaqqAiAMHoprtY0+EU6S27NF23wK6i3eVO2mVJCtTY64PJ7DPebxuSl
	3s8SPbCay72jfU4Z9I/8wbGoEPqYIEis4TEEeKUcHVud7zdqvL8QKH6cvqlqnDjqvU5
	s3CFj41rdHvaOpb3jSSKxQ8cPQhtA2O80u9aVeiyoMCeuo6NuHpLbCNikzY/+9OO6VZ
	7Py2E9cKd+JEtksBYzBhWOjOq6JDtFFY3VxHq5NH13slCQ63U//V3NREQp0LnZwizPr
	QAo4ULxAbsk2KrInmxRkLn96crZ1aFfvW4Eh/srULG4LziBk1mAEwuFHzPnR43paWII
	skEZypyFMg==
Received: by mx.zohomail.com with SMTPS id 1777998135578601.1702646946356;
	Tue, 5 May 2026 09:22:15 -0700 (PDT)
Message-ID: <aa5798db-51b1-4d44-abec-c55b0560ec21@machnikowski.net>
Date: Tue, 5 May 2026 18:22:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, vadim.fedorenko@linux.dev, horms@kernel.org
References: <20260503074747.1321-1-maciek@machnikowski.net>
 <20260503074747.1321-4-maciek@machnikowski.net>
 <20260504100753.7cc193cc@kernel.org>
 <b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
 <9c7eecee-f0c2-4ee3-95cf-ae9965191902@lunn.ch>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <9c7eecee-f0c2-4ee3-95cf-ae9965191902@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 7EDB54D13DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284508-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[machnikowski.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,intel.com,linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,machnikowski.net:dkim,machnikowski.net:mid,nscl.name:url]



On 05/05/2026 14:22, Andrew Lunn wrote:
> On Tue, May 05, 2026 at 09:36:30AM +0200, Maciek Machnikowski wrote:
>>
>>
>> On 04/05/2026 19:07, Jakub Kicinski wrote:
>>> On Sun,  3 May 2026 09:47:47 +0200 Maciek Machnikowski wrote:
>>>> Add PTP synchronization test using ptp4l and netdevsim.
>>>>
>>>> The test creates two netdevsim adapters, links them together
>>>> and runs the ptp4l leader and ptp4l follower on two ends
>>>> of the netdevsim link and waits for the follower to report the
>>>> synchronized state (s2) in its output log.
>>>>
>>>> This implementation runs the test runs over IPv4 link.
>>>
>>> Doesn't seem to pass on netdevsim for us:
>>>
>>> # 41.13 [+40.95] # ptp4l follower did not reach locked state (s2) within 40s
>>> # 41.13 [+0.00] # Follower log (last 10 lines): ptp4l[2179.605]: ioctl SIOCETHTOOL failed: Operation not supported | ptp4l[2179.607]: interface 'eth0' does not support requested timestamping mode | failed to create a clock
>>> # 41.15 [+0.02] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 173, in ptp_sync_test:
>>> # 41.15 [+0.01] # Check|     _run_ptp4l_wait_sync(nsimsv.ifname, nsimcl.ifname, nssv.name, nscl.name)
>>> # 41.16 [+0.01] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 99, in _run_ptp4l_wait_sync:
>>> # 41.17 [+0.01] # Check|     ksft_true(False, "PTP sync timeout")
>>> # 41.17 [+0.00] # Check failed False does not eval to True PTP sync timeout
>>> # 41.32 [+0.16] not ok 1 ptp.ptp_sync_test
>>> # 41.33 [+0.00] # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
>>>
>>> Anything we need to do?
>>
>> Can you share the config file you used? Seems the PTP clock was not
>> found which may lead to PTP_1588_CLOCK_MOCK not being enabled?
> 
> Shouldn't the configuration file be part of the test?
> 
> 	Andrew

I meant the kernel config. The PTP emulation requires PTP Mock to be
enabled, as that's the backbone for generating timestamps. If it's
disabled - netdevsim netdevs will report no timestamping support, as in
the example above.
- Maciek

