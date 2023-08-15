Return-Path: <netdev+bounces-27669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8529777CC09
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 13:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12442814BF
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 11:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6D21119C;
	Tue, 15 Aug 2023 11:52:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E02FC15C
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 11:52:16 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE43C9
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 04:52:13 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe8242fc4dso44877125e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 04:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692100332; x=1692705132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XG1CdDs3BJOFxaT2xWjh9aVXbUzXw0Qce5rbzwyMS1I=;
        b=cx29Z2/Gf27wrI+GW+nt3MIGLYw8rdG0pM2V8V6gDIXoay6oVWyPcSlNRrXgx+ia9H
         bynI3SuDiD1rHaWKQmAYTV+ZTfQRL8SBYnGy7ugUvdKNYR2KihJl4aW/Ae6gZOEY+ppk
         C+bHh+tb7qpNR5GWM7RLqu4DpPHA6S7nI3guRFLWjxpbWRZGPcmghzt7lHjZWBPKEHrR
         2fzhXb3Ah5+iraDZEA83A635nZ1V8bHmbW2lwyeqV/rCQP+S2FLs1H33TInFKWf3s2oO
         HmUYDH1HIX7JjEYrXa0u+I/jRXatro806knbv5tOnVzBiq3f5FvOjTuiNbgH9Q+B3xzP
         HZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692100332; x=1692705132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XG1CdDs3BJOFxaT2xWjh9aVXbUzXw0Qce5rbzwyMS1I=;
        b=ibkXw5DmQchTZKE4JUsVWwx23N0cj16lA/hARS7Wik/tmcnSPO+q0JmxeueUNBX2CP
         ONMFoj72/0T5dYHz3Nd4/Q+gbbKoyleAXZsR+w27qmSM0w6hWi8yg0LIbk3IdQkCec9o
         tG0Y6k6MjrMzWOoenn+7H3Vua7pZNX75cShuSDdKiekpnSiQCZqPqaiDRud2trQeeOvo
         7i2q+vPUxx5xUcpDChuJQJeR2Vz6JTadBEc7iVJNHIOE5vwoCOaM4JGfil0Q7hvXLzCn
         C6AI4msCuXeuFs2v2g9zTsrWuf64r++O/FXHrI1Cw410bfYKUIbvxDX4AxS3SlZPwccL
         cw5Q==
X-Gm-Message-State: AOJu0YyTZ2dJC0y/NcsGdDqlRIV6xm0zYMGzYLsN6LwyHvC/3qo/a01C
	rl72/EN/IolAExYMoNDBlEG89A==
X-Google-Smtp-Source: AGHT+IG4DWtf444jYikYwXk+iJ1caroN9SCLeIUZQSKVD0XACiRvyg7nhoXLwxD45xrNyqAuLwJwHQ==
X-Received: by 2002:a05:600c:214d:b0:3fe:179a:9eee with SMTP id v13-20020a05600c214d00b003fe179a9eeemr9396315wml.30.1692100331959;
        Tue, 15 Aug 2023 04:52:11 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id z5-20020a7bc7c5000000b003fbe4cecc3bsm20301828wmk.16.2023.08.15.04.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 04:52:11 -0700 (PDT)
Date: Tue, 15 Aug 2023 13:52:10 +0200
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
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 0/9] Create common DPLL configuration API
Message-ID: <ZNtm6v+UuDIex1+s@nanopsycho>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230814194528.00baec23@kernel.org>
 <43395307-9d11-7905-0eec-0a4c1b1fc62a@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43395307-9d11-7905-0eec-0a4c1b1fc62a@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 15, 2023 at 01:36:11PM CEST, vadim.fedorenko@linux.dev wrote:
>On 15/08/2023 03:45, Jakub Kicinski wrote:
>> On Fri, 11 Aug 2023 21:03:31 +0100 Vadim Fedorenko wrote:
>> >   create mode 100644 Documentation/driver-api/dpll.rst
>> >   create mode 100644 Documentation/netlink/specs/dpll.yaml
>> >   create mode 100644 drivers/dpll/Kconfig
>> >   create mode 100644 drivers/dpll/Makefile
>> >   create mode 100644 drivers/dpll/dpll_core.c
>> >   create mode 100644 drivers/dpll/dpll_core.h
>> >   create mode 100644 drivers/dpll/dpll_netlink.c
>> >   create mode 100644 drivers/dpll/dpll_netlink.h
>> >   create mode 100644 drivers/dpll/dpll_nl.c
>> >   create mode 100644 drivers/dpll/dpll_nl.h
>> >   create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.c
>> >   create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.h
>> >   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>> >   create mode 100644 include/linux/dpll.h
>> >   create mode 100644 include/uapi/linux/dpll.h
>> 
>> Feels like we're lacking tests here. Is there a common subset of
>> stuff we can expect reasonable devices to support?
>> Anything you used in development that can be turned into tests?
>
>Well, we were playing with the tool ynl/cli.py and it's stated in
>the cover letter. But needs proper hardware to run. I'm not sure
>we can easily create emulation device to run tests.

Well, something like "dpllsim", similar to netdevsim would be certainly
possible, then you can use it to write selftests for the uapi testing.
But why don't we do that as a follow-up patchset?

