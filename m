Return-Path: <netdev+bounces-40826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE4F7C8BF6
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 19:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F6CDB209B5
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E821362;
	Fri, 13 Oct 2023 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="H11fZ8rw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48051C29F
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 17:07:12 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C04CF
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 10:07:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so4038587a12.2
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697216827; x=1697821627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E12q1te0xMpxhMA+H5nGVNs8h6DByaGZ32I0VIS9pys=;
        b=H11fZ8rwvup1CrqbG2jEqoHy1hM8u28scZaw72vgh7IQoijtaCnGkzqe0zUZesi7vt
         SKrgJEfiG5Cc1OwH8PbygLbHQXZ/HXcpCgyCrzAA9ivZbHtJK1yfxGROkBa2qWNvQoxB
         7jiAWE6FjuMhRNA2sgZ+zwZHLal201eIIhaqOFPeZXSY3L4iS8Uyvaw5s2iJjXtE80vQ
         jRYsa0tvc3dhX9CtoSSERupUCV08tD2ohWb8UA4ZtVIblKSgeU0KVUXdms39H4bDwfQX
         +wCisCTnlveCC2SeiX6l920MS05BHyRJ7ZHdcr1YYnJT4MUYfx+OM+2SMh4BDfpTnSDA
         CobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697216827; x=1697821627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E12q1te0xMpxhMA+H5nGVNs8h6DByaGZ32I0VIS9pys=;
        b=YSlmzPgAAKB2dIMoVssjZeyzwcWrE7/AthRMIRrbt3YWyBRugrhtTq3YijKZXEEeaZ
         nv+Kgc/7g+uuiAZIOXx5KHJ5Fl+7bNTWlvG2hbtO2ztQLitr+BcpHE8NPrJG0HHqlqMm
         OBqMMzSxtNAinMwJKJyoQh6aQ2Km/L3ztKKn5r0o4eQ5CzHBj7GvV0ln6d/IW4et0E5Q
         8LtaYgT9EdGtmsYM/6MbbAXknal6Djs0PG5lsw4ElbBELUaD2CgBq5zlZKyIhZsBGLdQ
         9fm1cxiSP+OGzWFddt4KfN4HFh6+zkxTCEOh3w/VEdu5XNXl5x5w4QcQau5hD6BUlmlp
         b1xQ==
X-Gm-Message-State: AOJu0YxyH8RrvVkcjMaMIMu77Ox50gN9ckgj2kLMgWHe4kkHMsZvjZx8
	BQODAauRwmzFjF6GlEr+VJLYZQ==
X-Google-Smtp-Source: AGHT+IGKHBntt4i2UROhLAHrxpedYC/m3f9E/cSysCSFMWX34kJlhj9l9LfJUBjm6qYS50xadNaLhg==
X-Received: by 2002:a17:906:fe07:b0:9bd:e036:387d with SMTP id wy7-20020a170906fe0700b009bde036387dmr1525326ejb.21.1697216827564;
        Fri, 13 Oct 2023 10:07:07 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h14-20020aa7de0e000000b00532eba07773sm11811658edv.25.2023.10.13.10.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:07:06 -0700 (PDT)
Date: Fri, 13 Oct 2023 19:07:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <ZSl5OS7bFsg/ahCK@nanopsycho>
References: <ZSQeNxmoual7ewcl@nanopsycho>
 <20231009093129.377167bb@kernel.org>
 <ZST9yFTeeTuYD3RV@nanopsycho>
 <20231010075231.322ced83@kernel.org>
 <ZSV0NOackGvWn7t/@nanopsycho>
 <20231010111605.2d520efc@kernel.org>
 <ZSakg8W+SBgahXtW@nanopsycho>
 <20231011172025.5f4bebcb@kernel.org>
 <ZSeOq+I+Z12E/oRC@nanopsycho>
 <20231013083945.3f6d8efe@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013083945.3f6d8efe@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Oct 13, 2023 at 05:39:45PM CEST, kuba@kernel.org wrote:
>On Thu, 12 Oct 2023 08:14:03 +0200 Jiri Pirko wrote:
>> >The current code is a problem in itself. You added another xarray,
>> >with some mark, callbacks and unclear locking semantics. All of it
>> >completely undocumented.  
>> 
>> Okay, I will add the documentation. But I thouth it is clear. The parent
>> instance lock needs to be taken out of child lock. The problem this
>> patch tries to fix is when the rntl comes into the picture in one flow,
>> see the patch description.
>> 
>> >The RCU lock on top is just fixing one obvious bug I pointed out to you.  
>> 
>> Not sure what obvious bug you mean. If you mean the parent-child
>> lifetime change, I don't know how that would help here. I don't see how.
>> 
>> Plus it has performance implications. When user removes SF port under
>> instance lock, the SF itself is removed asynchonously out of the lock.
>> You suggest to remove it synchronously holding the instance lock,
>> correct? 
>
>The SF is deleted by calling ->port_del() on the PF instance, correct?

That or setting opstate "inactive".


>
>> SF removal does not need that lock. Removing thousands of SFs
>> would take much longer as currently, they are removed in parallel.
>> You would serialize the removals for no good reason.
>
>First of all IDK what the removal rate you're targeting is, and what
>is achievable under PF's lock. Handwaving "we need parallelism" without
>data is not a serious argument.

Oh there are data and there is a need. My colleagues are working
on parallel creation/removal within mlx5 driver as we speak. What you
suggest would be huge setback :/


>
>> >Maybe this is completely unfair but I feel like devlink locking has
>> >been haphazard and semi-broken since the inception. I had to step in   
>> 
>> Well, it got broken over time. I appreciate you helped to fix it.
>> 
>> >to fix it. And now a year later we're back to weird locking and random
>> >dependencies. The only reason it was merged is because I was on PTO.  
>> 
>> Not sure what you mean by that. Locking is quite clear. Why weird?
>> What's weird exactly? What do you mean by "random dependencies"?
>> 
>> I have to say I feel we got a bit lost in the conversation.
>
>You have a rel object, which is refcounted, xarray with a lock, and 
>an async work for notifications.

Yes. The async work for notification is something you would need anyway,
even with object lifetime change you suggest. It's about locking order.
Please see the patchset I sent today (v3), I did put in a documentation
describing that (3 last patches). That should make it clear.


>
>All you need is a list, and a requirement that the PF can't disappear
>before SF (which your version also has, BTW).

It's not PF, but object contained in PF. Just to be clear. That does not
scale as we discuss above :/


