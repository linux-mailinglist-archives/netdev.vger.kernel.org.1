Return-Path: <netdev+bounces-263809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO3DNkgpqGkdpAAAu9opvQ
	(envelope-from <netdev+bounces-263809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:44:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7860C1FFC6C
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CD553033250
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2931DE3DC;
	Wed,  4 Mar 2026 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="eqva1X0L"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03401D63F3
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628280; cv=pass; b=IhifcLgp4cA1JUbsMhg6KCR4/G4MkJa9DMd+f13eqtdvh6gquu8lFiQlrbV82yfKZZQyt7XaBbuZeXrC5ieCahKih49YXPxkm08LDM7O9JTZzYGVbuWXcLRduwFRWNPeRlwAcLzSubNlwlUVj7y5RgzB+nN28PcaWLRmftyFXJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628280; c=relaxed/simple;
	bh=X2nS94u7nxbtaIrN9MWRG/nzRpA1LzoYr7s/AMOGkCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQ6kcyNyY+xDvmtwN5NlxIeRh9FDOa8AjSw5Gehj0AzmjgJ0ky3fAQQyD0W8JKJ+LiwKR02+0JIBPBg3yfVIEL/mEAVNbyo09b+ZMWPNTYmzyNqzqepL7S/w1nxiVmaZM1XFxN6L/X9Pz6TjJS9axducV0ENrzBuNnJwsxQeXp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=eqva1X0L; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1772628265; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lNNbE/DzQAOalQ4ZG3hIDGlgN6GlsX5UGzrZl637hGtXjdpSqzv1nGnvw7P2+HR78y6RVHroAB98Cdn77cZ7VnXeUbmCe9J3Sgg2svI302vYXoIr29IJBUAVCFVtL5aGGgEIg8nymR7zwjGQF6AjTmlhakhD+FtCO85AiQ9AorE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772628265; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tTNTML6DYrUvdkGL3TICwFcU2LFSoeP5gceXsX5UW7c=; 
	b=QtqVNcSzBMnZLBTEbunIAEPYZAGwkHd5TGE4u+Z6YBme6DOD7y7S2hH830UtFl/KtLPLQQDQ9Kho/k7JU1W3nTGjOXkzCrL8UoCn5xDj6yORrTJuKVXAN9HGQzHvmHfkGXqqG4ck+xyBn1ytp9l8lk1Q/TYE5Z9YkzEwUDo5oFg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772628265;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tTNTML6DYrUvdkGL3TICwFcU2LFSoeP5gceXsX5UW7c=;
	b=eqva1X0LEbKosqjXFcfAArdrTNRCxNoF4VWadlRbQdKpoaueFeLnJ49LTnu6vDjb
	1ZKPXqQXu17L5IrgjGCM+0oVFwugz4dWW/7whvnsMZlorGmr3vycpkOlF7GwnegE0bp
	zSa0U/X3r6PuSwLs5VRVxa4hY+Q+ZZDzQjz4AAl5kEddTc9OsADwskcfISKFQKAiREX
	Ln0SczJJTGGokJUXWaKtTduc1t4hUN/6P0xk/dVwOplBX77hj0p00LKT5C/5/HpUtBL
	TVjoKOQ4RjDbmAD38deMzqD4zfKM+DedzwWN8YdS88NjWYyGaVMbQaF2CGvbxatBgwU
	6IX/9IicUg==
Received: by mx.zohomail.com with SMTPS id 1772628263087224.9134221869408;
	Wed, 4 Mar 2026 04:44:23 -0800 (PST)
Message-ID: <1968d10a-454f-4bc8-99e0-14f7a8fc465f@machnikowski.net>
Date: Wed, 4 Mar 2026 13:44:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
To: Sai Krishna Gajula <saikrishnag@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "milena.olech@intel.com" <milena.olech@intel.com>,
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
 "andrew@lunn.ch" <andrew@lunn.ch>,
 "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "horms@kernel.org" <horms@kernel.org>
References: <20260225153858.29486-1-maciek@machnikowski.net>
 <20260225153858.29486-4-maciek@machnikowski.net>
 <BYAPR18MB373527B461555491BBA10FF1A075A@BYAPR18MB3735.namprd18.prod.outlook.com>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <BYAPR18MB373527B461555491BBA10FF1A075A@BYAPR18MB3735.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 7860C1FFC6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263809-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[machnikowski.net];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,lunn.ch,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,machnikowski.net:dkim,machnikowski.net:email,machnikowski.net:mid,marvell.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:email,linux.dev:email]
