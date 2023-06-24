Return-Path: <netdev+bounces-13704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508A573CA37
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 11:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C571C21222
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405984417;
	Sat, 24 Jun 2023 09:33:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D8E211A
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 09:33:26 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E9F1BE4
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 02:33:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f9b258f3a2so18161365e9.0
        for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687599202; x=1690191202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp6HVeJRXdco6A41V3XseExK/GY+kMyzcZfuBr9RNpc=;
        b=gIKlIOLY9cHfmDYP+SLJW2xjfwdnCaX//IlHXzA57AfU1HfLtNfSdpV7e+sWJkSq4y
         BuhpLocpp6Aj7eZaUBVELZ8I/iAEhoB2EfyD493E08UXUf9NqTvk51rGjBmtM3CJe7Xb
         0Usr43dxO9Mr0XD3MvnVn3HX3iC3pPHhMM89+8S3PI47s/yE2kuxYMgJBBo/inYO8ufz
         eT13Mrn0NZqOJSZviOkRvPFA4AHe5JHSd/YfvZLx9KiyaW1U/M3JkippJ48SmnPRqkB9
         tN52OmEWl0Ish629QLN+NmubXgPzKivFn5xCNoaCrb6hy+uj7LCuE8tye7P8hY844Grq
         EopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687599202; x=1690191202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp6HVeJRXdco6A41V3XseExK/GY+kMyzcZfuBr9RNpc=;
        b=iPPRSyBtzw1D8DEaUI1wjd6iTeyNjGdXDoMXuAMOS4HgjCYpvTRHhCFWkxO7ZOXDiL
         YMhMxSZ6Cy2Hocpzd1PRV0GDYJ3NIQuv+PRbUYkp6vKTg4CNihrqwn91/E/GYedBN3oq
         t0Jat8Egdl7Nt9gYX7Vg9jyY52Lga5S78/9MWWYUaFZN0Ws4PznH3loJXBDTFCZbDnwM
         ZYxONErAnLvMqi+ESB39wKtHqEAE03kNNHm9obiPLFYIIW4Kx146RnWIWhG4rGruTeKk
         gYU2qagy73Xg/rqxPIEDoSYFCqht96c8vBOKCVC7TM6/5jwblQatH55zMQZvlQeSe7+Q
         MUdw==
X-Gm-Message-State: AC+VfDxzf+8gitCcX+2b+93v+64Fq4YXpiANjEo+KZruqH7zWSRjiRj+
	I0a9dCBNNTmCSdA7723zU7yZxA==
X-Google-Smtp-Source: ACHHUZ7Sun4gJqymzuXqFWj0EOOF8KXBQkc6PdS4014QYOzlLtswZswDUTPyJsEhh7X35514YRTmgg==
X-Received: by 2002:a7b:ce14:0:b0:3f9:7a15:1716 with SMTP id m20-20020a7bce14000000b003f97a151716mr14467745wmc.5.1687599202419;
        Sat, 24 Jun 2023 02:33:22 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003f8f8fc3c32sm1659191wmk.31.2023.06.24.02.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 02:33:21 -0700 (PDT)
Date: Sat, 24 Jun 2023 11:33:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [net-next 14/15] net/mlx5: Light probe local SFs
Message-ID: <ZJa4YPtXaLOJigVM@nanopsycho>
References: <20230613190552.4e0cdbbf@kernel.org>
 <ZIrtHZ2wrb3ZdZcB@nanopsycho>
 <20230615093701.20d0ad1b@kernel.org>
 <ZItMUwiRD8mAmEz1@nanopsycho>
 <20230615123325.421ec9aa@kernel.org>
 <ZJL3u/6Pg7R2Qy94@nanopsycho>
 <ZJPsTVKUj/hCUozU@nanopsycho>
 <20230622093523.18993f44@kernel.org>
 <ZJVlbmR9bJknznPM@nanopsycho>
 <20230623082108.7a4973cc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623082108.7a4973cc@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Jun 23, 2023 at 05:21:08PM CEST, kuba@kernel.org wrote:
>On Fri, 23 Jun 2023 11:27:10 +0200 Jiri Pirko wrote:
>> Thu, Jun 22, 2023 at 06:35:23PM CEST, kuba@kernel.org wrote:
>> >SG. For the IPU case when spawning from within the IPU can we still
>> >figure out what the auxdev id is going to be? If not maybe we should  
>> 
>> Yeah, the driver is assigning the auxdev id. I'm now trying to figure
>> out how to pass that to devlink code/user nicely. The devlink instance
>> for the SF does not exist yet, but we know what the handle is going to
>> be. Perhaps some sort of place holder instance would do. IDK.
>> 
>> >add some form of UUID on both the port and the sf devlink instance?  
>> 
>> What about the MAC?
>> 
>> $ sudo devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 102
>> pci/0000:08:00.0/32769: type eth netdev eth8 flavour pcisf controller 0 pfnum 0 sfnum 102 splittable false
>>   function:
>>     hw_addr 00:00:00:00:00:00 state inactive opstate detached
>> $ sudo devlink port function set pci/0000:08:00.0/32769 hw_addr AA:22:33:44:55:66
>> $ sudo devlink port function set pci/0000:08:00.0/32769 state active
>> $ ip link show eth9
>> 15: eth9: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>>     link/ether aa:22:33:44:55:66 brd ff:ff:ff:ff:ff:ff
>> 
>> There are 2 issues with this:
>> 1) If the hw_addr stays zeroed for activation, random MAC is generated
>> 2) On the SF side, the MAC is only seen for netdev. That is problematic
>>    for SFs without netdev. However, I don't see why we cannot add
>>    devlink port attr to expose hw_addr on the SF.
>
>Yeah, the fact that mac add of zero has special meaning could be

True. But I believe we can sanitize this in devlink core, not allowing
to activate zeroed mac. Instead of radom generating of a mac on the SF
side, we random generate it on the eswitch port function side.

I think this can work.


>problematic. Other vendors may get "inspired" by the legacy SR-IOV
>semantics of MAC addr of zero == user can decide, or whatnot.
>The value on the port is the admin-set MAC, not the current MAC

True, that is why I suggested to expose hw_addr attr on devlink port of
the SF instance, where this would be fixed no matter what the user does
on the actual netdevice.


>of the SF after all, right? Probably best to find another way...


Well, yeah. The mac/hw_addr is quite convenient. It's there and
I believe that any device could work with that. Having some kind of
"extra cookie" would require to implement that in FW, which makes things
more complicated.


>
>> >Maybe there's already some UUID in the vfio world we can co-opt?  
>> 
>> Let me check that out.

