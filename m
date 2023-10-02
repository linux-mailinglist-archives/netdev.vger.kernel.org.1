Return-Path: <netdev+bounces-37425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BDD7B54E0
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 16:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 74540282E15
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BAB1A261;
	Mon,  2 Oct 2023 14:23:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB018032
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 14:23:56 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96986A4
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 07:23:49 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso2334201966b.2
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 07:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696256628; x=1696861428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxH2lLJIFtW176Et97ufrR9NvKqcKgOAtljgRAcfpWs=;
        b=lLZEQW+D7gmPMZRBwFfTmFRggKpC0k0Ik7NT9zULYoKQnn5JDWDMnNjSvxNDS0Xw/U
         5+ortCtHRHPOhp3T+UTWHwSJfqe1DV2vpIDI5hhahO2+Gam7a4ayLlUkmHazEnuqXfX4
         efl9/NpI9pgoz/p+uR2cAINFb+dr8PvEv/lfkanWJmVv+PFAaAu8f767IkP/Lx5kkbJJ
         RWPsPnFWQmE/+TzC2nwkW5VbcLbJ3hjyeRkh69V2J5MvB5EO7qtiVuRPZ2TdWkhAW9DH
         ou8KKHVveA+0/STJO+0Kqg+brSxsLMzOE2p2yEyKkzmmh0DuVDWcmj6VJe3+832t6Yg9
         o9/g==
X-Gm-Message-State: AOJu0YwesOqEKfgXe9FU93c/agAeyG3zVzNWJ2qKBABmeAS6q6kqSQrA
	4igK90/17jLkwe4l78dJsUo=
X-Google-Smtp-Source: AGHT+IFcYnBxsOa3y17ItOCruaAPONFhY6Ub1fsg8iILfUeR48v1tW9KVn7OVylQFMhvVAshTPzVJg==
X-Received: by 2002:a17:907:1386:b0:9ae:6ffd:be0d with SMTP id vs6-20020a170907138600b009ae6ffdbe0dmr9419265ejb.50.1696256627588;
        Mon, 02 Oct 2023 07:23:47 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id kb22-20020a1709070f9600b009adcb6c0f0dsm17025830ejc.38.2023.10.02.07.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:23:47 -0700 (PDT)
Date: Mon, 2 Oct 2023 07:23:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Joel Becker <jlbec@evilplan.org>
Cc: hch@lst.de, netdev@vger.kernel.org
Subject: Re: configfs: Create config_item from netconsole
Message-ID: <ZRrScSauRvN8nkUs@gmail.com>
References: <ZRWRal5bW93px4km@gmail.com>
 <ZRccv2H3wK6PL5Rb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRccv2H3wK6PL5Rb@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Joel,

On Fri, Sep 29, 2023 at 11:51:43AM -0700, Joel Becker wrote:
> On Thu, Sep 28, 2023 at 07:44:58AM -0700, Breno Leitao wrote:

> > Should I create a configfs_register_item() to solve this problem?
> 
> It's an express philosophy of configfs that all lifetimes are controlled
> by userspace, which is why we don't have such a facility.  If hch wants
> to change this, I defer to his judgement.  But I don't think it is
> necessary.

I am happy the suggestion you gave, so, no need to change this
philosophy.

> In this fashion, each console created on the command line will get a
> name of `cmdline0`, `cmdline1`, etc.  They will not be part of the
> configfs tree.  If the user comes along later and says `mkdir
> /sys/kernel/config/netconsole/cmdline1`, the existing `cmdline1` console
> will be attached to the configfs tree.  The user is then free to disable
> and reconfigure the device.

I am happy with this approach.

> There would, of course, be some other corner cases to handle.  Do we
> allow dynamic names that look like command-line names if no command-line
> parameter exists? 

I'd say so, I think `cmdline` targets shouldn't be special if there are
not netconsole targets defined at boot time.


> Does `rmdir /sys/kernel/config/netconsole/cmdline0`
> actually delete the command-line console entry, or does it return
> -EBUSY?  And so on.

I've looked at the code and tested, it `cmdline0`could be removed as any
other target entry. On top of that, the user can create a new `cmdline0`
entry, and, it will be set with the default values for the attributes.

I am planning to send a patch based on what you suggested, and we can
continue the discuss there.

Thanks for the _very_ detailed feedback!
Breno

