Return-Path: <netdev+bounces-28119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462D77E476
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327721C210E1
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51D12B95;
	Wed, 16 Aug 2023 15:00:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12C10957
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:00:30 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113B2272D
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:00:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68874269df4so1156619b3a.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692198004; x=1692802804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zv9Vk5jQr2IfT7BdkJ5wITslmnfO7Niuhi2RQ//Q/uI=;
        b=dVyBON4GqQLQTBztdkhw0VGqjV8RHTS/Ys1rVHs36yVWX9/PYvIj8ZfuiJP445Gxgf
         2pN42vj3R8CXXtPJPP6my7iMN7SaDqH0m99MG0wEhgR7hE8WD3gnAuB8vWZOw8JxGXsx
         mqaNKSOTBXl1s22SD6QoTOLRKMxPOMHe0kb3Eeloxr4V6kh4KRQIR0/TqWOeu8CqkvZD
         2eC7xLImtLCCjFgwQwc9MLXAwViqlWoUXH9ZW1gOWyjBdCTe0I96UGNhJe8XlCP9xRul
         RreSvIeBVPfxra+1jDmM4ZRDZ84WS7yEwMIyuhtTFbR/hmR+yIYZSo6GqJqYT3bomQ73
         niKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692198004; x=1692802804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zv9Vk5jQr2IfT7BdkJ5wITslmnfO7Niuhi2RQ//Q/uI=;
        b=W0+SwnIUZULQuBzN1qXD6nClZf44YgBsghTc66cv6vrf35QaGW7w4eRWoMMSX7iHPj
         tLFL2Jq23RnNeaBtEvWAGIBjCjcV4oBTWwmCevQGMjUJwNkiEO/lShKhmmKuaqqWjB92
         9dYO7GrP33lT6pQDQMCbwYDKgrKfPBRKbbge/pj5wqobLB6QKvNx2/43Wf+0FYL9gqvm
         jtC776nU/ggrTMpDOQiG2hxLSPNZdMOb9uZHWDfkcMcRAHqM0m3SZfiSQxutaamq9wNU
         COtaAHoNnodbmo4ZufOhAWSbzvqac6eabWjCOM5apoSI2doY73NTzLrUS0y2HjTt3Q4f
         hcQg==
X-Gm-Message-State: AOJu0YxB8Rhmt/PEwft813mxfT6Wh94TS191b3pY0IaJA7ApzkCFyA0q
	2cgahroxJsdwEjpA/WCUNtTwYw==
X-Google-Smtp-Source: AGHT+IFzVKmDjIvzwtlgT+bq3frquZsmviDY6b3R1BpsgDRS7gVCDBoX2/5mJ9NJ3jfCE3Q0ivDGaQ==
X-Received: by 2002:a05:6a20:144c:b0:12b:2170:7b13 with SMTP id a12-20020a056a20144c00b0012b21707b13mr2533125pzi.16.1692198004467;
        Wed, 16 Aug 2023 08:00:04 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id v1-20020aa78501000000b00688431379f6sm1222816pfn.115.2023.08.16.08.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:00:04 -0700 (PDT)
Date: Wed, 16 Aug 2023 08:00:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Rakocevic, Veselin"
 <Veselin.Rakocevic.1@city.ac.uk>, "Markus.Amend@telekom.de"
 <Markus.Amend@telekom.de>, "nathalie.romo-moreno@telekom.de"
 <nathalie.romo-moreno@telekom.de>
Subject: Re: DCCP Deprecation
Message-ID: <20230816080000.333b39c2@hermes.local>
In-Reply-To: <CWLP265MB644915995F6D87F6F186BEF7C915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
References: <CWLP265MB6449FC7D80FB6DDEE9D76DA9C930A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230710182253.81446-1-kuniyu@amazon.com>
	<20230710133132.7c6ada3a@hermes.local>
	<CWLP265MB6449543ADBE7B64F5FE1D9F8C931A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<0cb1b68794529c4d4493b5891f6dc0e9a3a03331.camel@redhat.com>
	<CWLP265MB644915995F6D87F6F186BEF7C915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 16 Aug 2023 09:38:21 +0000
"Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk> wrote:

> >As Kuniyuki noted, a relevant record of contributions to netdev would
> >help/be appreciated/customary before proposing stepping-in as
> >maintainer of some networking components.  
> 
> Admittedly I have minimal netdev experience, I thought helping with an unmaintained protocol with no users would have been good experience. However, if we're looking to upstream MP-DCCP then our project would no longer require a DCCP maintainer.
> 
> >IMHO solving the license concerns and move MP-DCCP upstream (in this
> >order) would be the better solution. That would allow creating the
> >contributions record mentioned above.  
> 
> MP-DCCP is open source under GPL-2. The scheduling and reordering algorithms are proprietary, however, they are not necessary to MP-DCCP and can be omitted. Is that enough to solve the license concern? 

Is the scheduling in the kernel? If so yes, it will cause a MP-DCCP not to be accepted.
If it is all done in userspace, then it leaves option for someone to reinvent their own open source version.

