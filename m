Return-Path: <netdev+bounces-34183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195BD7A2770
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7923282194
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ECF1B261;
	Fri, 15 Sep 2023 19:52:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538330D01
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 19:52:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C527211E
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694807551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HNgfdJeO076tImx6jFh9hOiFdIPM4yz7+TlZmmONbfo=;
	b=caYd3g/OTvPdRkqJGjSUOni9v8dLL1ubt/idcXL2Pgv5sQztmarzgqw9LAmU0ZRAl+T6WF
	Kyw8+9gfA3zlTzVvsxV+2GiEwlrVYWO3PXB2ymx1b4MiCBqdg4Q6ErBA40DHGMFW7B16u1
	fJw0WJ4y0JDmXv3lA2fRRZtau9WZDYM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-_L0Upw1bM1O-EgMbwCLbtA-1; Fri, 15 Sep 2023 15:52:29 -0400
X-MC-Unique: _L0Upw1bM1O-EgMbwCLbtA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so19320995e9.3
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694807547; x=1695412347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNgfdJeO076tImx6jFh9hOiFdIPM4yz7+TlZmmONbfo=;
        b=QKXjLE9YBGpzebS5W13d71sbYqsJrCprnX+Szh4sepshtqFPfoh13sh5Mt0VpnT+eI
         BtArzj6gWzo+bsr9QwJw+K5L8Q9DGdaf0gEPUAJ7k3IOm+uLZ28HrlHO0sNXCmmOcdvJ
         aZ+fqbEd3otuSyMTlGc0b406bpTcn2UAcTV2AkSrivK1ORFaT5X3XoWKP14g7e6HgRs7
         GZ8tKMt/008OqGzrMcIZKqP2Aj+mc3p+hE7AZXp2xEJi7mAyfpAocj0Y61pFoAyNBqX/
         uKsppv5O2QsIIhGEgaxU6e2ZoAKEvCyplvwlXJA5/PV7HkGrdJVjno0qHjmto5yDLZi+
         rFhQ==
X-Gm-Message-State: AOJu0YxdovBPdHsHMrEULfBkD1O7Q6h49+dKS6aNmYi9mFadHIuJaxHV
	qjysay/AlnwtXzsgVW7xu/LlOXW9IhWFc5oux2AVEcav1Ysepmj2trMJwNWeJn0WPHCH6ueluyU
	lRkvT2i3AAYM/HKj/cuy9cqkb
X-Received: by 2002:a7b:c40d:0:b0:403:bb3:28bf with SMTP id k13-20020a7bc40d000000b004030bb328bfmr2261436wmi.23.1694807547635;
        Fri, 15 Sep 2023 12:52:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmlmT0ooNTnsAwr0JuC93RZbtPuUICSBkNB34kVLhlyWNQHIW9rl6cri/YkGGKH+2LXdQkpA==
X-Received: by 2002:a7b:c40d:0:b0:403:bb3:28bf with SMTP id k13-20020a7bc40d000000b004030bb328bfmr2261420wmi.23.1694807547265;
        Fri, 15 Sep 2023 12:52:27 -0700 (PDT)
Received: from localhost ([37.163.8.26])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003ff3b964a9asm8289732wmd.39.2023.09.15.12.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:52:26 -0700 (PDT)
Date: Fri, 15 Sep 2023 21:52:22 +0200
From: Andrea Claudi <aclaudi@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux-foundation.org, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH iproute2-next 1/2] configure: add the --color option
Message-ID: <ZQS19lwZlso1AMAR@renaissance-vector>
References: <cover.1694625043.git.aclaudi@redhat.com>
 <844947000ac7744a3b40b10f9cf971fd15572195.1694625043.git.aclaudi@redhat.com>
 <20230915085912.78ffd25c@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915085912.78ffd25c@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 08:59:12AM -0700, Stephen Hemminger wrote:
> On Wed, 13 Sep 2023 19:58:25 +0200
> Andrea Claudi <aclaudi@redhat.com> wrote:
> 
> > This commit allows users/packagers to choose a default for the color
> > output feature provided by some iproute2 tools.
> > 
> > The configure script option is documented in the script itself and it is
> > pretty much self-explanatory. The default value is set to "never" to
> > avoid changes to the current ip, tc, and bridge behaviour.
> > 
> > Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
> > ---
> 
> More build time config is not the answer either.
> Don't want complaints from distribution users about the change.
> Needs to be an environment variable or config file.
>

Hi Stephen,
This is not modifying the default behaviour; as David noted color output
will be off as it is right now. If packagers want to make use of this,
it's up to them to choose a sane default for their environment. After
all, we are providing options such as '--prefix' and '--libdir', and
there are endless possibilities to choose obviously wrong values for
these vars. Packagers are gonna deal with their own choices.

I think I can improve this in two ways:

1. Exclude 'always' from the allowed color choices
This is the setting with the highest chance to produce complaints, since
it is enabling color output regardless of stdout state. 'auto' instead
produces color output only on stdout that are terminals. Of course
'always' will remain as a param choice for the command line.

2. Add packaging guidelines to README (or README.packaging)
iproute packaging is a bit tricky, since some packaging systems simply
assume that configure comes from autotools. We even leverage this to our
advantage, providing configure options that packaging systems use
flawlessly as the autotools ones. I can provide some info about this,
and add some recommendations about sane configure defaults, especially
about the --color option.

What do you think? Is this approach fine for you?


