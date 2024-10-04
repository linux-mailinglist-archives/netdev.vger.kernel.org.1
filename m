Return-Path: <netdev+bounces-132039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887D89903AF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49661282497
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B7320FAA7;
	Fri,  4 Oct 2024 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dIDy1U+L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA871581E0;
	Fri,  4 Oct 2024 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047818; cv=none; b=dKmbRnvON9iun3wW3aHw0KdOFubbbLED0WzFXOgDalfi5/XNL5uHEjHpNP5GpzIN8Xk/zOZz8k/OsG23q9v3y4CmQyA+eBHqN/jO1gLmWpZSOVP6Wxexot7D6Cz2Tc12SpUinBV1gu8IABcpcTaSbiMPO0vVAC2KlQBOmhtpO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047818; c=relaxed/simple;
	bh=8PSo2DIypTXDb/TKuaNwWxyZQeUAK6b2eKsf8YBpur8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIjJOO1zM7DvnPl/2WrKm89vVWWs/hWB7ldHQabbnbA5Gg2C8Wbr3ASgX+2Mn25vh9jl1Y5KC+uLqP48TbXXexd9Zar3BHzLSbDMiUfpwZdz8NRiYzqwiVXInHMHMMr30U8Yj66fsHNC4qXdpQ9j6cj3uZ02BRriC04YlWpwgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dIDy1U+L; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id wi9ksLfHdWgzbwi9kshUS6; Fri, 04 Oct 2024 15:15:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728047741;
	bh=nRWH9XpiDQTzL94CS1nb47ffVIXOhin5jmNHlLBiMic=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=dIDy1U+L/vYne/XH2vKiOD1wJhQ4KCqzffTGciZsdwVuTqjFxzzPHq+q6boDldrIc
	 JGQcLctsMbQqJod7l/hN3Lhns43PuEQTS9NqUoGMjui6VoEgWWUYRjDXT6uzWzer8E
	 SzH5NZrNOt8a5hBnYPi0Vu+RZq+XQqVFLiAfPERTq1Mkt5e5POm61rvTcMX/YY7ykf
	 ZB+fP0C+2qCUtZUCTu22dJgA1TmEV+/pYWPLPxUEbE6HOjDMcZwiQQJ26fFn6Am/Ur
	 5qqz2YP3ooG2XQZcmvRudtfYGoJxx2XTgEqk5o1FcKinpL/Iv0cXaILcSGpmg7gvpC
	 tUBM4tmCjIsCA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 04 Oct 2024 15:15:41 +0200
X-ME-IP: 90.11.132.44
Message-ID: <2669052d-752f-416a-9d5e-a03848f30904@wanadoo.fr>
Date: Fri, 4 Oct 2024 15:15:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: adi: adin1110: Fix some error handling
 path in adin1110_read_fifo()
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Lennart Franzen <lennart@lfdomain.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org
References: <8ff73b40f50d8fa994a454911b66adebce8da266.1727981562.git.christophe.jaillet@wanadoo.fr>
 <20241004113735.GF1310185@kernel.org>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241004113735.GF1310185@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/10/2024 à 13:37, Simon Horman a écrit :
> On Thu, Oct 03, 2024 at 08:53:15PM +0200, Christophe JAILLET wrote:
>> If 'frame_size' is too small or if 'round_len' is an error code, it is
>> likely that an error code should be returned to the caller.
>>
>> Actually, 'ret' is likely to be 0, so if one of these sanity checks fails,
>> 'success' is returned.
> 
> Hi Christophe,
> 
> I think we can say "'ret' will be 0".

Agreed.

	ret = adin1110_read_reg()
	--> spi_sync_transfer()
	--> spi_sync()

which explicitly documents "zero on success, else a negative error code."

> At least that is what my brief investigation tells me.
> 
>>
>> Return -EINVAL instead.
> 

If the patch is considered as correct, can you confirm that -EINVAL is 
the correct error code to use? If not, which one would be preferred?


> Please include some information on how this was found and tested.
> e.g.
> 
> Found by inspection / Found using widget-ng.

I would say: found by luck! :)

The explanation below will be of no help in the commit message and won't 
be added. I just give you all the gory details because you asked for it ;-)

(and after reading bellow, you can call me crazy!)



I was looking at functions that propagate error codes as their last 
argument. The idea came after submitting [1].

I read cci_read() and wondered if functions with such a semantic could 
use an un-initialized last argument. In such a case, this function could 
not behave as expected if the initial value of "err" was not 0.

So I wrote the following coccinelle script and several other variations.


// Options: --include-headers

@ok@
identifier fct, err;
type T;
@@

	int fct(..., T *err)
	{
		...
	}

@test depends on ok@
identifier x, fct = ok.fct;
expression res;
type T = ok.T;
@@

*	T x;
	...
(
	fct(..., &x);
|
	res = fct(..., &x);
)

(For the record, I have not found any issue with it...)


BUT, adin1110_read_fifo() was spotted because of the prototype of 
adin1110_read_reg().

When I reviewed the code, I quickly saw that it was a false positive and 
that using "type T" in my script was not that logical...

Anyway, when reviewing the code, I saw:

	if (ret < 0)
		return ret;

	/* The read frame size includes the extra 2 bytes
	 * from the  ADIN1110 frame header.
	 */
	if (frame_size < ADIN1110_FRAME_HEADER_LEN + ADIN1110_FEC_LEN)
		return ret;

	round_len = adin1110_round_len(frame_size);
	if (round_len < 0)
		return ret;

which looks really strange and likely broken...

Then I sent the patch we are talking about!


(yes some real people really search such things and write such 
coccinelle scripts, and now you can call me crazy)


[1]: 
https://lore.kernel.org/all/666ac169157f0af1c2e1d47926b68870cb39d587.1727977974.git.christophe.jaillet@wanadoo.fr/

> Compile tested only.

As a "speculative" patch, it was only compile tested, you are correct.

> 
>>
>> Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This patch is speculative.
>> If returning 0 is what was intended, then an explicit 0 would be better.
> 
> In my brief investigation I see that adin1110_read_fifo()
> is only called by adin1110_read_frames(), like this:
> 
> 	while (budget) {
> 		...
> 
> 		ret = adin1110_read_fifo(port_priv);
> 		if (ret < 0)
> 			return;
> 
> 		budget--;
> 	}
> 
> So the question becomes, should a failure in reading the fifo,
> because of an invalid frame size, be treated as an error
> and terminate reading frames.
> 
> Like you, I speculate the answer is yes.
> But I think we need a bit more certainty to take this patch.

I won't be of any help here.

I can just say that "it looks strange" and is "certainly" bogus, but 
won't be able the prove it nor test it.


I'll wait a bit before sending a v2. If confirming this point is a 
requirement for accepting the patch, there is no need to urge for a v2 
if no-one cares about answering your point.

CJ


> 


