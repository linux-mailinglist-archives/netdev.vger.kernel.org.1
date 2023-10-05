Return-Path: <netdev+bounces-38185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC10A7B9B54
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 09:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9C898280EBE
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 07:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A98E538F;
	Thu,  5 Oct 2023 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xKXfoTaU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FAA7F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:22:32 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CFC7AA1
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:22:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so1023733a12.2
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696490548; x=1697095348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wg0kSJFB6EJHSAnWmER03G72rs5jlPt4Pu0o+uNZqvI=;
        b=xKXfoTaU+qdEGSisxtIS1sCUDJnzRonv7K8j4WTiVuSHIiCWzyBqYjneIh3mvf/xmk
         tl7iHxQTKC+lAutrSUg+rv4PpvTjEVKsVbHpsSLh8AbNzbSJc0yy7OtqD3QV4gPCdTRW
         t4KWMAijwnNpFa6KwxFoCPzQ/YB4AGNj95qx6fB0J3elqj2NjsBj/Lng0/fh3cJ76xMV
         7Jmd/6Mmfh9qTGpdeoWLUli0FalMM69DgRV+7c8U2AW3MOrVS501BamrWQOxlSY+XEhS
         +jP4manXZktM5oZB/unyMk19olLIxoNgtGnKYpt0U4Cd0fkR34lPB0NSlQmboMoINjst
         3GCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696490548; x=1697095348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wg0kSJFB6EJHSAnWmER03G72rs5jlPt4Pu0o+uNZqvI=;
        b=nclVYKDGfY95ee8d1mkEQztW6SAamssJGWTbjgn4756dCpZiH5FX+Kc4Aspe2rKVP5
         m1PsUbLr2XMInVsO9bfquVfYGoqoXNCqxxyL8FYyias4EzkcbtBR4bGm5GsU5Ef/Frkc
         ycOH/vLy6z3SOhkDuv1Dpj8ofT9ygaCV2u+qjmEEAjSOCWGy7nmT6xj/8j6qKXIbBt40
         AfC6cLl19/TkvZ5hZkmOKzDxQyzajJrsxawEk3yHoJuT6UBfap6dYwJ/ivVu/ydEIyyx
         Ohvut7w1fdHf8zLkKlCHpq93+H1PLbnI6UmciE7QzKX7a7VgAnFf+tFw3MpACZMBvYDO
         UKmg==
X-Gm-Message-State: AOJu0Yw+SYQH9T1kD2KstUIz9DXVDYd/ebJosb1YfI+2sSXm7JMdt0yF
	GfOpQA1Ynz4jTxcGaiM/Co4VIA==
X-Google-Smtp-Source: AGHT+IGZfBRra0irhbomszGjj2Zl2EKmTkl6P0w9Mde4OyJOoqd0VjcPN727OaIfls+vP26/Fl4A9A==
X-Received: by 2002:a17:906:518f:b0:9a5:c4c0:2d8a with SMTP id y15-20020a170906518f00b009a5c4c02d8amr3636586ejk.24.1696490547911;
        Thu, 05 Oct 2023 00:22:27 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id a14-20020a17090680ce00b0099cb1a2cab0sm679882ejx.28.2023.10.05.00.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:22:27 -0700 (PDT)
Date: Thu, 5 Oct 2023 09:22:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	daniel.machon@microchip.com
Subject: Re: [patch iproute2-next v2 3/5] devlink: introduce support for
 netns id for nested handle
Message-ID: <ZR5kKxNKkLrOoQ4S@nanopsycho>
References: <20230919115644.1157890-1-jiri@resnulli.us>
 <20230919115644.1157890-4-jiri@resnulli.us>
 <3652856a-1cda-c050-04da-fe2204949ff5@gmail.com>
 <ZQnYDVBeuIRn7uwK@nanopsycho>
 <5476af84-7f3d-2895-3be3-83b5abc38485@gmail.com>
 <ZQqfeQiz2OoVHqdS@nanopsycho>
 <ZRa1cu4TlCuj51gD@nanopsycho>
 <ca25c554-4fd9-5db2-655d-a30ffca11d8d@gmail.com>
 <ZRxMrelhKF9QHGrj@nanopsycho>
 <017e9228-f003-8056-d3a8-3fe1337db2f6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017e9228-f003-8056-d3a8-3fe1337db2f6@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Oct 04, 2023 at 05:20:46PM CEST, dsahern@gmail.com wrote:
>On 10/3/23 11:17 AM, Jiri Pirko wrote:
>> Tue, Oct 03, 2023 at 06:37:31PM CEST, dsahern@gmail.com wrote:
>>> On 9/29/23 5:30 AM, Jiri Pirko wrote:
>>>>>> The attribute is a namespace id, and the value is a namespace id. Given
>>>>>> that, the name here should be netnsid (or nsid - we did a horrible job
>>>>>> with consistency across iproute2 commands). I have not followed the
>>>>>> kernel patches to understand what you mean by nested devlink instance.
>>>>>
>>>>> Please do that. Again, the netnsid is related to the nested instance.
>>>>> Therefore I put the "nested_devlink" in the name. Putting just "netnsid"
>>>>> as you suggest is wrong. Another possibility would be do nest this into
>>>>> object, but:
>>>>> 1) I didn't find nice way to do that
>>>>> 2) We would break linecards as they expose nested_devlink already
>>>
>>> well, that just shows I make mistakes as a reviewer. These really long
>>> command lines are really taxing.
>> 
>> So what do you suggest?
>
>That you learn how to make up shorter names, leveraging established
>abbreviations for example. This one new parameter is 22 chars. How do
>you expect these command lines and responses to fit on a reasonable
>width terminal? I have been saying this now for many years about devlink
>commands - excessively long attribute names combined with duplicate
>terms in a command line. Not user friendly.

The problem is not the length, the problem is how to group nested
devlink handle and netnsid. Anyway..

