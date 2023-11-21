Return-Path: <netdev+bounces-49609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD427F2B90
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A0AB21905
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 11:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80910482FC;
	Tue, 21 Nov 2023 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEED59C;
	Tue, 21 Nov 2023 03:17:57 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-548c548c40aso3392981a12.0;
        Tue, 21 Nov 2023 03:17:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700565476; x=1701170276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbfqKc92HY0GWFqXRpFHBsFHHapn1hVDYmvSnYYYEf8=;
        b=d0qEiUJTMvQW/UJT/2zkzoCmPmfHFBMxhQTArfwM2LMEKekB/74f7LSpe1VKwJTofV
         Ytg+L/gBsjTitDVzu4gexkaXmdIwsNv8e5ykA8zsQ4ehVTBbc02DjxTZO0onp80GVHWO
         Qmz7sylSec4aUM/EaoynrhvFQdLFNLLMZgYv9ZAiuJDJL9v3GfyKwPH84OJofUqmKl/Y
         jgHnukadimn+GUbQPJ1N4D0M5NYm4wkobz88yOeheYi/WwHUPTmyhSgY/ifDZz7MaLSo
         8XZ5rfLCnuKSmBuJrjRDBSKoPegwps79dlZygKRu1qYzbH27Y9VbsAK9MgxmAIT0ReVN
         Qsqg==
X-Gm-Message-State: AOJu0YzeWksLlP5nZ2j5Kgiqk6UbDAs23Zb4AqXBdEuBTqkv7krRyZjR
	dN8mWZaHYJSRuLDI3szJY5w=
X-Google-Smtp-Source: AGHT+IGr0PX24+7zBlFIcy4+Pn/Zyyc2ZNMrEAnivGbRyFXWuPFOWQpwnVs7Zx+OkT8QHsVS+XEONA==
X-Received: by 2002:a17:906:3c17:b0:9ad:8a9e:23ee with SMTP id h23-20020a1709063c1700b009ad8a9e23eemr2121676ejg.13.1700565475979;
        Tue, 21 Nov 2023 03:17:55 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-016.fbsv.net. [2a03:2880:31ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id i9-20020a170906250900b009ca522853ecsm5110945ejb.58.2023.11.21.03.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:17:55 -0800 (PST)
Date: Tue, 21 Nov 2023 03:17:53 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: leit@meta.com, Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	donald.hunter@gmail.com, linux-doc@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Document each netlink family
Message-ID: <ZVyR4dcndNMtLRvb@gmail.com>
References: <20231113202936.242308-1-leitao@debian.org>
 <87y1ew6n4x.fsf@meer.lwn.net>
 <20231117163939.2de33e83@kernel.org>
 <ZVu5rq1SdloY41nH@gmail.com>
 <20231120120706.40766380@kernel.org>
 <ZVvE36Sq1LD++Eb9@gmail.com>
 <20231120131424.18187f0e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120131424.18187f0e@kernel.org>

On Mon, Nov 20, 2023 at 01:14:24PM -0800, Jakub Kicinski wrote:
> On Mon, 20 Nov 2023 12:43:11 -0800 Breno Leitao wrote:
> > > %.rst: $(YNL_YAML_DIR)/%.yaml
> > > 	$(YNL_TOOL) -i $< -o $@  
> > 
> > That is basically what it does now in the current implementation, but,
> > you don't need to pass the full path and no output file, since it knows
> > where to get the file and where to save it to.
> > 
> > If you are curious about the current python script, I've pushed it here:
> > https://github.com/leitao/linux/blob/netdev_discuss/tools/net/ynl/ynl-gen-rst.py
> > 
> > I can easily remove the paths inside the python file and only keep it in
> > the Makefile, so, we can use -i $< and -o $@.
> 
> I think switching to -i / -o with full paths and removing the paths
> from the generator is worthwhile.
> 
> We'll need to call the generator for another place sooner or later.

I do agree with you. Let me update and send a V3 with these changes.

