Return-Path: <netdev+bounces-40232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8E97C6537
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4DC1C20A39
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 06:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB59D28A;
	Thu, 12 Oct 2023 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NJ9GBBaa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B21A28EF
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 06:14:10 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194E1A9
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:14:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bdcade7fbso88457566b.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697091245; x=1697696045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4HQzK95S9Wjb2C0nruurvcp8jEQs9ZhaOvxPRUnER0=;
        b=NJ9GBBaaISXMLVBd2vGBqX/geatDQYO/5MSi36QgGyjtxmfABblrT2VNaKJFmdeS/g
         jNI40/yN1tSBMvNFOBdsCBXPQqF+AE0U+yUnLS7syD3pqlaZOXjzfXU9WZE6F9iywQI7
         qCRQg7g3Z7XToMIFYVHgwgqSI4V54/P5NQJ4Vac1+6E/H7J3+eVVNH2UHmPiQ5LzkujG
         L4qzxBTMAbxfphYzzKtUtt3hsKM7kyZAAP+mHOZKsNQFDQAg7w2vMKQ3RTlM+Hr/lfKR
         ZMpjicxxfQf+3bIYwkzARRgxx+RmGzfoWNMeRyNtl/pkKXGc2AghWZkBgFhewlE+qCFO
         GA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091245; x=1697696045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4HQzK95S9Wjb2C0nruurvcp8jEQs9ZhaOvxPRUnER0=;
        b=GtfGVhuuN3Xj6fT1PwL2qgt8NB+x4XU0E5s35eLQuxOq4TQR/UP2YYw1xfK2x4MJ37
         TY72PUIssidV4k3z1f8687l9LM4my2b7cBLL/lQm9aJZLogYojb32pW0SSFHXRpnz6OY
         +v+tTi0gb0LpyLRNwEMbzT4zaAlvMERqFY14YomxqdLOVL4uwebESVUfD9oz2Wc9Zic3
         nUj/VVHpQaz7CkB3W3TrgD0LGEMxux9qf963VIBg1UiskitXq8oEnhUfAfi0hAB/04Vp
         sQsDSMaSrLAb8+OqFD0PDjI4D7oSWT9notsf/Ss1HznFo7ToHfEJg0JmY4HX2/y4wrBG
         0kbg==
X-Gm-Message-State: AOJu0YwD4dU1aDlqmId1sicFJjWHHgtGBkWUis2bz1GqoOc34tNuJMQP
	bRlbmTifzKyOfLX3rBhlJbc37A==
X-Google-Smtp-Source: AGHT+IHNvEmBLi8xvtHV6MxPIm2hBCo5Wmp5yk50fCjrdC/4cPFmYdotXD4lFiTh66ariItUL2QvgQ==
X-Received: by 2002:a17:907:7702:b0:9b2:b2ad:2a76 with SMTP id kw2-20020a170907770200b009b2b2ad2a76mr19191357ejc.16.1697091245393;
        Wed, 11 Oct 2023 23:14:05 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u13-20020a1709060b0d00b009ad87d1be17sm10620092ejg.22.2023.10.11.23.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:14:04 -0700 (PDT)
Date: Thu, 12 Oct 2023 08:14:03 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <ZSeOq+I+Z12E/oRC@nanopsycho>
References: <ZSEwO+1pLuV6F6K/@nanopsycho>
 <20231009081532.07e902d4@kernel.org>
 <ZSQeNxmoual7ewcl@nanopsycho>
 <20231009093129.377167bb@kernel.org>
 <ZST9yFTeeTuYD3RV@nanopsycho>
 <20231010075231.322ced83@kernel.org>
 <ZSV0NOackGvWn7t/@nanopsycho>
 <20231010111605.2d520efc@kernel.org>
 <ZSakg8W+SBgahXtW@nanopsycho>
 <20231011172025.5f4bebcb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011172025.5f4bebcb@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Oct 12, 2023 at 02:20:25AM CEST, kuba@kernel.org wrote:
>On Wed, 11 Oct 2023 15:34:59 +0200 Jiri Pirko wrote:
>> >If parent is guaranteed to exist the read only fields can be accessed
>> >freely and the read-write fields can be cached on children.  
>> 
>> Only reason to access parent currently is netns change notification.
>> See devlink_rel_nested_in_notify().
>> It basically just scheduled delayed work by calling:
>> devlink_rel_nested_in_notify_work_schedule().
>> 
>> When work is processed in
>> devlink_rel_nested_in_notify_work()
>> There is no guarantee the parent exists, therefore devlink_index is used
>> to get the instance and then obj_index to get port/linecard index.
>> 
>> notify_cb() basically sends notification of parent object and that needs
>> parent instance lock. <--- This is why you need to lock the parent.
>> 
>> I see no way how to cache anything on children as you describe in this
>> scenario.
>> 
>> 
>> >Parent has a list of children, it can store/cache a netns pointer on all
>> >of them. When reload happens lock them and update that pointer.
>> >At which point children do not have to lock the parent.  
>> 
>> Access of netns pointer is not a problem. 
>
>The current code is a problem in itself. You added another xarray,
>with some mark, callbacks and unclear locking semantics. All of it
>completely undocumented.

Okay, I will add the documentation. But I thouth it is clear. The parent
instance lock needs to be taken out of child lock. The problem this
patch tries to fix is when the rntl comes into the picture in one flow,
see the patch description.

>
>The RCU lock on top is just fixing one obvious bug I pointed out to you.

Not sure what obvious bug you mean. If you mean the parent-child
lifetime change, I don't know how that would help here. I don't see how.

Plus it has performance implications. When user removes SF port under
instance lock, the SF itself is removed asynchonously out of the lock.
You suggest to remove it synchronously holding the instance lock,
correct? SF removal does not need that lock. Removing thousands of SFs
would take much longer as currently, they are removed in parallel.
You would serialize the removals for no good reason.


>
>Maybe this is completely unfair but I feel like devlink locking has
>been haphazard and semi-broken since the inception. I had to step in 

Well, it got broken over time. I appreciate you helped to fix it.


>to fix it. And now a year later we're back to weird locking and random
>dependencies. The only reason it was merged is because I was on PTO.

Not sure what you mean by that. Locking is quite clear. Why weird?
What's weird exactly? What do you mean by "random dependencies"?

I have to say I feel we got a bit lost in the conversation.




