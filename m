Return-Path: <netdev+bounces-30235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1934C7868EE
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 09:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F241C20DBB
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 07:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5821FB8;
	Thu, 24 Aug 2023 07:52:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6FC1FB4
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:52:40 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6744A1703
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:52:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bed101b70so835683666b.3
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692863557; x=1693468357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcaLughu7vzp1St72QilzBBqtkNR6lQj1NS0/O5hJQk=;
        b=h6faqXkr2NXAnFtdcggLa5fzELmV3kqgiRqa1HIWVcsbOgj0UGry6J3PNYVRNmKKPM
         Hl226wAckDiws7vR8GhNDW4XLDStzy5g5KXV5h+NLaF66xQDDuip2S9ykBT4k3WbtPUg
         a2ot9Mw7TnG+8gcZU8wvSFuumNPSc87iUDiQZgy+T0Cu+QRmqKnwz34ryVsAFxcH3FWz
         hBCuw0V8umOC2W1qdHf1/U/mekqQFaOixdW4q5xKP+8IkQNa0lzJy+sYET12iT6kuxzJ
         6/j/I/hU6yMbmfMl74SWkEt6ONa1z5ElPYSMh1KykOhK52fFmwVfRdqXMEuhs1zIXctu
         mudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692863557; x=1693468357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcaLughu7vzp1St72QilzBBqtkNR6lQj1NS0/O5hJQk=;
        b=G41/m/OqhsTu715nM35aAkeU5s8RbiP62qGa5VeTQ+FgEMRcmQ5biJ61VWcphcFFfi
         V7rOLR61ezXJ8Y3B5sixvJOzIEoNoAFlPf6fjdUG9qCMqJ6Pz9uO4bgmWTWoYSKraUi/
         YRAJ4IPzitqVoKYBV4lIIcrjKtARnVrSaI6960V6egiNPSWV6jxjwUGJRYL4nibWJc2m
         YzDtlyLJKOWaza+ccYDjuZ9upXGmxvK71NW2XhYin+eJRu4Jd3lVGouIxlcvQuu2Gl8m
         qCDjd7tP+NXUNXOoTON/g1kB6TFcsGe0aIM2tz8A/2XoyH84ujoQeMcvKlni7n/4XHEF
         rHkg==
X-Gm-Message-State: AOJu0Yz+H2Ak7iznOm7UUUfN7XAl9OyXjME2yFTKPCiCl9mvbtjr+QTA
	jDxn+ii//L8h5hXcez6bC6Y=
X-Google-Smtp-Source: AGHT+IHRn9sfboc2ZAdIqZFqXHgmj/IS/8BHmOolGzlVu+ALZCwhfpQYL9Mu2tUCot41ekECgyv89g==
X-Received: by 2002:a17:906:8466:b0:9a1:f026:b4f1 with SMTP id hx6-20020a170906846600b009a1f026b4f1mr2647696ejc.30.1692863556524;
        Thu, 24 Aug 2023 00:52:36 -0700 (PDT)
Received: from ?IPV6:2a02:3100:95e4:6600:5091:3e0c:bdec:d10a? (dynamic-2a02-3100-95e4-6600-5091-3e0c-bdec-d10a.310.pool.telefonica.de. [2a02:3100:95e4:6600:5091:3e0c:bdec:d10a])
        by smtp.googlemail.com with ESMTPSA id z14-20020a170906240e00b00982d0563b11sm10703712eja.197.2023.08.24.00.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 00:52:35 -0700 (PDT)
Message-ID: <ad71f412-e317-d8d0-5e9d-274fe0e01374@gmail.com>
Date: Thu, 24 Aug 2023 09:52:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: r8169 link up but no traffic, and watchdog error
To: =?UTF-8?Q?Martin_Kj=c3=a6r_J=c3=b8rgensen?= <me@lagy.org>
Cc: nic_swsd@realtek.com, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
 <87fs489agk.fsf@lagy.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <87fs489agk.fsf@lagy.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18.08.2023 13:49, Martin Kj=C3=A6r J=C3=B8rgensen wrote:
>=20
> On Wed, Aug 09 2023, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
>>
>> There were some fix in r8169 for power management changes recently.
>> Could you try the latest stable kernel? 6.4.9 ?
>>
>=20
> I have just upgraded to latest Debian testing kernel (6.4.0-3-amd64 #1 =
SMP
> PREEMPT_DYNAMIC Debian 6.4.11-1) but it doesn't seem to make much
> difference. I can trigger the same issue again, and get similar kernel =
error
> as before:
>=20
=46rom the line above it's not clear which kernel version is used. Best t=
est with a
self-compiled mainline kernel.

