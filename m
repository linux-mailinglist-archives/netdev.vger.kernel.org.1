Return-Path: <netdev+bounces-47062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF57E7B2C
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975A4B20A4F
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A84134D3;
	Fri, 10 Nov 2023 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oEDQb4bo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12DD134CA
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 10:09:51 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8769027054
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:09:49 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so3033131a12.1
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699610988; x=1700215788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0rQC8423D0Etf4086n6r4A4cDWDglKrezyJj3TtoeQ=;
        b=oEDQb4bo0syhEyCFzMC6Aa87v5wNJffzioDIit5bK/4vDsaTxF+xlpe1satt/0kHm6
         BTtZKYEmMPAdKsFVc5pl0rbZ/icyyP1wmufNkmmYAd6rdRkBU4ooCmEy+pvOqfR4LD3u
         CN+TZye6Ca5hjIaJORKxb99ktLbdI/+8eYjRBsfd6DQOj+4wqebYkJJJqXfOZbXhnFfN
         IzabZtIJYWOyOUwhuU92b82UvA9zmpBxkNEC5vUfRvJYom6XsV2a5iTcm73fjdXzN4HQ
         ttYjD9P2/PpJ4q4rsoIePeVgZQjslRdrZNrODIvWqW76FVTlk13D01K5TM4WrbX1BXo3
         Zg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699610988; x=1700215788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0rQC8423D0Etf4086n6r4A4cDWDglKrezyJj3TtoeQ=;
        b=g/QJKlzqGI/c7Uq0G9T76bA4YoCT1VQJk/jKr1zKx/5Na4M4zEUYWQ9Tr3KAk+5gP2
         080zJyl9NOs4Nf3sO1A/Iz5bL/6tcwBZb+LG4IAQTDBX7IRX9LTOq6YsPPoPSbDu4Ksq
         1Z914ul8iDZ6SDSDchAfnrwsI+D7XkMGTIF+PVNsftfW+bPjd3XQ1IDTlU1zirRKLBQz
         AcaVuc6PIqKXKGFEIhTHTYglW05cL/jnBvuw4EC+lRBSpd2OZpPvWA3nwWQ3GhZpTyKu
         0k013+bTZ0oipDJmNEoT2ku/nlpEuGsZA2fq1OrQBRBYhd7dcVphW3xi+owxE9oHzYqi
         FtrA==
X-Gm-Message-State: AOJu0YybVF3gAjCd+vXW1+5rHs+UV39PBLhSt8ZSgRe7XdEpaM9mH+bz
	FYgilpaHN/Hvk+Lf06HFjLiZjoIsvvo4ukZoc4M+IQ==
X-Google-Smtp-Source: AGHT+IH9Fv73t0GO7hYDi6Ljdqm0Sf6FjN08DJBwMxUwsEZOxI8zzu61nlYBqgWBIo5Fhl9O5NKcLA==
X-Received: by 2002:a17:906:4784:b0:9de:cfa1:f072 with SMTP id cw4-20020a170906478400b009decfa1f072mr6674340ejc.25.1699610967101;
        Fri, 10 Nov 2023 02:09:27 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i17-20020a1709061cd100b00992e14af9c3sm3761148ejh.143.2023.11.10.02.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:09:26 -0800 (PST)
Date: Fri, 10 Nov 2023 11:09:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net 0/3] dpll: fix unordered unbind/bind registerer issues
Message-ID: <ZU4BVdPvAwKer+3v@nanopsycho>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <4c251905-308b-4709-8e08-39cda85678f9@linux.dev>
 <DM6PR11MB465721130A49C22D77E42A799BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU0fzzmmxjnsNW0n@nanopsycho>
 <DM6PR11MB4657209FFC300E207E600F3F9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU3SSClU6Ijn3M7B@nanopsycho>
 <DM6PR11MB4657DE812ADB8C5079705DC99BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657DE812ADB8C5079705DC99BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>

