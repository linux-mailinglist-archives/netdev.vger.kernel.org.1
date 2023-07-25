Return-Path: <netdev+bounces-20728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8313E760C9A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3848928166A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACD4134B8;
	Tue, 25 Jul 2023 08:03:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465D012B69
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:03:55 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2D2E5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:03:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99364ae9596so899317966b.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690272229; x=1690877029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JbbX6sgdLzkJv2mPvdir4q6VzYMXsbxqgWJNRH0IqlY=;
        b=4mR9aa2XCgMdSbX6jewGv2ImZ3UggYRtYN2hb1UPHcViw6AbieGKw4eKYiv8tBXzlL
         iTGLJpe3218BtX4MmVCi4v85hOXDjEecGu3AkJR2TQ+l9flS32Y3oBY2kvOax6aL3f8E
         +/ViIMYNUbfudLgJRyo0hgaheujKkXYNmEX9q9T5gtC4KRiPo3NncAlGC0njyQlniq1t
         lhyhQbxjwYxB7Y8XGu9WMy3QLEdYBEm3wEakkVrgW7a32wYkFqBsw7I7l+RFkVOkHk4W
         PdcgFR6gvogL8ADxtKDN+Wbyyw96XSxMwGw1vbHVjYSHQYUsRC15aWHs4njWU9oV2e+U
         5UTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690272229; x=1690877029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbbX6sgdLzkJv2mPvdir4q6VzYMXsbxqgWJNRH0IqlY=;
        b=fmUa+cGok+9dDytG3rlaBn3GHIkjr0DsNTjzYUbLSATVT+KY0HgkUUwWNvseaQrsue
         sSoT0tARC8paGYrdQVB3SjPIkFFIzAp3EZkEveGbUZf0y/A8xzQeOvQQK2lhVfpUuarq
         wVyU2UDy2JjwGXhI4Iwh24vVNzp5shW3wJUiUE3vZSsXWELXNOYidlNJ2odSLwH1dPKy
         vj3LvU1LLd8fD1PRrIUxwfX3ljczKFmlKtQqMoiLtJqwujxYmDHAYlopvBPon6R/MMa1
         AZ1ujrSbEuBKpKCB1RfJv8cdOxCSK92yXlzU+fLgzVv4nYXT3NyK7EuH1WYvJ8+rebED
         4VbA==
X-Gm-Message-State: ABy/qLZ95V82qLAEETsBlrXjn7ZAqPgGL9x/01smG8zSYGjg7Kg28e5v
	gswgTKbm/KiPX2Hh/ivwbJtrmA==
X-Google-Smtp-Source: APBJJlHDxt0mEm2bPgjqk1aORT7cgAAf4XRKLLvhtNV8HYWSaYa68+TnPWz3zGWPRbzRORJldpWK/A==
X-Received: by 2002:a17:907:2ccb:b0:973:c070:1b5f with SMTP id hg11-20020a1709072ccb00b00973c0701b5fmr12120343ejc.44.1690272229527;
        Tue, 25 Jul 2023 01:03:49 -0700 (PDT)
Received: from localhost ([91.218.191.82])
        by smtp.gmail.com with ESMTPSA id x2-20020a1709060a4200b00992ddf46e65sm7750664ejf.46.2023.07.25.01.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:03:48 -0700 (PDT)
Date: Tue, 25 Jul 2023 10:03:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Olech, Milena" <milena.olech@intel.com>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	poros <poros@redhat.com>, mschmidt <mschmidt@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 09/11] ice: implement dpll interface to control cgu
Message-ID: <ZL+B48Om/cf61/Vq@nanopsycho>
References: <ZLk/9zwbBHgs+rlb@nanopsycho>
 <DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLo0ujuLMF2NrMog@nanopsycho>
 <DM6PR11MB46576153E0E28BA4C283A30A9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLpzwMQrqp7mIMFF@nanopsycho>
 <DM6PR11MB46579CC7E6D314BFDE47E4EE9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLqoMhxHq3m4dp1u@nanopsycho>
 <DM6PR11MB46571D843FB903AC050E2F129B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLt5GPRls7UL4zGx@nanopsycho>
 <DM6PR11MB465713389A234771BD29DF149B02A@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB465713389A234771BD29DF149B02A@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Jul 24, 2023 at 05:03:55PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Saturday, July 22, 2023 8:37 AM
