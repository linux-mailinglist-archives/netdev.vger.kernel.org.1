Return-Path: <netdev+bounces-35434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE9C7A9835
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2496F1C20F1B
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F8A18036;
	Thu, 21 Sep 2023 17:10:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A517996
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:09:59 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA412120
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:09:27 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6beff322a97so741270a34.3
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316167; x=1695920967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVcvvu/JFjnu+QrVzMYimtmbCiKo0Cmt5bIvcu2c+Og=;
        b=bD6jowcgW8QgQ2k2FEMeCG0rV8F6NAktmgtxg27XWVqvB8Cs2p52G46RMzIFpo2oTa
         yySMReiWn1AE/tkypIqFEJYbfHMPqbK31IRMjtSv2ewvGAwJ1vKmIZQkEe1Eke3e5G5r
         tjnr/jZh+yomx6gMm+gR7cuyDMXJYKyy006vvf4rsarh2vlS3vosWu3yTdIupQRC0/OL
         tWZ2Urw677gGoGSqXOq8J16BmjtSg0qUA8cFhf7Z56YNt3oxdOR6j4lU6i4LzrGzwh44
         wxcCd5j2JCLRDrk0d3P9yb1TeBt0SatctVVkAj3MwdqjcTWB57PeU4BKy0GYqQusFL+/
         ciug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316167; x=1695920967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVcvvu/JFjnu+QrVzMYimtmbCiKo0Cmt5bIvcu2c+Og=;
        b=HOvzdN0/2qVaeNHQN4Q/F4RQA1s+Wh5GOeqLe4FcYDgZpYxX2z59m3H6PMhYUtJZDu
         K63Fc8YDYnagC8aGUuETvoJpGbjD2A/7541M5mG7IVWJflh4LSw0DqIwZR+qeGQZOhFe
         VoseOn8847RodnZ8ZGzgASpExKpplmgoD8PXBT3N9MRK+yc3VUxe+Es8qlAylTgEEMP5
         dySg6bpgL1d7f5uMjYxiRTIUoHurClTpXhsCLXIOYiQe2FJpE/FuGkqO5K06oFvpgVmj
         hpWk+q67oQkKxjq3RSwxIJMv3Ko5b758X8Il11PAIabCzMB6j+tKUHhxWK8Lw+kDem8x
         h4rw==
X-Gm-Message-State: AOJu0YxjKAg4zgmuO1S6+iay2MUhpkYPewiy1yPl2xrtkfIg64zWn3oC
	HLespkt4MHUTyWLKmBqH4zkOAV3UOEs=
X-Google-Smtp-Source: AGHT+IG6oddQ51epnwGypAV5ylkotDRLWmvf1cAm59XtvXlGEBE+kRUDCVW24cX245cOZi/WF3b9zA==
X-Received: by 2002:a17:90a:4f4b:b0:26d:43f0:7ce4 with SMTP id w11-20020a17090a4f4b00b0026d43f07ce4mr5030413pjl.8.1695282654322;
        Thu, 21 Sep 2023 00:50:54 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id jx4-20020a17090b46c400b00274a43c3414sm2420784pjb.47.2023.09.21.00.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:50:53 -0700 (PDT)
Message-ID: <be58d429-90d1-42ff-a36b-da318db6ee68@gmail.com>
Date: Thu, 21 Sep 2023 14:50:47 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
To: Martin Zaharinov <micron10@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>,
 patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, kuba+netdrv@kernel.org,
 dsahern@gmail.com, Florian Westphal <fw@strlen.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com>
 <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
 <8a62f57a9454b0592ab82248fca5a21fc963995b.camel@redhat.com>
 <CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
 <43ED0333-18AB-4C38-A615-7755E5BE9C3E@gmail.com>
 <5A853CC5-F15C-4F30-B845-D9E5B43EC039@gmail.com>
 <A416E134-BFAA-45FE-9061-9545F6DCC246@gmail.com>
 <CANn89iKXxyAQG-N+mdhNA8H+LEf=OK+goMFxYCV6yU1BpE=Xvw@mail.gmail.com>
 <BB129799-E196-428C-909D-721670DD5E21@gmail.com> <ZQqOJOa_qTwz_k0V@debian.me>
 <94BC75CD-A34A-4FED-A2EA-C18A28512230@gmail.com>
 <CANn89iKvv7F9G8AbYTEu7wca_SDHEp4GVTOEWk7_Yq0KFJrWgw@mail.gmail.com>
 <CANn89iJCJhJ=RWqPGkdbPoXhoa1W9ovi0s1t4242vsz-1=0WLw@mail.gmail.com>
 <85F1F301-BECA-4210-A81F-12CAEEC85FD7@gmail.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <85F1F301-BECA-4210-A81F-12CAEEC85FD7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20/09/2023 14:32, Martin Zaharinov wrote:
> I will make this yes .
> 
> And will wait if any find fix in future release.
> 

Please don't top-post; reply inline with appropriate context instead.

Martin, what prevents you from doing bisection as Eric requested again?
If you only have production systems, why can't you afford to have
testing ones? Why not turning one of your prod machines to be testing
and bisect from there?

Sorry for inconvenience.

-- 
An old man doll... just what I always wanted! - Clara