Fri, Nov 10, 2023 at 10:06:59AM CET, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Friday, November 10, 2023 7:49 AM
>>
>>Fri, Nov 10, 2023 at 12:35:43AM CET, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Thursday, November 9, 2023 7:07 PM
>>>>
>>>>Thu, Nov 09, 2023 at 06:20:14PM CET, arkadiusz.kubalewski@intel.com
>>>>wrote:
>>>>>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>>>>Sent: Thursday, November 9, 2023 11:51 AM
>>>>>>
>>>>>>On 08/11/2023 10:32, Arkadiusz Kubalewski wrote:
>>>>>>> Fix issues when performing unordered unbind/bind of a kernel modules
>>>>>>> which are using a dpll device with DPLL_PIN_TYPE_MUX pins.
>>>>>>> Currently only serialized bind/unbind of such use case works, fix
>>>>>>> the issues and allow for unserialized kernel module bind order.
>>>>>>>
>>>>>>> The issues are observed on the ice driver, i.e.,
>>>>>>>
>>>>>>> $ echo 0000:af:00.0 > /sys/bus/pci/drivers/ice/unbind
>>>>>>> $ echo 0000:af:00.1 > /sys/bus/pci/drivers/ice/unbind
>>>>>>>
>>>>>>> results in:
>>>>>>>
>>>>>>> ice 0000:af:00.0: Removed PTP clock
>>>>>>> BUG: kernel NULL pointer dereference, address: 0000000000000010
>>>>>>> PF: supervisor read access in kernel mode
>>>>>>> PF: error_code(0x0000) - not-present page
>>>>>>> PGD 0 P4D 0
>>>>>>> Oops: 0000 [#1] PREEMPT SMP PTI
>>>>>>> CPU: 7 PID: 71848 Comm: bash Kdump: loaded Not tainted 6.6.0-
>>>>>>>rc5_next-
>>>>>>>queue_19th-Oct-2023-01625-g039e5d15e451 #1
>>>>>>> Hardware name: Intel Corporation S2600STB/S2600STB, BIOS
>>>>>>>SE5C620.86B.02.01.0008.031920191559 03/19/2019
>>>>>>> RIP: 0010:ice_dpll_rclk_state_on_pin_get+0x2f/0x90 [ice]
>>>>>>> Code: 41 57 4d 89 cf 41 56 41 55 4d 89 c5 41 54 55 48 89 f5 53 4c 8b
>>>>>>>66
>>>>>>>08 48 89 cb 4d 8d b4 24 f0 49 00 00 4c 89 f7 e8 71 ec 1f c5 <0f> b6 5b
>>>>>>>10
>>>>>>>41 0f b6 84 24 30 4b 00 00 29 c3 41 0f b6 84 24 28 4b
>>>>>>> RSP: 0018:ffffc902b179fb60 EFLAGS: 00010246
>>>>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>>>>>> RDX: ffff8882c1398000 RSI: ffff888c7435cc60 RDI: ffff888c7435cb90
>>>>>>> RBP: ffff888c7435cc60 R08: ffffc902b179fbb0 R09: 0000000000000000
>>>>>>> R10: ffff888ef1fc8050 R11: fffffffffff82700 R12: ffff888c743581a0
>>>>>>> R13: ffffc902b179fbb0 R14: ffff888c7435cb90 R15: 0000000000000000
>>>>>>> FS:  00007fdc7dae0740(0000) GS:ffff888c105c0000(0000)
>>>>>>>knlGS:0000000000000000
>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> CR2: 0000000000000010 CR3: 0000000132c24002 CR4: 00000000007706e0
>>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>> PKRU: 55555554
>>>>>>> Call Trace:
>>>>>>>   <TASK>
>>>>>>>   ? __die+0x20/0x70
>>>>>>>   ? page_fault_oops+0x76/0x170
>>>>>>>   ? exc_page_fault+0x65/0x150
>>>>>>>   ? asm_exc_page_fault+0x22/0x30
>>>>>>>   ? ice_dpll_rclk_state_on_pin_get+0x2f/0x90 [ice]
>>>>>>>   ? __pfx_ice_dpll_rclk_state_on_pin_get+0x10/0x10 [ice]
>>>>>>>   dpll_msg_add_pin_parents+0x142/0x1d0
>>>>>>>   dpll_pin_event_send+0x7d/0x150
>>>>>>>   dpll_pin_on_pin_unregister+0x3f/0x100
>>>>>>>   ice_dpll_deinit_pins+0xa1/0x230 [ice]
>>>>>>>   ice_dpll_deinit+0x29/0xe0 [ice]
>>>>>>>   ice_remove+0xcd/0x200 [ice]
>>>>>>>   pci_device_remove+0x33/0xa0
>>>>>>>   device_release_driver_internal+0x193/0x200
>>>>>>>   unbind_store+0x9d/0xb0
>>>>>>>   kernfs_fop_write_iter+0x128/0x1c0
>>>>>>>   vfs_write+0x2bb/0x3e0
>>>>>>>   ksys_write+0x5f/0xe0
>>>>>>>   do_syscall_64+0x59/0x90
>>>>>>>   ? filp_close+0x1b/0x30
>>>>>>>   ? do_dup2+0x7d/0xd0
>>>>>>>   ? syscall_exit_work+0x103/0x130
>>>>>>>   ? syscall_exit_to_user_mode+0x22/0x40
>>>>>>>   ? do_syscall_64+0x69/0x90
>>>>>>>   ? syscall_exit_work+0x103/0x130
>>>>>>>   ? syscall_exit_to_user_mode+0x22/0x40
>>>>>>>   ? do_syscall_64+0x69/0x90
>>>>>>>   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>>>>>> RIP: 0033:0x7fdc7d93eb97
>>>>>>> Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f
>>>>>>>1e
>>>>>>>fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00
>>>>>>>f0
>>>>>>>ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
>>>>>>> RSP: 002b:00007fff2aa91028 EFLAGS: 00000246 ORIG_RAX:
>>>>>>>0000000000000001
>>>>>>> RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fdc7d93eb97
>>>>>>> RDX: 000000000000000d RSI: 00005644814ec9b0 RDI: 0000000000000001
>>>>>>> RBP: 00005644814ec9b0 R08: 0000000000000000 R09: 00007fdc7d9b14e0
>>>>>>> R10: 00007fdc7d9b13e0 R11: 0000000000000246 R12: 000000000000000d
>>>>>>> R13: 00007fdc7d9fb780 R14: 000000000000000d R15: 00007fdc7d9f69e0
>>>>>>>   </TASK>
>>>>>>> Modules linked in: uinput vfio_pci vfio_pci_core vfio_iommu_type1
>>>>>>>vfio
>>>>>>>irqbypass ixgbevf snd_seq_dummy snd_hrtimer snd_seq snd_timer
>>>>>>>snd_seq_device snd soundcore overlay qrtr rfkill vfat fat xfs
>>>>>>>libcrc32c
>>>>>>>rpcrdma sunrpc rdma_ucm ib_srpt ib_isert iscsi_target_mod
>>>>>>>target_core_mod
>>>>>>>ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm
>>>>>>>intel_rapl_msr
>>>>>>>intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common
>>>>>>>isst_if_common skx_edac nfit libnvdimm ipmi_ssif x86_pkg_temp_thermal
>>>>>>>intel_powerclamp coretemp irdma rapl intel_cstate ib_uverbs iTCO_wdt
>>>>>>>iTCO_vendor_support acpi_ipmi intel_uncore mei_me ipmi_si pcspkr
>>>>>>>i2c_i801
>>>>>>>ib_core mei ipmi_devintf intel_pch_thermal ioatdma i2c_smbus
>>>>>>>ipmi_msghandler lpc_ich joydev acpi_power_meter acpi_pad ext4 mbcache
>>>>>>>jbd2
>>>>>>>sd_mod t10_pi sg ast i2c_algo_bit drm_shmem_helper drm_kms_helper ice
>>>>>>>crct10dif_pclmul ixgbe crc32_pclmul drm crc32c_intel ahci i40e libahci
>>>>>>>ghash_clmulni_intel libata mdio dca gnss wmi fuse [last unloaded:
>>>>>>>iavf]
>>>>>>> CR2: 0000000000000010
>>>>>>>
>>>>>>> Arkadiusz Kubalewski (3):
>>>>>>>    dpll: fix pin dump crash after module unbind
>>>>>>>    dpll: fix pin dump crash for rebound module
>>>>>>>    dpll: fix register pin with unregistered parent pin
>>>>>>>
>>>>>>>   drivers/dpll/dpll_core.c    |  8 ++------
>>>>>>>   drivers/dpll/dpll_core.h    |  4 ++--
>>>>>>>   drivers/dpll/dpll_netlink.c | 37 ++++++++++++++++++++++------------
>>>>>>>--
>>>>>>>-
>>>>>>>   3 files changed, 26 insertions(+), 23 deletions(-)
>>>>>>>
>>>>>>
>>>>>>
>>>>>>I still don't get how can we end up with unregistered pin. And
>>>>>>shouldn't
>>>>>>drivers do unregister of dpll/pin during release procedure? I thought
>>>>>>it
>>>>>>was kind of agreement we reached while developing the subsystem.
>>>>>>
>>>>>
>>>>>It's definitely not about ending up with unregistered pins.
>>>>>
>>>>>Usually the driver is loaded for PF0, PF1, PF2, PF3 and unloaded in
>>>>>opposite
>>>>>order: PF3, PF2, PF1, PF0. And this is working without any issues.
>>>>
>>>>Please fix this in the driver.
>>>>
>>>
>>>Thanks for your feedback, but this is already wrong advice.
>>>
>>>Our HW/FW is designed in different way than yours, it doesn't mean it is
>>>wrong.
>>>As you might recall from our sync meetings, the dpll subsystem is to unify
>>>approaches and reduce the code in the drivers, where your advice is
>>>exactly
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
>>
>>I replied in the other patch thread.
>>
>
>Yes, so did I.
>But what is the reason you have moved the discussion from the other thread
>into this one?

I didn't, not sure why you say so. I just wanted to make sure you
follow.

>
>Thank you!
>Arkadiusz
>
>>
>>>
>>>Thank you!
>>>Arkadiusz
>>>
>>>>
>>>>>
>>>>>Above crash is caused because of unordered driver unload, where dpll
>>>>>subsystem
>>>>>tries to notify muxed pin was deleted, but at that time the parent is
>>>>>already
>>>>>gone, thus data points to memory which is no longer available, thus
>>>>>crash
>>>>>happens when trying to dump pin parents.
>>>>>
>>>>>This series fixes all issues I could find connected to the situation
>>>>>where
>>>>>muxed-pins are trying to access their parents, when parent registerer
>>>>>was
>>>>>removed
>>>>>in the meantime.
>>>>>
>>>>>Thank you!
>>>>>Arkadiusz

