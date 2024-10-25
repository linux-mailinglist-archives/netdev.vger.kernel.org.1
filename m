Return-Path: <netdev+bounces-139189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9685D9B0D51
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 20:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1751F250B1
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 18:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BA518C930;
	Fri, 25 Oct 2024 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="APKtVjV4"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85E1465A0
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881028; cv=none; b=AplJhAODX/C6ekzyQWcuqylro8Dd8ieR7qXL6nXJtKMwQNpS8Zh+t9CmA3qiixYzTgze2Rd7hEW1C8fBgF2OdWlrlDXnYR2hLPa+y4lLltWeZGXH3PCkO8kTtaDCL5q1OfVkV1mDlT3+Q35C6Rst66MAEjdQVyGPpAcIVXBNRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881028; c=relaxed/simple;
	bh=SGH5Cu6HV7pUTJgcAU4WLzMiYOro4pkaoyi7srPIk/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUtwAsMIyUc7gjIsRsYEsK7nG+l6NRWhcT1eA1yDCtgEsVz4O8d7yJD6irGpOB6m8JvSUgxj4CkcMv/KZ2ZOktewGD/2h+nMpSdaBOXnClcwpaBQPjMKv/flNugNS+khtLpcIknqKIr8iboEm+B/6laazRLpV7NpD6z+zFSCWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=APKtVjV4; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0e5712f2-7ecc-457a-afb7-4b304eb1bffa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729881023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7yCOcsQE5SG3SKhQzIbuLb+nPE7HmrNk95DllndTqw=;
	b=APKtVjV4P2oY506YW/GWr1A7Cs9ornse0u4aqBRAS4b+prR1D4+Y1VEuwwg6/Mdk1cX3Sa
	BXv7c+QPi+n4c5vPCL3zuKXNaD9xilz0e4j7i6aLlvLoV9lPusMTn0xT0jZ9K0fFa58FdB
	qlik7mXt20xc8YXaQKPdNvyWLxQ2pBw=
Date: Fri, 25 Oct 2024 11:30:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/4] net/smc: Introduce smc_bpf_ops
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, dtcccc@linux.alibaba.com
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
 <1729737768-124596-4-git-send-email-alibuda@linux.alibaba.com>
 <74c06b43-095f-414a-b4aa-2addbe610336@linux.dev>
 <e398770a-1ab5-478b-820d-16c6060e0008@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <e398770a-1ab5-478b-820d-16c6060e0008@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/25/24 4:05 AM, D. Wythe wrote:
> Our main concern is to avoid introducing kfuncs as much as possible. For our 
> subsystem, we might need to maintain it in a way that maintains a uapi, as we 
> certainly have user applications depending on it.

The smc_bpf_ops can read/write the tp and ireq. In patch 4, there is 
'tp->syn_smc = 1'. I assume the real bpf prog will read something from the tp to 
make the decision also. Note that tp/ireq is also not in the uapi but the CO-RE 
can help in case the tp->syn_smc bool is moved around.

 From looking at the selftest in patch 4 again, I think all it needs is for the 
bpf prog (i.e. the ops) to return a bool instead of allowing the bpf prog to 
write or call a kfunc to change the tp/ireq.



