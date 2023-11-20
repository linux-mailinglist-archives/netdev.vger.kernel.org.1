Return-Path: <netdev+bounces-49181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A7C7F10E4
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E931F23786
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63426FD1;
	Mon, 20 Nov 2023 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JF4Fp2nn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A7AF2
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700477660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zUAf0kRwyhFacdVDNduqaFmW+J2nhNnMJ6K916lSRE=;
	b=JF4Fp2nnhphCjILUdJ6p0Q5YtN11BxnU1nzbUUcvyCLhCgyk1IQqPz9YDQ2fpgVcS57Q1Q
	xkhmG7U+YiPmcLhUxSjfT3+XCQahkaY8mVPYyeR2g9tjJUMbuifUg4V4d60LKGTgv6jy29
	OnfVC9PyYiUTBON91VQL4c2ORJ0rpD8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-qMBRv8-1OwaRqBEOQHO7ag-1; Mon, 20 Nov 2023 05:54:19 -0500
X-MC-Unique: qMBRv8-1OwaRqBEOQHO7ag-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9dd89e2ce17so317019566b.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:54:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700477658; x=1701082458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zUAf0kRwyhFacdVDNduqaFmW+J2nhNnMJ6K916lSRE=;
        b=w0kxf/ft4Av2z25qknMB3kK96WrA/xgqxTq++gbAQOJgn+j5+XZTskX4MHPeEnjTDb
         98kdnG5ce3f68fuTrnOXRKhX1E+gLr/+v7Gtple3Iv8Ww+fAd0vo573uiZbl5IXyRzIY
         zBK3tlqVLfpI/Mx/n6AYQ3svKJSnuSdiE1VmjalCbwNlScEV/ndHo0K3bRPJ4BJml4Rs
         sKlSvKF3p2160XX8ooAevC10rribaBlfVAgG/UBh+r6aRZX4iqa/DcslEXfDNWDjbBeE
         VDlQYc9UuxtM1KFbaHhkGvC4Z/amULrfLRnvpYABIjHYutZwxJWB5tZ/G4QqnmN86LMm
         99OQ==
X-Gm-Message-State: AOJu0YzdjUlyBTCCtYC0HXCy2uAxhFU4jNZXfU1o9IkV2R4VVUseUyJw
	sO/0L0FYDD338WoWdI2v6RHfEMVff8tP2Qo7gk3q/b/4C3k3rxyADo4jL358J6km6WGuNzH4dZ9
	BnWCFOtmfcSZVTvbU
X-Received: by 2002:a17:906:32c7:b0:9e7:3af8:1fd0 with SMTP id k7-20020a17090632c700b009e73af81fd0mr5202190ejk.76.1700477658014;
        Mon, 20 Nov 2023 02:54:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgoytvF8lwwp8rKx8884Oj65m/vmtmib1MiNPAMSTReWskVDTF1HFC8OJm9t7uAUXBc0cvnQ==
X-Received: by 2002:a17:906:32c7:b0:9e7:3af8:1fd0 with SMTP id k7-20020a17090632c700b009e73af81fd0mr5202175ejk.76.1700477657734;
        Mon, 20 Nov 2023 02:54:17 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id jx27-20020a170906ca5b00b009fda627abd9sm1262032ejb.79.2023.11.20.02.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:54:16 -0800 (PST)
Message-ID: <76d4f18e-a349-4337-a301-ffebb8f1c5e8@redhat.com>
Date: Mon, 20 Nov 2023 11:54:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/9] Enable Wifi RFI interference mitigation feature
 support
Content-Language: en-US, nl
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, lenb@kernel.org, johannes@sipsolutions.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alexander.deucher@amd.com, Lijo.Lazar@amd.com,
 mario.limonciello@amd.com
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
 <5f85eb72-3f34-4006-85ca-2a2181113008@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <5f85eb72-3f34-4006-85ca-2a2181113008@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/19/23 08:17, Ma, Jun wrote:
> ping...
> Any other comments?

Patches 1/9 and 2/9 look reasonable, once the questions about
use of the _DSM vs directly calling the WBRF ACPI method are
resolved I can merge patches 1/9 and 2/9 and create an immutable
feature branch based on 6.7-rc1 + these 2 patches.

I'll then also send a pull-request to the wifi /resp amdgpu
maintainers from this branch.

I see no acks / reviews from the wifi folks yet,
so once that immutable feature branch is ready the first
thing to do is try to get the wifi folks to review + merge WBRF
support.

Note I plan to not actually merge the feature branch
into for-next until the wifi folks are happy with the code.

This way if changes are necessary I can do a v2 feature branch
and the wifi folks can merge that instead.

Regards,

Hans




> On 10/17/2023 10:53 AM, Ma Jun wrote:
>> Due to electrical and mechanical constraints in certain platform designs there
>> may be likely interference of relatively high-powered harmonics of the (G-)DDR
>> memory clocks with local radio module frequency bands used by Wifi 6/6e/7. To
>> mitigate possible RFI interference we introuduced WBRF(Wifi Band RFI mitigation Feature).
>> Producers can advertise the frequencies in use and consumers can use this information
>> to avoid using these frequencies for sensitive features.
>>
>> The whole patch set is based on Linux 6.5.0. With some brief introductions
>> as below:
>> Patch1:      Document about WBRF
>> Patch2:      Core functionality setup for WBRF feature support
>> Patch3 - 4:  Bring WBRF support to wifi subsystem.
>> Patch5 - 9:  Bring WBRF support to AMD graphics driver.
>>
>> Evan Quan (7):
>>   cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
>>   wifi: mac80211: Add support for WBRF features
>>   drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
>>   drm/amd/pm: setup the framework to support Wifi RFI mitigation feature
>>   drm/amd/pm: add flood detection for wbrf events
>>   drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.0
>>   drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7
>>
>> Ma Jun (2):
>>   Documentation/driver-api: Add document about WBRF mechanism
>>   platform/x86/amd: Add support for AMD ACPI based Wifi band RFI
>>     mitigation feature
>>
>>  Documentation/driver-api/wbrf.rst             |  71 +++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 +
>>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 214 +++++++++
>>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  33 ++
>>  .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     |  14 +-
>>  .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     |  14 +-
>>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |   3 +-
>>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h  |   3 +-
>>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
>>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   3 +
>>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   9 +
>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  60 +++
>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  59 +++
>>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
>>  drivers/platform/x86/amd/Kconfig              |  15 +
>>  drivers/platform/x86/amd/Makefile             |   1 +
>>  drivers/platform/x86/amd/wbrf.c               | 422 ++++++++++++++++++
>>  include/linux/acpi_amd_wbrf.h                 | 101 +++++
>>  include/linux/ieee80211.h                     |   1 +
>>  include/net/cfg80211.h                        |   8 +
>>  net/mac80211/Makefile                         |   2 +
>>  net/mac80211/chan.c                           |   9 +
>>  net/mac80211/ieee80211_i.h                    |   9 +
>>  net/mac80211/main.c                           |   2 +
>>  net/mac80211/wbrf.c                           | 105 +++++
>>  net/wireless/chan.c                           |   3 +-
>>  27 files changed, 1180 insertions(+), 6 deletions(-)
>>  create mode 100644 Documentation/driver-api/wbrf.rst
>>  create mode 100644 drivers/platform/x86/amd/wbrf.c
>>  create mode 100644 include/linux/acpi_amd_wbrf.h
>>  create mode 100644 net/mac80211/wbrf.c
>>
> 