Please test also with the different ASPM L1 states disabled, you can use =
the sysfs
attributes under /sys/class/net/enp3s0/device/link/ for this.

Best bisect between last known good kernel and latest 6.4 version.

> [1]:
>=20
> [   99.274963] vdrbr0: port 2(enp9s0) entered disabled state
> [  105.064083] r8169 0000:08:00.0 enp8s0: Link is Up - 1Gbps/Full - flo=
w control rx/tx
> [  105.064138] vdrbr0: port 1(enp8s0) entered blocking state
> [  105.064145] vdrbr0: port 1(enp8s0) entered forwarding state
> [  105.172598] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flo=
w control rx/tx
> [  115.666147] ------------[ cut here ]------------
> [  115.666166] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue 0 timed =
out 8312 ms
> [  115.666191] WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:525 de=
v_watchdog+0x232/0x240
> [  115.666208] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq nf_=
conntrack_netlink xt_addrtype br_netfilter xt_policy jitterentropy_rng dr=
bg ansi_cprng authenc echainiv esp4 xfrm_interface xfrm6_tunnel tunnel6 t=
unnel4 xfrm_user xfrm_algo twofish_generic twofish_avx_x86_64 twofish_x86=
_64_3way twofish_x86_64 twofish_common serpent_avx_x86_64 serpent_sse2_x8=
6_64 serpent_generic blowfish_generic blowfish_x86_64 blowfish_common xt_=
CHECKSUM cast5_avx_x86_64 cast5_generic cast_common xt_MASQUERADE ctr xt_=
conntrack ecb cmac ipt_REJECT des_generic nf_reject_ipv4 libdes nls_utf8 =
algif_skcipher xt_tcpudp camellia_generic cifs nft_compat cifs_arc4 cifs_=
md4 dns_resolver fscache netfs camellia_x86_64 xcbc md4 algif_hash af_alg=
 nvme_fabrics nft_fib_ipv6 nft_nat nft_fib_ipv4 nft_fib overlay sunrpc bi=
nfmt_misc nls_ascii nls_cp437 vfat fat bridge stp llc cfg80211 rfkill int=
el_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coret=
emp kvm_intel snd_usb_audio kvm uvcvideo snd_usbmidi_lib snd_hwdep videob=
uf2_vmalloc uvc
> [  115.666513]  snd_rawmidi videobuf2_memops videobuf2_v4l2 snd_seq_dev=
ice snd_pcm irqbypass videodev rtsx_usb_ms iTCO_wdt think_lmi intel_pmc_b=
xt memstick mei_hdcp mei_wdt mei_pxp snd_timer intel_wmi_thunderbolt inte=
l_cstate iTCO_vendor_support wmi_bmof firmware_attributes_class intel_unc=
ore ftdi_sio mei_me watchdog snd videobuf2_common ee1004 usbserial mei jo=
ydev mc soundcore int3400_thermal acpi_thermal_rel intel_pmc_core acpi_pa=
d nft_masq button acpi_tad evdev nft_chain_nat nf_nat nf_conntrack nf_def=
rag_ipv6 nf_defrag_ipv4 nf_tables msr parport_pc ppdev nfnetlink lp parpo=
rt fuse loop efi_pstore configfs ip_tables x_tables autofs4 btrfs blake2b=
_generic hid_logitech_hidpp hid_logitech_dj rtsx_usb_sdmmc mmc_core rtsx_=
usb hid_jabra hid_generic dm_crypt dm_mod efivarfs raid10 raid456 async_r=
aid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32=
c raid1 raid0 multipath linear md_mod usbhid hid ext4 crc16 mbcache jbd2 =
crc32c_generic i915 i2c_algo_bit drm_buddy drm_display_helper drm_kms_hel=
per crc32_pclmul
> [  115.666915]  crc32c_intel cec nvme ghash_clmulni_intel rc_core nvme_=
core sha512_ssse3 ahci sha512_generic ttm libahci xhci_pci t10_pi libata =
xhci_hcd drm crc64_rocksoft_generic r8169 aesni_intel realtek e1000e scsi=
_mod crc64_rocksoft usbcore mdio_devres crc_t10dif libphy crypto_simd cry=
ptd crct10dif_generic i2c_i801 crct10dif_pclmul crc64 i2c_smbus crct10dif=
_common scsi_common usb_common fan video wmi
> [  115.667077] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.4.0-3-amd64 =
#1  Debian 6.4.11-1
> [  115.667087] Hardware name: LENOVO 30E30051UK/1052, BIOS S0AKT3AA 04/=
25/2023
> [  115.667091] RIP: 0010:dev_watchdog+0x232/0x240
> [  115.667101] Code: ff ff ff 48 89 df c6 05 35 fc 04 01 01 e8 46 3a fa=
 ff 45 89 f8 44 89 f1 48 89 de 48 89 c2 48 c7 c7 80 99 8f 9f e8 9e 0f 70 =
