Return-Path: <netdev+bounces-284515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP0+Fw4d+mkJJgMAu9opvQ
	(envelope-from <netdev+bounces-284515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:38:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FF04D1728
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DFEE3006823
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5589E3DDDD2;
	Tue,  5 May 2026 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UTvLib4J"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305E48C8CB
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999108; cv=none; b=ols7NNDV/o1tpJ5289xYXFKFGnff4Hui10kXbSyJ/iJR8QTNYEIdqk3fjqCk23skB+nfAIbGrtPLNgeHKP/7+1nBVIT593NG/Sb63IJ7oplAm5lv24m+lMTf2Pm4HXBD/DAQ8kOIJ//4anz63SwucBSoTAeTou0bnJTVprJ8quI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999108; c=relaxed/simple;
	bh=Fru+Doydi5oOoq+fd5J4KkwdTW03WWtS9TIjctDj33w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3GtT5/a3dQZfYdcG3LZKzGjUcGedUlUrv5V91zWQPweWLHyxPcPdmLeFmP2q3bZWhwRjrhH0Hdaj7SddSbITx/4hdxapKwW2b/fQiEL38lWnR20QVj8+uTT7m2tExYcqKjraqXKXtGcRKG82T2bTnnFTQoRhrzXxRP+uRYik1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UTvLib4J; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b2fc7480-dd88-4ddd-9e6e-239ba80dd879@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777999103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/m7swAUBiFHy0R/mrY0rl3l6yUSatDE/tHhm5isz340=;
	b=UTvLib4JWAC4Qr3Ei92PnoxTIT+I4iwfPMFykB8UJ019m5PZo1Zrph31pSYzLqIOLAO9Ux
	W1kN95da+6RMlFPBsvkrIqSrta6DGR4/ArFBBb9mHHaConkvOIBIvWgq/Pukd/CkPbOKaS
	+aTmADuH3T3WP/mlptWYwa0mFGEsouY=
Date: Tue, 5 May 2026 17:38:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
To: Maciek Machnikowski <maciek@machnikowski.net>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, horms@kernel.org
References: <20260503074747.1321-1-maciek@machnikowski.net>
 <20260503074747.1321-4-maciek@machnikowski.net>
 <20260504100753.7cc193cc@kernel.org>
 <b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
 <9c7eecee-f0c2-4ee3-95cf-ae9965191902@lunn.ch>
 <aa5798db-51b1-4d44-abec-c55b0560ec21@machnikowski.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aa5798db-51b1-4d44-abec-c55b0560ec21@machnikowski.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 11FF04D1728
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,intel.com];
	TAGGED_FROM(0.00)[bounces-284515-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,nscl.name:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 05/05/2026 17:22, Maciek Machnikowski wrote:
> 
> 
> On 05/05/2026 14:22, Andrew Lunn wrote:
>> On Tue, May 05, 2026 at 09:36:30AM +0200, Maciek Machnikowski wrote:
>>>
>>>
>>> On 04/05/2026 19:07, Jakub Kicinski wrote:
>>>> On Sun,  3 May 2026 09:47:47 +0200 Maciek Machnikowski wrote:
>>>>> Add PTP synchronization test using ptp4l and netdevsim.
>>>>>
>>>>> The test creates two netdevsim adapters, links them together
>>>>> and runs the ptp4l leader and ptp4l follower on two ends
>>>>> of the netdevsim link and waits for the follower to report the
>>>>> synchronized state (s2) in its output log.
>>>>>
>>>>> This implementation runs the test runs over IPv4 link.
>>>>
>>>> Doesn't seem to pass on netdevsim for us:
>>>>
>>>> # 41.13 [+40.95] # ptp4l follower did not reach locked state (s2) within 40s
>>>> # 41.13 [+0.00] # Follower log (last 10 lines): ptp4l[2179.605]: ioctl SIOCETHTOOL failed: Operation not supported | ptp4l[2179.607]: interface 'eth0' does not support requested timestamping mode | failed to create a clock
>>>> # 41.15 [+0.02] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 173, in ptp_sync_test:
>>>> # 41.15 [+0.01] # Check|     _run_ptp4l_wait_sync(nsimsv.ifname, nsimcl.ifname, nssv.name, nscl.name)
>>>> # 41.16 [+0.01] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 99, in _run_ptp4l_wait_sync:
>>>> # 41.17 [+0.01] # Check|     ksft_true(False, "PTP sync timeout")
>>>> # 41.17 [+0.00] # Check failed False does not eval to True PTP sync timeout
>>>> # 41.32 [+0.16] not ok 1 ptp.ptp_sync_test
>>>> # 41.33 [+0.00] # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
>>>>
>>>> Anything we need to do?
>>>
>>> Can you share the config file you used? Seems the PTP clock was not
>>> found which may lead to PTP_1588_CLOCK_MOCK not being enabled?
>>
>> Shouldn't the configuration file be part of the test?
>>
>> 	Andrew
> 
> I meant the kernel config. The PTP emulation requires PTP Mock to be
> enabled, as that's the backbone for generating timestamps. If it's
> disabled - netdevsim netdevs will report no timestamping support, as in
> the example above.
> - Maciek

tools/testing/selftests/drivers/net/netdevsim/config has
CONFIG_PTP_1588_CLOCK_MOCK=y

but maybe no CONFIG_PTP_1588_CLOCK ?

