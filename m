Return-Path: <netdev+bounces-17854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD123753478
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDA42821A7
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29273748E;
	Fri, 14 Jul 2023 08:00:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD468486
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:00:58 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5FE3C02
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:00:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-986d8332f50so213026466b.0
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689321651; x=1691913651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrnCz7Hfa4sPSf5kg/sc1xt8fKauTd641qFFpeMSqVw=;
        b=5S7EK8awIjLEzgP9Gn9bymlk7alkjE8hfmrAQJwffEyZmYHYb0LtdrYdly5Jqx27Ra
         /EmEZAf7EGtlXrpTMVfS4sAdBVSFq2/8IEcqb3KleCqHpTDgqvpFIKrXTyDIEeX9U/7I
         X0Z1Uc5QqcFXziH/VKFa1xVLpBe0lxrwm5pXoLyQlqY/UY+CJ11CnDDs5vkYIqShnwgG
         i3F3otwWz4QtiadTpvgKJCUMjGU7pqmg9QEbmtvM8Zm+3Jes4/1OzR2O7ymTKmZ91cxj
         5yBWBycETnbf8C1eiZk47vEkgRvQMGz9NU/c7wNB6t6QLO9Vk4n+m4pXs3HdMMZJ0JiB
         YtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321651; x=1691913651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrnCz7Hfa4sPSf5kg/sc1xt8fKauTd641qFFpeMSqVw=;
        b=Ag21VBJpzXW6NuD29NyGgM1wJ6nGBptTkFAry/9q/xbFGuBOFpIC4KA4oQeI+cRYQ6
         0lFP8OrdJ8RH2qsXwJEnXnvqBQexR8Ju+PHDembwzuZzexcBTXXXYQS59QMKzB2Hw3qI
         dX2DgJR1/sDnQ8XUaMBSwExIdJzzc5Ul7rYy0XtjYd1RQA9ZczT83ibD8GACvS28K0CO
         989FP2OAi9fHc5lI3uU7LfRRMIAMn9gpReoE8P98NzfwYehxQ4V3d7VWLDxlwK9ofkEg
         amYe/whj4BzzYPyIW0hoDx4pxINkoNUF4i+fNnJ9e4t1Etw3Bw/Eqz6NSrJZHnENzl+C
         nPog==
X-Gm-Message-State: ABy/qLZYaSVNbuH9N6pgrLgYRVJJP5Hg50qP3i72x4b6BxSPBWDJcrp+
	oCWIjT95CS+cWaY2ka3kk7F4FQ==
X-Google-Smtp-Source: APBJJlFwon6C/Lhq8iTmXP+SeHRj0Uw1dcqS6fqyACGMQ9EKMiNbvq5k8UPGdSNDkn1fl2Czz+/LQw==
X-Received: by 2002:a17:907:9541:b0:978:b94e:83dd with SMTP id ex1-20020a170907954100b00978b94e83ddmr3157602ejc.75.1689321650871;
        Fri, 14 Jul 2023 01:00:50 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id l24-20020a1709065a9800b00991bba473e1sm4999149ejq.3.2023.07.14.01.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:00:50 -0700 (PDT)
Date: Fri, 14 Jul 2023 10:00:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com
Subject: Re: [patch net-next] devlink: introduce dump selector attr and
 implement it for port dumps
Message-ID: <ZLEAsaKj+eKYlceM@nanopsycho>
References: <20230713151528.2546909-1-jiri@resnulli.us>
 <20230713205141.781b3759@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713205141.781b3759@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Jul 14, 2023 at 05:51:41AM CEST, kuba@kernel.org wrote:
>On Thu, 13 Jul 2023 17:15:28 +0200 Jiri Pirko wrote:
>> +	/* If the user provided selector attribute with devlink handle, dump only
>> +	 * objects that belong under this instance.
>> +	 */
>> +	if (cmd->dump_selector_nla_policy &&
>> +	    attrs[DEVLINK_ATTR_DUMP_SELECTOR]) {
>> +		struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
>> +
>> +		err = nla_parse_nested(tb, DEVLINK_ATTR_MAX,
>> +				       attrs[DEVLINK_ATTR_DUMP_SELECTOR],
>> +				       cmd->dump_selector_nla_policy,
>> +				       cb->extack);
>> +		if (err)
>> +			return err;
>> +		if (tb[DEVLINK_ATTR_BUS_NAME] && tb[DEVLINK_ATTR_DEV_NAME]) {
>> +			devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), tb);
>> +			if (IS_ERR(devlink))
>> +				return PTR_ERR(devlink);
>> +			err = cmd->dump_one(msg, devlink, cb);
>> +			devl_unlock(devlink);
>> +			devlink_put(devlink);
>> +			goto out;
>> +		}
>
>This implicitly depends on the fact that cmd->dump_one() will set and
>pay attention to state->idx. If it doesn't kernel will infinitely dump
>the same instance. I think we should explicitly check state->idx and
>set it to 1 after calling ->dump_one.

Nothing changes, only instead of iterating over multiple devlinks, we
just work with one.

So, the state->idx is in-devlink-instance index. That means, after
iterating to next devlink instance it is reset to 0 below (state->idx = 0;).
Here however, as we stay only within a single devlink instance,
the reset is not needed.

Am I missing something?


>
>Could you also move the filtered dump to a separate function which
>either does this or calls devlink_nl_instance_iter_dumpit()?
>I like the concise beauty that devlink_nl_instance_iter_dumpit()
>currently is, it'd be a shame to side load it with other logic :]

No problem. I put the code here as if in future the selector attr nest
would be passed down to dump_one(), there is one DEVLINK_ATTR_DUMP_SELECTOR
processing here. But could be resolved later on.

Will do.

>
>> +	}
>> +
>>  	while ((devlink = devlinks_xa_find_get(sock_net(msg->sk),
>>  					       &state->instance))) {
>>  		devl_lock(devlink);
>> @@ -228,6 +259,7 @@ int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
>>  		state->idx = 0;
>>  	}
>>  
>> +out:
>>  	if (err != -EMSGSIZE)
>>  		return err;
>>  	return msg->len;
>-- 
>pw-bot: cr

