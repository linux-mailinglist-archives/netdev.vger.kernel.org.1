Return-Path: <netdev+bounces-23523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431D276C56C
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA118281CAE
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 06:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1297D373;
	Wed,  2 Aug 2023 06:41:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FFBEBB
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:41:57 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202542D55
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 23:41:52 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-99bdf08860dso124940466b.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 23:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690958510; x=1691563310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sDOiuG0vkWfw9xL3HMTphBilrSkywllkCvYolakreYQ=;
        b=ppzu8+bR8Xuggl7Vv9IzYUi6zBUrokirRoDnVGBroYY1NZ7MyhYMfvYFZH8926Ylw5
         hDDRhCKzlYZ9Hgsg7KLvugAPKZieoecJobcyHUtMXr56Dr1vp04FXgSH2J2zQWEFBKkR
         N6sDG4iBpI77azVLCrw6sYOcUmSwgiT7OfZzQ6a640atXkZkHENiN3HyB7xJiWnY3LX3
         YLPrv+wO/Lzp11nsZ1e+WieKz09sp82zW918t3fPrP731FfbRURG2xaNIOTi/GlyJ5qY
         j0E6mU2kCeq+BzVrmnbYBo8C9Zxzw4X9SzlP8QMaTQzQMJAp/b3iVgIyohY89To01JZf
         6yJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690958510; x=1691563310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDOiuG0vkWfw9xL3HMTphBilrSkywllkCvYolakreYQ=;
        b=hwBHltNwrkQCyEnizX2eDP9JW1vPPtNz52xA+nkj5/qjEN6xoNeI+zzjLkUUM8OCVH
         jPDUx97q5BAlOI7PJOf5E5PN5ExqdArZoROrx2AWdIz0XFIvD8LKBbqH/fUoSU0LylCY
         ne1cDA9pnpmuoMrXs3DFF3g+NnnLz+2Rl/DKdtwXQ9lBLuiNRLsrjdkUbAQ/NNaGDOSW
         VCtjXs8oL2ToqSvu2YjRFRGm4+ssSTJCzV2H/bkad6+CETMJjBYaJyA9i1EvxJf93Qay
         FEw6gEIIPj2pYHG8Z81suImaUcr55kNrPf3o9GZ4eyyIC4p1fLNtF1QdavifY1JCcJws
         aANg==
X-Gm-Message-State: ABy/qLbksbeMI4rcg9j7MMyWrsT/XR/iTyIshlJy+TD23ddLbGsd6W/y
	Iwid9ihSOP8+a7z1d/PjBc5TTQ==
X-Google-Smtp-Source: APBJJlE3+kPEZxQIDU9yXUjw4SHRdKMGQ0EM9i2Jn/3ha7r8EN+aQ/WPCecGRETRFHmc3rD3dryLJg==
X-Received: by 2002:a17:907:6daa:b0:99b:af5a:fc2c with SMTP id sb42-20020a1709076daa00b0099baf5afc2cmr5753191ejc.26.1690958510333;
        Tue, 01 Aug 2023 23:41:50 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id pk15-20020a170906d7af00b0099bd6026f45sm8577005ejb.198.2023.08.01.23.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 23:41:49 -0700 (PDT)
Date: Wed, 2 Aug 2023 08:41:48 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next 1/8] ynl-gen-c.py: fix rendering of validate
 field
Message-ID: <ZMn6rLwl8tL+RmNh@nanopsycho>
References: <20230801141907.816280-1-jiri@resnulli.us>
 <20230801141907.816280-2-jiri@resnulli.us>
 <20230801112530.277d3090@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801112530.277d3090@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 01, 2023 at 08:25:30PM CEST, kuba@kernel.org wrote:
>On Tue,  1 Aug 2023 16:19:00 +0200 Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> For split ops, do and dump has different value in validate field. Fix
>> the rendering so for do op, only "strict" is filled out and for dump op,
>> "strict" is prefixed by "dump-".
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  tools/net/ynl/ynl-gen-c.py | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
>> index 650be9b8b693..1c36d0c935da 100755
>> --- a/tools/net/ynl/ynl-gen-c.py
>> +++ b/tools/net/ynl/ynl-gen-c.py
>> @@ -1988,9 +1988,17 @@ def print_kernel_op_table(family, cw):
>>                  cw.block_start()
>>                  members = [('cmd', op.enum_name)]
>>                  if 'dont-validate' in op:
>> +                    dont_validate = []
>> +                    for x in op['dont-validate']:
>> +                        if op_mode == 'do' and x == 'dump':
>> +                            continue
>> +                        if op_mode == "dump" and x == 'strict':
>> +                            x = 'dump-' + x
>> +                        dont_validate.append(x)
>> +
>>                      members.append(('validate',
>>                                      ' | '.join([c_upper('genl-dont-validate-' + x)
>> -                                                for x in op['dont-validate']])), )
>> +                                                for x in dont_validate])), )
>>                  name = c_lower(f"{family.name}-nl-{op_name}-{op_mode}it")
>>                  if 'pre' in op[op_mode]:
>>                      members.append((cb_names[op_mode]['pre'], c_lower(op[op_mode]['pre'])))
>
>I was hoping we can delete GENL_DONT_VALIDATE_DUMP_STRICT
>but there is one cmd (TIPC_NL_LINK_GET) which
>sets GENL_DONT_VALIDATE_STRICT and nothing about the dump.

I need GENL_DONT_VALIDATE_STRICT for devlink dump selectors as well. I
don't want to break existing user that may pass garbage attributes.

>
>To express something like that we should add dump-strict as
>an allowed flag explicitly rather than doing the auto-prepending

Yeah, that was an option. But strict means GENL_DONT_VALIDATE_STRICT
for do and GENL_DONT_VALIDATE_DUMP_STRICT for dump. That is why I
decided to go this way.

I will add dump-strict if you prefer it, I don't care.

>-- 
>pw-bot: cr

