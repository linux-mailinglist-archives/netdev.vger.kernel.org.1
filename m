Return-Path: <netdev+bounces-16389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877B974D092
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 10:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3061C2096F
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AD5C2FB;
	Mon, 10 Jul 2023 08:49:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BF320A
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 08:49:42 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17CBC3;
	Mon, 10 Jul 2023 01:49:40 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso54785535e9.0;
        Mon, 10 Jul 2023 01:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688978979; x=1691570979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HwV3UkEkNArn08rHfYqKJNn2/lAt35vAipu5aJAzUk=;
        b=mITH3vE8NGXs0FXSEn00pMu+nbQcrHdz5CpI06wWwORbh8Z3QjYdFOXB6kUdFzqyqg
         4DoPfxVNS7+0uPBoutk09Uyuf2koimICX7BBdHyS9O3BZOwZbRLKArPcY+IaWUQ/YwDJ
         Hq26pAta9ynsTSslEg+TET0TYF+6eOzs7Qc7/iDcfXkD5wJS/wXbJ4gEI0po0WuRVidi
         tfVY1w2EJNFBYJgjKm8cTOjRKIgvrR2DSy0E0v14kmv1QS6SmQF5usBwrkKD8lqhT619
         aK8OOho77H5w/l4dZrpLFHeY/mnhlXCIoaUGz/3RqXaiiMx1q9EVgyR1stsFPXgkxkIP
         IBVw==
X-Gm-Message-State: ABy/qLbqUkbAYss7bc9iUB3Zn7l2K+J3JMMLa14wEdPrhN5GxNC0OtDn
	9o2lNBbVTo/PUv690YgbNcQ=
X-Google-Smtp-Source: APBJJlFY7RJWgradJGfKyfSbfVLRNaXYxUZsHNesSfxwHiaBLTtgBsoFXv6KKg6hrgaK9bGTcJutAA==
X-Received: by 2002:a7b:cc15:0:b0:3fb:9ef1:34ef with SMTP id f21-20020a7bcc15000000b003fb9ef134efmr16249506wmh.37.1688978978943;
        Mon, 10 Jul 2023 01:49:38 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-008.fbsv.net. [2a03:2880:31ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c028400b003fbdf8292a7sm9614997wmk.46.2023.07.10.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 01:49:38 -0700 (PDT)
Date: Mon, 10 Jul 2023 01:49:36 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, sergey.senozhatsky@gmail.com,
	pmladek@suse.com, tj@kernel.org, stephen@networkplumber.org,
	Dave Jones <davej@codemonkey.org.uk>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] netconsole: Append kernel version to message
Message-ID: <ZKvGIGbWa751sfTA@gmail.com>
References: <20230707132911.2033870-1-leitao@debian.org>
 <20230707161050.61ec46a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707161050.61ec46a8@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 07, 2023 at 04:10:50PM -0700, Jakub Kicinski wrote:
> On Fri,  7 Jul 2023 06:29:11 -0700 Breno Leitao wrote:
> > Create a new netconsole runtime option that prepends the kernel version in
> > the netconsole message. This is useful to map kernel messages to kernel
> > version in a simple way, i.e., without checking somewhere which kernel
> > version the host that sent the message is using.
> > 
> > If this option is selected, then the "<release>," is prepended before the
> > netconsole message. This is an example of a netconsole output, with
> > release feature enabled:
> > 
> > 	6.4.0-01762-ga1ba2ffe946e;12,426,112883998,-;this is a test
> > 
> > Calvin Owens send a RFC about this problem in 2016[1], but his
> > approach was a bit more intrusive, changing the printk subsystem. This
> > approach is lighter, and just append the information in the last mile,
> > just before netconsole push the message to netpoll.
> > 
> > [1] Link: https://lore.kernel.org/all/51047c0f6e86abcb9ee13f60653b6946f8fcfc99.1463172791.git.calvinowens@fb.com/
> > 
> > Cc: Dave Jones <davej@codemonkey.org.uk>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Looks good! net-next is closed for the duration of the merge window 
> so you'll need to repost next week, and please put [PATCH net-next v3]
> as the subject prefix while at it.
> 
> > @@ -332,6 +350,11 @@ static ssize_t enabled_store(struct config_item *item,
> >  	}
> >  
> >  	if (enabled) {	/* true */
> > +		if (nt->release && !nt->extended) {
> > +			pr_err("release feature requires extended log message\n");
> > +			goto out_unlock;
> > +		}
> 
> This is the only bit that gave me pause - when parsing the command line
> you ignore release if extended is not set (with an error/warning).
> Does it make sense to be consistent and do the same thing here? 
> Or enabling at runtime is fundamentally different?

That is a good point, this patch ignores "release" if extended feature
is disabled in the command line, but, fails if "release" is set and
extended is not.

Looking at the other behaviours (netpoll parsing_ in the code, I think
the best approach is to also fail on both cases.

I'll fix it in v3.

Thanks for the review!

