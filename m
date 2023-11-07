Return-Path: <netdev+bounces-46399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3237E3B77
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 13:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A22E6B20BA3
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3879E2DF65;
	Tue,  7 Nov 2023 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JslCy8cz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E7651;
	Tue,  7 Nov 2023 12:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93009C433C8;
	Tue,  7 Nov 2023 12:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699358779;
	bh=9zCpIoWTpAhj1sQ+zAMwyzUr5ZYSTZ2jryJqekmTKMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JslCy8czwai3/oSeaqGeDqIEHOLhSxEizrUyptdWq2EVBiOLvG8u72/M76Eq/tgg4
	 9VvD1QfEdQfe2mzJujl0rGHCb6CNv7Zn/3JVmLS2CAbF11Rb75cHa4ZVfIqzBM7bAP
	 NbL05SWZaExEOpvua+qRE2jFahwHuUg1PdHtOx9J2S42XXOasSpW6kCs2eTZ+YAXzR
	 lNhZE7E49MO46p02qsOqxcJ3Z/bOCQCctkGv8SVXgSA0Bnkiylf868/87GBtoAcSmC
	 Go2SgvxBo4cDV+dDPi9DNn+i1mLafewHjBfpp7M2FCUHJYgdD+TqFoJeyx0CJBWcXp
	 cGEmBFzDEExTA==
Message-ID: <9e07a8d5-9fc6-44e3-ba98-5235f4c21ed9@kernel.org>
Date: Tue, 7 Nov 2023 13:06:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Draft net-next] docs: netdev: add section on using lei to
 manage netdev mail volume
Content-Language: en-GB, fr-BE
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net
Cc: netdev@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, pabeni@redhat.com, corbet@lwn.net,
 edumazet@google.com
References: <20231105185014.2523447-1-dw@davidwei.uk>
 <8205a0ba-aeef-4ab6-80cc-87848903f541@kernel.org>
 <9ee972b4-b3ff-4201-b22e-c76080cb8f6e@davidwei.uk>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
In-Reply-To: <9ee972b4-b3ff-4201-b22e-c76080cb8f6e@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

On 06/11/2023 17:57, David Wei wrote:
> On 2023-11-06 03:24, Matthieu Baerts wrote:
>> On 05/11/2023 19:50, David Wei wrote:
>>> As a beginner to netdev I found the volume of mail to be overwhelming. I only
>>> want to focus on core netdev changes and ignore most driver changes. I found a
>>> way to do this using lei, filtering the mailing list using lore's query
>>> language and writing the results into an IMAP server.
>>
>> I agree that the volume of mail is too high with a variety of subjects.
>> That's why it is very important to CC the right people (as mentioned by
>> Patchwork [1] ;) )
>>
>> [1]
>> https://patchwork.kernel.org/project/netdevbpf/patch/20231105185014.2523447-1-dw@davidwei.uk/
> 
> Sorry and noted, I've now CC'd maintainers mentioned by Patchwork.

Thanks!

>>> This patch is an RFC draft of updating the maintainer-netdev documentation with
>>> this information in the hope of helping out others in the future.
>>
>> Note that I'm also using lei to filter emails, e.g. to be notified when
>> someone sends a patch modifying this maintainer-netdev.rst file! [2]
>>
>> But I don't think this issue of "busy mailing list" is specific to
>> netdev. It seems that "lei" is already mentioned in another part of the
>> doc [3]. Maybe this part can be improved? Or the netdev doc could add a
>> reference to the existing part?
> 
> I think "busy mailing list" is especially bad for netdev. There are many
> tutorials for setting up lei, but my ideal goal is a copy + paste
> command specifically for netdev that outputs into an IMAP server for
> beginners to use. As opposed to writing something more generic.

I see. I don't know if many people are in this case, but having this
example will certainly help people adapting it to their case!

>> (Maybe such info should be present elsewhere, e.g. on vger [4] or lore)
>>
>> [2]
>> https://lore.kernel.org/netdev/?q=%28dfn%3ADocumentation%2Fnetworking%2Fnetdev-FAQ.rst+OR+dfn%3ADocumentation%2Fprocess%2Fmaintainer-netdev.rst%29+AND+rt%3A1.month.ago..
>> [3]
>> https://docs.kernel.org/maintainer/feature-and-driver-maintainers.html#mailing-list-participation
> 
> This document is aimed at kernel maintainers. My concern is that
> beginners would not find or read this document.

Indeed.

>> [4] http://vger.kernel.org/vger-lists.html
> 
> It would be nice to add a link in the netdev list "Info" section. Do you
> know how to update it?

No, sorry. Maybe Jakub or DaveM can help?

> How about keeping a netdev specific sample lei query in
> maintainer-netdev and refer to it from [4]?

Fine by me, but best to check with Netdev maintainers :)

(...)

> It would be ideal if we could express dfn:^net/*. I contacted the public
> inbox folks and they said it is not supported :(

Thank you for having asked them and Konstantin. That's a shame we cannot
use regex. Maybe later.

Cheers,
Matt

