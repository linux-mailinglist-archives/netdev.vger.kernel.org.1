Return-Path: <netdev+bounces-38186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6B37B9B56
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 09:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 653E6280EDF
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4525398;
	Thu,  5 Oct 2023 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="h6X1znkH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C547F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:23:32 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447E37AA1
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:23:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-533c4d20b33so1555043a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 00:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696490609; x=1697095409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hEgBJtjYM4oUgz8eob0UfOpPVGimr8ZdCkHaQsa0Nk0=;
        b=h6X1znkHC3TnBPVboLChNLZ6sxWC1XsUhVotoVZ8R5hU1bipfI8DtSM5P6YtCUfWD6
         +GaLrRIQOcU5rQYByMtAKqBGOpyOMEAOu4Or7BfiHHB5kC7xeG3dZKmScnosp62u9XIs
         1/BcyDKj5gp/qpiI+8KR1sHucmdflcwt5DpTFPUYGF7rLWalYGtcT3k0zLMPDBwwCfbB
         +ByWNfw1Zf/HlEfCkXD9nLDb/sRJzzCc5aMBMbbgN/eo0VHM1kw2VysMqxsOWTbt6vLA
         y5+VHi0NVM7BIV/OFRmomWaPAwTlLZkLIbMeKrhLm9t676nEKuw9B6iG1ZfazeX5HpmT
         DykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696490609; x=1697095409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEgBJtjYM4oUgz8eob0UfOpPVGimr8ZdCkHaQsa0Nk0=;
        b=MSn6l19lClVFQKiDsJA52oXgLEd2zGO+c8A6y0dxgxWBp0TfqBfaqT4OoCu0EHwtw2
         tFi6cueA4ZGvZIbk/ksrDFaWvLQlGhK4u8hBeedqhxx9p8nKQBaMfxMdGNEygL/xS1VL
         kUcF0FSh7tNeCeo1rzy8cX8BRkjMmVlRjgV9AYDt0aPq3buKUqDvUod9VqtEH60yn9GT
         18f6ugKo9LcWmhIzB7P21K70oc6l3bAtI7dw76uXw7IufCKyYGysVtksc7Cmgz+7YmDG
         p2Fw0wumQDW4ErB4MkRVB17W+mafCT5/zAieHSYKw37BDWFm7MdNPAo47HmJIA2O1h66
         49iA==
X-Gm-Message-State: AOJu0Yyk4dLvk6W5dcPWkNbeMxcm17zxfrHpBUHkai53rRa2lm6iIaQJ
	9cv2yl3hDh5obnErrfXQ3vnNAw==
X-Google-Smtp-Source: AGHT+IFlCLSXncoyuKBtR8IaakyR999q7dcpsUBCEaQz0x9tg/vosUgc/1Twp8MzxNK2UWC0Qoh39A==
X-Received: by 2002:a05:6402:3584:b0:52b:db44:79e3 with SMTP id y4-20020a056402358400b0052bdb4479e3mr493908edc.4.1696490608787;
        Thu, 05 Oct 2023 00:23:28 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c17-20020a056402121100b0052ff9bae873sm614259edw.5.2023.10.05.00.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:23:28 -0700 (PDT)
Date: Thu, 5 Oct 2023 09:23:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, donald.hunter@gmail.com
Subject: Re: [patch net-next v2 1/3] tools: ynl-gen: lift type requirement
 for attribute subsets
Message-ID: <ZR5kbsUGuRB3dYWD@nanopsycho>
References: <20230929134742.1292632-1-jiri@resnulli.us>
 <20230929134742.1292632-2-jiri@resnulli.us>
 <20231004171202.6e52bde3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004171202.6e52bde3@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Oct 05, 2023 at 02:12:02AM CEST, kuba@kernel.org wrote:
>On Fri, 29 Sep 2023 15:47:40 +0200 Jiri Pirko wrote:
>> --- a/tools/net/ynl/ynl-gen-c.py
>> +++ b/tools/net/ynl/ynl-gen-c.py
>> @@ -723,6 +723,8 @@ class AttrSet(SpecAttrSet):
>>              self.c_name = ''
>>  
>>      def new_attr(self, elem, value):
>> +        if 'type' not in elem:
>> +            raise Exception(f"Type has to be set for attribute {elem['name']}")
>>          if elem['type'] in scalars:
>>              t = TypeScalar(self.family, self, elem, value)
>>          elif elem['type'] == 'unused':
>
>Can this still be enforced using JSON schema? Using dependencies 
>to make sure that if subset-of is not present type is?

I have no clue. I know very little about json schema. I can take a look.


