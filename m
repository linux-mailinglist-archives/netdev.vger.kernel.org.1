Return-Path: <netdev+bounces-13092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6C473A234
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3621C2110B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F5C1F164;
	Thu, 22 Jun 2023 13:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7518A1D2D1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:52:13 +0000 (UTC)
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 06:52:11 PDT
Received: from mout2.freenet.de (mout2.freenet.de [IPv6:2001:748:100:40::2:4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DCA1AC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:52:11 -0700 (PDT)
Received: from [195.4.92.125] (helo=sub6.freenet.de)
	by mout2.freenet.de with esmtpa (ID tobias.klausmann@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1qCKeA-002tMo-83; Thu, 22 Jun 2023 15:46:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xC78NmrfesOdMAq1u1RN34rGRQrQD8Mauu1uJf/YTMo=; b=SQmOiqqnS0Uz84kejlNnYI80g1
	y8IqODJnUXzTvBpdQTJtiZe6B4bPKjQ5ZIe2p+gQyTB/8VrLY0UCvdhYdgFrsVhibUpzm0+EkUXXJ
	mHZFgtP41nKdqtlg4zYUxXDLmdCkIEPC9fBCmyoX6+UTEnwz5VSf2WF5ZAhLBPY/QshA8xgXNYKZP
	/1mHsHq6Ff3722qWqla8NxNKlUrFWLl24x8BNIX+k94LU8rtbEq0H9hJqsuqWvZQelQgp5ZJ8CXPW
	2s5fkMK+nyDmSLb6OAVyif4y5JUIBU6p4WciC++zuo9wzwj53gut1UDbRRvSf1PXYUIOYtajchY2i
	N9IdonhQ==;
Received: from p200300c7ff368200e5067a8d21d0d539.dip0.t-ipconnect.de ([2003:c7:ff36:8200:e506:7a8d:21d0:d539]:52562)
	by sub6.freenet.de with esmtpsa (ID tobias.klausmann@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim 4.94.2 #2)
	id 1qCKe9-00AMOh-Qg; Thu, 22 Jun 2023 15:46:50 +0200
Message-ID: <c3465166-f04d-fcf5-d284-57357abb3f99@freenet.de>
Date: Thu, 22 Jun 2023 15:46:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Content-Language: en-US
From: Tobias Klausmann <tobias.klausmann@freenet.de>
Subject: r8169: transmit transmit queue timed out - v6.4 cycle
To: hkallweit1@gmail.com, nic_swsd@realtek.com, netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 168744160973339370DDBCO
X-Originated-At: 2003:c7:ff36:8200:e506:7a8d:21d0:d539!52562
X-Scan-TS: Thu, 22 Jun 2023 15:46:49 +0200
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello all,

introduced in the 6.4 cycle r8169 show transmit queue timeouts [1]. 
Bisecting the problem brought me to the following commit:

2ab19de62d67e403105ba860971e5ff0d511ad15 is the first bad commit
commit 2ab19de62d67e403105ba860971e5ff0d511ad15
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Mon Mar 6 22:28:06 2023 +0100

     r8169: remove ASPM restrictions now that ASPM is disabled during 
NAPI poll

     Now that  ASPM is disabled during NAPI poll, we can remove all ASPM
     restrictions. This allows for higher power savings if the network
     isn't fully loaded.

     Reviewed-by: Simon Horman <simon.horman@corigine.com>
     Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
     Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
     Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>

  drivers/net/ethernet/realtek/r8169_main.c | 27 +--------------------------
  1 file changed, 1 insertion(+), 26 deletions(-)


With this commit reverted on top of v6.4-rc6, the timeouts are gone.

The NIC identifies as "03:00.0 Ethernet controller: Realtek 
Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet 
Controller (rev 15)"

Greetings,

Tobias Klausmann


[1]:

[ 2070.918700] ------------[ cut here ]------------
[ 2070.918708] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue 0 timed 
out 5317 ms
[ 2070.918719] WARNING: CPU: 4 PID: 0 at net/sched/sch_generic.c:525 
dev_watchdog+0x1c9/0x1d0
[ 2070.918726] Modules linked in: rfcomm(E) af_packet(E) cmac(E) 
algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) btusb(E) btrtl(E) 
uvcvideo(E) btbcm(E) uvc(E) btintel(E) videobuf2_vmalloc(E) btmtk(E) 
videobuf2_memops(E) rtsx_usb_sdmmc(E) videobuf2_v4l2(E) bluetooth(E) 
rtsx_usb_ms(E) mmc_core(E) ecdh_generic(E) memstick(E) ecc(E) 
videodev(E) videobuf2_common(E) mc(E) rtsx_usb(E) qrtr(E) 
nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) joydev(E) 
snd_hda_codec_realtek(E) snd_hda_codec_generic(E) ledtrig_audio(E) 
snd_hda_codec_hdmi(E) ath10k_pci(E) ath10k_core(E) hid_multitouch(E) 
ath(E) snd_hda_intel(E) snd_intel_dspcfg(E) iTCO_wdt(E) ee1004(E) 
intel_rapl_msr(E) snd_intel_sdw_acpi(E) intel_pmc_bxt(E) 
snd_hda_codec(E) mac80211(E) iTCO_vendor_support(E) r8169(E) 
intel_rapl_common(E) snd_hda_core(E) intel_tcc_cooling(E) mei_hdcp(E) 
x86_pkg_temp_thermal(E) acer_wmi(E) intel_powerclamp(E) cfg80211(E) 
snd_hwdep(E) sparse_keymap(E) coretemp(E) snd_pcm(E) realtek(E) 
i2c_i801(E) wmi_bmof(E) intel_wmi_thunderbolt(E)
[ 2070.918794]  snd_timer(E) rfkill(E) mdio_devres(E) libphy(E) 
libarc4(E) efi_pstore(E) snd(E) i2c_smbus(E) soundcore(E) mei_me(E) 
intel_lpss_pci(E) intel_lpss(E) mei(E) idma64(E) intel_pch_thermal(E) 
thermal(E) battery(E) ac(E) acpi_pad(E) tiny_power_button(E) fuse(E) 
configfs(E) dmi_sysfs(E) ip_tables(E) x_tables(E) hid_generic(E) 
usbhid(E) crct10dif_pclmul(E) nouveau(E) crc32_pclmul(E) crc32c_intel(E) 
i915(E) polyval_clmulni(E) drm_ttm_helper(E) polyval_generic(E) 
ghash_clmulni_intel(E) mxm_wmi(E) drm_buddy(E) sha512_ssse3(E) 
i2c_algo_bit(E) aesni_intel(E) drm_display_helper(E) crypto_simd(E) 
drm_kms_helper(E) syscopyarea(E) sysfillrect(E) cryptd(E) sysimgblt(E) 
cec(E) xhci_pci(E) ttm(E) xhci_hcd(E) usbcore(E) drm(E) usb_common(E) 
i2c_hid_acpi(E) i2c_hid(E) video(E) wmi(E) pinctrl_sunrisepoint(E) 
button(E) serio_raw(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) 
scsi_dh_emc(E) scsi_dh_alua(E) msr(E) efivarfs(E)
[ 2070.918862] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G            
E      6.4.0-rc1-desktop-debug+ #51
[ 2070.918864] Hardware name: Acer Aspire VN7-593G/Pluto_KLS, BIOS V1.11 
08/01/2018
[ 2070.918866] RIP: 0010:dev_watchdog+0x1c9/0x1d0
[ 2070.918869] Code: d5 eb 92 48 89 ef c6 05 5a 34 96 00 01 e8 2f d0 fb 
ff 45 89 f8 44 89 f1 48 89 ee 48 89 c2 48 c7 c7 58 5c f2 91 e8 07 c6 83 
ff <0f> 0b e9 74 ff ff ff 41 55 41 54 55 53 48 8b 47 50 4c 8b 28 48 85
[ 2070.918872] RSP: 0018:ffffbcec00220eb8 EFLAGS: 00010286
[ 2070.918875] RAX: 0000000000000000 RBX: ffff94f0104843dc RCX: 
000000000000083f
[ 2070.918877] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 
000000000000003f
[ 2070.918878] RBP: ffff94f010484000 R08: 0000000000000001 R09: 
0000000000000000
[ 2070.918880] R10: ffff94f1b6aa0000 R11: ffff94f1b6aa0000 R12: 
ffff94f010484488
[ 2070.918881] R13: ffff94f0031a0600 R14: 0000000000000000 R15: 
00000000000014c5
[ 2070.918883] FS:  0000000000000000(0000) GS:ffff94f1b6d00000(0000) 
knlGS:0000000000000000
[ 2070.918885] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2070.918887] CR2: 00007f8eea510000 CR3: 000000023322e005 CR4: 
00000000003706e0
[ 2070.918889] Call Trace:
[ 2070.918891]  <IRQ>
[ 2070.918893]  ? mq_change_real_num_tx+0xe0/0xe0
[ 2070.918897]  ? mq_change_real_num_tx+0xe0/0xe0
[ 2070.918899]  call_timer_fn.isra.0+0x17/0x70
[ 2070.918903]  __run_timers.part.0+0x1b2/0x200
[ 2070.918907]  ? tick_sched_do_timer+0x80/0x80
[ 2070.918910]  ? hw_breakpoint_pmu_read+0x10/0x10
[ 2070.918913]  ? ktime_get+0x33/0xa0
[ 2070.918915]  run_timer_softirq+0x21/0x50
[ 2070.918918]  __do_softirq+0xb8/0x1ea
[ 2070.918923]  irq_exit_rcu+0x75/0xa0
[ 2070.918926]  sysvec_apic_timer_interrupt+0x66/0x80
[ 2070.918929]  </IRQ>
[ 2070.918930]  <TASK>
[ 2070.918932]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[ 2070.918935] RIP: 0010:cpuidle_enter_state+0xa7/0x2a0
[ 2070.918938] Code: 45 40 40 0f 84 9f 01 00 00 e8 65 00 6e ff e8 10 f8 
ff ff 31 ff 49 89 c5 e8 66 64 6d ff 45 84 ff 0f 85 76 01 00 00 fb 45 85 
f6 <0f> 88 be 00 00 00 49 63 ce 48 8b 04 24 48 6b d1 68 49 29 c5 48 89
[ 2070.918939] RSP: 0018:ffffbcec0012fe90 EFLAGS: 00000202
[ 2070.918942] RAX: ffff94f1b6d25d80 RBX: 0000000000000008 RCX: 
0000000000000000
[ 2070.918943] RDX: 000001e22c5f9004 RSI: fffffffdc849289f RDI: 
0000000000000000
[ 2070.918945] RBP: ffff94f1b6d2fa00 R08: 0000000000000002 R09: 
000000002d959839
[ 2070.918946] R10: ffff94f1b6d24904 R11: 00000000000018c7 R12: 
ffffffff92155720
[ 2070.918948] R13: 000001e22c5f9004 R14: 0000000000000008 R15: 
0000000000000000
[ 2070.918951]  cpuidle_enter+0x24/0x40
[ 2070.918954]  do_idle+0x1c0/0x220
[ 2070.918958]  cpu_startup_entry+0x14/0x20
[ 2070.918960]  start_secondary+0x109/0x130
[ 2070.918963]  secondary_startup_64_no_verify+0xf4/0xfb
[ 2070.918966]  </TASK>
[ 2070.918968] ---[ end trace 0000000000000000 ]---
[ 2072.163726] pcieport 0000:00:1c.3: Data Link Layer Link Active not 
set in 1000 msec
[ 2072.165868] r8169 0000:03:00.0 enp3s0: Can't reset secondary PCI bus, 
detach NIC


