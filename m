Return-Path: <netdev+bounces-30232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11576786831
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 09:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332C528144A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 07:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFE824556;
	Thu, 24 Aug 2023 07:16:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6624522
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:16:34 +0000 (UTC)
Received: from anon.cephalopo.net (anon.cephalopo.net [128.76.233.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C73E66
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lagy.org; s=def2;
	t=1692861383; bh=NzFnsE9A2uLIoF1aJ4950yqWgLJyT9IIUALpBnefwU0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=67/I+khdR+sE2h/1iMCnafkZh1glZCGgNkvXIydG3As00xyU10rLtZKZYuErpriI+
	 r8BSsZvlbbaI76tu5C/mOL317CBgMCZCtk23qZYuiIauS+G/MySC1flqAVTORb5QXc
	 Qr80maxCGYDj4GGbFZWdaOEBiqY39wnjFuCD3su93QMLHFq+XRispVBf3p0pVhRdLU
	 w4cNuCrWBmPphrrpxXHZoqMfUtPc8r1acpsi8gcCAqQhYx/XlgVZXRfgWzwI6J9NEJ
	 tbZYvGGue/65EWBqWQ03u8ldR15AU5+tl7FFUi0hAYuSoo+hEQD4dLneJPBZxWiL2+
	 Z6d/CnD4XqZgQ==
Authentication-Results: anon.cephalopo.net;
	auth=pass smtp.auth=u1 smtp.mailfrom=me@lagy.org
Received: from localhost (unknown [109.70.55.226])
	by anon.cephalopo.net (Postfix) with ESMTPSA id 5668A11C00BE;
	Thu, 24 Aug 2023 09:16:23 +0200 (CEST)
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
User-agent: mu4e 1.8.13; emacs 29.1
From: Martin =?utf-8?Q?Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>
To: netdev@vger.kernel.org <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Jakub
 Kicinski <kuba@kernel.org>
Subject: Re: r8169 link up but no traffic, and watchdog error
Date: Fri, 18 Aug 2023 13:49:27 +0200
In-reply-to: <20230809125805.2e3f86ac@kernel.org>
Message-ID: <87fs489agk.fsf@lagy.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Wed, Aug 09 2023, Jakub Kicinski <kuba@kernel.org> wrote:

>
> There were some fix in r8169 for power management changes recently.
> Could you try the latest stable kernel? 6.4.9 ?
>

I have just upgraded to latest Debian testing kernel (6.4.0-3-amd64 #1 SMP
PREEMPT_DYNAMIC Debian 6.4.11-1) but it doesn't seem to make much
difference. I can trigger the same issue again, and get similar kernel error
as before:

[1]:

[   99.274963] vdrbr0: port 2(enp9s0) entered disabled state
[  105.064083] r8169 0000:08:00.0 enp8s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[  105.064138] vdrbr0: port 1(enp8s0) entered blocking state
[  105.064145] vdrbr0: port 1(enp8s0) entered forwarding state
[  105.172598] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[  115.666147] ------------[ cut here ]------------
[  115.666166] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue 0 timed out =
8312 ms
[  115.666191] WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:525 dev_wa=
tchdog+0x232/0x240
[  115.666208] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq nf_conn=
track_netlink xt_addrtype br_netfilter xt_policy jitterentropy_rng drbg ans=
i_cprng authenc echainiv esp4 xfrm_interface xfrm6_tunnel tunnel6 tunnel4 x=
frm_user xfrm_algo twofish_generic twofish_avx_x86_64 twofish_x86_64_3way t=
wofish_x86_64 twofish_common serpent_avx_x86_64 serpent_sse2_x86_64 serpent=
_generic blowfish_generic blowfish_x86_64 blowfish_common xt_CHECKSUM cast5=
_avx_x86_64 cast5_generic cast_common xt_MASQUERADE ctr xt_conntrack ecb cm=
ac ipt_REJECT des_generic nf_reject_ipv4 libdes nls_utf8 algif_skcipher xt_=
tcpudp camellia_generic cifs nft_compat cifs_arc4 cifs_md4 dns_resolver fsc=
ache netfs camellia_x86_64 xcbc md4 algif_hash af_alg nvme_fabrics nft_fib_=
ipv6 nft_nat nft_fib_ipv4 nft_fib overlay sunrpc binfmt_misc nls_ascii nls_=
cp437 vfat fat bridge stp llc cfg80211 rfkill intel_rapl_msr intel_rapl_com=
mon x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_usb_audio =
kvm uvcvideo snd_usbmidi_lib snd_hwdep videobuf2_vmalloc uvc
[  115.666513]  snd_rawmidi videobuf2_memops videobuf2_v4l2 snd_seq_device =
snd_pcm irqbypass videodev rtsx_usb_ms iTCO_wdt think_lmi intel_pmc_bxt mem=
stick mei_hdcp mei_wdt mei_pxp snd_timer intel_wmi_thunderbolt intel_cstate=
 iTCO_vendor_support wmi_bmof firmware_attributes_class intel_uncore ftdi_s=
io mei_me watchdog snd videobuf2_common ee1004 usbserial mei joydev mc soun=
dcore int3400_thermal acpi_thermal_rel intel_pmc_core acpi_pad nft_masq but=
ton acpi_tad evdev nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defr=
ag_ipv4 nf_tables msr parport_pc ppdev nfnetlink lp parport fuse loop efi_p=
store configfs ip_tables x_tables autofs4 btrfs blake2b_generic hid_logitec=
h_hidpp hid_logitech_dj rtsx_usb_sdmmc mmc_core rtsx_usb hid_jabra hid_gene=
ric dm_crypt dm_mod efivarfs raid10 raid456 async_raid6_recov async_memcpy =
async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath li=
near md_mod usbhid hid ext4 crc16 mbcache jbd2 crc32c_generic i915 i2c_algo=
_bit drm_buddy drm_display_helper drm_kms_helper crc32_pclmul
[  115.666915]  crc32c_intel cec nvme ghash_clmulni_intel rc_core nvme_core=
 sha512_ssse3 ahci sha512_generic ttm libahci xhci_pci t10_pi libata xhci_h=
cd drm crc64_rocksoft_generic r8169 aesni_intel realtek e1000e scsi_mod crc=
64_rocksoft usbcore mdio_devres crc_t10dif libphy crypto_simd cryptd crct10=
dif_generic i2c_i801 crct10dif_pclmul crc64 i2c_smbus crct10dif_common scsi=
_common usb_common fan video wmi
[  115.667077] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.4.0-3-amd64 #1  =
Debian 6.4.11-1
[  115.667087] Hardware name: LENOVO 30E30051UK/1052, BIOS S0AKT3AA 04/25/2=
023
[  115.667091] RIP: 0010:dev_watchdog+0x232/0x240
[  115.667101] Code: ff ff ff 48 89 df c6 05 35 fc 04 01 01 e8 46 3a fa ff =
45 89 f8 44 89 f1 48 89 de 48 89 c2 48 c7 c7 80 99 8f 9f e8 9e 0f 70 ff <0f=
> 0b e9 2d ff ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90
[  115.667107] RSP: 0018:ffffb7c70026ce70 EFLAGS: 00010286
[  115.667117] RAX: 0000000000000000 RBX: ffff9f540b878000 RCX: 00000000000=
00000
[  115.667123] RDX: 0000000000000104 RSI: 00000000000000f6 RDI: 00000000fff=
fffff
[  115.667129] RBP: ffff9f540b8784c8 R08: 0000000000000000 R09: ffffb7c7002=
6cd00
[  115.667134] R10: 0000000000000003 R11: ffffffff9fed26a8 R12: ffff9f540b8=
67600
[  115.667139] R13: ffff9f540b87841c R14: 0000000000000000 R15: 00000000000=
02078
[  115.667144] FS:  0000000000000000(0000) GS:ffff9f6335680000(0000) knlGS:=
0000000000000000
[  115.667150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  115.667155] CR2: 0000559cac67feb0 CR3: 00000008c6220001 CR4: 00000000007=
70ee0
[  115.667161] PKRU: 55555554
[  115.667165] Call Trace:
[  115.667171]  <IRQ>
[  115.667176]  ? dev_watchdog+0x232/0x240
[  115.667183]  ? __warn+0x81/0x130
[  115.667198]  ? dev_watchdog+0x232/0x240
[  115.667205]  ? report_bug+0x191/0x1c0
[  115.667216]  ? native_apic_msr_write+0x2b/0x40
[  115.667228]  ? handle_bug+0x3c/0x80
[  115.667237]  ? exc_invalid_op+0x17/0x70
[  115.667245]  ? asm_exc_invalid_op+0x1a/0x20
[  115.667258]  ? dev_watchdog+0x232/0x240
[  115.667266]  ? __pfx_dev_watchdog+0x10/0x10
[  115.667273]  call_timer_fn+0x24/0x130
[  115.667285]  ? __pfx_dev_watchdog+0x10/0x10
[  115.667291]  __run_timers+0x222/0x2c0
[  115.667303]  run_timer_softirq+0x2f/0x50
[  115.667313]  __do_softirq+0xf1/0x301
[  115.667322]  __irq_exit_rcu+0xb5/0x130
[  115.667333]  sysvec_apic_timer_interrupt+0xa2/0xd0
[  115.667341]  </IRQ>
[  115.667345]  <TASK>
[  115.667349]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  115.667359] RIP: 0010:cpuidle_enter_state+0xcc/0x440
[  115.667368] Code: 1a eb 58 ff e8 b5 f0 ff ff 8b 53 04 49 89 c5 0f 1f 44 =
00 00 31 ff e8 83 f6 57 ff 45 84 ff 0f 85 56 02 00 00 fb 0f 1f 44 00 00 <45=
> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[  115.667374] RSP: 0018:ffffb7c700193e90 EFLAGS: 00000246
[  115.667382] RAX: ffff9f6335680000 RBX: ffffd7c6ffaa8e00 RCX: 00000000000=
00000
[  115.667387] RDX: 0000000000000002 RSI: ffffffff9f840bf4 RDI: ffffffff9f8=
2d4df
[  115.667392] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000334=
83483
[  115.667396] R10: ffff9f63356b1d84 R11: 0000000000004abf R12: ffffffff9ff=
98300
[  115.667401] R13: 0000001aee3cf035 R14: 0000000000000003 R15: 00000000000=
00000
[  115.667410]  cpuidle_enter+0x2d/0x40
[  115.667423]  do_idle+0x217/0x270
[  115.667433]  cpu_startup_entry+0x1d/0x20
[  115.667441]  start_secondary+0x134/0x160
[  115.667453]  secondary_startup_64_no_verify+0x10b/0x10b
[  115.667467]  </TASK>
[  115.667472] ---[ end trace 0000000000000000 ]---
[  129.905036] r8169 0000:03:00.0 enp3s0: Link is Down
[  132.696851] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[  136.710137] r8169 0000:03:00.0 enp3s0: Link is Down
[  164.035337] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[  165.922474] r8169 0000:03:00.0 enp3s0: Link is Down
[  166.252291] r8169 0000:08:00.0 enp8s0: Link is Down
[  166.928980] vdrbr0: port 1(enp8s0) entered disabled state

