Return-Path: <netdev+bounces-246940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B3CF2816
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81D0830021F2
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3043320A14;
	Mon,  5 Jan 2026 08:45:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9DE212549
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767602729; cv=none; b=jMmJQSKt4xzZNuUr4wiB6FXecc2xWmfcCQ9vMPXvi9o4lWGTpolyo6UFiXFYvXBhbe+XxPdjdmuJfu/kPoKY4qSm4TE8LV+meJGTWUZqKrcdWEsKsTsRzUoG3cD4C+RpK/x/hzd6HnFXCUsQauxcQsazBDzFYoQkyulySUj+qRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767602729; c=relaxed/simple;
	bh=h0J1Bz0dkD/WI8tKr4odSfVsihCZNz2sZtFpeXbWq84=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Jjitquj0DXW2oItTawguDNF65QaFzsO1q9yJNmmwFPKAMyZ9N/Oz7efx10ATunKLnfala0OYFhAQPYWgXzzGpifdglh4Vz1GRe6CvYARo/QyNWXCXucKgCPaAfFr/o/TDfpKmVJs4ON0r0Kd1du69Cywiyj6qVV82s6PHj6hom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lja.fi; spf=pass smtp.mailfrom=lja.fi; arc=none smtp.client-ip=62.142.5.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lja.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lja.fi
Received: from mail.lja.fi (80-186-162-127.elisa-mobile.fi [80.186.162.127])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTPSA
	id b6aaea98-ea12-11f0-9890-005056bdd08f;
	Mon, 05 Jan 2026 10:44:14 +0200 (EET)
Received: by mail.lja.fi (Postfix, from userid 120)
	id 0EE8716032DCA; Mon, 05 Jan 2026 10:44:13 +0200 (EET)
X-Spam-Level: 
Received: from [192.168.1.21] (kytkin.sokeavartija.org [192.168.1.1])
	by mail.lja.fi (Postfix) with ESMTPSA id EE8CD16032DBF;
	Mon, 05 Jan 2026 10:43:54 +0200 (EET)
Message-ID: <366b6d83-ed54-48aa-9bbb-8768de50c88e@lja.fi>
Date: Mon, 5 Jan 2026 10:43:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Lauri Jakku <lja@lja.fi>
Subject: Re: Totally new module addition for Linux-tree
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 netdev@vger.kernel.org
References: <1a6028aa-7865-45c4-a074-03cff86a16de@lja.fi>
 <20251218145145.25524e384a4f268bfa577862@linux-foundation.org>
 <3cb28fed-0b04-4964-89a7-38ea0bdb62e5@lja.fi>
 <CADvbK_f1BVRufm1S_iRhWuLTt19bFP1Wk+KRhd0ZBQ9k3UeYBg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADvbK_f1BVRufm1S_iRhWuLTt19bFP1Wk+KRhd0ZBQ9k3UeYBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Copyrighted-Material: https://paxsudos.com/

Hi All,

Hope this now is the right place :) .. I was wondering to get the STCP 
into Linux-tree?

--Lauri Jakku

Xin Long kirjoitti 19.12.2025 klo 19.33:
> On Fri, Dec 19, 2025 at 2:53 AM Lauri Jakku <lja@lja.fi> wrote:
>> Hi Marcelo & Lucien,
>>
>> I've developed rust-kernel module, that adds security layer over TCP
>> connection, that can be used as replacement for any TCP connection, by
>> creating socket with IPPROTO_STCP from IPPROTO_TCP.
>>
>> The module then will do elliptic handshake + payload is AES (256bit)
>> encrypted & decrypted to/from wire. The protocol users might be IoT
>> devices and such.
>>
>> I've implemented the protocol in user-space also, but the module would
>> enable anything to be secured with protocol number change => no need to
>> implement all the userspace stuff per application. The protocol uses TCP
>> as transport layer, and hooks handle the elliptic handshake + AES
>> en/decryption ...
>>
>> The module is made of C & Rust, C code is delegating hooks to Rust and
>> it would be totally new addition to Linux-tree, there is no existing
>> implementation.
>>
>> The code is now in github,
>> https://github.com/MiesSuomesta/STCP/tree/main/kernel/OOT/linux
>>
>> What do you say?
> Hi Lauri,
>
> I think Andrew mixed STCP with SCTP.
> STCP looks similar to TLS/TCP, you may check with kTLS maintainers:
>
> NETWORKING [TLS]
> M: John Fastabend <john.fastabend@gmail.com>
> M: Jakub Kicinski <kuba@kernel.org>
> M: Sabrina Dubroca <sd@queasysnail.net>
> L: netdev@vger.kernel.org
>
> Thanks.
>>
>> --Lauri J / Pori, Finland
>>
>> Andrew Morton kirjoitti 19.12.2025 klo 1.51:
>>> On Thu, 18 Dec 2025 12:41:21 +0300 Lauri Jakku <lja@lja.fi> wrote:
>>>
>>>> Hi,
>>>>
>>>> I've developed STCP (Secure TCP) protocol witch I'd like to get into
>>>> the official Linux kernel.
>>>>
>>> Thanks.
>>>
>>> I suggest you read
>>> Documentation/process/submitting-patches.rst
>>> Documentation/process/submit-checklist.rst
>>>
>>> then check the SCTP record in MAINTAINERS
>>>
>>> then send the patchset to
>>>
>>> Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>>> Xin Long <lucien.xin@gmail.com>
>>> linux-sctp@vger.kernel.org
>>> netdev@vger.kernel.org
>>>
>>> good luck!
>> .---<[ Paxsudos IT / Security Screening 
>> ]>---------------------------------------------------------------->
>> | Known viruses: 3626914
>> | Engine version: 1.4.3
>> | Scanned directories: 0
>> | Scanned files: 1
>> | Infected files: 0
>> | Data scanned: 0.00 MB
>> | Data read: 0.00 MB (ratio 1.00:1)
>> | Time: 10.845 sec (0 m 10 s)
>> | Start Date: 2025:12:19 09:53:32
>> | End Date: 2025:12:19 09:53:42
>> | SPAM hints: []
>> | SPAM hints: []
>> | Message not from DMARC.
>> `-------------------------------------------------------------------->
> .---<[ Paxsudos IT / Security Screening 
> ]>---------------------------------------------------------------->
> | Known viruses: 3626914
> | Engine version: 1.4.3
> | Scanned directories: 0
> | Scanned files: 1
> | Infected files: 0
> | Data scanned: 0.00 MB
> | Data read: 0.00 MB (ratio 1.00:1)
> | Time: 10.773 sec (0 m 10 s)
> | Start Date: 2025:12:19 18:34:09
> | End Date: 2025:12:19 18:34:20
> | SPAM hints: []
> | SPAM hints: []
> | Message not from DMARC.
> `-------------------------------------------------------------------->
.---<[ Paxsudos IT / Security Screening ]>---------------------------------------------------------------->
| Known viruses: 3627110
| Engine version: 1.4.3
| Scanned directories: 0
| Scanned files: 1
| Infected files: 0
| Data scanned: 0.00 MB
| Data read: 0.00 MB (ratio 1.00:1)
| Time: 12.995 sec (0 m 12 s)
| Start Date: 2026:01:05 10:43:55
| End Date:   2026:01:05 10:44:08
| SPAM hints: []
| SPAM hints: []
| Message not from DMARC.
`-------------------------------------------------------------------->

