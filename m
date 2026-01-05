Return-Path: <netdev+bounces-247095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4729CF4AA0
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 120AA3054B30
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387EA33D503;
	Mon,  5 Jan 2026 15:38:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EDF33B6D2
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627536; cv=none; b=Wz6mGmI2vkqxi39G6gagam7fkhUoqFe2aG/XTG0ELgXawo5dlCy50rt64ihF52hxK+JhmPDOvMrxgxLATCgIm9NCLSQp9axhXR67haTRUy4PLE5x3CsUzkxYkC3c1BU/c1SfumhOUnO2Szp31F4QlLWsuOgSDcT/RvHqDEf0whU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627536; c=relaxed/simple;
	bh=+AWMr5yudchmhyUnXyHqOneQtnKDtSXwNC5mOCacMJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MawvOWheV/ZAy85LWgdstDHAj88HZwuQGVo3rKCV/0RmI6HiavZdRgFJkba4vjlLTNISJmEUhsw2DFpZEIyBRBuZrvi3IZHZ6OJnnmVhNaNvQNSi32NIf19ySKAYRCcm6gaYRm4+J1vbHR+SYXXT7ffRnDUkggDf2TQ3Q4OpjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lja.fi; spf=pass smtp.mailfrom=lja.fi; arc=none smtp.client-ip=62.142.5.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lja.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lja.fi
Received: from mail.lja.fi (80-186-162-127.elisa-mobile.fi [80.186.162.127])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTPSA
	id a04b4d4b-ea4c-11f0-a3e7-005056bd6ce9;
	Mon, 05 Jan 2026 17:38:47 +0200 (EET)
Received: by mail.lja.fi (Postfix, from userid 120)
	id 862211609BDD2; Mon, 05 Jan 2026 17:38:47 +0200 (EET)
X-Spam-Level: 
Received: from [192.168.1.21] (vartija.sokeavartija.org [192.168.1.1])
	by mail.lja.fi (Postfix) with ESMTPSA id C01F11609BDBF;
	Mon, 05 Jan 2026 17:38:28 +0200 (EET)
Message-ID: <ad8f797b-529a-49e2-bcda-a30d0396c1a9@lja.fi>
Date: Mon, 5 Jan 2026 17:38:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] STCP: secure-by-default transport (kernel-level,
 experimental)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
References: <73757a9a-5f03-401f-b529-65c2ab6bcc13@paxsudos.fi>
 <CANiq72mE5x70dg_pvM-n3oYY0w2mWJixxmpmrjuf_4cv2Xg8OQ@mail.gmail.com>
 <ac4c2d81-b1fd-4f8f-8ad4-e5083ebc2deb@paxsudos.fi>
 <22035087-9a3f-4abb-8851-9c66e835b777@paxsudos.fi>
 <c6cdc094-6714-437b-ba37-e3e62667f4aa@paxsudos.fi>
 <aceecca9-61ae-454f-957f-875c740c0686@lja.fi>
 <20260102154957.69e86d64@kernel.org>
Content-Language: en-US
From: Lauri Jakku <lja@lja.fi>
In-Reply-To: <20260102154957.69e86d64@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Copyrighted-Material: https://paxsudos.com/

Hi All,

Jakub Kicinski kirjoitti 3.1.2026 klo 1.49:
> On Mon, 22 Dec 2025 20:13:40 +0200 Lauri Jakku wrote:
>> STCP is an experimental, TCP-like transport protocol that integrates
>> encryption and authentication directly into the transport layer, instead
>> of layering TLS on top of TCP.
>>
>> The motivation is not to replace TCP, TLS, or QUIC for general Internet
>> traffic, but to explore whether *security-by-default at the transport
>> layer* can simplify certain classes of systems—particularly embedded,
>> industrial, and controlled environments—where TLS configuration,
>> certificate management, and user-space complexity are a significant
>> operational burden.
> We tend to merge transport crypto protocol support upstream if:
>   - HW integration is needed; or
>   - some network filesystem/block device needs it.
> Otherwise user space is a better place for the implementation.

  I got Nordic Semiconductor contact, that asked if it is upcoming 
feature for kernel, the need is there (For modem use).


> .---<[ Paxsudos IT / Security Screening ]>---------------------------------------------------------------->
> | Known viruses: 3627095
> | Engine version: 1.4.3
> | Scanned directories: 0
> | Scanned files: 1
> | Infected files: 0
> | Data scanned: 0.00 MB
> | Data read: 0.00 MB (ratio 0.00:1)
> | Time: 11.383 sec (0 m 11 s)
> | Start Date: 2026:01:03 01:50:02
> | End Date:   2026:01:03 01:50:13
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
| Data read: 0.00 MB (ratio 0.00:1)
| Time: 12.740 sec (0 m 12 s)
| Start Date: 2026:01:05 17:38:31
| End Date:   2026:01:05 17:38:43
| SPAM hints: []
| SPAM hints: []
| Message not from DMARC.
`-------------------------------------------------------------------->

