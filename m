Return-Path: <netdev+bounces-284243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM0gBnKf+WmQ+QIAu9opvQ
	(envelope-from <netdev+bounces-284243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 09:42:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FAD4C8246
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 09:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D1083012304
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 07:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A721255A;
	Tue,  5 May 2026 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="NWZ6ss+X"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032293B27C1
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966643; cv=pass; b=m8EgNXg4fbJJ+SfOcNikfith+9fKdV06osB8HkHMtwmbryRu+Si5XysNQFWU4nbhMJcRLfbMoRWPVdvpMlPGBkXv0MdW/l9u7QsOmO5eilSrHK450koxx0FJUt5Y4+FJdMepFGzcsq+QjGcBmd8PczX3W06dFGDDDQoLFN4szhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966643; c=relaxed/simple;
	bh=3G9QaTQCQEmoXL+LGKaHocl7k3NbJvxUMprfn/nMgWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cw7H8D/OUj9JB1XpZeqTgtPSr3QWGN5siaFwggzped7FKyV/8FAl+VPnn1/EPJxtapQnk81NFGupaU07J8BIgPyWCV1KyM09PKTw4jW2Iri5TbpJCHubCKbEmuq+7gpwWTDa/VF8JPtiQbCf7gufYWgmDkQwWNsocxNvvo0f4bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=NWZ6ss+X; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1777966597; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ISQltp39QM0SsYV2bXT4MruSErSKHUniXsAYwAaiMJQ1QbSUa8a+XttUE0GKGnMNUenrfbLocBj3w5dcDUs1aVRQ0IX/oPKdeL+YLjiYm/9J3fubgJdqnB27hTOaWvl1CfxdjYaTQ26ruRvTvKZxdzrKr4+vgf1DubsAG/GR0/Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777966597; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=b1nKg4eeO6C+sevwKxqwFI8mi3mbf4Tw5nChVLLH8eY=; 
	b=T4UZKIwPg0MFneyjPX2KY3ElMV/tPzM09wcFOb4WvWFGJMbiYNY0Vzys140xJXe3ZB7fUV7yCStSpDzs+4lLWMoLdpmpObMJfBUz9AGnX6svpScPDM/MbD61/Bfg50i+z3Kb8iK1QzWOBStPaONbIyWvdlhrhUJylPIlJnoLIQk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777966597;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=b1nKg4eeO6C+sevwKxqwFI8mi3mbf4Tw5nChVLLH8eY=;
	b=NWZ6ss+Xfi3XHldJyK4+u0AT13aRM6O2RJalWpe4xnj5RufJ3dG2tMAdTyeVBcIA
	uNqig92dtOeWcJWJMYEaQJKO/Y7UfQ2nq5fXDd0P9g156EYR4kR1I7XnCl3zLKT+D0B
	y6X9dxuKmFmECoi003PtIgbmx0n1uSBNbfN1OACTf73VhwSPSAHcvZVhV9eYi6MVNeM
	+ojCDfyVEHla2Ny/8tDAE1y0yDbbFro0axj1mJWX2YxqOeh4Gigid6NTfp0W1F3vxI7
	CZt+bSjL9BAr6xn+O7VFHSioffQ2BB76VLCdPCMK175gGH3oMwu7G1H9QR59R1nTZ8C
	LLyD0wQPAA==
Received: by mx.zohomail.com with SMTPS id 1777966593449373.83195855160307;
	Tue, 5 May 2026 00:36:33 -0700 (PDT)
Message-ID: <b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
Date: Tue, 5 May 2026 09:36:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, andrew@lunn.ch, vadim.fedorenko@linux.dev,
 horms@kernel.org
References: <20260503074747.1321-1-maciek@machnikowski.net>
 <20260503074747.1321-4-maciek@machnikowski.net>
 <20260504100753.7cc193cc@kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20260504100753.7cc193cc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 85FAD4C8246
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284243-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,lunn.ch,linux.dev,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[machnikowski.net];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]



On 04/05/2026 19:07, Jakub Kicinski wrote:
> On Sun,  3 May 2026 09:47:47 +0200 Maciek Machnikowski wrote:
>> Add PTP synchronization test using ptp4l and netdevsim.
>>
>> The test creates two netdevsim adapters, links them together
>> and runs the ptp4l leader and ptp4l follower on two ends
>> of the netdevsim link and waits for the follower to report the
>> synchronized state (s2) in its output log.
>>
>> This implementation runs the test runs over IPv4 link.
> 
> Doesn't seem to pass on netdevsim for us:
> 
> # 41.13 [+40.95] # ptp4l follower did not reach locked state (s2) within 40s
> # 41.13 [+0.00] # Follower log (last 10 lines): ptp4l[2179.605]: ioctl SIOCETHTOOL failed: Operation not supported | ptp4l[2179.607]: interface 'eth0' does not support requested timestamping mode | failed to create a clock
> # 41.15 [+0.02] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 173, in ptp_sync_test:
> # 41.15 [+0.01] # Check|     _run_ptp4l_wait_sync(nsimsv.ifname, nsimcl.ifname, nssv.name, nscl.name)
> # 41.16 [+0.01] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 99, in _run_ptp4l_wait_sync:
> # 41.17 [+0.01] # Check|     ksft_true(False, "PTP sync timeout")
> # 41.17 [+0.00] # Check failed False does not eval to True PTP sync timeout
> # 41.32 [+0.16] not ok 1 ptp.ptp_sync_test
> # 41.33 [+0.00] # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> Anything we need to do?

Can you share the config file you used? Seems the PTP clock was not
found which may lead to PTP_1588_CLOCK_MOCK not being enabled?


