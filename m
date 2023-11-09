Return-Path: <netdev+bounces-46924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76A87E7165
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 19:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C5CB20CA2
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613861DDCB;
	Thu,  9 Nov 2023 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA79347C9;
	Thu,  9 Nov 2023 18:28:08 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269363C03;
	Thu,  9 Nov 2023 10:28:08 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso191457466b.1;
        Thu, 09 Nov 2023 10:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699554486; x=1700159286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drCAL7MfPLvti2xnDPj/kIqoT3VUikkThA9jieXOVFI=;
        b=X4tkMelhdO9L7g86xOIF+sgL7/Pv6T7ulC98SuHACbMBrrfS0j/Jrw9yQIH9BAN4fK
         iFdqiavHronGAFN8mdlW1FPD5zGcgUa+l2E7tnut8gvEyB5uA2Cuz7Y++/3vXeuf6R62
         sAIpkrESdPpqxaQFkssAPlKW5zB2REjlFgb1gycPRgdf5cP2BD5Q0DDqSEJ9rYYBfVbK
         JINhsJHzujqCr3SAx/MOignEeujx0WkLaQ2oqfJoSQAXoyi6hISFyyhdwEmoRbEGPGvA
         9rE5VFgqABaczcKwE2qErP3mlk8hADf3NahcUuUwwf2vzpJQ7ouXKdtw+fimrOvW8f8F
         E6cA==
X-Gm-Message-State: AOJu0Yz+xEQXlEDmOw0wFWlr6c4S4KTHWi8uh0s/zZnFkfBuLNgWVpJC
	QNzW5O827vmJktTN3ENuxWpTixZxbM7IYQ==
X-Google-Smtp-Source: AGHT+IEP/9Msgj4tIj0/AA6iEsWNtNIXetDgQl3YXOjIS1u00dcEqWMjTNrPThLP2GXcb3djtFgD6w==
X-Received: by 2002:a17:907:7f04:b0:9c5:64b5:45cc with SMTP id qf4-20020a1709077f0400b009c564b545ccmr5237040ejc.14.1699554486346;
        Thu, 09 Nov 2023 10:28:06 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id s3-20020a1709067b8300b009adc77fe164sm2875248ejo.66.2023.11.09.10.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:28:05 -0800 (PST)
Date: Thu, 9 Nov 2023 10:28:04 -0800
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH] Documentation: Document the Netlink spec
Message-ID: <ZU0ktGJNbqTwjS3Q@gmail.com>
References: <20231103135622.250314-1-leitao@debian.org>
 <m2y1f8mjex.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2y1f8mjex.fsf@gmail.com>

On Wed, Nov 08, 2023 at 02:03:34PM +0000, Donald Hunter wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> > This is a Sphinx extension that parses the Netlink YAML spec files
> > (Documentation/netlink/specs/), and generates a rst file to be
> > displayed into Documentation pages.
> >
> > Create a new Documentation/networking/netlink_spec page, and a sub-page
> > for each Netlink spec that needs to be documented, such as ethtool,
> > devlink, netdev, etc.
> >
> > Create a Sphinx directive extension that reads the YAML spec
> > (located under Documentation/netlink/specs), parses it and returns a RST
> > string that is inserted where the Sphinx directive was called.
> 
> This is great! Looks like I need to fill in some missing docs in the
> specs I have contributed.
> 
> I wonder if the generated .rst content can be adjusted to improve the
> resulting HTML.
> 
> There are a couple of places where paragraph text is indented and I
> don't think it needs to be, e.g. the 'Summary' doc.
> 
> A lot of the .rst content seems to be over-indented which causes
> blockquote tags to be generated in the HTML. That combined with a
> mixture of bullets and definition lists at the same indentation level
> seems to produce HTML with inconsistent indentation.
> 
> I quickly hacked the diff below to see if it would improve the HTML
> rendering. I think the HTML has fewer odd constructs and the indentation
> seems better to my eye. My main aim was to ensure that for a given
> section, each indentation level uses the same construct, whether it be a
> definition list or a bullet list.

Thanks for the diff. That makes total sense and I will integrate it  in
the updated version.

> It would be great to generate links from e.g. an attribute-set to its
> definition.
> 
> Did you intentionally leave out the protocol values?

Yes. This could be done in a follow up patch if necessary.
> 
> It looks like parse_entries will need to be extended to include the type
> information for struct members, similar to how attribute sets are shown.
> I'd be happy to look at this as a follow up patch, unless you get there
> first. 

Awesome. That would be appreciate.

