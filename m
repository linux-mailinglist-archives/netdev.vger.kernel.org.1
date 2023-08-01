Return-Path: <netdev+bounces-23068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BEE76A961
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8422816DE
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 06:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F134A16;
	Tue,  1 Aug 2023 06:42:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F004A0A
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:42:17 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E917319A4
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:42:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so13538327a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690872131; x=1691476931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgawtNl3Ohn/OtPR+/ob5S8eyEcOe1Fa+wcwuZcHocs=;
        b=yy0nyo8LmESLVwFUVnxtlNppynTKjhaqeWNlt4WVGNK9H+pdoLOm6AQvSlwUrvpa+Z
         TwEjEr0LE2GAWyopkUWOcu8+b4Rq4/4GNoxn8hmAlxDbLtU1f3rGWEVCqtgmJQ/nygFs
         o324oQmXd4zdQFHWYgdx5FMvE+74JlDdwBKiGib9PcnL1aAlGaQGuwnUv+kWWSltLMKT
         JySzoE6UGgzWOFdLPpWsKYxRFf3Qb8BZkZcikDksn9Swfw2oXH8wACfZ6geFAM/gZW0D
         NUtbxEB6T6N0Xxw3FpvVHT+7mxBhLuUJ8rLmJwlsA95jaPWdBUKqeaOa6VCfRjjCRQii
         eb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690872131; x=1691476931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgawtNl3Ohn/OtPR+/ob5S8eyEcOe1Fa+wcwuZcHocs=;
        b=j0ciGlmP0bmrnHyCEs41/Iwmp4CkUlBRVKpNas40BEYRz93TUpgAyNhy43B6RE+e7N
         OTxbj8mm35qTx5NjmxJOvwixX5T6YVKoqMOqb2TP2DJYXS13dou6NWwt0Cy+poSULEWJ
         8G5w3nofeqZ1q7lFBcaF9sK5dj3L3KPWeSRSoB2TTq0V/xOcuP9mUKBETpGiP4ImQvnD
         JydXlsnSiG8J3UGEWXWLQgy3l/MhdshCWZwKfaGGljcU6nUx5cWDsbf/YXXsjQYLCJYR
         EgVSoh8/bj0mooBdpynwu1TuogOkmBaTGuYtodeV9MhzB0cyqSeJ94Jm6YqNs/OvfjPU
         iMCQ==
X-Gm-Message-State: ABy/qLb4OoPDocrQ2Lskl7hvo+yeTchLufejMEg07yvVXVro3cx+TQTF
	6VwStn6UajiH/fQEQW1TkhdXbw==
X-Google-Smtp-Source: APBJJlFdyP9tMrHrAECSVw+tBMkamXdMns/wdxzk202wWg0gn19hWPLFGcMx5WYBrsWdNuZ0zcvF6w==
X-Received: by 2002:a17:906:76c4:b0:993:d632:2c3 with SMTP id q4-20020a17090676c400b00993d63202c3mr2190355ejn.21.1690872131238;
        Mon, 31 Jul 2023 23:42:11 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id ga15-20020a170906b84f00b00997c1d125fasm7219570ejb.170.2023.07.31.23.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 23:42:10 -0700 (PDT)
Date: Tue, 1 Aug 2023 08:42:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 10/11] devlink: introduce dump selector attr
 and use it for per-instance dumps
Message-ID: <ZMipQcNtycg6Zyaq@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
 <20230720121829.566974-11-jiri@resnulli.us>
 <20230725114044.402450df@kernel.org>
 <ZMetTPCZ59rVLNyQ@nanopsycho>
 <20230731100341.4809a372@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731100341.4809a372@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Jul 31, 2023 at 07:03:41PM CEST, kuba@kernel.org wrote:
>On Mon, 31 Jul 2023 14:47:08 +0200 Jiri Pirko wrote:
>> >Why not declare a fully nested policy with just the two attrs?  
>> 
>> Not sure I follow. But the nest under DEVLINK_ATTR_DUMP_SELECTOR has
>> its own policy, generated by devlink_nl_dump_selector_policy_init(). I
>> did it this way instead of separate policy array for 2 reasons:
>> 1) We don't have duplicate and possibly conflicting policies for devlink
>>    root and selector
>> 2) It is easy for specific object type to pass attrs that are included
>>    in the policy initialization (see the health reporter extension later
>>    in this patchset). There are couple of object to benefit from this,
>>    for example "sb".
>> 3) It is I think a bit nicer for specific object type to pass array of
>>    attrs, instead of a policy array that would be exported from netlink.c
>> 
>> If you insist on separate policy arrays, I can do it though.
>
>IMO the contents of the series do not justify the complexity.
>
>> I had it like that initially, I just decided to go this way for the 3 reasons
>> listed above.
>> 
>> >Also - do you know of any userspace which would pass garbage attrs 
>> >to the dumps? Do we really need to accept all attributes, or can
>> >we trim the dump policies to what's actually supported?  
>> 
>> That's what this patch is doing. It only accepts what the kernel
>> understands. It gives the object types (as for example health reporter)
>> option to extend the attr set to accept them into selectors as well, if
>> they know how to handle them.
>
>I'm talking about the "outer" policy, the level at which
>DEVLINK_ATTR_DUMP_SELECTOR is defined.

I don't follow :/ Could you please describe what exactly do you mean and
want to see? Thanks!

