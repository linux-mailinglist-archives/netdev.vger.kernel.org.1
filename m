Return-Path: <netdev+bounces-29283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CE778275F
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 12:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45640280E80
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2124C7D;
	Mon, 21 Aug 2023 10:50:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E434C6D
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 10:50:00 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E7DDC
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 03:49:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso31433075e9.3
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 03:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692614996; x=1693219796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+lN0+IGayThxnga723PyHme0lBxDtILznlbkbp2uxY=;
        b=x2vY/3yrfaqI0g1mx1krIhF4Yq80+wTphOBNWYwbvpipXFjkdsSLuAVcymK11K301R
         iWNrzXuy3FEpg3S9OUgpwWlhqXkYFQeAUcUSebuLHyHt/Jz6EvMQVRoR79Xmshx8FVWI
         zmmZAZFIy4iFDdtxwvKzGF2cugSi7lM9C04h07oiT1wFUnvRcxil0bmH2pWLyF56LxxC
         WCqZKUb57KaQnUDPN+lU5i05us0rjfH7lE5kQU3zqcLQwaox3+S8s8WrkmtZRFyATfep
         tD5c7rT5EjuOpc47CcxnAX68X6DRYJl9kRvZCc3QvHJqo5tKxBVV4OyWF1Nh8LR6UnOs
         8QJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692614996; x=1693219796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+lN0+IGayThxnga723PyHme0lBxDtILznlbkbp2uxY=;
        b=AKIGaobwDafGzQfUQD1+QQ27LGRxTTyArWgf8sOgoy8kqkZgaIejyVmid+7jsczmbW
         6c8O3opJudroZhNwP/va4FY8g4OPtXxMxbPBZ1ttI9rUc2b6hPRwBzWX0XCDSHXGUYn5
         v/mkdWAOu8Tul+o99ZxJJBMGW8D1bu5c+5MPyWDQTIklFd/4HeNg0aUvb/FfXJnb5tqa
         TYQOvOHtGFoSMFopS20ta4zg7MdrMcv3srfYE+bYmqJkDVi5C8mIELQOHPIK71nqNT+n
         dKPqUO9925Vrizb0UANkuWqCVaTPeNmhOwqHgM+NBWFIPdqzVyNbLO8LrnuxiTX+9aFX
         VNKw==
X-Gm-Message-State: AOJu0Yz3AjHYAYm/I7N9ofH///FKPNkY91ggW49Lm2q3afP8EuvxqPr7
	tloJaZIvvh1aMA//dfOOYP1+0w==
X-Google-Smtp-Source: AGHT+IHuDn/WthxXrTIBs44zVpSkx5/xH6waEg2bdGG9q24sAZELKvNkvSLYJh580rBDwwpdp9VhUg==
X-Received: by 2002:a05:6000:11:b0:319:8436:d77d with SMTP id h17-20020a056000001100b003198436d77dmr4891208wrx.37.1692614996024;
        Mon, 21 Aug 2023 03:49:56 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q16-20020a05600000d000b0031c56218984sm2209661wrx.104.2023.08.21.03.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 03:49:55 -0700 (PDT)
Date: Mon, 21 Aug 2023 12:49:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	shayd@nvidia.com, leon@kernel.org
Subject: Re: [patch net-next 0/4] net/mlx5: expose peer SF devlink instance
Message-ID: <ZONBUuF1krmcSjoM@nanopsycho>
References: <20230815145155.1946926-1-jiri@resnulli.us>
 <20230817193420.108e9c26@kernel.org>
 <ZN8eCeDGcQSCi1D6@nanopsycho>
 <20230818142007.206eeb13@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818142007.206eeb13@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 18, 2023 at 11:20:07PM CEST, kuba@kernel.org wrote:
>On Fri, 18 Aug 2023 09:30:17 +0200 Jiri Pirko wrote:
>> >The devlink instance of the SF stays in the same network namespace 
>> >as the PF?  
>> 
>> SF devlink instance is created in init_ns and can move to another one.
>> So no.
>> 
>> I was thinking about this, as with the devlink handles we are kind of in
>> between sysfs and network. We have concept of network namespace in
>> devlink, but mainly because of the related netdevices.
>> 
>> There is no possibility of collision of devlink handles in between
>> separate namespaces, the handle is ns-unaware. Therefore the linkage to
>> instance in different ns is okay, I believe. Even more, It is handy as
>> the user knows that there exists such linkage.
>> 
>> What do you think?
>

First of all, I'm having difficulties to understand exactly what you
say. I'll try my best with the reply :)


>The way I was thinking about it is that the placement of the dl
>instance should correspond to the entity which will be configuring it.
>
>Assume a typical container setup where app has net admin in its
>netns and there is an orchestration daemon with root in init_net 
>which sets the containers up.
>
>Will we ever want the app inside the netns to configure the interface
>via the dl instance? Given that the SF is like giving the container
>full access to the HW it seems to me that we should also delegate 

Nope. SF has limitations that could be set by devlink port function
caps. So no full HW access.


>the devlink control to the app, i.e. move it to the netns?
>
>Same thing for devlink instances of VFs.

Like VFs, SFs are getting probed by mlx5 driver. Both create the devlink
instances in init_ns. For both the user can reload them to a different
netns. It's consistent approach.

I see a possibility to provide user another ATTR to pass during SF
activation that would indicate the netns new instance is going to be
created in (of course only if it is local). That would provide
the flexibility to solve the case you are looking for I believe.
***

>
>The orchestration daemon has access to the "PF" / main dl instance of
>the device, and to the ports / port fns so it has other ways to control
>the HW. While the app would otherwise have no devlink access.
>
>So my intuition is that the devlink instance should follow the SF
>netdev into a namespace.

It works the other way around. The only way to change devlink netns is
to reload the instance to a different netns. The related
netdevice/netdevices are reinstantiated to that netns. If later on the
user decides to move a netdev to a different netns, he can do it.

This behavious is consistent for all devlink instances, devlink port and
related netdevice/netdevices, no matter if there is only one netdevice
of more. What you suggest, I can't see how that could work when instance
have multiple netdevices.


>
>And then the next question is - once the devlink instances are in
>different namespaces - do we still show the "nested_devlink" attribute?
>Probably yes but we need to add netns id / link as well?

Not sure what is the usecase. Currently, once VFs/SFs/ could be probed
and devlink instance created in init_ns, the orchestrator does not need
this info.

In future, if the extension I suggested above (***) would be
implemented, the orchestrator still knows the netns he asked the
instance to be created in.

So I would say is it not needed for anything. Plus it would make code
more complex making sure the notifications are coming in case of SF
devlink instance netns changes.

So do you see the usecase? If not, I would like to go with what I have
in this patchset version.


