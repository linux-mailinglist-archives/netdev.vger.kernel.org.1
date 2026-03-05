Return-Path: <netdev+bounces-264113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODgDAE3YqGlmxwAAu9opvQ
	(envelope-from <netdev+bounces-264113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:11:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6330F209B69
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B38F301379F
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6A23C51D;
	Thu,  5 Mar 2026 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lD9BDUNx"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752B8203710
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673083; cv=none; b=RtaCc/5pJKLBZOmnFZ5XegR0c2nRJwh+tjRM8Zey2chTMmAwEhX+nBf/GafJ3sg2sg+3ZJ5TlqlFQyDbekxi/w7CbiDBr+kMJ9+krDWHHJUcUVzLVZ7GB+zReTN+pn8ySSyJPoOanEmREsZa5kNv2ZHbJThfPDMWqC33nHU2n4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673083; c=relaxed/simple;
	bh=6j9+bYJ9UVL6qrFbs8/OUsNVswHG1yIys0c/DuTaeTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddyPwPiA6G4rB+Bz7SOJ5PvPoz7Zs4m+gjPyi2uwg58ky6tqJFo5xY6BMhLr37gixirkg2vQSUBZGyOW83D1FOgdEfXKbBJXuPhcGe62n9qKWtOW2WJGa0J+DDRoubaZ4uh4HRagGklPcWuBynhB4EeknL5CmDe17BF9anPu9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lD9BDUNx; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <682b4e08-7c21-4616-b1cc-65923c3ae09a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772673070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PhDbeBcQSmf2HN3hAelrmzZ/D4QuioH83c5OluSuGY4=;
	b=lD9BDUNxnIhtn+vP6DoCTYsQ/ojmfnUoHTsuh0ygyT5TliZprRNCnU7Jsh7SemQRepTfXB
	7W6Hqt9HHId+I8Za/BxFw7z8AM4n08K4sgHKB+Tv+YOeIGKPv8iP1hrr2eOx4poqQ28DWZ
	iB0C3ZW2RipayWGiBzWNmSK6S22gWfM=
Date: Wed, 4 Mar 2026 17:11:02 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v10 bpf-next 2/2] selftests/bpf: Add selftests for the
 invocation of bpf_lwt_xmit_push_encap
To: Leon Hwang <leon.hwang@linux.dev>, Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, posk@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260304094429.168521-1-yangfeng59949@163.com>
 <20260304094429.168521-3-yangfeng59949@163.com>
 <8f6755ed-d2ae-42ba-8052-2e6fba3d5c69@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <8f6755ed-d2ae-42ba-8052-2e6fba3d5c69@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 6330F209B69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264113-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,163.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

On 3/4/26 2:33 AM, Leon Hwang wrote:
> On 4/3/26 17:44, Feng Yang wrote:
>> From: Feng Yang <yangfeng@kylinos.cn>
>>
>> Calling bpf_lwt_xmit_push_encap will not cause a crash when dst is missing.
>>
>> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
>> ---
>>   .../selftests/bpf/prog_tests/lwt_misc.c       |  9 ++++++++
>>   tools/testing/selftests/bpf/progs/lwt_misc.c  | 22 +++++++++++++++++++
>>   2 files changed, 31 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_misc.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/lwt_misc.c
>>
> 
> Unnecessary to create new files.
> 
> Move the adding test to verifier_lwt.c. prog_tests/verifier.c will run
> the test.

It is actually the change from v9 to v10. I think leaving it separate is 
better. It is not testing the verifier, so logically it does not fit in 
verifier_lwt.c. It probably won't be the last fix for test_run+lwt, so 
separating it should be useful going forward.




