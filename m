Return-Path: <netdev+bounces-107111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D251919E23
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 06:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC5E1C22263
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 04:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB0117C6A;
	Thu, 27 Jun 2024 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xq/ZSuCj"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438191864C;
	Thu, 27 Jun 2024 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719462311; cv=none; b=cDUjoognnfY0JBrGh1PVxr8GBWvGRt7byKBhCYaTmuUpjHw2YZvZVacSocDoBBsbpkE4sLVAfZuHa3Sgm/C2CdqlP+6ra4HvZx/ejdIVQKtcZc4NUrq308ruLAmXOCkSmCKhgDwu0FtySrwA7DkCmQynPeM0JB23RDDU8sGbDQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719462311; c=relaxed/simple;
	bh=juCSA/JEQdCInY0INwcmkXUwA1/C8FVRgHJ6wrrJoWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDHrGjzizdbK9bUEshMtTTHTzylrcaZRzFZXlf0+6u6Ojj1xj7YLoeLtgZevMDyt9u5n1QaXxnkgGt3l50nkh29wKuT7oqtcylYA+Dl3QJQc1QHAyJ2iV6ysdwoesnYDy5nmOu/GlyGOBRT4Fmq7YY3HCjzzCZF4ldEsTGrA7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xq/ZSuCj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Eq/tnOV8FvjvD57ahIklGr8d03YiQ6JNh+uUQrkfJcM=; b=xq/ZSuCj+0LVtZcWuz1W+dB0r2
	tSwrzg8WI39OjOWKrOOdQXRSS+Nt6FX6Jqc3KOXiWER7wBrADyiwG2+ABhMmlbiG3j7ESpzBFLIh3
	T8QvHpdbk+F1J02stpJgAO5F1ZJmQMfT9sEhP1olQM0QZ/botfsTKche+Olhup/hR1TWm6OiMwIXv
	eo95VF2QnFB9TELQh805/xIHMZvXQWu0IfenZrah99iY67SfvJYyQW2pfywdHAFj0MM3LKnNNe3TB
	K+tOrBfhATgn2/I1N1PobStdOBU7yw88DLpR7xN4Bj2TAOW52EkH9n2F1ke6K+2q8EI/MLESUum+1
	5J206szg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMggr-00000009Aec-38lI;
	Thu, 27 Jun 2024 04:25:03 +0000
Message-ID: <4090f208-766d-40b2-b64e-f0f700845258@infradead.org>
Date: Wed, 26 Jun 2024 21:24:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Documentation: best practices for using Link
 trailers
To: Thorsten Leemhuis <linux@leemhuis.info>, Jonathan Corbet
 <corbet@lwn.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Kees Cook <kees@kernel.org>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ksummit@lists.linux.dev
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
 <20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org>
 <202406211355.4AF91C2@keescook>
 <20240621-amorphous-topaz-cormorant-cc2ddb@lemur>
 <87cyo3fgcb.fsf@trenco.lwn.net>
 <4709c2fa-081f-4307-bc9e-eef928255c08@infradead.org>
 <62647fab-b3d4-48ac-af4c-78c655dcff26@leemhuis.info>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <62647fab-b3d4-48ac-af4c-78c655dcff26@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/24 8:51 PM, Thorsten Leemhuis wrote:
> On 27.06.24 01:17, Randy Dunlap wrote:
>> On 6/26/24 4:13 PM, Jonathan Corbet wrote:
>>> Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
>>>> On Fri, Jun 21, 2024 at 02:07:44PM GMT, Kees Cook wrote:
>>>>> On Wed, Jun 19, 2024 at 02:24:07PM -0400, Konstantin Ryabitsev wrote:
>>>>>> +   This URL should be used when referring to relevant mailing list
>>>>>> +   topics, related patch sets, or other notable discussion threads.
>>>>>> +   A convenient way to associate ``Link:`` trailers with the commit
>>>>>> +   message is to use markdown-like bracketed notation, for example::
>>>>>> ...
>>>>>> +     Link: https://lore.kernel.org/some-msgid@here # [1]
>>>>>> +     Link: https://bugzilla.example.org/bug/12345  # [2]
>>>>>
>>>>> Why are we adding the extra "# " characters? The vast majority of
>>>>> existing Link tags don't do this:
>>>>
>>>> That's just convention. In general, the hash separates the trailer from the
>>>> comment:
>>>>
>>>>     Trailer-name: actual-trailer-body # comment
>>>
>>> Did we ever come to a conclusion on this?  This one character seems to
>>> be the main source of disagreement in this series, I'm wondering if I
>>> should just apply it and let the painting continue thereafter...?
>>
>> We have used '#' for ages for adding comments to by: tags.
>> I'm surprised that it's not documented.
> 
> I thought it was documented, but either I was wrong or can't find it.
> But I found process/5.Posting.rst, which provides this example:
> 
>         Link: https://example.com/somewhere.html  optional-other-stuff
> 
> So no "# " there. So to avoid inconsistencies I guess this should not be
> applied, unless that document is changed as well.

In my use cases, other-optional-stuff begins with '#'.


-- 
~Randy

