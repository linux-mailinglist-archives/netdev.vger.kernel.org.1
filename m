Return-Path: <netdev+bounces-46231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A4B7E2A7E
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 17:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52751C20C22
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B722941E;
	Mon,  6 Nov 2023 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="okLAZE14"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7729CE1
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 16:57:20 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41A4C0
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 08:57:18 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc0e78ec92so30134915ad.3
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 08:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1699289838; x=1699894638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAtu3+SFzwI9m4YrirdXu7GL4DTW+zbFpK/FdXlvvTM=;
        b=okLAZE14Q17zvqYCXVvx1dSJC6m0z7c37uMiiQw5rHgjqfEfbOx708/hJnHzQIBwC8
         fuD9eyj3kOwBcpDeN42DYyQWfZRuy/dmBeyMM2P4SlNPlpzEuxNfYypLmDlLuEZLs02A
         0SPErTGLVU2Pwvqqt0QHBAB2jDFmbWaWTl8ZuAa3VNNn780n+HHEBYioV2l4TLBlIAPP
         64DNmQCIFDJ3WL9jTCVSIMEpqdTer24pc6gPaL+h9ePD2Vzr8qX6Zp68IQDCDPhmGacn
         RDAKRoomzIn6Rj17aXrqPmBP4eicLZn/UTwZ155kg2txCcPGKT0JbO9+JLUJrns6lmry
         o5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289838; x=1699894638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAtu3+SFzwI9m4YrirdXu7GL4DTW+zbFpK/FdXlvvTM=;
        b=SMRoGNWaBgwNT63CaF8P+x8OZBaUA1wKkQWP1KomhI71Wlj3wwzL31yWBFOxK1zdZQ
         ua9oJD6UJ1Hbq7zIwlgrecLw64LJOGFdw0L5ojQ+LD2J+dJl7GECzm+InRKGuUea5AsO
         lfQqxfefITjqV66quKJU6j422YKlhkU5p6o2XAmGMTOyQi4/gkC/Ajqgj9A47LvdZpIO
         KHA8BoSuL+TZZq/OfaJf6JLIrnSQXbYFLvyVrkNNPaXrjMBNLDLbByGCVS+AUXchJKkZ
         Pb6Qr0UCF3Q5jKprSoHJkqtyO2TtOHovYIBUFhJtHOnpN1m2Z8evX7MuaBEnwkM3BZLj
         Z5+A==
X-Gm-Message-State: AOJu0YzL3qW3/5MpOmbKL4IwoCFX43/T9nKRyRMv3TePlPnNS6Spw3Vx
	VKtt9L151ZFdI3G0nF6M+QCWMA==
X-Google-Smtp-Source: AGHT+IHtAosg/LkVtTBD2+bok4iEa94l++tqcHBvY/TX+5grNORG+M8J7zu3HhDUry5UXuPwJwM/mA==
X-Received: by 2002:a17:902:cf46:b0:1cc:6cc3:d9ba with SMTP id e6-20020a170902cf4600b001cc6cc3d9bamr13895878plg.4.1699289838227;
        Mon, 06 Nov 2023 08:57:18 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::7:3f3c])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ee8600b001c0a4146961sm6139074pld.19.2023.11.06.08.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 08:57:17 -0800 (PST)
Message-ID: <9ee972b4-b3ff-4201-b22e-c76080cb8f6e@davidwei.uk>
Date: Mon, 6 Nov 2023 08:57:15 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Draft net-next] docs: netdev: add section on using lei to
 manage netdev mail volume
Content-Language: en-GB
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, pabeni@redhat.com,
 davem@davemloft.net, corbet@lwn.net, edumazet@google.com
References: <20231105185014.2523447-1-dw@davidwei.uk>
 <8205a0ba-aeef-4ab6-80cc-87848903f541@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <8205a0ba-aeef-4ab6-80cc-87848903f541@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023-11-06 03:24, Matthieu Baerts wrote:
> Hi David,
> 
> On 05/11/2023 19:50, David Wei wrote:
>> As a beginner to netdev I found the volume of mail to be overwhelming. I only
>> want to focus on core netdev changes and ignore most driver changes. I found a
>> way to do this using lei, filtering the mailing list using lore's query
>> language and writing the results into an IMAP server.
> 
> I agree that the volume of mail is too high with a variety of subjects.
> That's why it is very important to CC the right people (as mentioned by
> Patchwork [1] ;) )
> 
> [1]
> https://patchwork.kernel.org/project/netdevbpf/patch/20231105185014.2523447-1-dw@davidwei.uk/

Sorry and noted, I've now CC'd maintainers mentioned by Patchwork.

> 
>> This patch is an RFC draft of updating the maintainer-netdev documentation with
>> this information in the hope of helping out others in the future.
> 
> Note that I'm also using lei to filter emails, e.g. to be notified when
> someone sends a patch modifying this maintainer-netdev.rst file! [2]
> 
> But I don't think this issue of "busy mailing list" is specific to
> netdev. It seems that "lei" is already mentioned in another part of the
> doc [3]. Maybe this part can be improved? Or the netdev doc could add a
> reference to the existing part?

