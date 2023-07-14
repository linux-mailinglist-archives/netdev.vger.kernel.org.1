Return-Path: <netdev+bounces-17845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE233753358
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851A2281FEC
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761E47479;
	Fri, 14 Jul 2023 07:42:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D87475
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:42:11 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893EC213C
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 00:42:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso9844285e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 00:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689320528; x=1691912528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sK84lncacaMhcQDL5MpNeLZp7wLw2TM8CahhFQIxHMI=;
        b=D6sq3fUQxqF8xeGkKEtstHfLaCzlmT942fMLl8ARYIMxltX14K9HfohIYTOTP9cjb8
         ZaEBpLCRYQ9kcMF9aVMvym2Ek9IOVU2ORg9Yw1l3W1gCk++uRiQ3SFkhSA5LZ1I6flp5
         v9Yz7uSJF5jSgp663mzKrDVNRXGVjRiAGDEk7HBuhxqPcT6eSqcMPxXFoU114HpwMee/
         9XtKsxndJXx8/1SxyGffoZZ9qEPGqRRNluSwxSMmsk19Z2iOZf02aEaC3S/QcOz+EgCv
         ESBD6+BYkWuqt6ecVh3OSQZ8XmATsPOfh95/jB3m+IoG6aNbLUo7hzyzk+ujiA1OMfj2
         8IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689320528; x=1691912528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sK84lncacaMhcQDL5MpNeLZp7wLw2TM8CahhFQIxHMI=;
        b=ACK4axWt/EmP2UKMGRro/G2/jh5RTjJdzn7M4ZDH2JR2SVImsxEuuzSHff+OQvxJ27
         gyR5Rb1s3BDksTGdJcBGh332zNI2OoYPnoOWFiUsXpDsg6Jr660zhHXqvcWHjoB/JLTd
         Ay27JGgwag6y1pf5DvYGgZRuqiHtfz1mpGUHqZyx/At/o/TBoIHK5/XPqQNRRxmntp7H
         H2cg2jzY2Lp1iX1DGLoisaER4QCNHgU7jp1VVWRFKtHEN8X8a36KhJf5yptNycGmTe8I
         d3JKUPlRbkBvjjenq7oMMl9dLX385TZy5ghFchaAEqRNwWnBfMjC73wBtiKkx3dbuD7y
         brWw==
X-Gm-Message-State: ABy/qLZyv8ZF4ga0bIgbu29XAj8jQQaJgpMrh2/p4/wEkZodgfPWoU++
	wUzb0DJu0dJ9zQ8M75cCPDCify6u43U=
X-Google-Smtp-Source: APBJJlFVxNDaPg7oUZR3R3FpXPNBsTyHhE0a6FrFucXT8U4X8TfbUf9aurfYwayGq8GOC1yrTW3R0w==
X-Received: by 2002:a05:600c:b54:b0:3f7:e7a2:25f6 with SMTP id k20-20020a05600c0b5400b003f7e7a225f6mr1590080wmr.17.1689320527603;
        Fri, 14 Jul 2023 00:42:07 -0700 (PDT)
Received: from ?IPV6:2a01:c22:72e8:a200:dbe:b466:eccf:67d7? (dynamic-2a01-0c22-72e8-a200-0dbe-b466-eccf-67d7.c22.pool.telefonica.de. [2a01:c22:72e8:a200:dbe:b466:eccf:67d7])
        by smtp.googlemail.com with ESMTPSA id c8-20020a7bc848000000b003fc06169ab3sm773566wml.20.2023.07.14.00.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 00:42:07 -0700 (PDT)
Message-ID: <ce802481-87c3-1bb8-2ee4-fc3cd73d889a@gmail.com>
Date: Fri, 14 Jul 2023 09:42:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: r8169: transmit transmit queue timed out - v6.4 cycle
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Tobias Klausmann <tobias.klausmann@freenet.de>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 netdev@vger.kernel.org
References: <c3465166-f04d-fcf5-d284-57357abb3f99@freenet.de>
 <CAFSsGVtiXSK_0M_TQm_38LabiRX7E5vR26x=cKags4ZQBqfXPQ@mail.gmail.com>
 <e47bac0d-e802-65e1-b311-6acb26d5cf10@freenet.de>
 <f7ca15e8-2cf2-1372-e29a-d7f2a2cc09f1@leemhuis.info>
 <CAFSsGVuDLnW_7iwSUNebx8Lku3CGZhcym3uXfMFnotA=OYJJjQ@mail.gmail.com>
 <A69A7D66-A73A-4C4D-913B-8C2D4CF03CE2@freenet.de>
 <842ae1f6-e3fe-f4d1-8d4f-f19627a52665@gmail.com> <87a5w0cn18.fsf@kurt>
 <04dc4bbb-6bfd-4074-6d32-007dc8d213e5@gmail.com> <87wmz3ezf3.fsf@kurt>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <87wmz3ezf3.fsf@kurt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14.07.2023 09:16, Kurt Kanzenbach wrote:
