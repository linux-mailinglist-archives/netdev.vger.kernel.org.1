Return-Path: <netdev+bounces-46917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 653407E7112
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 19:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B592810A5
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2199328D8;
	Thu,  9 Nov 2023 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yCcjT6Rq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C25DDA8
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 18:04:11 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BA53AA5
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 10:04:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso1831705a12.0
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 10:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699553049; x=1700157849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QG9iyLTf92w0IgYWsAAuUxWVVjyFzSx6H+xAC2GvfZc=;
        b=yCcjT6RqpXl01mxGjudmBvRmByJsAn3F16k1B4XQcbx+mZRBCFqUJ9t8iyq4iK+ful
         YnzqTQbcHp5WLYkg/PLpqjX2pNMIwolFA3CUcMNovswj4gHsKTV5lF8SMgL/9f74xV7m
         czmEJ3JlwaQx/SFWWC7GOv/9LooIgK3i2BPSBeW0CNAarcYUpC6GLWQHNw69D1U1R3iZ
         Pruua0Fh8a3ScM+DzrLkAA96FYfydZMuoY24UqCfoeQq+Wwa9fNU7RC0RQV9SzKZAmzl
         zW6n27LMT15Yi5qghqrAAzMWwA+TK/7jew/9/A3yTN5XZkRthBNcKWi/ymbVx5kIXi6a
         ODww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699553049; x=1700157849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG9iyLTf92w0IgYWsAAuUxWVVjyFzSx6H+xAC2GvfZc=;
        b=p/2Zbz2GNjXS87kK3/Tik1lGb1w2qY8Gt3voHTBxldsuiLkyB4g8MGKDKANeQNADUS
         oJx4MBglVNsYn/vjPZ/kdNm9ib7JGAEaLjRaAe9bEvb2ovfJ5E/s7DpSXN1f+5MBnsI7
         y+C9z5dMeh/i6ZFg6aFz61I5v0RoYTL8cJJ6Jegw3gb1XshSi251fRJ+CAHugTDZ6Sig
         JzyRi36EZZV5xibf5OEpX5l3J2wB+nIhewVs2XPywVRqCbXHY+odeoM7IK0hoMps3rao
         aWpq6oicczbp5rTSQm7fONeXDAyHVxs2bZkvypEBG/EScT1WIRSvBk63vAISi538kR2E
         63Ag==
X-Gm-Message-State: AOJu0YwQInBZP3Bf2YT+NvRom6bwou7L75ztsCkmZ4JPsFqtMlr9d+Km
	SNJvUOxRSkHUYFjTMJtAhoD7nA==
X-Google-Smtp-Source: AGHT+IHfg7ggkVH0tZ/f3Ptg7DcvMQ7uGVn9tvGgV5OxgNtDVBgNUT4VFdMRycF6q8fkrf4pB8k9jg==
X-Received: by 2002:a17:907:c14:b0:9a5:874a:9745 with SMTP id ga20-20020a1709070c1400b009a5874a9745mr5646706ejc.26.1699553048780;
        Thu, 09 Nov 2023 10:04:08 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906504200b009b65b2be80bsm2844026ejk.76.2023.11.09.10.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:04:08 -0800 (PST)
Date: Thu, 9 Nov 2023 19:04:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Message-ID: <ZU0fFz+GTdqjA7RD@nanopsycho>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-4-arkadiusz.kubalewski@intel.com>
 <ZUukPbTCww26jltC@nanopsycho>
 <DM6PR11MB46572BD8C43DACA0FF15C2CF9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <8b6e3211-3f03-4c17-b0cb-26175bf42213@linux.dev>
 <DM6PR11MB4657C6C1B094DD7B429A22469BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657C6C1B094DD7B429A22469BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>

Thu, Nov 09, 2023 at 05:02:48PM CET, arkadiusz.kubalewski@intel.com wrote:
>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>Sent: Thursday, November 9, 2023 11:56 AM
>>To: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Jiri Pirko
>>
>>On 09/11/2023 09:59, Kubalewski, Arkadiusz wrote:
>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>> Sent: Wednesday, November 8, 2023 4:08 PM
>>>>
>>>> Wed, Nov 08, 2023 at 11:32:26AM CET, arkadiusz.kubalewski@intel.com
>>>> wrote:
>>>>> In case of multiple kernel module instances using the same dpll device:
>>>>> if only one registers dpll device, then only that one can register
>>>>
>>>> They why you don't register in multiple instances? See mlx5 for a
>>>> reference.
>>>>
>>>
>>> Every registration requires ops, but for our case only PF0 is able to
>>> control dpll pins and device, thus only this can provide ops.
>>> Basically without PF0, dpll is not able to be controlled, as well
>>> as directly connected pins.
>>>
>>But why do you need other pins then, if FP0 doesn't exist?
>>
>
>In general we don't need them at that point, but this is a corner case,
>where users for some reason decided to unbind PF 0, and I treat this state
>as temporary, where dpll/pins controllability is temporarily broken.

