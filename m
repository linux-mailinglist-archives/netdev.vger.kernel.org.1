Return-Path: <netdev+bounces-53808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FE5804B56
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3814281603
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 07:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEE9286A2;
	Tue,  5 Dec 2023 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iS/ge1xz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6488FCB
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 23:47:47 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1b68ae40efso256828766b.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 23:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701762466; x=1702367266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w+CcGcui1YmWg+yt9qsWBMYdAtBu93YJ8/xh6Ot4PfE=;
        b=iS/ge1xzxyDshARpdlcb/s1mSTiVKkrBeOYxqAYLVes+nT/PNq2ue+e8jM5LXONYOu
         uk4UE/NFbNOnW+SFqRPfxuZ+o1rDmb7TVPAs2oNsy690P9OJ4IoNIoCJNigDAwalPpZM
         WsYS7v5FWFf82YsNrvQqyFNQkewblC3y2O/YIol6i93I3YtckM6oBA1i/Q1XvIfTcCCk
         3vhcYyt7pa+I6RtrAwaFPp2X7EsD3fGAobSW7LhEma0hXvLur1gcCOzQ3SUEZmol8zAC
         QZBLx3+Zs5BIT8hZc8Vz6ejwlgsgEGSvqcK3ry/gfLXFQuO5orCyDNrvc/vUoBesjgQ3
         S5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701762466; x=1702367266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+CcGcui1YmWg+yt9qsWBMYdAtBu93YJ8/xh6Ot4PfE=;
        b=mKaccm10gj9vB0l0wxyyj46LCsmrMGwQwPP5V2eG9jsa6FLA4TYhPK2euFOmaoNxnX
         pSt5KnZKZYjYVH56JrfwJdy9BJwojvE9EI3LcPxwF+7je3+Vm/aJyku2HqqB0x9Io+Uz
         yP8EB1Tpe/wQCYiRrB+EqWjquuX7aFc64RBGTCPO8bZ6Q44CQ5NZQvCcTtm1NUD9b5Dh
         jBlEffdbKh1paweFElEODjBbdpuVQVJnzZkiZdp21/4hWlHTVnhTXUO5DOVog8nU/ePS
         fPqbGRymIPETczzva6vFUjChDGdvPvL7pW9Gvqs/M1T7UwvaVDYhwzAeOLPSr2mavHyg
         y5NQ==
X-Gm-Message-State: AOJu0YzlXmDAzUx3inqHLDNl4RZbEAEDjTQUVeWVJQB3j03quIQIIzyh
	/qXeJ6lDBW0SkqwVlDWwKy+2og==
X-Google-Smtp-Source: AGHT+IEX0SSip1LlmZtIdYDvvYVqWhZt1DDKhOqWvJjzS6UghApcKJXUFnj0D1fjvUPQeZdZNMgXrw==
X-Received: by 2002:a17:906:2244:b0:a19:4f2b:f78a with SMTP id 4-20020a170906224400b00a194f2bf78amr3469088ejr.5.1701762465762;
        Mon, 04 Dec 2023 23:47:45 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906279500b00a0949d4f66fsm6195440ejc.54.2023.12.04.23.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 23:47:45 -0800 (PST)
Date: Tue, 5 Dec 2023 08:47:43 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"Hadi Salim, Jamal" <jhs@mojatatu.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"Nambiar, Amritha" <amritha.nambiar@intel.com>,
	"sdf@google.com" <sdf@google.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [patch net-next v4 8/9] devlink: add a command to set
 notification filter and use it for multicasts
Message-ID: <ZW7Vn4F6bm2hYgpi@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-9-jiri@resnulli.us>
 <6dbb53ac-ec93-31cd-5201-0d49b0fdf0bb@intel.com>
 <ZW39QoYQUSyIr89P@nanopsycho>
 <CO1PR11MB5089142F465D060B9AE3FDC0D686A@CO1PR11MB5089.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB5089142F465D060B9AE3FDC0D686A@CO1PR11MB5089.namprd11.prod.outlook.com>

Mon, Dec 04, 2023 at 08:17:24PM CET, jacob.e.keller@intel.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Monday, December 4, 2023 8:25 AM
>> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
>> Cc: kuba@kernel.org; pabeni@redhat.com; davem@davemloft.net;
>> edumazet@google.com; Keller, Jacob E <jacob.e.keller@intel.com>; Hadi Salim,
>> Jamal <jhs@mojatatu.com>; johannes@sipsolutions.net;
>> andriy.shevchenko@linux.intel.com; Nambiar, Amritha
>> <amritha.nambiar@intel.com>; sdf@google.com; horms@kernel.org;
>> netdev@vger.kernel.org
>> Subject: Re: [patch net-next v4 8/9] devlink: add a command to set notification
>> filter and use it for multicasts
>> 
>> Mon, Nov 27, 2023 at 04:40:22PM CET, przemyslaw.kitszel@intel.com wrote:
>> >On 11/23/23 19:15, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >>
>> 
>> [...]
>> 
>> 
>> >> diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
>> >> index fa9afe3e6d9b..33a8e51dea68 100644
>> >> --- a/net/devlink/netlink.c
>> >> +++ b/net/devlink/netlink.c
>> >> @@ -17,6 +17,79 @@ static const struct genl_multicast_group
>> devlink_nl_mcgrps[] = {
>> >>   	[DEVLINK_MCGRP_CONFIG] = { .name =
>> DEVLINK_GENL_MCGRP_CONFIG_NAME },
>> >>   };
>> >> +int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
>> >> +				      struct genl_info *info)
>> >> +{
>> >> +	struct nlattr **attrs = info->attrs;
>> >> +	struct devlink_obj_desc *flt;
>> >> +	size_t data_offset = 0;
>> >> +	size_t data_size = 0;
>> >> +	char *pos;
>> >> +
>> >> +	if (attrs[DEVLINK_ATTR_BUS_NAME])
>> >> +		data_size += nla_len(attrs[DEVLINK_ATTR_BUS_NAME]) + 1;
>> >> +	if (attrs[DEVLINK_ATTR_DEV_NAME])
>> >> +		data_size += nla_len(attrs[DEVLINK_ATTR_DEV_NAME]) + 1;
>> >> +
>> >> +	flt = kzalloc(sizeof(*flt) + data_size, GFP_KERNEL);
>> >
>> >instead of arithmetic here, you could use struct_size()
>> 
>> That is used for flex array, yet I have no flex array here.
>> 
>
>Yea this isn't a flexible array. You could use size_add to ensure that this can't overflow. I don't know what the bound on the attribute sizes is.

Okay, will do that to be on a safe side.

>

