Return-Path: <netdev+bounces-91532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3178B2F93
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 06:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE1B1C2278F
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 04:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F52E139D1A;
	Fri, 26 Apr 2024 04:55:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A8B763F0
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 04:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714107343; cv=none; b=cJc58ADcKzHA+uT1W/MfkJfRCtd9DoLbsldJrdcTfO5VgWS6EMV2z4fSWXIhz+xFMHgJy03t63a7q3eQMFeDr7caboWDPEAOKWeWdxy6oGkGFnmZVO14noA5Xbdw5eM1VeaReMi3d8iH9KAtqhtyNT8NoiGgfFuIwT7sJ6loAb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714107343; c=relaxed/simple;
	bh=iFPsd2THMndpOYaDq7ZumxjsnmWlTYQhZl01gl4Txhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RR7zlcwstNdlYizV7vwugmWgSXtiTbJp6Tfl4kRchmNHJASZAS0RZltMtyLbvVuovMANiaq1ZOXjUNshAO70Wtc7vFrNVfwamA28LOaqALWyYbkK+q3wJxZo6jME3wUNbr0aQ9IaZEHiXG5R9lRGJK48oy8fmPQmqu2SBb0n2Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8CxCurJMytmGUwDAA--.1703S3;
	Fri, 26 Apr 2024 12:55:37 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxQ1bGMytmjecFAA--.2411S3;
	Fri, 26 Apr 2024 12:55:35 +0800 (CST)
Message-ID: <21325271-95bc-41b9-8f9e-53b744369e79@loongson.cn>
Date: Fri, 26 Apr 2024 12:55:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 00/15] stmmac: Add Loongson platform support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <go6zgo5mxqscourw567e756tngt3xpbrnuqsid4av2luu4zkfm@h6xjnlosexwi>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <go6zgo5mxqscourw567e756tngt3xpbrnuqsid4av2luu4zkfm@h6xjnlosexwi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxQ1bGMytmjecFAA--.2411S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuF48Xw4rCw43ZrWxCF48uFX_yoW5Gryxpr
	WkKw12kr4kJw12kw1xua10vFyrCr1fJ3yrJr9xGryjv398Ww1I9r48Ka1Yva1DCr9a9w4Y
	qw42qrn5uF4rZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

Hi Serge,

在 2024/4/25 21:19, Serge Semin 写道:
>> v12:
>> * The biggest change is the re-splitting of patches.
>> * Add a "gmac_version" in loongson_data, then we only
>>    read it once in the _probe().
>> * Drop Serge's patch.
>> * Rebase to the latest code state.
>> * Fixed the gnet commit message.
> V11 review hasn't finished yet. You posted a question to me just four
> hours ago, waited for an answer a tiny bit and decided to submit v12.
> Really, what the rush for? Do you expect the reviewer to react in an
> instant?

I'm sorry. It's my fault.


I did this because I didn't want to repeat the v8 process, we talked 
about v8 for

two months, after I collected all the comments and changed the code, a 
lot of

changes happened, and I seemed to misunderstand the comments about patch

splitting, which made v9-v11 look bad.


v12 is actually still based on v8, but it's just resplit the patches 
again, maybe

it's easier to review,

>
> Please understand, the review process isn't a quick-road process. The
> most of the maintainers and reviewers have their own jobs and can't
> react just at the moment you want it or need it. It's better to

Yes, I quite agree with you. In fact, we have been working together 
happily for

almost a year. I appreciate your patience. With your help, this patch 
set has

gotten better and better since the beginning.

> collect all the review comments, wait for all questions being answered
> (ping the person you need if you waited long enough) and resubmit the

Yes, I understand, because I also do some kernel document translation in my

spare time, and I understand this very well.

> series with all the notes taken into account. Needlessly rushing and
> spamming out the maintainers inboxes with your series containing just
> a part of the requested changes, won't help you much but will likely
> irritate the reviewers.
Ok, I will reduce the frequency of my emails unless all comments are 
clearly answered.
>
> What do you expect me to do now? Move on with v11 review? Copy my
> questions to v12 and continue the discussion here? By not waiting for
> all the discussions done you made the my life harder. What was the
> point? Sigh...

v11 is not much different from v12, except that it removes your patch 
and then

resplits the patch, which improves the review efficiency to some extent.


loongson_dwmac_config_multi_msi() is the only comment left that didn't 
end in

v11. I originally wanted to include this question in the cover letter of 
v12, but I

did send it in a hurry and lost it. I'm sorry about that, let me copy 
this question

to v12.


Thanks,

Yanteng