>>
>>Fri, Jul 21, 2023 at 09:48:18PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Friday, July 21, 2023 5:46 PM
>>>>
>>>>Fri, Jul 21, 2023 at 03:36:17PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>Sent: Friday, July 21, 2023 2:02 PM
>>>>>>
>>>>>>Fri, Jul 21, 2023 at 01:17:59PM CEST, arkadiusz.kubalewski@intel.com
>>>>>>wrote:
>>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>Sent: Friday, July 21, 2023 9:33 AM
>>>>>>>>
>>>>>>>>Thu, Jul 20, 2023 at 07:31:14PM CEST, arkadiusz.kubalewski@intel.com
>>>>>>>>wrote:
>>>>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>>>Sent: Thursday, July 20, 2023 4:09 PM
>>>>>>>>>>
>>>>>>>>>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev
>>>>>>>>>>wrote:
>>>>>>>>>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>>>>>>>
>>>>>>>>>>[...]
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>+/**
>>>>>>>>>>>+ * ice_dpll_pin_enable - enable a pin on dplls
>>>>>>>>>>>+ * @hw: board private hw structure
>>>>>>>>>>>+ * @pin: pointer to a pin
>>>>>>>>>>>+ * @pin_type: type of pin being enabled
>>>>>>>>>>>+ * @extack: error reporting
>>>>>>>>>>>+ *
>>>>>>>>>>>+ * Enable a pin on both dplls. Store current state in pin->flags.
>>>>>>>>>>>+ *
>>>>>>>>>>>+ * Context: Called under pf->dplls.lock
>>>>>>>>>>>+ * Return:
>>>>>>>>>>>+ * * 0 - OK
>>>>>>>>>>>+ * * negative - error
>>>>>>>>>>>+ */
>>>>>>>>>>>+static int
>>>>>>>>>>>+ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>>>>>>>>>>>+		    enum ice_dpll_pin_type pin_type,
>>>>>>>>>>>+		    struct netlink_ext_ack *extack)
>>>>>>>>>>>+{
>>>>>>>>>>>+	u8 flags = 0;
>>>>>>>>>>>+	int ret;
>>>>>>>>>>>+
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>I don't follow. Howcome you don't check if the mode is freerun here or
>>>>>>>>>>not? Is it valid to enable a pin when freerun mode? What happens?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>Because you are probably still thinking the modes are somehow connected
>>>>>>>>>to the state of the pin, but it is the other way around.
>>>>>>>>>The dpll device mode is a state of DPLL before pins are even
>>>>>>>>>considered.
>>>>>>>>>If the dpll is in mode FREERUN, it shall not try to synchronize or
>>>>>>>>>monitor
>>>>>>>>>any of the pins.
>>>>>>>>>
>>>>>>>>>>Also, I am probably slow, but I still don't see anywhere in this
>>>>>>>>>>patchset any description about why we need the freerun mode. What is
>>>>>>>>>>diffrerent between:
>>>>>>>>>>1) freerun mode
>>>>>>>>>>2) automatic mode & all pins disabled?
>>>>>>>>>
>>>>>>>>>The difference:
>>>>>>>>>Case I:
>>>>>>>>>1. set dpll to FREERUN and configure the source as if it would be in
>>>>>>>>>AUTOMATIC
>>>>>>>>>2. switch to AUTOMATIC
>>>>>>>>>3. connecting to the valid source takes ~50 seconds
>>>>>>>>>
>>>>>>>>>Case II:
>>>>>>>>>1. set dpll to AUTOMATIC, set all the source to disconnected
>>>>>>>>>2. switch one valid source to SELECTABLE
>>>>>>>>>3. connecting to the valid source takes ~10 seconds
>>>>>>>>>
>>>>>>>>>Basically in AUTOMATIC mode the sources are still monitored even when
>>>>>>>>>they
>>>>>>>>>are not in SELECTABLE state, while in FREERUN there is no such
>>>>>>>>>monitoring,
>>>>>>>>>so in the end process of synchronizing with the source takes much
>>>>>>>>>longer as
>>>>>>>>>dpll need to start the process from scratch.
>>>>>>>>
>>>>>>>>I believe this is implementation detail of your HW. How you do it is up
>>>>>>>>to you. User does not have any visibility to this behaviour, therefore
>>>>>>>>makes no sense to expose UAPI that is considering it. Please drop it at
>>>>>>>>least for the initial patchset version. If you really need it later on
>>>>>>>>(which I honestly doubt), you can send it as a follow-up patchset.
>>>>>>>>
>>>>>>>
>>>>>>>And we will have the same discussion later.. But implementation is
>>>>>>>already
>>>>>>>there.
>>>>>>
>>>>>>Yeah, it wouldn't block the initial submission. I would like to see this
>>>>>>merged, so anything which is blocking us and is totally optional (as
>>>>>>this freerun mode) is better to be dropped.
>>>>>>
>>>>>
>>>>>It is not blocking anything. Most of it was defined and available for
>>>>>long time already. Only ice implementing set_mode is a new part.
>>>>>No clue what is the problem you are implying here.
>>>>
>>>>Problem is that I believe you freerun mode should not exist. I believe
>>>>it is wrong.
>>>>
>>>>
>>>>>
>>>>>>
>>>>>>>As said in our previous discussion, without mode_set there is no point to
>>>>>>>have
>>>>>>>command DEVICE_SET at all, and there you said that you are ok with having
>>>>>>>the
>>>>>>>command as a placeholder, which doesn't make sense, since it is not used.
>>>>>>
>>>>>>I don't see any problem in having enum value reserved. But it does not
>>>>>>need to be there at all. You can add it to the end of the list when
>>>>>>needed. No problem. This is not an argument.
>>>>>>
>>>>>
>>>>>The argument is that I already implemented and tested, and have the need
>>>>>for the
>>>>>existence to set_mode to configure DPLL, which is there to switch the mode
>>>>>between AUTOMATIC and FREERUN.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>Also this is not HW implementation detail but a synchronizer chip
>>>>>>>feature,
>>>>>>>once dpll is in FREERUN mode, the measurements like phase offset between
>>>>>>>the
>>>>>>>input and dpll's output won't be available.
>>>>>>>
>>>>>>>For the user there is a difference..
>>>>>>>Enabling the FREERUN mode is a reset button on the dpll's state machine,
>>>>>>>where disconnecting sources is not, as they are still used, monitored and
>>>>>>>measured.
>>>>>>
>>>>>>So it is not a mode! Mode is either "automatic" or "manual". Then we
>>>>>>have a state to indicate the state of the state machine (unlocked, locked,
>>>>>>holdover, holdover-acq). So what you seek is a way for the user to
>>>>>>expliticly set the state to "unlocked" and reset of the state machine.
>>>>>>
>>>>>>Please don't mix config and state. I think we untangled this in the past
>>>>>>:/
>>>>>
>>>>>I don't mix anything, this is the way dpll works, which means mode of dpll.
>>>>
>>>>You do. You want to force-change the state yet you mangle the mode in.
>>>>The fact that some specific dpll implemented it as mode does not mean it
>>>>has to be exposed like that to user. We have to find the right
>>>>abstraction.
>>>>
>>>
>>>Just to make it clear:
>>>
>>>AUTOMATIC:
>>>- inputs monitored, validated, phase measurements available
>>>- possible states: unlocked, locked, locked-ho-acq, holdover
>>>
>>>FREERUN:
>>>- inputs not monitored, not validated, no phase measurements available
>>>- possible states: unlocked
>>
>>This is your implementation of DPLL. Others may have it done
>>differently. But the fact the input is monitored or not, does not make
>>any difference from user perspective.
>>
>>When he has automatic mode and does:
>>1) disconnect all pins
>>2) reset state    (however you implement it in the driver is totaly up
>>		   to the device, you may go to your freerun dpll mode
>>		   internally and to automatic back, up to you)
>> -> state will go to unlocked
>>
>>The behaviour is exactly the same, without any special mode.
>
>In this case there is special reset button, which doesn't exist in
>reality, actually your suggestion to go into FREERUN and back to AUTOMATIC
>to pretend the some kind of reset has happened, where in reality dpll went to
>FREERUN and AUTOMATIC.

