Return-Path: <netdev+bounces-23948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF47276E449
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D2E1C213EB
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E5A1549F;
	Thu,  3 Aug 2023 09:24:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545867E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:24:45 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9024D30FA
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:24:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3177f520802so1172436f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 02:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691054681; x=1691659481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HF4Y9/Tb44mhvBF9ysUsnXqQI4uBxPo0V5rBsbgndUU=;
        b=QjUeykdx6Wpgaj2E25KOJpRJM28tYKFK8WJP7XXkKllua6fWzkOP2KvmFE8mLuwurB
         F/znomOyhUEH6XL/kkEbtUFbGjaV5LqZmVQWN7jq2b9OVNqcUwmR0HJ3kH2JPiNKXyiv
         09yHJ9uCEznrgcZMjusW88HrDprI6uBnxYY9UDpLO5FAUWuryJYblw6sk/BzUcNcva1Z
         foT6nWTvk446FjFH7+PodL84y0Fo5CcZXPSpu8nsJG+LnNRnevU3wzohQfvcSX5Czzxs
         JRV/mGmUOXUomgUPul5BzcaSbAad9p2t48OsoW5e7K/kQCpaAH0NyVuRjN91JcTgTa6f
         YUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691054681; x=1691659481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HF4Y9/Tb44mhvBF9ysUsnXqQI4uBxPo0V5rBsbgndUU=;
        b=VYngJfpY4MGnekD+X9psuT5F44P1XMMW8UDH9URyPb4vsBKWWYkizirW+mbuFwDg5I
         tYnP+JwnpUbXJO25nGPGq3hErzYmrttjN9fQbDJ1l9j2ZNLxf3L69oIAq+WS2VjhaQVl
         G9m4KGZoWIynR/gK5gAtI9xhXErJEIYjgxvuRnz42g2tyxReeG5hDFfOh+nMHgAM4qFd
         ifwLAduDxDAs1n4IDCG5vLuknzzPmU80aXLZxVE8dHqlmsaCb5PyHFLT5rzYL3WDU9vL
         95SCFdgn2gGuSacV2EuWw8w1bZMwL6gZ0JBq3J1ooKbnifpENmnbWj/eRyc1olV99dwq
         Im1g==
X-Gm-Message-State: ABy/qLY6ZTBKA5at3cOAJQ03NKiCXpkyRwgJS4IbgZMZZJeywMsf/Ikf
	mZs1RFHffX7KOquUfFhLnGJZEA==
X-Google-Smtp-Source: APBJJlHni9shKxmVufoc6l2kKRA3JpIEV95ZUCfDo4hjQjPgWfcXeyRxN2fuyxsBlXegzSVDNm5hyA==
X-Received: by 2002:adf:dccb:0:b0:314:385d:3f32 with SMTP id x11-20020adfdccb000000b00314385d3f32mr6756423wrm.29.1691054680740;
        Thu, 03 Aug 2023 02:24:40 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id t6-20020a5d6906000000b0031760af2331sm21172504wru.100.2023.08.03.02.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:24:40 -0700 (PDT)
Date: Thu, 3 Aug 2023 11:24:39 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	johannes@sipsolutions.net, ryazanov.s.a@gmail.com,
	loic.poulain@linaro.org, ilpo.jarvinen@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	edumazet@google.com, pabeni@redhat.com,
	chandrashekar.devegowda@intel.com, m.chetan.kumar@linux.intel.com,
	linuxwwan@intel.com, linuxwwan_5g@intel.com,
	soumya.prakash.mishra@intel.com, jesse.brandeburg@intel.com,
	danielwinkler@google.com, Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next 0/6] net: wwan: t7xx: fw flashing & coredump support
