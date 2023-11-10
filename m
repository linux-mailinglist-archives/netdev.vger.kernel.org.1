Return-Path: <netdev+bounces-47061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F807E7B28
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71D95B20DC6
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAED5134CA;
	Fri, 10 Nov 2023 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CEoO7hmM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05010134A3
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 10:07:21 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425072633F
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:07:20 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so3029026a12.1
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699610839; x=1700215639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DlBOgBoXPKfJZMcyDI+Q+RUe8URoSOkOPgLxdc2HK+A=;
        b=CEoO7hmMu5mG4s1xYLGFkHf/LqfUDZ06JWKexO9kf8XrlQVIKyOe+UhlQFDfxnwZzI
         eOe8XU9iLKf0i29HMkk7s7D37eXGj5KEJ8CUU6pTY9EULlXXWEjXPpxP1gILmjZ7JpJt
         S+kg7nqHl/a7T5xfAohBZpQ4DEYmmsNUStvfY3itrNc8+f3ALvXIUfi4WglWW1Jwawu3
         K84oowLBvKapd65uGHjtPP1TMWfyfjRB6l/gijh732q0afUnTNRQGodrhQ9CSOrHG5KN
         fJplwGVE7QLraLrNV4BPr1CJcVHDC/zEoJZcEyNbKttML6lDqjhhwE2+QbQTqMs3r15v
         py0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699610839; x=1700215639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlBOgBoXPKfJZMcyDI+Q+RUe8URoSOkOPgLxdc2HK+A=;
        b=KYIkpFkBq/X/dzflfdDBcUDMyAaJLdYTOWwqAQZMf0ry5FwrkGG0xjonoAaOl3yB/1
         08zW+lPpH7ORY9HpMQD+Sg18uYXd9agJwcQBWVMo+r9YrNOw2e75MKbjt2zEiIwfL6Sm
         BQklZX3eJMnuqXUFGVqcB5FMmnwCmua+JixkgXDGXO1aNjwm/TU7c/pXyyNHvvZIPc4B
         9Pom4hj5EvLczi+ddm2ARLkeMHr9uKBIjgtl3NWuYPDk2rGCR5+hzyHRqeUu6chEkmb/
         bvj4dJkSl7K0tL5w1vHhkwZyVPNOTwN2bUO1bnbLWh9Aa+KvGa4sq0jCh3/lqgZ48azC
         h5hQ==
X-Gm-Message-State: AOJu0YzXu6tPblaDCx8luvSAvmwZpWkE0LM6hF23RhucWjO9T6cwdVDj
	X/qUQ8c7sD80FAo8fjcQXVZVcw==
X-Google-Smtp-Source: AGHT+IEdJj/9Nlub09u+YbnLH8NPEXNplT2jLOejpc7aMwRNAw9rTwzx9nzxdbYobJKrzGF/IK4OVQ==
X-Received: by 2002:a17:907:2d26:b0:9d8:78f2:7e9a with SMTP id gs38-20020a1709072d2600b009d878f27e9amr6701417ejc.14.1699610838506;
        Fri, 10 Nov 2023 02:07:18 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id bv18-20020a170906b1d200b0098e34446464sm3682728ejb.25.2023.11.10.02.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:07:17 -0800 (PST)
Date: Fri, 10 Nov 2023 11:07:16 +0100
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
Message-ID: <ZU4A1FG0+JgVz3HF@nanopsycho>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-4-arkadiusz.kubalewski@intel.com>
 <ZUukPbTCww26jltC@nanopsycho>
 <DM6PR11MB46572BD8C43DACA0FF15C2CF9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <8b6e3211-3f03-4c17-b0cb-26175bf42213@linux.dev>
 <DM6PR11MB4657C6C1B094DD7B429A22469BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU0fFz+GTdqjA7RD@nanopsycho>
 <DM6PR11MB465763E8D261CEC6B215358C9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU3SJdlOwoFOEavA@nanopsycho>
 <DM6PR11MB465767D550C3DF2CE24E70EA9BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB465767D550C3DF2CE24E70EA9BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>

