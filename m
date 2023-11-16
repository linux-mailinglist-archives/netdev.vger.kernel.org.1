Return-Path: <netdev+bounces-48251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEF47EDBD5
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 08:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81E8280FCB
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 07:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65DFBF7;
	Thu, 16 Nov 2023 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vNsIGEyb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE2A192
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 23:15:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso680911a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 23:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700118954; x=1700723754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fur0IPb7+2dgsUUb9UGdmoQ/0AZ2nQUoJZwsWUMftvQ=;
        b=vNsIGEybskGf881bbqv9uZMkpK4W+Npwldw7Umb+5x/LFFp1+3RHzw+r615wudBCQv
         DL6oyXEUzUjAUVPZ6AJF/Sm3gq4Y6GMT79M1CwYBNzQ1P9PMMvWbvS5+QzxtyKuS4UC6
         HW7+ZAHjuqsUeFcGaW1dRO5wxCYdT2M5ZVruXQmQ6FxCN2J1yDrCSm1mAUEEKzSZ2NBp
         VOdaPGQpdwx9vFzgBnGwP0JqTqDVaQ0ayNKs45Ycd9+oqBcssSchZbAeDlEDBYEXqdMD
         73aQbEt/SuepvywYegT74ZO4mUDYp95vynV3v8huS7NOd2/Zmc5+/QhuBCCpUVu77pM2
         vLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700118954; x=1700723754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fur0IPb7+2dgsUUb9UGdmoQ/0AZ2nQUoJZwsWUMftvQ=;
        b=Wb/g242s0hyZXfB96kVsK3dnrAdK+S3kFyLJSwfcphvJsknGk/L8FWw8hHTZJ9XWqg
         82US2wWfGewfI/r9wOGdI0ZHeCbPCGFxxMX31JI7eIZIH6AnfPhU5zjhqJFuW+nOdFnP
         7YWs7hM3b7ArXQP0ezE7+WQTvJDx732YUJeeGq1JlnflzzTBoI9dMlcatFefk0chJFk1
         8MHog3vH5pnObbiHlXPbT3bUdztxOeBHgkdGZwZ7/CMfhiC7NApyI8w7JpbFSwVvyIS6
         dujX/La/av1a9k2TY/lqhqT2TVJjLcwilzUJ1afnXo6QMVixsYsonEGdnY7GN5nSbZIQ
         pvUQ==
X-Gm-Message-State: AOJu0YwrJ/mCqhO+92jjDAhBV7TfMgLerth6yPJ2VsAR0luyu420+dL1
	2oWZr/OlZqGmSPkEwAVyP8rnpcloceozQinx6NY=
X-Google-Smtp-Source: AGHT+IHCCZMR5zeg+M6O50eP+E3T010xeKzCVk+wF67yDp3DTlWGD/RV90wdXWBdpkp6Ns2gq99ivw==
X-Received: by 2002:a05:6402:1acf:b0:543:bd27:f4a9 with SMTP id ba15-20020a0564021acf00b00543bd27f4a9mr11000923edb.12.1700118953939;
        Wed, 15 Nov 2023 23:15:53 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x4-20020aa7d384000000b005435d434a90sm7376824edq.57.2023.11.15.23.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 23:15:53 -0800 (PST)
Date: Thu, 16 Nov 2023 08:15:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
	jhs@mojatatu.com, johannes@sipsolutions.net,
	amritha.nambiar@intel.com, sdf@google.com
Subject: Re: [patch net-next 6/8] genetlink: introduce helpers to do filtered
 multicast
Message-ID: <ZVXBqGyBkalA3nM9@nanopsycho>
References: <20231115141724.411507-1-jiri@resnulli.us>
 <20231115141724.411507-7-jiri@resnulli.us>
 <ZVTbccC0VhT4CetU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVTbccC0VhT4CetU@smile.fi.intel.com>

Wed, Nov 15, 2023 at 03:53:37PM CET, andriy.shevchenko@linux.intel.com wrote:
>On Wed, Nov 15, 2023 at 03:17:22PM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Currently it is possible for netlink kernel user to pass custom
>> filter function to broadcast send function netlink_broadcast_filtered().
>> However, this is not exposed to multicast send and to generic
>> netlink users.
>> 
>> Extend the api and introduce a netlink helper nlmsg_multicast_filtered()
>> and a generic netlink helper genlmsg_multicast_netns_filtered()
>> to allow generic netlink families to specify filter function
>> while sending multicast messages.
>
>...
>
>> +/**
>> + * genlmsg_multicast_netns_filtered - multicast a netlink message
>> + *				      to a specific netns with filter
>> + *				      function
>> + * @family: the generic netlink family
>> + * @net: the net namespace
>> + * @skb: netlink message as socket buffer
>> + * @portid: own netlink portid to avoid sending to yourself
>> + * @group: offset of multicast group in groups array
>> + * @flags: allocation flags
>> + * @filter: filter function
>> + * @filter_data: filter function private data
>
>	scripts/kernel-doc -v -none -Wall ...
>
>will complain.

Will fix.


>
>> + */
>
>...
>
>> +				 int (*filter)(struct sock *dsk,
>> +					       struct sk_buff *skb,
>> +					       void *data),
>
>Since it occurs more than once, perhaps
>
>typedef int (*genlmsg_filter_fn)(struct sock *, struct sk_buff *, void *);

Makes sense. Will make that in a separate patch before this one.


>
>?
>
>...
>
>>  /**
>> - * nlmsg_multicast - multicast a netlink message
>> + * nlmsg_multicast_filtered - multicast a netlink message with filter function
>>   * @sk: netlink socket to spread messages to
>>   * @skb: netlink message as socket buffer
>>   * @portid: own netlink portid to avoid sending to yourself
>>   * @group: multicast group id
>>   * @flags: allocation flags
>> + * @filter: filter function
>> + * @filter_data: filter function private data
>
>I believe same complain by kernel-doc here and in more places...
>
>Can you at least make sure your patches do not add new ones and removes ones
>where you touch the code?

Okay.


>
>-- 
>With Best Regards,
>Andy Shevchenko
>
>

