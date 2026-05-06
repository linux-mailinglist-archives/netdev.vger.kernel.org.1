Return-Path: <netdev+bounces-284808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLVVLjY3+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:42:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB194DA5EA
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F62A301F184
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317FA4418CB;
	Wed,  6 May 2026 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="IxX3sIs+"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24B3264E6
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071075; cv=pass; b=MM+yhhlBCBSlL6Ahp5f24KlT/2HOfFfeHGWMpzSDz35hwNDrJNg1SaM4uiwbx6B4xzyuroUuuMYRgaxA9lhiA1tUa0+wQPAXolGs0KhG5QlBQnHUaMmgFc9LGKKGqCEp/DjCA0ezeseB8eN4BZe7nxmbDOkc+jwnNzQ3I7/h82M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071075; c=relaxed/simple;
	bh=dAnnTHpDsx0tKV6OP/2Kcnjd2/Q1atFONvIVC9/JLaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/Qvz0ndKQNZPQqIEJH6QPw8DMlg8OmDGfqfO1BgaPnelecx85AUrjSYm8SvjCyDGNF2Sxw/ByIIaVLMnKlJtZ6QqLdKiovWwC3zjrf7z3W+Y5xPfQpflyGJu84uOrYK1JzxXr3rmoGENPtXiErtZDYzbsd+4zpsN3f/Zv6SNXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=IxX3sIs+; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1778071009; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I+Cv3F0eqahfVusU+3VBsIfiqtazzI09YULQ6q1CEQ2FydgmuTkqLI5rPPWxc5VAA7HE4YK5da2T5QtILh2g4fyfIZcjJsUpQk39+EAuf1kBui4Q/Z2fUFjkIRzOylKF545WxOrjcc/2AQZFwcaWrMWpeioej36Ubz5XX9K6l/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778071009; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GJBnN2UKtkH2wblZF5SpKtrTXUKF319xoDdA0nj17ew=; 
	b=foCISYHmdNn+6Sj2P3fYjwXMsFalWbBSG7gynkekNhcIOOzAQxjMIaBI40WLpQM6TOQFd1KUCbEtmzXmrNjnPn0rLJKe444l0TCJJbxGLEKu/fTpBWYqSdnwcWpC9UilVe1SCQSrqEbvFguMGxw1WqhUVDPnIUGFtDKdIwvhKxo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778071009;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GJBnN2UKtkH2wblZF5SpKtrTXUKF319xoDdA0nj17ew=;
	b=IxX3sIs+q4ClUeb9W9P5FfU/cCMQPC70ZP9N/2O6Rbs9g/+k2UDuVXW224PH/4Gx
	JRtbp2EEruzGwHrLwTgQWTANowNMO3dhX1C2xDVtU7bwyf6aMfKYPReoZlEXnCLgjEm
	oNqNqBG8OycPTsptNK8Vpq2Ggmn2Xb+JrhWhz5SY064hqBp9L9H8bgFpm/zaidefAkE
	PNupgFR4zGqb/xBlcStcPohyGBAzN5b90ndz4tRl6t1K+hXgpHXJpEtKEH+ROnfLY3o
	QYkDHQIh9RcFJgB4W3kPiRYZMvuivb99unGP4SF/o/ucTmm6th9wvtYGyE6V+w+lTcy
	lnGyIFVTgQ==
Received: by mx.zohomail.com with SMTPS id 1778071005458975.5407631899534;
	Wed, 6 May 2026 05:36:45 -0700 (PDT)
Message-ID: <b1d219cf-1f9c-4e50-8e43-b463b1855142@machnikowski.net>
Date: Wed, 6 May 2026 14:36:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, horms@kernel.org
References: <20260503074747.1321-1-maciek@machnikowski.net>
 <20260503074747.1321-4-maciek@machnikowski.net>
 <20260504100753.7cc193cc@kernel.org>
 <b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
 <9c7eecee-f0c2-4ee3-95cf-ae9965191902@lunn.ch>
 <aa5798db-51b1-4d44-abec-c55b0560ec21@machnikowski.net>
 <b2fc7480-dd88-4ddd-9e6e-239ba80dd879@linux.dev>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <b2fc7480-dd88-4ddd-9e6e-239ba80dd879@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 1CB194DA5EA
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-284808-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[machnikowski.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,intel.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 05/05/2026 18:38, Vadim Fedorenko wrote:
> On 05/05/2026 17:22, Maciek Machnikowski wrote:
>>
>>
>> On 05/05/2026 14:22, Andrew Lunn wrote:
>>> On Tue, May 05, 2026 at 09:36:30AM +0200, Maciek Machnikowski wrote:
>>>>
>>>>
>>>> On 04/05/2026 19:07, Jakub Kicinski wrote:
>>>>> On Sun,  3 May 2026 09:47:47 +0200 Maciek Machnikowski wrote:
>>>>>> Add PTP synchronization test using ptp4l and netdevsim.
>>>>>>
>>>>>> The test creates two netdevsim adapters, links them together
>>>>>> and runs the ptp4l leader and ptp4l follower on two ends
>>>>>> of the netdevsim link and waits for the follower to report the
>>>>>> synchronized state (s2) in its output log.
>>>>>>
>>>>>> This implementation runs the test runs over IPv4 link.
>>>>>
>>>>> Doesn't seem to pass on netdevsim for us:
>>>>>
>>>>> # 41.13 [+40.95] # ptp4l follower did not reach locked state (s2)
>>>>> within 40s
>>>>> # 41.13 [+0.00] # Follower log (last 10 lines): ptp4l[2179.605]:
>>>>> ioctl SIOCETHTOOL failed: Operation not supported |
>>>>> ptp4l[2179.607]: interface 'eth0' does not support requested
>>>>> timestamping mode | failed to create a clock
>>>>> # 41.15 [+0.02] # Check| At /srv/vmksft/testing/wt-2/tools/testing/
>>>>> selftests/net/./ptp.py, line 173, in ptp_sync_test:
>>>>> # 41.15 [+0.01] # Check|     _run_ptp4l_wait_sync(nsimsv.ifname,
>>>>> nsimcl.ifname, nssv.name, nscl.name)
>>>>> # 41.16 [+0.01] # Check| At /srv/vmksft/testing/wt-2/tools/testing/
>>>>> selftests/net/./ptp.py, line 99, in _run_ptp4l_wait_sync:
>>>>> # 41.17 [+0.01] # Check|     ksft_true(False, "PTP sync timeout")
>>>>> # 41.17 [+0.00] # Check failed False does not eval to True PTP sync
>>>>> timeout
>>>>> # 41.32 [+0.16] not ok 1 ptp.ptp_sync_test
>>>>> # 41.33 [+0.00] # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
>>>>>
>>>>> Anything we need to do?
>>>>
>>>> Can you share the config file you used? Seems the PTP clock was not
>>>> found which may lead to PTP_1588_CLOCK_MOCK not being enabled?
>>>
>>> Shouldn't the configuration file be part of the test?
>>>
>>>     Andrew
>>
>> I meant the kernel config. The PTP emulation requires PTP Mock to be
>> enabled, as that's the backbone for generating timestamps. If it's
>> disabled - netdevsim netdevs will report no timestamping support, as in
>> the example above.
>> - Maciek
> 
> tools/testing/selftests/drivers/net/netdevsim/config has
> CONFIG_PTP_1588_CLOCK_MOCK=y
> 
> but maybe no CONFIG_PTP_1588_CLOCK ?

AFIR the PTP_1588_CLOCK_MOCK depends on PTP_1588_CLOCK, so the latter
should be enabled as well - unless the test environment doesn't respect
dependencies

