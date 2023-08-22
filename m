Return-Path: <netdev+bounces-29522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929DA783A0F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 08:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B54280EA4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 06:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0568D3D7A;
	Tue, 22 Aug 2023 06:36:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5088EA8
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 06:36:16 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2847FB
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:36:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso24757071fa.1
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692686169; x=1693290969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ws4Om7IJDZL1lZk4Fmzxh32/5NrOqSEHZG4qiL0SXjY=;
        b=AMtoIIPVvd2+Zt2RykEYA6NU/vNJ3VI/1L8PP8hGJIZ7XVPKkg1M5EiggP1M9Tq5DJ
         ndJ+9a4MLonnfWLIE3pmCMbZVKCHBMmOssKMVi8KJjfwdZPKPyTEFHwi6ZevSkTIFNLR
         2L3FDYD7eC4um7mFfU9N5raKlO8b8K3SLz8Cas+PZ//O4gzKtlPllgBiPlb6i+1WI4VA
         eed1J5E023b1WN8Ozh4cOnzI61qgKdeEnyxW4/UPxFjKfn23okG4y3+xYtw7N8jd99yR
         0kIxDBsFR5mdN6PDTCpDmhSAlLV1P94Y4VSeEEa4HojmKA2gHeIqllJBwosccE2O3Dj2
         nrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692686169; x=1693290969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ws4Om7IJDZL1lZk4Fmzxh32/5NrOqSEHZG4qiL0SXjY=;
        b=aqgmRXzlGc+Mo/VM7Hn+4EyoI8/U6col2ZSnAxS3SQX9SJgqwk4eoI9D46wU0bQnnT
         /1JBssqXr5HIZkXFDYcnUvl38xFcOSP5s5rILYTdBqy1auyxELJ2VtWb3AUp+v3Kub1B
         Kmy1Y54DXh8Bog72Jn68X063wLDVDCDCI9T+NPik8PXMZsWkfneDFaWkeZiQD16wjk9b
         +rEWJ3yHvz+Oevuqyk+DvEdncq72gb4cYZ4aBirdhvo8P2aqH6T3S6kJ+deQd7L40qd8
         JZYXW8d/fJjOAXUfvW+HmVV379PaPdqQdr+otVDpo7huMmt3tsjsyJBh8QRWbU7cWEjf
         5vgg==
X-Gm-Message-State: AOJu0YwLi4GdbMoeVA4HmC/oXJDSkS1vOqiDEk/lfcQT2DUXYNEjc/Gs
	bIA6+5aCBBNLLFY/LoRZXrZAIHiT51lz7EoMWSKJx09J
X-Google-Smtp-Source: AGHT+IHGQkfdNNPQ/X4Mazvlt6LYne5NG71nsENy1yHWl+3ifzVSgCbSNfyLRnkH3Zg/XMEavOCcAQ==
X-Received: by 2002:a2e:9a8b:0:b0:2bc:d376:1bb5 with SMTP id p11-20020a2e9a8b000000b002bcd3761bb5mr295720lji.19.1692686168819;
        Mon, 21 Aug 2023 23:36:08 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b003fe1a96845bsm18328507wmh.2.2023.08.21.23.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 23:36:07 -0700 (PDT)
Date: Tue, 22 Aug 2023 08:36:06 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	shayd@nvidia.com, leon@kernel.org
Subject: Re: [patch net-next 0/4] net/mlx5: expose peer SF devlink instance 
Message-ID: <ZORXVr4bcTlbstj8@nanopsycho>
References: <20230815145155.1946926-1-jiri@resnulli.us>
 <20230817193420.108e9c26@kernel.org>
 <ZN8eCeDGcQSCi1D6@nanopsycho>
 <20230818142007.206eeb13@kernel.org>
 <ZONBUuF1krmcSjoM@nanopsycho>
 <20230821131937.7ed01b55@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821131937.7ed01b55@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Aug 21, 2023 at 10:19:37PM CEST, kuba@kernel.org wrote:
