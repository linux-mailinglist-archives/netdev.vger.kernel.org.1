Return-Path: <netdev+bounces-30977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A1978A572
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA541C20854
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 06:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8145581F;
	Mon, 28 Aug 2023 06:00:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742927ED
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:00:03 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F87115
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:00:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401c9525276so6256865e9.1
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1693202399; x=1693807199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGnE+bAqEzgFAo1EfPUa2dyvWOk2LeROJQyXne0QxZ4=;
        b=O4CYbavZqCGlxG92k8dJ2nEMIYhSW/Ee11yV0gtzXaG6s0WUJ8X+0Aud53EZVPLKLt
         jUt0p+4TnMPGXtKv8Uc56qVEy9sBvzS9khpw681IOp5/hybHXGetVsz/ez4QB31wpMxf
         WgoHwLJcx4mrULzNyL2kkCg0l5Tn1wU+rWllTMoLH0D5Q0LI88AO6RdeHpQPhoN0AhWW
         DBo+ceu4k/48U3rR4IFbfJOytc3Z8tn0rlQti837kQ9sjSz5ugh42tnIh0M9z3sDcl0J
         xj/Q3POZd1Nlxzi/oMuT/XjHw1a2qwJuPugImtjPC/hmWhDSBgNt1yuWrtQrArIjzObO
         e4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693202399; x=1693807199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGnE+bAqEzgFAo1EfPUa2dyvWOk2LeROJQyXne0QxZ4=;
        b=Quw/9DH5MHxwkDhCsWMUf0kaMk7ZHytLM4sADt7OmcaubFKSa1jbqG7j+qbwK2Ifsn
         +iIDgLs/MRE0wiSbfkCwYXo9SzayWae6DEWBnJmw/BxnbMEEDagO5j1Q+zXfqfoRoTSG
         zPzHxeo3c06HFSmGUj7GdAmKKxGvmjciww+ZoRBgGiGGnASsHeKgx6btzno0RjugTbJn
         NJrc2TPxXi7ac6huTR5i2nH+iEYUzrK5EU7rboDHx2xCNS8kCbOUbArT5I04o3VcXIc0
         9QdFHkkgazJSjqFLNowM171pKp3243Fqs6GeRLERBgpjgydQEvop7zx3GykspN67OdL0
         o5BQ==
X-Gm-Message-State: AOJu0YzGZNLp61O5qh+Fr58Yjd4L3TTkWs/xwmMomfvo7dvMMmIiq++7
	lQi+/+BC81wXDdWUzMK/qVg25w==
X-Google-Smtp-Source: AGHT+IFc4w9sx7Bd8vIMop/Fh73PS3V/w0Eeb5VQyk27b3heZ6oPDwigX3yFux7Jj2URYy2qG3B+xQ==
X-Received: by 2002:a7b:c7c3:0:b0:3fe:22fd:1b23 with SMTP id z3-20020a7bc7c3000000b003fe22fd1b23mr18415440wmk.34.1693202398944;
        Sun, 27 Aug 2023 22:59:58 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c2a4300b003fe601a7d46sm12723415wme.45.2023.08.27.22.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 22:59:58 -0700 (PDT)
Date: Mon, 28 Aug 2023 07:59:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com
Subject: Re: [patch net-next 00/15] devlink: finish file split and get retire
 leftover.c
Message-ID: <ZOw33WNViRcS7UmP@nanopsycho>
References: <20230825085321.178134-1-jiri@resnulli.us>
 <20230827171643.57743e55@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827171643.57743e55@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Aug 28, 2023 at 02:16:43AM CEST, kuba@kernel.org wrote:
>On Fri, 25 Aug 2023 10:53:06 +0200 Jiri Pirko wrote:
>> This patchset finishes a move Jakub started and Moshe continued in the
>> past. I was planning to do this for a long time, so here it is, finally.
>> 
>> This patchset does not change any behaviour. It just splits leftover.c
>> into per-object files and do necessary changes, like declaring functions
>> used from other code, on the way.
>> 
>> The last 3 patches are pushing the rest of the code into appropriate
>> existing files.
>
>Conflicts with Saeed's series, could you respin?

Sure. I'm on it.

