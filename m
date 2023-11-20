Return-Path: <netdev+bounces-49173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 647E77F107F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04039B21062
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4A2101EC;
	Mon, 20 Nov 2023 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3VQra6l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782D2C5
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700476513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDa5Zifa699JA7DgA6NqBUl602nqWvF/0Qs0z1ItO6s=;
	b=K3VQra6lqO0waVNVRr+v+4df5PsVdjivsP8PVEWrvLoglfZIhtlf+m2JPAgTYi2kpi8EyJ
	7x0ZmV5jI1S3lylfv2a3/1qNISDgznx7vw7YKNJEbxCLpR3AOGKBD/eEJbjfvLdFjrkNjV
	IcVaHLOgLOJDiNEiSclY3Mx5axCgrxQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-rK7Y0Ks8MOKBVQOlX9xR9w-1; Mon, 20 Nov 2023 05:35:09 -0500
X-MC-Unique: rK7Y0Ks8MOKBVQOlX9xR9w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9d30a6a67abso304559466b.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700476508; x=1701081308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDa5Zifa699JA7DgA6NqBUl602nqWvF/0Qs0z1ItO6s=;
        b=OBK1MXbHu3x+kidjm797PaguQFkM5grYihk7cEAPJVannYkPh7sUZLw2ZSdBTeJ6uB
         fB0qqdFAb6xAcJBxfPFZJpJ6PKA5LNNp1TGTxR2JCEYr3IBnOpezGhLmIccoYRjaJxtD
         pMeKwNSjYsBAJ3/mMe0wCFhbfwxoNzo8lIAorC/GtO1d4Joq9oRuTK4ydOBvQOWsOZFt
         uyEn6dwAV5bVzMLReYkwLQn6gLvXWKfAqTbPH1/ro7akAmktILYgNXVenNnNXF4bzHtu
         vuscr6WJjcUltHLdNASTMJvd0sCQGdu0DO1R49gsO8SnD0gWjvajSh0ZONT/83pflhYL
         ZO7w==
X-Gm-Message-State: AOJu0Yxq5nASaedqJHzuzAeSqNKA3vhnvsNM/iXI6rhkZL2WfNNS4qky
	YqBbpG0vEMn0RqcZOEMasykb84eyvKvyNs7vxpKGbvPldAy79BcKdC8sDClkqfFFTcnF8oJJ9jq
	YkFZryYIoJPf7m5Nr
X-Received: by 2002:a17:907:c24b:b0:9ae:6ad0:f6db with SMTP id tj11-20020a170907c24b00b009ae6ad0f6dbmr6930267ejc.71.1700476508608;
        Mon, 20 Nov 2023 02:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtYB3LpQ2jUhXembvmGnwIAULaeNK5MwYtq0w1lhRVzSiXtm7qVIWAoEoosVuqDagxql3aow==
X-Received: by 2002:a17:907:c24b:b0:9ae:6ad0:f6db with SMTP id tj11-20020a170907c24b00b009ae6ad0f6dbmr6930238ejc.71.1700476507968;
        Mon, 20 Nov 2023 02:35:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p27-20020a1709060ddb00b009fc50ebb062sm1745968eji.4.2023.11.20.02.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:35:07 -0800 (PST)
Message-ID: <db2051d0-c847-4d3b-98da-4f4f68a5b30b@redhat.com>
Date: Mon, 20 Nov 2023 11:35:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/9] Documentation/driver-api: Add document about WBRF
 mechanism
Content-Language: en-US, nl
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org, lenb@kernel.org,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alexander.deucher@amd.com,
 Lijo.Lazar@amd.com, mario.limonciello@amd.com
Cc: majun@amd.com, netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
 <20231017025358.1773598-2-Jun.Ma2@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231017025358.1773598-2-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/17/23 04:53, Ma Jun wrote:
> Add documentation about AMD's Wifi band RFI mitigation (WBRF) mechanism
> explaining the theory and how it is used.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  Documentation/driver-api/wbrf.rst | 73 +++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/driver-api/wbrf.rst
> 
> diff --git a/Documentation/driver-api/wbrf.rst b/Documentation/driver-api/wbrf.rst
> new file mode 100644
> index 000000000000..8561840263b3
> --- /dev/null
> +++ b/Documentation/driver-api/wbrf.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=================================
> +WBRF - Wifi Band RFI Mitigations
> +=================================
> +Due to electrical and mechanical constraints in certain platform designs
> +there may be likely interference of relatively high-powered harmonics of
> +the GPU memory clocks with local radio module frequency bands used by
> +certain Wifi bands.
> +
> +To mitigate possible RFI interference producers can advertise the
> +frequencies in use and consumers can use this information to avoid using
> +these frequencies for sensitive features.
> +
> +When a platform is known to have this issue with any contained devices,
> +the platform designer will advertise the availability of this feature via
> +ACPI devices with a device specific method (_DSM).
> +* Producers with this _DSM will be able to advertise the frequencies in use.
> +* Consumers with this _DSM will be able to register for notifications of
> +frequencies in use.
> +
> +Some general terms
> +==================
> +Producer: such component who can produce high-powered radio frequency
> +Consumer: such component who can adjust its in-use frequency in
> +           response to the radio frequencies of other components to
> +           mitigate the possible RFI.
> +
> +To make the mechanism function, those producers should notify active use
> +of their particular frequencies so that other consumers can make relative
> +internal adjustments as necessary to avoid this resonance.
> +
> +ACPI interface
> +==============
> +Although initially used by for wifi + dGPU use cases, the ACPI interface
> +can be scaled to any type of device that a platform designer discovers
> +can cause interference.
> +
> +The GUID used for the _DSM is 7B7656CF-DC3D-4C1C-83E9-66E721DE3070.
> +
> +3 functions are available in this _DSM:
> +
> +* 0: discover # of functions available
> +* 1: record RF bands in use
> +* 2: retrieve RF bands in use
> +
> +Driver programming interface
> +============================
> +.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
> +
> +Sample Usage
> +=============
> +The expected flow for the producers:
> +1) During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
> +can be enabled for the device.
> +2) On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
> +param to get other consumers properly notified.
> +3) Or on stopping using some frequency band, call
> +`acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
> +
> +The expected flow for the consumers:
> +1) During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
> +can be enabled for the device.
> +2) Call `amd_wbrf_register_notifier` to register for notification
> +of frequency band change(add or remove) from other producers.

> +3) Call the `amd_wbrf_retrieve_freq_band` intentionally to retrieve
> +current active frequency bands considering some producers may broadcast
> +such information before the consumer is up.

"intentionally" in this sentence should be "initially" (I presume).

With that fixed and Ilpo's review comments addressed you may add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

to this patch.

Regards,

Hans




> +4) On receiving a notification for frequency band change, run
> +`amd_wbrf_retrieve_freq_band` again to retrieve the latest
> +active frequency bands.
> +5) During driver cleanup, call `amd_wbrf_unregister_notifier` to
> +unregister the notifier.


