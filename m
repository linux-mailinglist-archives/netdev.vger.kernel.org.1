Return-Path: <netdev+bounces-206268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D61B0263A
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 23:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B747B8C0A
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30BC1C6FFE;
	Fri, 11 Jul 2025 21:15:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8141228C86
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752268515; cv=none; b=Dx2YE5rHJyaYwA/bkWgzMpe09bllZrfQIklgFPTTDFl+eP+9045bS/gbUbkGEDklhw1JS9f8e7dBfECu8j/XAHUSar/6+jm6nG/O/i6PWY4sNeAD9sVEEnTWoy05uJ8F+D6H+F5bWsHKOwLlfb4y4hczkv9b3+9mICP8qQBaF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752268515; c=relaxed/simple;
	bh=V696mK9LLUdJLQKBhHRvVREJm7ibhC4PMOO4Q2QWkbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiW3eyjngBYvAaXZNQMUz3mz4hTxRf09s+bgeqtDXHL7kVnx4Pb7y321yXb7c8PGHM39x5MakzA68mtLC9utgndmiJQXNSoDSwp2u/mgwFh80T0DXqezbuBN8S/zWXMt7rB5Pc+ynG5shACWQzckgv30VlT/IBPzqL7ZgwUjggg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af13e.dynamic.kabel-deutschland.de [95.90.241.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5176561E64841;
	Fri, 11 Jul 2025 23:14:51 +0200 (CEST)
Message-ID: <acc5fe70-ecb4-404c-9439-ff3181118983@molgen.mpg.de>
Date: Fri, 11 Jul 2025 23:14:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net 0/5] idpf: replace Tx flow
 scheduling buffer ring with buffer pool
To: Brian Vazquez <brianvv@google.com>
Cc: Joshua A Hay <joshua.a.hay@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
References: <20250625161156.338777-1-joshua.a.hay@intel.com>
 <c4f80a35-c92b-4989-8c63-6289463a170c@molgen.mpg.de>
 <DM4PR11MB65024CB6CF4ED7302FDB9D58D446A@DM4PR11MB6502.namprd11.prod.outlook.com>
 <c6444d15-bc20-41a8-9230-9bb266cb2ac6@molgen.mpg.de>
 <yhluj2ljtv4qoq65zfqoagwdwshokfmzylf52numl26skxqfp4@k3dm7jrimuis>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <yhluj2ljtv4qoq65zfqoagwdwshokfmzylf52numl26skxqfp4@k3dm7jrimuis>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Brian,


Thank you for your reply.

Am 07.07.25 um 16:43 schrieb Brian Vazquez:
> O Mon, Jun 30, 2025 at 06:22:11PM +0200, Paul Menzel wrote:

>> Am 30.06.25 um 18:08 schrieb Hay, Joshua A:
>>
>>>> Am 25.06.25 um 18:11 schrieb Joshua Hay:
>>>>> This series fixes a stability issue in the flow scheduling Tx send/clean
>>>>> path that results in a Tx timeout.
>>>>>
>>>>> The existing guardrails in the Tx path were not sufficient to prevent
>>>>> the driver from reusing completion tags that were still in flight (held
>>>>> by the HW).  This collision would cause the driver to erroneously clean
>>>>> the wrong packet thus leaving the descriptor ring in a bad state.
>>>>>
>>>>> The main point of this refactor is replace the flow scheduling buffer
>>>>
>>>> … to replace …?
>>>
>>> Thanks, will fix in v2
>>>
>>>>> ring with a large pool/array of buffers.  The completion tag then simply
>>>>> is the index into this array.  The driver tracks the free tags and pulls
>>>>> the next free one from a refillq.  The cleaning routines simply use the
>>>>> completion tag from the completion descriptor to index into the array to
>>>>> quickly find the buffers to clean.
>>>>>
>>>>> All of the code to support the refactor is added first to ensure traffic
>>>>> still passes with each patch.  The final patch then removes all of the
>>>>> obsolete stashing code.
>>>>
>>>> Do you have reproducers for the issue?
>>>
>>> This issue cannot be reproduced without the customer specific device
>>> configuration, but it can impact any traffic once in place.
>>
>> Interesting. Then it’d be great if you could describe that setup in more
>> detail.

> The hardware can process packets and return completions out of order;
> this depends on HW configuration that is difficult to replicate.
> 
> To match completions with packets, each packet with pending completions
> must be associated to a unique ID.  The previous code would occasionally
> reassigned the same ID to multiple pending packets, resulting in
> resource leaks and eventually panics.

Thank you for describing the problem again. Too bad it’s not easily 
reproducible.

> The new code uses a much simpler data structure to assign IDs that
> is immune to duplicate assignment, and also much more efficient at
> runtime.

Maybe that could be added to the commit message too. How can the 
efficiency claim be verified?

>>>>> Joshua Hay (5):
>>>>>      idpf: add support for Tx refillqs in flow scheduling mode
>>>>>      idpf: improve when to set RE bit logic
>>>>>      idpf: replace flow scheduling buffer ring with buffer pool
>>>>>      idpf: stop Tx if there are insufficient buffer resources
>>>>>      idpf: remove obsolete stashing code
>>>>>
>>>>>     .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   6 +-
>>>>>     drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 626 ++++++------------
>>>>>     drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  76 +--
>>>>>     3 files changed, 239 insertions(+), 469 deletions(-)

Kind regards,

Paul

