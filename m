Return-Path: <netdev+bounces-39533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 500E87BF9EF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2721C20B3C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E7718C2D;
	Tue, 10 Oct 2023 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Le27YFJH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC917171DE
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:40:04 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C36AC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:40:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3247d69ed2cso5309907f8f.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696937999; x=1697542799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFC/sXIq9nCSaoAMnClcuzF+AzyAJKy6Npzb7iz+l7c=;
        b=Le27YFJHU3dgbiC3g3MLRa8MXUVE4IRBFiabCSaecl6iG7d+VbAJGx5zpNVqAbCP68
         ajx/+iYvxkwgo/p1D2jA0EO9PCjpr756WHBR+99oDRW6SF93oqnMA2GepoHOGZoXOF+g
         ytR6DLaoZLt9DnL8rqDjnTGaxpIKuyCxnfOUXhj17VLIlUZVEqo67Jf1Up8CcCIHqHHL
         BkEoykxMehNWLjjWcvxuM+qpeYXxqS8T9FSwIYTAmotWSvuLmlWZ9SGTH2oGRzx+3MUB
         X9tq3sbJHEKn+VLNISSGvQsxCZt5opNqJNnSIjIRLDqmAENBQt7ts8MuYh6bhy93+BTT
         KV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696937999; x=1697542799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFC/sXIq9nCSaoAMnClcuzF+AzyAJKy6Npzb7iz+l7c=;
        b=NEtrLXThm6j/gzhgU69oiagDdgC8gN3MII5AmltepKvY3m2ruKWfHGsN1S6RHBKpw7
         qhsMs2VqFgcHatX51k4hcYh/KOl68zHxJ1SpOq2rK3TnN4XxdQv/bnBooz64v9VYZv/p
         CSlJWJcDUGAwL68hrBNEAJgQJWWd7qrZLc+KCruXxwqeB3twJWZaKodKjlS2ZDs5wa9y
         /iOilWclvjUbSSmpJTOGNOHZBlVLy6+2mg/kvyisRZPFi+hvQs10R6ntQVYe3VsLuYWE
         XMvcYcgoVBDjBQSJXbqK0qV9Ysvg1wCfECTnYK0sE3qFkWeHzLxyWHfk/BON43WS2Ed0
         WltQ==
X-Gm-Message-State: AOJu0YwdIv7Ni1BjzlqUNE+vBiiA8W9R4oXyttHZzJ//UiyGYctMmhLH
	uHrZkezbP6qIFpeE7n6NeRRfwA==
X-Google-Smtp-Source: AGHT+IE+1xhIVSCjOxkz5TnGZfMTFR3D4CciD3SJ3rzye8ZdbLCs4RAwW2Ny61N9hWzfG0t2pUV69w==
X-Received: by 2002:a5d:6447:0:b0:31f:fb5d:96da with SMTP id d7-20020a5d6447000000b0031ffb5d96damr16398907wrw.64.1696937999451;
        Tue, 10 Oct 2023 04:39:59 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id bv28-20020a0560001f1c00b0032d402f816csm1292196wrb.98.2023.10.10.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:39:58 -0700 (PDT)
Date: Tue, 10 Oct 2023 13:39:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com
Subject: Re: [patch net-next 01/10] genetlink: don't merge dumpit split op
 for different cmds into single iter
Message-ID: <ZSU4DExDGm3M9dLY@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
 <20231010110828.200709-2-jiri@resnulli.us>
 <25c23d3482cb2747ee386543dce53cf212c899c3.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25c23d3482cb2747ee386543dce53cf212c899c3.camel@sipsolutions.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 10, 2023 at 01:24:31PM CEST, johannes@sipsolutions.net wrote:
>On Tue, 2023-10-10 at 13:08 +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Currently, split ops of doit and dumpit are merged into a single iter
>> item when they are subsequent. However, there is no guarantee that the
>> dumpit op is for the same cmd as doit op.
>> 
>> Fix this by checking if cmd is the same for both.
>
>It's confusing, but I don't think this is needed, I believe
>genl_validate_ops() ensures that do comes before dump, and the commands
>are sorted, so that you cannot end up in this situation?

Apply this patchset w/o this patch and you'll hit it :) Otherwise I
would not care...

The problem is dumpit op of cmd Y with previous doit op of cmd X. They
should not be merged, they are not same cmd, yet existing code does
that.


>
>And even if you can end up in this situation, I don't think this patch
>is the correct way to address it - we should then improve the validation
>in genl_validate_ops() instead.

The problem is incorrect merge of 2 consequent split ops into iter.
This function does the merging. Where else to fix it?


>
>(And maybe add a comment here, but ...)
>
>johannes
>

