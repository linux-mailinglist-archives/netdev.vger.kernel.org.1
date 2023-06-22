Return-Path: <netdev+bounces-12928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52002739776
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2E12816B4
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 06:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166C05239;
	Thu, 22 Jun 2023 06:29:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088671C05
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:29:38 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2CD199E
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 23:29:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b474dac685so66154641fa.3
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 23:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687415374; x=1690007374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2gbJaM97+TGyDFUFCPcPpHHFTQUtUYwV1I+Dgy+Y/E=;
        b=0bYKXoF9X/e4i7t1QztHMs7tKvxb0WcBEf1KXU1//3Qe4c9hjiPP3t0HVzxOtdpCvw
         FfOesQGGjBVWV8k9Hjn4Tnkce6k2Ummj3gP5LiPlC7pK9Zew7ButqhLo6SKNAPa94xhX
         WykZylJcW2ozA1fgFeScz3Hp6BfP22ci3iRKf33wH8txBKnxyReMyFAFT02se5Z1oiCo
         IfZg2AN23YEIlZnILrS398evuJK0lgrD+RSLDVM0J75e+zONav5Qiglm/wEXHbZm6cyO
         MX3JrU1uOT3fBGAa0VQneiSJCUs6ZUK2ImhYDYBHCw66R+UAMazDW8B4VZlp/7w0muXW
         s/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687415374; x=1690007374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2gbJaM97+TGyDFUFCPcPpHHFTQUtUYwV1I+Dgy+Y/E=;
        b=H4n+w45d6Vm1xqLCa2+pxL9J3HWlnrZ4cxQZhp4ngWUxXfReMTQ6uxP3u+R79gKbZY
         sgTkmKRnyF5LAshV0hVqjAdbyIVz/CkWbKfdy10Oxhrj4Go135M9c/KlvooTTAqoLfbP
         lnCMyMy7cASqWQ5avIzYke7MD0mvTig1W5EecjkDJBvrLzOsMg3P58LrGmIODfoliZNL
         haasGTPP8vcNBCaqutXgKR80cbcpO9LVm25y1jFEGitx3WhkZed1txGbwsx0NKHmI3rE
         iPAiS7EI8gybUJgI5BSzPs9LcGFVdszbISDcWp/sSbeKDqbauAGiTh8TYfwR6ZBoCI2C
         QUSQ==
X-Gm-Message-State: AC+VfDzJ+7FW7ianX84mw3/uOayzFyGSkEtPHohTZhV3Kq7lA6T8y1NY
	mqNbqTH+MUHsvr0jsi3i8VqWNFhAyYL6BHhWoSD6nA==
X-Google-Smtp-Source: ACHHUZ5+0dBtLdu7/18vqP/HL8mrnEWsoHw4A3UeXPjTRbS/F+2eOqbh3lXijKKcHTIYQoXv/Miccw==
X-Received: by 2002:a2e:8017:0:b0:2b4:5cbf:cb9d with SMTP id j23-20020a2e8017000000b002b45cbfcb9dmr11064342ljg.20.1687415373677;
        Wed, 21 Jun 2023 23:29:33 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id y7-20020a1c4b07000000b003f17848673fsm6773961wma.27.2023.06.21.23.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 23:29:32 -0700 (PDT)
Date: Thu, 22 Jun 2023 08:29:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com
Subject: Re: [RFC PATCH net-next 1/2] devlink: Hold a reference on parent
 device
Message-ID: <ZJPqS0Di6Cg9JT3D@nanopsycho>
References: <20230619125015.1541143-1-idosch@nvidia.com>
 <20230619125015.1541143-2-idosch@nvidia.com>
 <ZJLjlGo+jww6QIAg@nanopsycho>
 <ZJMYsyw06+jWVR5i@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJMYsyw06+jWVR5i@shredder>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jun 21, 2023 at 05:35:15PM CEST, idosch@nvidia.com wrote:
>On Wed, Jun 21, 2023 at 01:48:36PM +0200, Jiri Pirko wrote:
>> Mon, Jun 19, 2023 at 02:50:14PM CEST, idosch@nvidia.com wrote:
>> >@@ -91,6 +92,7 @@ static void devlink_release(struct work_struct *work)
>> > 
>> > 	mutex_destroy(&devlink->lock);
>> > 	lockdep_unregister_key(&devlink->lock_key);
>> >+	put_device(devlink->dev);
>> 
>> In this case I think you have to make sure this is called before
>> devlink_free() ends. After the caller of devlink_free() returns (most
>> probably .remove callback), nothing stops module from being removed.
>> 
>> I don't see other way. Utilize complete() here and wait_for_completion()
>> at the end of devlink_free().
>
>I might be missing something, but how can I do something like
>wait_for_completion(&devlink->comp) at the end of devlink_free()? After
>I call devlink_put() the devlink instance can be freed and the
>wait_for_completion() call will result in a UAF.

You have to move the free() to devlink_free()
Basically, all the things done in devlink_put that are symmetrical to
the initialization done in devlink_alloc() should be moved there.


>
>> 
>> If the completion in devlink_put() area rings a bell for you, let me save
>> you the trouble looking it up:
>> 9053637e0da7 ("devlink: remove the registration guarantee of references")
>> This commit removed that. But it is a different usage.
>> 
>> 
>> 
>> > 	kfree(devlink);
>> > }
>> > 
>> >@@ -204,6 +206,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
>> > 	if (ret < 0)
>> > 		goto err_xa_alloc;
>> > 
>> >+	get_device(dev);
>> > 	devlink->dev = dev;
>> > 	devlink->ops = ops;
>> > 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
>> >-- 
>> >2.40.1
>> >

