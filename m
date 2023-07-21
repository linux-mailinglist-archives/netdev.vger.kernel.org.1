Return-Path: <netdev+bounces-19743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F1975BFC5
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 09:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497FB2821A9
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 07:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3F220F2;
	Fri, 21 Jul 2023 07:33:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951520E4
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:33:21 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6496E270A
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 00:33:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fba86f069bso2529638e87.3
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 00:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689924796; x=1690529596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYK3IrQCwIlRKnidHAZyFhY83ge+Okh3eSN0zwEW7aI=;
        b=T/kWxas2KxG5t6m1LECmvOW0hLTn7ZtkhiqoHsk+sd5n2C6vEmrM/W71W0+KqCfSqr
         kZu5bQvvltUKqh3faY5Z+e5JVo0ytLnVZmmJRDyckz7A8pM7C7u6YHtRfCnKWdinBgM5
         39JiaKhx35YVLwNcOcsjzaBplIMac4jtBgFFnzvFIOhQuivyzys4yQ1sp7/UpXVrYKsa
         I66ClMJGTOKAyny6jHaqanUYb9Uj2s9KqThtr6093IPedP5VPWObz6/kk8JqvlMr06yW
         LKmpd6faKQQSKdPHN4oqnS5E0WEig3/+hQY4CPfYirLvoSVDvkSO8rmDcqKGuBNZ+Els
         GNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689924796; x=1690529596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYK3IrQCwIlRKnidHAZyFhY83ge+Okh3eSN0zwEW7aI=;
        b=JgO6Ruh8Apor/8XAw/K8VMx9wFWZ3tVb7kqwtvHyFNy47Mkc1rDO3udMlpR8T4xMm6
         pJRQ2EDZqz25v5Q7LfTZTZASQ4X0Fe3nDxRGKMszFlmtZ8w/WWnpEBLYvbng4oliQtDv
         ULcCeu64vZMp4q9UofFGknz9sKcfUY1zY8oJ535n8Rnsa8zRydGOiqChXektj+YM6HvT
         AzEON95ynUbdkvs+m1nyd5CNl5gSd3CKdzmLyNHxkSpiT3fcXH+MDiev/csRqQHXKi3u
         /ZR55Zwx7UpGGzNRo2EaJ3CaSV4ntc4CFYiATrBTTCnp8/u0ErLRUXESao3LxxY6P92j
         9Q/w==
X-Gm-Message-State: ABy/qLY64L0aG8Xz16JSJer04Vc881uYGENz8Gg8aSSr6s8wzbn7UcB9
	bLub+n1i8O67CtmO1wFU1LGr9w==
X-Google-Smtp-Source: APBJJlEQqkNu5OMsSGxZu2OgY+YB7ZPg1GE94FcV4r3WbogJGl5e3IrmaZ8+7oYeVhHc3bq/gsNjJA==
X-Received: by 2002:ac2:4f05:0:b0:4f8:5696:6bbc with SMTP id k5-20020ac24f05000000b004f856966bbcmr956672lfr.29.1689924796481;
        Fri, 21 Jul 2023 00:33:16 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id w10-20020adfd4ca000000b003140f47224csm3394956wrk.15.2023.07.21.00.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:33:15 -0700 (PDT)
Date: Fri, 21 Jul 2023 09:33:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	kuba@kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
Message-ID: <ZLo0ujuLMF2NrMog@nanopsycho>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLk/9zwbBHgs+rlb@nanopsycho>
 <DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jul 20, 2023 at 07:31:14PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Thursday, July 20, 2023 4:09 PM
>>
>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev wrote:
>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>
>>[...]
>>
>>
>>>+/**
>>>+ * ice_dpll_pin_enable - enable a pin on dplls
>>>+ * @hw: board private hw structure
>>>+ * @pin: pointer to a pin
>>>+ * @pin_type: type of pin being enabled
>>>+ * @extack: error reporting
>>>+ *
>>>+ * Enable a pin on both dplls. Store current state in pin->flags.
>>>+ *
>>>+ * Context: Called under pf->dplls.lock
>>>+ * Return:
>>>+ * * 0 - OK
>>>+ * * negative - error
>>>+ */
>>>+static int
>>>+ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>>>+		    enum ice_dpll_pin_type pin_type,
>>>+		    struct netlink_ext_ack *extack)
>>>+{
>>>+	u8 flags = 0;
>>>+	int ret;
>>>+
>>
>>
>>
>>I don't follow. Howcome you don't check if the mode is freerun here or
>>not? Is it valid to enable a pin when freerun mode? What happens?
>>
>
>Because you are probably still thinking the modes are somehow connected
>to the state of the pin, but it is the other way around.
>The dpll device mode is a state of DPLL before pins are even considered.
>If the dpll is in mode FREERUN, it shall not try to synchronize or monitor
>any of the pins.
>
>>Also, I am probably slow, but I still don't see anywhere in this
>>patchset any description about why we need the freerun mode. What is
>>diffrerent between:
>>1) freerun mode
>>2) automatic mode & all pins disabled?
>
>The difference:
>Case I:
>1. set dpll to FREERUN and configure the source as if it would be in
>AUTOMATIC
>2. switch to AUTOMATIC
>3. connecting to the valid source takes ~50 seconds
>
>Case II:
>1. set dpll to AUTOMATIC, set all the source to disconnected
>2. switch one valid source to SELECTABLE
>3. connecting to the valid source takes ~10 seconds
>
>Basically in AUTOMATIC mode the sources are still monitored even when they
>are not in SELECTABLE state, while in FREERUN there is no such monitoring,
>so in the end process of synchronizing with the source takes much longer as
>dpll need to start the process from scratch.