X-Rspamd-Action: no action



On 25/02/2026 17:45, Sai Krishna Gajula wrote:
>> -----Original Message-----
>> From: Maciek Machnikowski <maciek@machnikowski.net>
>> Sent: Wednesday, February 25, 2026 9:09 PM
>> To: netdev@vger.kernel.org
>> Cc: kuba@kernel.org; maciek@machnikowski.net;
>> richardcochran@gmail.com; milena.olech@intel.com;
>> willemdebruijn.kernel@gmail.com; andrew@lunn.ch;
>> vadim.fedorenko@linux.dev; horms@kernel.org
>> Subject:  [PATCH v3 net-next 3/3] selftests:net: Implement ptp4l
>> sync test using netdevsim
>>
>> Add PTP synchronization test using ptp4l and netdevsim. The test creates two
>> netdevsim adapters, links them together and runs the ptp4l leader and ptp4l
>> follower on two ends of the netdevsim link and waits for the follower to
>> report the synchronized 
>> Add PTP synchronization test using ptp4l and netdevsim.
>>
>> The test creates two netdevsim adapters, links them together and runs the
>> ptp4l leader and ptp4l follower on two ends of the netdevsim link and waits
>> for the follower to report the synchronized state (s2) in its output log.
>>
>> This implementation runs the test runs over IPv4 link.
>>
>> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
>> ---
>>  tools/testing/selftests/net/Makefile |   1 +
>>  tools/testing/selftests/net/ptp.sh   | 105 +++++++++++++++++++++++++++
>>  2 files changed, 106 insertions(+)
>>  create mode 100755 tools/testing/selftests/net/ptp.sh
>>
>> +
>> +# PTP synchronization test: run ptp4l leader in nssv and follower in
>> +nscl, # then parse follower output to verify they synchronized (servo state s2
>> = locked).
>> +PTP4L_LEADER_LOG=$(mktemp)
>> +PTP4L_FOLLOWER_LOG=$(mktemp)
>> +ip netns exec nssv ptp4l -i "$NSIM_DEV_1_NAME" -m -4 -P \
>> +	> "$PTP4L_LEADER_LOG" 2>&1 &
>> +PTP4L_LEADER_PID=$!
>> +
>> +ip netns exec nscl ptp4l -i "$NSIM_DEV_2_NAME" -s -m -4 -P \
>> +	> "$PTP4L_FOLLOWER_LOG" 2>&1 &
>> +PTP4L_FOLLOWER_PID=$!
> Minor nit,  
> ptp4l master, ptp4l slave started back-to-back.  
> Better practice is to 
> Start master
> Sleep 1
> Then start follower
> 
> Otherwise initial announce might be missed, causing unnecessary delay.

Hmm not sure how would a sleep 1 help here - the leaders starts first,
runs its BMCA anyway, and the follower starts with the -s flag. If
anything, adding the sleep 1 would actually cause the initial announce
to be missed (unless I'm missing sth there).

>> +
>> +
>> +for _ in $(seq 1 "$PTP4L_SYNC_TIMEOUT"); do
>> +	if grep -q ' s2 ' "$PTP4L_FOLLOWER_LOG" 2>/dev/null; then
>> +		exit 0
>> +	fi
>> +	sleep 1
>> +done
>> +
>> +echo "ptp4l follower did not reach locked state (s2) within
>> ${PTP4L_SYNC_TIMEOUT}s"
>> +exit 1
>> --
>> 2.53.0
>>
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>