>On Mon, 21 Aug 2023 12:49:54 +0200 Jiri Pirko wrote:
>> Fri, Aug 18, 2023 at 11:20:07PM CEST, kuba@kernel.org wrote:
>> >On Fri, 18 Aug 2023 09:30:17 +0200 Jiri Pirko wrote:  
>> >> SF devlink instance is created in init_ns and can move to another one.
>> >> So no.
>> >> 
>> >> I was thinking about this, as with the devlink handles we are kind of in
>> >> between sysfs and network. We have concept of network namespace in
>> >> devlink, but mainly because of the related netdevices.
>> >> 
>> >> There is no possibility of collision of devlink handles in between
>> >> separate namespaces, the handle is ns-unaware. Therefore the linkage to
>> >> instance in different ns is okay, I believe. Even more, It is handy as
>> >> the user knows that there exists such linkage.
>> >> 
>> >> What do you think?  
>> 
>> First of all, I'm having difficulties to understand exactly what you
>> say. I'll try my best with the reply :)
>> 
>> >The way I was thinking about it is that the placement of the dl
>> >instance should correspond to the entity which will be configuring it.
>> >
>> >Assume a typical container setup where app has net admin in its
>> >netns and there is an orchestration daemon with root in init_net 
>> >which sets the containers up.
>> >
>> >Will we ever want the app inside the netns to configure the interface
>> >via the dl instance? Given that the SF is like giving the container
>> >full access to the HW it seems to me that we should also delegate   
>> 
>> Nope. SF has limitations that could be set by devlink port function
>> caps. So no full HW access.
>> 
>> 
>> >the devlink control to the app, i.e. move it to the netns?
>> >
>> >Same thing for devlink instances of VFs.  
>> 
>> Like VFs, SFs are getting probed by mlx5 driver. Both create the devlink
>> instances in init_ns. For both the user can reload them to a different
>> netns. It's consistent approach.
>> 
>> I see a possibility to provide user another ATTR to pass during SF
>> activation that would indicate the netns new instance is going to be
>> created in (of course only if it is local). That would provide
>> the flexibility to solve the case you are looking for I believe.
>> ***
>>
>> >The orchestration daemon has access to the "PF" / main dl instance of
>> >the device, and to the ports / port fns so it has other ways to control
>> >the HW. While the app would otherwise have no devlink access.
>> >
>> >So my intuition is that the devlink instance should follow the SF
>> >netdev into a namespace.  
>> 
>> It works the other way around. The only way to change devlink netns is
>> to reload the instance to a different netns. The related
>> netdevice/netdevices are reinstantiated to that netns. If later on the
>> user decides to move a netdev to a different netns, he can do it.
>> 
>> This behavious is consistent for all devlink instances, devlink port and
>> related netdevice/netdevices, no matter if there is only one netdevice
>> of more. What you suggest, I can't see how that could work when instance
>> have multiple netdevices.
>
>Netdevs can move to netns without their devlink following (leaving
>representors aside). We can't change that because uAPI.
>But can we make it impossible to move SFs by themselves and require
>devlink reload to move them?

That is how we currently implement SFs in mlx5. Example:
$ sudo devlink dev eswitch set pci/0000:08:00.0 mode switchdev
$ sudo devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 106
pci/0000:08:00.0/32768: type eth netdev eth4 flavour pcisf controller 0 pfnum 0 sfnum 106 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
$ sudo devlink port function set pci/0000:08:00.0/32768 state active
$ devlink dev
pci/0000:08:00.0
pci/0000:08:00.1
auxiliary/mlx5_core.sf.2
$ sudo ip netns add ns1
$ sudo devlink dev reload auxiliary/mlx5_core.sf.2 netns ns1
$ devlink dev
pci/0000:08:00.0
pci/0000:08:00.1
$ sudo ip netns exec ns1 devlink dev
auxiliary/mlx5_core.sf.2


>
>> >And then the next question is - once the devlink instances are in
>> >different namespaces - do we still show the "nested_devlink" attribute?
>> >Probably yes but we need to add netns id / link as well?  
>> 
>> Not sure what is the usecase. Currently, once VFs/SFs/ could be probed
>> and devlink instance created in init_ns, the orchestrator does not need
>> this info.
>> 
>> In future, if the extension I suggested above (***) would be
>> implemented, the orchestrator still knows the netns he asked the
>> instance to be created in.
>> 
>> So I would say is it not needed for anything. Plus it would make code
>> more complex making sure the notifications are coming in case of SF
>> devlink instance netns changes.
>> 
>> So do you see the usecase? If not, I would like to go with what I have
>> in this patchset version.
>
>I'm thinking about containers. Since the SF configuration is currently
>completely vendor ad-hoc I'm trying to establish who's supposed to be
>in control of the devlink instance of an SF - orchestrator or the
>workload. We should pick one and force everyone to fall in line.

I think that both are valid. In the VF case, the workload (VM) owns the
devlink instance and netdev. In the SF case:
1) It could be the same. You can reload SF into netns, then
   the container has them both. That would provide the container
   more means (e.g. configuration of rdma,netdev,vdev etc).
2) Or, your can only put netdev into netns.

Both usecases are valid. But back to my question regarding to this
patchsets. Do you see the need to expose netns for nested port function
devlink instance? Even now, I still don't.