I believe this is implementation detail of your HW. How you do it is up
to you. User does not have any visibility to this behaviour, therefore
makes no sense to expose UAPI that is considering it. Please drop it at
least for the initial patchset version. If you really need it later on
(which I honestly doubt), you can send it as a follow-up patchset.



>
>>
>>Isn't the behaviour of 1) and 2) exactly the same? If no, why? This
>>needs to be documented, please.
>>
>
>Sure will add the description of FREERUN to the docs.

No, please drop it from this patchset. I have no clue why you readded
it in the first place in the last patchset version.


>
>>
>>
>>Another question, I asked the last time as well, but was not heard:
>>Consider example where you have 2 netdevices, eth0 and eth1, each
>>connected with a single DPLL pin:
>>eth0 - DPLL pin 10 (DPLL device id 2)
>>eth1 - DPLL pin 11 (DPLL device id 2)
>>
>>You have a SyncE daemon running on top eth0 and eth1.
>>
>>Could you please describe following 2 flows?
>>
>>1) SyncE daemon selects eth0 as a source of clock
>>2) SyncE daemon selects eth1 as a source of clock
>>
>>
>>For mlx5 it goes like:
>>
>>DPLL device mode is MANUAL.
>>1)
>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth0
>>    -> pin_id: 10
>> SenceE daemon will use PIN_GET with pin_id 10 to get DPLL device id
>>    -> device_id: 2
>
>Not sure if it needs to obtain the dpll id in this step, but it doesn't
>relate to the dpll interface..

Sure it has to. The PIN_SET accepts pin_id and device_id attrs as input.
You need to set the state on a pin on a certain DPLL device.


>
>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =
>>CONNECTED
>>
>>2)
>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth1
>>    -> pin_id: 11
>> SenceE daemon will use PIN_GET with pin_id 11 to get DPLL device id
>>    -> device_id: 2
>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =
>>CONNECTED
>> (that will in HW disconnect previously connected pin 10, there will be
>>  notification of pin_id 10, device_id -> state DISCONNECT)
>>
>
>This flow is similar for ice, but there are some differences, although
>they come from the fact, the ice is using AUTOMATIC mode and recovered
>clock pins which are not directly connected to a dpll (connected through
>the MUX pin).
>
>1) 
>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 -> pin_id: 13
>b) SyncE daemon uses PIN_GET to find a parent MUX type pin -> pin_id: 2
>   (in case of dpll_id is needed, would be find in this response also)
>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) to
>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while all the
>   other pins shall be lower prio i.e. pin-prio:1)

Yeah, for this you need pin_id 2 and device_id. Because you are setting
state on DPLL device.


>d) SyncE daemon uses PIN_SET to set state of pin_id:13 to CONNECTED with
>   parent pin (pin-id:2)

For this you need pin_id and pin_parent_id because you set the state on
a parent pin.


Yeah, this is exactly why I initially was in favour of hiding all the
muxes and magic around it hidden from the user. Now every userspace app
working with this has to implement a logic of tracking pin and the mux
parents (possibly multiple levels) and configure everything. But it just
need a simple thing: "select this pin as a source" :/


Jakub, isn't this sort of unnecessary HW-details complexicity exposure
in UAPI you were against in the past? Am I missing something?



> 
>2) (basically the same, only eth1 would get different pin_id.)
>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 -> pin_id: 14
>b) SyncE daemon uses PIN_GET to find parent MUX type pin -> pin_id: 2
>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) to
>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while all the
>   other pins shall be lower prio i.e. pin-prio:1)
>d) SyncE daemon uses PIN_SET to set state of pin_id:14 to CONNECTED with
>   parent pin (pin-id:2)
>
>Where step c) is required due to AUTOMATIC mode, and step d) required due to
>phy recovery clock pin being connected through the MUX type pin.
>
>Thank you!
>Arkadiusz
>
>>
>>Thanks!
>>
>>
>>[...]

