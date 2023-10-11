Return-Path: <netdev+bounces-39994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E387C5590
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335701C20FD1
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BD81F942;
	Wed, 11 Oct 2023 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gLDRwfvL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015351F928
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 13:35:05 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5B790
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:35:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so65775455e9.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697031301; x=1697636101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dP5Q5Du7NAyXjtMY9uD2ENDLxtJmtUvg1pfS99UAKK4=;
        b=gLDRwfvL6xk5DPNWYrstjrAjpdSS0L0nK8kxbr8OmMy5z7taLSHi9bLcCQJDktMRuv
         gLtlw0FG4VDFue9mqQ2c5PjvRkUcUV/PwaBStFxgEVZ9sERtxvpclyBCegrkHSZe6QGy
         b23a5aQMRy2JVX/CMSYqH3eSY9aDe8qhCUdN7lge2tnibPRQNxrUiOGVBLJdK/R+dK5w
         7RvmkWmSzzY3HQ0qE53AQfeFmHA/22fgRiEXhNNJ0nYOOLQbCMV8OeOq9pdL5iRDms7m
         i6W3tvOmNDewnXmPECq21B8s53vzbACBy4OxrbrvhkYX39hpfjJ80rcrIYBYG+2jRjwa
         4W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697031301; x=1697636101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dP5Q5Du7NAyXjtMY9uD2ENDLxtJmtUvg1pfS99UAKK4=;
        b=pFqnDh2H+VJGozOyNZJUI+NqPaz93XdHId61V9kngZamO2xDpY+xgjFrP7FgAbLsQ1
         +vbZyjZistihN4JDnB9IDeiq4MbQbsUjsOHAcDGQBW+dj9qpPrZHBcqN6jWKwpiWKw1x
         nfRuoZFx0d9QDa8gUOYAaEPBYg50jRO+QWJW+vhMPhb8a2HQse7JHcSFUenUv1q1WBeL
         yGfnzIijhhw+vvnzCI+HkIBpvYp78hGafNSnbeXUMiytjoZsJxTeigqQBRFA+3trkfIL
         zEvNe8MGFTqgpX2QfuVVrsI97yLpGUXiLePUtXMRF5rvdQUlwCDfCAQ+O9t3+s4MSM7x
         W5yA==
X-Gm-Message-State: AOJu0YwCU877JKCBdFiuFGnuAymBz8yrbCI+zArNMIN3D2UyKIwf324b
	pnywJORXJ79mdY++I+pN8es7eb7Kj4VeTHjnLDw=
X-Google-Smtp-Source: AGHT+IERDgO4HSN33tTuJmyh+SPJECo0HeZPwPCxrGhfbNAezDV/2jzo0rbyEk6b7uGdDFs7p1Hjtg==
X-Received: by 2002:a7b:cd98:0:b0:405:1ba2:4fcb with SMTP id y24-20020a7bcd98000000b004051ba24fcbmr19313228wmj.16.1697031300933;
        Wed, 11 Oct 2023 06:35:00 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id y11-20020a05600c364b00b004063977eccesm19227045wmq.42.2023.10.11.06.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 06:35:00 -0700 (PDT)
Date: Wed, 11 Oct 2023 15:34:59 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <ZSakg8W+SBgahXtW@nanopsycho>
References: <ZSA+1qA6gNVOKP67@nanopsycho>
 <20231006151446.491b5965@kernel.org>
 <ZSEwO+1pLuV6F6K/@nanopsycho>
 <20231009081532.07e902d4@kernel.org>
 <ZSQeNxmoual7ewcl@nanopsycho>
 <20231009093129.377167bb@kernel.org>
 <ZST9yFTeeTuYD3RV@nanopsycho>
 <20231010075231.322ced83@kernel.org>
 <ZSV0NOackGvWn7t/@nanopsycho>
 <20231010111605.2d520efc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010111605.2d520efc@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 10, 2023 at 08:16:05PM CEST, kuba@kernel.org wrote:
>On Tue, 10 Oct 2023 17:56:36 +0200 Jiri Pirko wrote:
>> >You understand what I'm saying tho, right?
>> >
>> >If we can depend on the parent not disappearing before the child,
>> >and the hierarchy is a DAG - the locking is much easier, because
>> >parent can lock the child.  
>> 
>> It won't help with the locking though. During GET, the devlink lock
>> is taken and within it, you need to access the nested devlink attributes.
>> 
>> And during reload->notify, we still need work so the lock are taken in
>> proper order.
>
>If parent is guaranteed to exist the read only fields can be accessed
>freely and the read-write fields can be cached on children.

Only reason to access parent currently is netns change notification.
See devlink_rel_nested_in_notify().
It basically just scheduled delayed work by calling:
devlink_rel_nested_in_notify_work_schedule().

When work is processed in
devlink_rel_nested_in_notify_work()
There is no guarantee the parent exists, therefore devlink_index is used
to get the instance and then obj_index to get port/linecard index.

notify_cb() basically sends notification of parent object and that needs
parent instance lock. <--- This is why you need to lock the parent.

I see no way how to cache anything on children as you describe in this
scenario.


>Parent has a list of children, it can store/cache a netns pointer on all
>of them. When reload happens lock them and update that pointer.
>At which point children do not have to lock the parent.

Access of netns pointer is not a problem. See my latest version (v2)
where rcu is used in order to make sure peernet2id_alloc() call is safe:

devlink: call peernet2id_alloc() with net pointer under RCU read lock

       rcu_read_lock();
       devl_net = read_pnet_rcu(&devlink->_net);
       if (!net_eq(net, devl_net)) {
               int id = peernet2id_alloc(net, devl_net, GFP_ATOMIC);

               rcu_read_unlock();
               if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
                       return -EMSGSIZE;
       } else {
               rcu_read_unlock();
       }


>
>> It would only make the rel infrastructure a bit similer. I will look
>> into that. But it's parallel to this patchset really.
>

