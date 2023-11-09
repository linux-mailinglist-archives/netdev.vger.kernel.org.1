Return-Path: <netdev+bounces-46867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900EA7E6D2F
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06171C204F6
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF730200C0;
	Thu,  9 Nov 2023 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491A13AEA;
	Thu,  9 Nov 2023 15:20:14 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B3630DC;
	Thu,  9 Nov 2023 07:20:14 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9dbb3e0ff65so159861866b.1;
        Thu, 09 Nov 2023 07:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543213; x=1700148013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16xlYBLszwqQlQAbY7x5clf2OicB8Tm47V0ZYIRvObw=;
        b=Bt8Arq1yzm091vxMINet3UjAJaCh+mz+sOaH1Ik/g/rMHLk0l7V6zA1GPpx5WijND1
         zDiQEYjIhWGVzHy46nW8PzemZqnziCHxzSNd0f+6BeZhfnI05qUPRo8hfxC7Y16ImYLX
         M1RhjzerlwEnMlW7It9vY/uwNhZeZFFjiYiQcX2MMzAHc/2onTk1+v+bk6UXxdRa3YCW
         1S17lL9ubhpTbAp7zK/n7aDsawuZVkKBqH6VqeaBjhq6zMAgsTqRRCresgqc1JT48SFs
         KUh4jH9JvAJZf401OgR4R8e+V7MLozl8DJSwT+FUUHboxSkOqhHPNWdd0VHUWef9sTmm
         qbVg==
X-Gm-Message-State: AOJu0YzMavkwWrOeRButxNVflTuTKRJGq7moB74N+e2uu00XxYvZfcNo
	dFbIXEA3hU5EFXG/lrN9+Oc=
X-Google-Smtp-Source: AGHT+IHlY76Ts3s6PL1LrK0jDV09wT/lYvdvAjudKX29kqcxIfZBRgEI6Lm70RvVy2w++83q4ztAxg==
X-Received: by 2002:a17:907:6ea4:b0:9de:c702:3f59 with SMTP id sh36-20020a1709076ea400b009dec7023f59mr4496854ejc.33.1699543212522;
        Thu, 09 Nov 2023 07:20:12 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-012.fbsv.net. [2a03:2880:31ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id i17-20020a170906251100b009b2b47cd757sm2626495ejb.9.2023.11.09.07.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:20:12 -0800 (PST)
Date: Thu, 9 Nov 2023 07:20:10 -0800
From: Breno Leitao <leitao@debian.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [PATCH] Documentation: Document the Netlink spec
Message-ID: <ZUz4qkeMkazCUFKx@gmail.com>
References: <20231103135622.250314-1-leitao@debian.org>
 <875y2cxa6n.fsf@meer.lwn.net>
 <m2h6lvmasi.fsf@gmail.com>
 <87r0kzuiax.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0kzuiax.fsf@meer.lwn.net>

On Thu, Nov 09, 2023 at 07:12:38AM -0700, Jonathan Corbet wrote:
> Donald Hunter <donald.hunter@gmail.com> writes:
> 
> > Jonathan Corbet <corbet@lwn.net> writes:
> >> I do have to wonder, though, whether a sphinx extension is the right way
> >> to solve this problem.  You're essentially implementing a filter that
> >> turns one YAML file into one RST file; might it be better to keep that
> >> outside of sphinx as a standalone script, invoked by the Makefile?
> >>
> >> Note that I'm asking because I wonder, I'm not saying I would block an
> >> extension-based implementation.
> >
> > +1 to this. The .rst generation can then be easily tested independently
> > of the doc build and the stub files could be avoided.
> >
> > Just a note that last year you offered the opposite guidance:
> >
> > https://lore.kernel.org/linux-doc/87tu4zsfse.fsf@meer.lwn.net/
> 
> Heh ... I totally forgot about that whole discussion ...
> 
> > If the preference now is for standalone scripts invoked by the Makefile
> > then this previous patch might be useful:
> >
> > https://lore.kernel.org/linux-doc/20220922115257.99815-2-donald.hunter@gmail.com/
> >
> > It would be good to document the preferred approach to this kind of doc
> > extension and I'd be happy to contribute an 'Extensions' section for
> > contributing.rst in the doc-guide.
> 
> I think it will vary depending on what we're trying to do, and I think
> we're still working it out - part of why I expressed some uncertainty
> this time around.
> 
> For something like the kernel-doc or automarkup, where we are modifying
> existing documents, an extension is the only way to go.  In this case,
> where we are creating new RST files from whole cloth, it's not so clear
> to me.  My feeling (this week at least ;) is that doing it as an
> extension makes things more complicated without a lot of benefit.

One way or another works for me. Given my experience with both ways, let
me share the advantages of boths so we can understand the trade-offs
better:

Sphinx extension advantages:
===========================

 1) Keep "extensions" uniform and organized, written in the same
 framework/language (python), using the same enry point, output, etc.

 2) Easy to cross reference objects in the whole documentation (not done
 in this patchset)

 3) Same dependencies for all "documentation". I.e, you don't need a
 dependency (as in python pip requirements.txt) for every "parser"
 script.

 4) Already being used in our infrastructure.


One-off parser advantages:
=========================

 1) Total flexibility. You can write the parser in any language.

 2) Easier and faster to interate and debug.

 3) No need to have a rst stub for every file (as in this patchset).
 This is a sphinx limitation right now, and *might* go away in the
 future.

 4) Less dependent of sphinx project.

> FWIW, if something like this is done as a makefile change, I'd do it a
> bit differently than your linked patch above.  Rather than replicate the
> command through the file, I'd just add a new target:
> 
>   netlink_specs:
>   	.../scripts/gen-netlink-rst
> 
>   htmldocs: netlink_specs
>   	existing stuff here
> 
> But that's a detail.

For that, we can't use a sphinx extension, since there is no way (as I
understood) from one rst to generate multiple rst.

