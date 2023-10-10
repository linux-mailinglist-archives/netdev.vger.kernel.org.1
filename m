Return-Path: <netdev+bounces-39609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE6C7C00DD
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78381C20B86
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E463A27466;
	Tue, 10 Oct 2023 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="d1Mretp9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E527440
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:56:42 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA10BA7
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:56:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32d80ae19f8so234883f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696953398; x=1697558198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJfm2PAr4bCf6SyWliNzd5Uis594LQ0eJ9ICywsH2v8=;
        b=d1Mretp9esPy9hGw5zHB1CfNIGBCaYM7d8fenuvvZu35vYxf/dsOTAwO4RWI4OHh+d
         rKWnimUDA7b+TkUeibWQZ/K8gBwUdKLeWbnRR6JLW1s1x/M4uZvP2AnZHVAKFHykyO0y
         ZVGVKMbsod/lcfSidDh13EKjXig5FUnHTmlRm/ZfAObFLhGatMxRcF7RZR1WY103L3nG
         JphMwd1KBfnHMXJAYdVVnFGm1JgLkbT8soUFvX6xcGO/XZzR/mIVlIETJ859U9cweTI3
         K5WRzefjJCdjh4kv1FxgBONzooI0K7LhrkU6i9oIeIL1Eoz+YnnBkeBNLiLEhmRStr92
         h0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696953398; x=1697558198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJfm2PAr4bCf6SyWliNzd5Uis594LQ0eJ9ICywsH2v8=;
        b=ZEh+kCrPCpg2+bHAC+QOGGyhT1R+DPsg5Fs7bHrh/NqhPSVrl8was12SpxSzRgziMi
         1wOFJhgAgch86bm0pPyqL7iF2GctCYusX8oVz0ePfzXhhKHTvYF5oQMHSJ3wzskxNL+u
         jjVkmGs06+PlCHW0k1Nkxq/EppG1JCPphxUyB9pUY9QzccOM00mIBaa4kTZOPTTV/7ej
         usAAY8LIPluSYV+1h5XGKzWCg3uQHW6NsHgTlikDsvze6cefmRCzOsfObKPydlrxh3oa
         /ZTUcAS1zW6OIILEZJBzlFVE33bn+d8QKFJKci03VTV+7GfqHIlIRydDmXuXFrB4zMeA
         27BQ==
X-Gm-Message-State: AOJu0YybKpVwhI5jdWclmptRjP+rVfTD9c7wN60s0ytHoUVlDmkpQkw/
	A8v2G3PExnE3AkERy5EDsjZH/Q==
X-Google-Smtp-Source: AGHT+IH1/dzjiNl0Su8yaQJJH1th9guNsT/r24MtA4GFI6IZdhxWLU+9GoI20ntOGNGL+KR3gwkw0A==
X-Received: by 2002:a5d:5448:0:b0:320:7fa:c71e with SMTP id w8-20020a5d5448000000b0032007fac71emr17553604wrv.15.1696953398013;
        Tue, 10 Oct 2023 08:56:38 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b00323293bd023sm13155533wro.6.2023.10.10.08.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 08:56:37 -0700 (PDT)
Date: Tue, 10 Oct 2023 17:56:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <ZSV0NOackGvWn7t/@nanopsycho>
References: <ZR+1mc/BEDjNQy9A@nanopsycho>
 <20231006074842.4908ead4@kernel.org>
 <ZSA+1qA6gNVOKP67@nanopsycho>
 <20231006151446.491b5965@kernel.org>
 <ZSEwO+1pLuV6F6K/@nanopsycho>
 <20231009081532.07e902d4@kernel.org>
 <ZSQeNxmoual7ewcl@nanopsycho>
 <20231009093129.377167bb@kernel.org>
 <ZST9yFTeeTuYD3RV@nanopsycho>
 <20231010075231.322ced83@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010075231.322ced83@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 10, 2023 at 04:52:31PM CEST, kuba@kernel.org wrote:
>On Tue, 10 Oct 2023 09:31:20 +0200 Jiri Pirko wrote:
>>> In Linux the PF is what controls the SFs, right?
>>> Privileges, configuration/admin, resource control.
>>> How can the parent disappear and children still exist.  
>> 
>> It's not like the PF instance disappears, the devlink port related to
>> the SF is removed. Whan user does it, driver asks FW to shutdown the SF.
>> That invokes FW flow which eventually leads to event delivered back to
>> driver that removes the SF instance itself.
>
>You understand what I'm saying tho, right?
>
>If we can depend on the parent not disappearing before the child,
>and the hierarchy is a DAG - the locking is much easier, because
>parent can lock the child.

It won't help with the locking though. During GET, the devlink lock
is taken and within it, you need to access the nested devlink attributes.

And during reload->notify, we still need work so the lock are taken in
proper order.

It would only make the rel infrastructure a bit similer. I will look
into that. But it's parallel to this patchset really.

>
>If it's only nVidia that put the control in hands of FW we shouldn't
>complicate the core for y'all.