Message-ID: <ZMtyV8qxr4RePrgb@nanopsycho>
References: <MEYP282MB26974DA32942DE35F636FA41BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB26974DA32942DE35F636FA41BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Aug 03, 2023 at 04:18:06AM CEST, songjinjian@hotmail.com wrote:
>From: Jinjian Song <jinjian.song@fibocom.com>
>
>Adds support for t7xx wwan device firmware flashing & coredump collection
>using devlink.
>
>On early detection of wwan device in fastboot mode driver sets up CLDMA0 HW
>tx/rx queues for raw data transfer and then registers to devlink framework.
>On user space application issuing command for firmware update the driver
>sends fastboot flash command & firmware to program NAND.
>
>In flashing procedure the fastboot command & response are exchanged between
>driver and device. Once firmware flashing is success, user space application
>get modem event by sysfs interface.
>
>Below is the devlink command usage for firmware flashing
>
>$devlink dev flash pci/$BDF file ABC.img component ABC
>
>Note: ABC.img is the firmware to be programmed to "ABC" partition.
>
>In case of coredump collection when wwan device encounters an exception
>it reboots & stays in fastboot mode for coredump collection by host driver.
>On detecting exception state driver collects the core dump, creates the
>devlink region & reports an event to user space application for dump
>collection. The user space application invokes devlink region read command
>for dump collection.
>
>Below are the devlink commands used for coredump collection.
>
>devlink region new pci/$BDF/mr_dump
>devlink region read pci/$BDF/mr_dump snapshot $ID address $ADD length $LEN
>devlink region del pci/$BDF/mr_dump snapshot $ID

Interesting. Makes me wonder why you didn't mention the "fastboot" param
in the cover letter...


>
>Jinjian Song (6):
>  net: wwan: t7xx: Infrastructure for early port configuration
>  net: wwan: t7xx: Driver registers with Devlink framework
>  net: wwan: t7xx: Implements devlink ops of firmware flashing
>  net: wwan: t7xx: Creates region & snapshot for coredump log collection
>  net: wwan: t7xx: Adds sysfs attribute of modem event
>  net: wwan: t7xx: Devlink documentation
>
> Documentation/networking/devlink/index.rst |   1 +
> Documentation/networking/devlink/t7xx.rst  | 232 +++++++
> drivers/net/wwan/Kconfig                   |   1 +
> drivers/net/wwan/t7xx/Makefile             |   4 +-
> drivers/net/wwan/t7xx/t7xx_hif_cldma.c     |  47 +-
> drivers/net/wwan/t7xx/t7xx_hif_cldma.h     |  18 +-
> drivers/net/wwan/t7xx/t7xx_modem_ops.c     |   5 +-
> drivers/net/wwan/t7xx/t7xx_pci.c           |  79 ++-
> drivers/net/wwan/t7xx/t7xx_pci.h           |  19 +
> drivers/net/wwan/t7xx/t7xx_port.h          |   6 +
> drivers/net/wwan/t7xx/t7xx_port_ap_msg.c   |  78 +++
> drivers/net/wwan/t7xx/t7xx_port_ap_msg.h   |  11 +
> drivers/net/wwan/t7xx/t7xx_port_devlink.c  | 723 +++++++++++++++++++++
> drivers/net/wwan/t7xx/t7xx_port_devlink.h  |  85 +++
> drivers/net/wwan/t7xx/t7xx_port_proxy.c    | 118 +++-
> drivers/net/wwan/t7xx/t7xx_port_proxy.h    |  14 +
> drivers/net/wwan/t7xx/t7xx_port_wwan.c     |  27 +-
> drivers/net/wwan/t7xx/t7xx_reg.h           |  28 +-
> drivers/net/wwan/t7xx/t7xx_state_monitor.c | 137 +++-
> drivers/net/wwan/t7xx/t7xx_state_monitor.h |   1 +
> 20 files changed, 1556 insertions(+), 78 deletions(-)
> create mode 100644 Documentation/networking/devlink/t7xx.rst
> create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.c
> create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.h
> create mode 100644 drivers/net/wwan/t7xx/t7xx_port_devlink.c
> create mode 100644 drivers/net/wwan/t7xx/t7xx_port_devlink.h
>
>-- 
>2.34.1
>
>

