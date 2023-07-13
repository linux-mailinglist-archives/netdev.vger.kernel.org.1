Return-Path: <netdev+bounces-17487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AC8751C7D
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17CD5281482
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533BAF9DA;
	Thu, 13 Jul 2023 09:01:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F6F9D7
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:01:08 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A87268A
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:00:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-314417861b9so586600f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689238853; x=1691830853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5WxbRdD6fBUeo+fFC+dWQDKMnZVyapN3LxYNlhp9Eso=;
        b=4r/fUa3oOr+WjxNrYmUMGO5vTqxKmBUPFmXyBgP75UEx+ygXTW/0rgqVI5YqTZGzU4
         D1V1+t3xOOqHgK4dfbTShEhYuMnaiMdim78hi8EZVnGFseoWlEvNgOSTY2EPwimAHWeg
         JBmlBsctQFUWZicZccMH9nkmEMGVmc5B7L1D9EJtQxYnq+MUdiJDp23bse73NXRzGKVR
         +H2m1qP0qtJZxU/td4Ga4irajFw+rRmCjrZ/YowbN/u+l+PnCQvow9fdoYGz8YMr5kgB
         ownrsJAJnwiiFVvOQgss4Zbxp0mz2rrpD8Dgtm9qCMJsFNvbS1stwzSF02YKZIGkB3Ec
         PSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689238853; x=1691830853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WxbRdD6fBUeo+fFC+dWQDKMnZVyapN3LxYNlhp9Eso=;
        b=L0EY0nYwUJ6k0nEPFPBYL/6BE49GupwcM/w8hZLk5YTv3DTbtBdaFqgwp8V5Q13JRl
         WaeUun8nmmXiaHVe48tDzgyWCCNwyEyR1zVMVQaqnfPbl8W4e3vbsJX9Pqp3k96Khbs8
         +HGEGW7Y0wr4YnqiZu//z8/CfevW/VwR418unOHSjlxM/mmVdUJJyAxDywWugfoD0l+v
         swRTpHzTBlyJRLhaqg4iYslZjSROJzXLfpwurcCMtpUPm2KCsB1eY6axFTceQqeu7noo
         kXhWui8NUjw3cSbCJm5HMJ6IrCWqkcQRGoS6/a/n+ssVMpJ0dxVYLlQ5Eb2JbkpVpIQj
         r7Qw==
X-Gm-Message-State: ABy/qLZzDrFGrpCIdMqThvu+2H45f1LJqs3WrchmycW7lbGikm62vGrg
	rPnyCm3q6/4jsqc9KjQmI9ovrw==
X-Google-Smtp-Source: APBJJlHMSurDVK6f/K5b2ktLDjdptAO+VfkknexFQZf6xmhvCQPTEMp8/HxKplcTnWy64QZb5q03sg==
X-Received: by 2002:a5d:5544:0:b0:313:f907:ceed with SMTP id g4-20020a5d5544000000b00313f907ceedmr853402wrw.39.1689238852888;
        Thu, 13 Jul 2023 02:00:52 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d4b10000000b003143be36d99sm7352109wrq.58.2023.07.13.02.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:00:52 -0700 (PDT)
Date: Thu, 13 Jul 2023 11:00:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	moshe@nvidia.com
Subject: Re: [patch net-next] devlink: remove reload failed checks in params
 get/set callbacks
Message-ID: <ZK+9Q/5NC7/eNGH8@nanopsycho>
References: <20230712113710.2520129-1-jiri@resnulli.us>
 <ZK6u8UFXjyD+a9R0@shredder>
 <ZK7EyBcE7sFVvYvh@nanopsycho>
 <20230712122103.4263c112@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712122103.4263c112@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jul 12, 2023 at 09:21:03PM CEST, kuba@kernel.org wrote:
>On Wed, 12 Jul 2023 17:20:40 +0200 Jiri Pirko wrote:
>> >> Back then, it was a possible fix. Alternative way to fix this was to
>> >> make sure drivers register/unregister params in the code where it is
>> >> ensured that the data accessed by params callbacks are available.
>> >> But that was problematic as the list of params wes static durint  
>> >
>> >s/wes/was/
>> >s/durint/during/  
>> 
>> Maintainers, I will send v2 with these typos fixed tomorrow, if these
>> are not any other comments.
>
>Feel free to toss in
>
>pw-bot: changes-requested

I see, is this documented somewhere?

>
>so we don't have to update the status manually.
>
>The commit message would benefit from a rewrite, TBH I don't understand
>half of it, specially:

Will do.

>
>  Alternative way to fix this was to make sure drivers
>  register/unregister params in the code where it is ensured that 
>  the data accessed by params callbacks are available.
>
>Can't parse.
>
>  list of params [was] static [during] devlink instance being
>  registered.
>
>You mean that list of params can't change after the instance was
>registered?

Yeah, that was a limitation in history IIRC.


>
>  register/unregister params alongside with the data it touches
>
>Meaning params for a sub-object are registered when the sub-object 
>is registered? An example could help clarify the meaning.
>
>> >> devlink instance being registered.
>> >> 
>> >> Eventually this limitation was lifted and also the alternative fix
>> >> (which also fixed another issue) was done for mlxsw by
>> >> commit 74cbc3c03c82 ("mlxsw: spectrum_acl_tcam: Move devlink param to TCAM code").
>> >> 
>> >> The checks are no longer relevant, each driver should make sure to
>> >> register/unregister params alongside with the data it touches. Remove
>> >> the checks.

