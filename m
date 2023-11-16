Return-Path: <netdev+bounces-48250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 139AA7EDBCE
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 08:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDCC280F32
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 07:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E21C2C0;
	Thu, 16 Nov 2023 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qsBHL6cI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2604182
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 23:14:29 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507b9408c61so641948e87.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 23:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700118868; x=1700723668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/nxaljah/OTCp64L0pw32SbzdsxFgbsHdXr8XpwRG94=;
        b=qsBHL6cIESLUpJ8LY8tOOfwIM/2WkkuzR4fWAaE6HGN+129q9sV+1Aj9pkssqXW5Qf
         IwKnclFIiBcIAWFJueqRAZIzRNGkbdW6hX230pARmJ3SFZ3/lZ6JxHHjeItOiLEENLbN
         /40B6aC+gPTBYguIfRfW8qNo2NmbGijBJVpHtW7P9sZqYNbGjJ+j3Zw1KzTf1wPpdx6d
         K6YScV5gZINmOJR3i9MDxhH7epZkDSJQ/HzDr6OyIM2lCqfSUxCV6evhEDyVQVUMtspi
         6wo9AWeq+5yEVR5XU4vloQTWZvqXrcv66xZa2EqsspOWamk+SkyMtu16NFLyHIzvn0KW
         +VNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700118868; x=1700723668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nxaljah/OTCp64L0pw32SbzdsxFgbsHdXr8XpwRG94=;
        b=ctGLFnInhN8vnwasgdz/8mCyHmft8pj4LGgjvCaqhaLeQwBDIFyXTeEXtyzvyhuZrb
         KIEe2z3jg2y+By5Jr5MEFRtVtpDnFuR0V7jBl6rrNnoboCP21zOMLOdhfQ/rY+8pfuul
         kCv/LtIz9ukaCJ/XXSkvQMGzhtLfNEGtMnJ24+Vr24CCuWd3NbStOGXDGFElaDnhP8gU
         uibejUn3RZy1SoqnubAMIf5COqJfmU/pyDiOdFD7kFbLdKP+T2pUbP6jKkYO+wX1dPBg
         t+/pUiDRvONJVIsZO7XBnj3YPac87aqNHePJRF/Lvy7nQ0FCoJhjWu6AMxkc0IMAs1SX
         l/fQ==
X-Gm-Message-State: AOJu0YxVDolc4wPO0hk+YL0336QTR3L4GjeeXNAQhvp122rPkBJPQGsl
	IjDiHWb2MThzMSEkwWQkbZX9nA==
X-Google-Smtp-Source: AGHT+IGX5DtIt2k77d7D5iRylziewRU7pk0/Ie01Fu/u8S793JyRcImjTWflWWQe/FHglJQm8/ekbg==
X-Received: by 2002:a05:6512:3ca9:b0:509:1033:c544 with SMTP id h41-20020a0565123ca900b005091033c544mr14933911lfv.50.1700118867807;
        Wed, 15 Nov 2023 23:14:27 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e15-20020a056402148f00b0053e625da9absm7342016edv.41.2023.11.15.23.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 23:14:27 -0800 (PST)
Date: Thu, 16 Nov 2023 08:14:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com
Subject: Re: [patch net-next 3/8] devlink: send notifications only if there
 are listeners
Message-ID: <ZVXBUorPrSmd7UNl@nanopsycho>
References: <20231115141724.411507-1-jiri@resnulli.us>
 <20231115141724.411507-4-jiri@resnulli.us>
 <63a83bf7-b2d3-4af6-b87b-4e166fa22744@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a83bf7-b2d3-4af6-b87b-4e166fa22744@intel.com>

Wed, Nov 15, 2023 at 09:17:17PM CET, jacob.e.keller@intel.com wrote:
>
>
>On 11/15/2023 6:17 AM, Jiri Pirko wrote:
>> +static inline bool devlink_nl_notify_need(struct devlink *devlink)
>> +{
>> +	return genl_has_listeners(&devlink_nl_family, devlink_net(devlink),
>> +				  DEVLINK_MCGRP_CONFIG);
>> +}
>> +
>
>I assume following changes will add more checks here to filter here so
>it doesn't make sense to call this "devlink_has_listeners"? I feel like
>the devlink_nl_notify_need is a bit weird of a way to phrase this.
>
>I don't have a strong objection to the name overall, just found it a bit
>odd.

Right. I named it like this because eventually, this function is going
to check the filters as well return false if there is no msg passed to
any listening socket through any filter. That is the plan.


>
>>  /* Notify */
>>  void devlink_notify_register(struct devlink *devlink);
>>  void devlink_notify_unregister(struct devlink *devlink);
>> diff --git a/net/devlink/health.c b/net/devlink/health.c
>> index 695df61f8ac2..93eae8b5d2d3 100644
>> --- a/net/devlink/health.c
>> +++ b/net/devlink/health.c
>> @@ -496,6 +496,9 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
>>  	WARN_ON(cmd != DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
>>  	ASSERT_DEVLINK_REGISTERED(devlink);
>>  
>> +	if (!devlink_nl_notify_need(devlink))
>> +		return;
>> +
>>  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>>  	if (!msg)
>>  		return;
>> diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
>> index 9d080ac1734b..45b36975ee6f 100644
>> --- a/net/devlink/linecard.c
>> +++ b/net/devlink/linecard.c
>> @@ -136,7 +136,7 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
>>  	WARN_ON(cmd != DEVLINK_CMD_LINECARD_NEW &&
>>  		cmd != DEVLINK_CMD_LINECARD_DEL);
>>  
>> -	if (!__devl_is_registered(devlink))
>> +	if (!__devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
>>  		return;
>>  
>
>A bunch of callers are checking both if its registered and a
>notification is needed, does it make sense to combine this? Or I guess
>at least a few places are notifying of removal after its no longer
>registered, so we can't inline the devl_is_registered into the
>devlink_nl_notify_need. Probably more clear to keep it separate too.

Yeah, it is more clear to have it separate. Plus there would have to be
2 locked and unlocked versions.


>
>Ok.

