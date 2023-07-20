Return-Path: <netdev+bounces-19518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0827675B0DB
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A9A281E68
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9421D182C0;
	Thu, 20 Jul 2023 14:09:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867EC171A9
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:09:01 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A716211D
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:08:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so12201001fa.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689862137; x=1690466937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0F4qt8y1B6CKQx+PcuHEtUg+2LdJdvmBAdu8A9bWVA=;
        b=fk2W5inpSBgysWw6YjUv4qZziLX9MNP/62x8E1NtOwYLMXl8tWrS3ytc3dpdtvQXvR
         2kCkA0KSwbUDPQqGYCmqQfYqrz178s/lkrVJFlK12TtHR+vyOO1dA3esZ6jSuKu4U/OZ
         /zg2XBV8UkXzq2g3pBKTk10trZ8NwetQYlU6U/P7zVlHzOpn0S6P+m0E2Pti1FXKc0P5
         HRIIzkbK8T2OqY6D5sQlLqg2YFkq8v9mAi6q+OiEWQRtx43gUkbHfMEhEJpVM+yX7Qlz
         FCsq9fkqPP9DrGdJ0JQ2IYLr0hr6T+m8j/tDadxjqiaYh801FZCQAOzcvSWNvpro3Os2
         k8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689862137; x=1690466937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0F4qt8y1B6CKQx+PcuHEtUg+2LdJdvmBAdu8A9bWVA=;
        b=gnGydd9HETmvQfNqo9hmxBWrj3YVYg1czR4/t82dqovzDY2YcHpfg04y3vARfXdMD6
         G2piEjWCbntUlO9dD/CoAcxzYbCupRkaULQ5dq9+4j4D29ejOB3SD6DlTzUJ/hkf+CFM
         nQY6EXM/3OucYoyjlAGjJpzdNp2bIRFZt8HJB+/W60OcJERvP252tpZEd3Ae6H2Sz8G9
         O2MWjOQmTOrXzaw7EdmHF/A2S8LSbmQWL63EuQIOQsJNIIWLlIRtywDeg4OG6C/qiU49
         HeEo3wIihGMQUkuxIvBbLRuZg200UInwI7g4APu9/mVCVR2arSVJ+BaI7MeCqATDtqYb
         AfQw==
X-Gm-Message-State: ABy/qLZc+EXiWpx3Fh8FgvZ1My6xifkRpw8qEbygvfXXbvhpME+I7hyO
	NqWHM0HquJW0T0KzmX+CT0YWfYYlYuwJxaW2S74=
X-Google-Smtp-Source: APBJJlGL5Xu/p/+dewcIpMhrBKBuamn+f5NSjDhyK8nrWTxvyRHHlMVTStlS2o7s5thnPRT6dqtz0g==
X-Received: by 2002:a2e:3c14:0:b0:2b9:615b:39a9 with SMTP id j20-20020a2e3c14000000b002b9615b39a9mr2271784lja.52.1689862137543;
        Thu, 20 Jul 2023 07:08:57 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c00c600b003fbb5142c4bsm4073779wmm.18.2023.07.20.07.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:08:56 -0700 (PDT)
Date: Thu, 20 Jul 2023 16:08:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-arm-kernel@lists.infradead.org, poros@redhat.com,
	mschmidt@redhat.com, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 09/11] ice: implement dpll interface to control cgu
Message-ID: <ZLk/9zwbBHgs+rlb@nanopsycho>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720091903.297066-10-vadim.fedorenko@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev wrote:
>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

[...]


>+/**
>+ * ice_dpll_pin_enable - enable a pin on dplls
>+ * @hw: board private hw structure
>+ * @pin: pointer to a pin
>+ * @pin_type: type of pin being enabled
>+ * @extack: error reporting
>+ *
>+ * Enable a pin on both dplls. Store current state in pin->flags.
>+ *
>+ * Context: Called under pf->dplls.lock
>+ * Return:
>+ * * 0 - OK
>+ * * negative - error
>+ */
>+static int
>+ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>+		    enum ice_dpll_pin_type pin_type,
>+		    struct netlink_ext_ack *extack)
>+{
>+	u8 flags = 0;
>+	int ret;
>+



I don't follow. Howcome you don't check if the mode is freerun here or
not? Is it valid to enable a pin when freerun mode? What happens?

Also, I am probably slow, but I still don't see anywhere in this
patchset any description about why we need the freerun mode. What is
diffrerent between:
1) freerun mode
2) automatic mode & all pins disabled?

Isn't the behaviour of 1) and 2) exactly the same? If no, why? This
needs to be documented, please.



Another question, I asked the last time as well, but was not heard:
Consider example where you have 2 netdevices, eth0 and eth1, each
connected with a single DPLL pin:
eth0 - DPLL pin 10 (DPLL device id 2)
eth1 - DPLL pin 11 (DPLL device id 2)

You have a SyncE daemon running on top eth0 and eth1.

Could you please describe following 2 flows?

1) SyncE daemon selects eth0 as a source of clock
2) SyncE daemon selects eth1 as a source of clock


For mlx5 it goes like:

DPLL device mode is MANUAL.
1)
 SynceE daemon uses RTNetlink to obtain DPLL pin number of eth0
    -> pin_id: 10
 SenceE daemon will use PIN_GET with pin_id 10 to get DPLL device id
    -> device_id: 2
 SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state = CONNECTED

2)
 SynceE daemon uses RTNetlink to obtain DPLL pin number of eth1
    -> pin_id: 11
 SenceE daemon will use PIN_GET with pin_id 11 to get DPLL device id
    -> device_id: 2
 SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state = CONNECTED
 (that will in HW disconnect previously connected pin 10, there will be
  notification of pin_id 10, device_id -> state DISCONNECT)


Thanks!


[...]

