Return-Path: <netdev+bounces-23067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B02676A955
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A4028172E
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 06:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4489E46B6;
	Tue,  1 Aug 2023 06:41:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349796119
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:41:18 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B862B198B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:41:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bcd6c0282so811850366b.1
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690872070; x=1691476870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uY84uby8p3w6eiPSff8BxRA/CDbixhIP2n+IcZbYoCU=;
        b=sOjowxp/wNDyEY7qja/6C3d7oVKInXgrfn/2Tq0xbDmTlj6F8eFD+0QgY/s9NgT7f5
         Z0ipv1K6GHK/XD88NwrLmXTJQcp4iE8Qmi7Zv25c0TZwvex6Yvt4FdJcH7R09W1ZwZYo
         dqIZ3vjVFAygwfAqgitspF8wjDu9MEcrCgc1cSBrv2CKg/EwaENrdPOn3i4pxOBpzW+R
         KG2Jyij0A+Stef6pJ5vulBefi0vcjt1NggA5F5ssTFKu+puqxhEFcIJN1/KYKwBKXu+H
         g2i4QYym8bC7FXEuPJbPs6y7w+y4pQiHGaYlTnLPkSPMnFgnVth2R2Nv/dVO3rLchi5J
         FFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690872070; x=1691476870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uY84uby8p3w6eiPSff8BxRA/CDbixhIP2n+IcZbYoCU=;
        b=hWyJY35cCw+lmUojXSkhB8UMhAvAAUtfzH7H6xl9rq8XVWEsnlRVMtg7zj+8luddgq
         YypXZn4vfGXYgd0I3Wmg8ZQKj8P4/ptaB1YqtNWUbax54VVOIoMCtTbelb2k07QTRuGA
         eBYNCO8FniBVYhg/9PUEU5p+cYVpHN6Y1b1af9wIVPGX4+ZWBvq3K6eXEhmw6Tnrg0Ol
         C7G9HGv7/3cX6S6/K+j2pdy/CSBBNwI1tMJlbFy8L3XRhZIbjWpWs01LMaaCPaP3HjOH
         aTLr4bxYcHN6Fc/wvOJundPLCbCWliIg4xykMifv1/71hTKLtgwMhgspPJJDFdK0+cDF
         SilA==
X-Gm-Message-State: ABy/qLZe0rWW/oVCJn+aBJ6CdcutnqP+DwBmtbPKWW5Lxpwi8Xg5FOO/
	5nyPjSHpKnG3UH9iOC/0Rmsvcg==
X-Google-Smtp-Source: APBJJlGu447d+YszsKACauSuUqTOt2e8H8vzby8WYC222/wqTa5SrGtOqqsFqm1A2+AEazrwzsmJDg==
X-Received: by 2002:a17:906:53d7:b0:992:345e:8319 with SMTP id p23-20020a17090653d700b00992345e8319mr1765320ejo.58.1690872069828;
        Mon, 31 Jul 2023 23:41:09 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id k17-20020a1709061c1100b009937dbabbd5sm7156766ejg.220.2023.07.31.23.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 23:41:09 -0700 (PDT)
Date: Tue, 1 Aug 2023 08:41:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 08/11] devlink: introduce set of macros and
 use it for split ops definitions
Message-ID: <ZMipBAoEMVglMnsn@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
 <20230720121829.566974-9-jiri@resnulli.us>
 <20230725103816.2be372b2@kernel.org>
 <ZMenYPE5zrA2myAm@nanopsycho>
 <20230731095745.60a965b8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731095745.60a965b8@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Jul 31, 2023 at 06:57:45PM CEST, kuba@kernel.org wrote:
>On Mon, 31 Jul 2023 14:21:52 +0200 Jiri Pirko wrote:
>> >If you want to use split ops extensively please use the nlspec
>> >and generate the table automatically. Integrating closer with
>> >the spec will have many benefits.  
>> 
>> Yeah, I was thinging about it, it just didn't seem necessary. Okay, will
>> check that out.
>> 
>> Btw, does that mean that any split-ops usage would require generated
>> code? If yes, could you please document that somewhere, probably near
>> the struct?
>
>I wrote it somewhere, probably the commit messages for the split ops.

I believe we need to have it written down in actual codebase.


>The tools are not 100% ready for partial generation I don't want to
>force everyone to do code gen. But the homegrown macros in every family
>are a no go.

So you say that if I spell it out without macros, that would be okay?