Fri, Nov 10, 2023 at 09:50:34AM CET, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Friday, November 10, 2023 7:48 AM
>>
>>Fri, Nov 10, 2023 at 12:21:11AM CET, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Thursday, November 9, 2023 7:04 PM
>>>>
>>>>Thu, Nov 09, 2023 at 05:02:48PM CET, arkadiusz.kubalewski@intel.com
>>>>wrote:
>>>>>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>>>>Sent: Thursday, November 9, 2023 11:56 AM
>>>>>>To: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Jiri Pirko
>>>>>>
>>>>>>On 09/11/2023 09:59, Kubalewski, Arkadiusz wrote:
>>>>>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>> Sent: Wednesday, November 8, 2023 4:08 PM
>>>>>>>>
>>>>>>>> Wed, Nov 08, 2023 at 11:32:26AM CET, arkadiusz.kubalewski@intel.com
>>>>>>>> wrote:
>>>>>>>>> In case of multiple kernel module instances using the same dpll
>>>>>>>>>device:
>>>>>>>>> if only one registers dpll device, then only that one can register
>>>>>>>>
>>>>>>>> They why you don't register in multiple instances? See mlx5 for a
>>>>>>>> reference.
>>>>>>>>
>>>>>>>
>>>>>>> Every registration requires ops, but for our case only PF0 is able to
>>>>>>> control dpll pins and device, thus only this can provide ops.
>>>>>>> Basically without PF0, dpll is not able to be controlled, as well
>>>>>>> as directly connected pins.
>>>>>>>
>>>>>>But why do you need other pins then, if FP0 doesn't exist?
>>>>>>
>>>>>
>>>>>In general we don't need them at that point, but this is a corner case,
>>>>>where users for some reason decided to unbind PF 0, and I treat this
>>>>>state
>>>>>as temporary, where dpll/pins controllability is temporarily broken.
>>>>
>>>>So resolve this broken situation internally in the driver, registering
>>>>things only in case PF0 is present. Some simple notification infra would
>>>>do. Don't drag this into the subsystem internals.
>>>>
>>>
>>>Thanks for your feedback, but this is already wrong advice.
>>>
>>>Our HW/FW is designed in different way than yours, it doesn't mean it is
>>>wrong.
>>>As you might recall from our sync meetings, the dpll subsystem is to unify
>>>approaches and reduce the code in the drivers, where your advice is
>>>exactly
>>
>>No. Your driver knows when what objects are valid or not. Of a pin of
>>PF1 is not valid because the "master" PF0 is gone, it is responsibility
>>of your driver to resolve that. Don't bring this internal dependencies
>>to the dpll core please, does not make any sense to do so. Thanks!
>>
>
>No, a driver doesn't know it, those are separated instances, and you already
>suggested to implement special notification bus in the driver.
>This is not needed and prone for another errors. The dpll subsystem is here to
>make driver life easier.

See the other thread for my reply.

