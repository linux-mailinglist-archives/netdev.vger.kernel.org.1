Return-Path: <netdev+bounces-233727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B08C178B8
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C6E422070
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C192BD035;
	Wed, 29 Oct 2025 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hdiX8RxG"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600829BDA1
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697826; cv=none; b=AaINeljstT25zrF2+6vAj2IH1k+LNdyq3I86QmuEOTMUPCjA70J67CXgxMbe0+J9BBmrc2/Oz1CIihF3U8j8MJupmB987hUnQ9cZd3Fu/w9Oc6qTHk8I7Rq/xjkBLQAIPsp64vgk+Db8V8Gd8ML2ryC/jugVzzGF/L+NZRkedyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697826; c=relaxed/simple;
	bh=BFp2VOOXg/vvY0+wkx4HQcNTNHWlJAGVc0AZqw9NsnE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jJU9J9RolzTgrmNtNEB8/4q8HSHU4HYJfFpTKy7mHxpr/qomrcYK+eDxv9WQ5+x9LH5gVtGqixtQEp4k8JDa7McyJ0/j5oaLEkZjx9+KyOHJaTPMkKW0KiuJhrxEk2XsLL0F7fFLQ5oNohOt5HM3Qcg2hXDI7gEAog1PdeJbAcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hdiX8RxG; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fea9adf1-3c61-4213-bc84-9429bf3e82a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761697821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnDCxLRbb/ZeQwXZ8FgEr+f0AbXz70y90EJMoOKVMHs=;
	b=hdiX8RxGb2RboeKk0VMWeCaghnXKANApyvNT0I0fIoEjyZDg05i77VsME2kNXhIBlUTTr7
	YNECrdAvnVI07ow6pgQTDoawMYsDbl/7ttV89qz8pM9NwIdP0SwrjSUYPfUD3GHU7+9Id8
	CY1NaAY7ZIdHmWfUg2orAX/0vg6647w=
Date: Tue, 28 Oct 2025 17:30:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v3 0/3] net/smc: Introduce smc_hs_ctrl
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: martin.lau@linux.dev, ast@kernel.org, andrii.nakryiko@gmail.com,
 daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com, song@kernel.org,
 sdf@google.com, haoluo@google.com, yhs@fb.com, edumazet@google.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
 mjambigi@linux.ibm.com, wenjia@linux.ibm.com, wintera@linux.ibm.com,
 dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, bpf@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com,
 jaka@linux.ibm.com
References: <20250929063400.37939-1-alibuda@linux.alibaba.com>
 <20251028121531.GA51645@j66a10360.sqa.eu95>
Content-Language: en-US
In-Reply-To: <20251028121531.GA51645@j66a10360.sqa.eu95>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/28/25 5:15 AM, D. Wythe wrote:
> On Mon, Sep 29, 2025 at 02:33:57PM +0800, D. Wythe wrote:
>> This patch aims to introduce BPF injection capabilities for SMC and
>> includes a self-test to ensure code stability.
>>
>> Since the SMC protocol isn't ideal for every situation, especially
>> short-lived ones, most applications can't guarantee the absence of
>> such scenarios. Consequently, applications may need specific strategies
>> to decide whether to use SMC. For example, an application might limit SMC
>> usage to certain IP addresses or ports.
>>
>> To maintain the principle of transparent replacement, we want applications
>> to remain unaffected even if they need specific SMC strategies. In other
>> words, they should not require recompilation of their code.
>>
>> Additionally, we need to ensure the scalability of strategy implementation.
>> While using socket options or sysctl might be straightforward, it could
>> complicate future expansions.
>>
>> Fortunately, BPF addresses these concerns effectively. Users can write
>> their own strategies in eBPF to determine whether to use SMC, and they can
>> easily modify those strategies in the future.
>>
>> This is a rework of the series from [1]. Changes since [1] are limited to
>> the SMC parts:
>>
>> 1. Rename smc_ops to smc_hs_ctrl and change interface name.
>> 2. Squash SMC patches, removing standalone non-BPF hook capability.
>> 3. Fix typos
> 
> 
> Hi bpf folks,
> 
> I've noticed this patch has been pending for a while, and I wanted to
> gently check in. Is there any specific concerns or feedback regarding
> it from the BPF side? I'm keen to address any issues and move it
> forward.

The original v1 started last year. The bpf side had been responsive but 
the progress stopped for months and the smc side review had been slow 
also. I doubt how well will this be supported in the future and put this 
to the bottom of my list since then.

The set does not apply on bpf-next/net now. Please re-spin.


