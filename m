Return-Path: <netdev+bounces-220586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E062CB47071
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 16:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD97A077B5
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 14:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881981DB127;
	Sat,  6 Sep 2025 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="lCHXOKET"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8F6366;
	Sat,  6 Sep 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757169115; cv=none; b=TfCY1o8Md4MC91bWqwxP8BllMC2t2BYb6Fw0Po8fMb8VAcbY/oivqVYLgKKJ8ukNmRhoxLMqyxVnQnI0jme5On3pS46BVOC7ssAN78jrgJdh8N4LezD1rfsAuKePg/MVrGoQb/8/J0l19SOKilVE/tx2zRANi5+t7naU5mqi6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757169115; c=relaxed/simple;
	bh=nPtolzUUdlCUaSNkIVdfvaVv8xRgd3T2+hMojv5OFwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWKHZdgT5FAQLKXU3RRS5uOUV9a89JY/vbsBCydqSTcWi8OLRzCc0nXTrDewpPq3be1y5RTWQvTcp7/EledVqcMUfpiJIoZErZSzt588JoNFzqbMrbh/vDyb2roHNIlJbQ1C/oo/bdILToGEGC32rLD68vJeuQjEVsCDE5cg2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=lCHXOKET; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757169109;
	bh=nPtolzUUdlCUaSNkIVdfvaVv8xRgd3T2+hMojv5OFwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lCHXOKET/sMYecAcLRWWSOJthU2boxTzWWGDVH2KhgusrErXQsLJQNpUP6ZF9J7aD
	 60nXSmju64g/ga/0A2Qt4Q3lj/eNJcHbPwKh0X0cMDjNvdSA/asrDJozK6xgo1hPU+
	 LN2ROUhWOvA8r+xFctiFaImzVE4ByXYiK1gISPVSrkaMwB9yjc/KgTf0RckeEoT8Ur
	 6Te80cyYeluLgr78r9g6uALlZatoVsabqk7WA9D41RSZtZNuRI0YP+APAj0zEdLvBG
	 CRcd3vbpcLqW1JtFjtKZvwTlN1sd5G0tbpsH9F3MBZnZvkz9gHiLZ65j4PsV53CBLw
	 PyagK+Oy1UVFQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 367586000C;
	Sat,  6 Sep 2025 14:31:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id ED8E1200438;
	Sat, 06 Sep 2025 14:31:44 +0000 (UTC)
Message-ID: <bf530a9a-dca8-4df7-b9f2-9f2b3a1d2ce1@fiberby.net>
Date: Sat, 6 Sep 2025 14:31:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/11] tools: ynl: decode hex input
To: Jacob Keller <jacob.e.keller@intel.com>,
 Donald Hunter <donald.hunter@gmail.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-10-ast@fiberby.net> <m2h5xhxjd5.fsf@gmail.com>
 <410d69e5-d1f8-40e0-84b1-b5d56e0d9366@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <410d69e5-d1f8-40e0-84b1-b5d56e0d9366@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/25 12:27 AM, Jacob Keller wrote:
> On 9/5/2025 3:51 AM, Donald Hunter wrote:
>> Asbjørn Sloth Tønnesen <ast@fiberby.net> writes:
>>
>>> This patch add support for decoding hex input, so
>>> that binary attributes can be read through --json.
>>>
>>> Example (using future wireguard.yaml):
>>>   $ sudo ./tools/net/ynl/pyynl/cli.py --family wireguard \
>>>     --do set-device --json '{"ifindex":3,
>>>       "private-key":"2a ae 6c 35 c9 4f cf <... to 32 bytes>"}'
>>>
>>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>>
>> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
>>
>> FWIW, the hex can include spaces or not when using bytes.fromhex(). When
>> formatting hex for output, I chose to include spaces, but I don't really
>> know if that was a good choice or not.
> 
> I also prefer the spaces for readability.
I formatted it with spaces for clarity, even without spaces it was a bit
long for one line. Spaces also has the advantage that you don't have to
think about endianness.

Should we define the display hints a bit more in a .rst, or is it OK that
they end up being implementation specific for each language library? Do we
want them to behave the same in a Rust YNL library, as they do in Python?

BTW: The rest of the key used in the example can be found with this key-gen:
$ printf "hello world" | sha1sum
[redacted key material]

