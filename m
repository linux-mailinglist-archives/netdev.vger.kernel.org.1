Return-Path: <netdev+bounces-24624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6E4770E1F
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 08:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AED1C20D49
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 06:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0061417C6;
	Sat,  5 Aug 2023 06:33:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2F180
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 06:33:35 +0000 (UTC)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB1FFC
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 23:33:32 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-790cc395896so102526839f.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 23:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691217211; x=1691822011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pc3WoibZYZDYFLA/vnf/DW8hjMxBlg+bH0Lqd2MjA0g=;
        b=cCSR8EfA591i6DXa8gmsVWDkQErirJBSU/kcKJCIweOtdK8J/b/3yOw4HE/5zn16HB
         p64IzxjeqsOtWUtQUl6atZCL9x1zGHTpFWq8zLtmAPXedJ6cTQgK27I4Aqso5dGXD4cn
         AyFMGrfGikr1ocC0R0mxaC79s95mS90JAU5gM8lJhHMDPA95GV61fds+mdPGHrMPoMS4
         IRYOULP0o5nMU0J1krqn1XEytKeOT03JXPmhctrynWtPX1Uz1ZY+YGM6XlGIgjQP5FxT
         DZkiQiswF99UwjsJcmQJskwzRHIRZEcfZ0Y4gqrFGtwL3ad8KaHlgn2BeEB4u3vN/2lQ
         5RDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691217211; x=1691822011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pc3WoibZYZDYFLA/vnf/DW8hjMxBlg+bH0Lqd2MjA0g=;
        b=VeI+vgiZ61yKWVgpyOtfa+Wm+n+7bJn7+7nRSceUwHYQsaxYyT7j8orlMvce166a2c
         p3AW4ZkCoe/K91wxGW8s+hqEU7iDlg+paO/ilJmASe6vD3UeJExAxMC/mpGPwBwwZ8Gs
         JFG8vpsllKUnHmEHA9zcSDXrPVjInxPwk8lQx5mdg4NG8Jm5pDPklXFjuFoyMMBpb0ae
         w8ov7l+TkFQ8IeaYfha9mYU0qI/y3AExJ5Ry5RLU6EyVvJekd/P5bqJp4BCd8Gx/kaWT
         qh/dO2sNJgCZ3+v0gL4TYs/q0H5XLdBEbttRFZnbnmfHsK2nZ7uUJVEFIfPz9B3j8dDK
         7szQ==
X-Gm-Message-State: AOJu0Yy7ntKKCCzJnqkOorZzYQ54loeL2zQEt6p/U3g7JdyAnY7Vauq2
	m9NMEFpqgWsFtkyzmbg/Emq95A==
X-Google-Smtp-Source: AGHT+IEO97yCCN1nbSk23P2S5d2yOkPqmV8YKtj0bApL6YXwzwWRqmPw13KsoClY7SVHvbBC/0HyvQ==
X-Received: by 2002:a6b:f20f:0:b0:791:280:839f with SMTP id q15-20020a6bf20f000000b007910280839fmr357424ioh.13.1691217211579;
        Fri, 04 Aug 2023 23:33:31 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id p22-20020a5d8d16000000b00786f5990435sm1132203ioj.7.2023.08.04.23.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 23:33:30 -0700 (PDT)
Date: Sat, 5 Aug 2023 08:33:28 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: ynl - mutiple policies for one nested attr used in multiple cmds
Message-ID: <ZM3tOOHifjFQqorV@nanopsycho>
References: <ZM01ezEkJw4D27Xl@nanopsycho>
 <20230804125816.11431885@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804125816.11431885@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 04, 2023 at 09:58:16PM CEST, kuba@kernel.org wrote:
>On Fri, 4 Aug 2023 19:29:31 +0200 Jiri Pirko wrote:
>> I need to have one nested attribute but according to what cmd it is used
>> with, there will be different nested policy.
>> 
>> If I'm looking at the codes correctly, that is not currenly supported,
>> correct?
>> 
>> If not, why idea how to format this in yaml file?
>
>I'm not sure if you'll like it but my first choice would be to skip
>the selector attribute. Put the attributes directly into the message.
>There is no functional purpose the wrapping serves, right?

Well, the only reason is backward compatibility.
Currently, there is no attr parsing during dump, which is ensured by
GENL_DONT_VALIDATE_DUMP flag. That means if user passes any attr, it is
ignored.

Now if we allow attrs to select, previously ignored attributes would be
processed now. User that passed crap with old kernel can gen different
results with new kernel.

That is why I decided to add selector attr and put attrs inside, doing
strict parsing, so if selector attr is not supported by kernel, user
gets message back.

So what do you suggest? Do per-dump strict parsing policy of root
attributes serving to do selection?

