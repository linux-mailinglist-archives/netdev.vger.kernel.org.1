Return-Path: <netdev+bounces-42838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6E27D05EF
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 02:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97233B213F3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 00:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BC2377;
	Fri, 20 Oct 2023 00:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbk5Ckb4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E8E361;
	Fri, 20 Oct 2023 00:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F8DC433C8;
	Fri, 20 Oct 2023 00:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697762715;
	bh=Twrwsm+yRhPJMXgLaDPF9ua54sAfuF8xqw4+X8+49kI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kbk5Ckb46l0m5IM+SW9mDE8rZnVI5h01xpa/TTSVlA4/K+maz+yMcXq+/UnREF2aH
	 s0q2cq0l1AbMfidIqogiUsKCAmazHFAXLQSu4QuqOvGs9cEDTz59ePLf4mYOwLETdU
	 objqVgfs4II18c8OkldBanXZqdT8l85dBq63KAlBXLy9Bk5zd3d9udGV0nFUVHGLkO
	 KtJizbaJK9zznV7FgfibWpLpHWbFNLQaMNTUcW/CIUlszHQlNuKzkc66pmckN+Im7Z
	 r3NjqcOJ1WhTTHxDvIdYwI+g9cBOT9JG4JUFVlQliyQU8fYuoOB+1S2Xqk6OvjnvcU
	 h2BuPsasOt85A==
Date: Thu, 19 Oct 2023 17:45:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ferenc Fejes <fejes@inf.elte.hu>
Cc: netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org, Hayes Wang
 <hayeswang@realtek.com>
Subject: Re: r8152: error when loading the module
Message-ID: <20231019174514.384ccca8@kernel.org>
In-Reply-To: <aff833bb8b202f12feed5b2682f1361f13e37581.camel@inf.elte.hu>
References: <aff833bb8b202f12feed5b2682f1361f13e37581.camel@inf.elte.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

CC: Hayes

On Thu, 19 Oct 2023 13:48:35 +0200 Ferenc Fejes wrote:
> Hi!
>=20
> On my machine r8152 module loading takes about one minute.
>=20
> Its a Debian Sid:=C2=A0
> uname -a
> Linux pc 6.5.0-2-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.5.6-1 (2023-10-
> 07) x86_64 GNU/Linux

Did this device work fine with older kernels or this is the only one
you tried? The code doesn't seem to have changed all that much since
RTL8156B support was added.

