Return-Path: <netdev+bounces-19809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF11975C660
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57BA282216
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 12:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13061E50A;
	Fri, 21 Jul 2023 12:03:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB451D2F6
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:03:16 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E013A98
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 05:02:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so15308195e9.2
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689940930; x=1690545730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk63RChk971hx/wl+lPvy732XZ7IGqfv3tMslcdagrI=;
        b=G5UatuTsXi/XjXKrY+wrDqIO/f3YXQ3zQeqKrQ6AXwwU6jKf/lsRdfU15ZZ+cEDFPb
         eZCZ3spWElh0t6COgYWBNoyJ/AHE9C8ypUWQfN/yICvrVqQqjMIlQ0/8wEeD0tsj/bVK
         e/WpRSl29hRf9TbmD8Knzb8cVHCz0jRHDQDYyWNnajtSbBLAzsIAFUwc8NGGKF8eAfwh
         TV3Ay9cL6u/w+gOzbkZvhw0sfcm34NcTGMWfkSz0DiDD4EfvC9Uw1FHJL67U7urhD+Vb
         J/6Ncc0O9ST7ZuLHy6Xj7eoqORhhPz1DkfP397PsiqPIZmATqFGKkhDuvr/mNckM6W0J
         Ztxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689940930; x=1690545730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uk63RChk971hx/wl+lPvy732XZ7IGqfv3tMslcdagrI=;
        b=KC/R+42VHOl6FxgnZIhRjv59qX3Sp7yTc652vPAB6kT6XOMHA58OF+GGsSSeyKz5zx
         TXIcWYFLH/HoQ6ufSYrywFGbOv9cJO699wvycn7Gx//vHKZGfWrxlULgd5/fBOVRsxIn
         XpU6rrZiOrL42UdxoXTIq789R1IVk+elmT+y2+oXdLjUfIbfjYjoFfX59fVvHlPI2Woj
         kzsYFFNtJS2J8GitC3b7kgYk3ZO0VecnnbxePp2zgEfhr81zYcY71YZqEm8qVf/UHhV2
         VaiYCflXUO1/IIJHEctKCjgg/kJHukSBSYO3AMPBSpzxNEk0TEAjqm2isH5Fr+vfKQAV
         xBLQ==
X-Gm-Message-State: ABy/qLbnbLTVcH4DRFz2mac7xKOK5LQTut4tzKMuyaqh/CRYjh8t2VVx
	oyvHj7vruO8APCocMPdboQwiqA==
X-Google-Smtp-Source: APBJJlFBi0s6hS6tmUYK6NjhO/dxN7BONAI1AalV3sMiRCkPDjBf/mDZnWA+uNuz34jmHiiNwmQR8w==
X-Received: by 2002:a5d:6984:0:b0:313:e9d7:108f with SMTP id g4-20020a5d6984000000b00313e9d7108fmr1192289wru.33.1689940930136;
        Fri, 21 Jul 2023 05:02:10 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x17-20020adfffd1000000b003141f3843e6sm3995858wrs.90.2023.07.21.05.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:02:09 -0700 (PDT)
Date: Fri, 21 Jul 2023 14:02:08 +0200
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
Message-ID: <ZLpzwMQrqp7mIMFF@nanopsycho>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLk/9zwbBHgs+rlb@nanopsycho>
 <DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLo0ujuLMF2NrMog@nanopsycho>
 <DM6PR11MB46576153E0E28BA4C283A30A9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46576153E0E28BA4C283A30A9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Jul 21, 2023 at 01:17:59PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Friday, July 21, 2023 9:33 AM
