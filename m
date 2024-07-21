Return-Path: <netdev+bounces-112316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DC1938479
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 13:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15F5281283
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 11:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60970374D3;
	Sun, 21 Jul 2024 11:46:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29378F70
	for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721562399; cv=none; b=XORvY7gqVQvzqTpZYAlb2ZVojdjGDtisi6RMITYP6nsdmorkoOYxccVTzwfAlXbAAX7FsFLV0OTSUMGAfbTJj8j/XoPrcVmr0x1zRhPVZnd0bBww/iL18e1Ck8xVhrZ3QagiQvW6zj53YhZO3khZ4QGjGYaXxeiPBIrQ8MQaihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721562399; c=relaxed/simple;
	bh=rIOLOuehTgdbRsyNqfbrDuMTUbofv710LhMRG7U5xOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hhl8t2/pVOSz5adn4xQUUxEEOBqk2CfuEa+ILb4PtvHt43jdiCxBVt7LiVvOvGL/W394WNuh4LXs0KQlKNRlLkVmsArgTUnUTKEm/gBmTXgLKsueVkL+IoxK72V8FUj6UE6qvYhwa0S1fBjIb7S1t1fiSWWiphhLhUL9MBbSL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427b9fca517so3024475e9.2
        for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 04:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721562396; x=1722167196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fy7JqxvWubOU8G8nGkj9K3+kqwvFSWwcrQL4bVFXx7E=;
        b=ncSt1Wy48RK7mQyIdEWyfpAMjV8ANAnFs4VOBY4B7kk7mIJeKp/HDRGGkNPKVabzTW
         1ou+KestvcrkzRuNDXpVeb7U6QSqUf4uukb+qJpCL+kyNOF4b6qBqclGCa1JqeCmKm8q
         jQLS1cRsF91yjCd/0xuFFN458zvFPzWr5gcEjwJuv3X+ube+CYQPfNH5RcuKs1EASMCQ
         3OPVVq+igydwwNrBFk93nODB5AX9+YazqUbIVA3EGLbJyFU9Hztb7sk15LNlUP4d5BC2
         cP86c6KhJoDIrlxqOVdbmH6dxR1gQKFRbVWjsYV5qGoktw0F/v90n8JZYtlCMLtfj439
         Q1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb1cs9Rldc5n2xHKiJI3S9keFBbvrtAC6vE7lwK9/ZDsI6QHvslzrgTjiTaFr6ol5ihWVoSp7tQGuEmsfy7YjwRYqKfg/7
X-Gm-Message-State: AOJu0Ywxe3nItstNu9NQCFAycde15h7Fy8X78L6AP+KtWtTvSw57qSU8
	xn/CrZnNgm7fSEMfmaOj5XK6Rc1wwJdmHIoP6Z3d2arEzlXa8HO3
X-Google-Smtp-Source: AGHT+IE5xljxunFIi2ZqzXnsvLdLkYefFxKNqo79di4PSeVHH0w3UBqicVNITDEB+3OIkp8E85S4cA==
X-Received: by 2002:a05:600c:5108:b0:427:9f6f:4914 with SMTP id 5b1f17b1804b1-427daa727dfmr21714175e9.6.1721562395844;
        Sun, 21 Jul 2024 04:46:35 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43598sm115863455e9.1.2024.07.21.04.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:46:35 -0700 (PDT)
Message-ID: <7846613b-f7c7-430e-a453-e0023a1f5667@grimberg.me>
Date: Sun, 21 Jul 2024 14:46:34 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme-tcp: reduce callback lock contention
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240716073616.84417-1-hare@kernel.org>
 <20240716073616.84417-7-hare@kernel.org>
 <9b8b57ca-83ae-43a4-84c6-33017dc81a32@grimberg.me>
 <a5473f69-5404-4c38-85d9-ca91c5160361@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a5473f69-5404-4c38-85d9-ca91c5160361@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 18/07/2024 9:42, Hannes Reinecke wrote:
> On 7/17/24 23:19, Sagi Grimberg wrote:
>>
>>
>> On 16/07/2024 10:36, Hannes Reinecke wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> We have heavily queued tx and rx flows, so callbacks might happen
>>> at the same time. As the callbacks influence the state machine we
>>> really should remove contention here to not impact I/O performance.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>> ---
>>>   drivers/nvme/host/tcp.c | 14 ++++++++------
>>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index a758fbb3f9bb..9634c16d7bc0 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -1153,28 +1153,28 @@ static void nvme_tcp_data_ready(struct sock 
>>> *sk)
>>>       trace_sk_data_ready(sk);
>>> -    read_lock_bh(&sk->sk_callback_lock);
>>> -    queue = sk->sk_user_data;
>>> +    rcu_read_lock();
>>> +    queue = rcu_dereference_sk_user_data(sk);
>>>       if (likely(queue && queue->rd_enabled) &&
>>>           !test_bit(NVME_TCP_Q_POLLING, &queue->flags)) {
>>>           queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>>           queue->data_ready_cnt++;
>>>       }
>>> -    read_unlock_bh(&sk->sk_callback_lock);
>>> +    rcu_read_unlock();
>>
>> Umm, this looks dangerous...
>>
>> Please give a concrete (numeric) justification for this change, and 
>> preferably a big fat comment
>> on why it is safe to do (for either .data_ready or .write_space).
>>
>> Is there any precedence of another tcp ulp that does this? I'd like 
>> to have the netdev folks review this change. CC'ing netdev.
>>
> Reasoning here is that the queue itself (and with that, the workqueue
> element) will _not_ be deleted once we set 'sk_user_data' to NULL.
>
> The shutdown sequence is:
>
>         kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>         nvme_tcp_restore_sock_ops(queue);
>         cancel_work_sync(&queue->io_work);
>
> So first we're shutting down the socket (which cancels all I/O
> calls in io_work), then restore the socket callbacks.
> As these are rcu protected I'm calling synchronize_rcu() to
> ensure all callbacks have left the rcu-critical section on
> exit.
> At a final step we are cancelling all work, ie ensuring that
> any action triggered by the callbacks have completed.
>
> But sure, comment is fine.

I suggest that you audit all the accessors of this lock in the 
networking subsystem
before determining that it can be safely converted to rcu read critical 
section. I suspect that
the underlying network stack assumes that this lock is taken when the 
callback is invoked.

$ grep -rIn sk_callback_lock net/ | wc -l
122
$ grep -rIn sk_callback_lock kernel/  | wc -l
15

