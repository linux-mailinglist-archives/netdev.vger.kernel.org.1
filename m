Return-Path: <netdev+bounces-14220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D109973F9DB
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 12:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBF11C20ABF
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EB6174D3;
	Tue, 27 Jun 2023 10:14:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124B10F9
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 10:14:15 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BC52952
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 03:13:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so5963437e87.2
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 03:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687860828; x=1690452828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QzW+EB1pujGEYMUURd0UfzMKtKrwioL+fXlEAfwoT4=;
        b=4ViGtxOsCHim+ygNMZtRS8DOXnp3frBZiULzArVhlw5Mt6JCZ8JsF9nYkxlRITHdIS
         cZ/1YcONv6O9f7QuQywx4LZDZ6pTf0bqJSS4SGzkmd7o4sgK3hNIPQJb/5sGasoDy4fq
         ssFds/DCpDpvV60lPSiYE5I6XaXYDjdq7MLFU+2nVkl8mJTvWsAPsYWxqfbOzGSxTNCy
         Sck85/r6wSbIXy5rh8SmnVFUIsUl6d6W1RNRjEiQNLE5n2EFo+KOxZSNLoMruVhFBu6U
         J5IixWYgm2DKpoRX3BDj1mQ8Mufi1kTS/ccNXaEzjCLuBOXLXdSPdLjBSqrFpw0TScik
         Z4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687860828; x=1690452828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QzW+EB1pujGEYMUURd0UfzMKtKrwioL+fXlEAfwoT4=;
        b=JThdGIqaV3Qwu3DB85Lv90Ax9i+nBbXlP3PX4ZxXWBnHJIf8R9olGHa/byZO8WM60L
         PaK1zvXfepF0DINiBmUfzE//MBiEbHBiROUGDHr6iuNf07HpvUmqjv2lv1eEIfOFuJA8
         yhCIu+608w15gClXJ3Q06G1H7+yYjDLyu1H4UjiH44YVsdv3YoIJvaBjTzD1ebDuZzRG
         LR44/R0aL1Qhl1JQoga8bEe0JaR4RNH9G+3G7ZVvhgq+pwXpqlG79WtujjSlOCteMYYa
         kApd8uPD2BAnYGYR8jKHSA3t8Hvyg9T1/LBRitwXJJZruirWK6emyzxDR2MAmMR0ZXQN
         xZ7A==
X-Gm-Message-State: AC+VfDy4NeuVgb8Bu8A4HLrAa+cGnykZiNmUHZPD/LoTnJJ1LJm37jXg
	RiDz45PKjIcPshsf9BqXbXwAvA==
X-Google-Smtp-Source: ACHHUZ7zqN8686JmwgiZclvHHJ05AYKDcLQrRYuynh+7oUIVv2+s+Ixn5SlCMBG6JJw1mIfwrSvIrg==
X-Received: by 2002:a19:911b:0:b0:4f9:5571:544f with SMTP id t27-20020a19911b000000b004f95571544fmr11656654lfd.17.1687860827910;
        Tue, 27 Jun 2023 03:13:47 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l6-20020a7bc446000000b003fba137857esm1774231wmi.14.2023.06.27.03.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 03:13:47 -0700 (PDT)
Date: Tue, 27 Jun 2023 12:13:46 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com
Subject: Re: [RFC PATCH net-next 1/2] devlink: Hold a reference on parent
 device
Message-ID: <ZJq2Wjuxr+ys2pPc@nanopsycho>
References: <20230619125015.1541143-1-idosch@nvidia.com>
 <20230619125015.1541143-2-idosch@nvidia.com>
 <ZJLjlGo+jww6QIAg@nanopsycho>
 <ZJMYsyw06+jWVR5i@shredder>
 <ZJPqS0Di6Cg9JT3D@nanopsycho>
 <ZJgrOAmhIycWSKtU@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJgrOAmhIycWSKtU@shredder>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sun, Jun 25, 2023 at 01:55:36PM CEST, idosch@nvidia.com wrote:
>On Thu, Jun 22, 2023 at 08:29:31AM +0200, Jiri Pirko wrote:
>> Wed, Jun 21, 2023 at 05:35:15PM CEST, idosch@nvidia.com wrote:
>> >On Wed, Jun 21, 2023 at 01:48:36PM +0200, Jiri Pirko wrote:
>> >> Mon, Jun 19, 2023 at 02:50:14PM CEST, idosch@nvidia.com wrote:
>> >> >@@ -91,6 +92,7 @@ static void devlink_release(struct work_struct *work)
>> >> > 
>> >> > 	mutex_destroy(&devlink->lock);
>> >> > 	lockdep_unregister_key(&devlink->lock_key);
>> >> >+	put_device(devlink->dev);
>> >> 
>> >> In this case I think you have to make sure this is called before
>> >> devlink_free() ends. After the caller of devlink_free() returns (most
>> >> probably .remove callback), nothing stops module from being removed.
>> >> 
>> >> I don't see other way. Utilize complete() here and wait_for_completion()
>> >> at the end of devlink_free().
>> >
>> >I might be missing something, but how can I do something like
>> >wait_for_completion(&devlink->comp) at the end of devlink_free()? After
>> >I call devlink_put() the devlink instance can be freed and the
>> >wait_for_completion() call will result in a UAF.
>> 
>> You have to move the free() to devlink_free()
>> Basically, all the things done in devlink_put that are symmetrical to
>> the initialization done in devlink_alloc() should be moved there.
>
>But it's a bit weird to dereference 'devlink' (to wait for the
>completion) after calling 'devlink_put(devlink)'. Given that this

Well, I don't see any problem in that.

>problem seems to be specific to netdevsim, don't you think it's better
>to fix it in netdevsim rather than working around it in devlink?

Up to you, both work.


>
>> 
>> 
>> >
>> >> 
>> >> If the completion in devlink_put() area rings a bell for you, let me save
>> >> you the trouble looking it up:
>> >> 9053637e0da7 ("devlink: remove the registration guarantee of references")
>> >> This commit removed that. But it is a different usage.
>> >> 
>> >> 
>> >> 
>> >> > 	kfree(devlink);
>> >> > }
>> >> > 
>> >> >@@ -204,6 +206,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
>> >> > 	if (ret < 0)
>> >> > 		goto err_xa_alloc;
>> >> > 
>> >> >+	get_device(dev);
>> >> > 	devlink->dev = dev;
>> >> > 	devlink->ops = ops;
>> >> > 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
>> >> >-- 
>> >> >2.40.1
>> >> >