>
>Thank you!
>Arkadiusz
>
>>
>>>opposite, suggested fix would require to implement extra synchronization
>>>of the
>>>dpll and pin registration state between driver instances, most probably
>>>with
>>>use of additional modules like aux-bus or something similar, which was
>>>from the
>>>very beginning something we tried to avoid.
>>>Only ice uses the infrastructure of muxed pins, and this is broken as it
>>>doesn't allow unbind the driver which have registered dpll and pins
>>>without
>>>crashing the kernel, so a fix is required in dpll subsystem, not in the
>>>driver.
>>>
>>>Thank you!
>>>Arkadiusz
>>>
>>>>
>>>>>
>>>>>The dpll at that point is not registered, all the direct pins are also
>>>>>not registered, thus not available to the users.
>>>>>
>>>>>When I do dump at that point there are still 3 pins present, one for
>>>>>each
>>>>>PF, although they are all zombies - no parents as their parent pins are
>>>>>not
>>>>>registered (as the other patch [1/3] prevents dump of pin parent if the
>>>>>parent is not registered). Maybe we can remove the REGISTERED mark for
>>>>>all
>>>>>the muxed pins, if all their parents have been unregistered, so they
>>>>>won't
>>>>>be visible to the user at all. Will try to POC that.
>>>>>
>>>>>>>>
>>>>>>>>> directly connected pins with a dpll device. If unregistered parent
>>>>>>>>> determines if the muxed pin can be register with it or not, it
>>>>>>>>>forces
>>>>>>>>> serialized driver load order - first the driver instance which
>>>>>>>>> registers the direct pins needs to be loaded, then the other
>>>>>>>>> instances
>>>>>>>>> could register muxed type pins.
>>>>>>>>>
>>>>>>>>> Allow registration of a pin with a parent even if the parent was
>>>>>>>>>not
>>>>>>>>> yet registered, thus allow ability for unserialized driver instance
>>>>>>>>
>>>>>>>> Weird.
>>>>>>>>
>>>>>>>
>>>>>>> Yeah, this is issue only for MUX/parent pin part, couldn't find
>>>>>>>better
>>>>>>> way, but it doesn't seem to break things around..
>>>>>>>
>>>>>>
>>>>>>I just wonder how do you see the registration procedure? How can parent
>>>>>>pin exist if it's not registered? I believe you cannot get it through
>>>>>>DPLL API, then the only possible way is to create it within the same
>>>>>>driver code, which can be simply re-arranged. Am I wrong here?
>>>>>>
>>>>>
>>>>>By "parent exist" I mean the parent pin exist in the dpll subsystem
>>>>>(allocated on pins xa), but it doesn't mean it is available to the
>>>>>users,
>>>>>as it might not be registered with a dpll device.
>>>>>
>>>>>We have this 2 step init approach:
>>>>>1. dpll_pin_get(..) -> allocate new pin or increase reference if exist
>>>>>2.1. dpll_pin_register(..) -> register with a dpll device
>>>>>2.2. dpll_pin_on_pin_register -> register with a parent pin
>>>>>
>>>>>Basically:
>>>>>- PF 0 does 1 & 2.1 for all the direct inputs, and steps: 1 & 2.2 for
>>>>>its
>>>>>  recovery clock pin,
>>>>>- other PF's only do step 1 for the direct input pins (as they must get
>>>>>  reference to those in order to register recovery clock pin with them),
>>>>>  and steps: 1 & 2.2 for their recovery clock pin.
>>>>>
>>>>>
>>>>>Thank you!
>>>>>Arkadiusz
>>>>>
>>>>>>> Thank you!
>>>>>>> Arkadiusz
>>>>>>>
>>>>>>>>
>>>>>>>>> load order.
>>>>>>>>> Do not WARN_ON notification for unregistered pin, which can be
>>>>>>>>> invoked
>>>>>>>>> for described case, instead just return error.
>>>>>>>>>
>>>>>>>>> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base
>>>>>>>>>functions")
>>>>>>>>> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>>>>>>>> functions")
>>>>>>>>> Signed-off-by: Arkadiusz Kubalewski
>>>>>>>>><arkadiusz.kubalewski@intel.com>
>>>>>>>>> ---
>>>>>>>>> drivers/dpll/dpll_core.c    | 4 ----
>>>>>>>>> drivers/dpll/dpll_netlink.c | 2 +-
>>>>>>>>> 2 files changed, 1 insertion(+), 5 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>>>>>>> index
>>>>>>>>> 4077b562ba3b..ae884b92d68c 100644
>>>>>>>>> --- a/drivers/dpll/dpll_core.c
>>>>>>>>> +++ b/drivers/dpll/dpll_core.c
>>>>>>>>> @@ -28,8 +28,6 @@ static u32 dpll_xa_id;
>>>>>>>>> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id,
>>>>>>>>> DPLL_REGISTERED))
>>>>>>>>> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
>>>>>>>>> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id,
>>>>>>>>> DPLL_REGISTERED))
>>>>>>>>> -#define ASSERT_PIN_REGISTERED(p)	\
>>>>>>>>> -	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id,
>>>>>>>>> DPLL_REGISTERED))
>>>>>>>>>
>>>>>>>>> struct dpll_device_registration {
>>>>>>>>> 	struct list_head list;
>>>>>>>>> @@ -641,8 +639,6 @@ int dpll_pin_on_pin_register(struct dpll_pin
>>>>>>>>> *parent,
>>>>>>>>> struct dpll_pin *pin,
>>>>>>>>> 	    WARN_ON(!ops->state_on_pin_get) ||
>>>>>>>>> 	    WARN_ON(!ops->direction_get))
>>>>>>>>> 		return -EINVAL;
>>>>>>>>> -	if (ASSERT_PIN_REGISTERED(parent))
>>>>>>>>> -		return -EINVAL;
>>>>>>>>>
>>>>>>>>> 	mutex_lock(&dpll_lock);
>>>>>>>>> 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops,
>>>>>>>>> priv); diff
>>>>>>>>> --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>>>>>>>> index
>>>>>>>>> 963bbbbe6660..ff430f43304f 100644
>>>>>>>>> --- a/drivers/dpll/dpll_netlink.c
>>>>>>>>> +++ b/drivers/dpll/dpll_netlink.c
>>>>>>>>> @@ -558,7 +558,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct
>>>>>>>>> dpll_pin *pin)
>>>>>>>>> 	int ret = -ENOMEM;
>>>>>>>>> 	void *hdr;
>>>>>>>>>
>>>>>>>>> -	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id,
>>>>>>>>> DPLL_REGISTERED)))
>>>>>>>>> +	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>>>>>>>>> 		return -ENODEV;
>>>>>>>>>
>>>>>>>>> 	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>>>>>>>> --
>>>>>>>>> 2.38.1
>>>>>>>>>
>>>>>>
>>>>>