There are 3 pin states:
disconnected
connected
selectable

When the last source disconnects, go to your internal freerun.
When some source gets selectable or connected, go to your internal
automatic mode.

From user perspactive, the mode didn't change.

From user perepective, this is exacly the behaviour he requested.


>For me it seems it seems like unnecessary complication of user's life.
>The idea of FREERUN mode is to run dpll on its system clock, so all the
>"external" dpll sources shall be disconnected when dpll is in FREERUN.

Yes, that is when you set all pins to disconnect. no mode change needed.


>Let's assume your HW doesn't have a FREERUN, can't you just create it by
>disconnecting all the sources? 

Yep, that's what we do.


>BTW, what chip are you using on mlx5 for this?
>I don't understand why the user would have to mangle state of all the pins just
>to stop dpll's work if he could just go into FREERUN and voila. Also what if
>user doesn't want change the configuration of the pins at all, and he just want
>to desynchronize it's dpll for i.e. testing reason.

I tried to explain multiple times. Let the user have clean an abstracted
api, with clear semantics. Simple as that. Your internal freerun mode is
just something to abstract out, it is not needed to expose it.


>
>>
>>We are talking about UAPI here. It should provide the abstraction, leaving
>>the
>>internal implementation behind the curtain. What is important is:
>>1) clear configuration knobs
>>2) the outcome (hw behaviour)
>>
>>
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>Perhaps you just need an extra cmd like DPLL_CMD_DEVICE_STATE_RESET cmd
>>>>>>to hit this button.
>>>>>>
>>>>>
>>>>>As already said there are measurement in place in AUTOMATIC, there are no
>>>>>such
>>>>>thing in FREERUN. Going into FREERUN resets the state machine of dpll
>>>>>which
>>>>>is a side effect of going to FREERUN.
>>>>>
>>>>>>
>>>>>>
>>>>>>>So probably most important fact that you are missing here: assuming the
>>>>>>>user
>>>>>>>disconnects the pin that dpll was locked with, our dpll doesn't go into
>>>>>>>UNLOCKED
>>>>>>>state but into HOLDOVER.
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>Isn't the behaviour of 1) and 2) exactly the same? If no, why? This
>>>>>>>>>>needs to be documented, please.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>Sure will add the description of FREERUN to the docs.
>>>>>>>>
>>>>>>>>No, please drop it from this patchset. I have no clue why you readded
>>>>>>>>it in the first place in the last patchset version.
>>>>>>>>
>>>>>>>
>>>>>>>mode_set was there from the very beginning.. now implemented in ice
>>>>>>>driver
>>>>>>>as it should.
>>>>>>
>>>>>>I don't understand the fixation on a callback to be implemented. Just
>>>>>>remove it. It can be easily added when needed. No problem.
>>>>>>
>>>>>
>>>>>Well, I don't understand the fixation about removing it.
>>>>
>>>>It is needed only for your freerun mode, which is questionable. This
>>>>discussion it not about mode_set. I don't care about it, if it is
>>>>needed, should be there, if not, so be it.
>>>>
>>>>As you say, you need existance of your freerun mode to justify existence
>>>>of mode_set(). Could you please, please drop both for now so we can
>>>>move on? I'm tired of this. Thanks!
>>>>
>>>
>>>Reason for dpll subsystem is to control the dpll. So the mode_set and
>>>different modes are there for the same reason.
>>>Explained this multiple times already, we need a way to let the user switch
>>>to FREERUN, so all the activities on dpll are stopped.
>>>
>>>>
>>>>>set_mode was there for a long time, now the callback is properly
>>>>>implemented
>>>>>and you are trying to imply that this is not needed.
>>>>>We require it, as there is no other other way to stop AUTOMATIC mode dpll
>>>>>to do its work.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>Another question, I asked the last time as well, but was not heard:
>>>>>>>>>>Consider example where you have 2 netdevices, eth0 and eth1, each
>>>>>>>>>>connected with a single DPLL pin:
>>>>>>>>>>eth0 - DPLL pin 10 (DPLL device id 2)
>>>>>>>>>>eth1 - DPLL pin 11 (DPLL device id 2)
>>>>>>>>>>
>>>>>>>>>>You have a SyncE daemon running on top eth0 and eth1.
>>>>>>>>>>
>>>>>>>>>>Could you please describe following 2 flows?
>>>>>>>>>>
>>>>>>>>>>1) SyncE daemon selects eth0 as a source of clock
>>>>>>>>>>2) SyncE daemon selects eth1 as a source of clock
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>For mlx5 it goes like:
>>>>>>>>>>
>>>>>>>>>>DPLL device mode is MANUAL.
>>>>>>>>>>1)
>>>>>>>>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth0
>>>>>>>>>>    -> pin_id: 10
>>>>>>>>>> SenceE daemon will use PIN_GET with pin_id 10 to get DPLL device id
>>>>>>>>>>    -> device_id: 2
>>>>>>>>>
>>>>>>>>>Not sure if it needs to obtain the dpll id in this step, but it doesn't
>>>>>>>>>relate to the dpll interface..
>>>>>>>>
>>>>>>>>Sure it has to. The PIN_SET accepts pin_id and device_id attrs as input.
>>>>>>>>You need to set the state on a pin on a certain DPLL device.
>>>>>>>>
>>>>>>>
>>>>>>>The thing is pin can be connected to multiple dplls and SyncE daemon shall
>>>>>>>know already something about the dpll it is managing.
>>>>>>>Not saying it is not needed, I am saying this is not a moment the SyncE
>>>>>>>daemon
>>>>>>>learns it.
>>>>>>
>>>>>>Moment or not, it is needed for the cmd, that is why I have it there.
>>>>>>
>>>>>>
>>>>>>>But let's park it, as this is not really relevant.
>>>>>>
>>>>>>Agreed.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =
>>>>>>>>>>CONNECTED
>>>>>>>>>>
>>>>>>>>>>2)
>>>>>>>>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth1
>>>>>>>>>>    -> pin_id: 11
>>>>>>>>>> SenceE daemon will use PIN_GET with pin_id 11 to get DPLL device id
>>>>>>>>>>    -> device_id: 2
>>>>>>>>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =
>>>>>>>>>>CONNECTED
>>>>>>>>>> (that will in HW disconnect previously connected pin 10, there
>>>>>>>>>>will be
>>>>>>>>>>  notification of pin_id 10, device_id -> state DISCONNECT)
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>This flow is similar for ice, but there are some differences, although
>>>>>>>>>they come from the fact, the ice is using AUTOMATIC mode and recovered
>>>>>>>>>clock pins which are not directly connected to a dpll (connected
>>>>>>>>>through
>>>>>>>>>the MUX pin).
>>>>>>>>>
>>>>>>>>>1)
>>>>>>>>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 ->
>>>>>>>>>pin_id: 13
>>>>>>>>>b) SyncE daemon uses PIN_GET to find a parent MUX type pin -> pin_id: 2
>>>>>>>>>   (in case of dpll_id is needed, would be find in this response also)
>>>>>>>>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) to
>>>>>>>>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while
>>>>>>>>>all the
>>>>>>>>>   other pins shall be lower prio i.e. pin-prio:1)
>>>>>>>>
>>>>>>>>Yeah, for this you need pin_id 2 and device_id. Because you are setting
>>>>>>>>state on DPLL device.
>>>>>>>>
>>>>>>>>
>>>>>>>>>d) SyncE daemon uses PIN_SET to set state of pin_id:13 to CONNECTED
>>>>>>>>>with
>>>>>>>>>   parent pin (pin-id:2)
>>>>>>>>
>>>>>>>>For this you need pin_id and pin_parent_id because you set the state on
>>>>>>>>a parent pin.
>>>>>>>>
>>>>>>>>
>>>>>>>>Yeah, this is exactly why I initially was in favour of hiding all the
>>>>>>>>muxes and magic around it hidden from the user. Now every userspace app
>>>>>>>>working with this has to implement a logic of tracking pin and the mux
>>>>>>>>parents (possibly multiple levels) and configure everything. But it
>>>>>>>>just
>>>>>>>>need a simple thing: "select this pin as a source" :/
>>>>>>>>
>>>>>>>>
>>>>>>>>Jakub, isn't this sort of unnecessary HW-details complexicity exposure
>>>>>>>>in UAPI you were against in the past? Am I missing something?
>>>>>>>>
>>>>>>>
>>>>>>>Multiple level of muxes possibly could be hidden in the driver, but the
>>>>>>>fact
>>>>>>>they exist is not possible to be hidden from the user if the DPLL is in
>>>>>>>AUTOMATIC mode.
>>>>>>>For MANUAL mode dpll the muxes could be also hidden.
>>>>>>>Yeah, we have in ice most complicated scenario of AUTOMATIC mode + MUXED
>>>>>>>type
>>>>>>>pin.
>>>>>>
>>>>>>Sure, but does user care how complicated things are inside? The syncE
>>>>>>daemon just cares for: "select netdev x as a source". However it is done
>>>>>>internally is irrelevant to him. With the existing UAPI, the syncE
>>>>>>daemon needs to learn individual device dpll/pin/mux topology and
>>>>>>work with it.
>>>>>>
>>>>>
>>>>>This is dpll subsystem not SyncE one.
>>>>
>>>>SyncE is very legit use case of the UAPI. I would say perhaps the most
>>>>important.
>>>>
>>>
>>>But it is still a dpll subsystem.
>>>
>>>Thank you!
>>>Arkadiusz
>>>
>>>>
>>>>>
>>>>>>Do we need a dpll library to do this magic?
>>>>>>
>>>>>
>>>>>IMHO rather SyncE library :)
>>>>>
>>>>>Thank you!
>>>>>Arkadiusz
>>>>>
>>>>>>
>>>>>>>
>>>>>>>Thank you!
>>>>>>>Arkadiusz
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>2) (basically the same, only eth1 would get different pin_id.)
>>>>>>>>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 ->
>>>>>>>>>pin_id: 14
>>>>>>>>>b) SyncE daemon uses PIN_GET to find parent MUX type pin -> pin_id: 2
>>>>>>>>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) to
>>>>>>>>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while
>>>>>>>>>all the
>>>>>>>>>   other pins shall be lower prio i.e. pin-prio:1)
>>>>>>>>>d) SyncE daemon uses PIN_SET to set state of pin_id:14 to CONNECTED
>>>>>>>>>with
>>>>>>>>>   parent pin (pin-id:2)
>>>>>>>>>
>>>>>>>>>Where step c) is required due to AUTOMATIC mode, and step d) required
>>>>>>>>>due to
>>>>>>>>>phy recovery clock pin being connected through the MUX type pin.
>>>>>>>>>
>>>>>>>>>Thank you!
>>>>>>>>>Arkadiusz
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>Thanks!
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>[...]
>>>>>>>

