Return-Path: <netdev+bounces-291745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADD2Kfe+FWrYZgcAu9opvQ
	(envelope-from <netdev+bounces-291745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:40:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8105D8EA0
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6425301EE0C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7E8305680;
	Tue, 26 May 2026 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h+MbZAcN"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6CC1D5ADE;
	Tue, 26 May 2026 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809041; cv=none; b=pAfN2zYsqpXCcPvFSVRoqSTiyL7hoSXjMz3hQWekOKluku+9S/rRoPthAJb1/s2d4vvIUPXxiz5PWUsiV8/CTDkkCh3nknT5V6KfM7Ek3WWVYz47qr2M1jo49CTJSnPFth/EQvI+Vw2Q8i4c8gfSmxcU7LGLSL3KjurITXFltAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809041; c=relaxed/simple;
	bh=3e1zqRl6zwuIULkAIQGfKTuvCcLwuUU1UmQkPmbiYyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5B/tZ5Iw6TLI4z8SoX85PEz55goxhS4UYKwABqYmJyYUVUlOUuSHRQOSRUQ/aySZVgI1CjVc4QeKF/uA3kY7ddvUulWLVIwhzPddk3fwPwaBhT1u8mHMwML7/ty7Qi9i71qu7zgmHDoTfAB6kOHUXEtImPUfFn/FGxWw8guBWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h+MbZAcN; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b39dacb-6c4c-430a-9bc8-4d53d4f1f404@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779809026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nMO/6+hfT/3RY3sEQzw7Qj/Aa7bcOJh/efr+qadybA=;
	b=h+MbZAcNxDO5wsXuQqSje6WXoMPIskPmshBO1G1lCShxXvRfpeMmBHejkMhiqzZN2ii8b2
	il/jgFUUkpd9QCq8eUkbs06WZ62i1L0JPFH48jaJQZDBHrg+ToqUElMvkTJzoQf5oJovvz
	kDZXNgN5UDQAdSPnUFri5Jox5ptwIFg=
Date: Tue, 26 May 2026 23:23:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] selftests: net: add socat syslog for PPPoL2TP
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260526014152.532505-1-qingfang.deng@linux.dev>
 <60b50562-3351-49da-ab6b-953270380314@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <60b50562-3351-49da-ab6b-953270380314@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291745-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4A8105D8EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/2026 4:10 PM, Matthieu Baerts wrote:
> Hi Qingfang,
> 
> On 26/05/2026 11:41, Qingfang Deng wrote:
>> As done in pppoe.sh, start socat as the syslog listener. In case the
>> test fails, dump its log to see what's going on.
> 
> (...)
> 
>> diff --git a/tools/testing/selftests/net/ppp/pppol2tp.sh b/tools/testing/selftests/net/ppp/pppol2tp.sh
>> index 5b592785f1f9..96786267ccc7 100755
>> --- a/tools/testing/selftests/net/ppp/pppol2tp.sh
>> +++ b/tools/testing/selftests/net/ppp/pppol2tp.sh
> 
> (...)
> 
>> +# Dump syslog messages if the test failed
>> +if [ "$RET" -ne 0 ]; then
> 
> This only checks for errors with the first test, not with the second one
> below. Should you create a new helper and call it here and below? Or
> only once at the end, using ${EXIT_STATUS} instead?

I'll move it to the end, thanks.

>> +	while read -r _sign _date _time len _from _to
>> +	do      len=${len##*=}
>> +		read -n "$len" -r LINE
>> +		echo "$LINE"
>> +	done < "$PPPOL2TP_LOG"
>> +fi
>> +
>>   # Recursion test
>>   RET=0
>>   # Delete route to LNS IP
> 
> Cheers,
> Matt
> 


