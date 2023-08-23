Return-Path: <netdev+bounces-29853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD91784F30
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229E81C2081D
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 03:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F96520F0D;
	Wed, 23 Aug 2023 03:19:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7BC15BC
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 03:19:14 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4DACDA
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 20:19:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68730bafa6bso4121704b3a.1
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 20:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692760750; x=1693365550;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rhQbYXtfiIx+s1DxIlHepK5Dhs6VsPW+W76Yj0fJRto=;
        b=CFYGOxgCYU8pjtRttKBvbgEVyPzu85+4ScgE516f1koYiWE/b7+DLuDsR1/+PgQIVx
         m9xZ2WEIYfSqLmpiB3fQEj2rguNSpof+rU+FZ2I0iXX6aQadrl6Dou3KH/thlta4SNdC
         ssuWxqbW6iNenjec5gUpHcRmfaRGjxzwZc2fyc+bx1rHorYC5vtJpRKaMcoQPULo86yW
         +Hf5yXHkQ0KWubby/e1J8CgRPvpfgPq+CpPm+pna8WK1takN0NC1rXOZ0V5PKB96OQvy
         26hK5PqiaMFaNf7vCzbNdd0vw9uvSyon1EvQF8cV6dCnAvC0zdUlvnDbg2ozBfnKPZDb
         U/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692760750; x=1693365550;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhQbYXtfiIx+s1DxIlHepK5Dhs6VsPW+W76Yj0fJRto=;
        b=G0wIvq9+9kXX8RBdnJK0vdCBQXj2MPzui0g1h1cJDVjq3BKYV9x2MD6vzPY9R8DnW2
         f0qUSTUk8cNqPbwKhpvYbS3Q+B8DOym0qagz7m3BBuYwscZqgMvbS35Rxns3ZL7OPpTR
         dw4ExVJV73TaEXtLd0Cbt3Ic9T/gz7o5SQpkC8R//QLSDDOUPwSv1QC1AHANbp0bVy9L
         HplEVr3My5xG3PgnYJL8GYxGRM8uJ2EkMP88KaIledytMzydR0hWoNaIw+7s/BvTvb/M
         fCxULLciYM54zfc0ml26WFzH9kYGpVsl8lbETR41M007DkWvveO1RYF6KUXHkInUeD2C
         AHwQ==
X-Gm-Message-State: AOJu0Yy5AFw0YRH3oHGjaXoF4yH5F5q0YIRgrN98uoSuzz1YdnJ0A0jL
	3Mvbhh7csqC0pzWjoE1v3nAFhUizsDzbFfJqChAzog==
X-Google-Smtp-Source: AGHT+IHqyxKQrdybQjz7vcUtQq1Urmh223opCz2NMFPYc+XwMMoVFMpJ3nv62uKMgyjl5jSEXEr8+Q==
X-Received: by 2002:a17:90b:4a48:b0:26b:535e:fc12 with SMTP id lb8-20020a17090b4a4800b0026b535efc12mr16812077pjb.7.1692760750223;
        Tue, 22 Aug 2023 20:19:10 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a198300b0025023726fc4sm5472928pji.26.2023.08.22.20.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 20:19:10 -0700 (PDT)
Date: Tue, 22 Aug 2023 20:19:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com
Cc: netdev@vger.kernel.org
Subject: Fw: [Bug 217814] New: r8169 transmit queue 0 timed out (after
 upgrade from 5.x to 6.x)
Message-ID: <20230822201908.7230de68@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Begin forwarded message:

Date: Wed, 23 Aug 2023 00:50:16 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 217814] New: r8169 transmit queue 0 timed out (after upgrade from 5.x to 6.x)


https://bugzilla.kernel.org/show_bug.cgi?id=217814

            Bug ID: 217814
           Summary: r8169 transmit queue 0 timed out (after upgrade from
                    5.x to 6.x)
           Product: Networking
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: chris@chrisheath.us
        Regression: No

After upgrading my system to 6.2 recently I've been getting seemingly random
network card crashes.

>lsb-release:  
DISTRIB_ID=LinuxMint
DISTRIB_RELEASE=21.2
DISTRIB_CODENAME=victoria
DISTRIB_DESCRIPTION="Linux Mint 21.2 Victoria"

>uname -a:  
Linux i5-ProDesk 6.2.0-26-generic #26~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu
Jul 13 16:27:29 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

