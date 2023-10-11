Return-Path: <netdev+bounces-39827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203757C49A0
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDE41C20BAB
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04621FC08;
	Wed, 11 Oct 2023 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gFY6JBcg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93B354F0
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:09:02 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F135398
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:09:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53b962f09e0so6123300a12.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697004539; x=1697609339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j+BLBUljX0HpZurVboiKBOjo+uEpNMVY9V1xmcZegac=;
        b=gFY6JBcgw0Rc7jXQcg36cZaH3uzyP0R5l3XhNACRVQcU5hzBNrUAFNaM+5CrK0J0YW
         SQvf1APLUX2Ip/RprjwXaFG9xSw8dyPy4vTO8LyetFuKDSjg06RKnRXXPJRJy/RWkbw9
         2SHh4V0ZwFKRhn00g6W0aMT9PEcF9GCM8TbchRGnb0hIC8zWc11ifGciL5a0LUVV/1mW
         oRe0N/5GhxnlL+9Ab+nnNqMVFfibuh3GLZ0CBVu3RBdtX/859EsJWYLgkwadrJ6UJVIU
         R/2jKrvd+vNuqlOkd0woccM0u0UtEIez4Yu8ZBL2NQu4465aV+x6QF4pvn4W4jn7fnQj
         Ftiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697004539; x=1697609339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+BLBUljX0HpZurVboiKBOjo+uEpNMVY9V1xmcZegac=;
        b=SDBdIBU/AjIfUvbE36lTbWZTBAXo+RPVHKNbimcsYAUu5Ig/MlRCqkofknWhiq+5CG
         cOYcjryWoAKB9ayQM8+k1QL/SVvWddgcQoaTE2oPDf1tRWXvNnom0X3qQraujyQ6Q13Q
         9W20GOPZGUyxWIFbsr0D3JLYcqidun8YVef7Tu7NFVUJynbps+GbLtw6utWfmmXa6aYs
         jF5iAT2rbpHSNZx47RiDOPrj5SIpJFKWTony4fI+9mgyumG6tsuoty2pf5PyJvcne5ki
         v1icTalQfFQnw3uYq+tYH+cpDwL4mv8BJ+sg2Fp5oK7Qo18oUoTf049sAaI5Up+imt6z
         EFNA==
X-Gm-Message-State: AOJu0YyUAtiKGBtgo/3kkFFRWeilVO3P7/Z/AQzpy7UyiToUVsNkjH5y
	m3n/m9AgvGxfJvisK5ORezUOgw==
X-Google-Smtp-Source: AGHT+IEfURdi7u1pt23iJKgchab4CtmMqeuNpl2UUoHg/yAORwj2EnZMA5llEX2s0OL+jbTcP1634A==
X-Received: by 2002:aa7:c549:0:b0:532:c72e:26fe with SMTP id s9-20020aa7c549000000b00532c72e26femr18674622edr.10.1697004539336;
        Tue, 10 Oct 2023 23:08:59 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e7-20020a50fb87000000b00533c844e337sm8527656edq.85.2023.10.10.23.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:08:58 -0700 (PDT)
Date: Wed, 11 Oct 2023 08:08:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: Re: [patch net-next 01/10] genetlink: don't merge dumpit split op
 for different cmds into single iter
Message-ID: <ZSY7+b5qQhKgzXo5@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
 <20231010110828.200709-2-jiri@resnulli.us>
 <20231010114845.019c0f78@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010114845.019c0f78@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 10, 2023 at 08:48:45PM CEST, kuba@kernel.org wrote:
>On Tue, 10 Oct 2023 13:08:20 +0200 Jiri Pirko wrote:
>> Fixes: b8fd60c36a44 ("genetlink: allow families to use split ops directly")
>
>Drop Fixes, add "currently no family declares ops which could trigger
>this issue".

Yeah, we need fixes semantics written down somewhere.
I can do it, sure.


>
>>  	if (i + cnt < family->n_split_ops &&
>> -	    family->split_ops[i + cnt].flags & GENL_CMD_CAP_DUMP) {
>> +	    family->split_ops[i + cnt].flags & GENL_CMD_CAP_DUMP &&
>> +	    (!cnt ||
>> +	     (cnt && family->split_ops[i + cnt].cmd == iter->doit.cmd))) {
>
>Why are you checking cnt? if do was not found cmd will be 0, which
>cannot mis-match.

Correct. Will remove cnt check.

