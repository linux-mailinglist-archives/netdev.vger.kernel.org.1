Return-Path: <netdev+bounces-22827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF897696CE
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 14:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AA7281410
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB718001;
	Mon, 31 Jul 2023 12:52:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B768BF0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 12:52:49 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE83D102
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 05:52:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-986d8332f50so653515466b.0
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690807966; x=1691412766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgWupkEBbqnmC5BhDfBs1OoeJgSS7QCp0zNoBZUCR1o=;
        b=JxCOID2S9yCKbqXN8JxzKQmfeW63mQdl1uC2PDlT2vL5iZO7IrgTINsD/06xLK8+tR
         pghxBYoMYNEiinApbO+EIHb6ylopiaDctjBY5Sb9gBIiHRpIaKE1gPIxsQP2RJ+slKOw
         eE80F9WAf71fAPZHr5xaWx/VPRtUqtYZceR5bfGQTNe8l7CXNJAFamoCtqdim+c6mK0S
         IN4S4/TnjiROJkU0HViwSmz/rrusAmWdk5YFOWMTISpF/an4buEYbm76n2WcWhB6Mk4R
         MoMRmCq/DmvAMtWBIJuoOarAbIYUG5toiUAaZLQsISoFq5kHwuyZbNKhHlE3j7k98a75
         QVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690807966; x=1691412766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgWupkEBbqnmC5BhDfBs1OoeJgSS7QCp0zNoBZUCR1o=;
        b=QI2LUqUjn6NXrB9VkG9GszhZhHcd/j6bxkHwtxn7zj5mDBfWhdKvJbnhutFpRVcYKO
         8KIM55ostIoQrH2nUcMteYhRs4CuEp5es7oITwcKMQNBUNiM0HEVPJu6v+kKNAsZwOrr
         DxWP6FXC6SuTMO7o23qjbv7hw9nD0KSMblRHtdNHJ8JnCrA35BxpMmBxSgDFqvdk68Ug
         uY/vAHOCGi9Ui5pvpdeHVpSb+JZ/ACYYo7yHd0u0iY7/w3sn5QgkpUJLPf5UEP2t6SK7
         FyUNiX7GALczy2IOCDf7hIhY+73un47JEGak7sZkD1IwSwLBsZJw4pGKERolDf0+stv3
         pi3w==
X-Gm-Message-State: ABy/qLY4NuHjs8sIe49U0cTCjEuin3410qjbN/BOoT4FcoTYMB4QiGZY
	BUMzrVi1oMhNK5olUVb7mb/kGg==
X-Google-Smtp-Source: APBJJlFuc+oWqNgyJW9W9vlhQDVGA5aGOFdbPRpC6+jvlqZ1hZdSgcGWwPKIDN3s/fzLOgMA4nbQ5Q==
X-Received: by 2002:a17:906:cc58:b0:993:e9b8:90ee with SMTP id mm24-20020a170906cc5800b00993e9b890eemr5992684ejb.18.1690807966142;
        Mon, 31 Jul 2023 05:52:46 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090686cd00b0098884f86e41sm6064440ejy.123.2023.07.31.05.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:52:45 -0700 (PDT)
Date: Mon, 31 Jul 2023 14:52:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 11/11] devlink: extend health reporter dump
 selector by port index
Message-ID: <ZMeunKZscNRQTssp@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
 <20230720121829.566974-12-jiri@resnulli.us>
 <20230725114803.78e1ae00@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725114803.78e1ae00@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Jul 25, 2023 at 08:48:03PM CEST, kuba@kernel.org wrote:
>On Thu, 20 Jul 2023 14:18:29 +0200 Jiri Pirko wrote:
>> Introduce a possibility for devlink object to expose attributes it
>> supports for selection of dumped objects.
>> 
>> Use this by health reporter to indicate it supports port index based
>> selection of dump objects. Implement this selection mechanism in
>> devlink_nl_cmd_health_reporter_get_dump_one()
>
>This patch is not very clean. IMHO implementing the filters by skipping
>is not going to scale to reasonably complex filters. Isn't it better to

I'm not sure what do you mean by skipping? There is not skipping. In
case PORT_INDEX is passed in the selector, only that specific port is
processed. No scale issues I see. Am I missing something?


>add a .filter callback which will look at the about-to-be-dumped object
>and return true/false on whether it should be dumped?

No, that would not scale. Passing the selector attrs to the dump
callback it better, as the dump callback according to the attrs can
reach only what is needed, knowing the internals. But perhaps I don't
understand correctly your suggestion.

