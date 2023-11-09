Return-Path: <netdev+bounces-46863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086D7E6C3E
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 15:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819941C20940
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 14:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438E1E52E;
	Thu,  9 Nov 2023 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RCQPyMxB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AE31E530;
	Thu,  9 Nov 2023 14:12:39 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453562D75;
	Thu,  9 Nov 2023 06:12:39 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C48D52C1;
	Thu,  9 Nov 2023 14:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C48D52C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1699539159; bh=8kev2//0PzKZ/xSG/Y0mE6h/RdMVt+9LuCt1xXu5iDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RCQPyMxBH4vnMDMhEznJ7OJVwNrup4SoWpRSOVXYIn+/N/he7cwTy9amIWYC0SH5c
	 AMUK57YCDp0lrT8+boCVA+pXBwJ+UlIshKxC7U/yhCX32+SdCpVw80ZASqbVRVgeko
	 2scQrp0JGkBAAskrD6ZMjwACzo6yW9Qw5UvrsBLbEMWy6mQf7lxl8ayZK9SlfpBJQA
	 R5WgIdHQMbPkm2T8amYTMlyQXW9XLeKyGa5nb2nPpv9eiJJ8JP5l5jpET6w2x9Vg9s
	 PxJKUtPLeDOtA2h7REZUB+ffU/KPxhJvUWI0NlD86iPvZ+ZqKGCV+5I30KrINsd9Kp
	 4JUf+9Wm8DVuQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com
Subject: Re: [PATCH] Documentation: Document the Netlink spec
In-Reply-To: <m2h6lvmasi.fsf@gmail.com>
References: <20231103135622.250314-1-leitao@debian.org>
 <875y2cxa6n.fsf@meer.lwn.net> <m2h6lvmasi.fsf@gmail.com>
Date: Thu, 09 Nov 2023 07:12:38 -0700
Message-ID: <87r0kzuiax.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Donald Hunter <donald.hunter@gmail.com> writes:

> Jonathan Corbet <corbet@lwn.net> writes:
>> I do have to wonder, though, whether a sphinx extension is the right way
>> to solve this problem.  You're essentially implementing a filter that
>> turns one YAML file into one RST file; might it be better to keep that
>> outside of sphinx as a standalone script, invoked by the Makefile?
>>
>> Note that I'm asking because I wonder, I'm not saying I would block an
>> extension-based implementation.
>
> +1 to this. The .rst generation can then be easily tested independently
> of the doc build and the stub files could be avoided.
>
> Just a note that last year you offered the opposite guidance:
>
> https://lore.kernel.org/linux-doc/87tu4zsfse.fsf@meer.lwn.net/

Heh ... I totally forgot about that whole discussion ...

> If the preference now is for standalone scripts invoked by the Makefile
> then this previous patch might be useful:
>
> https://lore.kernel.org/linux-doc/20220922115257.99815-2-donald.hunter@gmail.com/
>
> It would be good to document the preferred approach to this kind of doc
> extension and I'd be happy to contribute an 'Extensions' section for
> contributing.rst in the doc-guide.

I think it will vary depending on what we're trying to do, and I think
we're still working it out - part of why I expressed some uncertainty
this time around.

For something like the kernel-doc or automarkup, where we are modifying
existing documents, an extension is the only way to go.  In this case,
where we are creating new RST files from whole cloth, it's not so clear
to me.  My feeling (this week at least ;) is that doing it as an
extension makes things more complicated without a lot of benefit.

FWIW, if something like this is done as a makefile change, I'd do it a
bit differently than your linked patch above.  Rather than replicate the
command through the file, I'd just add a new target:

  netlink_specs:
  	.../scripts/gen-netlink-rst

  htmldocs: netlink_specs
  	existing stuff here

But that's a detail.

Thanks,

jon