I think "busy mailing list" is especially bad for netdev. There are many
tutorials for setting up lei, but my ideal goal is a copy + paste
command specifically for netdev that outputs into an IMAP server for
beginners to use. As opposed to writing something more generic.

> 
> (Maybe such info should be present elsewhere, e.g. on vger [4] or lore)
> 
> [2]
> https://lore.kernel.org/netdev/?q=%28dfn%3ADocumentation%2Fnetworking%2Fnetdev-FAQ.rst+OR+dfn%3ADocumentation%2Fprocess%2Fmaintainer-netdev.rst%29+AND+rt%3A1.month.ago..
> [3]
> https://docs.kernel.org/maintainer/feature-and-driver-maintainers.html#mailing-list-participation

This document is aimed at kernel maintainers. My concern is that
beginners would not find or read this document.

> [4] http://vger.kernel.org/vger-lists.html

It would be nice to add a link in the netdev list "Info" section. Do you
know how to update it?

How about keeping a netdev specific sample lei query in
maintainer-netdev and refer to it from [4]?

> 
> (Note: regarding the commit message here, each line should be limited to
> max 72 chars ideally)

Apologies, I may not have line wrap set up properly in my editor.

> 
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  Documentation/process/maintainer-netdev.rst | 39 +++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
>> index 7feacc20835e..93851783de6f 100644
>> --- a/Documentation/process/maintainer-netdev.rst
>> +++ b/Documentation/process/maintainer-netdev.rst
>> @@ -33,6 +33,45 @@ Aside from subsystems like those mentioned above, all network-related
>>  Linux development (i.e. RFC, review, comments, etc.) takes place on
>>  netdev.
>>  
>> +Managing emails
>> +~~~~~~~~~~~~~~~
>> +
>> +netdev is a busy mailing list with on average over 200 emails received per day,
>> +which can be overwhelming to beginners. Rather than subscribing to the entire
>> +list, considering using ``lei`` to only subscribe to topics that you are
>> +interested in. Konstantin Ryabitsev wrote excellent tutorials on using ``lei``:
>> +
>> + - https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
>> + - https://people.kernel.org/monsieuricon/lore-lei-part-2-now-with-imap
>> +
>> +As a netdev beginner, you may want to filter out driver changes and only focus
>> +on core netdev changes. Try using the following query with ``lei q``::
>> +
>> +  lei q -o ~/Mail/netdev \
>> +    -I https://lore.kernel.org/all \
>> +    -t '(b:b/net/* AND tc:netdev@vger.kernel.org AND rt:2.week.ago..'
> 
> Small optimisations:
> 
> - you can remove tc:netdev@vger.kernel.org and modify the '-I' to
> restrict to netdev instead of querying 'all': -I
> https://lore.kernel.org/netdev/

Thank you, this is great.

> 
> - In theory, 'dfn:' should help you to match a filename being modified.
> But in your case, 'net' is too generic, and I don't think we can specify
> "starting with 'net'". You can still omit some results after [5] but the
> syntax doesn't look better :)
> 
>   dfn:net AND NOT dfn:drivers/net AND NOT dfn:selftests/net AND NOT
> dfn:tools/net AND rt:2.week.ago..

I initially went with this as well, but found it tedious to add many AND
NOT statements. My metric was number of emails filtered and matching
using b:b/net/* produced the least number of emails :)

It would be ideal if we could express dfn:^net/*. I contacted the public
inbox folks and they said it is not supported :(

> 
> [5]
> https://lore.kernel.org/netdev/?q=dfn%3Anet+AND+NOT+dfn%3Adrivers%2Fnet+AND+NOT+dfn%3Aselftests%2Fnet+AND+NOT+dfn%3Atools%2Fnet+AND+rt%3A2.week.ago..
> 
>> +This query will only match threads containing messages with patches that modify
>> +files in ``net/*``. For more information on the query language, see:
>> +
>> +  https://lore.kernel.org/linux-btrfs/_/text/help/
> 
> (if this is specific to 'netdev', best to use '/netdev/', not
> '/linux-btrfs/')

Thank you, will fix this.

> 
>> +By default ``lei`` will output to a Maildir, but it also supports Mbox and IMAP
>> +by adding a prefix to the output directory ``-o``. For a list of supported
>> +formats and prefix strings, see:
>> +
>> +  https://www.mankier.com/1/lei-q
> 
> Maybe safer to point to the official doc?
> 
> https://public-inbox.org/lei-q.html
> 
> (or 'man lei-q')

Thanks, official manpages are best.

> 
>> +If you would like to use IMAP, Konstantin’s blog is slightly outdated and you
>> +no longer need to use here strings i.e. ``<<<`` or ``<<EOF``.
> 
> I think we can still use them. In the part 1, they are not used. Maybe
> best to contact Konstantin to update his blog post instead of mentioning
> in the doc that the blog post is outdated?

You're right, I've emailed Konstantin.

> 
>> You can simply
>> +point lei at an IMAP server e.g. ``imaps://imap.gmail.com``::
> 
> In Konstantin's blog post, he mentioned different servers with different
> specificities. Maybe easier to just point to that instead of taking one
> example without more explanations?

Will do!

> 
> Cheers,
> Matt

