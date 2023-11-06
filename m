Return-Path: <netdev+bounces-46184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B727E1FE7
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 12:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A471C2085A
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 11:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A0018AEF;
	Mon,  6 Nov 2023 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/f408Sv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0666E18043
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 11:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA519C433C8;
	Mon,  6 Nov 2023 11:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699269901;
	bh=vjFyA96ISKuv32u0146EL9PZKlDB08ufc7HvCrGs70E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F/f408SvPPV9zr9YBiuN9ETZhLs18QTJKK5QM2LDx+IAPd0euqC5Mcn6SODQh5ulF
	 JUIy34pFN8AsjQ4LaqTyARBmOQTBIycC63H23OIsjEvfJIDuTnCfmVdYYS3YIdax6B
	 NKHVvsvAfSjGfc01GuJLMfc95Ph+kuY6RttrvMDoZjkUljubltdBKwtnux2BnbzIxW
	 Zksdi9zPY5+k+cxLlqcwM8/AsHkPQZCuQhP04HMGMdbce3LjRJpK2H0P/4iWh12jkt
	 MaJ4SFdk1ZTo+8iX1VdmitaBqfzk7JMiGp3Q2idA+vaGySBJ6UGnM+O1kaXVE9EOd1
	 YUamhx5dwAIzw==
Message-ID: <8205a0ba-aeef-4ab6-80cc-87848903f541@kernel.org>
Date: Mon, 6 Nov 2023 12:24:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Draft net-next] docs: netdev: add section on using lei to
 manage netdev mail volume
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <20231105185014.2523447-1-dw@davidwei.uk>
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
In-Reply-To: <20231105185014.2523447-1-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

On 05/11/2023 19:50, David Wei wrote:
> As a beginner to netdev I found the volume of mail to be overwhelming. I only
> want to focus on core netdev changes and ignore most driver changes. I found a
> way to do this using lei, filtering the mailing list using lore's query
> language and writing the results into an IMAP server.

I agree that the volume of mail is too high with a variety of subjects.
That's why it is very important to CC the right people (as mentioned by
Patchwork [1] ;) )

[1]
https://patchwork.kernel.org/project/netdevbpf/patch/20231105185014.2523447-1-dw@davidwei.uk/

> This patch is an RFC draft of updating the maintainer-netdev documentation with
> this information in the hope of helping out others in the future.

Note that I'm also using lei to filter emails, e.g. to be notified when
someone sends a patch modifying this maintainer-netdev.rst file! [2]

But I don't think this issue of "busy mailing list" is specific to
netdev. It seems that "lei" is already mentioned in another part of the
doc [3]. Maybe this part can be improved? Or the netdev doc could add a
reference to the existing part?

(Maybe such info should be present elsewhere, e.g. on vger [4] or lore)

[2]
https://lore.kernel.org/netdev/?q=%28dfn%3ADocumentation%2Fnetworking%2Fnetdev-FAQ.rst+OR+dfn%3ADocumentation%2Fprocess%2Fmaintainer-netdev.rst%29+AND+rt%3A1.month.ago..
[3]
https://docs.kernel.org/maintainer/feature-and-driver-maintainers.html#mailing-list-participation
[4] http://vger.kernel.org/vger-lists.html

(Note: regarding the commit message here, each line should be limited to
max 72 chars ideally)

> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  Documentation/process/maintainer-netdev.rst | 39 +++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index 7feacc20835e..93851783de6f 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -33,6 +33,45 @@ Aside from subsystems like those mentioned above, all network-related
>  Linux development (i.e. RFC, review, comments, etc.) takes place on
>  netdev.
>  
> +Managing emails
> +~~~~~~~~~~~~~~~
> +
> +netdev is a busy mailing list with on average over 200 emails received per day,
> +which can be overwhelming to beginners. Rather than subscribing to the entire
> +list, considering using ``lei`` to only subscribe to topics that you are
> +interested in. Konstantin Ryabitsev wrote excellent tutorials on using ``lei``:
> +
> + - https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
> + - https://people.kernel.org/monsieuricon/lore-lei-part-2-now-with-imap
> +
> +As a netdev beginner, you may want to filter out driver changes and only focus
> +on core netdev changes. Try using the following query with ``lei q``::
> +
> +  lei q -o ~/Mail/netdev \
> +    -I https://lore.kernel.org/all \
> +    -t '(b:b/net/* AND tc:netdev@vger.kernel.org AND rt:2.week.ago..'

Small optimisations:

- you can remove tc:netdev@vger.kernel.org and modify the '-I' to
restrict to netdev instead of querying 'all': -I
https://lore.kernel.org/netdev/

- In theory, 'dfn:' should help you to match a filename being modified.
But in your case, 'net' is too generic, and I don't think we can specify
"starting with 'net'". You can still omit some results after [5] but the
syntax doesn't look better :)

  dfn:net AND NOT dfn:drivers/net AND NOT dfn:selftests/net AND NOT
dfn:tools/net AND rt:2.week.ago..

[5]
https://lore.kernel.org/netdev/?q=dfn%3Anet+AND+NOT+dfn%3Adrivers%2Fnet+AND+NOT+dfn%3Aselftests%2Fnet+AND+NOT+dfn%3Atools%2Fnet+AND+rt%3A2.week.ago..

> +This query will only match threads containing messages with patches that modify
> +files in ``net/*``. For more information on the query language, see:
> +
> +  https://lore.kernel.org/linux-btrfs/_/text/help/

(if this is specific to 'netdev', best to use '/netdev/', not
'/linux-btrfs/')

> +By default ``lei`` will output to a Maildir, but it also supports Mbox and IMAP
> +by adding a prefix to the output directory ``-o``. For a list of supported
> +formats and prefix strings, see:
> +
> +  https://www.mankier.com/1/lei-q

Maybe safer to point to the official doc?

https://public-inbox.org/lei-q.html

(or 'man lei-q')

> +If you would like to use IMAP, Konstantin’s blog is slightly outdated and you
> +no longer need to use here strings i.e. ``<<<`` or ``<<EOF``.

I think we can still use them. In the part 1, they are not used. Maybe
best to contact Konstantin to update his blog post instead of mentioning
in the doc that the blog post is outdated?

> You can simply
> +point lei at an IMAP server e.g. ``imaps://imap.gmail.com``::

In Konstantin's blog post, he mentioned different servers with different
specificities. Maybe easier to just point to that instead of taking one
example without more explanations?

Cheers,
Matt

