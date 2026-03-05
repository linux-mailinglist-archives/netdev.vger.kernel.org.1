Return-Path: <netdev+bounces-264119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HudIejdqGmVyAAAu9opvQ
	(envelope-from <netdev+bounces-264119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:35:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3408209E41
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D548A301DA70
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E25123B62C;
	Thu,  5 Mar 2026 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a5J0nCAq"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E1378F4A
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772674476; cv=none; b=PqpvsjTcWnnOSa2Rj1X/ZGmc4IWRUQ5aJibrQ5RCkeBgeeXQYZlaEFRYV/cQlTeBfySBo0v8W7XR8YokZGRp421YCQcrHVz6SONAPe7QZtLQ6wTQC96g6u9DHkSWbhIIsMRPIl9CcdDmJvszPMCaiOnYVRAV/oAt+ohZLotgXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772674476; c=relaxed/simple;
	bh=pWgQ8y71kCvi/Sb21LxjNPt5SMJRWb1n0bWk+ROs/Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iB2PFUGXUGNja4VVymcfT2fXYVfCg+MdkbLxzrcpp6yIP/mSSkDzJU05AQ7Hn+a/8UL38X856bCMJdIa6P0RSYE/f8bkX0EhkSOH+dPbRKqcyPVewsMERd5q+kKxUkjaqIIvcOv15eKgp3spLZTU88iRFNXoO9jwM0NZZWkVus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a5J0nCAq; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d76953ff-841e-4c88-800e-5c761f50d70f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772674462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfDN/bvfBCvYWg7+zeSFGz8yRL+iVsNGXGZCk8qgMlc=;
	b=a5J0nCAqG5IDYwn11YB6UPJ4LkY9w2nm0tjGlR37R6r10VAggTWEd9/Pq7zjy39wK8uqnG
	lYcnVkFqkKN9+NSRWFAlT1gYYzwJg7GmzXKSMrs0WKNnU84BOqZ9ola2t7crB1PfX+FYbA
	qcb6hp3kfb82h2Zd5BULQCIBdDF7nvU=
Date: Thu, 5 Mar 2026 09:34:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v10 bpf-next 2/2] selftests/bpf: Add selftests for the
 invocation of bpf_lwt_xmit_push_encap
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, Leon Hwang
 <leon.hwang@linux.dev>, Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, posk@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260304094429.168521-1-yangfeng59949@163.com>
 <20260304094429.168521-3-yangfeng59949@163.com>
 <8f6755ed-d2ae-42ba-8052-2e6fba3d5c69@linux.dev>
 <682b4e08-7c21-4616-b1cc-65923c3ae09a@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <682b4e08-7c21-4616-b1cc-65923c3ae09a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C3408209E41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264119-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,163.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

On 5/3/26 09:11, Martin KaFai Lau wrote:
> On 3/4/26 2:33 AM, Leon Hwang wrote:
>> On 4/3/26 17:44, Feng Yang wrote:
>>> From: Feng Yang <yangfeng@kylinos.cn>
>>>
>>> Calling bpf_lwt_xmit_push_encap will not cause a crash when dst is
>>> missing.
>>>
>>> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
>>> ---
>>>   .../selftests/bpf/prog_tests/lwt_misc.c       |  9 ++++++++
>>>   tools/testing/selftests/bpf/progs/lwt_misc.c  | 22 +++++++++++++++++++
>>>   2 files changed, 31 insertions(+)
>>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_misc.c
>>>   create mode 100644 tools/testing/selftests/bpf/progs/lwt_misc.c
>>>
>>
>> Unnecessary to create new files.
>>
>> Move the adding test to verifier_lwt.c. prog_tests/verifier.c will run
>> the test.
> 
> It is actually the change from v9 to v10. I think leaving it separate is

Got it.

> better. It is not testing the verifier, so logically it does not fit in
> verifier_lwt.c. It probably won't be the last fix for test_run+lwt, so
> separating it should be useful going forward.
> 

I realized it after sending the reply. Thanks for the explanation.

Thanks,
Leon