> dmesg:
>=20
>=20
> [  899.522306] usbcore: registered new device driver r8152-cfgselector
> [  899.601295] r8152-cfgselector 2-1.3: reset SuperSpeed USB device
> number 4 using xhci_hcd
> [  927.789526] r8152 2-1.3:1.0: firmware: direct-loading firmware
> rtl_nic/rtl8156b-2.fw
> [  942.033905] r8152 2-1.3:1.0: load rtl8156b-2 v2 04/27/23
> successfully
> [  956.269444] ------------[ cut here ]------------
> [  956.269447] WARNING: CPU: 7 PID: 211 at drivers/net/usb/r8152.c:7668
> r8156b_hw_phy_cfg+0x1417/0x1430 [r8152]
> [  956.269458] Modules linked in: r8152(+) hid_logitech_hidpp uhid ccm
> rfcomm cmac algif_hash algif_skcipher af_alg snd_seq_dummy snd_hrtimer
> snd_seq qrtr openvswitch nsh nf_conncount nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 bnep binfmt_misc nls_ascii nls_cp437 vfat
> fat snd_ctl_led snd_soc_skl_hda_dsp snd_soc_intel_hda_dsp_common
> snd_sof_probes snd_soc_hdac_hdmi x86_pkg_temp_thermal intel_powerclamp
> coretemp kvm_intel snd_hda_codec_hdmi snd_hda_codec_realtek
> snd_hda_codec_generic ledtrig_audio kvm iwlmvm snd_soc_dmic
> snd_sof_pci_intel_tgl snd_sof_intel_hda_common btusb btrtl btbcm
> soundwire_intel btintel btmtk irqbypass soundwire_generic_allocation
> mac80211 mei_pxp mei_wdt mei_hdcp snd_sof_intel_hda_mlink bluetooth
> ghash_clmulni_intel soundwire_cadence snd_sof_intel_hda snd_sof_pci
> pmt_telemetry pmt_class intel_rapl_msr snd_sof_xtensa_dsp snd_sof
> libarc4 aesni_intel snd_sof_utils snd_soc_hdac_hda snd_hda_ext_core
> snd_soc_acpi_intel_match snd_soc_acpi crypto_simd snd_soc_core cryptd
> iwlwifi sha3_generic
> [  956.269502]  jitterentropy_rng rapl snd_compress soundwire_bus
> sha512_ssse3 snd_hda_intel iTCO_wdt intel_cstate intel_pmc_bxt
> sha512_generic snd_intel_dspcfg hp_wmi iTCO_vendor_support
> snd_intel_sdw_acpi intel_uncore cfg80211 platform_profile snd_usb_audio
> snd_hda_codec ctr pcspkr watchdog snd_hda_core mei_me drbg wmi_bmof
> snd_usbmidi_lib ansi_cprng snd_hwdep snd_rawmidi mei ecdh_generic
> uvcvideo snd_seq_device snd_pcm videobuf2_vmalloc uvc videobuf2_memops
> hid_sensor_incl_3d videobuf2_v4l2 hid_sensor_magn_3d hid_sensor_als
> hid_sensor_rotation hid_sensor_accel_3d hid_sensor_gyro_3d rfkill
> snd_timer hid_sensor_trigger videobuf2_common snd hid_sensor_iio_common
> ecc processor_thermal_device_pci_legacy industrialio_triggered_buffer
> kfifo_buf processor_thermal_device soundcore industrialio
> processor_thermal_rfim processor_thermal_mbox ucsi_acpi typec_ucsi
> processor_thermal_rapl roles intel_vsec intel_rapl_common
> intel_soc_dts_iosf igen6_edac typec int3403_thermal soc_button_array
> int340x_thermal_zone int3400_thermal
> [  956.269530]  intel_hid acpi_pad intel_pmc_core ac acpi_thermal_rel
> sparse_keymap joydev hid_multitouch serio_raw evdev squashfs msr
> videodev mc parport_pc ppdev lp parport dm_mod loop efi_pstore configfs
> ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 efivarfs raid10
> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> raid6_pq libcrc32c crc32c_generic raid1 raid0 multipath linear md_mod
> virtiofs virtio_ring fuse virtio cdc_ncm cdc_ether usbnet hid_jabra
> hid_sensor_custom hid_sensor_hub intel_ishtp_hid mii i915 drm_buddy
> i2c_algo_bit drm_display_helper wacom usbhid cec hid_generic rc_core
> nvme nvme_core ttm xhci_pci t10_pi drm_kms_helper xhci_hcd
> crc64_rocksoft crc64 crc_t10dif iosm crct10dif_generic i2c_hid_acpi
> crc32_pclmul crct10dif_pclmul intel_ish_ipc intel_lpss_pci i2c_i801
> crc32c_intel drm usbcore thunderbolt i2c_smbus intel_lpss intel_ishtp
> wwan crct10dif_common vmd idma64 usb_common i2c_hid battery hid video
> wmi button [last unloaded: r8152]
> [  956.269572] CPU: 7 PID: 211 Comm: kworker/7:2 Tainted: G        W =20
> 6.5.0-2-amd64 #1  Debian 6.5.6-1
> [  956.269574] Hardware name: HP HP EliteBook x360 1040 G8 Notebook
> PC/8720, BIOS T93 Ver. 01.14.00 06/26/2023
> [  956.269575] Workqueue: events_long rtl_hw_phy_work_func_t [r8152]
> [  956.269580] RIP: 0010:r8156b_hw_phy_cfg+0x1417/0x1430 [r8152]
> [  956.269584] Code: be 00 a4 00 00 48 89 df 81 e2 ff f7 00 00 e8 00 49
> ff ff e9 a3 ec ff ff be 01 00 00 00 48 89 df e8 ae 6d ff ff e9 eb f0 ff
> ff <0f> 0b e9 b5 ec ff ff e8 5d 7e e1 d3 66 66 2e 0f 1f 84 00 00 00 00
> [  956.269585] RSP: 0018:ffffac368073bde0 EFLAGS: 00010293
> [  956.269586] RAX: 0000000000000000 RBX: ffffa0c848d939c0 RCX:
> 0000000000000000
> [  956.269587] RDX: 0000000000000000 RSI: 0000000000000246 RDI:
> 0000000000000000
> [  956.269588] RBP: ffffa0c848d93da8 R08: 0000000000000000 R09:
> 0000000000000000
> [  956.269589] R10: 0000000000000001 R11: 0000000000000000 R12:
> ffffa0c848d939c0
> [  956.269589] R13: ffffac368023cc50 R14: ffffa0c8a3ab3360 R15:
> 0000000000001c50
> [  956.269590] FS:  0000000000000000(0000) GS:ffffa0cfcf9c0000(0000)
> knlGS:0000000000000000
> [  956.269591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  956.269592] CR2: 00007fbc793e5000 CR3: 00000001ddd70002 CR4:
> 0000000000f70ee0
> [  956.269593] PKRU: 55555554
> [  956.269593] Call Trace:
> [  956.269595]  <TASK>
> [  956.269596]  ? r8156b_hw_phy_cfg+0x1417/0x1430 [r8152]
> [  956.269600]  ? __warn+0x81/0x130
> [  956.269605]  ? r8156b_hw_phy_cfg+0x1417/0x1430 [r8152]
> [  956.269609]  ? report_bug+0x191/0x1c0
> [  956.269613]  ? handle_bug+0x3c/0x80
> [  956.269615]  ? exc_invalid_op+0x17/0x70
> [  956.269617]  ? asm_exc_invalid_op+0x1a/0x20
> [  956.269620]  ? r8156b_hw_phy_cfg+0x1417/0x1430 [r8152]
> [  956.269624]  rtl_hw_phy_work_func_t+0x263/0xf50 [r8152]
> [  956.269629]  process_one_work+0x1de/0x3f0
> [  956.269632]  worker_thread+0x51/0x390
> [  956.269633]  ? _raw_spin_lock_irqsave+0x27/0x60
> [  956.269635]  ? __pfx_worker_thread+0x10/0x10
> [  956.269637]  kthread+0xf4/0x130
> [  956.269639]  ? __pfx_kthread+0x10/0x10
> [  956.269640]  ret_from_fork+0x31/0x50
> [  956.269643]  ? __pfx_kthread+0x10/0x10
> [  956.269645]  ret_from_fork_asm+0x1b/0x30
> [  956.269648]  </TASK>
> [  956.269648] ---[ end trace 0000000000000000 ]---
> [  966.304141] r8152 2-1.3:1.0: PHY patch request fail
> [  966.304935] r8152 2-1.3:1.0 eth0: v1.12.13
> [  966.304983] usbcore: registered new interface driver r8152
>=20
> Which in my case points to line 7668:
>=20
> (gdb) l *(r8156b_hw_phy_cfg+0x1417)
> 0x12577 is in r8156b_hw_phy_cfg (drivers/net/usb/r8152.c:7668).
> 7663=09
> 7664		/* disable EEE before updating the PHY parameters */
> 7665		rtl_eee_enable(tp, false);
> 7666=09
> 7667		data =3D r8153_phy_status(tp, PHY_STAT_LAN_ON);
> 7668		WARN_ON_ONCE(data !=3D PHY_STAT_LAN_ON);
> 7669=09
> 7670		ocp_data =3D ocp_read_word(tp, MCU_TYPE_PLA,
> PLA_PHY_PWR);
> 7671		ocp_data |=3D PFM_PWM_SWITCH;
> 7672		ocp_write_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR,
> ocp_data);