>>
>>Thu, Jul 20, 2023 at 07:31:14PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Thursday, July 20, 2023 4:09 PM
>>>>
>>>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev wrote:
>>>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>
>>>>[...]
>>>>
>>>>
>>>>>+/**
>>>>>+ * ice_dpll_pin_enable - enable a pin on dplls
>>>>>+ * @hw: board private hw structure
>>>>>+ * @pin: pointer to a pin
>>>>>+ * @pin_type: type of pin being enabled
>>>>>+ * @extack: error reporting
>>>>>+ *
>>>>>+ * Enable a pin on both dplls. Store current state in pin->flags.
>>>>>+ *
>>>>>+ * Context: Called under pf->dplls.lock
>>>>>+ * Return:
>>>>>+ * * 0 - OK
>>>>>+ * * negative - error
>>>>>+ */
>>>>>+static int
>>>>>+ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>>>>>+		    enum ice_dpll_pin_type pin_type,
>>>>>+		    struct netlink_ext_ack *extack)
>>>>>+{
>>>>>+	u8 flags = 0;
>>>>>+	int ret;
>>>>>+
>>>>
>>>>
>>>>
>>>>I don't follow. Howcome you don't check if the mode is freerun here or
>>>>not? Is it valid to enable a pin when freerun mode? What happens?
>>>>
>>>
>>>Because you are probably still thinking the modes are somehow connected
>>>to the state of the pin, but it is the other way around.
>>>The dpll device mode is a state of DPLL before pins are even considered.
>>>If the dpll is in mode FREERUN, it shall not try to synchronize or monitor
>>>any of the pins.
>>>
>>>>Also, I am probably slow, but I still don't see anywhere in this
>>>>patchset any description about why we need the freerun mode. What is
>>>>diffrerent between:
>>>>1) freerun mode
>>>>2) automatic mode & all pins disabled?
>>>
>>>The difference:
>>>Case I:
>>>1. set dpll to FREERUN and configure the source as if it would be in
>>>AUTOMATIC
>>>2. switch to AUTOMATIC
>>>3. connecting to the valid source takes ~50 seconds
>>>
>>>Case II:
>>>1. set dpll to AUTOMATIC, set all the source to disconnected
>>>2. switch one valid source to SELECTABLE
>>>3. connecting to the valid source takes ~10 seconds
>>>
>>>Basically in AUTOMATIC mode the sources are still monitored even when they
>>>are not in SELECTABLE state, while in FREERUN there is no such monitoring,
>>>so in the end process of synchronizing with the source takes much longer as
>>>dpll need to start the process from scratch.
>>
>>I believe this is implementation detail of your HW. How you do it is up
>>to you. User does not have any visibility to this behaviour, therefore
>>makes no sense to expose UAPI that is considering it. Please drop it at
>>least for the initial patchset version. If you really need it later on
>>(which I honestly doubt), you can send it as a follow-up patchset.
>>
>
>And we will have the same discussion later.. But implementation is already
>there.

Yeah, it wouldn't block the initial submission. I would like to see this
merged, so anything which is blocking us and is totally optional (as
this freerun mode) is better to be dropped.


>As said in our previous discussion, without mode_set there is no point to have
>command DEVICE_SET at all, and there you said that you are ok with having the
>command as a placeholder, which doesn't make sense, since it is not used. 

I don't see any problem in having enum value reserved. But it does not
need to be there at all. You can add it to the end of the list when
needed. No problem. This is not an argument.


>
>Also this is not HW implementation detail but a synchronizer chip feature,
>once dpll is in FREERUN mode, the measurements like phase offset between the
>input and dpll's output won't be available.
>
>For the user there is a difference..
>Enabling the FREERUN mode is a reset button on the dpll's state machine,
>where disconnecting sources is not, as they are still used, monitored and
>measured.

So it is not a mode! Mode is either "automatic" or "manual". Then we
have a state to indicate the state of the state machine (unlocked, locked,
holdover, holdover-acq). So what you seek is a way for the user to
expliticly set the state to "unlocked" and reset of the state machine.

Please don't mix config and state. I think we untangled this in the past
:/

Perhaps you just need an extra cmd like DPLL_CMD_DEVICE_STATE_RESET cmd
to hit this button.



>So probably most important fact that you are missing here: assuming the user
>disconnects the pin that dpll was locked with, our dpll doesn't go into UNLOCKED
>state but into HOLDOVER.
>
>>
>>
>>>
>>>>
>>>>Isn't the behaviour of 1) and 2) exactly the same? If no, why? This
>>>>needs to be documented, please.
>>>>
>>>
>>>Sure will add the description of FREERUN to the docs.
>>
>>No, please drop it from this patchset. I have no clue why you readded
>>it in the first place in the last patchset version.
>>
>
>mode_set was there from the very beginning.. now implemented in ice driver
>as it should.

I don't understand the fixation on a callback to be implemented. Just
remove it. It can be easily added when needed. No problem.


