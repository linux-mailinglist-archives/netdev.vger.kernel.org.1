Return-Path: <netdev+bounces-38672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A647BC11A
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB99282435
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 21:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8864D44494;
	Fri,  6 Oct 2023 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChmVKuCi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15544483
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 21:21:54 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4881BD
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 14:21:52 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1859784a12.2
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696627312; x=1697232112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sal1wT6OgX4gx9I/pTY8Ne5w3VbRzz44eIVM9pCe4Oc=;
        b=ChmVKuCiSWG6L3iBApPORvD1QovGyu8+0/HUo3e4+D2ADzgoGKAco0ov32SrEMm5/f
         zwp0iDnFCGVjrDoLA3mNaNI8jOVGggC41oi7DXlwZbC22659S3XRi6iQM488h5fFIAAc
         BMnKX5LnB3ksPDBMxZPyKa4aTBbLvv5dRpD2uVdryHWPG8nmJ6Amd5JDHbngGMIpRr54
         lVYPfWES7c/MSSE6w17nczefMCDBFew7Ppew8srJhpRsYW7MW3pXJY+UAe/ITvoA62h/
         Jrt6rA7v/bdxHvmN8XtM0idr/w3X6x8kkQK/ygrf/zE73j7pL48WHx3/5aAws+JLVBdf
         kr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696627312; x=1697232112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sal1wT6OgX4gx9I/pTY8Ne5w3VbRzz44eIVM9pCe4Oc=;
        b=uznEOjmUP0acKSi0b8C4bgrUwsMA9wYmEz6IPs5on7adFrsksKxEpB98fHnLQBlYZI
         ZZtlK2ieST2x9vg8+j/PoAqPlNL+/ujdBuJ5o47X7/uuqZfHTvOb3mHLaWGO/iF5pr21
         3WQ+lpnh/if9t/9SPhTM1JlqKE3B2WkjaZNTuSI3fzojxLr5aZaOT4l1aPwuLYLSDpun
         S2jjh9+5mUgOh4tcfUiVpU3EMsi1JMebPsSbsXaXUrwD8fjsqlmD8nozX9nYNTgdXC4G
         /gdFLuq1/cGoSK9Nh3Al6tqXc5GOIvtyfn1DDJ03VbWIhunYMGgOs73Jd/CZt6xUNkIL
         N81g==
X-Gm-Message-State: AOJu0Ywuczi10sfzb2tYiZzeaRELZhVvVqk7b+NBmWtbEz1qygl/YQyA
	buOzVjOyZ0ZJ+NveKo2CO/4=
X-Google-Smtp-Source: AGHT+IF7UOXoitCsANtivw5D1A8GUEpYF+3WqY7TvyIihlSmZqz4Xhwq4q8zcWpFDz9XHSh//kEMuA==
X-Received: by 2002:a05:6a20:7490:b0:160:a980:1222 with SMTP id p16-20020a056a20749000b00160a9801222mr10671788pzd.53.1696627311975;
        Fri, 06 Oct 2023 14:21:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g6-20020a170902740600b001bc18e579aesm4376647pll.101.2023.10.06.14.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 14:21:51 -0700 (PDT)
Message-ID: <add6d13b-c788-427e-a92d-1d07589b86d0@gmail.com>
Date: Fri, 6 Oct 2023 14:21:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] docs: netdev: encourage reviewers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jesse.brandeburg@intel.com, sd@queasysnail.net,
 horms@verge.net.au
References: <20231006163007.3383971-1-kuba@kernel.org>
 <8270f9b2-ec07-4f07-86cf-425d25829453@lunn.ch>
 <20231006115715.4f718fd7@kernel.org> <20231006121047.1690b43b@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231006121047.1690b43b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/6/23 12:10, Jakub Kicinski wrote:
> On Fri, 6 Oct 2023 11:57:15 -0700 Jakub Kicinski wrote:
>> :) If I can't get it past you there's no chance I'll get it past docs@
>>
>> Let me move some of the staff into general docs and add a reference.
>> The questions which came up were about use of tags and how maintainers
>> approach the reviews from less experienced devs, which I think is
>> subsystem-specific?
> 
> So moved most of the paragraphs to the common docs, what I kept in
> netdev is this:
> 
> 
> Reviewer guidance
> -----------------
> 
> Reviewing other people's patches on the list is highly encouraged,
> regardless of the level of expertise. For general guidance and
> helpful tips please see :ref:`development_advancedtopics_reviews`.
> 
> It's safe to assume that netdev maintainers know the community and the level
> of expertise of the reviewers. The reviewers should not be concerned about
> their comments impeding or derailing the patch flow.
> 
> Less experienced reviewers should avoid commenting exclusively on more
> trivial / subjective matters like code formatting and process aspects
> (e.g. missing subject tags).

Would rephrase the last paragraph and propose:

Less experienced reviewers are highly encouraged to do more in-depth 
review of submissions and not focus exclusively on trivial / subject 
matters like code formatting, tags etc.


-- 
Florian


