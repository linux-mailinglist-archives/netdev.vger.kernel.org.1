Return-Path: <netdev+bounces-23536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFB276C616
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E2E281BC2
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650321C35;
	Wed,  2 Aug 2023 07:05:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589931848
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:05:04 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7121B1BF9
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:05:01 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bf91956cdso588740666b.3
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 00:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690959900; x=1691564700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=srtztsOfRZHM5DByMvd5qNZ4d4L4TsJYOXXb3gpyLNg=;
        b=JUdtQeOUbF/J36LHPbsRWP0VqA+oUCYFvrpaTsq2l/rOzt67R9NGJhTnQxxF02+LdE
         TvcXPVUtZ8RVj5+Qc5NDr5yyB4/DXNpl2kB3uTadcmdBU+nzmNiFNFTtRlOZJG5AWS9i
         /lhaJfaveyhpdl7QSPT3QZrNtny4qHmVrovWtVFE19IVs8dbibFCkfDULn8cnLbQjqgv
         aXSLr30jRM5lrnk0+EQLNj4W6MGvZ6QJF0F41iqUPYVAXQiOVCwY7diED7J5qawgbCn+
         42eFF9bwobBCtFNqA5U0+freQPL4ibjxutNUw0/LIRU0ghAxwsLagQ7EAjhQoQFkPV2L
         Arlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959900; x=1691564700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srtztsOfRZHM5DByMvd5qNZ4d4L4TsJYOXXb3gpyLNg=;
        b=gdLg+AkdusnT6RN6Hmc2pKV5wJf4p5bC6uVITo4Pm40uBufIn+n5bmzxsGVIP0QpT9
         4dwZRzYUIx6f84Vb3BT6sCscxLR2+xu2Xm0u8qmqOsYXwpdCQUuebk285Hy8WSe+CBsH
         q/oix/bmI8+/pJnz4z+vdqOUEJrhPmn9nhHvz4NWTkSgv4H/aDB/KFMFHvPeniMzZuPY
         6AwvOLWhHHK63DVLBP3tL1ERNeKCz8I2XwUEvfZ+zJQUP4w8n/NTjmtI1f4CihzgJGSs
         gLNTvggvAgFzS39CPgKsQeKp8e8evcP8I1qhAwTPgDjHVuzNa0WRASAHIn2jPcSu7Eqa
         svFQ==
X-Gm-Message-State: ABy/qLbyZuUrvuAwEJK2FHjMtADAiKLN3yOLJ+081z6pwwPVgZkZkIr4
	K6WiX3o4albsw2kxUkDBXBTmzw==
X-Google-Smtp-Source: APBJJlFKvHX6CaVaIWDwJhrdlsairDgmqKfvU8+4Gtli3Iu3VlV8GRtfTCjEUQUIEWNYGOHFFwsRQw==
X-Received: by 2002:a17:906:64cb:b0:994:19ed:e92b with SMTP id p11-20020a17090664cb00b0099419ede92bmr3897121ejn.20.1690959899606;
        Wed, 02 Aug 2023 00:04:59 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id b10-20020a170906490a00b0099bd6ef67e8sm8751615ejq.78.2023.08.02.00.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:04:58 -0700 (PDT)
Date: Wed, 2 Aug 2023 09:04:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 11/11] devlink: extend health reporter dump
 selector by port index
Message-ID: <ZMoAGbFufprqV2FS@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
 <20230720121829.566974-12-jiri@resnulli.us>
 <20230725114803.78e1ae00@kernel.org>
 <ZMeunKZscNRQTssp@nanopsycho>
 <20230731100632.02c02b76@kernel.org>
 <ZMirCXLlY6H2yVEq@nanopsycho>
 <20230801085644.7be5b2e4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801085644.7be5b2e4@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 01, 2023 at 05:56:44PM CEST, kuba@kernel.org wrote:
>On Tue, 1 Aug 2023 08:49:45 +0200 Jiri Pirko wrote:
>> >for_each_obj() {
>> >	if (obj_dump_filtered(obj, dump_info))  // < run filter
>> >		continue;                       // < skip object
>> >
>> >	dump_one(obj)  
>> 
>> I don't see how this would help. For example, passing PORT_INDEX, I know
>> exactly what object to reach, according to this PORT_INDEX. Why to
>> iterate over all of them and try the filter? Does not make sense to me.
>> 
>> Maybe we are each understanding this feature differently. This is about
>> passing keys which index the objects. It is always devlink handle,
>> sometimes port index and I see another example in shared buffer index.
>> That's about it. Basically user passes partial tuple of indexes.
>> Example:
>> devlink port show
>> the key is: bus_name/dev_name/port_index
>> user passes bus_name/dev_name, this is the selector, a partial key.
>> 
>> The sophisticated filtering is not a focus of this patchset. User can do
>> it putting bpf filter on the netlink socket.
>
>Okay, I was trying to be helpful, I don't want to argue for
>a particular implementation. IMO what's posted is too ugly
>to be merged, please restructure it.

Ugly in which sense? What exactly needs to be restructured?