>
>>
>>>
>>>>
>>>>
>>>>Another question, I asked the last time as well, but was not heard:
>>>>Consider example where you have 2 netdevices, eth0 and eth1, each
>>>>connected with a single DPLL pin:
>>>>eth0 - DPLL pin 10 (DPLL device id 2)
>>>>eth1 - DPLL pin 11 (DPLL device id 2)
>>>>
>>>>You have a SyncE daemon running on top eth0 and eth1.
>>>>
>>>>Could you please describe following 2 flows?
>>>>
>>>>1) SyncE daemon selects eth0 as a source of clock
>>>>2) SyncE daemon selects eth1 as a source of clock
>>>>
>>>>
>>>>For mlx5 it goes like:
>>>>
>>>>DPLL device mode is MANUAL.
>>>>1)
>>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth0
>>>>    -> pin_id: 10
>>>> SenceE daemon will use PIN_GET with pin_id 10 to get DPLL device id
>>>>    -> device_id: 2
>>>
>>>Not sure if it needs to obtain the dpll id in this step, but it doesn't
>>>relate to the dpll interface..
>>
>>Sure it has to. The PIN_SET accepts pin_id and device_id attrs as input.
>>You need to set the state on a pin on a certain DPLL device.
>>
>
>The thing is pin can be connected to multiple dplls and SyncE daemon shall
>know already something about the dpll it is managing.
>Not saying it is not needed, I am saying this is not a moment the SyncE daemon
>learns it.

Moment or not, it is needed for the cmd, that is why I have it there.


>But let's park it, as this is not really relevant.

Agreed.


>
>>
>>>
>>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =
>>>>CONNECTED
>>>>
>>>>2)
>>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth1
>>>>    -> pin_id: 11
>>>> SenceE daemon will use PIN_GET with pin_id 11 to get DPLL device id
>>>>    -> device_id: 2
>>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =
>>>>CONNECTED
>>>> (that will in HW disconnect previously connected pin 10, there will be
>>>>  notification of pin_id 10, device_id -> state DISCONNECT)
>>>>
>>>
>>>This flow is similar for ice, but there are some differences, although
>>>they come from the fact, the ice is using AUTOMATIC mode and recovered
>>>clock pins which are not directly connected to a dpll (connected through
>>>the MUX pin).
>>>
>>>1)
>>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 ->
>>>pin_id: 13
>>>b) SyncE daemon uses PIN_GET to find a parent MUX type pin -> pin_id: 2
>>>   (in case of dpll_id is needed, would be find in this response also)
>>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) to
>>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while all the
>>>   other pins shall be lower prio i.e. pin-prio:1)
>>
>>Yeah, for this you need pin_id 2 and device_id. Because you are setting
>>state on DPLL device.
>>
>>
>>>d) SyncE daemon uses PIN_SET to set state of pin_id:13 to CONNECTED with
>>>   parent pin (pin-id:2)
>>
>>For this you need pin_id and pin_parent_id because you set the state on
>>a parent pin.
>>
>>
>>Yeah, this is exactly why I initially was in favour of hiding all the
>>muxes and magic around it hidden from the user. Now every userspace app
>>working with this has to implement a logic of tracking pin and the mux
>>parents (possibly multiple levels) and configure everything. But it just
>>need a simple thing: "select this pin as a source" :/
>>
>>
>>Jakub, isn't this sort of unnecessary HW-details complexicity exposure
>>in UAPI you were against in the past? Am I missing something?
>>
>
>Multiple level of muxes possibly could be hidden in the driver, but the fact
>they exist is not possible to be hidden from the user if the DPLL is in
>AUTOMATIC mode.
>For MANUAL mode dpll the muxes could be also hidden.
>Yeah, we have in ice most complicated scenario of AUTOMATIC mode + MUXED type
>pin.

Sure, but does user care how complicated things are inside? The syncE
daemon just cares for: "select netdev x as a source". However it is done
internally is irrelevant to him. With the existing UAPI, the syncE
daemon needs to learn individual device dpll/pin/mux topology and
work with it.

Do we need a dpll library to do this magic?


>
>Thank you!
>Arkadiusz
>
>>
>>
>>>
>>>2) (basically the same, only eth1 would get different pin_id.)
>>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 ->
>>>pin_id: 14
>>>b) SyncE daemon uses PIN_GET to find parent MUX type pin -> pin_id: 2
>>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) to
>>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while all the
>>>   other pins shall be lower prio i.e. pin-prio:1)
>>>d) SyncE daemon uses PIN_SET to set state of pin_id:14 to CONNECTED with
>>>   parent pin (pin-id:2)
>>>
>>>Where step c) is required due to AUTOMATIC mode, and step d) required due to
>>>phy recovery clock pin being connected through the MUX type pin.
>>>
>>>Thank you!
>>>Arkadiusz
>>>
>>>>
>>>>Thanks!
>>>>
>>>>
>>>>[...]
>

