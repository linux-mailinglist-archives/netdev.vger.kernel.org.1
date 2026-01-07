Return-Path: <netdev+bounces-247809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3F1CFED26
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 17:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D28E3300AC4D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B935E33468C;
	Wed,  7 Jan 2026 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M99Ftjyi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G8vU6iBr"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE48932AAA4;
	Wed,  7 Jan 2026 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801046; cv=none; b=JHvxRAklRNs1hczfmVHFjYBf26m3l/0ViCsjJi+/Xh5lm9WwV2Gt3p3aQRVtwFTSb574RXbdTPYgFMlub5W0FV/gcMQKHJAiGonc5DXRojVdB/r1BfKQh91+D3KoIx1hMV4FlFQSuf+r4jafVRMIrxnQcx1GZsvnjcv5GgnqiXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801046; c=relaxed/simple;
	bh=RUJXvBKgnBa2BvDzolVyJr4BB5nXdL3G8r5M9Sf/fLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bs4A4YOtNh/OAKa3SMs8S+WQceII4rsFKjDaQgkJb7UCSuSLYH+1ui/4qOHOJfvWZ27GqMguDy1IczrxA9HZHIslXa0EEHqIlrw6unu28Vrh+mrr+3SDo91b6jB/CbCrGpmH2x0ySS79XIqYDh0aWZtvUEa20fVwjWW+/gnv/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M99Ftjyi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G8vU6iBr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767801042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Rm/7Yl4bpOaIPKVVo5GHbdqhgHWVg68x5xjBPiNLTk=;
	b=M99FtjyibaQzmBBjBmYtoBMMbUpcKn/9hKJCnkgU9NvSqVqFfBfX+8WXhRl8ykjViYvXdV
	mbFfhGXsO0gWKFj3hwYtcz8NYAblHrQCJPORVJjFWRDTApdqdi+iBqA2ysbYIHQk+CxErv
	NzGHYCnTp9boTZnn3484lT5Wm0KH1bya/1G4cItNvb1jLmjoMfbt5IB71/mym1/EvtcbaG
	jYDbcxpJ1rzB8ytKK9JmBfza85dOyuJLBhelgQeD4s2fsaA1/cUerLZ2mQzdijrY6BGCVc
	tOzQo0oJOHb5BDnlDc7NJluRlE2PhU6emabaZkuOZ/CeMTE/mlthtlurTWv0dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767801042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Rm/7Yl4bpOaIPKVVo5GHbdqhgHWVg68x5xjBPiNLTk=;
	b=G8vU6iBreXFwoK0G2p/YlLJCLfaFVcBw1A7hJXrQLXhqPSLTt0bjbDaSdmVSwl+Kift8GS
	oEYXQtbOfznUM1Cg==
To: Breno Leitao <leitao@debian.org>, pmladek@suse.com, mpdesouza@suse.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com,
 calvin@wbinvd.org, jv@jvosburgh.net, kernel-team@meta.com, Petr Mladek
 <pmladek@suse.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
In-Reply-To: <5mpei32y7sl5jmi2ciim4crxbc55zztiucxxsdd633mvzxlk7n@fowtsefym5y6>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
 <5mpei32y7sl5jmi2ciim4crxbc55zztiucxxsdd633mvzxlk7n@fowtsefym5y6>
Date: Wed, 07 Jan 2026 16:56:41 +0106
Message-ID: <87zf6pfmlq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Breno,

On 2026-01-07, Breno Leitao <leitao@debian.org> wrote:
> On Mon, Dec 22, 2025 at 06:52:09AM -0800, Breno Leitao wrote:
>> This series adds support for the nbcon (new buffer console) infrastructure
>> to netconsole, enabling lock-free, priority-based console operations that
>> are safer in crash scenarios.
>
> I've been reflecting further on this port and encountered a potential
> roadblock that I'd like to discuss to ensure I'm heading in the right
> direction.
>
> Netconsole appends additional data (sysdata) to messages, specifically
> the CPU and task_struct->comm fields.
>
> Basically, it appends current->comm and raw_smp_processor_id()
> when sending a message.
> (For more details, see sysdata_append_cpu_nr() and
> sysdata_append_taskname())

I was not aware of this netconsole feature until now.

> With nbcon, since netconsole will operate on a separate thread, this
> sysdata may become inaccurate (the data would reflect the printk thread
> rather than the original task or CPU that generated the message).

Note that even with legacy consoles there was never a guarantee that the
printing context is the same CPU/task as the printk() caller. It was
just much more likely.

> Upon reviewing the printk subsystem, I noticed that struct
> printk_info->caller_id stores similar information, but not exactly the
> same. It contains either the CPU *or* the task, not both, and this data
> isn't easily accessible from within the ->write_thread() context. 
>
> One possible solution that comes to my mind is to pass both the CPU ID
> and the task_struct/vpid to struct printk_info, and then integrate this
> into struct nbcon_write_context *wctxt somehow.
>
> This way, netconsole could reliably query the original CPU and task that
> generated the message, regardless of where the netconsole code is
> executed.

But by the time the printer is active, that task may no longer exist,
may have migrated to a different CPU and/or may be sleeping.

IIUC, basically you want to attach console-specific additional
information to ringbuffer records, but only that specific console should
see/use the additional information. In this case it could be up to 4+16
additional bytes (depending on @sysdata_fields).

A while ago we had a discussion[0] about adding custom
information. There I even went so far as to suggest supporting things
like a new boot argument:

    printk.format=ts,cpu,comm,pid,in_atomic

(which could also be console-specific)

The result of the discussion was killing off dictionaries (that allowed
variable length custom data) and replacing them with the dev_printk_info
struct.

I am just pointing out that this kind of discussion has existed in the
past and not suggesting that we should reintroduce dictionaries.


A simple fix could be to add an extra 36-byte struct to both
dev_printk_info and nbcon_write_context that exists conditionally on
CONFIG_NETCONSOLE_DYNAMIC.

vprintk_store() would set the extra data to dev_printk_info.

nbcon_emit_next_record() would copy the data to nbcon_write_context.

John Ogness

[0] https://lore.kernel.org/lkml/20200904082438.20707-1-changki.kim@samsung.com