>lspci:  
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411
PCI Express Gigabit Ethernet Controller (rev 15)
        Subsystem: Hewlett-Packard Company RTL8111/8168/8411 PCI Express
Gigabit Ethernet Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 3000 [size=256]
        Region 2: Memory at cc904000 (64-bit, non-prefetchable) [size=4K]
        Region 4: Memory at cc900000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: r8169
        Kernel modules: r8169

>dmesg:  
[    9.210269] r8169 0000:02:00.0 eth0: RTL8168h/8111h, 40:b0:34:fb:e8:5a, XID
541, IRQ 133
[    9.210273] r8169 0000:02:00.0 eth0: jumbo features [frames: 9194 bytes, tx
checksumming: ko]
[    9.210507] usb 2-2: New USB device found, idVendor=1c04, idProduct=0013,
bcdDevice=61.08
[    9.210511] usb 2-2: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    9.210512] usb 2-2: Product: TR-004
[    9.210513] usb 2-2: Manufacturer: QNAP Systems, Inc.
[    9.210514] usb 2-2: SerialNumber: 51323043423037383430
[    9.242547] r8169 0000:02:00.0 enp2s0: renamed from eth0
[    9.292656] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04:
bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
[    9.295636] usb-storage 2-2:1.0: USB Mass Storage device detected
[    9.295795] scsi host6: usb-storage 2-2:1.0
[    9.295851] usbcore: registered new interface driver usb-storage
[    9.305456] usbcore: registered new interface driver uas
[    9.379685] intel_tcc_cooling: Programmable TCC Offset detected
[    9.406737] intel_rapl_common: Found RAPL domain package
[    9.406740] intel_rapl_common: Found RAPL domain core
[    9.406742] intel_rapl_common: Found RAPL domain uncore
[    9.406744] intel_rapl_common: Found RAPL domain dram
[    9.426136] snd_hda_intel 0000:00:1f.3: enabling device (0100 -> 0102)
[    9.426440] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
[    9.513624] snd_hda_codec_conexant hdaudioC0D0: CX20632: BIOS auto-probing.
[    9.514513] snd_hda_codec_conexant hdaudioC0D0: autoconfig for CX20632:
line_outs=1 (0x1c/0x0/0x0/0x0/0x0) type:line
[    9.514530] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=1
(0x1f/0x0/0x0/0x0/0x0)
[    9.514537] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=1
(0x19/0x0/0x0/0x0/0x0)
[    9.514543] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=0x0
[    9.514546] snd_hda_codec_conexant hdaudioC0D0:    inputs:
[    9.514550] snd_hda_codec_conexant hdaudioC0D0:      Mic=0x1a
[    9.514554] snd_hda_codec_conexant hdaudioC0D0:      Line=0x1d
[    9.571974] input: HDA Intel PCH Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input23
[    9.572082] input: HDA Intel PCH Line as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input24
[    9.572161] input: HDA Intel PCH Line Out as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input25
[    9.572244] input: HDA Intel PCH Front Headphone as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input26
[    9.572346] input: HDA Intel PCH HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input27
[    9.572433] input: HDA Intel PCH HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input28
[    9.572552] input: HDA Intel PCH HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input29
[   10.128945] EXT4-fs (nvme0n1p3): mounted filesystem
fec84ea4-37d8-4a23-aa47-6026b141f1e0 with ordered data mode. Quota mode: none.
[   10.167438] audit: type=1400 audit(1692740819.357:4): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=490
comm="apparmor_parser"
[   10.167443] audit: type=1400 audit(1692740819.357:5): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod"
pid=490 comm="apparmor_parser"
[   10.167646] audit: type=1400 audit(1692740819.357:6): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="lsb_release" pid=489
comm="apparmor_parser"
[   10.171430] audit: type=1400 audit(1692740819.361:7): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=492
comm="apparmor_parser"
[   10.171434] audit: type=1400 audit(1692740819.361:8): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="man_filter" pid=492
comm="apparmor_parser"
[   10.171436] audit: type=1400 audit(1692740819.361:9): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="man_groff" pid=492
comm="apparmor_parser"
[   10.172672] audit: type=1400 audit(1692740819.361:10): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="/usr/lib/lightdm/lightdm-guest-session" pid=488 comm="apparmor_parser"
[   10.172675] audit: type=1400 audit(1692740819.361:11): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="/usr/lib/lightdm/lightdm-guest-session//chromium" pid=488
comm="apparmor_parser"
[   10.173611] audit: type=1400 audit(1692740819.361:12): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="/usr/bin/redshift" pid=493
comm="apparmor_parser"
[   10.175074] audit: type=1400 audit(1692740819.365:13): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=491
comm="apparmor_parser"
[   10.218202] RPC: Registered named UNIX socket transport module.
[   10.218204] RPC: Registered udp transport module.
[   10.218205] RPC: Registered tcp transport module.
[   10.218206] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   10.322223] scsi 6:0:0:0: Direct-Access     QNAP     TR-004 DISK00    6108
PQ: 0 ANSI: 6
[   10.322510] sd 6:0:0:0: Attached scsi generic sg1 type 0
[   10.322737] sd 6:0:0:0: [sda] Very big device. Trying to use READ
CAPACITY(16).
[   10.322864] sd 6:0:0:0: [sda] 46883930112 512-byte logical blocks: (24.0
TB/21.8 TiB)
[   10.322870] sd 6:0:0:0: [sda] 4096-byte physical blocks
[   10.323181] sd 6:0:0:0: [sda] Write Protect is off
[   10.323187] sd 6:0:0:0: [sda] Mode Sense: 47 00 00 08
[   10.323500] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[   10.366735] sd 6:0:0:0: [sda] Attached SCSI disk
[   10.570267] fbcon: Taking over console
[   10.596271] Console: switching to colour frame buffer device 170x48
[   10.706401] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY driver
(mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
[   10.780320] Lockdown: Xorg: raw io port access is restricted; see man
kernel_lockdown.7
[   10.901951] r8169 0000:02:00.0 enp2s0: Link is Down
[   11.040232] bridge: filtering via arp/ip/ip6tables is no longer available by
default. Update your scripts to load br_netfilter if you need this.
[   13.279884] Lockdown: systemd-logind: hibernation is restricted; see man
kernel_lockdown.7
[   13.291180] Lockdown: systemd-logind: hibernation is restricted; see man
kernel_lockdown.7
[   14.157624] r8169 0000:02:00.0 enp2s0: Link is Up - 1Gbps/Full - flow
control rx/tx
[   14.157677] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0: link becomes ready
[   14.162293] r8169 0000:02:00.0 enp2s0: Link is Up - 1Gbps/Full - flow
control off
[   14.162428] r8169 0000:02:00.0 enp2s0: Link is Down
[   15.530004] logitech-hidpp-device 0003:046D:406E.0005: HID++ 4.5 device
connected.
[   17.671377] r8169 0000:02:00.0 enp2s0: Link is Up - 100Mbps/Full - flow
control off
[   18.257246] logitech-hidpp-device 0003:046D:406D.0004: HID++ 4.5 device
connected.
[   22.827616] EXT4-fs (sda): mounted filesystem
62140d4d-9618-435f-8414-18384be15421 with ordered data mode. Quota mode: none.
[   67.980872] show_signal_msg: 18 callbacks suppressed
[   67.980874] GpuWatchdog[2955]: segfault at 0 ip 00007fd0eaf929a6 sp
00007fd0dfdfd370 error 6 in libcef.so[7fd0e6aef000+7770000] likely on CPU 1
(core 1, socket 0)
[   67.980884] Code: 89 de e8 0d ef 6e ff 80 7d cf 00 79 09 48 8b 7d b8 e8 4e
66 2c 03 41 8b 84 24 e0 00 00 00 89 45 b8 48 8d 7d b8 e8 5a d3 b5 fb <c7> 04 25
00 00 00 00 37 13 00 00 48 83 c4 38 5b 41 5c 41 5d 41 5e
[ 2809.974520] perf: interrupt took too long (2529 > 2500), lowering
kernel.perf_event_max_sample_rate to 79000
[ 6003.062611] perf: interrupt took too long (3175 > 3161), lowering
kernel.perf_event_max_sample_rate to 63000
[ 6781.127013] perf: interrupt took too long (3972 > 3968), lowering
kernel.perf_event_max_sample_rate to 50250
[ 8278.008471] ------------[ cut here ]------------
[ 8278.008479] NETDEV WATCHDOG: enp2s0 (r8169): transmit queue 0 timed out
[ 8278.008510] WARNING: CPU: 1 PID: 3485 at net/sched/sch_generic.c:525
dev_watchdog+0x21f/0x230
[ 8278.008527] Modules linked in: xt_multiport xt_CHECKSUM xt_MASQUERADE
xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nft_chain_nat
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink bridge
stp llc sunrpc binfmt_misc snd_soc_avs snd_hda_codec_hdmi snd_soc_hda_codec
snd_hda_ext_core snd_hda_codec_conexant snd_soc_core snd_hda_codec_generic
ledtrig_audio snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel
snd_intel_dspcfg intel_rapl_msr snd_intel_sdw_acpi intel_rapl_common
snd_hda_codec intel_tcc_cooling snd_hda_core x86_pkg_temp_thermal snd_hwdep
intel_powerclamp snd_pcm coretemp snd_seq_midi kvm_intel snd_seq_midi_event uas
usb_storage snd_rawmidi mei_pxp mei_hdcp kvm snd_seq irqbypass snd_seq_device
joydev hp_wmi rapl snd_timer r8169 nls_iso8859_1 input_leds intel_cstate
sparse_keymap mei_me snd realtek serio_raw platform_profile ee1004 mei
soundcore wmi_bmof mac_hid acpi_pad sch_fq_codel msr parport_pc ppdev lp
pstore_blk ramoops parport pstore_zone
[ 8278.008682]  reed_solomon efi_pstore ip_tables x_tables autofs4 btrfs
blake2b_generic xor raid6_pq libcrc32c dm_mirror dm_region_hash dm_log
hid_logitech_hidpp i915 hid_logitech_dj drm_buddy i2c_algo_bit ttm
drm_display_helper crct10dif_pclmul cec crc32_pclmul rc_core polyval_clmulni
hid_generic polyval_generic drm_kms_helper ghash_clmulni_intel usbhid
syscopyarea sha512_ssse3 hid sysfillrect aesni_intel nvme sysimgblt crypto_simd
ahci i2c_i801 xhci_pci nvme_core drm cryptd psmouse xhci_pci_renesas i2c_smbus
libahci nvme_common video wmi
[ 8278.008808] CPU: 1 PID: 3485 Comm: bitburner Not tainted 6.2.0-26-generic
#26~22.04.1-Ubuntu
[ 8278.008816] Hardware name: HP HP ProDesk 400 G4 SFF /82A2, BIOS P08 Ver.
02.46 03/28/2023
[ 8278.008819] RIP: 0010:dev_watchdog+0x21f/0x230
[ 8278.008830] Code: 00 e9 31 ff ff ff 4c 89 e7 c6 05 f5 a9 78 01 01 e8 c6 ff
f7 ff 44 89 f1 4c 89 e6 48 c7 c7 08 30 24 93 48 89 c2 e8 31 0b 2c ff <0f> 0b e9
22 ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[ 8278.008836] RSP: 0000:ffffa30488b17db0 EFLAGS: 00010246
[ 8278.008842] RAX: 0000000000000000 RBX: ffff924a5f31c4c8 RCX:
0000000000000000
[ 8278.008847] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[ 8278.008851] RBP: ffffa30488b17dd8 R08: 0000000000000000 R09:
0000000000000000
[ 8278.008855] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff924a5f31c000
[ 8278.008858] R13: ffff924a5f31c41c R14: 0000000000000000 R15:
0000000000000000
[ 8278.008862] FS:  00007fa39d427280(0000) GS:ffff924d62680000(0000)
knlGS:0000000000000000
[ 8278.008868] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8278.008872] CR2: 000016980078c380 CR3: 0000000216c98002 CR4:
00000000003706e0
[ 8278.008877] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 8278.008880] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 8278.008884] Call Trace:
[ 8278.008888]  <TASK>
[ 8278.008895]  ? __pfx_dev_watchdog+0x10/0x10
[ 8278.008905]  call_timer_fn+0x29/0x160
[ 8278.008914]  ? __pfx_dev_watchdog+0x10/0x10
[ 8278.008921]  __run_timers.part.0+0x1fb/0x2b0
[ 8278.008929]  ? ktime_get+0x43/0xc0
[ 8278.008934]  ? __pfx_tick_sched_timer+0x10/0x10
[ 8278.008945]  ? lapic_next_deadline+0x2c/0x50
[ 8278.008951]  ? clockevents_program_event+0xb2/0x140
[ 8278.008959]  run_timer_softirq+0x2a/0x60
[ 8278.008966]  __do_softirq+0xda/0x330
[ 8278.008972]  ? hrtimer_interrupt+0x12b/0x250
[ 8278.008982]  __irq_exit_rcu+0xa2/0xd0
[ 8278.008988]  irq_exit_rcu+0xe/0x20
[ 8278.008994]  sysvec_apic_timer_interrupt+0x43/0xb0
[ 8278.009001]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
[ 8278.009008] RIP: 0033:0x55be202d9e83
[ 8278.009014] Code: 00 00 00 0c 00 00 00 dd 00 00 00 ff ff ff ff 00 00 00 00
ff ff ff ff 0c 00 00 00 0c 00 00 00 0c 00 00 00 00 00 00 00 8b 59 d0 <49> 03 de
f6 43 1b 01 74 05 e9 2f 30 bb 1f 55 48 89 e5 56 57 50 48
[ 8278.009019] RSP: 002b:00007ffd8e384078 EFLAGS: 00000206
[ 8278.009024] RAX: 0000000000000001 RBX: 0000000004c3e909 RCX:
000055be202d9e80
[ 8278.009028] RDX: 00003636000023e1 RSI: 00003636006a2ca1 RDI:
000036360069c629
[ 8278.009032] RBP: 00007ffd8e3840d0 R08: 000036360069c629 R09:
00003636001c4841
[ 8278.009035] R10: 00001698003f3209 R11: 0000000000000011 R12:
000036360000400d
[ 8278.009039] R13: 0000169800550000 R14: 0000363600000000 R15:
0000000000000006
[ 8278.009047]  </TASK>
[ 8278.009050] ---[ end trace 0000000000000000 ]---
[ 8278.038321] r8169 0000:02:00.0 enp2s0: rtl_chipcmd_cond == 1 (loop: 100,
delay: 100).
[ 8278.039685] r8169 0000:02:00.0 enp2s0: rtl_ephyar_cond == 1 (loop: 100,
delay: 10).
[ 8278.041049] r8169 0000:02:00.0 enp2s0: rtl_ephyar_cond == 1 (loop: 100,
delay: 10).
[ 8278.042416] r8169 0000:02:00.0 enp2s0: rtl_ephyar_cond == 1 (loop: 100,
delay: 10).
[ 8278.043805] r8169 0000:02:00.0 enp2s0: rtl_ephyar_cond == 1 (loop: 100,
delay: 10).
[ 8278.045244] r8169 0000:02:00.0 enp2s0: rtl_ephyar_cond == 1 (loop: 100,
delay: 10).
[ 8278.046613] r8169 0000:02:00.0 enp2s0: rtl_ephyar_cond == 1 (loop: 100,
delay: 10).
[ 8278.070550] r8169 0000:02:00.0 enp2s0: rtl_eriar_cond == 1 (loop: 100,
delay: 100).
[ 8278.093905] r8169 0000:02:00.0 enp2s0: rtl_eriar_cond == 1 (loop: 100,
delay: 100).
[ 8278.117905] r8169 0000:02:00.0 enp2s0: rtl_eriar_cond == 1 (loop: 100,
delay: 100).
[ 8388.884453] net_ratelimit: 9 callbacks suppressed
[ 8388.884460] r8169 0000:02:00.0 enp2s0: rtl_chipcmd_cond == 1 (loop: 100,
delay: 100).
[ 8388.886144] r8169 0000:02:00.0 enp2s0: rtl_ephyar_cond == 1 (loop: 100,
delay: 10).
[ 8388.887504] r8169 0000:02:00.0 enp2s0: rtl_ephyar_cond == 1 (loop: 100,
delay: 10).
[ 8388.888934] r8169 0000:02:00.0 enp2s0: rtl_ephyar_cond == 1 (loop: 100,
delay: 10).
[ 8388.890386] r8169 0000:02:00.0 enp2s0: rtl_ephyar_cond == 1 (loop: 100,
delay: 10).
[ 8388.891839] r8169 0000:02:00.0 enp2s0: rtl_ephyar_cond == 1 (loop: 100,
delay: 10).
[ 8388.893406] r8169 0000:02:00.0 enp2s0: rtl_ephyar_cond == 1 (loop: 100,
delay: 10).
[ 8388.920620] r8169 0000:02:00.0 enp2s0: rtl_eriar_cond == 1 (loop: 100,
delay: 100).
[ 8388.949110] r8169 0000:02:00.0 enp2s0: rtl_eriar_cond == 1 (loop: 100,
delay: 100).
[ 8388.973078] r8169 0000:02:00.0 enp2s0: rtl_eriar_cond == 1 (loop: 100,
delay: 100).

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