> On Thu Jul 13 2023, Heiner Kallweit wrote:
>> On 13.07.2023 09:01, Kurt Kanzenbach wrote:
>>> Hello Heiner,
>>>
>>> On Mon Jul 10 2023, Heiner Kallweit wrote:
>>>> On 05.07.2023 00:25, Tobias Klausmann wrote:
>>>>> Hi, top posting as well, as im on vacation, too. The system does not
>>>>> allow disabling ASPM, it is a very constrained notebook BIOS, thus
>>>>> the suggestion is nit feasible. All in all the sugesstion seems not
>>>>> favorable for me, as it is unknown how many systems are broken the
>>>>> same way. Having a workaround adviced as default seems oretty wrong
>>>>> to me.
>>>>>
>>>>
>>>> To get a better understanding of the affected system:
>>>> Could you please provide a full dmesg log and the lspci -vv output?
>>>
>>> I'm having the same problem as described by Tobias on a desktop
>>> machine. v6.3 works; v6.4 results in transmit queue timeouts
>>> occasionally. Reverting 2ab19de62d67 ("r8169: remove ASPM restrictions
>>> now that ASPM is disabled during NAPI poll") "solves" the issue.
>>>
>>> From dmesg:
>>>
>>> |~ % dmesg | grep -i ASPM
>>> |[    0.152746] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
>>> |[    0.905100] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
>>> |[    0.906508] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
>>> |[    1.156585] pci 10000:e1:00.0: can't override BIOS ASPM; OS doesn't have ASPM control
>>> |[    1.300059] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
>>>
>>> In addition, with commit 2ab19de62d67 in kernel regular messages like
>>> this show up:
>>>
>>> |[ 7487.214593] pcieport 0000:00:1c.2: AER: Corrected error received: 0000:03:00.0
>>>
>>> I'm happy to test any patches or provide more info if needed.
>>>
>> Thanks for the report. It's interesting that the issue seems to occur only on systems
>> where BIOS doesn't allow OS to control ASPM. Maybe this results in the PCI subsystem
>> not properly initializing something.
>> Kurt/Klaus: Could you please boot with cmd line parameter pcie_aspm=force and see
>> whether this changes something?
>> This parameter lets Linux ignore the BIOS setting. You should see a message
>> "PCIe ASPM is forcibly enabled" in the dmesg log with this parameter.
> 
> Seems like this does not help. There are still PCIe errors:
> 
> |~ # dmesg | grep -i ASPM
> |[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.4.2-gentoo-kurtOS root=/dev/nvme0n1p3 ro kvm-intel.nested=1 vga=794 pcie_aspm=force
> |[    0.044016] Kernel command line: BOOT_IMAGE=/vmlinuz-6.4.2-gentoo-kurtOS root=/dev/nvme0n1p3 ro kvm-intel.nested=1 vga=794 pcie_aspm=force
> |[    0.044048] PCIe ASPM is forcibly enabled
> |[    0.153011] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> |[    0.916341] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> |[    0.917719] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> |~ # dmesg | grep -i r8169
> |[    1.337417] r8169 0000:03:00.0 eth0: RTL8168h/8111h, 6c:3c:8c:2c:bd:de, XID 541, IRQ 164
> |[    1.337422] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> |[    2.833876] r8169 0000:03:00.0 enp3s0: renamed from eth0
> |[   20.886564] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY driver (mii_bus:phy_addr=r8169-0-300:00, irq=MAC)
> |[   21.168373] r8169 0000:03:00.0 enp3s0: Link is Down
> |[   24.006543] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow control off
> |~ # dmesg | tail
> |[   20.886564] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY driver (mii_bus:phy_addr=r8169-0-300:00, irq=MAC)
> |[   21.168373] r8169 0000:03:00.0 enp3s0: Link is Down
> |[   24.006543] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow control off
> |[   24.006568] IPv6: ADDRCONF(NETDEV_CHANGE): enp3s0: link becomes ready
> |[   24.567803] ACPI Warning: \_SB.PC00.PEG1.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20230331/nsarguments-61)
> |[   41.563396] pcieport 0000:00:1c.2: AER: Corrected error received: 0000:03:00.0
> |[   47.065441] pcieport 0000:00:1c.2: AER: Multiple Corrected error received: 0000:03:00.0
> |[   54.264285] pcieport 0000:00:1c.2: AER: Corrected error received: 0000:03:00.0
> |[   54.424210] pcieport 0000:00:1c.2: AER: Corrected error received: 0000:03:00.0
> |[   55.443439] pcieport 0000:00:1c.2: AER: Corrected error received: 0000:03:00.0
> 

But no tx timeout (yet)?
Now that ASPM is forced, could you please disable ASPM L1.2?
-> /sys/class/net/enp3s0/device/link/l1_2_aspm
That's what we did until 6.3 for RTL8168h on systems where
OS can control ASPM.

> Thanks,
> Kurt