ff <0f> 0b e9 2d ff ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90
> [  115.667107] RSP: 0018:ffffb7c70026ce70 EFLAGS: 00010286
> [  115.667117] RAX: 0000000000000000 RBX: ffff9f540b878000 RCX: 0000000=
000000000
> [  115.667123] RDX: 0000000000000104 RSI: 00000000000000f6 RDI: 0000000=
0ffffffff
> [  115.667129] RBP: ffff9f540b8784c8 R08: 0000000000000000 R09: ffffb7c=
70026cd00
> [  115.667134] R10: 0000000000000003 R11: ffffffff9fed26a8 R12: ffff9f5=
40b867600
> [  115.667139] R13: ffff9f540b87841c R14: 0000000000000000 R15: 0000000=
000002078
> [  115.667144] FS:  0000000000000000(0000) GS:ffff9f6335680000(0000) kn=
lGS:0000000000000000
> [  115.667150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  115.667155] CR2: 0000559cac67feb0 CR3: 00000008c6220001 CR4: 0000000=
000770ee0
> [  115.667161] PKRU: 55555554
> [  115.667165] Call Trace:
> [  115.667171]  <IRQ>
> [  115.667176]  ? dev_watchdog+0x232/0x240
> [  115.667183]  ? __warn+0x81/0x130
> [  115.667198]  ? dev_watchdog+0x232/0x240
> [  115.667205]  ? report_bug+0x191/0x1c0
> [  115.667216]  ? native_apic_msr_write+0x2b/0x40
> [  115.667228]  ? handle_bug+0x3c/0x80
> [  115.667237]  ? exc_invalid_op+0x17/0x70
> [  115.667245]  ? asm_exc_invalid_op+0x1a/0x20
> [  115.667258]  ? dev_watchdog+0x232/0x240
> [  115.667266]  ? __pfx_dev_watchdog+0x10/0x10
> [  115.667273]  call_timer_fn+0x24/0x130
> [  115.667285]  ? __pfx_dev_watchdog+0x10/0x10
> [  115.667291]  __run_timers+0x222/0x2c0
> [  115.667303]  run_timer_softirq+0x2f/0x50
> [  115.667313]  __do_softirq+0xf1/0x301
> [  115.667322]  __irq_exit_rcu+0xb5/0x130
> [  115.667333]  sysvec_apic_timer_interrupt+0xa2/0xd0
> [  115.667341]  </IRQ>
> [  115.667345]  <TASK>
> [  115.667349]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  115.667359] RIP: 0010:cpuidle_enter_state+0xcc/0x440
> [  115.667368] Code: 1a eb 58 ff e8 b5 f0 ff ff 8b 53 04 49 89 c5 0f 1f=
 44 00 00 31 ff e8 83 f6 57 ff 45 84 ff 0f 85 56 02 00 00 fb 0f 1f 44 00 =
00 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
> [  115.667374] RSP: 0018:ffffb7c700193e90 EFLAGS: 00000246
> [  115.667382] RAX: ffff9f6335680000 RBX: ffffd7c6ffaa8e00 RCX: 0000000=
000000000
> [  115.667387] RDX: 0000000000000002 RSI: ffffffff9f840bf4 RDI: fffffff=
f9f82d4df
> [  115.667392] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000=
033483483
> [  115.667396] R10: ffff9f63356b1d84 R11: 0000000000004abf R12: fffffff=
f9ff98300
> [  115.667401] R13: 0000001aee3cf035 R14: 0000000000000003 R15: 0000000=
000000000
> [  115.667410]  cpuidle_enter+0x2d/0x40
> [  115.667423]  do_idle+0x217/0x270
> [  115.667433]  cpu_startup_entry+0x1d/0x20
> [  115.667441]  start_secondary+0x134/0x160
> [  115.667453]  secondary_startup_64_no_verify+0x10b/0x10b
> [  115.667467]  </TASK>
> [  115.667472] ---[ end trace 0000000000000000 ]---
> [  129.905036] r8169 0000:03:00.0 enp3s0: Link is Down
> [  132.696851] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flo=
w control rx/tx
> [  136.710137] r8169 0000:03:00.0 enp3s0: Link is Down
> [  164.035337] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flo=
w control rx/tx
> [  165.922474] r8169 0000:03:00.0 enp3s0: Link is Down
> [  166.252291] r8169 0000:08:00.0 enp8s0: Link is Down
> [  166.928980] vdrbr0: port 1(enp8s0) entered disabled state


