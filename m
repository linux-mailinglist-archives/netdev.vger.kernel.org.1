Return-Path: <netdev+bounces-22826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE1F7696B6
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 14:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7D91C20BA2
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 12:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1EC17FF9;
	Mon, 31 Jul 2023 12:47:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD24429
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 12:47:41 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2341992
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 05:47:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe1344b707so7074961e87.1
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 05:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690807630; x=1691412430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kXU17iNNbbIDhaqUsJXffcy9Yn0j2qk78Fkd47KX3Ao=;
        b=O+AO3KxoP/OWoe8Z0LT7yIk215OPbAHb7h3qNlEc3vc2+edKGouyHDo3B+veQn38em
         Xin6LAXk72K1DER6WeeAytIvCGDZhuDSDXyi83lvucztwGss2liQnkYaU5xKLZ2x1N5N
         Fc45go2Kom5RR2f8OlezRn6J95u/+S3Q9kyRD4/m6cSp6WhLnr6FWXAtTMpeLkAa4tRu
         C27Ll5s9qRSHrQ7AZIHATdS/n7utbFgf5OVSuvn8/nkh5xCmngWLvC3LfQNd1Qra6tE8
         nSWlxwG2xUK6TZEtTQnRZNNrfE/09MrLNOoOe0NZrDHDEK+v2l6DaI+E/sTDQmZQa/Zr
         vWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690807630; x=1691412430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXU17iNNbbIDhaqUsJXffcy9Yn0j2qk78Fkd47KX3Ao=;
        b=AX/g3x/YWbuYPqWCWIm36oJ6xUOAVkiztfnWisGuLoIvrguzfRTxmdZg41dUeGdEk1
         qNkfYqdhxzvav5ly4YzuC7ZhXaGbT5KGw6BhYQFj5BMIL0X0g//nxQ8fXSAIez4v+q9d
         OPQcJAZIiy6wZYnFbq2Wm35ca/yiCGsB6xFqg8T1pPIT50uXnZwk9OYc17kB0Hwiz1gg
         aa6pFoSE5cgO0usgWhwl1/ephle6wwSLtlutjarP9Q7fYmDOkFGgrVTdaAR44I57x/WN
         QFQ6tIWHDzEB6vok3buyztCcZ1xh/21K701Ef0Wo3eDk3iCHVq0TPvBeNirC66K66X4x
         C/dA==
X-Gm-Message-State: ABy/qLZaQFudvxjONqsjNhZDpBrYEKzDJVGQYikpafnAGPu1nzPEtYut
	ykvOLyCdTxqQSDt+zF79bxuKpw==
X-Google-Smtp-Source: APBJJlGNgTlYRMiUw8n7LHnhoRCFOsftxi/JjtHMlqb5cqiTWXWMfXBulmi9uaPy00z/Nrb22TUQAQ==
X-Received: by 2002:ac2:5f9c:0:b0:4f9:92c7:401d with SMTP id r28-20020ac25f9c000000b004f992c7401dmr5834745lfe.30.1690807630454;
        Mon, 31 Jul 2023 05:47:10 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id cw25-20020a170906c79900b009786c8249d6sm6121818ejb.175.2023.07.31.05.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:47:09 -0700 (PDT)
Date: Mon, 31 Jul 2023 14:47:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 10/11] devlink: introduce dump selector attr
 and use it for per-instance dumps
Message-ID: <ZMetTPCZ59rVLNyQ@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
 <20230720121829.566974-11-jiri@resnulli.us>
 <20230725114044.402450df@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725114044.402450df@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Jul 25, 2023 at 08:40:44PM CEST, kuba@kernel.org wrote:
>On Thu, 20 Jul 2023 14:18:28 +0200 Jiri Pirko wrote:
>> +static void devlink_nl_policy_cpy(struct nla_policy *policy, unsigned int attr)
>> +{
>> +	memcpy(&policy[attr], &devlink_nl_policy[attr], sizeof(*policy));
>> +}
>> +
>> +static void devlink_nl_dump_selector_policy_init(const struct devlink_cmd *cmd,
>> +						 struct nla_policy *policy)
>> +{
>> +	devlink_nl_policy_cpy(policy, DEVLINK_ATTR_BUS_NAME);
>> +	devlink_nl_policy_cpy(policy, DEVLINK_ATTR_DEV_NAME);
>> +}
>> +
>> +static int devlink_nl_start(struct netlink_callback *cb)
>> +{
>> +	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
>> +	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
>> +	struct nlattr **attrs = info->attrs;
>> +	const struct devlink_cmd *cmd;
>> +	struct nla_policy *policy;
>> +	struct nlattr **selector;
>> +	int err;
>> +
>> +	if (!attrs[DEVLINK_ATTR_DUMP_SELECTOR])
>> +		return 0;
>> +
>> +	selector = kzalloc(sizeof(*selector) * (DEVLINK_ATTR_MAX + 1),
>> +			   GFP_KERNEL);
>> +	if (!selector)
>> +		return -ENOMEM;
>> +	policy = kzalloc(sizeof(*policy) * (DEVLINK_ATTR_MAX + 1), GFP_KERNEL);
>> +	if (!policy) {
>> +		kfree(selector);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	cmd = devl_cmds[info->op.cmd];
>> +	devlink_nl_dump_selector_policy_init(cmd, policy);
>> +	err = nla_parse_nested(selector, DEVLINK_ATTR_MAX,
>> +			       attrs[DEVLINK_ATTR_DUMP_SELECTOR],
>> +			       policy, cb->extack);
>> +	kfree(policy);
>> +	if (err) {
>> +		kfree(selector);
>> +		return err;
>> +	}
>> +
>> +	state->selector = selector;
>> +	return 0;
>> +}
>
>Why not declare a fully nested policy with just the two attrs?

Not sure I follow. But the nest under DEVLINK_ATTR_DUMP_SELECTOR has
its own policy, generated by devlink_nl_dump_selector_policy_init(). I
did it this way instead of separate policy array for 2 reasons:
1) We don't have duplicate and possibly conflicting policies for devlink
   root and selector
2) It is easy for specific object type to pass attrs that are included
   in the policy initialization (see the health reporter extension later
   in this patchset). There are couple of object to benefit from this,
   for example "sb".
3) It is I think a bit nicer for specific object type to pass array of
   attrs, instead of a policy array that would be exported from netlink.c

If you insist on separate policy arrays, I can do it though. I had it
like that initially, I just decided to go this way for the 3 reasons
listed above.


>
>Also - do you know of any userspace which would pass garbage attrs 
>to the dumps? Do we really need to accept all attributes, or can
>we trim the dump policies to what's actually supported?

That's what this patch is doing. It only accepts what the kernel
understands. It gives the object types (as for example health reporter)
option to extend the attr set to accept them into selectors as well, if
they know how to handle them.


>-- 
>pw-bot: cr

