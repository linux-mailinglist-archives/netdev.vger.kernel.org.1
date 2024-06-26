Return-Path: <netdev+bounces-107073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B6F919B1F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 01:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CB71C21640
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 23:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5384B194124;
	Wed, 26 Jun 2024 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZLAy5u49"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD47F6;
	Wed, 26 Jun 2024 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443890; cv=none; b=YIgk1/8d1/Y/Sz+6a17+D+2pz02ioh6eeoq2MHdt3474SoCHlxdQSP26AfLgz4GvhB0ZpJvjlGUHEnCSa12tMdIKyZdPlBJDtfbB29Lg/YcoKiUqJWzo1ci/WY3WlwJ07lR8DpBuLEXpE4+i7gFvdFb93lQm/DghEKMOk+jXiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443890; c=relaxed/simple;
	bh=6HekR43pJqUCcNkKc40b69Drnr3HJInw6fCbjRstiaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ycge9SA+21YqkZrWAU/G8Sb6Tf6f4Lltwyaa9vNOKtReDqXDOzdVpuqEVSsPtTBkXO5TFJR/kFFzd+zQJnbrawkm+63nQD0vHXXoczJ7KBt9KyHE7BU5rX6GRPHcZYxlJ2efDLNu91LoF5xcjKyiRLlSci9k7njiGnakZYZkO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZLAy5u49; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=fIdipLCiB6LuGEB/Bu1DIt/EU3UFGy5WyDBALrOlYbo=; b=ZLAy5u49NXHY03W49GkzU5gN+3
	ZQUBwEtX9Fz6SxX2/8vMQc3gTO3hnUiemG8OTHh1g292YW06vglD3yEFLBPwvCj1qFWrK2XYdN1rY
	J9zzj+cQ9knuA+Gw0mmC4gzc1MB4fn63hEVB1KgF3XF+X1Gszrk5pRdyiFjJu+lO2xvAIOJIWvlIs
	RbZm7v0e/S1kUUzmuIK2TmEi7gD6RNIPKXrIOOCDYwku0WH2WXFvBARlcJXkq86xjLo9WU5+SYESm
	ng16i34vBst48tr0maT02s9N9RjeBkNVnMQXJp8JAqQ/7bxX6xwdwzopjlQBzRq7F3hoTT7EUzXIZ
	hEqZnjFA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMbtn-00000008baK-1YaN;
	Wed, 26 Jun 2024 23:17:59 +0000
Message-ID: <4709c2fa-081f-4307-bc9e-eef928255c08@infradead.org>
Date: Wed, 26 Jun 2024 16:17:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Documentation: best practices for using Link
 trailers
To: Jonathan Corbet <corbet@lwn.net>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87cyo3fgcb.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/24 4:13 PM, Jonathan Corbet wrote:
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
> 
>> On Fri, Jun 21, 2024 at 02:07:44PM GMT, Kees Cook wrote:
>>> On Wed, Jun 19, 2024 at 02:24:07PM -0400, Konstantin Ryabitsev wrote:
>>>> +   This URL should be used when referring to relevant mailing list
>>>> +   topics, related patch sets, or other notable discussion threads.
>>>> +   A convenient way to associate ``Link:`` trailers with the commit
>>>> +   message is to use markdown-like bracketed notation, for example::
>>>> ...
>>>> +     Link: https://lore.kernel.org/some-msgid@here # [1]
>>>> +     Link: https://bugzilla.example.org/bug/12345  # [2]
>>>
>>> Why are we adding the extra "# " characters? The vast majority of
>>> existing Link tags don't do this:
>>
>> That's just convention. In general, the hash separates the trailer from the
>> comment:
>>
>>     Trailer-name: actual-trailer-body # comment
>>
> 
> Did we ever come to a conclusion on this?  This one character seems to
> be the main source of disagreement in this series, I'm wondering if I
> should just apply it and let the painting continue thereafter...?

We have used '#' for ages for adding comments to by: tags.
I'm surprised that it's not documented.

-- 
~Randy