So resolve this broken situation internally in the driver, registering
things only in case PF0 is present. Some simple notification infra would
do. Don't drag this into the subsystem internals.


>
>The dpll at that point is not registered, all the direct pins are also
>not registered, thus not available to the users.
>
>When I do dump at that point there are still 3 pins present, one for each
>PF, although they are all zombies - no parents as their parent pins are not
>registered (as the other patch [1/3] prevents dump of pin parent if the
>parent is not registered). Maybe we can remove the REGISTERED mark for all
>the muxed pins, if all their parents have been unregistered, so they won't
>be visible to the user at all. Will try to POC that.
>
>>>>
>>>>> directly connected pins with a dpll device. If unregistered parent
>>>>> determines if the muxed pin can be register with it or not, it forces
>>>>> serialized driver load order - first the driver instance which
>>>>> registers the direct pins needs to be loaded, then the other instances
>>>>> could register muxed type pins.
>>>>>
>>>>> Allow registration of a pin with a parent even if the parent was not
>>>>> yet registered, thus allow ability for unserialized driver instance
>>>>
>>>> Weird.
>>>>
>>>
>>> Yeah, this is issue only for MUX/parent pin part, couldn't find better
>>> way, but it doesn't seem to break things around..
>>>
>>
>>I just wonder how do you see the registration procedure? How can parent
>>pin exist if it's not registered? I believe you cannot get it through
>>DPLL API, then the only possible way is to create it within the same
>>driver code, which can be simply re-arranged. Am I wrong here?
>>
>
>By "parent exist" I mean the parent pin exist in the dpll subsystem
>(allocated on pins xa), but it doesn't mean it is available to the users,
>as it might not be registered with a dpll device.
>
>We have this 2 step init approach:
>1. dpll_pin_get(..) -> allocate new pin or increase reference if exist
>2.1. dpll_pin_register(..) -> register with a dpll device
>2.2. dpll_pin_on_pin_register -> register with a parent pin
>
>Basically:
>- PF 0 does 1 & 2.1 for all the direct inputs, and steps: 1 & 2.2 for its
>  recovery clock pin,
>- other PF's only do step 1 for the direct input pins (as they must get
>  reference to those in order to register recovery clock pin with them),
>  and steps: 1 & 2.2 for their recovery clock pin.
>
>
>Thank you!
>Arkadiusz
>
>>> Thank you!
>>> Arkadiusz
>>>
>>>>
>>>>> load order.
>>>>> Do not WARN_ON notification for unregistered pin, which can be invoked
>>>>> for described case, instead just return error.
>>>>>
>>>>> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>>>> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>>>> functions")
>>>>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>> ---
>>>>> drivers/dpll/dpll_core.c    | 4 ----
>>>>> drivers/dpll/dpll_netlink.c | 2 +-
>>>>> 2 files changed, 1 insertion(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c index
>>>>> 4077b562ba3b..ae884b92d68c 100644
>>>>> --- a/drivers/dpll/dpll_core.c
>>>>> +++ b/drivers/dpll/dpll_core.c
>>>>> @@ -28,8 +28,6 @@ static u32 dpll_xa_id;
>>>>> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>>>>> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
>>>>> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>>>>> -#define ASSERT_PIN_REGISTERED(p)	\
>>>>> -	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
>>>>>
>>>>> struct dpll_device_registration {
>>>>> 	struct list_head list;
>>>>> @@ -641,8 +639,6 @@ int dpll_pin_on_pin_register(struct dpll_pin
>>>>>*parent,
>>>> struct dpll_pin *pin,
>>>>> 	    WARN_ON(!ops->state_on_pin_get) ||
>>>>> 	    WARN_ON(!ops->direction_get))
>>>>> 		return -EINVAL;
>>>>> -	if (ASSERT_PIN_REGISTERED(parent))
>>>>> -		return -EINVAL;
>>>>>
>>>>> 	mutex_lock(&dpll_lock);
>>>>> 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv); diff
>>>>> --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c index
>>>>> 963bbbbe6660..ff430f43304f 100644
>>>>> --- a/drivers/dpll/dpll_netlink.c
>>>>> +++ b/drivers/dpll/dpll_netlink.c
>>>>> @@ -558,7 +558,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct
>>>> dpll_pin *pin)
>>>>> 	int ret = -ENOMEM;
>>>>> 	void *hdr;
>>>>>
>>>>> -	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED)))
>>>>> +	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>>>>> 		return -ENODEV;
>>>>>
>>>>> 	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>>>> --
>>>>> 2.38.1
>>>>>
>>
>

