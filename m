Return-Path: <netdev+bounces-17168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386B9750B18
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB6D1C21157
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08841F93B;
	Wed, 12 Jul 2023 14:33:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D357A42
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:33:52 +0000 (UTC)
Received: from mout2.freenet.de (mout2.freenet.de [IPv6:2001:748:100:40::2:4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554CBE42
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:33:42 -0700 (PDT)
Received: from [195.4.92.121] (helo=sub2.freenet.de)
	by mout2.freenet.de with esmtpa (ID tobias.klausmann@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1qJauG-00AnHe-Gg; Wed, 12 Jul 2023 16:33:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date
	:Message-ID:Content-Type:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=0VpVeMGY1i9eBt2JHZ+xknK8UX+7yrxVtfSyD3EG8io=; b=egYP2aGIwalMcBydohPM748z/n
	lIZDP/3NPJLC2v70MxSC/cLhDO86rUURa0mpt/6ODK8PYcS0K3vvw+m+7ZHN+t4PNT8yoC3Azn9rH
	J4eBJli6djrT1YvaCHwetl87vriP2OFktNifMFWQfzT0Fybmxv9X+juSjzuto5ik/uIskfoGea/Wh
	fNTXKHCIlt7z80zwU+KyM6T04RYSADQs372ZIlySFkeNBoD7cqTSSpipSLx2nt9W874Xt3YPlX3Aq
	a7mi2SUYHdwoAqfa6gHWMe2eKMEreLuoSfBzhzVTm94GDREvGTgeZ+7x9Ukppt1xJUPDeZuhkPnCy
	fUr2dklA==;
Received: from p200300c7ff4eee00e5067a8d21d0d539.dip0.t-ipconnect.de ([2003:c7:ff4e:ee00:e506:7a8d:21d0:d539]:47214)
	by sub2.freenet.de with esmtpsa (ID tobias.klausmann@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim 4.94.2 #2)
	id 1qJauF-00AVUQ-5w; Wed, 12 Jul 2023 16:33:28 +0200
Content-Type: multipart/mixed; boundary="------------lS5SUTwfL0SlAT94caQJNMwq"
Message-ID: <177e7247-2bff-0ef7-8219-873edca14adc@freenet.de>
Date: Wed, 12 Jul 2023 16:33:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: r8169: transmit transmit queue timed out - v6.4 cycle
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 netdev@vger.kernel.org
References: <c3465166-f04d-fcf5-d284-57357abb3f99@freenet.de>
 <CAFSsGVtiXSK_0M_TQm_38LabiRX7E5vR26x=cKags4ZQBqfXPQ@mail.gmail.com>
 <e47bac0d-e802-65e1-b311-6acb26d5cf10@freenet.de>
 <f7ca15e8-2cf2-1372-e29a-d7f2a2cc09f1@leemhuis.info>
 <CAFSsGVuDLnW_7iwSUNebx8Lku3CGZhcym3uXfMFnotA=OYJJjQ@mail.gmail.com>
 <A69A7D66-A73A-4C4D-913B-8C2D4CF03CE2@freenet.de>
 <842ae1f6-e3fe-f4d1-8d4f-f19627a52665@gmail.com>
Content-Language: en-US
From: Tobias Klausmann <tobias.klausmann@freenet.de>
In-Reply-To: <842ae1f6-e3fe-f4d1-8d4f-f19627a52665@gmail.com>
X-FN-MUUID: 1689172407ED2E1760F997O
X-Originated-At: 2003:c7:ff4e:ee00:e506:7a8d:21d0:d539!47214
X-Scan-TS: Wed, 12 Jul 2023 16:33:27 +0200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a multi-part message in MIME format.
--------------lS5SUTwfL0SlAT94caQJNMwq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.07.23 13:39, Heiner Kallweit wrote:
> On 05.07.2023 00:25, Tobias Klausmann wrote:
>> Hi,
>> top posting as well, as im on vacation, too. The system does not allow disabling ASPM, it is a very constrained notebook BIOS, thus the suggestion is nit feasible. All in all the sugesstion seems not favorable for me, as it is unknown how many systems are broken the same way. Having a workaround adviced as default seems oretty wrong to me.
>>
> To get a better understanding of the affected system:
> Could you please provide a full dmesg log and the lspci -vv output?
>
>>
>> Am 4. Juli 2023 16:45:06 GMT-04:00 schrieb Heiner Kallweit <hkallweit1@gmail.com>:
>>
>>      I'm currently on vacation, therefore html top-posting via mobile Gmail client.
>>      The referenced chip version RTL8168h works fine with ASPM L1.2 and v6.4 for me, therefore supposedly ASPM is massively broken on the author's system. My suggestion to the author is to disable ASPM in BIOS, also because his BIOS doesn't allow Linux to change ASPM settings.
>>
>>      Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info <mailto:regressions@leemhuis.info>> schrieb am Di., 4. Juli 2023, 18:42:
>>
>>          [CCing the regression list, as it should be in the loop for regressions:
>>          https://docs.kernel.org/admin-guide/reporting-regressions.html <https://docs.kernel.org/admin-guide/reporting-regressions.html>]
>>
>>          Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>>          for once, to make this easily accessible to everyone.
>>
>>          Heiner, could you please give a status update? It looks like this
>>          regression made no progress in the past 11 days. Should this maybe be
>>          reverted for now if things take so long? Or am I missing something?
>>
>>          Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>          --
>>          Everything you wanna know about Linux kernel regression tracking:
>>          https://linux-regtracking.leemhuis.info/about/#tldr <https://linux-regtracking.leemhuis.info/about/#tldr>
>>          If I did something stupid, please tell me, as explained on that page.
>>
>>          #regzbot poke
>>
>>          On 23.06.23 19:30, Tobias Klausmann wrote:
>>          > Hello,
>>          >
>>          > ASPM is not available as per
>>          >
>>          > "r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPMcontrol",
>>          > the problem is triggered by "no-load" to ~100MBit/s load on a 1GBit/s
>>          > connection.
>>          >
>>          >
>>          > On 23.06.23 00:10, Heiner Kallweit wrote:
>>          >> Same chip version works fine for me even with ASPM L1.2. So your board
>>          >> may have  broken ASPM support. Any special load pattern that triggers
>>          >> the issue?  Can you work around the issue by disabling ASPM sub-states
>>          >> via sysfs attributes, starting with L1.2?
>>          >>
>>          >> Tobias Klausmann <tobias.klausmann@freenet.de <mailto:tobias.klausmann@freenet.de>> schrieb am Do., 22.
>>          >> Juni 2023, 15:46:
>>          >>
>>          >>     Hello all,
>>          >>
>>          >>     introduced in the 6.4 cycle r8169 show transmit queue timeouts [1].
>>          >>     Bisecting the problem brought me to the following commit:
>>          >>
>>          >>     2ab19de62d67e403105ba860971e5ff0d511ad15 is the first bad commit
>>          >>     commit 2ab19de62d67e403105ba860971e5ff0d511ad15
>>          >>     Author: Heiner Kallweit <hkallweit1@gmail.com <mailto:hkallweit1@gmail.com>>
>>          >>     Date:   Mon Mar 6 22:28:06 2023 +0100
>>          >>
>>          >>          r8169: remove ASPM restrictions now that ASPM is disabled during
>>          >>     NAPI poll
>>          >>
>>          >>          Now that  ASPM is disabled during NAPI poll, we can remove
>>          >>     all ASPM
>>          >>          restrictions. This allows for higher power savings if the
>>          >> network
>>          >>          isn't fully loaded.
>>          >>
>>          >>          Reviewed-by: Simon Horman <simon.horman@corigine.com <mailto:simon.horman@corigine.com>>
>>          >>          Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com <mailto:kai.heng.feng@canonical.com>>
>>          >>          Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com <mailto:holger@applied-asynchrony.com>>
>>          >>          Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com <mailto:hkallweit1@gmail.com>>
>>          >>          Signed-off-by: David S. Miller <davem@davemloft.net <mailto:davem@davemloft.net>>
>>          >>
>>          >>       drivers/net/ethernet/realtek/r8169_main.c | 27
>>          >>     +--------------------------
>>          >>       1 file changed, 1 insertion(+), 26 deletions(-)
>>          >>
>>          >>
>>          >>     With this commit reverted on top of v6.4-rc6, the timeouts are gone.
>>          >>
>>          >>     The NIC identifies as "03:00.0 Ethernet controller: Realtek
>>          >>     Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit
>>          >>     Ethernet
>>          >>     Controller (rev 15)"
>>          >>
>>          >>     Greetings,
>>          >>
>>          >>     Tobias Klausmann
>>          >>
>>          >>
>>          >>     [1]:
>>          >>
>>          >>     [ 2070.918700] ------------[ cut here ]------------
>>          >>     [ 2070.918708] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue 0
>>          >>     timed
>>          >>     out 5317 ms
>>          >>     [ 2070.918719] WARNING: CPU: 4 PID: 0 at net/sched/sch_generic.c:525
>>          >>     dev_watchdog+0x1c9/0x1d0
>>          >>     [ 2070.918726] Modules linked in: rfcomm(E) af_packet(E) cmac(E)
>>          >>     algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) btusb(E) btrtl(E)
>>          >>     uvcvideo(E) btbcm(E) uvc(E) btintel(E) videobuf2_vmalloc(E) btmtk(E)
>>          >>     videobuf2_memops(E) rtsx_usb_sdmmc(E) videobuf2_v4l2(E) bluetooth(E)
>>          >>     rtsx_usb_ms(E) mmc_core(E) ecdh_generic(E) memstick(E) ecc(E)
>>          >>     videodev(E) videobuf2_common(E) mc(E) rtsx_usb(E) qrtr(E)
>>          >>     nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) joydev(E)
>>          >>     snd_hda_codec_realtek(E) snd_hda_codec_generic(E) ledtrig_audio(E)
>>          >>     snd_hda_codec_hdmi(E) ath10k_pci(E) ath10k_core(E) hid_multitouch(E)
>>          >>     ath(E) snd_hda_intel(E) snd_intel_dspcfg(E) iTCO_wdt(E) ee1004(E)
>>          >>     intel_rapl_msr(E) snd_intel_sdw_acpi(E) intel_pmc_bxt(E)
>>          >>     snd_hda_codec(E) mac80211(E) iTCO_vendor_support(E) r8169(E)
>>          >>     intel_rapl_common(E) snd_hda_core(E) intel_tcc_cooling(E) mei_hdcp(E)
>>          >>     x86_pkg_temp_thermal(E) acer_wmi(E) intel_powerclamp(E) cfg80211(E)
>>          >>     snd_hwdep(E) sparse_keymap(E) coretemp(E) snd_pcm(E) realtek(E)
>>          >>     i2c_i801(E) wmi_bmof(E) intel_wmi_thunderbolt(E)
>>          >>     [ 2070.918794]  snd_timer(E) rfkill(E) mdio_devres(E) libphy(E)
>>          >>     libarc4(E) efi_pstore(E) snd(E) i2c_smbus(E) soundcore(E) mei_me(E)
>>          >>     intel_lpss_pci(E) intel_lpss(E) mei(E) idma64(E) intel_pch_thermal(E)
>>          >>     thermal(E) battery(E) ac(E) acpi_pad(E) tiny_power_button(E) fuse(E)
>>          >>     configfs(E) dmi_sysfs(E) ip_tables(E) x_tables(E) hid_generic(E)
>>          >>     usbhid(E) crct10dif_pclmul(E) nouveau(E) crc32_pclmul(E)
>>          >>     crc32c_intel(E)
>>          >>     i915(E) polyval_clmulni(E) drm_ttm_helper(E) polyval_generic(E)
>>          >>     ghash_clmulni_intel(E) mxm_wmi(E) drm_buddy(E) sha512_ssse3(E)
>>          >>     i2c_algo_bit(E) aesni_intel(E) drm_display_helper(E) crypto_simd(E)
>>          >>     drm_kms_helper(E) syscopyarea(E) sysfillrect(E) cryptd(E)
>>          >>     sysimgblt(E)
>>          >>     cec(E) xhci_pci(E) ttm(E) xhci_hcd(E) usbcore(E) drm(E) usb_common(E)
>>          >>     i2c_hid_acpi(E) i2c_hid(E) video(E) wmi(E) pinctrl_sunrisepoint(E)
>>          >>     button(E) serio_raw(E) sg(E) dm_multipath(E) dm_mod(E)
>>          >>     scsi_dh_rdac(E)
>>          >>     scsi_dh_emc(E) scsi_dh_alua(E) msr(E) efivarfs(E)
>>          >>     [ 2070.918862] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G
>>          >>     E      6.4.0-rc1-desktop-debug+ #51
>>          >>     [ 2070.918864] Hardware name: Acer Aspire VN7-593G/Pluto_KLS, BIOS
>>          >>     V1.11
>>          >>     08/01/2018
>>          >>     [ 2070.918866] RIP: 0010:dev_watchdog+0x1c9/0x1d0
>>          >>     [ 2070.918869] Code: d5 eb 92 48 89 ef c6 05 5a 34 96 00 01 e8 2f
>>          >>     d0 fb
>>          >>     ff 45 89 f8 44 89 f1 48 89 ee 48 89 c2 48 c7 c7 58 5c f2 91 e8 07
>>          >>     c6 83
>>          >>     ff <0f> 0b e9 74 ff ff ff 41 55 41 54 55 53 48 8b 47 50 4c 8b 28
>>          >> 48 85
>>          >>     [ 2070.918872] RSP: 0018:ffffbcec00220eb8 EFLAGS: 00010286
>>          >>     [ 2070.918875] RAX: 0000000000000000 RBX: ffff94f0104843dc RCX:
>>          >>     000000000000083f
>>          >>     [ 2070.918877] RDX: 0000000000000000 RSI: 00000000000000f6 RDI:
>>          >>     000000000000003f
>>          >>     [ 2070.918878] RBP: ffff94f010484000 R08: 0000000000000001 R09:
>>          >>     0000000000000000
>>          >>     [ 2070.918880] R10: ffff94f1b6aa0000 R11: ffff94f1b6aa0000 R12:
>>          >>     ffff94f010484488
>>          >>     [ 2070.918881] R13: ffff94f0031a0600 R14: 0000000000000000 R15:
>>          >>     00000000000014c5
>>          >>     [ 2070.918883] FS:  0000000000000000(0000) GS:ffff94f1b6d00000(0000)
>>          >>     knlGS:0000000000000000
>>          >>     [ 2070.918885] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>          >>     [ 2070.918887] CR2: 00007f8eea510000 CR3: 000000023322e005 CR4:
>>          >>     00000000003706e0
>>          >>     [ 2070.918889] Call Trace:
>>          >>     [ 2070.918891]  <IRQ>
>>          >>     [ 2070.918893]  ? mq_change_real_num_tx+0xe0/0xe0
>>          >>     [ 2070.918897]  ? mq_change_real_num_tx+0xe0/0xe0
>>          >>     [ 2070.918899]  call_timer_fn.isra.0+0x17/0x70
>>          >>     [ 2070.918903]  __run_timers.part.0+0x1b2/0x200
>>          >>     [ 2070.918907]  ? tick_sched_do_timer+0x80/0x80
>>          >>     [ 2070.918910]  ? hw_breakpoint_pmu_read+0x10/0x10
>>          >>     [ 2070.918913]  ? ktime_get+0x33/0xa0
>>          >>     [ 2070.918915]  run_timer_softirq+0x21/0x50
>>          >>     [ 2070.918918]  __do_softirq+0xb8/0x1ea
>>          >>     [ 2070.918923]  irq_exit_rcu+0x75/0xa0
>>          >>     [ 2070.918926]  sysvec_apic_timer_interrupt+0x66/0x80
>>          >>     [ 2070.918929]  </IRQ>
>>          >>     [ 2070.918930]  <TASK>
>>          >>     [ 2070.918932]  asm_sysvec_apic_timer_interrupt+0x16/0x20
>>          >>     [ 2070.918935] RIP: 0010:cpuidle_enter_state+0xa7/0x2a0
>>          >>     [ 2070.918938] Code: 45 40 40 0f 84 9f 01 00 00 e8 65 00 6e ff e8
>>          >>     10 f8
>>          >>     ff ff 31 ff 49 89 c5 e8 66 64 6d ff 45 84 ff 0f 85 76 01 00 00 fb
>>          >>     45 85
>>          >>     f6 <0f> 88 be 00 00 00 49 63 ce 48 8b 04 24 48 6b d1 68 49 29 c5
>>          >> 48 89
>>          >>     [ 2070.918939] RSP: 0018:ffffbcec0012fe90 EFLAGS: 00000202
>>          >>     [ 2070.918942] RAX: ffff94f1b6d25d80 RBX: 0000000000000008 RCX:
>>          >>     0000000000000000
>>          >>     [ 2070.918943] RDX: 000001e22c5f9004 RSI: fffffffdc849289f RDI:
>>          >>     0000000000000000
>>          >>     [ 2070.918945] RBP: ffff94f1b6d2fa00 R08: 0000000000000002 R09:
>>          >>     000000002d959839
>>          >>     [ 2070.918946] R10: ffff94f1b6d24904 R11: 00000000000018c7 R12:
>>          >>     ffffffff92155720
>>          >>     [ 2070.918948] R13: 000001e22c5f9004 R14: 0000000000000008 R15:
>>          >>     0000000000000000
>>          >>     [ 2070.918951]  cpuidle_enter+0x24/0x40
>>          >>     [ 2070.918954]  do_idle+0x1c0/0x220
>>          >>     [ 2070.918958]  cpu_startup_entry+0x14/0x20
>>          >>     [ 2070.918960]  start_secondary+0x109/0x130
>>          >>     [ 2070.918963]  secondary_startup_64_no_verify+0xf4/0xfb
>>          >>     [ 2070.918966]  </TASK>
>>          >>     [ 2070.918968] ---[ end trace 0000000000000000 ]---
>>          >>     [ 2072.163726] pcieport 0000:00:1c.3: Data Link Layer Link Active not
>>          >>     set in 1000 msec
>>          >>     [ 2072.165868] r8169 0000:03:00.0 enp3s0: Can't reset secondary
>>          >>     PCI bus,
>>          >>     detach NIC
>>          >>
>>
Hi,

attached are the dmesg an lspci -vv as txt files as requested. The 
running kernel has the offending commit reverted.


--------------lS5SUTwfL0SlAT94caQJNMwq
Content-Type: text/plain; charset=UTF-8; name="dmesg.txt"
Content-Disposition: attachment; filename="dmesg.txt"
Content-Transfer-Encoding: base64

WyAgICAwLjAwMDAwMF0gbWljcm9jb2RlOiB1cGRhdGVkIGVhcmx5OiAweDg0IC0+IDB4ZjIs
IGRhdGUgPSAyMDIyLTEyLTI2ClsgICAgMC4wMDAwMDBdIExpbnV4IHZlcnNpb24gNi40LjAt
ZGVza3RvcC1hY2VyZmFuKyAodG9iaUBzaWViZW4pIChnY2MgKFNVU0UgTGludXgpIDEzLjEu
MSAyMDIzMDUyMiBbcmV2aXNpb24gZGQzNjY1NmFkYTA1NzMxYzA2OWVjZDViMTg3ODM4MDI5
NGZiMWYzZV0sIEdOVSBsZCAoR05VIEJpbnV0aWxzOyBvcGVuU1VTRSBUdW1ibGV3ZWVkKSAy
LjQwLjAuMjAyMzA0MTItNSkgIzY1IFNNUCBQUkVFTVBUIE1vbiBKdW4gMjYgMTY6NDE6NDgg
Q0VTVCAyMDIzClsgICAgMC4wMDAwMDBdIENvbW1hbmQgbGluZTogQk9PVF9JTUFHRT0vYm9v
dC92bWxpbnV6LTYuNC4wLWRlc2t0b3AtYWNlcmZhbisgcm9vdD1VVUlEPTA4NzQ2ZTI2LTQz
NWMtNDllMS1hNTIyLTE4ZGJhNjIyOTIzOSBzcGxhc2g9c2lsZW50IHJlc3VtZT0vZGV2L2Rp
c2svYnktdXVpZC8zMzlmMjIxMy1jMGVlLTQ1NGEtOTk2NS1iZTkwMmVlZmU3ZjQgbm91dmVh
dS52cmFtX3B1c2hidWY9MSBhY3BpX29zaT0hICJhY3BpX29zaT1XaW5kb3dzIDIwMTUiIG5v
dXZlYXUuaGRtaW1oej02MDAgbm91dmVhdS5kZWJ1Zz1pbmZvIG5vdXZlYXUuYXRvbWljPTEg
bWl0aWdhdGlvbnM9YXV0bwpbICAgIDAuMDAwMDAwXSBLRVJORUwgc3VwcG9ydGVkIGNwdXM6
ClsgICAgMC4wMDAwMDBdICAgSW50ZWwgR2VudWluZUludGVsClsgICAgMC4wMDAwMDBdIHg4
Ni9mcHU6IFN1cHBvcnRpbmcgWFNBVkUgZmVhdHVyZSAweDAwMTogJ3g4NyBmbG9hdGluZyBw
b2ludCByZWdpc3RlcnMnClsgICAgMC4wMDAwMDBdIHg4Ni9mcHU6IFN1cHBvcnRpbmcgWFNB
VkUgZmVhdHVyZSAweDAwMjogJ1NTRSByZWdpc3RlcnMnClsgICAgMC4wMDAwMDBdIHg4Ni9m
cHU6IFN1cHBvcnRpbmcgWFNBVkUgZmVhdHVyZSAweDAwNDogJ0FWWCByZWdpc3RlcnMnClsg
ICAgMC4wMDAwMDBdIHg4Ni9mcHU6IFN1cHBvcnRpbmcgWFNBVkUgZmVhdHVyZSAweDAwODog
J01QWCBib3VuZHMgcmVnaXN0ZXJzJwpbICAgIDAuMDAwMDAwXSB4ODYvZnB1OiBTdXBwb3J0
aW5nIFhTQVZFIGZlYXR1cmUgMHgwMTA6ICdNUFggQ1NSJwpbICAgIDAuMDAwMDAwXSB4ODYv
ZnB1OiB4c3RhdGVfb2Zmc2V0WzJdOiAgNTc2LCB4c3RhdGVfc2l6ZXNbMl06ICAyNTYKWyAg
ICAwLjAwMDAwMF0geDg2L2ZwdTogeHN0YXRlX29mZnNldFszXTogIDgzMiwgeHN0YXRlX3Np
emVzWzNdOiAgIDY0ClsgICAgMC4wMDAwMDBdIHg4Ni9mcHU6IHhzdGF0ZV9vZmZzZXRbNF06
ICA4OTYsIHhzdGF0ZV9zaXplc1s0XTogICA2NApbICAgIDAuMDAwMDAwXSB4ODYvZnB1OiBF
bmFibGVkIHhzdGF0ZSBmZWF0dXJlcyAweDFmLCBjb250ZXh0IHNpemUgaXMgOTYwIGJ5dGVz
LCB1c2luZyAnY29tcGFjdGVkJyBmb3JtYXQuClsgICAgMC4wMDAwMDBdIHNpZ25hbDogbWF4
IHNpZ2ZyYW1lIHNpemU6IDIwMzIKWyAgICAwLjAwMDAwMF0gQklPUy1wcm92aWRlZCBwaHlz
aWNhbCBSQU0gbWFwOgpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAw
MDAwMDAwMDAwLTB4MDAwMDAwMDAwMDA1N2ZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIEJJ
T1MtZTgyMDogW21lbSAweDAwMDAwMDAwMDAwNTgwMDAtMHgwMDAwMDAwMDAwMDU4ZmZmXSBy
ZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMDU5
MDAwLTB4MDAwMDAwMDAwMDA5ZGZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIEJJT1MtZTgy
MDogW21lbSAweDAwMDAwMDAwMDAwOWUwMDAtMHgwMDAwMDAwMDAwMGZmZmZmXSByZXNlcnZl
ZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMTAwMDAwLTB4
MDAwMDAwMDAyMjNiNWZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21l
bSAweDAwMDAwMDAwMjIzYjYwMDAtMHgwMDAwMDAwMDIyM2I2ZmZmXSBBQ1BJIE5WUwpbICAg
IDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDIyM2I3MDAwLTB4MDAwMDAw
MDAyMjNiN2ZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4
MDAwMDAwMDAyMjNiODAwMC0weDAwMDAwMDAwMzllOWRmZmZdIHVzYWJsZQpbICAgIDAuMDAw
MDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDM5ZTllMDAwLTB4MDAwMDAwMDAzYTg4
ZGZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAw
MDAzYTg4ZTAwMC0weDAwMDAwMDAwM2FmN2RmZmZdIEFDUEkgTlZTClsgICAgMC4wMDAwMDBd
IEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwM2FmN2UwMDAtMHgwMDAwMDAwMDNhZmZkZmZm
XSBBQ1BJIGRhdGEKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAz
YWZmZTAwMC0weDAwMDAwMDAwM2FmZmVmZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSBCSU9T
LWU4MjA6IFttZW0gMHgwMDAwMDAwMDNhZmZmMDAwLTB4MDAwMDAwMDAzZmZmZmZmZl0gcmVz
ZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBlMDAwMDAw
MC0weDAwMDAwMDAwZWZmZmZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgy
MDogW21lbSAweDAwMDAwMDAwZmQwMDAwMDAtMHgwMDAwMDAwMGZlN2ZmZmZmXSByZXNlcnZl
ZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZlYzAwMDAwLTB4
MDAwMDAwMDBmZWMwMGZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBb
bWVtIDB4MDAwMDAwMDBmZWQwMDAwMC0weDAwMDAwMDAwZmVkMDBmZmZdIHJlc2VydmVkClsg
ICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwZmVkMTAwMDAtMHgwMDAw
MDAwMGZlZDE5ZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0g
MHgwMDAwMDAwMGZlZDg0MDAwLTB4MDAwMDAwMDBmZWQ4NGZmZl0gcmVzZXJ2ZWQKWyAgICAw
LjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZWUwMDAwMC0weDAwMDAwMDAw
ZmVlMDBmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAw
MDAwMDAwZmZhMDAwMDAtMHgwMDAwMDAwMGZmZmZmZmZmXSByZXNlcnZlZApbICAgIDAuMDAw
MDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4MDAwMDAwMDJiZWZm
ZmZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIE5YIChFeGVjdXRlIERpc2FibGUpIHByb3Rl
Y3Rpb246IGFjdGl2ZQpbICAgIDAuMDAwMDAwXSBlODIwOiB1cGRhdGUgW21lbSAweDIwZDVm
MDE4LTB4MjBkNmYwNTddIHVzYWJsZSA9PT4gdXNhYmxlClsgICAgMC4wMDAwMDBdIGU4MjA6
IHVwZGF0ZSBbbWVtIDB4MjBkNWYwMTgtMHgyMGQ2ZjA1N10gdXNhYmxlID09PiB1c2FibGUK
WyAgICAwLjAwMDAwMF0gZXh0ZW5kZWQgcGh5c2ljYWwgUkFNIG1hcDoKWyAgICAwLjAwMDAw
MF0gcmVzZXJ2ZSBzZXR1cF9kYXRhOiBbbWVtIDB4MDAwMDAwMDAwMDAwMDAwMC0weDAwMDAw
MDAwMDAwNTdmZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSByZXNlcnZlIHNldHVwX2RhdGE6
IFttZW0gMHgwMDAwMDAwMDAwMDU4MDAwLTB4MDAwMDAwMDAwMDA1OGZmZl0gcmVzZXJ2ZWQK
WyAgICAwLjAwMDAwMF0gcmVzZXJ2ZSBzZXR1cF9kYXRhOiBbbWVtIDB4MDAwMDAwMDAwMDA1
OTAwMC0weDAwMDAwMDAwMDAwOWRmZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSByZXNlcnZl
IHNldHVwX2RhdGE6IFttZW0gMHgwMDAwMDAwMDAwMDllMDAwLTB4MDAwMDAwMDAwMDBmZmZm
Zl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gcmVzZXJ2ZSBzZXR1cF9kYXRhOiBbbWVtIDB4
MDAwMDAwMDAwMDEwMDAwMC0weDAwMDAwMDAwMjBkNWYwMTddIHVzYWJsZQpbICAgIDAuMDAw
MDAwXSByZXNlcnZlIHNldHVwX2RhdGE6IFttZW0gMHgwMDAwMDAwMDIwZDVmMDE4LTB4MDAw
MDAwMDAyMGQ2ZjA1N10gdXNhYmxlClsgICAgMC4wMDAwMDBdIHJlc2VydmUgc2V0dXBfZGF0
YTogW21lbSAweDAwMDAwMDAwMjBkNmYwNTgtMHgwMDAwMDAwMDIyM2I1ZmZmXSB1c2FibGUK
WyAgICAwLjAwMDAwMF0gcmVzZXJ2ZSBzZXR1cF9kYXRhOiBbbWVtIDB4MDAwMDAwMDAyMjNi
NjAwMC0weDAwMDAwMDAwMjIzYjZmZmZdIEFDUEkgTlZTClsgICAgMC4wMDAwMDBdIHJlc2Vy
dmUgc2V0dXBfZGF0YTogW21lbSAweDAwMDAwMDAwMjIzYjcwMDAtMHgwMDAwMDAwMDIyM2I3
ZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSByZXNlcnZlIHNldHVwX2RhdGE6IFttZW0g
MHgwMDAwMDAwMDIyM2I4MDAwLTB4MDAwMDAwMDAzOWU5ZGZmZl0gdXNhYmxlClsgICAgMC4w
MDAwMDBdIHJlc2VydmUgc2V0dXBfZGF0YTogW21lbSAweDAwMDAwMDAwMzllOWUwMDAtMHgw
MDAwMDAwMDNhODhkZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSByZXNlcnZlIHNldHVw
X2RhdGE6IFttZW0gMHgwMDAwMDAwMDNhODhlMDAwLTB4MDAwMDAwMDAzYWY3ZGZmZl0gQUNQ
SSBOVlMKWyAgICAwLjAwMDAwMF0gcmVzZXJ2ZSBzZXR1cF9kYXRhOiBbbWVtIDB4MDAwMDAw
MDAzYWY3ZTAwMC0weDAwMDAwMDAwM2FmZmRmZmZdIEFDUEkgZGF0YQpbICAgIDAuMDAwMDAw
XSByZXNlcnZlIHNldHVwX2RhdGE6IFttZW0gMHgwMDAwMDAwMDNhZmZlMDAwLTB4MDAwMDAw
MDAzYWZmZWZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIHJlc2VydmUgc2V0dXBfZGF0YTog
W21lbSAweDAwMDAwMDAwM2FmZmYwMDAtMHgwMDAwMDAwMDNmZmZmZmZmXSByZXNlcnZlZApb
ICAgIDAuMDAwMDAwXSByZXNlcnZlIHNldHVwX2RhdGE6IFttZW0gMHgwMDAwMDAwMGUwMDAw
MDAwLTB4MDAwMDAwMDBlZmZmZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gcmVzZXJ2
ZSBzZXR1cF9kYXRhOiBbbWVtIDB4MDAwMDAwMDBmZDAwMDAwMC0weDAwMDAwMDAwZmU3ZmZm
ZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIHJlc2VydmUgc2V0dXBfZGF0YTogW21lbSAw
eDAwMDAwMDAwZmVjMDAwMDAtMHgwMDAwMDAwMGZlYzAwZmZmXSByZXNlcnZlZApbICAgIDAu
MDAwMDAwXSByZXNlcnZlIHNldHVwX2RhdGE6IFttZW0gMHgwMDAwMDAwMGZlZDAwMDAwLTB4
MDAwMDAwMDBmZWQwMGZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gcmVzZXJ2ZSBzZXR1
cF9kYXRhOiBbbWVtIDB4MDAwMDAwMDBmZWQxMDAwMC0weDAwMDAwMDAwZmVkMTlmZmZdIHJl
c2VydmVkClsgICAgMC4wMDAwMDBdIHJlc2VydmUgc2V0dXBfZGF0YTogW21lbSAweDAwMDAw
MDAwZmVkODQwMDAtMHgwMDAwMDAwMGZlZDg0ZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAw
XSByZXNlcnZlIHNldHVwX2RhdGE6IFttZW0gMHgwMDAwMDAwMGZlZTAwMDAwLTB4MDAwMDAw
MDBmZWUwMGZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gcmVzZXJ2ZSBzZXR1cF9kYXRh
OiBbbWVtIDB4MDAwMDAwMDBmZmEwMDAwMC0weDAwMDAwMDAwZmZmZmZmZmZdIHJlc2VydmVk
ClsgICAgMC4wMDAwMDBdIHJlc2VydmUgc2V0dXBfZGF0YTogW21lbSAweDAwMDAwMDAxMDAw
MDAwMDAtMHgwMDAwMDAwMmJlZmZmZmZmXSB1c2FibGUKWyAgICAwLjAwMDAwMF0gZWZpOiBF
RkkgdjIuNSBieSBJTlNZREUgQ29ycC4KWyAgICAwLjAwMDAwMF0gZWZpOiBBQ1BJIDIuMD0w
eDNhZmZkMDE0IFNNQklPUz0weDNhMTE0MDAwIFNNQklPUyAzLjA9MHgzYTExMjAwMCBFU1JU
PTB4M2ExMTA2OTggUk5HPTB4M2FmYTMwMTggVFBNRXZlbnRMb2c9MHgyM2M5YjAxOCAKWyAg
ICAwLjAwMDAwMF0gcmFuZG9tOiBjcm5nIGluaXQgZG9uZQpbICAgIDAuMDAwMDAwXSBUUE0g
RmluYWwgRXZlbnRzIHRhYmxlIG5vdCBwcmVzZW50ClsgICAgMC4wMDAwMDBdIGVmaTogUmVt
b3ZlIG1lbTQwOiBNTUlPIHJhbmdlPVsweGUwMDAwMDAwLTB4ZWZmZmZmZmZdICgyNTZNQikg
ZnJvbSBlODIwIG1hcApbICAgIDAuMDAwMDAwXSBlODIwOiByZW1vdmUgW21lbSAweGUwMDAw
MDAwLTB4ZWZmZmZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIGVmaTogUmVtb3ZlIG1l
bTQxOiBNTUlPIHJhbmdlPVsweGZkMDAwMDAwLTB4ZmU3ZmZmZmZdICgyNE1CKSBmcm9tIGU4
MjAgbWFwClsgICAgMC4wMDAwMDBdIGU4MjA6IHJlbW92ZSBbbWVtIDB4ZmQwMDAwMDAtMHhm
ZTdmZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gZWZpOiBOb3QgcmVtb3ZpbmcgbWVt
NDI6IE1NSU8gcmFuZ2U9WzB4ZmVjMDAwMDAtMHhmZWMwMGZmZl0gKDRLQikgZnJvbSBlODIw
IG1hcApbICAgIDAuMDAwMDAwXSBlZmk6IE5vdCByZW1vdmluZyBtZW00MzogTU1JTyByYW5n
ZT1bMHhmZWQwMDAwMC0weGZlZDAwZmZmXSAoNEtCKSBmcm9tIGU4MjAgbWFwClsgICAgMC4w
MDAwMDBdIGVmaTogTm90IHJlbW92aW5nIG1lbTQ0OiBNTUlPIHJhbmdlPVsweGZlZDEwMDAw
LTB4ZmVkMTlmZmZdICg0MEtCKSBmcm9tIGU4MjAgbWFwClsgICAgMC4wMDAwMDBdIGVmaTog
Tm90IHJlbW92aW5nIG1lbTQ1OiBNTUlPIHJhbmdlPVsweGZlZDg0MDAwLTB4ZmVkODRmZmZd
ICg0S0IpIGZyb20gZTgyMCBtYXAKWyAgICAwLjAwMDAwMF0gZWZpOiBOb3QgcmVtb3Zpbmcg
bWVtNDY6IE1NSU8gcmFuZ2U9WzB4ZmVlMDAwMDAtMHhmZWUwMGZmZl0gKDRLQikgZnJvbSBl
ODIwIG1hcApbICAgIDAuMDAwMDAwXSBlZmk6IFJlbW92ZSBtZW00NzogTU1JTyByYW5nZT1b
MHhmZmEwMDAwMC0weGZmZmZmZmZmXSAoNk1CKSBmcm9tIGU4MjAgbWFwClsgICAgMC4wMDAw
MDBdIGU4MjA6IHJlbW92ZSBbbWVtIDB4ZmZhMDAwMDAtMHhmZmZmZmZmZl0gcmVzZXJ2ZWQK
WyAgICAwLjAwMDAwMF0gU01CSU9TIDMuMC4wIHByZXNlbnQuClsgICAgMC4wMDAwMDBdIERN
STogQWNlciBBc3BpcmUgVk43LTU5M0cvUGx1dG9fS0xTLCBCSU9TIFYxLjExIDA4LzAxLzIw
MTgKWyAgICAwLjAwMDAwMF0gdHNjOiBEZXRlY3RlZCAyODAwLjAwMCBNSHogcHJvY2Vzc29y
ClsgICAgMC4wMDAwMDBdIHRzYzogRGV0ZWN0ZWQgMjc5OS45MjcgTUh6IFRTQwpbICAgIDAu
MDAxMzM0XSBlODIwOiB1cGRhdGUgW21lbSAweDAwMDAwMDAwLTB4MDAwMDBmZmZdIHVzYWJs
ZSA9PT4gcmVzZXJ2ZWQKWyAgICAwLjAwMTMzNl0gZTgyMDogcmVtb3ZlIFttZW0gMHgwMDBh
MDAwMC0weDAwMGZmZmZmXSB1c2FibGUKWyAgICAwLjAwMTM0NV0gbGFzdF9wZm4gPSAweDJi
ZjAwMCBtYXhfYXJjaF9wZm4gPSAweDQwMDAwMDAwMApbICAgIDAuMDAxMzQ5XSB4ODYvUEFU
OiBDb25maWd1cmF0aW9uIFswLTddOiBXQiAgV0MgIFVDLSBVQyAgV0IgIFdQICBVQy0gV1Qg
IApbICAgIDAuMDAxNjQ3XSBsYXN0X3BmbiA9IDB4M2FmZmYgbWF4X2FyY2hfcGZuID0gMHg0
MDAwMDAwMDAKWyAgICAwLjAxNDEyMV0gZXNydDogUmVzZXJ2aW5nIEVTUlQgc3BhY2UgZnJv
bSAweDAwMDAwMDAwM2ExMTA2OTggdG8gMHgwMDAwMDAwMDNhMTEwNmY4LgpbICAgIDAuMDE0
MTI5XSBVc2luZyBHQiBwYWdlcyBmb3IgZGlyZWN0IG1hcHBpbmcKWyAgICAwLjAxNDMxMV0g
U2VjdXJlIGJvb3QgZGlzYWJsZWQKWyAgICAwLjAxNDMxMl0gUkFNRElTSzogW21lbSAweDIw
ZDcwMDAwLTB4MjIxN2JmZmZdClsgICAgMC4wMTQzMTddIEFDUEk6IEVhcmx5IHRhYmxlIGNo
ZWNrc3VtIHZlcmlmaWNhdGlvbiBkaXNhYmxlZApbICAgIDAuMDE0MzE5XSBBQ1BJOiBSU0RQ
IDB4MDAwMDAwMDAzQUZGRDAxNCAwMDAwMjQgKHYwMiBBQ1JTWVMpClsgICAgMC4wMTQzMjNd
IEFDUEk6IFhTRFQgMHgwMDAwMDAwMDNBRkI1MTg4IDAwMDEyNCAodjAxIEFDUlNZUyBBQ1JQ
UkRDVCAwMDAwMDAwMCAgICAgIDAxMDAwMDEzKQpbICAgIDAuMDE0MzI4XSBBQ1BJOiBGQUNQ
IDB4MDAwMDAwMDAzQUZFNTAwMCAwMDAxMEMgKHYwNSBBQ1JTWVMgQUNSUFJEQ1QgMDAwMDAw
MDAgMTAyNSAwMDA0MDAwMCkKWyAgICAwLjAxNDMzM10gQUNQSTogRFNEVCAweDAwMDAwMDAw
M0FGQjgwMDAgMDI4RkVEICh2MDIgQUNSU1lTIEFDUlBSRENUIDAwMDAwMDAwIDEwMjUgMDAw
NDAwMDApClsgICAgMC4wMTQzMzZdIEFDUEk6IEZBQ1MgMHgwMDAwMDAwMDNBRjU0MDAwIDAw
MDA0MApbICAgIDAuMDE0MzM4XSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDAzQUZGMjAwMCAwMDUz
REQgKHYwMSBBQ1JTWVMgQUNSUFJEQ1QgMDAwMDEwMDAgMTAyNSAwMDA0MDAwMCkKWyAgICAw
LjAxNDM0MV0gQUNQSTogVFBNMiAweDAwMDAwMDAwM0FGRUUwMDAgMDAwMDM0ICh2MDMgQUNS
U1lTIEFDUlBSRENUIDAwMDAwMDAwIDEwMjUgMDAwNDAwMDApClsgICAgMC4wMTQzNDNdIEFD
UEk6IEJPT1QgMHgwMDAwMDAwMDNBRkU3MDAwIDAwMDAyOCAodjAxIEFDUlNZUyBBQ1JQUkRD
VCAwMDAwMDAwMSAxMDI1IDAwMDQwMDAwKQpbICAgIDAuMDE0MzQ1XSBBQ1BJOiBNQ0ZHIDB4
MDAwMDAwMDAzQUZFMjAwMCAwMDAwM0MgKHYwMSBBQ1JTWVMgQUNSUFJEQ1QgMDAwMDAwMDEg
MTAyNSAwMDA0MDAwMCkKWyAgICAwLjAxNDM0OF0gQUNQSTogU1NEVCAweDAwMDAwMDAwM0FG
QjMwMDAgMDAwMjg5ICh2MDIgQUNSU1lTIEFDUlBSRENUIDAwMDAwMDAwIDEwMjUgMDAwNDAw
MDApClsgICAgMC4wMTQzNTBdIEFDUEk6IERCR1AgMHgwMDAwMDAwMDNBRkFGMDAwIDAwMDAz
NCAodjAxIEFDUlNZUyBBQ1JQUkRDVCAwMDAwMDAwMiAxMDI1IDAwMDQwMDAwKQpbICAgIDAu
MDE0MzUyXSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDAzQUZBNjAwMCAwMDQ3N0UgKHYwMSBBQ1JT
WVMgQUNSUFJEQ1QgMDAwMDEwMDAgMTAyNSAwMDA0MDAwMCkKWyAgICAwLjAxNDM1NV0gQUNQ
STogVUVGSSAweDAwMDAwMDAwM0FGRkMwMDAgMDAwMjM2ICh2MDEgQUNSU1lTIEFDUlBSRENU
IDAwMDAwMDAxIDEwMjUgMDAwNDAwMDApClsgICAgMC4wMTQzNTddIEFDUEk6IFNTRFQgMHgw
MDAwMDAwMDNBRkVBMDAwIDAwMzEzMiAodjAyIEFDUlNZUyBBQ1JQUkRDVCAwMDAwMzAwMCAx
MDI1IDAwMDQwMDAwKQpbICAgIDAuMDE0MzU5XSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDAzQUZC
NzAwMCAwMDA4M0EgKHYwMiBBQ1JTWVMgQUNSUFJEQ1QgMDAwMDAwMDAgMTAyNSAwMDA0MDAw
MCkKWyAgICAwLjAxNDM2Ml0gQUNQSTogREJHMiAweDAwMDAwMDAwM0FGQUUwMDAgMDAwMDU0
ICh2MDAgQUNSU1lTIEFDUlBSRENUIDAwMDAwMDAyIDEwMjUgMDAwNDAwMDApClsgICAgMC4w
MTQzNjRdIEFDUEk6IEFQSUMgMHgwMDAwMDAwMDNBRkUzMDAwIDAwMDEyQyAodjAzIEFDUlNZ
UyBBQ1JQUkRDVCAwMDAwMDAwMSAxMDI1IDAwMDQwMDAwKQpbICAgIDAuMDE0MzY3XSBBQ1BJ
OiBGUERUIDB4MDAwMDAwMDAzQUZFMTAwMCAwMDAwNDQgKHYwMSBBQ1JTWVMgQUNSUFJEQ1Qg
MDAwMDAwMDIgMTAyNSAwMDA0MDAwMCkKWyAgICAwLjAxNDM2OV0gQUNQSTogU1NEVCAweDAw
MDAwMDAwM0FGQUIwMDAgMDAxN0FFICh2MDIgQUNSU1lTIEFDUlBSRENUIDAwMDAzMDAwIDEw
MjUgMDAwNDAwMDApClsgICAgMC4wMTQzNzFdIEFDUEk6IFVFRkkgMHgwMDAwMDAwMDNBRkY4
MDAwIDAwMDA0MiAodjAxIEFDUlNZUyBBQ1JQUkRDVCAwMDAwMDAwMiAxMDI1IDAwMDQwMDAw
KQpbICAgIDAuMDE0Mzc0XSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDAzQUZGOTAwMCAwMDI1NDYg
KHYwMSBBQ1JTWVMgQUNSUFJEQ1QgMDAwMDEwMDAgMTAyNSAwMDA0MDAwMCkKWyAgICAwLjAx
NDM3Nl0gQUNQSTogQVNGISAweDAwMDAwMDAwM0FGRTkwMDAgMDAwMEE1ICh2MzIgQUNSU1lT
IEFDUlBSRENUIDAwMDAwMDAxIDEwMjUgMDAwNDAwMDApClsgICAgMC4wMTQzNzhdIEFDUEk6
IExQSVQgMHgwMDAwMDAwMDNBRkI2MDAwIDAwMDA5NCAodjAxIEFDUlNZUyBBQ1JQUkRDVCAw
MDAwMDAwMCAxMDI1IDAwMDQwMDAwKQpbICAgIDAuMDE0MzgxXSBBQ1BJOiBTU0RUIDB4MDAw
MDAwMDAzQUZBRDAwMCAwMDBCQzcgKHYwMiBBQ1JTWVMgQUNSUFJEQ1QgMDAwMDEwMDAgMTAy
NSAwMDA0MDAwMCkKWyAgICAwLjAxNDM4M10gQUNQSTogTVNETSAweDAwMDAwMDAwM0FGRjEw
MDAgMDAwMDU1ICh2MDMgQUNSU1lTIEFDUlBSRENUIDAwMDAwMDAxIDEwMjUgMDAwNDAwMDAp
ClsgICAgMC4wMTQzODVdIEFDUEk6IFNTRFQgMHgwMDAwMDAwMDNBRkIyMDAwIDAwMDM0NiAo
djAxIEFDUlNZUyBBQ1JQUkRDVCAwMDAwMDAwMCAxMDI1IDAwMDQwMDAwKQpbICAgIDAuMDE0
Mzg4XSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDAzQUZFRjAwMCAwMDAwNDYgKHYwMiBBQ1JTWVMg
QUNSUFJEQ1QgMDAwMDMwMDAgMTAyNSAwMDA0MDAwMCkKWyAgICAwLjAxNDM5MF0gQUNQSTog
QVNQVCAweDAwMDAwMDAwM0FGRTgwMDAgMDAwMDM0ICh2MDcgQUNSU1lTIEFDUlBSRENUIDAw
MDAwMDAxIDEwMjUgMDAwNDAwMDApClsgICAgMC4wMTQzOTNdIEFDUEk6IEJHUlQgMHgwMDAw
MDAwMDNBRkE0MDAwIDAwMDAzOCAodjAxIEFDUlNZUyBBQ1JQUkRDVCAwMDAwMDAwMSAxMDI1
IDAwMDQwMDAwKQpbICAgIDAuMDE0Mzk1XSBBQ1BJOiBIUEVUIDB4MDAwMDAwMDAzQUZFNDAw
MCAwMDAwMzggKHYwMSBBQ1JTWVMgQUNSUFJEQ1QgMDAwMDAwMDEgMTAyNSAwMDA0MDAwMCkK
WyAgICAwLjAxNDM5OF0gQUNQSTogRE1BUiAweDAwMDAwMDAwM0FGQTUwMDAgMDAwMEYwICh2
MDEgQUNSU1lTIEFDUlBSRENUIDAwMDAwMDAxIDEwMjUgMDAwNDAwMDApClsgICAgMC4wMTQ0
MDBdIEFDUEk6IFdTTVQgMHgwMDAwMDAwMDNBRkI0MDAwIDAwMDAyOCAodjAxIEFDUlNZUyBB
Q1JQUkRDVCAwMDAwMDAwMCAxMDI1IDAwMDQwMDAwKQpbICAgIDAuMDE0NDAyXSBBQ1BJOiBT
U0RUIDB4MDAwMDAwMDAzQUZCMTAwMCAwMDBFNDAgKHYwMiBBQ1JTWVMgQUNSUFJEQ1QgMDAw
MDEwMDAgMTAyNSAwMDA0MDAwMCkKWyAgICAwLjAxNDQwNV0gQUNQSTogU1NEVCAweDAwMDAw
MDAwM0FGQjAwMDAgMDAwNTFFICh2MDIgQUNSU1lTIEFDUlBSRENUIDAwMDAxMDAwIDEwMjUg
MDAwNDAwMDApClsgICAgMC4wMTQ0MDddIEFDUEk6IERCR1AgMHgwMDAwMDAwMDNBRkU2MDAw
IDAwMDAzNCAodjAxIEFDUlNZUyBBQ1JQUkRDVCAwMDAwMDAwMSAxMDI1IDAwMDQwMDAwKQpb
ICAgIDAuMDE0NDA5XSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDAzQUZGMDAwMCAwMDA0QzMgKHYw
MiBBQ1JTWVMgQUNSUFJEQ1QgMDAwMDEwMDAgMTAyNSAwMDA0MDAwMCkKWyAgICAwLjAxNDQx
MV0gQUNQSTogUmVzZXJ2aW5nIEZBQ1AgdGFibGUgbWVtb3J5IGF0IFttZW0gMHgzYWZlNTAw
MC0weDNhZmU1MTBiXQpbICAgIDAuMDE0NDEzXSBBQ1BJOiBSZXNlcnZpbmcgRFNEVCB0YWJs
ZSBtZW1vcnkgYXQgW21lbSAweDNhZmI4MDAwLTB4M2FmZTBmZWNdClsgICAgMC4wMTQ0MTRd
IEFDUEk6IFJlc2VydmluZyBGQUNTIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4M2FmNTQwMDAt
MHgzYWY1NDAzZl0KWyAgICAwLjAxNDQxNF0gQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUg
bWVtb3J5IGF0IFttZW0gMHgzYWZmMjAwMC0weDNhZmY3M2RjXQpbICAgIDAuMDE0NDE1XSBB
Q1BJOiBSZXNlcnZpbmcgVFBNMiB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDNhZmVlMDAwLTB4
M2FmZWUwMzNdClsgICAgMC4wMTQ0MTZdIEFDUEk6IFJlc2VydmluZyBCT09UIHRhYmxlIG1l
bW9yeSBhdCBbbWVtIDB4M2FmZTcwMDAtMHgzYWZlNzAyN10KWyAgICAwLjAxNDQxN10gQUNQ
STogUmVzZXJ2aW5nIE1DRkcgdGFibGUgbWVtb3J5IGF0IFttZW0gMHgzYWZlMjAwMC0weDNh
ZmUyMDNiXQpbICAgIDAuMDE0NDE3XSBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJsZSBtZW1v
cnkgYXQgW21lbSAweDNhZmIzMDAwLTB4M2FmYjMyODhdClsgICAgMC4wMTQ0MThdIEFDUEk6
IFJlc2VydmluZyBEQkdQIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4M2FmYWYwMDAtMHgzYWZh
ZjAzM10KWyAgICAwLjAxNDQxOV0gQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5
IGF0IFttZW0gMHgzYWZhNjAwMC0weDNhZmFhNzdkXQpbICAgIDAuMDE0NDE5XSBBQ1BJOiBS
ZXNlcnZpbmcgVUVGSSB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDNhZmZjMDAwLTB4M2FmZmMy
MzVdClsgICAgMC4wMTQ0MjBdIEFDUEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1lbW9yeSBh
dCBbbWVtIDB4M2FmZWEwMDAtMHgzYWZlZDEzMV0KWyAgICAwLjAxNDQyMV0gQUNQSTogUmVz
ZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHgzYWZiNzAwMC0weDNhZmI3ODM5
XQpbICAgIDAuMDE0NDIxXSBBQ1BJOiBSZXNlcnZpbmcgREJHMiB0YWJsZSBtZW1vcnkgYXQg
W21lbSAweDNhZmFlMDAwLTB4M2FmYWUwNTNdClsgICAgMC4wMTQ0MjJdIEFDUEk6IFJlc2Vy
dmluZyBBUElDIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4M2FmZTMwMDAtMHgzYWZlMzEyYl0K
WyAgICAwLjAxNDQyM10gQUNQSTogUmVzZXJ2aW5nIEZQRFQgdGFibGUgbWVtb3J5IGF0IFtt
ZW0gMHgzYWZlMTAwMC0weDNhZmUxMDQzXQpbICAgIDAuMDE0NDI0XSBBQ1BJOiBSZXNlcnZp
bmcgU1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDNhZmFiMDAwLTB4M2FmYWM3YWRdClsg
ICAgMC4wMTQ0MjRdIEFDUEk6IFJlc2VydmluZyBVRUZJIHRhYmxlIG1lbW9yeSBhdCBbbWVt
IDB4M2FmZjgwMDAtMHgzYWZmODA0MV0KWyAgICAwLjAxNDQyNV0gQUNQSTogUmVzZXJ2aW5n
IFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHgzYWZmOTAwMC0weDNhZmZiNTQ1XQpbICAg
IDAuMDE0NDI2XSBBQ1BJOiBSZXNlcnZpbmcgQVNGISB0YWJsZSBtZW1vcnkgYXQgW21lbSAw
eDNhZmU5MDAwLTB4M2FmZTkwYTRdClsgICAgMC4wMTQ0MjddIEFDUEk6IFJlc2VydmluZyBM
UElUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4M2FmYjYwMDAtMHgzYWZiNjA5M10KWyAgICAw
LjAxNDQyN10gQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHgz
YWZhZDAwMC0weDNhZmFkYmM2XQpbICAgIDAuMDE0NDI4XSBBQ1BJOiBSZXNlcnZpbmcgTVNE
TSB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDNhZmYxMDAwLTB4M2FmZjEwNTRdClsgICAgMC4w
MTQ0MjldIEFDUEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4M2Fm
YjIwMDAtMHgzYWZiMjM0NV0KWyAgICAwLjAxNDQzMF0gQUNQSTogUmVzZXJ2aW5nIFNTRFQg
dGFibGUgbWVtb3J5IGF0IFttZW0gMHgzYWZlZjAwMC0weDNhZmVmMDQ1XQpbICAgIDAuMDE0
NDMwXSBBQ1BJOiBSZXNlcnZpbmcgQVNQVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDNhZmU4
MDAwLTB4M2FmZTgwMzNdClsgICAgMC4wMTQ0MzFdIEFDUEk6IFJlc2VydmluZyBCR1JUIHRh
YmxlIG1lbW9yeSBhdCBbbWVtIDB4M2FmYTQwMDAtMHgzYWZhNDAzN10KWyAgICAwLjAxNDQz
Ml0gQUNQSTogUmVzZXJ2aW5nIEhQRVQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHgzYWZlNDAw
MC0weDNhZmU0MDM3XQpbICAgIDAuMDE0NDMyXSBBQ1BJOiBSZXNlcnZpbmcgRE1BUiB0YWJs
ZSBtZW1vcnkgYXQgW21lbSAweDNhZmE1MDAwLTB4M2FmYTUwZWZdClsgICAgMC4wMTQ0MzNd
IEFDUEk6IFJlc2VydmluZyBXU01UIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4M2FmYjQwMDAt
MHgzYWZiNDAyN10KWyAgICAwLjAxNDQzNF0gQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUg
bWVtb3J5IGF0IFttZW0gMHgzYWZiMTAwMC0weDNhZmIxZTNmXQpbICAgIDAuMDE0NDM1XSBB
Q1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDNhZmIwMDAwLTB4
M2FmYjA1MWRdClsgICAgMC4wMTQ0MzVdIEFDUEk6IFJlc2VydmluZyBEQkdQIHRhYmxlIG1l
bW9yeSBhdCBbbWVtIDB4M2FmZTYwMDAtMHgzYWZlNjAzM10KWyAgICAwLjAxNDQzNl0gQUNQ
STogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHgzYWZmMDAwMC0weDNh
ZmYwNGMyXQpbICAgIDAuMDE0NDYyXSBObyBOVU1BIGNvbmZpZ3VyYXRpb24gZm91bmQKWyAg
ICAwLjAxNDQ2Ml0gRmFraW5nIGEgbm9kZSBhdCBbbWVtIDB4MDAwMDAwMDAwMDAwMDAwMC0w
eDAwMDAwMDAyYmVmZmZmZmZdClsgICAgMC4wMTQ0NjddIE5PREVfREFUQSgwKSBhbGxvY2F0
ZWQgW21lbSAweDJiZWZlOTAwMC0weDJiZWZmZmZmZl0KWyAgICAwLjAxNDQ4Nl0gWm9uZSBy
YW5nZXM6ClsgICAgMC4wMTQ0ODddICAgRE1BICAgICAgW21lbSAweDAwMDAwMDAwMDAwMDEw
MDAtMHgwMDAwMDAwMDAwZmZmZmZmXQpbICAgIDAuMDE0NDg5XSAgIERNQTMyICAgIFttZW0g
MHgwMDAwMDAwMDAxMDAwMDAwLTB4MDAwMDAwMDBmZmZmZmZmZl0KWyAgICAwLjAxNDQ5MF0g
ICBOb3JtYWwgICBbbWVtIDB4MDAwMDAwMDEwMDAwMDAwMC0weDAwMDAwMDAyYmVmZmZmZmZd
ClsgICAgMC4wMTQ0OTFdICAgRGV2aWNlICAgZW1wdHkKWyAgICAwLjAxNDQ5Ml0gTW92YWJs
ZSB6b25lIHN0YXJ0IGZvciBlYWNoIG5vZGUKWyAgICAwLjAxNDQ5NF0gRWFybHkgbWVtb3J5
IG5vZGUgcmFuZ2VzClsgICAgMC4wMTQ0OTRdICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAw
MDAwMDAxMDAwLTB4MDAwMDAwMDAwMDA1N2ZmZl0KWyAgICAwLjAxNDQ5NV0gICBub2RlICAg
MDogW21lbSAweDAwMDAwMDAwMDAwNTkwMDAtMHgwMDAwMDAwMDAwMDlkZmZmXQpbICAgIDAu
MDE0NDk2XSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDAwMDEwMDAwMC0weDAwMDAwMDAw
MjIzYjVmZmZdClsgICAgMC4wMTQ0OTddICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDIy
M2I4MDAwLTB4MDAwMDAwMDAzOWU5ZGZmZl0KWyAgICAwLjAxNDQ5OF0gICBub2RlICAgMDog
W21lbSAweDAwMDAwMDAwM2FmZmUwMDAtMHgwMDAwMDAwMDNhZmZlZmZmXQpbICAgIDAuMDE0
NDk5XSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDEwMDAwMDAwMC0weDAwMDAwMDAyYmVm
ZmZmZmZdClsgICAgMC4wMTQ1MDBdIEluaXRtZW0gc2V0dXAgbm9kZSAwIFttZW0gMHgwMDAw
MDAwMDAwMDAxMDAwLTB4MDAwMDAwMDJiZWZmZmZmZl0KWyAgICAwLjAxNDUwM10gT24gbm9k
ZSAwLCB6b25lIERNQTogMSBwYWdlcyBpbiB1bmF2YWlsYWJsZSByYW5nZXMKWyAgICAwLjAx
NDUwNV0gT24gbm9kZSAwLCB6b25lIERNQTogMSBwYWdlcyBpbiB1bmF2YWlsYWJsZSByYW5n
ZXMKWyAgICAwLjAxNDUyNV0gT24gbm9kZSAwLCB6b25lIERNQTogOTggcGFnZXMgaW4gdW5h
dmFpbGFibGUgcmFuZ2VzClsgICAgMC4wMTU2OTJdIE9uIG5vZGUgMCwgem9uZSBETUEzMjog
MiBwYWdlcyBpbiB1bmF2YWlsYWJsZSByYW5nZXMKWyAgICAwLjAxNTcyNV0gT24gbm9kZSAw
LCB6b25lIERNQTMyOiA0NDQ4IHBhZ2VzIGluIHVuYXZhaWxhYmxlIHJhbmdlcwpbICAgIDAu
MDE2MDcwXSBPbiBub2RlIDAsIHpvbmUgTm9ybWFsOiAyMDQ4MSBwYWdlcyBpbiB1bmF2YWls
YWJsZSByYW5nZXMKWyAgICAwLjAxNjEwMF0gT24gbm9kZSAwLCB6b25lIE5vcm1hbDogNDA5
NiBwYWdlcyBpbiB1bmF2YWlsYWJsZSByYW5nZXMKWyAgICAwLjAxNjEyMV0gUmVzZXJ2aW5n
IEludGVsIGdyYXBoaWNzIG1lbW9yeSBhdCBbbWVtIDB4M2MwMDAwMDAtMHgzZmZmZmZmZl0K
WyAgICAwLjAxNjQ2NV0gQUNQSTogUE0tVGltZXIgSU8gUG9ydDogMHgxODA4ClsgICAgMC4w
MTY0NzFdIEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDAxXSBoaWdoIGVkZ2UgbGludFsw
eDFdKQpbICAgIDAuMDE2NDczXSBBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgwMl0gaGln
aCBlZGdlIGxpbnRbMHgxXSkKWyAgICAwLjAxNjQ3M10gQUNQSTogTEFQSUNfTk1JIChhY3Bp
X2lkWzB4MDNdIGhpZ2ggZWRnZSBsaW50WzB4MV0pClsgICAgMC4wMTY0NzRdIEFDUEk6IExB
UElDX05NSSAoYWNwaV9pZFsweDA0XSBoaWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAuMDE2
NDc1XSBBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgwNV0gaGlnaCBlZGdlIGxpbnRbMHgx
XSkKWyAgICAwLjAxNjQ3NV0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDZdIGhpZ2gg
ZWRnZSBsaW50WzB4MV0pClsgICAgMC4wMTY0NzZdIEFDUEk6IExBUElDX05NSSAoYWNwaV9p
ZFsweDA3XSBoaWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAuMDE2NDc3XSBBQ1BJOiBMQVBJ
Q19OTUkgKGFjcGlfaWRbMHgwOF0gaGlnaCBlZGdlIGxpbnRbMHgxXSkKWyAgICAwLjAxNjQ3
N10gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDldIGhpZ2ggZWRnZSBsaW50WzB4MV0p
ClsgICAgMC4wMTY0NzhdIEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDBhXSBoaWdoIGVk
Z2UgbGludFsweDFdKQpbICAgIDAuMDE2NDc5XSBBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRb
MHgwYl0gaGlnaCBlZGdlIGxpbnRbMHgxXSkKWyAgICAwLjAxNjQ3OV0gQUNQSTogTEFQSUNf
Tk1JIChhY3BpX2lkWzB4MGNdIGhpZ2ggZWRnZSBsaW50WzB4MV0pClsgICAgMC4wMTY0ODBd
IEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDBkXSBoaWdoIGVkZ2UgbGludFsweDFdKQpb
ICAgIDAuMDE2NDgxXSBBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgwZV0gaGlnaCBlZGdl
IGxpbnRbMHgxXSkKWyAgICAwLjAxNjQ4MV0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4
MGZdIGhpZ2ggZWRnZSBsaW50WzB4MV0pClsgICAgMC4wMTY0ODJdIEFDUEk6IExBUElDX05N
SSAoYWNwaV9pZFsweDEwXSBoaWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAuMDE2NTA5XSBJ
T0FQSUNbMF06IGFwaWNfaWQgMiwgdmVyc2lvbiAzMiwgYWRkcmVzcyAweGZlYzAwMDAwLCBH
U0kgMC0xMTkKWyAgICAwLjAxNjUxMV0gQUNQSTogSU5UX1NSQ19PVlIgKGJ1cyAwIGJ1c19p
cnEgMCBnbG9iYWxfaXJxIDIgZGZsIGRmbCkKWyAgICAwLjAxNjUxM10gQUNQSTogSU5UX1NS
Q19PVlIgKGJ1cyAwIGJ1c19pcnEgOSBnbG9iYWxfaXJxIDkgaGlnaCBsZXZlbCkKWyAgICAw
LjAxNjUxN10gQUNQSTogVXNpbmcgQUNQSSAoTUFEVCkgZm9yIFNNUCBjb25maWd1cmF0aW9u
IGluZm9ybWF0aW9uClsgICAgMC4wMTY1MThdIEFDUEk6IEhQRVQgaWQ6IDB4ODA4NmEyMDEg
YmFzZTogMHhmZWQwMDAwMApbICAgIDAuMDE2NTIzXSBlODIwOiB1cGRhdGUgW21lbSAweDJh
ODNjMDAwLTB4MmE4OThmZmZdIHVzYWJsZSA9PT4gcmVzZXJ2ZWQKWyAgICAwLjAxNjUzNF0g
VFNDIGRlYWRsaW5lIHRpbWVyIGF2YWlsYWJsZQpbICAgIDAuMDE2NTM0XSBzbXBib290OiBB
bGxvd2luZyA4IENQVXMsIDAgaG90cGx1ZyBDUFVzClsgICAgMC4wMTY1NDldIFBNOiBoaWJl
cm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4MDAwMDAwMDAtMHgw
MDAwMGZmZl0KWyAgICAwLjAxNjU1MV0gUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5v
c2F2ZSBtZW1vcnk6IFttZW0gMHgwMDA1ODAwMC0weDAwMDU4ZmZmXQpbICAgIDAuMDE2NTUz
XSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDAw
MDllMDAwLTB4MDAwZmZmZmZdClsgICAgMC4wMTY1NTRdIFBNOiBoaWJlcm5hdGlvbjogUmVn
aXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4MjBkNWYwMDAtMHgyMGQ1ZmZmZl0KWyAg
ICAwLjAxNjU1Nl0gUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6
IFttZW0gMHgyMGQ2ZjAwMC0weDIwZDZmZmZmXQpbICAgIDAuMDE2NTU3XSBQTTogaGliZXJu
YXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDIyM2I2MDAwLTB4MjIz
YjZmZmZdClsgICAgMC4wMTY1NThdIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3Nh
dmUgbWVtb3J5OiBbbWVtIDB4MjIzYjcwMDAtMHgyMjNiN2ZmZl0KWyAgICAwLjAxNjU1OV0g
UE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHgyYTgz
YzAwMC0weDJhODk4ZmZmXQpbICAgIDAuMDE2NTYxXSBQTTogaGliZXJuYXRpb246IFJlZ2lz
dGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDM5ZTllMDAwLTB4M2E4OGRmZmZdClsgICAg
MC4wMTY1NjFdIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBb
bWVtIDB4M2E4OGUwMDAtMHgzYWY3ZGZmZl0KWyAgICAwLjAxNjU2Ml0gUE06IGhpYmVybmF0
aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHgzYWY3ZTAwMC0weDNhZmZk
ZmZmXQpbICAgIDAuMDE2NTYzXSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZl
IG1lbW9yeTogW21lbSAweDNhZmZmMDAwLTB4M2ZmZmZmZmZdClsgICAgMC4wMTY1NjRdIFBN
OiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4NDAwMDAw
MDAtMHhmZWJmZmZmZl0KWyAgICAwLjAxNjU2NV0gUE06IGhpYmVybmF0aW9uOiBSZWdpc3Rl
cmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHhmZWMwMDAwMC0weGZlYzAwZmZmXQpbICAgIDAu
MDE2NTY1XSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21l
bSAweGZlYzAxMDAwLTB4ZmVjZmZmZmZdClsgICAgMC4wMTY1NjZdIFBNOiBoaWJlcm5hdGlv
bjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4ZmVkMDAwMDAtMHhmZWQwMGZm
Zl0KWyAgICAwLjAxNjU2N10gUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBt
ZW1vcnk6IFttZW0gMHhmZWQwMTAwMC0weGZlZDBmZmZmXQpbICAgIDAuMDE2NTY3XSBQTTog
aGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweGZlZDEwMDAw
LTB4ZmVkMTlmZmZdClsgICAgMC4wMTY1NjhdIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJl
ZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4ZmVkMWEwMDAtMHhmZWQ4M2ZmZl0KWyAgICAwLjAx
NjU2OV0gUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0g
MHhmZWQ4NDAwMC0weGZlZDg0ZmZmXQpbICAgIDAuMDE2NTY5XSBQTTogaGliZXJuYXRpb246
IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweGZlZDg1MDAwLTB4ZmVkZmZmZmZd
ClsgICAgMC4wMTY1NzBdIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVt
b3J5OiBbbWVtIDB4ZmVlMDAwMDAtMHhmZWUwMGZmZl0KWyAgICAwLjAxNjU3MF0gUE06IGhp
YmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHhmZWUwMTAwMC0w
eGZmZmZmZmZmXQpbICAgIDAuMDE2NTcyXSBbbWVtIDB4NDAwMDAwMDAtMHhmZWJmZmZmZl0g
YXZhaWxhYmxlIGZvciBQQ0kgZGV2aWNlcwpbICAgIDAuMDE2NTc0XSBjbG9ja3NvdXJjZTog
cmVmaW5lZC1qaWZmaWVzOiBtYXNrOiAweGZmZmZmZmZmIG1heF9jeWNsZXM6IDB4ZmZmZmZm
ZmYsIG1heF9pZGxlX25zOiAxOTEwOTY5OTQwMzkxNDE5IG5zClsgICAgMC4wMjA5ODBdIHNl
dHVwX3BlcmNwdTogTlJfQ1BVUzoxNiBucl9jcHVtYXNrX2JpdHM6OCBucl9jcHVfaWRzOjgg
bnJfbm9kZV9pZHM6MQpbICAgIDAuMDIxMjUyXSBwZXJjcHU6IEVtYmVkZGVkIDQ4IHBhZ2Vz
L2NwdSBzMTU5NjU2IHI4MTkyIGQyODc2MCB1MjYyMTQ0ClsgICAgMC4wMjEyNThdIHBjcHUt
YWxsb2M6IHMxNTk2NTYgcjgxOTIgZDI4NzYwIHUyNjIxNDQgYWxsb2M9MSoyMDk3MTUyClsg
ICAgMC4wMjEyNjBdIHBjcHUtYWxsb2M6IFswXSAwIDEgMiAzIDQgNSA2IDcgClsgICAgMC4w
MjEyNzZdIEtlcm5lbCBjb21tYW5kIGxpbmU6IEJPT1RfSU1BR0U9L2Jvb3Qvdm1saW51ei02
LjQuMC1kZXNrdG9wLWFjZXJmYW4rIHJvb3Q9VVVJRD0wODc0NmUyNi00MzVjLTQ5ZTEtYTUy
Mi0xOGRiYTYyMjkyMzkgc3BsYXNoPXNpbGVudCByZXN1bWU9L2Rldi9kaXNrL2J5LXV1aWQv
MzM5ZjIyMTMtYzBlZS00NTRhLTk5NjUtYmU5MDJlZWZlN2Y0IG5vdXZlYXUudnJhbV9wdXNo
YnVmPTEgYWNwaV9vc2k9ISAiYWNwaV9vc2k9V2luZG93cyAyMDE1IiBub3V2ZWF1LmhkbWlt
aHo9NjAwIG5vdXZlYXUuZGVidWc9aW5mbyBub3V2ZWF1LmF0b21pYz0xIG1pdGlnYXRpb25z
PWF1dG8KWyAgICAwLjAyMTM1NV0gVW5rbm93biBrZXJuZWwgY29tbWFuZCBsaW5lIHBhcmFt
ZXRlcnMgIkJPT1RfSU1BR0U9L2Jvb3Qvdm1saW51ei02LjQuMC1kZXNrdG9wLWFjZXJmYW4r
IHNwbGFzaD1zaWxlbnQiLCB3aWxsIGJlIHBhc3NlZCB0byB1c2VyIHNwYWNlLgpbICAgIDAu
MDIxMzkxXSBwcmludGs6IGxvZ19idWZfbGVuIGluZGl2aWR1YWwgbWF4IGNwdSBjb250cmli
dXRpb246IDMyNzY4IGJ5dGVzClsgICAgMC4wMjEzOTJdIHByaW50azogbG9nX2J1Zl9sZW4g
dG90YWwgY3B1X2V4dHJhIGNvbnRyaWJ1dGlvbnM6IDIyOTM3NiBieXRlcwpbICAgIDAuMDIx
MzkzXSBwcmludGs6IGxvZ19idWZfbGVuIG1pbiBzaXplOiAyNjIxNDQgYnl0ZXMKWyAgICAw
LjAyMTczN10gcHJpbnRrOiBsb2dfYnVmX2xlbjogNTI0Mjg4IGJ5dGVzClsgICAgMC4wMjE3
MzhdIHByaW50azogZWFybHkgbG9nIGJ1ZiBmcmVlOiAyNDMyMzIoOTIlKQpbICAgIDAuMDIy
Mzc4XSBEZW50cnkgY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAxMDQ4NTc2IChvcmRlcjog
MTEsIDgzODg2MDggYnl0ZXMsIGxpbmVhcikKWyAgICAwLjAyMjcwMl0gSW5vZGUtY2FjaGUg
aGFzaCB0YWJsZSBlbnRyaWVzOiA1MjQyODggKG9yZGVyOiAxMCwgNDE5NDMwNCBieXRlcywg
bGluZWFyKQpbICAgIDAuMDIyNzg1XSBGYWxsYmFjayBvcmRlciBmb3IgTm9kZSAwOiAwIApb
ICAgIDAuMDIyNzg3XSBCdWlsdCAxIHpvbmVsaXN0cywgbW9iaWxpdHkgZ3JvdXBpbmcgb24u
ICBUb3RhbCBwYWdlczogMjAzNTU1NApbICAgIDAuMDIyNzg4XSBQb2xpY3kgem9uZTogTm9y
bWFsClsgICAgMC4wMjI3ODldIG1lbSBhdXRvLWluaXQ6IHN0YWNrOm9mZiwgaGVhcCBhbGxv
YzpvZmYsIGhlYXAgZnJlZTpvZmYKWyAgICAwLjAyMjc5NV0gc29mdHdhcmUgSU8gVExCOiBh
cmVhIG51bSA4LgpbICAgIDAuMDM3MTM1XSBNZW1vcnk6IDkzNDM5MksvODI3MjEwMEsgYXZh
aWxhYmxlICgxMjI4OEsga2VybmVsIGNvZGUsIDE2NDFLIHJ3ZGF0YSwgMjE2OEsgcm9kYXRh
LCAxNDQ0SyBpbml0LCAxMjk2SyBic3MsIDMxNzY3NksgcmVzZXJ2ZWQsIDBLIGNtYS1yZXNl
cnZlZCkKWyAgICAwLjAzNzIzMF0gU0xVQjogSFdhbGlnbj02NCwgT3JkZXI9MC0zLCBNaW5P
YmplY3RzPTAsIENQVXM9OCwgTm9kZXM9MQpbICAgIDAuMDM3MjM3XSBLZXJuZWwvVXNlciBw
YWdlIHRhYmxlcyBpc29sYXRpb246IGVuYWJsZWQKWyAgICAwLjAzNzI5OF0gcmN1OiBQcmVl
bXB0aWJsZSBoaWVyYXJjaGljYWwgUkNVIGltcGxlbWVudGF0aW9uLgpbICAgIDAuMDM3Mjk5
XSByY3U6IAlSQ1UgcmVzdHJpY3RpbmcgQ1BVcyBmcm9tIE5SX0NQVVM9MTYgdG8gbnJfY3B1
X2lkcz04LgpbICAgIDAuMDM3MzAwXSAJVHJhbXBvbGluZSB2YXJpYW50IG9mIFRhc2tzIFJD
VSBlbmFibGVkLgpbICAgIDAuMDM3MzAwXSAJVHJhY2luZyB2YXJpYW50IG9mIFRhc2tzIFJD
VSBlbmFibGVkLgpbICAgIDAuMDM3MzAxXSByY3U6IFJDVSBjYWxjdWxhdGVkIHZhbHVlIG9m
IHNjaGVkdWxlci1lbmxpc3RtZW50IGRlbGF5IGlzIDEwMCBqaWZmaWVzLgpbICAgIDAuMDM3
MzAyXSByY3U6IEFkanVzdGluZyBnZW9tZXRyeSBmb3IgcmN1X2Zhbm91dF9sZWFmPTE2LCBu
cl9jcHVfaWRzPTgKWyAgICAwLjAzNzMyMF0gTlJfSVJRUzogNDM1MiwgbnJfaXJxczogMjA0
OCwgcHJlYWxsb2NhdGVkIGlycXM6IDE2ClsgICAgMC4wMzc1MTBdIHJjdTogc3JjdV9pbml0
OiBTZXR0aW5nIHNyY3Vfc3RydWN0IHNpemVzIGJhc2VkIG9uIGNvbnRlbnRpb24uClsgICAg
MC4wMzc2NzBdIENvbnNvbGU6IGNvbG91ciBkdW1teSBkZXZpY2UgODB4MjUKWyAgICAwLjAz
NzY3Ml0gcHJpbnRrOiBjb25zb2xlIFt0dHkwXSBlbmFibGVkClsgICAgMC4wMzgxNDhdIEFD
UEk6IENvcmUgcmV2aXNpb24gMjAyMzAzMzEKWyAgICAwLjAzODQ1Ml0gY2xvY2tzb3VyY2U6
IGhwZXQ6IG1hc2s6IDB4ZmZmZmZmZmYgbWF4X2N5Y2xlczogMHhmZmZmZmZmZiwgbWF4X2lk
bGVfbnM6IDc5NjM1ODU1MjQ1IG5zClsgICAgMC4wMzg1MjVdIEFQSUM6IFN3aXRjaCB0byBz
eW1tZXRyaWMgSS9PIG1vZGUgc2V0dXAKWyAgICAwLjAzODUyOF0gRE1BUjogSG9zdCBhZGRy
ZXNzIHdpZHRoIDM5ClsgICAgMC4wMzg1MzBdIERNQVI6IERSSEQgYmFzZTogMHgwMDAwMDBm
ZWQ5MDAwMCBmbGFnczogMHgwClsgICAgMC4wMzg1MzddIERNQVI6IGRtYXIwOiByZWdfYmFz
ZV9hZGRyIGZlZDkwMDAwIHZlciAxOjAgY2FwIDFjMDAwMGM0MDY2MDQ2MiBlY2FwIDE5ZTJm
ZjA1MDVlClsgICAgMC4wMzg1NDFdIERNQVI6IERSSEQgYmFzZTogMHgwMDAwMDBmZWQ5MTAw
MCBmbGFnczogMHgxClsgICAgMC4wMzg1NDZdIERNQVI6IGRtYXIxOiByZWdfYmFzZV9hZGRy
IGZlZDkxMDAwIHZlciAxOjAgY2FwIGQyMDA4YzQwNjYwNDYyIGVjYXAgZjA1MGRhClsgICAg
MC4wMzg1NTBdIERNQVI6IFJNUlIgYmFzZTogMHgwMDAwMDAzYTc2NjAwMCBlbmQ6IDB4MDAw
MDAwM2E3ODVmZmYKWyAgICAwLjAzODU1M10gRE1BUjogUk1SUiBiYXNlOiAweDAwMDAwMDNi
ODAwMDAwIGVuZDogMHgwMDAwMDAzZmZmZmZmZgpbICAgIDAuMDM4NTU1XSBETUFSOiBBTkRE
IGRldmljZTogMSBuYW1lOiBcX1NCLlBDSTAuSTJDMApbICAgIDAuMDM4NTU4XSBETUFSOiBB
TkREIGRldmljZTogMiBuYW1lOiBcX1NCLlBDSTAuSTJDMQpbICAgIDAuMDM4NTYxXSBETUFS
LUlSOiBJT0FQSUMgaWQgMiB1bmRlciBEUkhEIGJhc2UgIDB4ZmVkOTEwMDAgSU9NTVUgMQpb
ICAgIDAuMDM4NTYzXSBETUFSLUlSOiBIUEVUIGlkIDAgdW5kZXIgRFJIRCBiYXNlIDB4ZmVk
OTEwMDAKWyAgICAwLjAzODU2Nl0gRE1BUi1JUjogUXVldWVkIGludmFsaWRhdGlvbiB3aWxs
IGJlIGVuYWJsZWQgdG8gc3VwcG9ydCB4MmFwaWMgYW5kIEludHItcmVtYXBwaW5nLgpbICAg
IDAuMDQwMTU2XSBETUFSLUlSOiBFbmFibGVkIElSUSByZW1hcHBpbmcgaW4geDJhcGljIG1v
ZGUKWyAgICAwLjA0MDE1OV0geDJhcGljIGVuYWJsZWQKWyAgICAwLjA0MDE3MV0gU3dpdGNo
ZWQgQVBJQyByb3V0aW5nIHRvIGNsdXN0ZXIgeDJhcGljLgpbICAgIDAuMDQ0MjAyXSAuLlRJ
TUVSOiB2ZWN0b3I9MHgzMCBhcGljMT0wIHBpbjE9MiBhcGljMj0tMSBwaW4yPS0xClsgICAg
MC4wNDg1MjRdIGNsb2Nrc291cmNlOiB0c2MtZWFybHk6IG1hc2s6IDB4ZmZmZmZmZmZmZmZm
ZmZmZiBtYXhfY3ljbGVzOiAweDI4NWJmYmFmYWQyLCBtYXhfaWRsZV9uczogNDQwNzk1MjE1
NTMwIG5zClsgICAgMC4wNDg1MzFdIENhbGlicmF0aW5nIGRlbGF5IGxvb3AgKHNraXBwZWQp
LCB2YWx1ZSBjYWxjdWxhdGVkIHVzaW5nIHRpbWVyIGZyZXF1ZW5jeS4uIDU1OTkuODUgQm9n
b01JUFMgKGxwaj0yNzk5OTI3KQpbICAgIDAuMDQ4NTM2XSBwaWRfbWF4OiBkZWZhdWx0OiAz
Mjc2OCBtaW5pbXVtOiAzMDEKWyAgICAwLjA1MDU1Nl0gTFNNOiBpbml0aWFsaXppbmcgbHNt
PWxvY2tkb3duLGNhcGFiaWxpdHksYXBwYXJtb3IsaW50ZWdyaXR5ClsgICAgMC4wNTA1ODNd
IEFwcEFybW9yOiBBcHBBcm1vciBpbml0aWFsaXplZApbICAgIDAuMDUwNjA5XSBNb3VudC1j
YWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjogNSwgMTMxMDcyIGJ5dGVz
LCBsaW5lYXIpClsgICAgMC4wNTA2MjNdIE1vdW50cG9pbnQtY2FjaGUgaGFzaCB0YWJsZSBl
bnRyaWVzOiAxNjM4NCAob3JkZXI6IDUsIDEzMTA3MiBieXRlcywgbGluZWFyKQpbICAgIDAu
MDUwNzg3XSBDUFUwOiBUaGVybWFsIG1vbml0b3JpbmcgZW5hYmxlZCAoVE0xKQpbICAgIDAu
MDUwODM5XSBwcm9jZXNzOiB1c2luZyBtd2FpdCBpbiBpZGxlIHRocmVhZHMKWyAgICAwLjA1
MDg0NF0gTGFzdCBsZXZlbCBpVExCIGVudHJpZXM6IDRLQiA2NCwgMk1CIDgsIDRNQiA4Clsg
ICAgMC4wNTA4NDZdIExhc3QgbGV2ZWwgZFRMQiBlbnRyaWVzOiA0S0IgNjQsIDJNQiAwLCA0
TUIgMCwgMUdCIDQKWyAgICAwLjA1MDg1M10gU3BlY3RyZSBWMSA6IE1pdGlnYXRpb246IHVz
ZXJjb3B5L3N3YXBncyBiYXJyaWVycyBhbmQgX191c2VyIHBvaW50ZXIgc2FuaXRpemF0aW9u
ClsgICAgMC4wNTA4NThdIFNwZWN0cmUgVjIgOiBNaXRpZ2F0aW9uOiBSZXRwb2xpbmVzClsg
ICAgMC4wNTA4NjBdIFNwZWN0cmUgVjIgOiBTcGVjdHJlIHYyIC8gU3BlY3RyZVJTQiBtaXRp
Z2F0aW9uOiBGaWxsaW5nIFJTQiBvbiBjb250ZXh0IHN3aXRjaApbICAgIDAuMDUwODYzXSBT
cGVjdHJlIFYyIDogU3BlY3RyZSB2MiAvIFNwZWN0cmVSU0IgOiBGaWxsaW5nIFJTQiBvbiBW
TUVYSVQKWyAgICAwLjA1MDg2NV0gU3BlY3RyZSBWMiA6IEVuYWJsaW5nIFJlc3RyaWN0ZWQg
U3BlY3VsYXRpb24gZm9yIGZpcm13YXJlIGNhbGxzClsgICAgMC4wNTA4NjhdIFJFVEJsZWVk
OiBXQVJOSU5HOiBTcGVjdHJlIHYyIG1pdGlnYXRpb24gbGVhdmVzIENQVSB2dWxuZXJhYmxl
IHRvIFJFVEJsZWVkIGF0dGFja3MsIGRhdGEgbGVha3MgcG9zc2libGUhClsgICAgMC4wNTA4
NzFdIFJFVEJsZWVkOiBWdWxuZXJhYmxlClsgICAgMC4wNTA4NzRdIFNwZWN0cmUgVjIgOiBt
aXRpZ2F0aW9uOiBFbmFibGluZyBjb25kaXRpb25hbCBJbmRpcmVjdCBCcmFuY2ggUHJlZGlj
dGlvbiBCYXJyaWVyClsgICAgMC4wNTA4NzddIFNwZWN0cmUgVjIgOiBVc2VyIHNwYWNlOiBN
aXRpZ2F0aW9uOiBTVElCUCB2aWEgcHJjdGwKWyAgICAwLjA1MDg4MF0gU3BlY3VsYXRpdmUg
U3RvcmUgQnlwYXNzOiBNaXRpZ2F0aW9uOiBTcGVjdWxhdGl2ZSBTdG9yZSBCeXBhc3MgZGlz
YWJsZWQgdmlhIHByY3RsClsgICAgMC4wNTA4OTBdIE1EUzogTWl0aWdhdGlvbjogQ2xlYXIg
Q1BVIGJ1ZmZlcnMKWyAgICAwLjA1MDg5Ml0gTU1JTyBTdGFsZSBEYXRhOiBNaXRpZ2F0aW9u
OiBDbGVhciBDUFUgYnVmZmVycwpbICAgIDAuMDUwOTAwXSBTUkJEUzogTWl0aWdhdGlvbjog
TWljcm9jb2RlClsgICAgMC4wNTIzMjJdIEZyZWVpbmcgU01QIGFsdGVybmF0aXZlcyBtZW1v
cnk6IDM2SwpbICAgIDAuMDUzNTU1XSBzbXBib290OiBDUFUwOiBJbnRlbChSKSBDb3JlKFRN
KSBpNy03NzAwSFEgQ1BVIEAgMi44MEdIeiAoZmFtaWx5OiAweDYsIG1vZGVsOiAweDllLCBz
dGVwcGluZzogMHg5KQpbICAgIDAuMDUzNjYxXSBjYmxpc3RfaW5pdF9nZW5lcmljOiBTZXR0
aW5nIGFkanVzdGFibGUgbnVtYmVyIG9mIGNhbGxiYWNrIHF1ZXVlcy4KWyAgICAwLjA1MzY2
NV0gY2JsaXN0X2luaXRfZ2VuZXJpYzogU2V0dGluZyBzaGlmdCB0byAzIGFuZCBsaW0gdG8g
MS4KWyAgICAwLjA1MzY3N10gY2JsaXN0X2luaXRfZ2VuZXJpYzogU2V0dGluZyBzaGlmdCB0
byAzIGFuZCBsaW0gdG8gMS4KWyAgICAwLjA1MzY4OF0gUGVyZm9ybWFuY2UgRXZlbnRzOiBQ
RUJTIGZtdDMrLCBTa3lsYWtlIGV2ZW50cywgMzItZGVlcCBMQlIsIGZ1bGwtd2lkdGggY291
bnRlcnMsIEludGVsIFBNVSBkcml2ZXIuClsgICAgMC4wNTM3MTJdIC4uLiB2ZXJzaW9uOiAg
ICAgICAgICAgICAgICA0ClsgICAgMC4wNTM3MTRdIC4uLiBiaXQgd2lkdGg6ICAgICAgICAg
ICAgICA0OApbICAgIDAuMDUzNzE2XSAuLi4gZ2VuZXJpYyByZWdpc3RlcnM6ICAgICAgNApb
ICAgIDAuMDUzNzE3XSAuLi4gdmFsdWUgbWFzazogICAgICAgICAgICAgMDAwMGZmZmZmZmZm
ZmZmZgpbICAgIDAuMDUzNzIwXSAuLi4gbWF4IHBlcmlvZDogICAgICAgICAgICAgMDAwMDdm
ZmZmZmZmZmZmZgpbICAgIDAuMDUzNzIyXSAuLi4gZml4ZWQtcHVycG9zZSBldmVudHM6ICAg
MwpbICAgIDAuMDUzNzI0XSAuLi4gZXZlbnQgbWFzazogICAgICAgICAgICAgMDAwMDAwMDcw
MDAwMDAwZgpbICAgIDAuMDUzODM2XSBFc3RpbWF0ZWQgcmF0aW8gb2YgYXZlcmFnZSBtYXgg
ZnJlcXVlbmN5IGJ5IGJhc2UgZnJlcXVlbmN5ICh0aW1lcyAxMDI0KTogMTI0MwpbICAgIDAu
MDUzODUzXSByY3U6IEhpZXJhcmNoaWNhbCBTUkNVIGltcGxlbWVudGF0aW9uLgpbICAgIDAu
MDUzODU2XSByY3U6IAlNYXggcGhhc2Ugbm8tZGVsYXkgaW5zdGFuY2VzIGlzIDQwMC4KWyAg
ICAwLjA1NDMwNV0gTk1JIHdhdGNoZG9nOiBFbmFibGVkLiBQZXJtYW5lbnRseSBjb25zdW1l
cyBvbmUgaHctUE1VIGNvdW50ZXIuClsgICAgMC4wNTQzNjZdIHNtcDogQnJpbmdpbmcgdXAg
c2Vjb25kYXJ5IENQVXMgLi4uClsgICAgMC4wNTQ0MzJdIHg4NjogQm9vdGluZyBTTVAgY29u
ZmlndXJhdGlvbjoKWyAgICAwLjA1NDQzNF0gLi4uLiBub2RlICAjMCwgQ1BVczogICAgICAj
MSAjMiAjMyAjNApbICAgIDAuMDYxNjAwXSBNRFMgQ1BVIGJ1ZyBwcmVzZW50IGFuZCBTTVQg
b24sIGRhdGEgbGVhayBwb3NzaWJsZS4gU2VlIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9j
L2h0bWwvbGF0ZXN0L2FkbWluLWd1aWRlL2h3LXZ1bG4vbWRzLmh0bWwgZm9yIG1vcmUgZGV0
YWlscy4KWyAgICAwLjA2MTYwMF0gTU1JTyBTdGFsZSBEYXRhIENQVSBidWcgcHJlc2VudCBh
bmQgU01UIG9uLCBkYXRhIGxlYWsgcG9zc2libGUuIFNlZSBodHRwczovL3d3dy5rZXJuZWwu
b3JnL2RvYy9odG1sL2xhdGVzdC9hZG1pbi1ndWlkZS9ody12dWxuL3Byb2Nlc3Nvcl9tbWlv
X3N0YWxlX2RhdGEuaHRtbCBmb3IgbW9yZSBkZXRhaWxzLgpbICAgIDAuMDYxNjM0XSAgIzUg
IzYgIzcKWyAgICAwLjA2Mjk4Ml0gc21wOiBCcm91Z2h0IHVwIDEgbm9kZSwgOCBDUFVzClsg
ICAgMC4wNjI5ODJdIHNtcGJvb3Q6IE1heCBsb2dpY2FsIHBhY2thZ2VzOiAxClsgICAgMC4w
NjI5ODJdIHNtcGJvb3Q6IFRvdGFsIG9mIDggcHJvY2Vzc29ycyBhY3RpdmF0ZWQgKDQ0Nzk4
LjgzIEJvZ29NSVBTKQpbICAgIDAuMDcxNjUyXSBub2RlIDAgZGVmZXJyZWQgcGFnZXMgaW5p
dGlhbGlzZWQgaW4gOW1zClsgICAgMC4wNzI3NDZdIGRldnRtcGZzOiBpbml0aWFsaXplZApb
ICAgIDAuMDcyNzQ2XSB4ODYvbW06IE1lbW9yeSBibG9jayBzaXplOiAxMjhNQgpbICAgIDAu
MDczNTQxXSBBQ1BJOiBQTTogUmVnaXN0ZXJpbmcgQUNQSSBOVlMgcmVnaW9uIFttZW0gMHgy
MjNiNjAwMC0weDIyM2I2ZmZmXSAoNDA5NiBieXRlcykKWyAgICAwLjA3MzU0Nl0gQUNQSTog
UE06IFJlZ2lzdGVyaW5nIEFDUEkgTlZTIHJlZ2lvbiBbbWVtIDB4M2E4OGUwMDAtMHgzYWY3
ZGZmZl0gKDcyNzQ0OTYgYnl0ZXMpClsgICAgMC4wNzM2NTJdIGNsb2Nrc291cmNlOiBqaWZm
aWVzOiBtYXNrOiAweGZmZmZmZmZmIG1heF9jeWNsZXM6IDB4ZmZmZmZmZmYsIG1heF9pZGxl
X25zOiAxOTExMjYwNDQ2Mjc1MDAwIG5zClsgICAgMC4wNzM2NTddIGZ1dGV4IGhhc2ggdGFi
bGUgZW50cmllczogMjA0OCAob3JkZXI6IDUsIDEzMTA3MiBieXRlcywgbGluZWFyKQpbICAg
IDAuMDczNjk5XSBwaW5jdHJsIGNvcmU6IGluaXRpYWxpemVkIHBpbmN0cmwgc3Vic3lzdGVt
ClsgICAgMC4wNzM4NjRdIFBNOiBSVEMgdGltZTogMjA6MTE6MTcsIGRhdGU6IDIwMjMtMDct
MTEKWyAgICAwLjA3NDIyNV0gTkVUOiBSZWdpc3RlcmVkIFBGX05FVExJTksvUEZfUk9VVEUg
cHJvdG9jb2wgZmFtaWx5ClsgICAgMC4wNzQzMDRdIGF1ZGl0OiBpbml0aWFsaXppbmcgbmV0
bGluayBzdWJzeXMgKGRpc2FibGVkKQpbICAgIDAuMDc0MzExXSBhdWRpdDogdHlwZT0yMDAw
IGF1ZGl0KDE2ODkxMDYyNzcuMDMyOjEpOiBzdGF0ZT1pbml0aWFsaXplZCBhdWRpdF9lbmFi
bGVkPTAgcmVzPTEKWyAgICAwLjA3NDMxMV0gdGhlcm1hbF9zeXM6IFJlZ2lzdGVyZWQgdGhl
cm1hbCBnb3Zlcm5vciAnZmFpcl9zaGFyZScKWyAgICAwLjA3NDMxMV0gdGhlcm1hbF9zeXM6
IFJlZ2lzdGVyZWQgdGhlcm1hbCBnb3Zlcm5vciAnYmFuZ19iYW5nJwpbICAgIDAuMDc0MzEx
XSB0aGVybWFsX3N5czogUmVnaXN0ZXJlZCB0aGVybWFsIGdvdmVybm9yICdzdGVwX3dpc2Un
ClsgICAgMC4wNzQzMTFdIHRoZXJtYWxfc3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwgZ292ZXJu
b3IgJ3VzZXJfc3BhY2UnClsgICAgMC4wNzQzMTFdIGNwdWlkbGU6IHVzaW5nIGdvdmVybm9y
IGxhZGRlcgpbICAgIDAuMDc0MzExXSBjcHVpZGxlOiB1c2luZyBnb3Zlcm5vciBtZW51Clsg
ICAgMC4wNzQzMTFdIFNpbXBsZSBCb290IEZsYWcgYXQgMHg0NCBzZXQgdG8gMHg4MApbICAg
IDAuMDc0MzExXSBBQ1BJIEZBRFQgZGVjbGFyZXMgdGhlIHN5c3RlbSBkb2Vzbid0IHN1cHBv
cnQgUENJZSBBU1BNLCBzbyBkaXNhYmxlIGl0ClsgICAgMC4wNzQzMTFdIGFjcGlwaHA6IEFD
UEkgSG90IFBsdWcgUENJIENvbnRyb2xsZXIgRHJpdmVyIHZlcnNpb246IDAuNQpbICAgIDAu
MDc0NTc4XSBQQ0k6IE1NQ09ORklHIGZvciBkb21haW4gMDAwMCBbYnVzIDAwLWZmXSBhdCBb
bWVtIDB4ZTAwMDAwMDAtMHhlZmZmZmZmZl0gKGJhc2UgMHhlMDAwMDAwMCkKWyAgICAwLjA3
NDU4NV0gUENJOiBub3QgdXNpbmcgTU1DT05GSUcKWyAgICAwLjA3NDU4N10gUENJOiBVc2lu
ZyBjb25maWd1cmF0aW9uIHR5cGUgMSBmb3IgYmFzZSBhY2Nlc3MKWyAgICAwLjA3NDc4MV0g
RU5FUkdZX1BFUkZfQklBUzogU2V0IHRvICdub3JtYWwnLCB3YXMgJ3BlcmZvcm1hbmNlJwpb
ICAgIDAuMDc0Nzg5XSBIdWdlVExCOiByZWdpc3RlcmVkIDEuMDAgR2lCIHBhZ2Ugc2l6ZSwg
cHJlLWFsbG9jYXRlZCAwIHBhZ2VzClsgICAgMC4wNzQ3ODldIEh1Z2VUTEI6IDE2MzgwIEtp
QiB2bWVtbWFwIGNhbiBiZSBmcmVlZCBmb3IgYSAxLjAwIEdpQiBwYWdlClsgICAgMC4wNzQ3
ODldIEh1Z2VUTEI6IHJlZ2lzdGVyZWQgMi4wMCBNaUIgcGFnZSBzaXplLCBwcmUtYWxsb2Nh
dGVkIDAgcGFnZXMKWyAgICAwLjA3NDc4OV0gSHVnZVRMQjogMjggS2lCIHZtZW1tYXAgY2Fu
IGJlIGZyZWVkIGZvciBhIDIuMDAgTWlCIHBhZ2UKWyAgICAwLjA3NDc4OV0gQUNQSTogRGlz
YWJsZWQgYWxsIF9PU0kgT1MgdmVuZG9ycwpbICAgIDAuMDc0Nzg5XSBBQ1BJOiBBZGRlZCBf
T1NJKE1vZHVsZSBEZXZpY2UpClsgICAgMC4wNzQ3ODldIEFDUEk6IEFkZGVkIF9PU0koUHJv
Y2Vzc29yIERldmljZSkKWyAgICAwLjA3NDc4OV0gQUNQSTogQWRkZWQgX09TSSgzLjAgX1ND
UCBFeHRlbnNpb25zKQpbICAgIDAuMDc0Nzg5XSBBQ1BJOiBBZGRlZCBfT1NJKFByb2Nlc3Nv
ciBBZ2dyZWdhdG9yIERldmljZSkKWyAgICAwLjA3NDc4OV0gQUNQSTogQWRkZWQgX09TSShX
aW5kb3dzIDIwMTUpClsgICAgMC4xMTYwNTZdIEFDUEk6IDE0IEFDUEkgQU1MIHRhYmxlcyBz
dWNjZXNzZnVsbHkgYWNxdWlyZWQgYW5kIGxvYWRlZApbICAgIDAuMTE3OTk2XSBBQ1BJOiBb
RmlybXdhcmUgQnVnXTogQklPUyBfT1NJKExpbnV4KSBxdWVyeSBpZ25vcmVkClsgICAgMC4x
MjM3OTFdIEFDUEk6IER5bmFtaWMgT0VNIFRhYmxlIExvYWQ6ClsgICAgMC4xMjM4MDVdIEFD
UEk6IFNTRFQgMHhGRkZGODhFODQ5QkU3MDAwIDAwMDY1MSAodjAyIFBtUmVmICBDcHUwSXN0
ICAwMDAwMzAwMCBJTlRMIDIwMTYwNTI3KQpbICAgIDAuMTI0ODk3XSBBQ1BJOiBcX1BSXy5Q
UjAwOiBfT1NDIG5hdGl2ZSB0aGVybWFsIExWVCBBY2tlZApbICAgIDAuMTI2MzAzXSBBQ1BJ
OiBEeW5hbWljIE9FTSBUYWJsZSBMb2FkOgpbICAgIDAuMTI2MzE1XSBBQ1BJOiBTU0RUIDB4
RkZGRjg4RTg0OUJCNjgwMCAwMDAzRkYgKHYwMiBQbVJlZiAgQ3B1MENzdCAgMDAwMDMwMDEg
SU5UTCAyMDE2MDUyNykKWyAgICAwLjEyNzczM10gQUNQSTogRHluYW1pYyBPRU0gVGFibGUg
TG9hZDoKWyAgICAwLjEyNzc0NV0gQUNQSTogU1NEVCAweEZGRkY4OEU3QzBGREUwMDAgMDAw
RDE0ICh2MDIgUG1SZWYgIEFwSXN0ICAgIDAwMDAzMDAwIElOVEwgMjAxNjA1MjcpClsgICAg
MC4xMjk0MzNdIEFDUEk6IER5bmFtaWMgT0VNIFRhYmxlIExvYWQ6ClsgICAgMC4xMjk0NDNd
IEFDUEk6IFNTRFQgMHhGRkZGODhFODQ5QkI0ODAwIDAwMDMxNyAodjAyIFBtUmVmICBBcEh3
cCAgICAwMDAwMzAwMCBJTlRMIDIwMTYwNTI3KQpbICAgIDAuMTMwNDk4XSBBQ1BJOiBEeW5h
bWljIE9FTSBUYWJsZSBMb2FkOgpbICAgIDAuMTMwNTA4XSBBQ1BJOiBTU0RUIDB4RkZGRjg4
RTg0OUJCMTgwMCAwMDAzMEEgKHYwMiBQbVJlZiAgQXBDc3QgICAgMDAwMDMwMDAgSU5UTCAy
MDE2MDUyNykKWyAgICAwLjEzNDMzOF0gQUNQSTogRUM6IEVDIHN0YXJ0ZWQKWyAgICAwLjEz
NDM0MV0gQUNQSTogRUM6IGludGVycnVwdCBibG9ja2VkClsgICAgMC4xNTc0MzFdIEFDUEk6
IEVDOiBFQ19DTUQvRUNfU0M9MHg2NiwgRUNfREFUQT0weDYyClsgICAgMC4xNTc0MzZdIEFD
UEk6IFxfU0JfLlBDSTAuTFBDQi5FQzBfOiBCb290IERTRFQgRUMgdXNlZCB0byBoYW5kbGUg
dHJhbnNhY3Rpb25zClsgICAgMC4xNTc0MzldIEFDUEk6IEludGVycHJldGVyIGVuYWJsZWQK
WyAgICAwLjE1NzQ4N10gQUNQSTogUE06IChzdXBwb3J0cyBTMCBTMyBTNCBTNSkKWyAgICAw
LjE1NzQ5MF0gQUNQSTogVXNpbmcgSU9BUElDIGZvciBpbnRlcnJ1cHQgcm91dGluZwpbICAg
IDAuMTU4NzAyXSBQQ0k6IE1NQ09ORklHIGZvciBkb21haW4gMDAwMCBbYnVzIDAwLWZmXSBh
dCBbbWVtIDB4ZTAwMDAwMDAtMHhlZmZmZmZmZl0gKGJhc2UgMHhlMDAwMDAwMCkKWyAgICAw
LjE2MTUzMl0gUENJOiBNTUNPTkZJRyBhdCBbbWVtIDB4ZTAwMDAwMDAtMHhlZmZmZmZmZl0g
cmVzZXJ2ZWQgYXMgQUNQSSBtb3RoZXJib2FyZCByZXNvdXJjZQpbICAgIDAuMTYxNTQ4XSBQ
Q0k6IFVzaW5nIGhvc3QgYnJpZGdlIHdpbmRvd3MgZnJvbSBBQ1BJOyBpZiBuZWNlc3Nhcnks
IHVzZSAicGNpPW5vY3JzIiBhbmQgcmVwb3J0IGEgYnVnClsgICAgMC4xNjE1NTFdIFBDSTog
VXNpbmcgRTgyMCByZXNlcnZhdGlvbnMgZm9yIGhvc3QgYnJpZGdlIHdpbmRvd3MKWyAgICAw
LjE2MjU3OF0gQUNQSTogRW5hYmxlZCA3IEdQRXMgaW4gYmxvY2sgMDAgdG8gN0YKWyAgICAw
LjE2MzU0Ml0gQUNQSTogXF9TQl8uUENJMC5QRUcwLlBHMDA6IE5ldyBwb3dlciByZXNvdXJj
ZQpbICAgIDAuMTg0MTQzXSBhY3BpIEFCQ0QwMDAwOjAwOiBBQ1BJIGRvY2sgc3RhdGlvbiAo
ZG9ja3MvYmF5cyBjb3VudDogMSkKWyAgICAwLjE4NzEwMV0gQUNQSTogUENJIFJvb3QgQnJp
ZGdlIFtQQ0kwXSAoZG9tYWluIDAwMDAgW2J1cyAwMC1mZV0pClsgICAgMC4xODcxMTBdIGFj
cGkgUE5QMEEwODowMDogX09TQzogT1Mgc3VwcG9ydHMgW0V4dGVuZGVkQ29uZmlnIEFTUE0g
Q2xvY2tQTSBTZWdtZW50cyBNU0kgRURSIEhQWC1UeXBlM10KWyAgICAwLjE4NzIwMV0gYWNw
aSBQTlAwQTA4OjAwOiBfT1NDOiBwbGF0Zm9ybSBkb2VzIG5vdCBzdXBwb3J0IFtQQ0llSG90
cGx1ZyBTSFBDSG90cGx1ZyBQTUUgQUVSXQpbICAgIDAuMTg3MzU3XSBhY3BpIFBOUDBBMDg6
MDA6IF9PU0M6IE9TIG5vdyBjb250cm9scyBbUENJZUNhcGFiaWxpdHkgTFRSIERQQ10KWyAg
ICAwLjE4NzM2MV0gYWNwaSBQTlAwQTA4OjAwOiBGQURUIGluZGljYXRlcyBBU1BNIGlzIHVu
c3VwcG9ydGVkLCB1c2luZyBCSU9TIGNvbmZpZ3VyYXRpb24KWyAgICAwLjE4OTk3MV0gUENJ
IGhvc3QgYnJpZGdlIHRvIGJ1cyAwMDAwOjAwClsgICAgMC4xODk5NzVdIHBjaV9idXMgMDAw
MDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2lvICAweDAwMDAtMHgwY2Y3IHdpbmRvd10KWyAg
ICAwLjE4OTk3OV0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbaW8gIDB4
MGQwMC0weGZmZmYgd2luZG93XQpbICAgIDAuMTg5OTgyXSBwY2lfYnVzIDAwMDA6MDA6IHJv
b3QgYnVzIHJlc291cmNlIFttZW0gMHgwMDBhMDAwMC0weDAwMGZmZmZmIHdpbmRvd10KWyAg
ICAwLjE4OTk4NV0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4
NDAwMDAwMDAtMHhkZmZmZmZmZiB3aW5kb3ddClsgICAgMC4xODk5ODhdIHBjaV9idXMgMDAw
MDowMDogcm9vdCBidXMgcmVzb3VyY2UgW21lbSAweDIwMDAwMDAwMDAtMHgyZmZmZmZmZmZm
IHdpbmRvd10KWyAgICAwLjE4OTk5MV0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNv
dXJjZSBbbWVtIDB4ZmQwMDAwMDAtMHhmZTdmZmZmZiB3aW5kb3ddClsgICAgMC4xODk5OTRd
IHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2J1cyAwMC1mZV0KWyAgICAw
LjE5MDA3N10gcGNpIDAwMDA6MDA6MDAuMDogWzgwODY6NTkxMF0gdHlwZSAwMCBjbGFzcyAw
eDA2MDAwMApbICAgIDAuMTkwMTc3XSBwY2kgMDAwMDowMDowMS4wOiBbODA4NjoxOTAxXSB0
eXBlIDAxIGNsYXNzIDB4MDYwNDAwClsgICAgMC4xOTAyNDhdIHBjaSAwMDAwOjAwOjAxLjA6
IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkClsgICAgMC4xOTAzNDhdIHBj
aSAwMDAwOjAwOjAyLjA6IFs4MDg2OjU5MWJdIHR5cGUgMDAgY2xhc3MgMHgwMzAwMDAKWyAg
ICAwLjE5MDM3MF0gcGNpIDAwMDA6MDA6MDIuMDogcmVnIDB4MTA6IFttZW0gMHgyZmYyMDAw
MDAwLTB4MmZmMmZmZmZmZiA2NGJpdF0KWyAgICAwLjE5MDM4OF0gcGNpIDAwMDA6MDA6MDIu
MDogcmVnIDB4MTg6IFttZW0gMHgyZmMwMDAwMDAwLTB4MmZjZmZmZmZmZiA2NGJpdCBwcmVm
XQpbICAgIDAuMTkwNDAwXSBwY2kgMDAwMDowMDowMi4wOiByZWcgMHgyMDogW2lvICAweDUw
MDAtMHg1MDNmXQpbICAgIDAuMTkwNDM0XSBwY2kgMDAwMDowMDowMi4wOiBWaWRlbyBkZXZp
Y2Ugd2l0aCBzaGFkb3dlZCBST00gYXQgW21lbSAweDAwMGMwMDAwLTB4MDAwZGZmZmZdClsg
ICAgMC4xOTA2NzVdIHBjaSAwMDAwOjAwOjE0LjA6IFs4MDg2OmExMmZdIHR5cGUgMDAgY2xh
c3MgMHgwYzAzMzAKWyAgICAwLjE5MDcxN10gcGNpIDAwMDA6MDA6MTQuMDogcmVnIDB4MTA6
IFttZW0gMHg2MzUwMDAwMC0weDYzNTBmZmZmIDY0Yml0XQpbICAgIDAuMTkwODQ4XSBwY2kg
MDAwMDowMDoxNC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQzaG90IEQzY29sZApbICAgIDAu
MTkxNDk0XSBwY2kgMDAwMDowMDoxNC4yOiBbODA4NjphMTMxXSB0eXBlIDAwIGNsYXNzIDB4
MTE4MDAwClsgICAgMC4xOTE1MzRdIHBjaSAwMDAwOjAwOjE0LjI6IHJlZyAweDEwOiBbbWVt
IDB4MmZmMzAxODAwMC0weDJmZjMwMThmZmYgNjRiaXRdClsgICAgMC4xOTE4NzJdIHBjaSAw
MDAwOjAwOjE1LjA6IFs4MDg2OmExNjBdIHR5cGUgMDAgY2xhc3MgMHgxMTgwMDAKWyAgICAw
LjE5MjA4Ml0gcGNpIDAwMDA6MDA6MTUuMDogcmVnIDB4MTA6IFttZW0gMHgyZmYzMDE3MDAw
LTB4MmZmMzAxN2ZmZiA2NGJpdF0KWyAgICAwLjE5MzI3M10gcGNpIDAwMDA6MDA6MTUuMTog
WzgwODY6YTE2MV0gdHlwZSAwMCBjbGFzcyAweDExODAwMApbICAgIDAuMTkzNDgzXSBwY2kg
MDAwMDowMDoxNS4xOiByZWcgMHgxMDogW21lbSAweDJmZjMwMTYwMDAtMHgyZmYzMDE2ZmZm
IDY0Yml0XQpbICAgIDAuMTk0NTYyXSBwY2kgMDAwMDowMDoxNi4wOiBbODA4NjphMTNhXSB0
eXBlIDAwIGNsYXNzIDB4MDc4MDAwClsgICAgMC4xOTQ1OThdIHBjaSAwMDAwOjAwOjE2LjA6
IHJlZyAweDEwOiBbbWVtIDB4MmZmMzAxNTAwMC0weDJmZjMwMTVmZmYgNjRiaXRdClsgICAg
MC4xOTQ2OThdIHBjaSAwMDAwOjAwOjE2LjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDNob3QK
WyAgICAwLjE5NTE3MV0gcGNpIDAwMDA6MDA6MTcuMDogWzgwODY6YTEwM10gdHlwZSAwMCBj
bGFzcyAweDAxMDYwMQpbICAgIDAuMTk1MjAzXSBwY2kgMDAwMDowMDoxNy4wOiByZWcgMHgx
MDogW21lbSAweDYzNTE0MDAwLTB4NjM1MTVmZmZdClsgICAgMC4xOTUyMjNdIHBjaSAwMDAw
OjAwOjE3LjA6IHJlZyAweDE0OiBbbWVtIDB4NjM1MTcwMDAtMHg2MzUxNzBmZl0KWyAgICAw
LjE5NTI0MV0gcGNpIDAwMDA6MDA6MTcuMDogcmVnIDB4MTg6IFtpbyAgMHg1MDgwLTB4NTA4
N10KWyAgICAwLjE5NTI2MF0gcGNpIDAwMDA6MDA6MTcuMDogcmVnIDB4MWM6IFtpbyAgMHg1
MDg4LTB4NTA4Yl0KWyAgICAwLjE5NTI3OV0gcGNpIDAwMDA6MDA6MTcuMDogcmVnIDB4MjA6
IFtpbyAgMHg1MDYwLTB4NTA3Zl0KWyAgICAwLjE5NTI5OF0gcGNpIDAwMDA6MDA6MTcuMDog
cmVnIDB4MjQ6IFttZW0gMHg2MzUxNjAwMC0weDYzNTE2N2ZmXQpbICAgIDAuMTk1MzY4XSBw
Y2kgMDAwMDowMDoxNy4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQzaG90ClsgICAgMC4xOTU2
NjhdIHBjaSAwMDAwOjAwOjFjLjA6IFs4MDg2OmExMTJdIHR5cGUgMDEgY2xhc3MgMHgwNjA0
MDAKWyAgICAwLjE5NTgzMl0gcGNpIDAwMDA6MDA6MWMuMDogUE1FIyBzdXBwb3J0ZWQgZnJv
bSBEMCBEM2hvdCBEM2NvbGQKWyAgICAwLjE5NjM4NV0gcGNpIDAwMDA6MDA6MWMuMzogWzgw
ODY6YTExM10gdHlwZSAwMSBjbGFzcyAweDA2MDQwMApbICAgIDAuMTk2NTQ5XSBwY2kgMDAw
MDowMDoxYy4zOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDAu
MTk3MDg3XSBwY2kgMDAwMDowMDoxYy40OiBbODA4NjphMTE0XSB0eXBlIDAxIGNsYXNzIDB4
MDYwNDAwClsgICAgMC4xOTcyNTNdIHBjaSAwMDAwOjAwOjFjLjQ6IFBNRSMgc3VwcG9ydGVk
IGZyb20gRDAgRDNob3QgRDNjb2xkClsgICAgMC4xOTc3OTddIHBjaSAwMDAwOjAwOjFmLjA6
IFs4MDg2OmExNTJdIHR5cGUgMDAgY2xhc3MgMHgwNjAxMDAKWyAgICAwLjE5ODMxM10gcGNp
IDAwMDA6MDA6MWYuMjogWzgwODY6YTEyMV0gdHlwZSAwMCBjbGFzcyAweDA1ODAwMApbICAg
IDAuMTk4MzQzXSBwY2kgMDAwMDowMDoxZi4yOiByZWcgMHgxMDogW21lbSAweDYzNTEwMDAw
LTB4NjM1MTNmZmZdClsgICAgMC4xOTg2ODVdIHBjaSAwMDAwOjAwOjFmLjM6IFs4MDg2OmEx
NzFdIHR5cGUgMDAgY2xhc3MgMHgwNDAzMDAKWyAgICAwLjE5ODcyN10gcGNpIDAwMDA6MDA6
MWYuMzogcmVnIDB4MTA6IFttZW0gMHgyZmYzMDEwMDAwLTB4MmZmMzAxM2ZmZiA2NGJpdF0K
WyAgICAwLjE5ODc4OV0gcGNpIDAwMDA6MDA6MWYuMzogcmVnIDB4MjA6IFttZW0gMHgyZmYz
MDAwMDAwLTB4MmZmMzAwZmZmZiA2NGJpdF0KWyAgICAwLjE5ODg1M10gcGNpIDAwMDA6MDA6
MWYuMzogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEM2hvdCBEM2NvbGQKWyAgICAwLjE5OTY0NF0g
cGNpIDAwMDA6MDA6MWYuNDogWzgwODY6YTEyM10gdHlwZSAwMCBjbGFzcyAweDBjMDUwMApb
ICAgIDAuMTk5NzE1XSBwY2kgMDAwMDowMDoxZi40OiByZWcgMHgxMDogW21lbSAweDJmZjMw
MTQwMDAtMHgyZmYzMDE0MGZmIDY0Yml0XQpbICAgIDAuMTk5ODA0XSBwY2kgMDAwMDowMDox
Zi40OiByZWcgMHgyMDogW2lvICAweDUwNDAtMHg1MDVmXQpbICAgIDAuMjAwMTM5XSBwY2kg
MDAwMDowMTowMC4wOiBbMTBkZToxYzIwXSB0eXBlIDAwIGNsYXNzIDB4MDMwMDAwClsgICAg
MC4yMDAxNjBdIHBjaSAwMDAwOjAxOjAwLjA6IHJlZyAweDEwOiBbbWVtIDB4NjIwMDAwMDAt
MHg2MmZmZmZmZl0KWyAgICAwLjIwMDE3OV0gcGNpIDAwMDA6MDE6MDAuMDogcmVnIDB4MTQ6
IFttZW0gMHg1MDAwMDAwMC0weDVmZmZmZmZmIDY0Yml0IHByZWZdClsgICAgMC4yMDAxOTdd
IHBjaSAwMDAwOjAxOjAwLjA6IHJlZyAweDFjOiBbbWVtIDB4NjAwMDAwMDAtMHg2MWZmZmZm
ZiA2NGJpdCBwcmVmXQpbICAgIDAuMjAwMjExXSBwY2kgMDAwMDowMTowMC4wOiByZWcgMHgy
NDogW2lvICAweDQwMDAtMHg0MDdmXQpbICAgIDAuMjAwMjI0XSBwY2kgMDAwMDowMTowMC4w
OiByZWcgMHgzMDogW21lbSAweGZmZjgwMDAwLTB4ZmZmZmZmZmYgcHJlZl0KWyAgICAwLjIw
MDIzOV0gcGNpIDAwMDA6MDE6MDAuMDogRW5hYmxpbmcgSERBIGNvbnRyb2xsZXIKWyAgICAw
LjIwMDUwM10gcGNpIDAwMDA6MDE6MDAuMTogWzEwZGU6MTBmMV0gdHlwZSAwMCBjbGFzcyAw
eDA0MDMwMApbICAgIDAuMjAwNTI1XSBwY2kgMDAwMDowMTowMC4xOiByZWcgMHgxMDogW21l
bSAweDYzMDAwMDAwLTB4NjMwMDNmZmZdClsgICAgMC4yMDA2NzBdIHBjaSAwMDAwOjAwOjAx
LjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMV0KWyAgICAwLjIwMDY3NF0gcGNpIDAwMDA6MDA6
MDEuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHg0MDAwLTB4NGZmZl0KWyAgICAwLjIwMDY3
OF0gcGNpIDAwMDA6MDA6MDEuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg2MjAwMDAwMC0w
eDYzMGZmZmZmXQpbICAgIDAuMjAwNjgyXSBwY2kgMDAwMDowMDowMS4wOiAgIGJyaWRnZSB3
aW5kb3cgW21lbSAweDUwMDAwMDAwLTB4NjFmZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjIw
MDkwNl0gcGNpIDAwMDA6MDI6MDAuMDogWzE2OGM6MDAzZV0gdHlwZSAwMCBjbGFzcyAweDAy
ODAwMApbICAgIDAuMjAxMDg4XSBwY2kgMDAwMDowMjowMC4wOiByZWcgMHgxMDogW21lbSAw
eDYzMjAwMDAwLTB4NjMzZmZmZmYgNjRiaXRdClsgICAgMC4yMDIxNzNdIHBjaSAwMDAwOjAy
OjAwLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkClsgICAgMC4yMDMy
NTddIHBjaSAwMDAwOjAwOjFjLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMl0KWyAgICAwLjIw
MzI2Nl0gcGNpIDAwMDA6MDA6MWMuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg2MzIwMDAw
MC0weDYzM2ZmZmZmXQpbICAgIDAuMjAzMzUzXSBwY2kgMDAwMDowMzowMC4wOiBbMTBlYzo4
MTY4XSB0eXBlIDAwIGNsYXNzIDB4MDIwMDAwClsgICAgMC4yMDMzODVdIHBjaSAwMDAwOjAz
OjAwLjA6IHJlZyAweDEwOiBbaW8gIDB4MzAwMC0weDMwZmZdClsgICAgMC4yMDM0MjldIHBj
aSAwMDAwOjAzOjAwLjA6IHJlZyAweDE4OiBbbWVtIDB4NjM0MDQwMDAtMHg2MzQwNGZmZiA2
NGJpdF0KWyAgICAwLjIwMzQ1N10gcGNpIDAwMDA6MDM6MDAuMDogcmVnIDB4MjA6IFttZW0g
MHg2MzQwMDAwMC0weDYzNDAzZmZmIDY0Yml0XQpbICAgIDAuMjAzNTk0XSBwY2kgMDAwMDow
MzowMC4wOiBzdXBwb3J0cyBEMSBEMgpbICAgIDAuMjAzNTk2XSBwY2kgMDAwMDowMzowMC4w
OiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQxIEQyIEQzaG90IEQzY29sZApbICAgIDAuMjAz
ODQ5XSBwY2kgMDAwMDowMDoxYy4zOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDNdClsgICAgMC4y
MDM4NTVdIHBjaSAwMDAwOjAwOjFjLjM6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4MzAwMC0w
eDNmZmZdClsgICAgMC4yMDM4NjBdIHBjaSAwMDAwOjAwOjFjLjM6ICAgYnJpZGdlIHdpbmRv
dyBbbWVtIDB4NjM0MDAwMDAtMHg2MzRmZmZmZl0KWyAgICAwLjIwMzkzNF0gcGNpIDAwMDA6
MDA6MWMuNDogUENJIGJyaWRnZSB0byBbYnVzIDA0LTNjXQpbICAgIDAuMjAzOTQzXSBwY2kg
MDAwMDowMDoxYy40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDY0MDAwMDAwLTB4N2EwZmZm
ZmZdClsgICAgMC4yMDM5NTFdIHBjaSAwMDAwOjAwOjFjLjQ6ICAgYnJpZGdlIHdpbmRvdyBb
bWVtIDB4MmZkMDAwMDAwMC0weDJmZjFmZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjIwNjAz
NV0gQUNQSTogUENJOiBJbnRlcnJ1cHQgbGluayBMTktBIGNvbmZpZ3VyZWQgZm9yIElSUSAx
MQpbICAgIDAuMjA2MDkyXSBBQ1BJOiBQQ0k6IEludGVycnVwdCBsaW5rIExOS0IgY29uZmln
dXJlZCBmb3IgSVJRIDEwClsgICAgMC4yMDYxNDVdIEFDUEk6IFBDSTogSW50ZXJydXB0IGxp
bmsgTE5LQyBjb25maWd1cmVkIGZvciBJUlEgMTEKWyAgICAwLjIwNjE5OV0gQUNQSTogUENJ
OiBJbnRlcnJ1cHQgbGluayBMTktEIGNvbmZpZ3VyZWQgZm9yIElSUSAxMQpbICAgIDAuMjA2
MjUxXSBBQ1BJOiBQQ0k6IEludGVycnVwdCBsaW5rIExOS0UgY29uZmlndXJlZCBmb3IgSVJR
IDExClsgICAgMC4yMDYzMDRdIEFDUEk6IFBDSTogSW50ZXJydXB0IGxpbmsgTE5LRiBjb25m
aWd1cmVkIGZvciBJUlEgMTEKWyAgICAwLjIwNjM1Nl0gQUNQSTogUENJOiBJbnRlcnJ1cHQg
bGluayBMTktHIGNvbmZpZ3VyZWQgZm9yIElSUSAxMQpbICAgIDAuMjA2NDA5XSBBQ1BJOiBQ
Q0k6IEludGVycnVwdCBsaW5rIExOS0ggY29uZmlndXJlZCBmb3IgSVJRIDExClsgICAgMC4y
MTE2MDNdIEFDUEk6IEVDOiBpbnRlcnJ1cHQgdW5ibG9ja2VkClsgICAgMC4yMTE2MDZdIEFD
UEk6IEVDOiBldmVudCB1bmJsb2NrZWQKWyAgICAwLjIxMTYyMV0gQUNQSTogRUM6IEVDX0NN
RC9FQ19TQz0weDY2LCBFQ19EQVRBPTB4NjIKWyAgICAwLjIxMTYyNF0gQUNQSTogRUM6IEdQ
RT0weDMKWyAgICAwLjIxMTYyNl0gQUNQSTogXF9TQl8uUENJMC5MUENCLkVDMF86IEJvb3Qg
RFNEVCBFQyBpbml0aWFsaXphdGlvbiBjb21wbGV0ZQpbICAgIDAuMjExNjMwXSBBQ1BJOiBc
X1NCXy5QQ0kwLkxQQ0IuRUMwXzogRUM6IFVzZWQgdG8gaGFuZGxlIHRyYW5zYWN0aW9ucyBh
bmQgZXZlbnRzClsgICAgMC4yMTE2NzZdIGlvbW11OiBEZWZhdWx0IGRvbWFpbiB0eXBlOiBQ
YXNzdGhyb3VnaCAKWyAgICAwLjIxMTY3Nl0gU0NTSSBzdWJzeXN0ZW0gaW5pdGlhbGl6ZWQK
WyAgICAwLjIxMTY3Nl0gbGliYXRhIHZlcnNpb24gMy4wMCBsb2FkZWQuClsgICAgMC4yMTE2
NzZdIHBwc19jb3JlOiBMaW51eFBQUyBBUEkgdmVyLiAxIHJlZ2lzdGVyZWQKWyAgICAwLjIx
MTY3Nl0gcHBzX2NvcmU6IFNvZnR3YXJlIHZlci4gNS4zLjYgLSBDb3B5cmlnaHQgMjAwNS0y
MDA3IFJvZG9sZm8gR2lvbWV0dGkgPGdpb21ldHRpQGxpbnV4Lml0PgpbICAgIDAuMjExNjc2
XSBQVFAgY2xvY2sgc3VwcG9ydCByZWdpc3RlcmVkClsgICAgMC4yMTE2NzZdIEVEQUMgTUM6
IFZlcjogMy4wLjAKWyAgICAwLjIxMTc5NV0gZWZpdmFyczogUmVnaXN0ZXJlZCBlZml2YXJz
IG9wZXJhdGlvbnMKWyAgICAwLjIxMTc5NV0gTmV0TGFiZWw6IEluaXRpYWxpemluZwpbICAg
IDAuMjExNzk1XSBOZXRMYWJlbDogIGRvbWFpbiBoYXNoIHNpemUgPSAxMjgKWyAgICAwLjIx
MTc5NV0gTmV0TGFiZWw6ICBwcm90b2NvbHMgPSBVTkxBQkVMRUQgQ0lQU092NCBDQUxJUFNP
ClsgICAgMC4yMTE3OTVdIE5ldExhYmVsOiAgdW5sYWJlbGVkIHRyYWZmaWMgYWxsb3dlZCBi
eSBkZWZhdWx0ClsgICAgMC4yMTE3OTVdIG1jdHA6IG1hbmFnZW1lbnQgY29tcG9uZW50IHRy
YW5zcG9ydCBwcm90b2NvbCBjb3JlClsgICAgMC4yMTI1MzJdIE5FVDogUmVnaXN0ZXJlZCBQ
Rl9NQ1RQIHByb3RvY29sIGZhbWlseQpbICAgIDAuMjEyNTM2XSBQQ0k6IFVzaW5nIEFDUEkg
Zm9yIElSUSByb3V0aW5nClsgICAgMC4yMzczNzFdIFBDSTogcGNpX2NhY2hlX2xpbmVfc2l6
ZSBzZXQgdG8gNjQgYnl0ZXMKWyAgICAwLjIzNzU0Nl0gZTgyMDogcmVzZXJ2ZSBSQU0gYnVm
ZmVyIFttZW0gMHgwMDA1ODAwMC0weDAwMDVmZmZmXQpbICAgIDAuMjM3NTQ4XSBlODIwOiBy
ZXNlcnZlIFJBTSBidWZmZXIgW21lbSAweDAwMDllMDAwLTB4MDAwOWZmZmZdClsgICAgMC4y
Mzc1NDldIGU4MjA6IHJlc2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4MjBkNWYwMTgtMHgyM2Zm
ZmZmZl0KWyAgICAwLjIzNzU1MV0gZTgyMDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHgy
MjNiNjAwMC0weDIzZmZmZmZmXQpbICAgIDAuMjM3NTUyXSBlODIwOiByZXNlcnZlIFJBTSBi
dWZmZXIgW21lbSAweDJhODNjMDAwLTB4MmJmZmZmZmZdClsgICAgMC4yMzc1NTNdIGU4MjA6
IHJlc2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4MzllOWUwMDAtMHgzYmZmZmZmZl0KWyAgICAw
LjIzNzU1NF0gZTgyMDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHgzYWZmZjAwMC0weDNi
ZmZmZmZmXQpbICAgIDAuMjM3NTU0XSBlODIwOiByZXNlcnZlIFJBTSBidWZmZXIgW21lbSAw
eDJiZjAwMDAwMC0weDJiZmZmZmZmZl0KWyAgICAwLjIzNzU2N10gcGNpIDAwMDA6MDA6MDIu
MDogdmdhYXJiOiBzZXR0aW5nIGFzIGJvb3QgVkdBIGRldmljZQpbICAgIDAuMjM3NTY3XSBw
Y2kgMDAwMDowMDowMi4wOiB2Z2FhcmI6IGJyaWRnZSBjb250cm9sIHBvc3NpYmxlClsgICAg
MC4yMzc1NjddIHBjaSAwMDAwOjAwOjAyLjA6IHZnYWFyYjogVkdBIGRldmljZSBhZGRlZDog
ZGVjb2Rlcz1pbyttZW0sb3ducz1pbyttZW0sbG9ja3M9bm9uZQpbICAgIDAuMjM3NTY3XSBw
Y2kgMDAwMDowMTowMC4wOiB2Z2FhcmI6IGJyaWRnZSBjb250cm9sIHBvc3NpYmxlClsgICAg
MC4yMzc1NjddIHBjaSAwMDAwOjAxOjAwLjA6IHZnYWFyYjogVkdBIGRldmljZSBhZGRlZDog
ZGVjb2Rlcz1pbyttZW0sb3ducz1ub25lLGxvY2tzPW5vbmUKWyAgICAwLjIzNzU2N10gdmdh
YXJiOiBsb2FkZWQKWyAgICAwLjIzNzU4OF0gaHBldDA6IGF0IE1NSU8gMHhmZWQwMDAwMCwg
SVJRcyAyLCA4LCAwLCAwLCAwLCAwLCAwLCAwClsgICAgMC4yMzc1OTddIGhwZXQwOiA4IGNv
bXBhcmF0b3JzLCA2NC1iaXQgMjQuMDAwMDAwIE1IeiBjb3VudGVyClsgICAgMC4yMzk1NDld
IGNsb2Nrc291cmNlOiBTd2l0Y2hlZCB0byBjbG9ja3NvdXJjZSB0c2MtZWFybHkKWyAgICAw
LjIzOTYwOF0gVkZTOiBEaXNrIHF1b3RhcyBkcXVvdF82LjYuMApbICAgIDAuMjM5NjE5XSBW
RlM6IERxdW90LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNTEyIChvcmRlciAwLCA0MDk2
IGJ5dGVzKQpbICAgIDAuMjM5NzAwXSBBcHBBcm1vcjogQXBwQXJtb3IgRmlsZXN5c3RlbSBF
bmFibGVkClsgICAgMC4yMzk3MjldIHBucDogUG5QIEFDUEkgaW5pdApbICAgIDAuMjM5OTA4
XSBzeXN0ZW0gMDA6MDA6IFttZW0gMHhmZDAwMDAwMC0weGZkYWJmZmZmXSBoYXMgYmVlbiBy
ZXNlcnZlZApbICAgIDAuMjM5OTEzXSBzeXN0ZW0gMDA6MDA6IFttZW0gMHhmZGFkMDAwMC0w
eGZkYWRmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuMjM5OTE3XSBzeXN0ZW0gMDA6
MDA6IFttZW0gMHhmZGIwMDAwMC0weGZkZmZmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAg
IDAuMjM5OTIxXSBzeXN0ZW0gMDA6MDA6IFttZW0gMHhmZTAwMDAwMC0weGZlMDFmZmZmXSBo
YXMgYmVlbiByZXNlcnZlZApbICAgIDAuMjM5OTI0XSBzeXN0ZW0gMDA6MDA6IFttZW0gMHhm
ZTAzNjAwMC0weGZlMDNiZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuMjM5OTI3XSBz
eXN0ZW0gMDA6MDA6IFttZW0gMHhmZTAzZDAwMC0weGZlM2ZmZmZmXSBoYXMgYmVlbiByZXNl
cnZlZApbICAgIDAuMjM5OTMwXSBzeXN0ZW0gMDA6MDA6IFttZW0gMHhmZTQxMDAwMC0weGZl
N2ZmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuMjQwMjUyXSBzeXN0ZW0gMDA6MDE6
IFtpbyAgMHgyMDAwLTB4MjBmZV0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjI0MDM5Ml0g
c3lzdGVtIDAwOjAyOiBbaW8gIDB4ZmZmZl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjI0
MDM5Nl0gc3lzdGVtIDAwOjAyOiBbaW8gIDB4ZmZmZl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAg
ICAwLjI0MDM5OF0gc3lzdGVtIDAwOjAyOiBbaW8gIDB4ZmZmZl0gaGFzIGJlZW4gcmVzZXJ2
ZWQKWyAgICAwLjI0MDQwMV0gc3lzdGVtIDAwOjAyOiBbaW8gIDB4MTgwMC0weDE4ZmVdIGhh
cyBiZWVuIHJlc2VydmVkClsgICAgMC4yNDA0MDRdIHN5c3RlbSAwMDowMjogW21lbSAweGZl
ODAwMDAwLTB4ZmU4MGZmZmZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC4yNDA1MDBdIHN5
c3RlbSAwMDowMzogW2lvICAweDA4MDAtMHgwODdmXSBoYXMgYmVlbiByZXNlcnZlZApbICAg
IDAuMjQwNTQ1XSBzeXN0ZW0gMDA6MDU6IFtpbyAgMHgxODU0LTB4MTg1N10gaGFzIGJlZW4g
cmVzZXJ2ZWQKWyAgICAwLjI0MjczMF0gc3lzdGVtIDAwOjA4OiBbbWVtIDB4ZmVkMTAwMDAt
MHhmZWQxN2ZmZl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjI0MjczNV0gc3lzdGVtIDAw
OjA4OiBbbWVtIDB4ZmVkMTgwMDAtMHhmZWQxOGZmZl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAg
ICAwLjI0Mjc0MF0gc3lzdGVtIDAwOjA4OiBbbWVtIDB4ZmVkMTkwMDAtMHhmZWQxOWZmZl0g
aGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjI0Mjc0M10gc3lzdGVtIDAwOjA4OiBbbWVtIDB4
ZTAwMDAwMDAtMHhlZmZmZmZmZl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjI0Mjc0N10g
c3lzdGVtIDAwOjA4OiBbbWVtIDB4ZmVkMjAwMDAtMHhmZWQzZmZmZl0gaGFzIGJlZW4gcmVz
ZXJ2ZWQKWyAgICAwLjI0Mjc1MF0gc3lzdGVtIDAwOjA4OiBbbWVtIDB4ZmVkOTAwMDAtMHhm
ZWQ5M2ZmZl0gY291bGQgbm90IGJlIHJlc2VydmVkClsgICAgMC4yNDI3NTNdIHN5c3RlbSAw
MDowODogW21lbSAweGZlZDQ1MDAwLTB4ZmVkOGZmZmZdIGNvdWxkIG5vdCBiZSByZXNlcnZl
ZApbICAgIDAuMjQyNzU2XSBzeXN0ZW0gMDA6MDg6IFttZW0gMHhmZjAwMDAwMC0weGZmZmZm
ZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuMjQyNzU5XSBzeXN0ZW0gMDA6MDg6IFtt
ZW0gMHhmZWUwMDAwMC0weGZlZWZmZmZmXSBjb3VsZCBub3QgYmUgcmVzZXJ2ZWQKWyAgICAw
LjI0Mjc2Ml0gc3lzdGVtIDAwOjA4OiBbbWVtIDB4NDAwMDAwMDAtMHg0MDAxZmZmZl0gaGFz
IGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjI0MzMzM10gcG5wOiBQblAgQUNQSTogZm91bmQgOSBk
ZXZpY2VzClsgICAgMC4yNDg3OTVdIGNsb2Nrc291cmNlOiBhY3BpX3BtOiBtYXNrOiAweGZm
ZmZmZiBtYXhfY3ljbGVzOiAweGZmZmZmZiwgbWF4X2lkbGVfbnM6IDIwODU3MDEwMjQgbnMK
WyAgICAwLjI0ODg0Nl0gTkVUOiBSZWdpc3RlcmVkIFBGX0lORVQgcHJvdG9jb2wgZmFtaWx5
ClsgICAgMC4yNDg5MjJdIElQIGlkZW50cyBoYXNoIHRhYmxlIGVudHJpZXM6IDEzMTA3MiAo
b3JkZXI6IDgsIDEwNDg1NzYgYnl0ZXMsIGxpbmVhcikKWyAgICAwLjI1MDQ2M10gdGNwX2xp
c3Rlbl9wb3J0YWRkcl9oYXNoIGhhc2ggdGFibGUgZW50cmllczogNDA5NiAob3JkZXI6IDQs
IDY1NTM2IGJ5dGVzLCBsaW5lYXIpClsgICAgMC4yNTA0ODFdIFRhYmxlLXBlcnR1cmIgaGFz
aCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3JkZXI6IDYsIDI2MjE0NCBieXRlcywgbGluZWFy
KQpbICAgIDAuMjUwNDg3XSBUQ1AgZXN0YWJsaXNoZWQgaGFzaCB0YWJsZSBlbnRyaWVzOiA2
NTUzNiAob3JkZXI6IDcsIDUyNDI4OCBieXRlcywgbGluZWFyKQpbICAgIDAuMjUwNTQ0XSBU
Q1AgYmluZCBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogOSwgMjA5NzE1MiBi
eXRlcywgbGluZWFyKQpbICAgIDAuMjUwODExXSBUQ1A6IEhhc2ggdGFibGVzIGNvbmZpZ3Vy
ZWQgKGVzdGFibGlzaGVkIDY1NTM2IGJpbmQgNjU1MzYpClsgICAgMC4yNTA4NjJdIE1QVENQ
IHRva2VuIGhhc2ggdGFibGUgZW50cmllczogODE5MiAob3JkZXI6IDUsIDE5NjYwOCBieXRl
cywgbGluZWFyKQpbICAgIDAuMjUwODg0XSBVRFAgaGFzaCB0YWJsZSBlbnRyaWVzOiA0MDk2
IChvcmRlcjogNSwgMTMxMDcyIGJ5dGVzLCBsaW5lYXIpClsgICAgMC4yNTA5MDRdIFVEUC1M
aXRlIGhhc2ggdGFibGUgZW50cmllczogNDA5NiAob3JkZXI6IDUsIDEzMTA3MiBieXRlcywg
bGluZWFyKQpbICAgIDAuMjUwOTQ0XSBORVQ6IFJlZ2lzdGVyZWQgUEZfVU5JWC9QRl9MT0NB
TCBwcm90b2NvbCBmYW1pbHkKWyAgICAwLjI1MDk1MV0gTkVUOiBSZWdpc3RlcmVkIFBGX1hE
UCBwcm90b2NvbCBmYW1pbHkKWyAgICAwLjI1MDk1NV0gcGNpIDAwMDA6MDE6MDAuMDogY2Fu
J3QgY2xhaW0gQkFSIDYgW21lbSAweGZmZjgwMDAwLTB4ZmZmZmZmZmYgcHJlZl06IG5vIGNv
bXBhdGlibGUgYnJpZGdlIHdpbmRvdwpbICAgIDAuMjUwOTY0XSBwY2kgMDAwMDowMDoxYy40
OiBicmlkZ2Ugd2luZG93IFtpbyAgMHgxMDAwLTB4MGZmZl0gdG8gW2J1cyAwNC0zY10gYWRk
X3NpemUgMTAwMApbICAgIDAuMjUwOTcyXSBwY2kgMDAwMDowMDoxYy40OiBCQVIgMTM6IGFz
c2lnbmVkIFtpbyAgMHg2MDAwLTB4NmZmZl0KWyAgICAwLjI1MDk3N10gcGNpIDAwMDA6MDE6
MDAuMDogQkFSIDY6IGFzc2lnbmVkIFttZW0gMHg2MzA4MDAwMC0weDYzMGZmZmZmIHByZWZd
ClsgICAgMC4yNTA5ODBdIHBjaSAwMDAwOjAwOjAxLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAw
MV0KWyAgICAwLjI1MDk4M10gcGNpIDAwMDA6MDA6MDEuMDogICBicmlkZ2Ugd2luZG93IFtp
byAgMHg0MDAwLTB4NGZmZl0KWyAgICAwLjI1MDk5Ml0gcGNpIDAwMDA6MDA6MDEuMDogICBi
cmlkZ2Ugd2luZG93IFttZW0gMHg2MjAwMDAwMC0weDYzMGZmZmZmXQpbICAgIDAuMjUwOTk5
XSBwY2kgMDAwMDowMDowMS4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDUwMDAwMDAwLTB4
NjFmZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjI1MTAxMV0gcGNpIDAwMDA6MDA6MWMuMDog
UENJIGJyaWRnZSB0byBbYnVzIDAyXQpbICAgIDAuMjUxMDIzXSBwY2kgMDAwMDowMDoxYy4w
OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDYzMjAwMDAwLTB4NjMzZmZmZmZdClsgICAgMC4y
NTEwNDRdIHBjaSAwMDAwOjAwOjFjLjM6IFBDSSBicmlkZ2UgdG8gW2J1cyAwM10KWyAgICAw
LjI1MTA0N10gcGNpIDAwMDA6MDA6MWMuMzogICBicmlkZ2Ugd2luZG93IFtpbyAgMHgzMDAw
LTB4M2ZmZl0KWyAgICAwLjI1MTA1OV0gcGNpIDAwMDA6MDA6MWMuMzogICBicmlkZ2Ugd2lu
ZG93IFttZW0gMHg2MzQwMDAwMC0weDYzNGZmZmZmXQpbICAgIDAuMjUxMDgwXSBwY2kgMDAw
MDowMDoxYy40OiBQQ0kgYnJpZGdlIHRvIFtidXMgMDQtM2NdClsgICAgMC4yNTEwODNdIHBj
aSAwMDAwOjAwOjFjLjQ6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4NjAwMC0weDZmZmZdClsg
ICAgMC4yNTEwOTVdIHBjaSAwMDAwOjAwOjFjLjQ6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4
NjQwMDAwMDAtMHg3YTBmZmZmZl0KWyAgICAwLjI1MTEwNF0gcGNpIDAwMDA6MDA6MWMuNDog
ICBicmlkZ2Ugd2luZG93IFttZW0gMHgyZmQwMDAwMDAwLTB4MmZmMWZmZmZmZiA2NGJpdCBw
cmVmXQpbICAgIDAuMjUxMTE5XSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDQgW2lvICAw
eDAwMDAtMHgwY2Y3IHdpbmRvd10KWyAgICAwLjI1MTEyM10gcGNpX2J1cyAwMDAwOjAwOiBy
ZXNvdXJjZSA1IFtpbyAgMHgwZDAwLTB4ZmZmZiB3aW5kb3ddClsgICAgMC4yNTExMjVdIHBj
aV9idXMgMDAwMDowMDogcmVzb3VyY2UgNiBbbWVtIDB4MDAwYTAwMDAtMHgwMDBmZmZmZiB3
aW5kb3ddClsgICAgMC4yNTExMjhdIHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgNyBbbWVt
IDB4NDAwMDAwMDAtMHhkZmZmZmZmZiB3aW5kb3ddClsgICAgMC4yNTExMzFdIHBjaV9idXMg
MDAwMDowMDogcmVzb3VyY2UgOCBbbWVtIDB4MjAwMDAwMDAwMC0weDJmZmZmZmZmZmYgd2lu
ZG93XQpbICAgIDAuMjUxMTM0XSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDkgW21lbSAw
eGZkMDAwMDAwLTB4ZmU3ZmZmZmYgd2luZG93XQpbICAgIDAuMjUxMTM2XSBwY2lfYnVzIDAw
MDA6MDE6IHJlc291cmNlIDAgW2lvICAweDQwMDAtMHg0ZmZmXQpbICAgIDAuMjUxMTM5XSBw
Y2lfYnVzIDAwMDA6MDE6IHJlc291cmNlIDEgW21lbSAweDYyMDAwMDAwLTB4NjMwZmZmZmZd
ClsgICAgMC4yNTExNDFdIHBjaV9idXMgMDAwMDowMTogcmVzb3VyY2UgMiBbbWVtIDB4NTAw
MDAwMDAtMHg2MWZmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuMjUxMTQ0XSBwY2lfYnVzIDAw
MDA6MDI6IHJlc291cmNlIDEgW21lbSAweDYzMjAwMDAwLTB4NjMzZmZmZmZdClsgICAgMC4y
NTExNDddIHBjaV9idXMgMDAwMDowMzogcmVzb3VyY2UgMCBbaW8gIDB4MzAwMC0weDNmZmZd
ClsgICAgMC4yNTExNDldIHBjaV9idXMgMDAwMDowMzogcmVzb3VyY2UgMSBbbWVtIDB4NjM0
MDAwMDAtMHg2MzRmZmZmZl0KWyAgICAwLjI1MTE1Ml0gcGNpX2J1cyAwMDAwOjA0OiByZXNv
dXJjZSAwIFtpbyAgMHg2MDAwLTB4NmZmZl0KWyAgICAwLjI1MTE1NF0gcGNpX2J1cyAwMDAw
OjA0OiByZXNvdXJjZSAxIFttZW0gMHg2NDAwMDAwMC0weDdhMGZmZmZmXQpbICAgIDAuMjUx
MTU2XSBwY2lfYnVzIDAwMDA6MDQ6IHJlc291cmNlIDIgW21lbSAweDJmZDAwMDAwMDAtMHgy
ZmYxZmZmZmZmIDY0Yml0IHByZWZdClsgICAgMC4yNTMwMTZdIHBjaSAwMDAwOjAxOjAwLjE6
IGV4dGVuZGluZyBkZWxheSBhZnRlciBwb3dlci1vbiBmcm9tIEQzaG90IHRvIDIwIG1zZWMK
WyAgICAwLjI1MzAzOV0gcGNpIDAwMDA6MDE6MDAuMTogRDAgcG93ZXIgc3RhdGUgZGVwZW5k
cyBvbiAwMDAwOjAxOjAwLjAKWyAgICAwLjI1MzExOF0gUENJOiBDTFMgNjQgYnl0ZXMsIGRl
ZmF1bHQgNjQKWyAgICAwLjI1MzEyOF0gRE1BUjogQUNQSSBkZXZpY2UgImRldmljZTo4NCIg
dW5kZXIgRE1BUiBhdCBmZWQ5MTAwMCBhcyAwMDoxNS4wClsgICAgMC4yNTMxMzNdIERNQVI6
IEFDUEkgZGV2aWNlICJkZXZpY2U6ODUiIHVuZGVyIERNQVIgYXQgZmVkOTEwMDAgYXMgMDA6
MTUuMQpbICAgIDAuMjUzMTQ0XSBQQ0ktRE1BOiBVc2luZyBzb2Z0d2FyZSBib3VuY2UgYnVm
ZmVyaW5nIGZvciBJTyAoU1dJT1RMQikKWyAgICAwLjI1MzE0Nl0gc29mdHdhcmUgSU8gVExC
OiBtYXBwZWQgW21lbSAweDAwMDAwMDAwMzU5NDUwMDAtMHgwMDAwMDAwMDM5OTQ1MDAwXSAo
NjRNQikKWyAgICAwLjI1MzE1Ml0gVHJ5aW5nIHRvIHVucGFjayByb290ZnMgaW1hZ2UgYXMg
aW5pdHJhbWZzLi4uClsgICAgMC4yNjE5NTNdIFJBUEwgUE1VOiBBUEkgdW5pdCBpcyAyXi0z
MiBKb3VsZXMsIDQgZml4ZWQgY291bnRlcnMsIDY1NTM2MCBtcyBvdmZsIHRpbWVyClsgICAg
MC4yNjE5NjBdIFJBUEwgUE1VOiBodyB1bml0IG9mIGRvbWFpbiBwcDAtY29yZSAyXi0xNCBK
b3VsZXMKWyAgICAwLjI2MTk2M10gUkFQTCBQTVU6IGh3IHVuaXQgb2YgZG9tYWluIHBhY2th
Z2UgMl4tMTQgSm91bGVzClsgICAgMC4yNjE5NjVdIFJBUEwgUE1VOiBodyB1bml0IG9mIGRv
bWFpbiBkcmFtIDJeLTE0IEpvdWxlcwpbICAgIDAuMjYxOTY3XSBSQVBMIFBNVTogaHcgdW5p
dCBvZiBkb21haW4gcHAxLWdwdSAyXi0xNCBKb3VsZXMKWyAgICAwLjI2MjQ4MF0gSW5pdGlh
bGlzZSBzeXN0ZW0gdHJ1c3RlZCBrZXlyaW5ncwpbICAgIDAuMjYyNDg5XSBLZXkgdHlwZSBi
bGFja2xpc3QgcmVnaXN0ZXJlZApbICAgIDAuMjYyNTE0XSB3b3JraW5nc2V0OiB0aW1lc3Rh
bXBfYml0cz0zNyBtYXhfb3JkZXI9MjEgYnVja2V0X29yZGVyPTAKWyAgICAwLjI2MjUyM10g
emJ1ZDogbG9hZGVkClsgICAgMC4yNjI3MTZdIGludGVncml0eTogUGxhdGZvcm0gS2V5cmlu
ZyBpbml0aWFsaXplZApbICAgIDAuMjcwNzc2XSBLZXkgdHlwZSBhc3ltbWV0cmljIHJlZ2lz
dGVyZWQKWyAgICAwLjI3MDc3OV0gQXN5bW1ldHJpYyBrZXkgcGFyc2VyICd4NTA5JyByZWdp
c3RlcmVkClsgICAgMC4yNzA3OTBdIEJsb2NrIGxheWVyIFNDU0kgZ2VuZXJpYyAoYnNnKSBk
cml2ZXIgdmVyc2lvbiAwLjQgbG9hZGVkIChtYWpvciAyNDcpClsgICAgMC4yNzA4MjldIGlv
IHNjaGVkdWxlciBtcS1kZWFkbGluZSByZWdpc3RlcmVkClsgICAgMC4yNzA4MzFdIGlvIHNj
aGVkdWxlciBreWJlciByZWdpc3RlcmVkClsgICAgMC4yNzA4MzldIGlvIHNjaGVkdWxlciBi
ZnEgcmVnaXN0ZXJlZApbICAgIDAuMjcxNzkxXSBzaHBjaHA6IFN0YW5kYXJkIEhvdCBQbHVn
IFBDSSBDb250cm9sbGVyIERyaXZlciB2ZXJzaW9uOiAwLjQKWyAgICAwLjI3MzA1NF0gU2Vy
aWFsOiA4MjUwLzE2NTUwIGRyaXZlciwgMzIgcG9ydHMsIElSUSBzaGFyaW5nIGVuYWJsZWQK
WyAgICAwLjI3NDUwMF0gTm9uLXZvbGF0aWxlIG1lbW9yeSBkcml2ZXIgdjEuMwpbICAgIDAu
Mjc0NTA0XSBMaW51eCBhZ3BnYXJ0IGludGVyZmFjZSB2MC4xMDMKWyAgICAwLjI4Mzc5N10g
YWhjaSAwMDAwOjAwOjE3LjA6IHZlcnNpb24gMy4wClsgICAgMC4yOTQwNTZdIGFoY2kgMDAw
MDowMDoxNy4wOiBBSENJIDAwMDEuMDMwMSAzMiBzbG90cyAzIHBvcnRzIDYgR2JwcyAweDQg
aW1wbCBTQVRBIG1vZGUKWyAgICAwLjI5NDA2NV0gYWhjaSAwMDAwOjAwOjE3LjA6IGZsYWdz
OiA2NGJpdCBuY3Egc250ZiBwbSBsZWQgY2xvIG9ubHkgcGlvIHNsdW0gcGFydCBlbXMgZGVz
byBzYWRtIHNkcyBhcHN0IApbICAgIDAuMjk0NDU4XSBzY3NpIGhvc3QwOiBhaGNpClsgICAg
MC4yOTQ3MTFdIHNjc2kgaG9zdDE6IGFoY2kKWyAgICAwLjI5NDgyMV0gc2NzaSBob3N0Mjog
YWhjaQpbICAgIDAuMjk0ODUxXSBhdGExOiBEVU1NWQpbICAgIDAuMjk0ODUzXSBhdGEyOiBE
VU1NWQpbICAgIDAuMjk0ODU2XSBhdGEzOiBTQVRBIG1heCBVRE1BLzEzMyBhYmFyIG0yMDQ4
QDB4NjM1MTYwMDAgcG9ydCAweDYzNTE2MjAwIGlycSAxMjYKWyAgICAwLjI5NDkzMl0gaTgw
NDI6IFBOUDogUFMvMiBDb250cm9sbGVyIFtQTlAwMzAzOktCRDBdIGF0IDB4NjAsMHg2NCBp
cnEgMQpbICAgIDAuMjk0OTM3XSBpODA0MjogUE5QOiBQUy8yIGFwcGVhcnMgdG8gaGF2ZSBB
VVggcG9ydCBkaXNhYmxlZCwgaWYgdGhpcyBpcyBpbmNvcnJlY3QgcGxlYXNlIGJvb3Qgd2l0
aCBpODA0Mi5ub3BucApbICAgIDAuMjk1MzMyXSBzZXJpbzogaTgwNDIgS0JEIHBvcnQgYXQg
MHg2MCwweDY0IGlycSAxClsgICAgMC4yOTU1NTZdIG1vdXNlZGV2OiBQUy8yIG1vdXNlIGRl
dmljZSBjb21tb24gZm9yIGFsbCBtaWNlClsgICAgMC4yOTU3NTZdIGludGVsX3BzdGF0ZTog
SW50ZWwgUC1zdGF0ZSBkcml2ZXIgaW5pdGlhbGl6aW5nClsgICAgMC4yOTYwMTddIGludGVs
X3BzdGF0ZTogRGlzYWJsaW5nIGVuZXJneSBlZmZpY2llbmN5IG9wdGltaXphdGlvbgpbICAg
IDAuMjk2MDIwXSBpbnRlbF9wc3RhdGU6IEhXUCBlbmFibGVkClsgICAgMC4yOTYwNTZdIGxl
ZHRyaWctY3B1OiByZWdpc3RlcmVkIHRvIGluZGljYXRlIGFjdGl2aXR5IG9uIENQVXMKWyAg
ICAwLjI5NjA2MV0gc3lzZmI6IGluYWNjZXNzaWJsZSBWUkFNIGJhc2UKWyAgICAwLjI5NjEw
NV0gaGlkOiByYXcgSElEIGV2ZW50cyBkcml2ZXIgKEMpIEppcmkgS29zaW5hClsgICAgMC4y
OTYxOTddIE5FVDogUmVnaXN0ZXJlZCBQRl9JTkVUNiBwcm90b2NvbCBmYW1pbHkKWyAgICAw
LjMwNDkxOV0gaW5wdXQ6IEFUIFRyYW5zbGF0ZWQgU2V0IDIga2V5Ym9hcmQgYXMgL2Rldmlj
ZXMvcGxhdGZvcm0vaTgwNDIvc2VyaW8wL2lucHV0L2lucHV0MApbICAgIDAuMzUxNjEwXSBG
cmVlaW5nIGluaXRyZCBtZW1vcnk6IDIwNTI4SwpbICAgIDAuMzU3NjUyXSBTZWdtZW50IFJv
dXRpbmcgd2l0aCBJUHY2ClsgICAgMC4zNTc2NTZdIFJQTCBTZWdtZW50IFJvdXRpbmcgd2l0
aCBJUHY2ClsgICAgMC4zNTc2NjVdIEluLXNpdHUgT0FNIChJT0FNKSB3aXRoIElQdjYKWyAg
ICAwLjM1ODQ1NF0gbWljcm9jb2RlOiBNaWNyb2NvZGUgVXBkYXRlIERyaXZlcjogdjIuMi4K
WyAgICAwLjM1ODQ1OV0gSVBJIHNob3J0aGFuZCBicm9hZGNhc3Q6IGVuYWJsZWQKWyAgICAw
LjM1OTE5NV0gc2NoZWRfY2xvY2s6IE1hcmtpbmcgc3RhYmxlICgzNTUwMDEyODMsIDM4OTI2
ODkpLT4oMzY4ODI3Nzc1LCAtOTkzMzgwMykKWyAgICAwLjM1OTM1OV0gcmVnaXN0ZXJlZCB0
YXNrc3RhdHMgdmVyc2lvbiAxClsgICAgMC4zNTkzOTddIExvYWRpbmcgY29tcGlsZWQtaW4g
WC41MDkgY2VydGlmaWNhdGVzClsgICAgMC4zNTk4NzFdIExvYWRlZCBYLjUwOSBjZXJ0ICdC
dWlsZCB0aW1lIGF1dG9nZW5lcmF0ZWQga2VybmVsIGtleTogZjQ2NDdlNTliNzA1NThkMGE4
NjBiNzdjZGE4ODkwNzlkOTExZGI5OScKWyAgICAwLjM2MDcyNV0gS2V5IHR5cGUgLmZzY3J5
cHQgcmVnaXN0ZXJlZApbICAgIDAuMzYwNzI4XSBLZXkgdHlwZSBmc2NyeXB0LXByb3Zpc2lv
bmluZyByZWdpc3RlcmVkClsgICAgMC4zNjM1MjBdIEtleSB0eXBlIGVuY3J5cHRlZCByZWdp
c3RlcmVkClsgICAgMC4zNjUwNzRdIExvYWRpbmcgY29tcGlsZWQtaW4gbW9kdWxlIFguNTA5
IGNlcnRpZmljYXRlcwpbICAgIDAuMzY1NDgwXSBMb2FkZWQgWC41MDkgY2VydCAnQnVpbGQg
dGltZSBhdXRvZ2VuZXJhdGVkIGtlcm5lbCBrZXk6IGY0NjQ3ZTU5YjcwNTU4ZDBhODYwYjc3
Y2RhODg5MDc5ZDkxMWRiOTknClsgICAgMC4zNjU0ODNdIGltYTogQWxsb2NhdGVkIGhhc2gg
YWxnb3JpdGhtOiBzaGEyNTYKWyAgICAwLjM3OTEwM10gaW1hOiBObyBhcmNoaXRlY3R1cmUg
cG9saWNpZXMgZm91bmQKWyAgICAwLjM3OTExNV0gZXZtOiBJbml0aWFsaXNpbmcgRVZNIGV4
dGVuZGVkIGF0dHJpYnV0ZXM6ClsgICAgMC4zNzkxMTddIGV2bTogc2VjdXJpdHkuc2VsaW51
eApbICAgIDAuMzc5MTE5XSBldm06IHNlY3VyaXR5LlNNQUNLNjQgKGRpc2FibGVkKQpbICAg
IDAuMzc5MTIwXSBldm06IHNlY3VyaXR5LlNNQUNLNjRFWEVDIChkaXNhYmxlZCkKWyAgICAw
LjM3OTEyMl0gZXZtOiBzZWN1cml0eS5TTUFDSzY0VFJBTlNNVVRFIChkaXNhYmxlZCkKWyAg
ICAwLjM3OTEyM10gZXZtOiBzZWN1cml0eS5TTUFDSzY0TU1BUCAoZGlzYWJsZWQpClsgICAg
MC4zNzkxMjRdIGV2bTogc2VjdXJpdHkuYXBwYXJtb3IKWyAgICAwLjM3OTEyNl0gZXZtOiBz
ZWN1cml0eS5pbWEKWyAgICAwLjM3OTEyN10gZXZtOiBzZWN1cml0eS5jYXBhYmlsaXR5Clsg
ICAgMC4zNzkxMjhdIGV2bTogSE1BQyBhdHRyczogMHgxClsgICAgMC4zNzkyMTFdIFBNOiAg
IE1hZ2ljIG51bWJlcjogMTU6NTcwOjE5NApbICAgIDAuMzc5NDI4XSBSQVM6IENvcnJlY3Rh
YmxlIEVycm9ycyBjb2xsZWN0b3IgaW5pdGlhbGl6ZWQuClsgICAgMC42MDg5MDJdIGF0YTM6
IFNBVEEgbGluayB1cCA2LjAgR2JwcyAoU1N0YXR1cyAxMzMgU0NvbnRyb2wgMzAwKQpbICAg
IDAuNjExMTY2XSBhdGEzLjAwOiBzdXBwb3J0cyBEUk0gZnVuY3Rpb25zIGFuZCBtYXkgbm90
IGJlIGZ1bGx5IGFjY2Vzc2libGUKWyAgICAwLjYxMTE3N10gYXRhMy4wMDogQVRBLTk6IFNh
bXN1bmcgU1NEIDg1MCBQUk8gNTEyR0IsIEVYTTAyQjZRLCBtYXggVURNQS8xMzMKWyAgICAw
LjYxNzAxM10gYXRhMy4wMDogMTAwMDIxNTIxNiBzZWN0b3JzLCBtdWx0aSAxOiBMQkE0OCBO
Q1EgKGRlcHRoIDMyKSwgQUEKWyAgICAwLjYyODc1Nl0gYXRhMy4wMDogRmVhdHVyZXM6IFRy
dXN0IERldi1TbGVlcCBOQ1Etc25kcmN2ClsgICAgMC42MjkyODhdIGF0YTMuMDA6IHN1cHBv
cnRzIERSTSBmdW5jdGlvbnMgYW5kIG1heSBub3QgYmUgZnVsbHkgYWNjZXNzaWJsZQpbICAg
IDAuNjQ2ODYxXSBhdGEzLjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzEzMwpbICAgIDAuNjQ3
MTA3XSBzY3NpIDI6MDowOjA6IERpcmVjdC1BY2Nlc3MgICAgIEFUQSAgICAgIFNhbXN1bmcg
U1NEIDg1MCAgMkI2USBQUTogMCBBTlNJOiA1ClsgICAgMC42NDc4NzBdIHNkIDI6MDowOjA6
IFtzZGFdIDEwMDAyMTUyMTYgNTEyLWJ5dGUgbG9naWNhbCBibG9ja3M6ICg1MTIgR0IvNDc3
IEdpQikKWyAgICAwLjY0NzkwNl0gc2QgMjowOjA6MDogW3NkYV0gV3JpdGUgUHJvdGVjdCBp
cyBvZmYKWyAgICAwLjY0NzkxNl0gc2QgMjowOjA6MDogW3NkYV0gTW9kZSBTZW5zZTogMDAg
M2EgMDAgMDAKWyAgICAwLjY0Nzk4NF0gc2QgMjowOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6
IGVuYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3Ig
RlVBClsgICAgMC42NDgwOThdIHNkIDI6MDowOjA6IFtzZGFdIFByZWZlcnJlZCBtaW5pbXVt
IEkvTyBzaXplIDUxMiBieXRlcwpbICAgIDAuNjQ5OTE5XSAgc2RhOiBzZGExIHNkYTIgc2Rh
MyBzZGE0ClsgICAgMC42NTA0MzldIHNkIDI6MDowOjA6IFtzZGFdIHN1cHBvcnRzIFRDRyBP
cGFsClsgICAgMC42NTA0NDVdIHNkIDI6MDowOjA6IFtzZGFdIEF0dGFjaGVkIFNDU0kgZGlz
awpbICAgIDAuNjUwNDk2XSBjbGs6IERpc2FibGluZyB1bnVzZWQgY2xvY2tzClsgICAgMC42
NTA5NjhdIEZyZWVpbmcgdW51c2VkIGtlcm5lbCBpbWFnZSAoaW5pdG1lbSkgbWVtb3J5OiAx
NDQ0SwpbICAgIDAuNjU2OTg2XSBXcml0ZSBwcm90ZWN0aW5nIHRoZSBrZXJuZWwgcmVhZC1v
bmx5IGRhdGE6IDE2Mzg0awpbICAgIDAuNjU3NjQwXSBGcmVlaW5nIHVudXNlZCBrZXJuZWwg
aW1hZ2UgKHJvZGF0YS9kYXRhIGdhcCkgbWVtb3J5OiAxOTI4SwpbICAgIDAuNjU3NzMzXSBS
dW4gL2luaXQgYXMgaW5pdCBwcm9jZXNzClsgICAgMC42NTc3MzddICAgd2l0aCBhcmd1bWVu
dHM6ClsgICAgMC42NTc3MzddICAgICAvaW5pdApbICAgIDAuNjU3NzM4XSAgIHdpdGggZW52
aXJvbm1lbnQ6ClsgICAgMC42NTc3MzldICAgICBIT01FPS8KWyAgICAwLjY1Nzc0MF0gICAg
IFRFUk09bGludXgKWyAgICAwLjY1Nzc0MV0gICAgIEJPT1RfSU1BR0U9L2Jvb3Qvdm1saW51
ei02LjQuMC1kZXNrdG9wLWFjZXJmYW4rClsgICAgMC42NTc3NDJdICAgICBzcGxhc2g9c2ls
ZW50ClsgICAgMC42NjU2NTJdIGVmaXZhcmZzOiBtb2R1bGUgdmVyaWZpY2F0aW9uIGZhaWxl
ZDogc2lnbmF0dXJlIGFuZC9vciByZXF1aXJlZCBrZXkgbWlzc2luZyAtIHRhaW50aW5nIGtl
cm5lbApbICAgIDAuNzMyMTQ2XSBzeXN0ZW1kWzFdOiBzeXN0ZW1kIDI1My41K3N1c2UuMjku
ZzA3YmIxMmEyODIgcnVubmluZyBpbiBzeXN0ZW0gbW9kZSAoK1BBTSArQVVESVQgK1NFTElO
VVggK0FQUEFSTU9SICtJTUEgLVNNQUNLICtTRUNDT01QICtHQ1JZUFQgK0dOVVRMUyArT1BF
TlNTTCArQUNMICtCTEtJRCArQ1VSTCArRUxGVVRJTFMgK0ZJRE8yICtJRE4yIC1JRE4gK0lQ
VEMgK0tNT0QgK0xJQkNSWVBUU0VUVVAgK0xJQkZESVNLICtQQ1JFMiArUFdRVUFMSVRZICtQ
MTFLSVQgK1FSRU5DT0RFICtUUE0yICtCWklQMiArTFo0ICtYWiArWkxJQiArWlNURCArQlBG
X0ZSQU1FV09SSyAtWEtCQ09NTU9OICtVVE1QICtTWVNWSU5JVCBkZWZhdWx0LWhpZXJhcmNo
eT11bmlmaWVkKQpbICAgIDAuNzMyMTU2XSBzeXN0ZW1kWzFdOiBEZXRlY3RlZCBhcmNoaXRl
Y3R1cmUgeDg2LTY0LgpbICAgIDAuNzMyMTU5XSBzeXN0ZW1kWzFdOiBSdW5uaW5nIGluIGlu
aXRyZC4KWyAgICAwLjczMjI3MF0gc3lzdGVtZFsxXTogSG9zdG5hbWUgc2V0IHRvIDxzaWVi
ZW4+LgpbICAgIDAuNzk0MzQ3XSBzeXN0ZW1kWzFdOiBRdWV1ZWQgc3RhcnQgam9iIGZvciBk
ZWZhdWx0IHRhcmdldCBJbml0cmQgRGVmYXVsdCBUYXJnZXQuClsgICAgMC44MDQ1NzFdIHN5
c3RlbWRbMV06IENyZWF0ZWQgc2xpY2UgU2xpY2UgL3N5c3RlbS9zeXN0ZW1kLWhpYmVybmF0
ZS1yZXN1bWUuClsgICAgMC44MDQ2ODldIHN5c3RlbWRbMV06IFN0YXJ0ZWQgRGlzcGF0Y2gg
UGFzc3dvcmQgUmVxdWVzdHMgdG8gQ29uc29sZSBEaXJlY3RvcnkgV2F0Y2guClsgICAgMC44
MDQ3NTNdIHN5c3RlbWRbMV06IFJlYWNoZWQgdGFyZ2V0IEluaXRyZCAvdXNyIEZpbGUgU3lz
dGVtLgpbICAgIDAuODA0NzkyXSBzeXN0ZW1kWzFdOiBSZWFjaGVkIHRhcmdldCBQYXRoIFVu
aXRzLgpbICAgIDAuODA0ODI5XSBzeXN0ZW1kWzFdOiBSZWFjaGVkIHRhcmdldCBTbGljZSBV
bml0cy4KWyAgICAwLjgwNDg2Ml0gc3lzdGVtZFsxXTogUmVhY2hlZCB0YXJnZXQgU3dhcHMu
ClsgICAgMC44MDQ5MDFdIHN5c3RlbWRbMV06IFJlYWNoZWQgdGFyZ2V0IFRpbWVyIFVuaXRz
LgpbICAgIDAuODA1MDE2XSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gSm91cm5hbCBTb2Nr
ZXQgKC9kZXYvbG9nKS4KWyAgICAwLjgwNTEyNl0gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9u
IEpvdXJuYWwgU29ja2V0LgpbICAgIDAuODA1MjQ3XSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcg
b24gdWRldiBDb250cm9sIFNvY2tldC4KWyAgICAwLjgwNTM0M10gc3lzdGVtZFsxXTogTGlz
dGVuaW5nIG9uIHVkZXYgS2VybmVsIFNvY2tldC4KWyAgICAwLjgwNTM3OV0gc3lzdGVtZFsx
XTogUmVhY2hlZCB0YXJnZXQgU29ja2V0IFVuaXRzLgpbICAgIDAuODA2MzkyXSBzeXN0ZW1k
WzFdOiBTdGFydGVkIEVudHJvcHkgRGFlbW9uIGJhc2VkIG9uIHRoZSBIQVZFR0UgYWxnb3Jp
dGhtLgpbICAgIDAuODA3MTEyXSBzeXN0ZW1kWzFdOiBTdGFydGluZyBDcmVhdGUgTGlzdCBv
ZiBTdGF0aWMgRGV2aWNlIE5vZGVzLi4uClsgICAgMC44MDgxNzBdIHN5c3RlbWRbMV06IFN0
YXJ0aW5nIEpvdXJuYWwgU2VydmljZS4uLgpbICAgIDAuODA4ODczXSBzeXN0ZW1kWzFdOiBT
dGFydGluZyBMb2FkIEtlcm5lbCBNb2R1bGVzLi4uClsgICAgMC44MDk0ODFdIHN5c3RlbWRb
MV06IFN0YXJ0aW5nIFNldHVwIFZpcnR1YWwgQ29uc29sZS4uLgpbICAgIDAuODEwMTAzXSBz
eXN0ZW1kWzFdOiBGaW5pc2hlZCBDcmVhdGUgTGlzdCBvZiBTdGF0aWMgRGV2aWNlIE5vZGVz
LgpbICAgIDAuODEwODU5XSBzeXN0ZW1kWzFdOiBTdGFydGluZyBDcmVhdGUgU3RhdGljIERl
dmljZSBOb2RlcyBpbiAvZGV2Li4uClsgICAgMC44MTM5MzBdIGFsdWE6IGRldmljZSBoYW5k
bGVyIHJlZ2lzdGVyZWQKWyAgICAwLjgxNDExM10gZW1jOiBkZXZpY2UgaGFuZGxlciByZWdp
c3RlcmVkClsgICAgMC44MTQzMDVdIHJkYWM6IGRldmljZSBoYW5kbGVyIHJlZ2lzdGVyZWQK
WyAgICAwLjgxNjA4NV0gc3lzdGVtZFsxXTogRmluaXNoZWQgQ3JlYXRlIFN0YXRpYyBEZXZp
Y2UgTm9kZXMgaW4gL2Rldi4KWyAgICAwLjgxNjY2Ml0gZGV2aWNlLW1hcHBlcjogY29yZTog
Q09ORklHX0lNQV9ESVNBQkxFX0hUQUJMRSBpcyBkaXNhYmxlZC4gRHVwbGljYXRlIElNQSBt
ZWFzdXJlbWVudHMgd2lsbCBub3QgYmUgcmVjb3JkZWQgaW4gdGhlIElNQSBsb2cuClsgICAg
MC44MTY2OTFdIGRldmljZS1tYXBwZXI6IHVldmVudDogdmVyc2lvbiAxLjAuMwpbICAgIDAu
ODE2NzU4XSBkZXZpY2UtbWFwcGVyOiBpb2N0bDogNC40OC4wLWlvY3RsICgyMDIzLTAzLTAx
KSBpbml0aWFsaXNlZDogZG0tZGV2ZWxAcmVkaGF0LmNvbQpbICAgIDAuODE3Nzk3XSBzZCAy
OjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2cwIHR5cGUgMApbICAgIDAuODE4MDE1
XSBzeXN0ZW1kLWpvdXJuYWxkWzE2Ml06IENvbGxlY3RpbmcgYXVkaXQgbWVzc2FnZXMgaXMg
ZGlzYWJsZWQuClsgICAgMC44MTg1MDldIHN5c3RlbWRbMV06IEZpbmlzaGVkIExvYWQgS2Vy
bmVsIE1vZHVsZXMuClsgICAgMC44MzEwODNdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIEFwcGx5
IEtlcm5lbCBWYXJpYWJsZXMuLi4KWyAgICAwLjgzNTE4Ml0gc3lzdGVtZFsxXTogRmluaXNo
ZWQgQXBwbHkgS2VybmVsIFZhcmlhYmxlcy4KWyAgICAwLjgzNjM1N10gc3lzdGVtZFsxXTog
U3RhcnRlZCBKb3VybmFsIFNlcnZpY2UuClsgICAgMS4wMzc5MzRdIGlucHV0OiBMaWQgU3dp
dGNoIGFzIC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFNZQlVTOjAwL1BOUDBDMEQ6MDAvaW5w
dXQvaW5wdXQxClsgICAgMS4wMzgwMTVdIEFDUEk6IGJ1dHRvbjogTGlkIFN3aXRjaCBbTElE
MF0KWyAgICAxLjAzODA2Ml0gaW5wdXQ6IFNsZWVwIEJ1dHRvbiBhcyAvZGV2aWNlcy9MTlhT
WVNUTTowMC9MTlhTWUJVUzowMC9QTlAwQzBFOjAwL2lucHV0L2lucHV0MgpbICAgIDEuMDM4
MTIwXSBBQ1BJOiBidXR0b246IFNsZWVwIEJ1dHRvbiBbU0xQQl0KWyAgICAxLjAzODE2OV0g
aW5wdXQ6IFBvd2VyIEJ1dHRvbiBhcyAvZGV2aWNlcy9MTlhTWVNUTTowMC9MTlhQV1JCTjow
MC9pbnB1dC9pbnB1dDMKWyAgICAxLjAzODQ0MV0gQUNQSTogYnV0dG9uOiBQb3dlciBCdXR0
b24gW1BXUkZdClsgICAgMS4wNDAyNTldIHdtaV9idXMgd21pX2J1cy1QTlAwQzE0OjAxOiBX
USBkYXRhIGJsb2NrIHF1ZXJ5IGNvbnRyb2wgbWV0aG9kIG5vdCBmb3VuZApbICAgIDEuMDQw
Mjc1XSB3bWlfYnVzIHdtaV9idXMtUE5QMEMxNDowMTogV1EgZGF0YSBibG9jayBxdWVyeSBj
b250cm9sIG1ldGhvZCBub3QgZm91bmQKWyAgICAxLjA0MDI4OF0gd21pX2J1cyB3bWlfYnVz
LVBOUDBDMTQ6MDE6IFdRIGRhdGEgYmxvY2sgcXVlcnkgY29udHJvbCBtZXRob2Qgbm90IGZv
dW5kClsgICAgMS4wNDAzMDFdIHdtaV9idXMgd21pX2J1cy1QTlAwQzE0OjAxOiBXUSBkYXRh
IGJsb2NrIHF1ZXJ5IGNvbnRyb2wgbWV0aG9kIG5vdCBmb3VuZApbICAgIDEuMDU2MTI3XSBB
Q1BJOiBidXMgdHlwZSBVU0IgcmVnaXN0ZXJlZApbICAgIDEuMDU2MTU3XSB1c2Jjb3JlOiBy
ZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYmZzClsgICAgMS4wNTYxNjldIHVz
YmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgaHViClsgICAgMS4wNTYx
ODNdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGRldmljZSBkcml2ZXIgdXNiClsgICAgMS4w
NjAxMTFdIEFDUEk6IGJ1cyB0eXBlIGRybV9jb25uZWN0b3IgcmVnaXN0ZXJlZApbICAgIDEu
MDYyNDQ4XSB4aGNpX2hjZCAwMDAwOjAwOjE0LjA6IHhIQ0kgSG9zdCBDb250cm9sbGVyClsg
ICAgMS4wNjI0NjNdIHhoY2lfaGNkIDAwMDA6MDA6MTQuMDogbmV3IFVTQiBidXMgcmVnaXN0
ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAxClsgICAgMS4wNjM1MzZdIGNyeXB0ZDogbWF4
X2NwdV9xbGVuIHNldCB0byAxMDAwClsgICAgMS4wNjM1OThdIHhoY2lfaGNkIDAwMDA6MDA6
MTQuMDogaGNjIHBhcmFtcyAweDIwMDA3N2MxIGhjaSB2ZXJzaW9uIDB4MTAwIHF1aXJrcyAw
eDAwMDAwMDAwMDExMDk4MTAKWyAgICAxLjA2NDIwNl0geGhjaV9oY2QgMDAwMDowMDoxNC4w
OiB4SENJIEhvc3QgQ29udHJvbGxlcgpbICAgIDEuMDY0MjE3XSB4aGNpX2hjZCAwMDAwOjAw
OjE0LjA6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgMgpb
ICAgIDEuMDY0MjI1XSB4aGNpX2hjZCAwMDAwOjAwOjE0LjA6IEhvc3Qgc3VwcG9ydHMgVVNC
IDMuMCBTdXBlclNwZWVkClsgICAgMS4wNjQyNzJdIHVzYiB1c2IxOiBOZXcgVVNCIGRldmlj
ZSBmb3VuZCwgaWRWZW5kb3I9MWQ2YiwgaWRQcm9kdWN0PTAwMDIsIGJjZERldmljZT0gNi4w
NApbICAgIDEuMDY0Mjc4XSB1c2IgdXNiMTogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZy
PTMsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTEKWyAgICAxLjA2NDI4M10gdXNiIHVzYjE6
IFByb2R1Y3Q6IHhIQ0kgSG9zdCBDb250cm9sbGVyClsgICAgMS4wNjQyODZdIHVzYiB1c2Ix
OiBNYW51ZmFjdHVyZXI6IExpbnV4IDYuNC4wLWRlc2t0b3AtYWNlcmZhbisgeGhjaS1oY2QK
WyAgICAxLjA2NDI4OV0gdXNiIHVzYjE6IFNlcmlhbE51bWJlcjogMDAwMDowMDoxNC4wClsg
ICAgMS4wNjQ0ODVdIGh1YiAxLTA6MS4wOiBVU0IgaHViIGZvdW5kClsgICAgMS4wNjQ1MjRd
IGh1YiAxLTA6MS4wOiAxNiBwb3J0cyBkZXRlY3RlZApbICAgIDEuMDY3NTQ1XSBBVlgyIHZl
cnNpb24gb2YgZ2NtX2VuYy9kZWMgZW5nYWdlZC4KWyAgICAxLjA2NzU4N10gQUVTIENUUiBt
b2RlIGJ5OCBvcHRpbWl6YXRpb24gZW5hYmxlZApbICAgIDEuMDg4NTMwXSB1c2IgdXNiMjog
TmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTFkNmIsIGlkUHJvZHVjdD0wMDAzLCBi
Y2REZXZpY2U9IDYuMDQKWyAgICAxLjA4ODUzN10gdXNiIHVzYjI6IE5ldyBVU0IgZGV2aWNl
IHN0cmluZ3M6IE1mcj0zLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0xClsgICAgMS4wODg1
NDBdIHVzYiB1c2IyOiBQcm9kdWN0OiB4SENJIEhvc3QgQ29udHJvbGxlcgpbICAgIDEuMDg4
NTQyXSB1c2IgdXNiMjogTWFudWZhY3R1cmVyOiBMaW51eCA2LjQuMC1kZXNrdG9wLWFjZXJm
YW4rIHhoY2ktaGNkClsgICAgMS4wODg1NDVdIHVzYiB1c2IyOiBTZXJpYWxOdW1iZXI6IDAw
MDA6MDA6MTQuMApbICAgIDEuMDg4NjIwXSBodWIgMi0wOjEuMDogVVNCIGh1YiBmb3VuZApb
ICAgIDEuMDg4NjQxXSBodWIgMi0wOjEuMDogOCBwb3J0cyBkZXRlY3RlZApbICAgIDEuMDg4
OTM1XSB1c2I6IHBvcnQgcG93ZXIgbWFuYWdlbWVudCBtYXkgYmUgdW5yZWxpYWJsZQpbICAg
IDEuMDg5ODQ0XSBzeXN0ZW1kLWpvdXJuYWxkWzE2Ml06IERhdGEgaGFzaCB0YWJsZSBvZiAv
cnVuL2xvZy9qb3VybmFsL2MxNzdiMzM4YjlhMzRjODBhYmE2MTE0M2MyM2JkYTVjL3N5c3Rl
bS5qb3VybmFsIGhhcyBhIGZpbGwgbGV2ZWwgYXQgNzUuMSAoMTcwOSBvZiAyMjc1IGl0ZW1z
LCAxMzEwNzIwIGZpbGUgc2l6ZSwgNzY2IGJ5dGVzIHBlciBoYXNoIHRhYmxlIGl0ZW0pLCBz
dWdnZXN0aW5nIHJvdGF0aW9uLgpbICAgIDEuMDg5ODU2XSBzeXN0ZW1kLWpvdXJuYWxkWzE2
Ml06IC9ydW4vbG9nL2pvdXJuYWwvYzE3N2IzMzhiOWEzNGM4MGFiYTYxMTQzYzIzYmRhNWMv
c3lzdGVtLmpvdXJuYWw6IEpvdXJuYWwgaGVhZGVyIGxpbWl0cyByZWFjaGVkIG9yIGhlYWRl
ciBvdXQtb2YtZGF0ZSwgcm90YXRpbmcuClsgICAgMS4wOTk1NTFdIEFDUEkgV2FybmluZzog
XF9TQi5QQ0kwLlBFRzAuUEVHUC5fRFNNOiBBcmd1bWVudCAjNCB0eXBlIG1pc21hdGNoIC0g
Rm91bmQgW0J1ZmZlcl0sIEFDUEkgcmVxdWlyZXMgW1BhY2thZ2VdICgyMDIzMDMzMS9uc2Fy
Z3VtZW50cy02MSkKWyAgICAxLjEwMDI5Ml0gcGNpIDAwMDA6MDE6MDAuMDogb3B0aW11cyBj
YXBhYmlsaXRpZXM6IGVuYWJsZWQsIHN0YXR1cyBkeW5hbWljIHBvd2VyLCBoZGEgYmlvcyBj
b2RlYyBzdXBwb3J0ZWQKWyAgICAxLjEwMDMwMl0gVkdBIHN3aXRjaGVyb286IGRldGVjdGVk
IE9wdGltdXMgRFNNIG1ldGhvZCBcX1NCXy5QQ0kwLlBFRzAuUEVHUCBoYW5kbGUKWyAgICAx
LjEwMDMwNV0gbm91dmVhdTogZGV0ZWN0ZWQgUFIgc3VwcG9ydCwgd2lsbCBub3QgdXNlIERT
TQpbICAgIDEuMTAwMzI1XSBub3V2ZWF1IDAwMDA6MDE6MDAuMDogZW5hYmxpbmcgZGV2aWNl
ICgwMDA2IC0+IDAwMDcpClsgICAgMS4xMDA2NDddIG5vdXZlYXUgMDAwMDowMTowMC4wOiBO
VklESUEgR1AxMDYgKDEzNjAwMGExKQpbICAgIDEuMTMwMDI3XSBpOTE1IDAwMDA6MDA6MDIu
MDogdmdhYXJiOiBkZWFjdGl2YXRlIHZnYSBjb25zb2xlClsgICAgMS4xMzIxNDNdIGk5MTUg
MDAwMDowMDowMi4wOiB2Z2FhcmI6IGNoYW5nZWQgVkdBIGRlY29kZXM6IG9sZGRlY29kZXM9
aW8rbWVtLGRlY29kZXM9bm9uZTpvd25zPWlvK21lbQpbICAgIDEuMTQyNTE1XSBpOTE1IDAw
MDA6MDA6MDIuMDogW2RybV0gRmluaXNoZWQgbG9hZGluZyBETUMgZmlybXdhcmUgaTkxNS9r
YmxfZG1jX3ZlcjFfMDQuYmluICh2MS40KQpbICAgIDEuMjg4OTY1XSB0c2M6IFJlZmluZWQg
VFNDIGNsb2Nrc291cmNlIGNhbGlicmF0aW9uOiAyODA4LjA0NSBNSHoKWyAgICAxLjI4OTAw
OV0gY2xvY2tzb3VyY2U6IHRzYzogbWFzazogMHhmZmZmZmZmZmZmZmZmZmZmIG1heF9jeWNs
ZXM6IDB4Mjg3OWYwYmM5YzcsIG1heF9pZGxlX25zOiA0NDA3OTUyODU3NjggbnMKWyAgICAx
LjI4OTA4NV0gY2xvY2tzb3VyY2U6IFN3aXRjaGVkIHRvIGNsb2Nrc291cmNlIHRzYwpbICAg
IDEuMzMwOTE0XSB1c2IgMS0xOiBuZXcgbG93LXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDIg
dXNpbmcgeGhjaV9oY2QKWyAgICAxLjM0OTA2OF0gaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1d
IFtFTkNPREVSOjk0OkRESSBBL1BIWSBBXSBpcyBkaXNhYmxlZC9pbiBEU0kgbW9kZSB3aXRo
IGFuIHVuZ2F0ZWQgRERJIGNsb2NrLCBnYXRlIGl0ClsgICAgMS4zNDkwOTddIGk5MTUgMDAw
MDowMDowMi4wOiBbZHJtXSBbRU5DT0RFUjoxMDI6RERJIEIvUEhZIEJdIGlzIGRpc2FibGVk
L2luIERTSSBtb2RlIHdpdGggYW4gdW5nYXRlZCBEREkgY2xvY2ssIGdhdGUgaXQKWyAgICAx
LjM0OTEyN10gaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1dIFtFTkNPREVSOjExODpEREkgQy9Q
SFkgQ10gaXMgZGlzYWJsZWQvaW4gRFNJIG1vZGUgd2l0aCBhbiB1bmdhdGVkIERESSBjbG9j
aywgZ2F0ZSBpdApbICAgIDEuMzUyMjY3XSBbZHJtXSBJbml0aWFsaXplZCBpOTE1IDEuNi4w
IDIwMjAxMTAzIGZvciAwMDAwOjAwOjAyLjAgb24gbWlub3IgMApbICAgIDEuMzUyOTQwXSBB
Q1BJOiB2aWRlbzogW0Zpcm13YXJlIEJ1Z106IEFDUEkoUEVHUCkgZGVmaW5lcyBfRE9EIGJ1
dCBub3QgX0RPUwpbICAgIDEuMzUyOTc2XSBBQ1BJOiB2aWRlbzogVmlkZW8gRGV2aWNlIFtQ
RUdQXSAobXVsdGktaGVhZDogeWVzICByb206IHllcyAgcG9zdDogbm8pClsgICAgMS4zNTMw
MThdIGlucHV0OiBWaWRlbyBCdXMgYXMgL2RldmljZXMvTE5YU1lTVE06MDAvTE5YU1lCVVM6
MDAvUE5QMEEwODowMC9kZXZpY2U6MDAvTE5YVklERU86MDAvaW5wdXQvaW5wdXQ0ClsgICAg
MS4zNTUwMDFdIEFDUEk6IHZpZGVvOiBWaWRlbyBEZXZpY2UgW0dGWDBdIChtdWx0aS1oZWFk
OiB5ZXMgIHJvbTogbm8gIHBvc3Q6IG5vKQpbICAgIDEuMzU1MTI4XSBpbnB1dDogVmlkZW8g
QnVzIGFzIC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFNZQlVTOjAwL1BOUDBBMDg6MDAvTE5Y
VklERU86MDEvaW5wdXQvaW5wdXQ1ClsgICAgMS40MjUzMTVdIG5vdXZlYXUgMDAwMDowMTow
MC4wOiBiaW9zOiB2ZXJzaW9uIDg2LjA2LjNhLjAwLjBmClsgICAgMS40MjY2MThdIG5vdXZl
YXUgMDAwMDowMTowMC4wOiBwbXU6IGZpcm13YXJlIHVuYXZhaWxhYmxlClsgICAgMS40NjMy
MjldIHVzYiAxLTE6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0wOTNhLCBpZFBy
b2R1Y3Q9MjUxMCwgYmNkRGV2aWNlPSAxLjAwClsgICAgMS40NjMyMzVdIHVzYiAxLTE6IE5l
dyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0w
ClsgICAgMS40NjMyMzhdIHVzYiAxLTE6IFByb2R1Y3Q6IFVTQiBPcHRpY2FsIE1vdXNlClsg
ICAgMS40NjMyNDBdIHVzYiAxLTE6IE1hbnVmYWN0dXJlcjogUGl4QXJ0ClsgICAgMS40Njcz
NDddIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXNiaGlkClsg
ICAgMS40NjczNTFdIHVzYmhpZDogVVNCIEhJRCBjb3JlIGRyaXZlcgpbICAgIDEuNDczNDEy
XSBub3V2ZWF1IDAwMDA6MDE6MDAuMDogZmI6IDYxNDQgTWlCIEdERFI1ClsgICAgMS41Nzg4
OTVdIHVzYiAxLTI6IG5ldyBsb3ctc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMyB1c2luZyB4
aGNpX2hjZApbICAgIDEuNzE0MjgyXSB1c2IgMS0yOiBOZXcgVVNCIGRldmljZSBmb3VuZCwg
aWRWZW5kb3I9MDQ2YSwgaWRQcm9kdWN0PWIwOTAsIGJjZERldmljZT0gMS4wMwpbICAgIDEu
NzE0Mjg3XSB1c2IgMS0yOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MSwgUHJvZHVj
dD0yLCBTZXJpYWxOdW1iZXI9MApbICAgIDEuNzE0MjkwXSB1c2IgMS0yOiBQcm9kdWN0OiBV
U0Iga2V5Ym9hcmQKWyAgICAxLjcxNDI5Ml0gdXNiIDEtMjogTWFudWZhY3R1cmVyOiBDaGVy
cnkKWyAgICAxLjcyNzc5MV0gaW5wdXQ6IFBpeEFydCBVU0IgT3B0aWNhbCBNb3VzZSBhcyAv
ZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MTQuMC91c2IxLzEtMS8xLTE6MS4wLzAwMDM6
MDkzQToyNTEwLjAwMDEvaW5wdXQvaW5wdXQ2ClsgICAgMS43Mjc4OTldIGhpZC1nZW5lcmlj
IDAwMDM6MDkzQToyNTEwLjAwMDE6IGlucHV0LGhpZHJhdzA6IFVTQiBISUQgdjEuMTEgTW91
c2UgW1BpeEFydCBVU0IgT3B0aWNhbCBNb3VzZV0gb24gdXNiLTAwMDA6MDA6MTQuMC0xL2lu
cHV0MApbICAgIDEuNzI4MDY1XSBpbnB1dDogQ2hlcnJ5IFVTQiBrZXlib2FyZCBhcyAvZGV2
aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MTQuMC91c2IxLzEtMi8xLTI6MS4wLzAwMDM6MDQ2
QTpCMDkwLjAwMDIvaW5wdXQvaW5wdXQ3ClsgICAgMS43ODAxMjZdIGhpZC1nZW5lcmljIDAw
MDM6MDQ2QTpCMDkwLjAwMDI6IGlucHV0LGhpZHJhdzE6IFVTQiBISUQgdjEuMTEgS2V5Ym9h
cmQgW0NoZXJyeSBVU0Iga2V5Ym9hcmRdIG9uIHVzYi0wMDAwOjAwOjE0LjAtMi9pbnB1dDAK
WyAgICAxLjc4MDMwN10gaW5wdXQ6IENoZXJyeSBVU0Iga2V5Ym9hcmQgU3lzdGVtIENvbnRy
b2wgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjE0LjAvdXNiMS8xLTIvMS0yOjEu
MS8wMDAzOjA0NkE6QjA5MC4wMDAzL2lucHV0L2lucHV0OApbICAgIDEuODIxMjk2XSBmYmNv
bjogaTkxNWRybWZiIChmYjApIGlzIHByaW1hcnkgZGV2aWNlClsgICAgMS44MjQ5NjVdIHZn
YV9zd2l0Y2hlcm9vOiBlbmFibGVkClsgICAgMS44MjUxMDhdIG5vdXZlYXUgMDAwMDowMTow
MC4wOiBEUk06IFZSQU06IDYxNDQgTWlCClsgICAgMS44MjUxMTBdIG5vdXZlYXUgMDAwMDow
MTowMC4wOiBEUk06IEdBUlQ6IDUzNjg3MDkxMiBNaUIKWyAgICAxLjgyNTExMl0gbm91dmVh
dSAwMDAwOjAxOjAwLjA6IERSTTogQklUIHRhYmxlICdBJyBub3QgZm91bmQKWyAgICAxLjgy
NTEzMV0gbm91dmVhdSAwMDAwOjAxOjAwLjA6IERSTTogQklUIHRhYmxlICdMJyBub3QgZm91
bmQKWyAgICAxLjgyNTEzMl0gbm91dmVhdSAwMDAwOjAxOjAwLjA6IERSTTogVE1EUyB0YWJs
ZSB2ZXJzaW9uIDIuMApbICAgIDEuODI1MTMzXSBub3V2ZWF1IDAwMDA6MDE6MDAuMDogRFJN
OiBEQ0IgdmVyc2lvbiA0LjEKWyAgICAxLjgyNTEzNF0gbm91dmVhdSAwMDAwOjAxOjAwLjA6
IERSTTogRENCIG91dHAgMDA6IDAyMDEyZjYyIDAwMDIwMDEwClsgICAgMS44MjUxMzVdIG5v
dXZlYXUgMDAwMDowMTowMC4wOiBEUk06IERDQiBjb25uIDAyOiAwMDAxMDI2MQpbICAgIDEu
ODI1MTM2XSBub3V2ZWF1IDAwMDA6MDE6MDAuMDogRFJNOiBEQ0IgY29ubiAwNDogMDEwMDA0
NDYKWyAgICAxLjgyNTEzN10gbm91dmVhdSAwMDAwOjAxOjAwLjA6IERSTTogRENCIGNvbm4g
MDU6IDAyMDAwNTQ2ClsgICAgMS44MjYyOTRdIG5vdXZlYXUgMDAwMDowMTowMC4wOiBmaWZv
OiBmYXVsdCAwMCBbUkVBRF0gYXQgMDAwMDAwMDAwMDAwMDAwMCBlbmdpbmUgMWYgW1BIWVNJ
Q0FMXSBjbGllbnQgMDcgW0hVQi9IT1NUX0NQVV0gcmVhc29uIDBkIFtSRUdJT05fVklPTEFU
SU9OXSBvbiBjaGFubmVsIC0xIFswMDAwMDAwMDAwIHVua25vd25dClsgICAgMS44MjY0NTRd
IG5vdXZlYXUgMDAwMDowMTowMC4wOiBEUk06IE1NOiB1c2luZyBDT1BZIGZvciBidWZmZXIg
Y29waWVzClsgICAgMS44MjgwNTZdIFtkcm1dIEluaXRpYWxpemVkIG5vdXZlYXUgMS4zLjEg
MjAxMjA4MDEgZm9yIDAwMDA6MDE6MDAuMCBvbiBtaW5vciAxClsgICAgMS44MzE2OTVdIEVY
VDQtZnMgKHNkYTMpOiBtb3VudGVkIGZpbGVzeXN0ZW0gMDg3NDZlMjYtNDM1Yy00OWUxLWE1
MjItMThkYmE2MjI5MjM5IHJvIHdpdGggb3JkZXJlZCBkYXRhIG1vZGUuIFF1b3RhIG1vZGU6
IG5vbmUuClsgICAgMS44MzIwNzBdIGlucHV0OiBDaGVycnkgVVNCIGtleWJvYXJkIENvbnN1
bWVyIENvbnRyb2wgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjE0LjAvdXNiMS8x
LTIvMS0yOjEuMS8wMDAzOjA0NkE6QjA5MC4wMDAzL2lucHV0L2lucHV0OQpbICAgIDEuODMy
MzE3XSBoaWQtZ2VuZXJpYyAwMDAzOjA0NkE6QjA5MC4wMDAzOiBpbnB1dCxoaWRkZXY5Nixo
aWRyYXcyOiBVU0IgSElEIHYxLjExIERldmljZSBbQ2hlcnJ5IFVTQiBrZXlib2FyZF0gb24g
dXNiLTAwMDA6MDA6MTQuMC0yL2lucHV0MQpbICAgIDEuODM5ODk4XSB1c2IgMS03OiBuZXcg
ZnVsbC1zcGVlZCBVU0IgZGV2aWNlIG51bWJlciA0IHVzaW5nIHhoY2lfaGNkClsgICAgMS45
NjczMjldIHVzYiAxLTc6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0wNDg5LCBp
ZFByb2R1Y3Q9ZTA5ZiwgYmNkRGV2aWNlPSAwLjAxClsgICAgMS45NjczMzJdIHVzYiAxLTc6
IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0wLCBQcm9kdWN0PTAsIFNlcmlhbE51bWJl
cj0wClsgICAgMi4wODM5OTVdIHVzYiAxLTk6IG5ldyBoaWdoLXNwZWVkIFVTQiBkZXZpY2Ug
bnVtYmVyIDUgdXNpbmcgeGhjaV9oY2QKWyAgICAyLjA5NzUwMV0gQ29uc29sZTogc3dpdGNo
aW5nIHRvIGNvbG91ciBmcmFtZSBidWZmZXIgZGV2aWNlIDI0MHg2NwpbICAgIDIuMTE3MjM3
XSBpOTE1IDAwMDA6MDA6MDIuMDogW2RybV0gZmIwOiBpOTE1ZHJtZmIgZnJhbWUgYnVmZmVy
IGRldmljZQpbICAgIDIuMTE3NDMzXSBub3V2ZWF1IDAwMDA6MDE6MDAuMDogW2RybV0gZmIx
OiBub3V2ZWF1ZHJtZmIgZnJhbWUgYnVmZmVyIGRldmljZQpbICAgIDIuMTIzOTg1XSBub3V2
ZWF1IDAwMDA6MDE6MDAuMDogRFJNOiBEaXNhYmxpbmcgUENJIHBvd2VyIG1hbmFnZW1lbnQg
dG8gYXZvaWQgYnVnClsgICAgMi4yMjE2NTldIHVzYiAxLTk6IE5ldyBVU0IgZGV2aWNlIGZv
dW5kLCBpZFZlbmRvcj0wNGYyLCBpZFByb2R1Y3Q9YjU3MSwgYmNkRGV2aWNlPTk5LjUyClsg
ICAgMi4yMjE2NjNdIHVzYiAxLTk6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0xLCBQ
cm9kdWN0PTIsIFNlcmlhbE51bWJlcj0wClsgICAgMi4yMjE2NjRdIHVzYiAxLTk6IFByb2R1
Y3Q6IEhEIFdlYkNhbQpbICAgIDIuMjIxNjY1XSB1c2IgMS05OiBNYW51ZmFjdHVyZXI6IENo
aWNvbnkgRWxlY3Ryb25pY3MgQ28uLEx0ZC4KWyAgICAyLjMzNzg5Nl0gdXNiIDEtMTA6IG5l
dyBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDYgdXNpbmcgeGhjaV9oY2QKWyAgICAy
LjQ2NTY3OV0gdXNiIDEtMTA6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0wYmRh
LCBpZFByb2R1Y3Q9MDEyOSwgYmNkRGV2aWNlPTM5LjYwClsgICAgMi40NjU2ODNdIHVzYiAx
LTEwOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MSwgUHJvZHVjdD0yLCBTZXJpYWxO
dW1iZXI9MwpbICAgIDIuNDY1Njg0XSB1c2IgMS0xMDogUHJvZHVjdDogVVNCMi4wLUNSVwpb
ICAgIDIuNDY1Njg1XSB1c2IgMS0xMDogTWFudWZhY3R1cmVyOiBHZW5lcmljClsgICAgMi40
NjU2ODVdIHVzYiAxLTEwOiBTZXJpYWxOdW1iZXI6IDIwMTAwMjAxMzk2MDAwMDAwClsgICAg
Mi40NzE0NjhdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgcnRz
eF91c2IKWyAgICAyLjU4Mjk4Nl0gdXNiIDEtMTE6IG5ldyBmdWxsLXNwZWVkIFVTQiBkZXZp
Y2UgbnVtYmVyIDcgdXNpbmcgeGhjaV9oY2QKWyAgICAyLjcxMzc3MF0gdXNiIDEtMTE6IE5l
dyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0wNGYzLCBpZFByb2R1Y3Q9MGMwMywgYmNk
RGV2aWNlPSAxLjM4ClsgICAgMi43MTM3NzVdIHVzYiAxLTExOiBOZXcgVVNCIGRldmljZSBz
dHJpbmdzOiBNZnI9MSwgUHJvZHVjdD0yLCBTZXJpYWxOdW1iZXI9MApbICAgIDIuNzEzNzc3
XSB1c2IgMS0xMTogUHJvZHVjdDogRUxBTjpGaW5nZXJwcmludApbICAgIDIuNzEzNzc4XSB1
c2IgMS0xMTogTWFudWZhY3R1cmVyOiBFTEFOClsgICAgMi43NDkxMThdIG1lbWZkX2NyZWF0
ZSgpIHdpdGhvdXQgTUZEX0VYRUMgbm9yIE1GRF9OT0VYRUNfU0VBTCwgcGlkPTEgJ3N5c3Rl
bWQnClsgICAgMi44MjEyOTddIHN5c3RlbWQtam91cm5hbGRbMTYyXTogUmVjZWl2ZWQgU0lH
VEVSTSBmcm9tIFBJRCAxIChzeXN0ZW1kKS4KWyAgICAyLjkwNzQ4MF0gc3lzdGVtZFsxXTog
c3lzdGVtZCAyNTMuNStzdXNlLjI5LmcwN2JiMTJhMjgyIHJ1bm5pbmcgaW4gc3lzdGVtIG1v
ZGUgKCtQQU0gK0FVRElUICtTRUxJTlVYICtBUFBBUk1PUiArSU1BIC1TTUFDSyArU0VDQ09N
UCArR0NSWVBUICtHTlVUTFMgK09QRU5TU0wgK0FDTCArQkxLSUQgK0NVUkwgK0VMRlVUSUxT
ICtGSURPMiArSUROMiAtSUROICtJUFRDICtLTU9EICtMSUJDUllQVFNFVFVQICtMSUJGRElT
SyArUENSRTIgK1BXUVVBTElUWSArUDExS0lUICtRUkVOQ09ERSArVFBNMiArQlpJUDIgK0xa
NCArWFogK1pMSUIgK1pTVEQgK0JQRl9GUkFNRVdPUksgLVhLQkNPTU1PTiArVVRNUCArU1lT
VklOSVQgZGVmYXVsdC1oaWVyYXJjaHk9dW5pZmllZCkKWyAgICAyLjkwODQ1MF0gc3lzdGVt
ZFsxXTogRGV0ZWN0ZWQgYXJjaGl0ZWN0dXJlIHg4Ni02NC4KWyAgICAyLjk1NjE2Nl0gc3lz
dGVtZFsxXTogYnBmLWxzbTogQlBGIExTTSBob29rIG5vdCBlbmFibGVkIGluIHRoZSBrZXJu
ZWwsIEJQRiBMU00gbm90IHN1cHBvcnRlZApbICAgIDMuMjY2ODkxXSBzeXN0ZW1kWzFdOiBp
bml0cmQtc3dpdGNoLXJvb3Quc2VydmljZTogRGVhY3RpdmF0ZWQgc3VjY2Vzc2Z1bGx5Lgpb
ICAgIDMuMjY3NjY3XSBzeXN0ZW1kWzFdOiBTdG9wcGVkIFN3aXRjaCBSb290LgpbICAgIDMu
MjcwMDcxXSBzeXN0ZW1kWzFdOiBzeXN0ZW1kLWpvdXJuYWxkLnNlcnZpY2U6IFNjaGVkdWxl
ZCByZXN0YXJ0IGpvYiwgcmVzdGFydCBjb3VudGVyIGlzIGF0IDEuClsgICAgMy4yNzExMzVd
IHN5c3RlbWRbMV06IENyZWF0ZWQgc2xpY2UgU2xpY2UgL3N5c3RlbS9nZXR0eS4KWyAgICAz
LjI3MzUzN10gc3lzdGVtZFsxXTogQ3JlYXRlZCBzbGljZSBTbGljZSAvc3lzdGVtL21vZHBy
b2JlLgpbICAgIDMuMjc1OTkyXSBzeXN0ZW1kWzFdOiBDcmVhdGVkIHNsaWNlIFNsaWNlIC9z
eXN0ZW0vc3lzdGVtZC1mc2NrLgpbICAgIDMuMjc4MjYxXSBzeXN0ZW1kWzFdOiBDcmVhdGVk
IHNsaWNlIFVzZXIgYW5kIFNlc3Npb24gU2xpY2UuClsgICAgMy4yODA2MzddIHN5c3RlbWRb
MV06IFN0YXJ0ZWQgRGlzcGF0Y2ggUGFzc3dvcmQgUmVxdWVzdHMgdG8gQ29uc29sZSBEaXJl
Y3RvcnkgV2F0Y2guClsgICAgMy4yODI5ODZdIHN5c3RlbWRbMV06IFNldCB1cCBhdXRvbW91
bnQgQXJiaXRyYXJ5IEV4ZWN1dGFibGUgRmlsZSBGb3JtYXRzIEZpbGUgU3lzdGVtIEF1dG9t
b3VudCBQb2ludC4KWyAgICAzLjI4NTI2MV0gc3lzdGVtZFsxXTogUmVhY2hlZCB0YXJnZXQg
TG9jYWwgRW5jcnlwdGVkIFZvbHVtZXMuClsgICAgMy4yODc1MDNdIHN5c3RlbWRbMV06IFN0
b3BwZWQgdGFyZ2V0IFN3aXRjaCBSb290LgpbICAgIDMuMjg5NzM4XSBzeXN0ZW1kWzFdOiBT
dG9wcGVkIHRhcmdldCBJbml0cmQgRmlsZSBTeXN0ZW1zLgpbICAgIDMuMjkyMDE4XSBzeXN0
ZW1kWzFdOiBTdG9wcGVkIHRhcmdldCBJbml0cmQgUm9vdCBGaWxlIFN5c3RlbS4KWyAgICAz
LjI5NDMxN10gc3lzdGVtZFsxXTogUmVhY2hlZCB0YXJnZXQgTG9jYWwgSW50ZWdyaXR5IFBy
b3RlY3RlZCBWb2x1bWVzLgpbICAgIDMuMjk1ODYxXSBzeXN0ZW1kWzFdOiBSZWFjaGVkIHRh
cmdldCBSZW1vdGUgRmlsZSBTeXN0ZW1zLgpbICAgIDMuMjk3NDEzXSBzeXN0ZW1kWzFdOiBS
ZWFjaGVkIHRhcmdldCBTbGljZSBVbml0cy4KWyAgICAzLjI5ODc5OF0gc3lzdGVtZFsxXTog
UmVhY2hlZCB0YXJnZXQgU3lzdGVtIFRpbWUgU2V0LgpbICAgIDMuMzAwMTU5XSBzeXN0ZW1k
WzFdOiBSZWFjaGVkIHRhcmdldCBMb2NhbCBWZXJpdHkgUHJvdGVjdGVkIFZvbHVtZXMuClsg
ICAgMy4zMDE1ODddIHN5c3RlbWRbMV06IExpc3RlbmluZyBvbiBEZXZpY2UtbWFwcGVyIGV2
ZW50IGRhZW1vbiBGSUZPcy4KWyAgICAzLjMwMzc0OF0gc3lzdGVtZFsxXTogTGlzdGVuaW5n
IG9uIExWTTIgcG9sbCBkYWVtb24gc29ja2V0LgpbICAgIDMuMzA1NzQyXSBzeXN0ZW1kWzFd
OiBMaXN0ZW5pbmcgb24gaW5pdGN0bCBDb21wYXRpYmlsaXR5IE5hbWVkIFBpcGUuClsgICAg
My4zMDgyMzBdIHN5c3RlbWRbMV06IExpc3RlbmluZyBvbiB1ZGV2IENvbnRyb2wgU29ja2V0
LgpbICAgIDMuMzEwMDMzXSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gdWRldiBLZXJuZWwg
U29ja2V0LgpbICAgIDMuMzIwMjA2XSBzeXN0ZW1kWzFdOiBNb3VudGluZyBIdWdlIFBhZ2Vz
IEZpbGUgU3lzdGVtLi4uClsgICAgMy4zMjI0OTZdIHN5c3RlbWRbMV06IE1vdW50aW5nIFBP
U0lYIE1lc3NhZ2UgUXVldWUgRmlsZSBTeXN0ZW0uLi4KWyAgICAzLjMyNDcwNV0gc3lzdGVt
ZFsxXTogTW91bnRpbmcgS2VybmVsIERlYnVnIEZpbGUgU3lzdGVtLi4uClsgICAgMy4zMjY1
NzJdIHN5c3RlbWRbMV06IEtlcm5lbCBUcmFjZSBGaWxlIFN5c3RlbSB3YXMgc2tpcHBlZCBi
ZWNhdXNlIG9mIGFuIHVubWV0IGNvbmRpdGlvbiBjaGVjayAoQ29uZGl0aW9uUGF0aEV4aXN0
cz0vc3lzL2tlcm5lbC90cmFjaW5nKS4KWyAgICAzLjMyNzcxNV0gc3lzdGVtZFsxXTogU3Rh
cnRpbmcgTG9hZCBBcHBBcm1vciBwcm9maWxlcy4uLgpbICAgIDMuMzMwNDI2XSBzeXN0ZW1k
WzFdOiBTdGFydGluZyBDcmVhdGUgTGlzdCBvZiBTdGF0aWMgRGV2aWNlIE5vZGVzLi4uClsg
ICAgMy4zMzMwMzBdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIE1vbml0b3Jpbmcgb2YgTFZNMiBt
aXJyb3JzLCBzbmFwc2hvdHMgZXRjLiB1c2luZyBkbWV2ZW50ZCBvciBwcm9ncmVzcyBwb2xs
aW5nLi4uClsgICAgMy4zMzU3MzFdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIExvYWQgS2VybmVs
IE1vZHVsZSBjb25maWdmcy4uLgpbICAgIDMuMzM4MzgyXSBzeXN0ZW1kWzFdOiBTdGFydGlu
ZyBMb2FkIEtlcm5lbCBNb2R1bGUgZHJtLi4uClsgICAgMy4zNDEwOTJdIHN5c3RlbWRbMV06
IFN0YXJ0aW5nIExvYWQgS2VybmVsIE1vZHVsZSBmdXNlLi4uClsgICAgMy4zNDMxMjFdIHN5
c3RlbWRbMV06IFN0b3BwZWQgSm91cm5hbCBTZXJ2aWNlLgpbICAgIDMuMzQ1MDQ3XSBzeXN0
ZW1kWzFdOiBTdG9wcGluZyBFbnRyb3B5IERhZW1vbiBiYXNlZCBvbiB0aGUgSEFWRUdFIGFs
Z29yaXRobS4uLgpbICAgIDMuMzQ3MTkwXSBmdXNlOiBpbml0IChBUEkgdmVyc2lvbiA3LjM4
KQpbICAgIDMuMzQ5OTE5XSBzeXN0ZW1kWzFdOiBTdGFydGluZyBMb2FkIEtlcm5lbCBNb2R1
bGVzLi4uClsgICAgMy4zNTIzNzVdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIFJlbW91bnQgUm9v
dCBhbmQgS2VybmVsIEZpbGUgU3lzdGVtcy4uLgpbICAgIDMuMzU0ODUzXSBzeXN0ZW1kWzFd
OiBTdGFydGluZyBDb2xkcGx1ZyBBbGwgdWRldiBEZXZpY2VzLi4uClsgICAgMy4zNjI3ODBd
IEVYVDQtZnMgKHNkYTMpOiByZS1tb3VudGVkIDA4NzQ2ZTI2LTQzNWMtNDllMS1hNTIyLTE4
ZGJhNjIyOTIzOSByL3cuIFF1b3RhIG1vZGU6IG5vbmUuClsgICAgMy4zNjYwNTFdIGF1ZGl0
OiB0eXBlPTE0MDAgYXVkaXQoMTY4OTEwNjI4MC4zMjM6Mik6IGFwcGFybW9yPSJTVEFUVVMi
IG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1lPSJs
c2JfcmVsZWFzZSIgcGlkPTQxMCBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAgMy4zNjc2
NTZdIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTY4OTEwNjI4MC4zMjM6Myk6IGFwcGFybW9y
PSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVk
IiBuYW1lPSJudmlkaWFfbW9kcHJvYmUiIHBpZD00MTEgY29tbT0iYXBwYXJtb3JfcGFyc2Vy
IgpbICAgIDMuMzY5MTQ4XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE2ODkxMDYyODAuMzIz
OjQpOiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmls
ZT0idW5jb25maW5lZCIgbmFtZT0ibnZpZGlhX21vZHByb2JlLy9rbW9kIiBwaWQ9NDExIGNv
bW09ImFwcGFybW9yX3BhcnNlciIKWyAgICAzLjM3MDcxNV0gYXVkaXQ6IHR5cGU9MTQwMCBh
dWRpdCgxNjg5MTA2MjgwLjMyNDo1KTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJw
cm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9InBpbmciIHBpZD00MDgg
Y29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAgIDMuMzcyMTI4XSBhdWRpdDogdHlwZT0xNDAw
IGF1ZGl0KDE2ODkxMDYyODAuMzI1OjYpOiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVyYXRpb249
InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25maW5lZCIgbmFtZT0ic2FtYmEtcnBjZCIg
cGlkPTQxNiBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAgMy4zNzM0MDRdIGF1ZGl0OiB0
eXBlPTE0MDAgYXVkaXQoMTY4OTEwNjI4MC4zMjU6Nyk6IGFwcGFybW9yPSJTVEFUVVMiIG9w
ZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1lPSJzYW1i
YS1kY2VycGNkIiBwaWQ9NDE1IGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgICAzLjM3NDY3
M10gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNjg5MTA2MjgwLjMyNTo4KTogYXBwYXJtb3I9
IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQi
IG5hbWU9InBocC1mcG0iIHBpZD00MTMgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAgIDMu
Mzc1NzU1XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE2ODkxMDYyODAuMzI1OjkpOiBhcHBh
cm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25m
aW5lZCIgbmFtZT0iZ2hvc3RzY3JpcHQiIHBpZD00MDkgY29tbT0iYXBwYXJtb3JfcGFyc2Vy
IgpbICAgIDMuMzc3MDE2XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE2ODkxMDYyODAuMzI1
OjEwKTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2Zp
bGU9InVuY29uZmluZWQiIG5hbWU9Imdob3N0c2NyaXB0Ly8vdXNyL2Jpbi9ocGlqcyIgcGlk
PTQwOSBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAgMy4zODI4MTRdIHN5c3RlbWRbMV06
IGhhdmVnZWQuc2VydmljZTogRGVhY3RpdmF0ZWQgc3VjY2Vzc2Z1bGx5LgpbICAgIDMuMzg0
MjAzXSBzeXN0ZW1kWzFdOiBTdG9wcGVkIEVudHJvcHkgRGFlbW9uIGJhc2VkIG9uIHRoZSBI
QVZFR0UgYWxnb3JpdGhtLgpbICAgIDMuMzg3MjcxXSBzeXN0ZW1kWzFdOiBNb3VudGVkIEh1
Z2UgUGFnZXMgRmlsZSBTeXN0ZW0uClsgICAgMy4zOTA1NTBdIHN5c3RlbWRbMV06IE1vdW50
ZWQgUE9TSVggTWVzc2FnZSBRdWV1ZSBGaWxlIFN5c3RlbS4KWyAgICAzLjM5Mjg3NV0gc3lz
dGVtZFsxXTogTW91bnRlZCBLZXJuZWwgRGVidWcgRmlsZSBTeXN0ZW0uClsgICAgMy4zOTQ3
MDNdIHN5c3RlbWRbMV06IEZpbmlzaGVkIExvYWQgQXBwQXJtb3IgcHJvZmlsZXMuClsgICAg
My4zOTY1MjBdIHN5c3RlbWRbMV06IEZpbmlzaGVkIENyZWF0ZSBMaXN0IG9mIFN0YXRpYyBE
ZXZpY2UgTm9kZXMuClsgICAgMy4zOTg1MjVdIHN5c3RlbWRbMV06IEZpbmlzaGVkIE1vbml0
b3Jpbmcgb2YgTFZNMiBtaXJyb3JzLCBzbmFwc2hvdHMgZXRjLiB1c2luZyBkbWV2ZW50ZCBv
ciBwcm9ncmVzcyBwb2xsaW5nLgpbICAgIDMuNDAwNTE4XSBzeXN0ZW1kWzFdOiBtb2Rwcm9i
ZUBjb25maWdmcy5zZXJ2aWNlOiBEZWFjdGl2YXRlZCBzdWNjZXNzZnVsbHkuClsgICAgMy40
MDExODJdIHN5c3RlbWRbMV06IEZpbmlzaGVkIExvYWQgS2VybmVsIE1vZHVsZSBjb25maWdm
cy4KWyAgICAzLjQwMzE1MF0gc3lzdGVtZFsxXTogbW9kcHJvYmVAZHJtLnNlcnZpY2U6IERl
YWN0aXZhdGVkIHN1Y2Nlc3NmdWxseS4KWyAgICAzLjQwMzc0NF0gc3lzdGVtZFsxXTogRmlu
aXNoZWQgTG9hZCBLZXJuZWwgTW9kdWxlIGRybS4KWyAgICAzLjQwNTc1Nl0gc3lzdGVtZFsx
XTogbW9kcHJvYmVAZnVzZS5zZXJ2aWNlOiBEZWFjdGl2YXRlZCBzdWNjZXNzZnVsbHkuClsg
ICAgMy40MDYzOTldIHN5c3RlbWRbMV06IEZpbmlzaGVkIExvYWQgS2VybmVsIE1vZHVsZSBm
dXNlLgpbICAgIDMuNDA4MjkzXSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBMb2FkIEtlcm5lbCBN
b2R1bGVzLgpbICAgIDMuNDEwMTQzXSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBSZW1vdW50IFJv
b3QgYW5kIEtlcm5lbCBGaWxlIFN5c3RlbXMuClsgICAgMy40MjEwNjVdIHN5c3RlbWRbMV06
IE1vdW50aW5nIEZVU0UgQ29udHJvbCBGaWxlIFN5c3RlbS4uLgpbICAgIDMuNDIzMzE0XSBz
eXN0ZW1kWzFdOiBNb3VudGluZyBLZXJuZWwgQ29uZmlndXJhdGlvbiBGaWxlIFN5c3RlbS4u
LgpbICAgIDMuNDI1MDg0XSBzeXN0ZW1kWzFdOiBBcHBseSBLZXJuZWwgVmFyaWFibGVzIGZv
ciA2LjQuMC1kZXNrdG9wLWFjZXJmYW4rIGZyb20gL2Jvb3Qgd2FzIHNraXBwZWQgYmVjYXVz
ZSBvZiBhbiB1bm1ldCBjb25kaXRpb24gY2hlY2sgKENvbmRpdGlvblBhdGhFeGlzdHM9L2Jv
b3Qvc3lzY3RsLmNvbmYtNi40LjAtZGVza3RvcC1hY2VyZmFuKykuClsgICAgMy40MjU2MzBd
IHN5c3RlbWRbMV06IEFwcGx5IEtlcm5lbCBWYXJpYWJsZXMgZm9yIDYuNC4wLWRlc2t0b3At
YWNlcmZhbisgd2FzIHNraXBwZWQgYmVjYXVzZSBvZiBhbiB1bm1ldCBjb25kaXRpb24gY2hl
Y2sgKENvbmRpdGlvblBhdGhFeGlzdHM9L3Vzci9saWIvbW9kdWxlcy82LjQuMC1kZXNrdG9w
LWFjZXJmYW4rL3N5c2N0bC5jb25mKS4KWyAgICAzLjQyNjIxM10gc3lzdGVtZFsxXTogRmly
c3QgQm9vdCBXaXphcmQgd2FzIHNraXBwZWQgYmVjYXVzZSBvZiBhbiB1bm1ldCBjb25kaXRp
b24gY2hlY2sgKENvbmRpdGlvbkZpcnN0Qm9vdD15ZXMpLgpbICAgIDMuNDI3MDExXSBzeXN0
ZW1kWzFdOiBSZWJ1aWxkIEhhcmR3YXJlIERhdGFiYXNlIHdhcyBza2lwcGVkIGJlY2F1c2Ug
b2YgYW4gdW5tZXQgY29uZGl0aW9uIGNoZWNrIChDb25kaXRpb25OZWVkc1VwZGF0ZT0vZXRj
KS4KWyAgICAzLjQyODc3NF0gc3lzdGVtZFsxXTogU3RhcnRpbmcgSm91cm5hbCBTZXJ2aWNl
Li4uClsgICAgMy40MzExODBdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIExvYWQvU2F2ZSBPUyBS
YW5kb20gU2VlZC4uLgpbICAgIDMuNDMzNTMxXSBzeXN0ZW1kWzFdOiBTdGFydGluZyBBcHBs
eSBLZXJuZWwgVmFyaWFibGVzLi4uClsgICAgMy40MzU2MDJdIHN5c3RlbWRbMV06IENyZWF0
ZSBTeXN0ZW0gVXNlcnMgd2FzIHNraXBwZWQgYmVjYXVzZSBubyB0cmlnZ2VyIGNvbmRpdGlv
biBjaGVja3Mgd2VyZSBtZXQuClsgICAgMy40MzY3OTFdIHN5c3RlbWRbMV06IFN0YXJ0aW5n
IENyZWF0ZSBTdGF0aWMgRGV2aWNlIE5vZGVzIGluIC9kZXYuLi4KWyAgICAzLjQzOTcwM10g
c3lzdGVtZFsxXTogTW91bnRlZCBGVVNFIENvbnRyb2wgRmlsZSBTeXN0ZW0uClsgICAgMy40
NDE1MzBdIHN5c3RlbWRbMV06IE1vdW50ZWQgS2VybmVsIENvbmZpZ3VyYXRpb24gRmlsZSBT
eXN0ZW0uClsgICAgMy40NTI3MzZdIHN5c3RlbWQtam91cm5hbGRbNDYzXTogQ29sbGVjdGlu
ZyBhdWRpdCBtZXNzYWdlcyBpcyBkaXNhYmxlZC4KWyAgICAzLjQ1Mjg2Nl0gc3lzdGVtZFsx
XTogRmluaXNoZWQgTG9hZC9TYXZlIE9TIFJhbmRvbSBTZWVkLgpbICAgIDMuNDU1MDE2XSBz
eXN0ZW1kWzFdOiBGaW5pc2hlZCBBcHBseSBLZXJuZWwgVmFyaWFibGVzLgpbICAgIDMuNDU2
NjI1XSBzeXN0ZW1kWzFdOiBTdGFydGVkIEpvdXJuYWwgU2VydmljZS4KWyAgICAzLjQ2OTI0
OF0gc3lzdGVtZC1qb3VybmFsZFs0NjNdOiBSZWNlaXZlZCBjbGllbnQgcmVxdWVzdCB0byBm
bHVzaCBydW50aW1lIGpvdXJuYWwuClsgICAgMy40ODMxMzNdIHN5c3RlbWQtam91cm5hbGRb
NDYzXTogL3Zhci9sb2cvam91cm5hbC9jMTc3YjMzOGI5YTM0YzgwYWJhNjExNDNjMjNiZGE1
Yy9zeXN0ZW0uam91cm5hbDogTW9ub3RvbmljIGNsb2NrIGp1bXBlZCBiYWNrd2FyZHMgcmVs
YXRpdmUgdG8gbGFzdCBqb3VybmFsIGVudHJ5LCByb3RhdGluZy4KWyAgICAzLjQ4NDMwM10g
c3lzdGVtZC1qb3VybmFsZFs0NjNdOiBSb3RhdGluZyBzeXN0ZW0gam91cm5hbC4KWyAgICAz
LjYxNDEwMF0gQUNQSTogYmF0dGVyeTogU2xvdCBbQkFUMF0gKGJhdHRlcnkgYWJzZW50KQpb
ICAgIDMuNjE0MTY0XSBBQ1BJOiBBQzogQUMgQWRhcHRlciBbQURQMV0gKG9uLWxpbmUpClsg
ICAgMy42MzkyMjNdIGludGVsLWxwc3MgMDAwMDowMDoxNS4wOiBlbmFibGluZyBkZXZpY2Ug
KDAwMDAgLT4gMDAwMikKWyAgICAzLjY0MDY4MF0gaTgwMV9zbWJ1cyAwMDAwOjAwOjFmLjQ6
IFNQRCBXcml0ZSBEaXNhYmxlIGlzIHNldApbICAgIDMuNjQxNTUyXSBpODAxX3NtYnVzIDAw
MDA6MDA6MWYuNDogU01CdXMgdXNpbmcgUENJIGludGVycnVwdApbICAgIDMuNjQyMzE5XSBw
Y2kgMDAwMDowMDoxZi4xOiBbODA4NjphMTIwXSB0eXBlIDAwIGNsYXNzIDB4MDU4MDAwClsg
ICAgMy42NDMxMDZdIHBjaSAwMDAwOjAwOjFmLjE6IHJlZyAweDEwOiBbbWVtIDB4ZmQwMDAw
MDAtMHhmZGZmZmZmZiA2NGJpdF0KWyAgICAzLjY0NDkwM10gaWRtYTY0IGlkbWE2NC4wOiBG
b3VuZCBJbnRlbCBpbnRlZ3JhdGVkIERNQSA2NC1iaXQKWyAgICAzLjY1NDkyOF0gcHN0b3Jl
OiBVc2luZyBjcmFzaCBkdW1wIGNvbXByZXNzaW9uOiBsem8KWyAgICAzLjY2MTI5MF0gaW50
ZWwtbHBzcyAwMDAwOjAwOjE1LjE6IGVuYWJsaW5nIGRldmljZSAoMDAwMCAtPiAwMDAyKQpb
ICAgIDMuNjY0NjE3XSBpMmMgaTJjLTIxOiAyLzIgbWVtb3J5IHNsb3RzIHBvcHVsYXRlZCAo
ZnJvbSBETUkpClsgICAgMy42Njc1MzRdIGkyYyBpMmMtMjE6IFN1Y2Nlc3NmdWxseSBpbnN0
YW50aWF0ZWQgU1BEIGF0IDB4NTAKWyAgICAzLjY2OTI1NV0gaWRtYTY0IGlkbWE2NC4xOiBG
b3VuZCBJbnRlbCBpbnRlZ3JhdGVkIERNQSA2NC1iaXQKWyAgICAzLjY2OTkxOV0gdGhlcm1h
bCBMTlhUSEVSTTowMDogcmVnaXN0ZXJlZCBhcyB0aGVybWFsX3pvbmUxClsgICAgMy42NzA4
MjZdIEFDUEk6IHRoZXJtYWw6IFRoZXJtYWwgWm9uZSBbVFowMV0gKDUzIEMpClsgICAgMy42
NzUyNjBdIHRoZXJtYWwgTE5YVEhFUk06MDE6IHJlZ2lzdGVyZWQgYXMgdGhlcm1hbF96b25l
MgpbICAgIDMuNjc2NzU4XSBtZWlfbWUgMDAwMDowMDoxNi4wOiBlbmFibGluZyBkZXZpY2Ug
KDAwMDAgLT4gMDAwMikKWyAgICAzLjY3Njk5Ml0gQUNQSTogdGhlcm1hbDogVGhlcm1hbCBa
b25lIFtUWjAwXSAoMjUgQykKWyAgICAzLjY5MTU1OF0gcHN0b3JlOiBSZWdpc3RlcmVkIGVm
aV9wc3RvcmUgYXMgcGVyc2lzdGVudCBzdG9yZSBiYWNrZW5kClsgICAgMy43MTA5NTRdIGFj
ZXJmYW46IEFjZXIgQXNwaXJlIEZhbiBkcml2ZXIsIHYuMC4wLjEKWyAgICAzLjcyMTE4Nl0g
aVRDT192ZW5kb3Jfc3VwcG9ydDogdmVuZG9yLXN1cHBvcnQ9MApbICAgIDMuNzIyNTc0XSBl
ZTEwMDQgMjEtMDA1MDogNTEyIGJ5dGUgRUUxMDA0LWNvbXBsaWFudCBTUEQgRUVQUk9NLCBy
ZWFkLW9ubHkKWyAgICAzLjczMzM5NF0gQWRkaW5nIDEyNTgyOTA4ayBzd2FwIG9uIC9kZXYv
c2RhMi4gIFByaW9yaXR5Oi0yIGV4dGVudHM6MSBhY3Jvc3M6MTI1ODI5MDhrIFNTRlMKWyAg
ICAzLjc2OTM4NF0gaW5wdXQ6IEVMQU4wNTAxOjAwIDA0RjM6MzAzRiBNb3VzZSBhcyAvZGV2
aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MTUuMS9pMmNfZGVzaWdud2FyZS4xL2kyYy0yMi9p
MmMtRUxBTjA1MDE6MDAvMDAxODowNEYzOjMwM0YuMDAwNC9pbnB1dC9pbnB1dDEwClsgICAg
My43NzAzODddIGlucHV0OiBFTEFOMDUwMTowMCAwNEYzOjMwM0YgVG91Y2hwYWQgYXMgL2Rl
dmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjE1LjEvaTJjX2Rlc2lnbndhcmUuMS9pMmMtMjIv
aTJjLUVMQU4wNTAxOjAwLzAwMTg6MDRGMzozMDNGLjAwMDQvaW5wdXQvaW5wdXQxMQpbICAg
IDMuNzcxMzk3XSBoaWQtZ2VuZXJpYyAwMDE4OjA0RjM6MzAzRi4wMDA0OiBpbnB1dCxoaWRy
YXczOiBJMkMgSElEIHYxLjAwIE1vdXNlIFtFTEFOMDUwMTowMCAwNEYzOjMwM0ZdIG9uIGky
Yy1FTEFOMDUwMTowMApbICAgIDMuNzc1Nzk3XSBpVENPX3dkdCBpVENPX3dkdDogRm91bmQg
YSBJbnRlbCBQQ0ggVENPIGRldmljZSAoVmVyc2lvbj00LCBUQ09CQVNFPTB4MDQwMCkKWyAg
ICAzLjc4MTgzNV0gYWNlcl93bWk6IEFjZXIgTGFwdG9wIEFDUEktV01JIEV4dHJhcwpbICAg
IDMuNzgyNTUzXSBhY2VyX3dtaTogRnVuY3Rpb24gYml0bWFwIGZvciBDb21tdW5pY2F0aW9u
IEJ1dHRvbjogMHg4MDEKWyAgICAzLjc4MjU1N10gaW50ZWxfdGNjX2Nvb2xpbmc6IFByb2dy
YW1tYWJsZSBUQ0MgT2Zmc2V0IGRldGVjdGVkClsgICAgMy43OTI0NDFdIGNmZzgwMjExOiBM
b2FkaW5nIGNvbXBpbGVkLWluIFguNTA5IGNlcnRpZmljYXRlcyBmb3IgcmVndWxhdG9yeSBk
YXRhYmFzZQpbICAgIDMuNzkyNzU4XSByODE2OSAwMDAwOjAzOjAwLjA6IGNhbid0IGRpc2Fi
bGUgQVNQTTsgT1MgZG9lc24ndCBoYXZlIEFTUE0gY29udHJvbApbICAgIDMuODAyMzE0XSBM
b2FkZWQgWC41MDkgY2VydCAnc2ZvcnNoZWU6IDAwYjI4ZGRmNDdhZWY5Y2VhNycKWyAgICAz
LjgwMjU1OF0gaW5wdXQ6IEFjZXIgV01JIGhvdGtleXMgYXMgL2RldmljZXMvdmlydHVhbC9p
bnB1dC9pbnB1dDEyClsgICAgMy44MDM5NjFdIGlUQ09fd2R0IGlUQ09fd2R0OiBpbml0aWFs
aXplZC4gaGVhcnRiZWF0PTMwIHNlYyAobm93YXlvdXQ9MCkKWyAgICAzLjgxMDk5Nl0gbWVp
X2hkY3AgMDAwMDowMDoxNi4wLWI2MzhhYjdlLTk0ZTItNGVhMi1hNTUyLWQxYzU0YjYyN2Yw
NDogYm91bmQgMDAwMDowMDowMi4wIChvcHMgMHhmZmZmZmZmZmMwOGEzYWMwKQpbICAgIDMu
ODIyNTUzXSBzbmRfaGRhX2ludGVsIDAwMDA6MDA6MWYuMzogYm91bmQgMDAwMDowMDowMi4w
IChvcHMgMHhmZmZmZmZmZmMwODliOWUwKQpbICAgIDMuODIzNzk2XSBzbmRfaGRhX2ludGVs
IDAwMDA6MDE6MDAuMTogRGlzYWJsaW5nIE1TSQpbICAgIDMuODI0NDk0XSBzbmRfaGRhX2lu
dGVsIDAwMDA6MDE6MDAuMTogSGFuZGxlIHZnYV9zd2l0Y2hlcm9vIGF1ZGlvIGNsaWVudApb
ICAgIDMuODI3Nzg4XSBpbnRlbF9yYXBsX2NvbW1vbjogRm91bmQgUkFQTCBkb21haW4gcGFj
a2FnZQpbICAgIDMuODI3NzkxXSBpbnRlbF9yYXBsX2NvbW1vbjogRm91bmQgUkFQTCBkb21h
aW4gY29yZQpbICAgIDMuODI3NzkyXSBpbnRlbF9yYXBsX2NvbW1vbjogRm91bmQgUkFQTCBk
b21haW4gdW5jb3JlClsgICAgMy44Mjc3OTNdIGludGVsX3JhcGxfY29tbW9uOiBGb3VuZCBS
QVBMIGRvbWFpbiBkcmFtClsgICAgMy44MjgyMDFdIHI4MTY5IDAwMDA6MDM6MDAuMCBldGgw
OiBSVEw4MTY4aC84MTExaCwgMzA6NjU6ZWM6YmE6MTg6MDIsIFhJRCA1NDEsIElSUSAxMzEK
WyAgICAzLjgzMDkzNF0gcjgxNjkgMDAwMDowMzowMC4wIGV0aDA6IGp1bWJvIGZlYXR1cmVz
IFtmcmFtZXM6IDkxOTQgYnl0ZXMsIHR4IGNoZWNrc3VtbWluZzoga29dClsgICAgMy44MzMw
NTVdIGF0aDEwa19wY2kgMDAwMDowMjowMC4wOiBwY2kgaXJxIG1zaSBvcGVyX2lycV9tb2Rl
IDIgaXJxX21vZGUgMCByZXNldF9tb2RlIDAKWyAgICAzLjgzNTU4OV0gcjgxNjkgMDAwMDow
MzowMC4wIGVucDNzMDogcmVuYW1lZCBmcm9tIGV0aDAKWyAgICAzLjg0MDkzNl0gc25kX2hk
YV9pbnRlbCAwMDAwOjAxOjAwLjE6IGJvdW5kIDAwMDA6MDE6MDAuMCAob3BzIDB4ZmZmZmZm
ZmZjMDY5MzRkMCkKWyAgICAzLjg0MzEwOF0gaW5wdXQ6IEhEQSBOVmlkaWEgSERNSS9EUCxw
Y209MyBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MDEuMC8wMDAwOjAxOjAwLjEv
c291bmQvY2FyZDEvaW5wdXQxMwpbICAgIDMuODQ5MzQzXSBzbmRfaGRhX2NvZGVjX3JlYWx0
ZWsgaGRhdWRpb0MwRDA6IGF1dG9jb25maWcgZm9yIEFMQzI1NTogbGluZV9vdXRzPTEgKDB4
MTQvMHgwLzB4MC8weDAvMHgwKSB0eXBlOnNwZWFrZXIKWyAgICAzLjg0OTk1M10gc25kX2hk
YV9jb2RlY19yZWFsdGVrIGhkYXVkaW9DMEQwOiAgICBzcGVha2VyX291dHM9MCAoMHgwLzB4
MC8weDAvMHgwLzB4MCkKWyAgICAzLjg0OTk1Nl0gc25kX2hkYV9jb2RlY19yZWFsdGVrIGhk
YXVkaW9DMEQwOiAgICBocF9vdXRzPTEgKDB4MjEvMHgwLzB4MC8weDAvMHgwKQpbICAgIDMu
ODQ5OTU3XSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsgaGRhdWRpb0MwRDA6ICAgIG1vbm86IG1v
bm9fb3V0PTB4MApbICAgIDMuODQ5OTU5XSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsgaGRhdWRp
b0MwRDA6ICAgIGRpZy1vdXQ9MHgxZS8weDAKWyAgICAzLjg0OTk2MF0gc25kX2hkYV9jb2Rl
Y19yZWFsdGVrIGhkYXVkaW9DMEQwOiAgICBpbnB1dHM6ClsgICAgMy44NDk5NjFdIHNuZF9o
ZGFfY29kZWNfcmVhbHRlayBoZGF1ZGlvQzBEMDogICAgICBNaWM9MHgxYQpbICAgIDMuODQ5
OTYzXSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsgaGRhdWRpb0MwRDA6ICAgICAgSW50ZXJuYWwg
TWljPTB4MTIKWyAgICAzLjg1OTAxNV0gaW5wdXQ6IEhEQSBOVmlkaWEgSERNSS9EUCxwY209
NyBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MDEuMC8wMDAwOjAxOjAwLjEvc291
bmQvY2FyZDEvaW5wdXQxNApbICAgIDMuODU5MDY1XSBpbnB1dDogSERBIE5WaWRpYSBIRE1J
L0RQLHBjbT04IGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDowMS4wLzAwMDA6MDE6
MDAuMS9zb3VuZC9jYXJkMS9pbnB1dDE1ClsgICAgMy44NTkxMDVdIGlucHV0OiBIREEgTlZp
ZGlhIEhETUkvRFAscGNtPTkgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjAxLjAv
MDAwMDowMTowMC4xL3NvdW5kL2NhcmQxL2lucHV0MTYKWyAgICAzLjg3MjgyNF0gaW5wdXQ6
IEVMQU4wNTAxOjAwIDA0RjM6MzAzRiBNb3VzZSBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAw
MDA6MDA6MTUuMS9pMmNfZGVzaWdud2FyZS4xL2kyYy0yMi9pMmMtRUxBTjA1MDE6MDAvMDAx
ODowNEYzOjMwM0YuMDAwNC9pbnB1dC9pbnB1dDE4ClsgICAgMy44NzM0NDFdIGlucHV0OiBF
TEFOMDUwMTowMCAwNEYzOjMwM0YgVG91Y2hwYWQgYXMgL2RldmljZXMvcGNpMDAwMDowMC8w
MDAwOjAwOjE1LjEvaTJjX2Rlc2lnbndhcmUuMS9pMmMtMjIvaTJjLUVMQU4wNTAxOjAwLzAw
MTg6MDRGMzozMDNGLjAwMDQvaW5wdXQvaW5wdXQxOQpbICAgIDMuODc0MjE1XSBoaWQtbXVs
dGl0b3VjaCAwMDE4OjA0RjM6MzAzRi4wMDA0OiBpbnB1dCxoaWRyYXczOiBJMkMgSElEIHYx
LjAwIE1vdXNlIFtFTEFOMDUwMTowMCAwNEYzOjMwM0ZdIG9uIGkyYy1FTEFOMDUwMTowMApb
ICAgIDMuOTA0NjkxXSBFWFQ0LWZzIChzZGE0KTogbW91bnRlZCBmaWxlc3lzdGVtIDk5OTc3
MWNmLTI4ZTItNGUzMS1hNDA2LWRjZGNkMzhmMDEyZSByL3cgd2l0aCBvcmRlcmVkIGRhdGEg
bW9kZS4gUXVvdGEgbW9kZTogbm9uZS4KWyAgICAzLjk2Mjc1N10gYWhjaSAwMDAwOjAwOjE3
LjA6IHBvcnQgZG9lcyBub3Qgc3VwcG9ydCBkZXZpY2Ugc2xlZXAKWyAgICA0LjA3NTk3OV0g
YXRoMTBrX3BjaSAwMDAwOjAyOjAwLjA6IHFjYTYxNzQgaHczLjIgdGFyZ2V0IDB4MDUwMzAw
MDAgY2hpcF9pZCAweDAwMzQwYWZmIHN1YiAxMDViOmUwOWQKWyAgICA0LjA3NjQ3OV0gYXRo
MTBrX3BjaSAwMDAwOjAyOjAwLjA6IGtjb25maWcgZGVidWcgMCBkZWJ1Z2ZzIDAgdHJhY2lu
ZyAwIGRmcyAwIHRlc3Rtb2RlIDAKWyAgICA0LjA3NzQ1OF0gYXRoMTBrX3BjaSAwMDAwOjAy
OjAwLjA6IGZpcm13YXJlIHZlciBXTEFOLlJNLjQuNC4xLTAwMjg4LSBhcGkgNiBmZWF0dXJl
cyB3b3dsYW4saWdub3JlLW90cCxtZnAgY3JjMzIgYmY5MDdjN2MKWyAgICA0LjEwMjAyOV0g
aW5wdXQ6IEhEQSBEaWdpdGFsIFBDQmVlcCBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6
MDA6MWYuMy9zb3VuZC9jYXJkMC9pbnB1dDE3ClsgICAgNC4xMDUxMTVdIGlucHV0OiBIREEg
SW50ZWwgUENIIE1pYyBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMy9zb3Vu
ZC9jYXJkMC9pbnB1dDIwClsgICAgNC4xMDU4MTZdIGlucHV0OiBIREEgSW50ZWwgUENIIEhl
YWRwaG9uZSBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMy9zb3VuZC9jYXJk
MC9pbnB1dDIxClsgICAgNC4xMDY1NDZdIGlucHV0OiBIREEgSW50ZWwgUENIIEhETUkvRFAs
cGNtPTMgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFmLjMvc291bmQvY2FyZDAv
aW5wdXQyMgpbICAgIDQuMTA3MjQ0XSBpbnB1dDogSERBIEludGVsIFBDSCBIRE1JL0RQLHBj
bT03IGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZi4zL3NvdW5kL2NhcmQwL2lu
cHV0MjMKWyAgICA0LjEwNzk2Ml0gaW5wdXQ6IEhEQSBJbnRlbCBQQ0ggSERNSS9EUCxwY209
OCBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMy9zb3VuZC9jYXJkMC9pbnB1
dDI0ClsgICAgNC4xNDYyMjVdIGF0aDEwa19wY2kgMDAwMDowMjowMC4wOiBib2FyZF9maWxl
IGFwaSAyIGJtaV9pZCBOL0EgY3JjMzIgZDI4NjNmOTEKWyAgICA0LjIzOTgzNl0gYXRoMTBr
X3BjaSAwMDAwOjAyOjAwLjA6IGh0dC12ZXIgMy44NyB3bWktb3AgNCBodHQtb3AgMyBjYWwg
b3RwIG1heC1zdGEgMzIgcmF3IDAgaHdjcnlwdG8gMQpbICAgIDQuMzAwNDU5XSBhdGg6IEVF
UFJPTSByZWdkb21haW46IDB4NmMKWyAgICA0LjMwMDQ2Ml0gYXRoOiBFRVBST00gaW5kaWNh
dGVzIHdlIHNob3VsZCBleHBlY3QgYSBkaXJlY3QgcmVncGFpciBtYXAKWyAgICA0LjMwMDQ2
M10gYXRoOiBDb3VudHJ5IGFscGhhMiBiZWluZyB1c2VkOiAwMApbICAgIDQuMzAwNDY0XSBh
dGg6IFJlZ3BhaXIgdXNlZDogMHg2YwpbICAgIDQuMzA0MDY4XSBhdGgxMGtfcGNpIDAwMDA6
MDI6MDAuMCB3bHAyczA6IHJlbmFtZWQgZnJvbSB3bGFuMApbICAgIDQuNTgyNTQ2XSBORVQ6
IFJlZ2lzdGVyZWQgUEZfUUlQQ1JUUiBwcm90b2NvbCBmYW1pbHkKWyAgICA0LjY5OTkyN10g
R2VuZXJpYyBGRS1HRSBSZWFsdGVrIFBIWSByODE2OS0wLTMwMDowMDogYXR0YWNoZWQgUEhZ
IGRyaXZlciAobWlpX2J1czpwaHlfYWRkcj1yODE2OS0wLTMwMDowMCwgaXJxPU1BQykKWyAg
ICA0Ljc0OTU5NF0gbWM6IExpbnV4IG1lZGlhIGludGVyZmFjZTogdjAuMTAKWyAgICA0Ljc1
NDU0NF0gdmlkZW9kZXY6IExpbnV4IHZpZGVvIGNhcHR1cmUgaW50ZXJmYWNlOiB2Mi4wMApb
ICAgIDQuNzcwMzAyXSBCbHVldG9vdGg6IENvcmUgdmVyIDIuMjIKWyAgICA0Ljc3MDMyNV0g
TkVUOiBSZWdpc3RlcmVkIFBGX0JMVUVUT09USCBwcm90b2NvbCBmYW1pbHkKWyAgICA0Ljc3
MDMyN10gQmx1ZXRvb3RoOiBIQ0kgZGV2aWNlIGFuZCBjb25uZWN0aW9uIG1hbmFnZXIgaW5p
dGlhbGl6ZWQKWyAgICA0Ljc3MDMzMV0gQmx1ZXRvb3RoOiBIQ0kgc29ja2V0IGxheWVyIGlu
aXRpYWxpemVkClsgICAgNC43NzAzMzNdIEJsdWV0b290aDogTDJDQVAgc29ja2V0IGxheWVy
IGluaXRpYWxpemVkClsgICAgNC43NzAzMzZdIEJsdWV0b290aDogU0NPIHNvY2tldCBsYXll
ciBpbml0aWFsaXplZApbICAgIDQuODY1MDY4XSByODE2OSAwMDAwOjAzOjAwLjAgZW5wM3Mw
OiBMaW5rIGlzIERvd24KWyAgICA0Ljg2Njc4OF0gdXNiIDEtOTogRm91bmQgVVZDIDEuMDAg
ZGV2aWNlIEhEIFdlYkNhbSAoMDRmMjpiNTcxKQpbICAgIDQuODczMTI2XSB1c2Jjb3JlOiBy
ZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIGJ0dXNiClsgICAgNC44Nzg0NjldIEJs
dWV0b290aDogaGNpMDogdXNpbmcgcmFtcGF0Y2ggZmlsZTogcWNhL3JhbXBhdGNoX3VzYl8w
MDAwMDMwMi5iaW4KWyAgICA0Ljg3ODQ3NF0gQmx1ZXRvb3RoOiBoY2kwOiBRQ0E6IHBhdGNo
IHJvbWUgMHgzMDIgYnVpbGQgMHgzZTgsIGZpcm13YXJlIHJvbWUgMHgzMDIgYnVpbGQgMHgx
MTEKWyAgICA0Ljg4NDA5M10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRy
aXZlciB1dmN2aWRlbwpbICAgIDQuOTYzMTI5XSBCbHVldG9vdGg6IEJORVAgKEV0aGVybmV0
IEVtdWxhdGlvbikgdmVyIDEuMwpbICAgIDQuOTYzMTM4XSBCbHVldG9vdGg6IEJORVAgZmls
dGVyczogcHJvdG9jb2wgbXVsdGljYXN0ClsgICAgNC45NjMxNDRdIEJsdWV0b290aDogQk5F
UCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgICA1LjIzMzE1MF0gQmx1ZXRvb3RoOiBo
Y2kwOiB1c2luZyBOVk0gZmlsZTogcWNhL252bV91c2JfMDAwMDAzMDIuYmluClsgICAgNS4y
NTY2NDFdIEJsdWV0b290aDogaGNpMDogSENJIEVuaGFuY2VkIFNldHVwIFN5bmNocm9ub3Vz
IENvbm5lY3Rpb24gY29tbWFuZCBpcyBhZHZlcnRpc2VkLCBidXQgbm90IHN1cHBvcnRlZC4K
WyAgICA1LjkwMDg3OF0gQmx1ZXRvb3RoOiBNR01UIHZlciAxLjIyClsgICAgNS45MDY4Mjhd
IE5FVDogUmVnaXN0ZXJlZCBQRl9BTEcgcHJvdG9jb2wgZmFtaWx5ClsgICAgNi4zNzA1OThd
IG5vdXZlYXUgMDAwMDowMTowMC4wOiBncjogaW50ciAwMDAwMDA0MApbICAgIDguNDY1OTM5
XSByODE2OSAwMDAwOjAzOjAwLjAgZW5wM3MwOiBMaW5rIGlzIFVwIC0gMUdicHMvRnVsbCAt
IGZsb3cgY29udHJvbCByeC90eApbICAgIDguNDY1OTU2XSBJUHY2OiBBRERSQ09ORihORVRE
RVZfQ0hBTkdFKTogZW5wM3MwOiBsaW5rIGJlY29tZXMgcmVhZHkKWyAgICA4LjQ2ODQ2N10g
cjgxNjkgMDAwMDowMzowMC4wIGVucDNzMDogTGluayBpcyBVcCAtIDFHYnBzL0Z1bGwgLSBm
bG93IGNvbnRyb2wgcngvdHgKWyAgICA4LjQ4MjU2MV0gTkVUOiBSZWdpc3RlcmVkIFBGX1BB
Q0tFVCBwcm90b2NvbCBmYW1pbHkKWyAgIDMzLjE0MTM3NF0gYWNlcl93bWk6IFVua25vd24g
ZnVuY3Rpb24gbnVtYmVyIC0gNiAtIDEKWyA0MTc4Ljg2OTYzMF0gc3lzdGVtZC1qb3VybmFs
ZFs0NjNdOiAvdmFyL2xvZy9qb3VybmFsL2MxNzdiMzM4YjlhMzRjODBhYmE2MTE0M2MyM2Jk
YTVjL3VzZXItMTAwMC5qb3VybmFsOiBNb25vdG9uaWMgY2xvY2sganVtcGVkIGJhY2t3YXJk
cyByZWxhdGl2ZSB0byBsYXN0IGpvdXJuYWwgZW50cnksIHJvdGF0aW5nLgpbIDQxODIuOTkz
MTk0XSBCbHVldG9vdGg6IFJGQ09NTSBUVFkgbGF5ZXIgaW5pdGlhbGl6ZWQKWyA0MTgyLjk5
MzIwMl0gQmx1ZXRvb3RoOiBSRkNPTU0gc29ja2V0IGxheWVyIGluaXRpYWxpemVkClsgNDE4
Mi45OTMyMDZdIEJsdWV0b290aDogUkZDT01NIHZlciAxLjExCg==
--------------lS5SUTwfL0SlAT94caQJNMwq
Content-Type: text/plain; charset=UTF-8; name="lspci.txt"
Content-Disposition: attachment; filename="lspci.txt"
Content-Transfer-Encoding: base64

MDA6MDAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gWGVvbiBFMy0xMjAwIHY2
Lzd0aCBHZW4gQ29yZSBQcm9jZXNzb3IgSG9zdCBCcmlkZ2UvRFJBTSBSZWdpc3RlcnMgKHJl
diAwNSkKCVN1YnN5c3RlbTogQWNlciBJbmNvcnBvcmF0ZWQgW0FMSV0gRGV2aWNlIDExNGUK
CUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdB
U25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0
dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFi
b3J0LSA8VEFib3J0LSA8TUFib3J0KyA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAw
CglDYXBhYmlsaXRpZXM6IFtlMF0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBMZW49
MTAgPD8+CglLZXJuZWwgZHJpdmVyIGluIHVzZTogc2tsX3VuY29yZQoKMDA6MDEuMCBQQ0kg
YnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiA2dGgtMTB0aCBHZW4gQ29yZSBQcm9jZXNzb3Ig
UENJZSBDb250cm9sbGVyICh4MTYpIChyZXYgMDUpIChwcm9nLWlmIDAwIFtOb3JtYWwgZGVj
b2RlXSkKCVN1YnN5c3RlbTogQWNlciBJbmNvcnBvcmF0ZWQgW0FMSV0gRGV2aWNlIDExNGUK
CUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdB
U25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgrCglTdGF0
dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFi
b3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAw
LCBDYWNoZSBMaW5lIFNpemU6IDY0IGJ5dGVzCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0
byBJUlEgMTIyCglCdXM6IHByaW1hcnk9MDAsIHNlY29uZGFyeT0wMSwgc3Vib3JkaW5hdGU9
MDEsIHNlYy1sYXRlbmN5PTAKCUkvTyBiZWhpbmQgYnJpZGdlOiA0MDAwLTRmZmYgW3NpemU9
NEtdIFsxNi1iaXRdCglNZW1vcnkgYmVoaW5kIGJyaWRnZTogNjIwMDAwMDAtNjMwZmZmZmYg
W3NpemU9MTdNXSBbMzItYml0XQoJUHJlZmV0Y2hhYmxlIG1lbW9yeSBiZWhpbmQgYnJpZGdl
OiA1MDAwMDAwMC02MWZmZmZmZiBbc2l6ZT0yODhNXSBbMzItYml0XQoJU2Vjb25kYXJ5IHN0
YXR1czogNjZNSHotIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRB
Ym9ydC0gPE1BYm9ydCsgPFNFUlItIDxQRVJSLQoJQnJpZGdlQ3RsOiBQYXJpdHktIFNFUlIr
IE5vSVNBLSBWR0EtIFZHQTE2LSBNQWJvcnQtID5SZXNldC0gRmFzdEIyQi0KCQlQcmlEaXNj
VG1yLSBTZWNEaXNjVG1yLSBEaXNjVG1yU3RhdC0gRGlzY1RtclNFUlJFbi0KCUNhcGFiaWxp
dGllczogWzg4XSBTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSAx
MTRlCglDYXBhYmlsaXRpZXM6IFs4MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlG
bGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVudD0wbUEgUE1FKEQwKyxEMS0s
RDItLEQzaG90KyxEM2NvbGQrKQoJCVN0YXR1czogRDAgTm9Tb2Z0UnN0KyBQTUUtRW5hYmxl
LSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJpbGl0aWVzOiBbOTBdIE1TSTogRW5hYmxl
KyBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0LQoJCUFkZHJlc3M6IGZlZTAwMjE4ICBEYXRh
OiAwMDAwCglDYXBhYmlsaXRpZXM6IFthMF0gRXhwcmVzcyAodjIpIFJvb3QgUG9ydCAoU2xv
dCspLCBNU0kgMDAKCQlEZXZDYXA6CU1heFBheWxvYWQgMjU2IGJ5dGVzLCBQaGFudEZ1bmMg
MAoJCQlFeHRUYWctIFJCRSsKCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRh
bEVyci0gVW5zdXBSZXEtCgkJCVJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3It
IE5vU25vb3AtCgkJCU1heFBheWxvYWQgMjU2IGJ5dGVzLCBNYXhSZWFkUmVxIDEyOCBieXRl
cwoJCURldlN0YToJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0g
QXV4UHdyLSBUcmFuc1BlbmQtCgkJTG5rQ2FwOglQb3J0ICMyLCBTcGVlZCA4R1QvcywgV2lk
dGggeDE2LCBBU1BNIEwwcyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8MjU2bnMsIEwxIDw4dXMK
CQkJQ2xvY2tQTS0gU3VycHJpc2UtIExMQWN0UmVwLSBCd05vdCsgQVNQTU9wdENvbXArCgkJ
TG5rQ3RsOglBU1BNIERpc2FibGVkOyBSQ0IgNjQgYnl0ZXMsIERpc2FibGVkLSBDb21tQ2xr
KwoJCQlFeHRTeW5jaC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0ludC0gQXV0QldJbnQtCgkJ
TG5rU3RhOglTcGVlZCAyLjVHVC9zLCBXaWR0aCB4MTYKCQkJVHJFcnItIFRyYWluLSBTbG90
Q2xrKyBETEFjdGl2ZS0gQldNZ210KyBBQldNZ210KwoJCVNsdENhcDoJQXR0bkJ0bi0gUHdy
Q3RybC0gTVJMLSBBdHRuSW5kLSBQd3JJbmQtIEhvdFBsdWctIFN1cnByaXNlLQoJCQlTbG90
ICMxLCBQb3dlckxpbWl0IDc1VzsgSW50ZXJsb2NrLSBOb0NvbXBsKwoJCVNsdEN0bDoJRW5h
YmxlOiBBdHRuQnRuLSBQd3JGbHQtIE1STC0gUHJlc0RldC0gQ21kQ3BsdC0gSFBJcnEtIExp
bmtDaGctCgkJCUNvbnRyb2w6IEF0dG5JbmQgVW5rbm93biwgUHdySW5kIFVua25vd24sIFBv
d2VyLSBJbnRlcmxvY2stCgkJU2x0U3RhOglTdGF0dXM6IEF0dG5CdG4tIFBvd2VyRmx0LSBN
UkwtIENtZENwbHQtIFByZXNEZXQrIEludGVybG9jay0KCQkJQ2hhbmdlZDogTVJMLSBQcmVz
RGV0KyBMaW5rU3RhdGUtCgkJUm9vdENhcDogQ1JTVmlzaWJsZS0KCQlSb290Q3RsOiBFcnJD
b3JyZWN0YWJsZS0gRXJyTm9uLUZhdGFsLSBFcnJGYXRhbC0gUE1FSW50RW5hLSBDUlNWaXNp
YmxlLQoJCVJvb3RTdGE6IFBNRSBSZXFJRCAwMDAwLCBQTUVTdGF0dXMtIFBNRVBlbmRpbmct
CgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBOb3QgU3VwcG9ydGVkLCBUaW1lb3V0
RGlzLSBOUk9QclByUC0gTFRSKwoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JG
RiBWaWEgV0FLRSMsIEV4dEZtdC0gRUVUTFBQcmVmaXgtCgkJCSBFbWVyZ2VuY3lQb3dlclJl
ZHVjdGlvbiBOb3QgU3VwcG9ydGVkLCBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbkluaXQtCgkJ
CSBGUlMtIExOIFN5c3RlbSBDTFMgTm90IFN1cHBvcnRlZCwgVFBIQ29tcC0gRXh0VFBIQ29t
cC0gQVJJRndkLQoJCQkgQXRvbWljT3BzQ2FwOiBSb3V0aW5nLSAzMmJpdCsgNjRiaXQrIDEy
OGJpdENBUysKCQlEZXZDdGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IDUwdXMgdG8gNTBtcywg
VGltZW91dERpcy0gTFRSKyAxMEJpdFRhZ1JlcS0gT0JGRiBWaWEgV0FLRSMsIEFSSUZ3ZC0K
CQkJIEF0b21pY09wc0N0bDogUmVxRW4tIEVncmVzc0JsY2stCgkJTG5rQ2FwMjogU3VwcG9y
dGVkIExpbmsgU3BlZWRzOiAyLjUtOEdUL3MsIENyb3NzbGluay0gUmV0aW1lci0gMlJldGlt
ZXJzLSBEUlMtCgkJTG5rQ3RsMjogVGFyZ2V0IExpbmsgU3BlZWQ6IDhHVC9zLCBFbnRlckNv
bXBsaWFuY2UtIFNwZWVkRGlzLQoJCQkgVHJhbnNtaXQgTWFyZ2luOiBOb3JtYWwgT3BlcmF0
aW5nIFJhbmdlLCBFbnRlck1vZGlmaWVkQ29tcGxpYW5jZS0gQ29tcGxpYW5jZVNPUy0KCQkJ
IENvbXBsaWFuY2UgUHJlc2V0L0RlLWVtcGhhc2lzOiAtNmRCIGRlLWVtcGhhc2lzLCAwZEIg
cHJlc2hvb3QKCQlMbmtTdGEyOiBDdXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtNmRCLCBF
cXVhbGl6YXRpb25Db21wbGV0ZSsgRXF1YWxpemF0aW9uUGhhc2UxKwoJCQkgRXF1YWxpemF0
aW9uUGhhc2UyKyBFcXVhbGl6YXRpb25QaGFzZTMrIExpbmtFcXVhbGl6YXRpb25SZXF1ZXN0
LQoJCQkgUmV0aW1lci0gMlJldGltZXJzLSBDcm9zc2xpbmtSZXM6IHVuc3VwcG9ydGVkCglD
YXBhYmlsaXRpZXM6IFsxMDAgdjFdIFZpcnR1YWwgQ2hhbm5lbAoJCUNhcHM6CUxQRVZDPTAg
UmVmQ2xrPTEwMG5zIFBBVEVudHJ5Qml0cz0xCgkJQXJiOglGaXhlZC0gV1JSMzItIFdSUjY0
LSBXUlIxMjgtCgkJQ3RybDoJQXJiU2VsZWN0PUZpeGVkCgkJU3RhdHVzOglJblByb2dyZXNz
LQoJCVZDMDoJQ2FwczoJUEFUT2Zmc2V0PTAwIE1heFRpbWVTbG90cz0xIFJlalNub29wVHJh
bnMtCgkJCUFyYjoJRml4ZWQrIFdSUjMyLSBXUlI2NC0gV1JSMTI4LSBUV1JSMTI4LSBXUlIy
NTYtCgkJCUN0cmw6CUVuYWJsZSsgSUQ9MCBBcmJTZWxlY3Q9Rml4ZWQgVEMvVkM9ZmYKCQkJ
U3RhdHVzOglOZWdvUGVuZGluZy0gSW5Qcm9ncmVzcy0KCUNhcGFiaWxpdGllczogWzE0MCB2
MV0gUm9vdCBDb21wbGV4IExpbmsKCQlEZXNjOglQb3J0TnVtYmVyPTAyIENvbXBvbmVudElE
PTAxIEVsdFR5cGU9Q29uZmlnCgkJTGluazA6CURlc2M6CVRhcmdldFBvcnQ9MDAgVGFyZ2V0
Q29tcG9uZW50PTAxIEFzc29jUkNSQi0gTGlua1R5cGU9TWVtTWFwcGVkIExpbmtWYWxpZCsK
CQkJQWRkcjoJMDAwMDAwMDBmZWQxOTAwMAoJQ2FwYWJpbGl0aWVzOiBbZDk0IHYxXSBTZWNv
bmRhcnkgUENJIEV4cHJlc3MKCQlMbmtDdGwzOiBMbmtFcXVJbnRycnVwdEVuLSBQZXJmb3Jt
RXF1LQoJCUxhbmVFcnJTdGF0OiAwCglLZXJuZWwgZHJpdmVyIGluIHVzZTogcGNpZXBvcnQK
CjAwOjAyLjAgVkdBIGNvbXBhdGlibGUgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24g
SEQgR3JhcGhpY3MgNjMwIChyZXYgMDQpIChwcm9nLWlmIDAwIFtWR0EgY29udHJvbGxlcl0p
CglTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSAxMTRlCglDb250
cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29w
LSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBD
YXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0g
PFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2Fj
aGUgTGluZSBTaXplOiA2NCBieXRlcwoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJR
IDEyOQoJUmVnaW9uIDA6IE1lbW9yeSBhdCAyZmYyMDAwMDAwICg2NC1iaXQsIG5vbi1wcmVm
ZXRjaGFibGUpIFtzaXplPTE2TV0KCVJlZ2lvbiAyOiBNZW1vcnkgYXQgMmZjMDAwMDAwMCAo
NjQtYml0LCBwcmVmZXRjaGFibGUpIFtzaXplPTI1Nk1dCglSZWdpb24gNDogSS9PIHBvcnRz
IGF0IDUwMDAgW3NpemU9NjRdCglFeHBhbnNpb24gUk9NIGF0IDAwMGMwMDAwIFt2aXJ0dWFs
XSBbZGlzYWJsZWRdIFtzaXplPTEyOEtdCglDYXBhYmlsaXRpZXM6IFs0MF0gVmVuZG9yIFNw
ZWNpZmljIEluZm9ybWF0aW9uOiBMZW49MGMgPD8+CglDYXBhYmlsaXRpZXM6IFs3MF0gRXhw
cmVzcyAodjIpIFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBvaW50LCBNU0kgMDAKCQlE
ZXZDYXA6CU1heFBheWxvYWQgMTI4IGJ5dGVzLCBQaGFudEZ1bmMgMAoJCQlFeHRUYWctIFJC
RSsgRkxSZXNldCsKCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0g
VW5zdXBSZXEtCgkJCVJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25v
b3AtIEZMUmVzZXQtCgkJCU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDEyOCBi
eXRlcwoJCURldlN0YToJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJl
cS0gQXV4UHdyLSBUcmFuc1BlbmQtCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBO
b3QgU3VwcG9ydGVkLCBUaW1lb3V0RGlzLSBOUk9QclByUC0gTFRSLQoJCQkgMTBCaXRUYWdD
b21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJl
Zml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdl
bmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLQoJCQkgQXRvbWljT3BzQ2FwOiAzMmJp
dC0gNjRiaXQtIDEyOGJpdENBUy0KCQlEZXZDdGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IDUw
dXMgdG8gNTBtcywgVGltZW91dERpcy0gTFRSLSAxMEJpdFRhZ1JlcS0gT0JGRiBEaXNhYmxl
ZCwKCQkJIEF0b21pY09wc0N0bDogUmVxRW4tCglDYXBhYmlsaXRpZXM6IFthY10gTVNJOiBF
bmFibGUrIENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQtCgkJQWRkcmVzczogZmVlMDAwMTgg
IERhdGE6IDAwMDAKCUNhcGFiaWxpdGllczogW2QwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNp
b24gMgoJCUZsYWdzOiBQTUVDbGstIERTSSsgRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUo
RDAtLEQxLSxEMi0sRDNob3QtLEQzY29sZC0pCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBN
RS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6IFsxMDAgdjFd
IFByb2Nlc3MgQWRkcmVzcyBTcGFjZSBJRCAoUEFTSUQpCgkJUEFTSURDYXA6IEV4ZWMtIFBy
aXYtLCBNYXggUEFTSUQgV2lkdGg6IDE0CgkJUEFTSURDdGw6IEVuYWJsZS0gRXhlYy0gUHJp
di0KCUNhcGFiaWxpdGllczogWzIwMCB2MV0gQWRkcmVzcyBUcmFuc2xhdGlvbiBTZXJ2aWNl
IChBVFMpCgkJQVRTQ2FwOglJbnZhbGlkYXRlIFF1ZXVlIERlcHRoOiAwMAoJCUFUU0N0bDoJ
RW5hYmxlLSwgU21hbGxlc3QgVHJhbnNsYXRpb24gVW5pdDogMDAKCUNhcGFiaWxpdGllczog
WzMwMCB2MV0gUGFnZSBSZXF1ZXN0IEludGVyZmFjZSAoUFJJKQoJCVBSSUN0bDogRW5hYmxl
LSBSZXNldC0KCQlQUklTdGE6IFJGLSBVUFJHSS0gU3RvcHBlZCsKCQlQYWdlIFJlcXVlc3Qg
Q2FwYWNpdHk6IDAwMDA4MDAwLCBQYWdlIFJlcXVlc3QgQWxsb2NhdGlvbjogMDAwMDAwMDAK
CUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBpOTE1CglLZXJuZWwgbW9kdWxlczogaTkxNQoKMDA6
MTQuMCBVU0IgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gMTAwIFNlcmllcy9DMjMw
IFNlcmllcyBDaGlwc2V0IEZhbWlseSBVU0IgMy4wIHhIQ0kgQ29udHJvbGxlciAocmV2IDMx
KSAocHJvZy1pZiAzMCBbWEhDSV0pCglTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtB
TEldIERldmljZSAxMTRlCglDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3lj
bGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJC
LSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkIrIFBhckVyci0g
REVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlIt
IElOVHgtCglMYXRlbmN5OiAwCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTI3
CglSZWdpb24gMDogTWVtb3J5IGF0IDYzNTAwMDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFi
bGUpIFtzaXplPTY0S10KCUNhcGFiaWxpdGllczogWzcwXSBQb3dlciBNYW5hZ2VtZW50IHZl
cnNpb24gMgoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTM3NW1B
IFBNRShEMC0sRDEtLEQyLSxEM2hvdCssRDNjb2xkKykKCQlTdGF0dXM6IEQwIE5vU29mdFJz
dCsgUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzgw
XSBNU0k6IEVuYWJsZSsgQ291bnQ9MS84IE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNzOiAw
MDAwMDAwMGZlZTAwMmY4ICBEYXRhOiAwMDAwCglLZXJuZWwgZHJpdmVyIGluIHVzZTogeGhj
aV9oY2QKCUtlcm5lbCBtb2R1bGVzOiB4aGNpX3BjaQoKMDA6MTQuMiBTaWduYWwgcHJvY2Vz
c2luZyBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiAxMDAgU2VyaWVzL0MyMzAgU2Vy
aWVzIENoaXBzZXQgRmFtaWx5IFRoZXJtYWwgU3Vic3lzdGVtIChyZXYgMzEpCglTdWJzeXN0
ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSAxMTRlCglDb250cm9sOiBJL08t
IE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnIt
IFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6
LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0g
PE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMAoJSW50ZXJydXB0OiBw
aW4gQyByb3V0ZWQgdG8gSVJRIDE4CglSZWdpb24gMDogTWVtb3J5IGF0IDJmZjMwMTgwMDAg
KDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NEtdCglDYXBhYmlsaXRpZXM6IFs1
MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0krIEQx
LSBEMi0gQXV4Q3VycmVudD0wbUEgUE1FKEQwLSxEMS0sRDItLEQzaG90LSxEM2NvbGQtKQoJ
CVN0YXR1czogRDAgTm9Tb2Z0UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1F
LQoJQ2FwYWJpbGl0aWVzOiBbODBdIE1TSTogRW5hYmxlLSBDb3VudD0xLzEgTWFza2FibGUt
IDY0Yml0LQoJCUFkZHJlc3M6IDAwMDAwMDAwICBEYXRhOiAwMDAwCglLZXJuZWwgZHJpdmVy
IGluIHVzZTogaW50ZWxfcGNoX3RoZXJtYWwKCUtlcm5lbCBtb2R1bGVzOiBpbnRlbF9wY2hf
dGhlcm1hbAoKMDA6MTUuMCBTaWduYWwgcHJvY2Vzc2luZyBjb250cm9sbGVyOiBJbnRlbCBD
b3Jwb3JhdGlvbiAxMDAgU2VyaWVzL0MyMzAgU2VyaWVzIENoaXBzZXQgRmFtaWx5IFNlcmlh
bCBJTyBJMkMgQ29udHJvbGxlciAjMCAocmV2IDMxKQoJU3Vic3lzdGVtOiBBY2VyIEluY29y
cG9yYXRlZCBbQUxJXSBEZXZpY2UgMTE0ZQoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3Rl
cisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VS
Ui0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJC
LSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJS
LSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAsIENhY2hlIExpbmUgU2l6ZTogNjQgYnl0ZXMK
CUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAxNgoJUmVnaW9uIDA6IE1lbW9yeSBh
dCAyZmYzMDE3MDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTRLXQoJQ2Fw
YWJpbGl0aWVzOiBbODBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxhZ3M6IFBN
RUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMC0sRDEtLEQyLSxEM2hv
dC0sRDNjb2xkLSkKCQlTdGF0dXM6IEQwIE5vU29mdFJzdCsgUE1FLUVuYWJsZS0gRFNlbD0w
IERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzkwXSBWZW5kb3IgU3BlY2lmaWMgSW5m
b3JtYXRpb246IExlbj0xNCA8Pz4KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBpbnRlbC1scHNz
CglLZXJuZWwgbW9kdWxlczogaW50ZWxfbHBzc19wY2kKCjAwOjE1LjEgU2lnbmFsIHByb2Nl
c3NpbmcgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gMTAwIFNlcmllcy9DMjMwIFNl
cmllcyBDaGlwc2V0IEZhbWlseSBTZXJpYWwgSU8gSTJDIENvbnRyb2xsZXIgIzEgKHJldiAz
MSkKCVN1YnN5c3RlbTogQWNlciBJbmNvcnBvcmF0ZWQgW0FMSV0gRGV2aWNlIDExNGUKCUNv
bnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25v
b3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6
IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0
LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwLCBD
YWNoZSBMaW5lIFNpemU6IDY0IGJ5dGVzCglJbnRlcnJ1cHQ6IHBpbiBCIHJvdXRlZCB0byBJ
UlEgMTcKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgMmZmMzAxNjAwMCAoNjQtYml0LCBub24tcHJl
ZmV0Y2hhYmxlKSBbc2l6ZT00S10KCUNhcGFiaWxpdGllczogWzgwXSBQb3dlciBNYW5hZ2Vt
ZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50
PTBtQSBQTUUoRDAtLEQxLSxEMi0sRDNob3QtLEQzY29sZC0pCgkJU3RhdHVzOiBEMCBOb1Nv
ZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6
IFs5MF0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBMZW49MTQgPD8+CglLZXJuZWwg
ZHJpdmVyIGluIHVzZTogaW50ZWwtbHBzcwoJS2VybmVsIG1vZHVsZXM6IGludGVsX2xwc3Nf
cGNpCgowMDoxNi4wIENvbW11bmljYXRpb24gY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRp
b24gMTAwIFNlcmllcy9DMjMwIFNlcmllcyBDaGlwc2V0IEZhbWlseSBNRUkgQ29udHJvbGxl
ciAjMSAocmV2IDMxKQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZp
Y2UgMTE0ZQoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1X
SU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5U
eCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1m
YXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxh
dGVuY3k6IDAKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAxMzAKCVJlZ2lvbiAw
OiBNZW1vcnkgYXQgMmZmMzAxNTAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6
ZT00S10KCUNhcGFiaWxpdGllczogWzUwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJ
CUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDAtLEQx
LSxEMi0sRDNob3QrLEQzY29sZC0pCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QrIFBNRS1FbmFi
bGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6IFs4Y10gTVNJOiBFbmFi
bGUrIENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUw
MDM1OCAgRGF0YTogMDAwMAoJS2VybmVsIGRyaXZlciBpbiB1c2U6IG1laV9tZQoJS2VybmVs
IG1vZHVsZXM6IG1laV9tZQoKMDA6MTcuMCBTQVRBIGNvbnRyb2xsZXI6IEludGVsIENvcnBv
cmF0aW9uIEhNMTcwL1FNMTcwIENoaXBzZXQgU0FUQSBDb250cm9sbGVyIFtBSENJIE1vZGVd
IChyZXYgMzEpIChwcm9nLWlmIDAxIFtBSENJIDEuMF0pCglTdWJzeXN0ZW06IEFjZXIgSW5j
b3Jwb3JhdGVkIFtBTEldIERldmljZSAxMTRlCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFz
dGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBT
RVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6KyBVREYtIEZhc3RC
MkIrIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+
U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRl
ZCB0byBJUlEgMTI2CglSZWdpb24gMDogTWVtb3J5IGF0IDYzNTE0MDAwICgzMi1iaXQsIG5v
bi1wcmVmZXRjaGFibGUpIFtzaXplPThLXQoJUmVnaW9uIDE6IE1lbW9yeSBhdCA2MzUxNzAw
MCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yNTZdCglSZWdpb24gMjogSS9P
IHBvcnRzIGF0IDUwODAgW3NpemU9OF0KCVJlZ2lvbiAzOiBJL08gcG9ydHMgYXQgNTA4OCBb
c2l6ZT00XQoJUmVnaW9uIDQ6IEkvTyBwb3J0cyBhdCA1MDYwIFtzaXplPTMyXQoJUmVnaW9u
IDU6IE1lbW9yeSBhdCA2MzUxNjAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6
ZT0yS10KCUNhcGFiaWxpdGllczogWzgwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS8xIE1hc2th
YmxlLSA2NGJpdC0KCQlBZGRyZXNzOiBmZWUwMDJkOCAgRGF0YTogMDAwMAoJQ2FwYWJpbGl0
aWVzOiBbNzBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxhZ3M6IFBNRUNsay0g
RFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMC0sRDEtLEQyLSxEM2hvdCssRDNj
b2xkLSkKCQlTdGF0dXM6IEQwIE5vU29mdFJzdCsgUE1FLUVuYWJsZS0gRFNlbD0wIERTY2Fs
ZT0wIFBNRS0KCUNhcGFiaWxpdGllczogW2E4XSBTQVRBIEhCQSB2MS4wIEJBUjQgT2Zmc2V0
PTAwMDAwMDA0CglLZXJuZWwgZHJpdmVyIGluIHVzZTogYWhjaQoKMDA6MWMuMCBQQ0kgYnJp
ZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiAxMDAgU2VyaWVzL0MyMzAgU2VyaWVzIENoaXBzZXQg
RmFtaWx5IFBDSSBFeHByZXNzIFJvb3QgUG9ydCAjMyAocmV2IGYxKSAocHJvZy1pZiAwMCBb
Tm9ybWFsIGRlY29kZV0pCglTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERl
dmljZSAxMTRlCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1l
bVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJ
TlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VM
PWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJ
TGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiA2NCBieXRlcwoJSW50ZXJydXB0OiBwaW4g
QyByb3V0ZWQgdG8gSVJRIDEyMwoJQnVzOiBwcmltYXJ5PTAwLCBzZWNvbmRhcnk9MDIsIHN1
Ym9yZGluYXRlPTAyLCBzZWMtbGF0ZW5jeT0wCglJL08gYmVoaW5kIGJyaWRnZTogW2Rpc2Fi
bGVkXSBbMTYtYml0XQoJTWVtb3J5IGJlaGluZCBicmlkZ2U6IDYzMjAwMDAwLTYzM2ZmZmZm
IFtzaXplPTJNXSBbMzItYml0XQoJUHJlZmV0Y2hhYmxlIG1lbW9yeSBiZWhpbmQgYnJpZGdl
OiBbZGlzYWJsZWRdIFs2NC1iaXRdCglTZWNvbmRhcnkgc3RhdHVzOiA2Nk1Iei0gRmFzdEIy
Qi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0KyA8U0VS
Ui0gPFBFUlItCglCcmlkZ2VDdGw6IFBhcml0eS0gU0VSUisgTm9JU0EtIFZHQS0gVkdBMTYt
IE1BYm9ydC0gPlJlc2V0LSBGYXN0QjJCLQoJCVByaURpc2NUbXItIFNlY0Rpc2NUbXItIERp
c2NUbXJTdGF0LSBEaXNjVG1yU0VSUkVuLQoJQ2FwYWJpbGl0aWVzOiBbNDBdIEV4cHJlc3Mg
KHYyKSBSb290IFBvcnQgKFNsb3QrKSwgTVNJIDAwCgkJRGV2Q2FwOglNYXhQYXlsb2FkIDI1
NiBieXRlcywgUGhhbnRGdW5jIDAKCQkJRXh0VGFnLSBSQkUrCgkJRGV2Q3RsOglDb3JyRXJy
LSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLQoJCQlSbHhkT3JkLSBFeHRUYWct
IFBoYW50RnVuYy0gQXV4UHdyLSBOb1Nub29wLQoJCQlNYXhQYXlsb2FkIDI1NiBieXRlcywg
TWF4UmVhZFJlcSAxMjggYnl0ZXMKCQlEZXZTdGE6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBG
YXRhbEVyci0gVW5zdXBSZXEtIEF1eFB3cisgVHJhbnNQZW5kLQoJCUxua0NhcDoJUG9ydCAj
MywgU3BlZWQgOEdUL3MsIFdpZHRoIHgxLCBBU1BNIEwxLCBFeGl0IExhdGVuY3kgTDEgPDE2
dXMKCQkJQ2xvY2tQTS0gU3VycHJpc2UtIExMQWN0UmVwKyBCd05vdCsgQVNQTU9wdENvbXAr
CgkJTG5rQ3RsOglBU1BNIEwxIEVuYWJsZWQ7IFJDQiA2NCBieXRlcywgRGlzYWJsZWQtIENv
bW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0lu
dC0KCQlMbmtTdGE6CVNwZWVkIDIuNUdUL3MsIFdpZHRoIHgxCgkJCVRyRXJyLSBUcmFpbi0g
U2xvdENsaysgRExBY3RpdmUrIEJXTWdtdCsgQUJXTWdtdC0KCQlTbHRDYXA6CUF0dG5CdG4t
IFB3ckN0cmwtIE1STC0gQXR0bkluZC0gUHdySW5kLSBIb3RQbHVnLSBTdXJwcmlzZS0KCQkJ
U2xvdCAjMiwgUG93ZXJMaW1pdCAxMFc7IEludGVybG9jay0gTm9Db21wbCsKCQlTbHRDdGw6
CUVuYWJsZTogQXR0bkJ0bi0gUHdyRmx0LSBNUkwtIFByZXNEZXQtIENtZENwbHQtIEhQSXJx
LSBMaW5rQ2hnLQoJCQlDb250cm9sOiBBdHRuSW5kIFVua25vd24sIFB3ckluZCBVbmtub3du
LCBQb3dlci0gSW50ZXJsb2NrLQoJCVNsdFN0YToJU3RhdHVzOiBBdHRuQnRuLSBQb3dlckZs
dC0gTVJMLSBDbWRDcGx0LSBQcmVzRGV0KyBJbnRlcmxvY2stCgkJCUNoYW5nZWQ6IE1STC0g
UHJlc0RldC0gTGlua1N0YXRlKwoJCVJvb3RDYXA6IENSU1Zpc2libGUtCgkJUm9vdEN0bDog
RXJyQ29ycmVjdGFibGUtIEVyck5vbi1GYXRhbC0gRXJyRmF0YWwtIFBNRUludEVuYS0gQ1JT
VmlzaWJsZS0KCQlSb290U3RhOiBQTUUgUmVxSUQgMDAwMCwgUE1FU3RhdHVzLSBQTUVQZW5k
aW5nLQoJCURldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogUmFuZ2UgQUJDLCBUaW1lb3V0
RGlzKyBOUk9QclByUC0gTFRSKwoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JG
RiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93
ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0
LQoJCQkgRlJTLSBMTiBTeXN0ZW0gQ0xTIE5vdCBTdXBwb3J0ZWQsIFRQSENvbXAtIEV4dFRQ
SENvbXAtIEFSSUZ3ZCsKCQkJIEF0b21pY09wc0NhcDogUm91dGluZy0gMzJiaXQtIDY0Yml0
LSAxMjhiaXRDQVMtCgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUw
bXMsIFRpbWVvdXREaXMtIExUUisgMTBCaXRUYWdSZXEtIE9CRkYgRGlzYWJsZWQsIEFSSUZ3
ZC0KCQkJIEF0b21pY09wc0N0bDogUmVxRW4tIEVncmVzc0JsY2stCgkJTG5rQ2FwMjogU3Vw
cG9ydGVkIExpbmsgU3BlZWRzOiAyLjUtOEdUL3MsIENyb3NzbGluay0gUmV0aW1lci0gMlJl
dGltZXJzLSBEUlMtCgkJTG5rQ3RsMjogVGFyZ2V0IExpbmsgU3BlZWQ6IDhHVC9zLCBFbnRl
ckNvbXBsaWFuY2UtIFNwZWVkRGlzLQoJCQkgVHJhbnNtaXQgTWFyZ2luOiBOb3JtYWwgT3Bl
cmF0aW5nIFJhbmdlLCBFbnRlck1vZGlmaWVkQ29tcGxpYW5jZS0gQ29tcGxpYW5jZVNPUy0K
CQkJIENvbXBsaWFuY2UgUHJlc2V0L0RlLWVtcGhhc2lzOiAtNmRCIGRlLWVtcGhhc2lzLCAw
ZEIgcHJlc2hvb3QKCQlMbmtTdGEyOiBDdXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtMy41
ZEIsIEVxdWFsaXphdGlvbkNvbXBsZXRlLSBFcXVhbGl6YXRpb25QaGFzZTEtCgkJCSBFcXVh
bGl6YXRpb25QaGFzZTItIEVxdWFsaXphdGlvblBoYXNlMy0gTGlua0VxdWFsaXphdGlvblJl
cXVlc3QtCgkJCSBSZXRpbWVyLSAyUmV0aW1lcnMtIENyb3NzbGlua1JlczogdW5zdXBwb3J0
ZWQKCUNhcGFiaWxpdGllczogWzgwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS8xIE1hc2thYmxl
LSA2NGJpdC0KCQlBZGRyZXNzOiBmZWUwMDI1OCAgRGF0YTogMDAwMAoJQ2FwYWJpbGl0aWVz
OiBbOTBdIFN1YnN5c3RlbTogQWNlciBJbmNvcnBvcmF0ZWQgW0FMSV0gRGV2aWNlIDExNGUK
CUNhcGFiaWxpdGllczogW2EwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdz
OiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0s
RDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBNRS1FbmFibGUtIERT
ZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6IFsxMDAgdjFdIEFkdmFuY2VkIEVy
cm9yIFJlcG9ydGluZwoJCVVFU3RhOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBD
bXBsdEFicnQtIFVueENtcGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1cFJlcS0gQUNT
VmlvbC0KCQlVRU1zazoJRExQLSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0
LSBVbnhDbXBsdCsgUnhPRi0gTWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJ
VUVTdnJ0OglETFArIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENt
cGx0LSBSeE9GKyBNYWxmVExQKyBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlDRVN0YToJ
UnhFcnItIEJhZFRMUC0gQmFkRExMUC0gUm9sbG92ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFs
RXJyLQoJCUNFTXNrOglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91
dC0gQWR2Tm9uRmF0YWxFcnIrCgkJQUVSQ2FwOglGaXJzdCBFcnJvciBQb2ludGVyOiAwMCwg
RUNSQ0dlbkNhcC0gRUNSQ0dlbkVuLSBFQ1JDQ2hrQ2FwLSBFQ1JDQ2hrRW4tCgkJCU11bHRI
ZHJSZWNDYXAtIE11bHRIZHJSZWNFbi0gVExQUGZ4UHJlcy0gSGRyTG9nQ2FwLQoJCUhlYWRl
ckxvZzogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAKCQlSb290Q21kOiBD
RVJwdEVuLSBORkVScHRFbi0gRkVScHRFbi0KCQlSb290U3RhOiBDRVJjdmQtIE11bHRDRVJj
dmQtIFVFUmN2ZC0gTXVsdFVFUmN2ZC0KCQkJIEZpcnN0RmF0YWwtIE5vbkZhdGFsTXNnLSBG
YXRhbE1zZy0gSW50TXNnIDAKCQlFcnJvclNyYzogRVJSX0NPUjogMDAwMCBFUlJfRkFUQUwv
Tk9ORkFUQUw6IDAwMDAKCUNhcGFiaWxpdGllczogWzE0MCB2MV0gQWNjZXNzIENvbnRyb2wg
U2VydmljZXMKCQlBQ1NDYXA6CVNyY1ZhbGlkKyBUcmFuc0JsaysgUmVxUmVkaXIrIENtcGx0
UmVkaXIrIFVwc3RyZWFtRndkLSBFZ3Jlc3NDdHJsLSBEaXJlY3RUcmFucy0KCQlBQ1NDdGw6
CVNyY1ZhbGlkLSBUcmFuc0Jsay0gUmVxUmVkaXItIENtcGx0UmVkaXItIFVwc3RyZWFtRndk
LSBFZ3Jlc3NDdHJsLSBEaXJlY3RUcmFucy0KCUNhcGFiaWxpdGllczogWzIyMCB2MV0gU2Vj
b25kYXJ5IFBDSSBFeHByZXNzCgkJTG5rQ3RsMzogTG5rRXF1SW50cnJ1cHRFbi0gUGVyZm9y
bUVxdS0KCQlMYW5lRXJyU3RhdDogMAoJS2VybmVsIGRyaXZlciBpbiB1c2U6IHBjaWVwb3J0
CgowMDoxYy4zIFBDSSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIDEwMCBTZXJpZXMvQzIz
MCBTZXJpZXMgQ2hpcHNldCBGYW1pbHkgUENJIEV4cHJlc3MgUm9vdCBQb3J0ICM0IChyZXYg
ZjEpIChwcm9nLWlmIDAwIFtOb3JtYWwgZGVjb2RlXSkKCVN1YnN5c3RlbTogQWNlciBJbmNv
cnBvcmF0ZWQgW0FMSV0gRGV2aWNlIDExNGUKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0
ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNF
UlItIEZhc3RCMkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIy
Qi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VS
Ui0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDY0IGJ5dGVz
CglJbnRlcnJ1cHQ6IHBpbiBEIHJvdXRlZCB0byBJUlEgMTI0CglCdXM6IHByaW1hcnk9MDAs
IHNlY29uZGFyeT0wMywgc3Vib3JkaW5hdGU9MDMsIHNlYy1sYXRlbmN5PTAKCUkvTyBiZWhp
bmQgYnJpZGdlOiAzMDAwLTNmZmYgW3NpemU9NEtdIFsxNi1iaXRdCglNZW1vcnkgYmVoaW5k
IGJyaWRnZTogNjM0MDAwMDAtNjM0ZmZmZmYgW3NpemU9MU1dIFszMi1iaXRdCglQcmVmZXRj
aGFibGUgbWVtb3J5IGJlaGluZCBicmlkZ2U6IFtkaXNhYmxlZF0gWzY0LWJpdF0KCVNlY29u
ZGFyeSBzdGF0dXM6IDY2TUh6LSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJv
cnQtIDxUQWJvcnQtIDxNQWJvcnQrIDxTRVJSLSA8UEVSUi0KCUJyaWRnZUN0bDogUGFyaXR5
LSBTRVJSKyBOb0lTQS0gVkdBLSBWR0ExNi0gTUFib3J0LSA+UmVzZXQtIEZhc3RCMkItCgkJ
UHJpRGlzY1Rtci0gU2VjRGlzY1Rtci0gRGlzY1RtclN0YXQtIERpc2NUbXJTRVJSRW4tCglD
YXBhYmlsaXRpZXM6IFs0MF0gRXhwcmVzcyAodjIpIFJvb3QgUG9ydCAoU2xvdCspLCBNU0kg
MDAKCQlEZXZDYXA6CU1heFBheWxvYWQgMjU2IGJ5dGVzLCBQaGFudEZ1bmMgMAoJCQlFeHRU
YWctIFJCRSsKCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5z
dXBSZXEtCgkJCVJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3At
CgkJCU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDEyOCBieXRlcwoJCURldlN0
YToJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdyKyBU
cmFuc1BlbmQtCgkJTG5rQ2FwOglQb3J0ICM0LCBTcGVlZCA4R1QvcywgV2lkdGggeDEsIEFT
UE0gTDEsIEV4aXQgTGF0ZW5jeSBMMSA8MTZ1cwoJCQlDbG9ja1BNLSBTdXJwcmlzZS0gTExB
Y3RSZXArIEJ3Tm90KyBBU1BNT3B0Q29tcCsKCQlMbmtDdGw6CUFTUE0gTDEgRW5hYmxlZDsg
UkNCIDY0IGJ5dGVzLCBEaXNhYmxlZC0gQ29tbUNsaysKCQkJRXh0U3luY2gtIENsb2NrUE0t
IEF1dFdpZERpcy0gQldJbnQtIEF1dEJXSW50LQoJCUxua1N0YToJU3BlZWQgMi41R1Qvcywg
V2lkdGggeDEKCQkJVHJFcnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZSsgQldNZ210KyBB
QldNZ210LQoJCVNsdENhcDoJQXR0bkJ0bi0gUHdyQ3RybC0gTVJMLSBBdHRuSW5kLSBQd3JJ
bmQtIEhvdFBsdWctIFN1cnByaXNlLQoJCQlTbG90ICMzLCBQb3dlckxpbWl0IDEwVzsgSW50
ZXJsb2NrLSBOb0NvbXBsKwoJCVNsdEN0bDoJRW5hYmxlOiBBdHRuQnRuLSBQd3JGbHQtIE1S
TC0gUHJlc0RldC0gQ21kQ3BsdC0gSFBJcnEtIExpbmtDaGctCgkJCUNvbnRyb2w6IEF0dG5J
bmQgVW5rbm93biwgUHdySW5kIFVua25vd24sIFBvd2VyLSBJbnRlcmxvY2stCgkJU2x0U3Rh
OglTdGF0dXM6IEF0dG5CdG4tIFBvd2VyRmx0LSBNUkwtIENtZENwbHQtIFByZXNEZXQrIElu
dGVybG9jay0KCQkJQ2hhbmdlZDogTVJMLSBQcmVzRGV0LSBMaW5rU3RhdGUrCgkJUm9vdENh
cDogQ1JTVmlzaWJsZS0KCQlSb290Q3RsOiBFcnJDb3JyZWN0YWJsZS0gRXJyTm9uLUZhdGFs
LSBFcnJGYXRhbC0gUE1FSW50RW5hLSBDUlNWaXNpYmxlLQoJCVJvb3RTdGE6IFBNRSBSZXFJ
RCAwMDAwLCBQTUVTdGF0dXMtIFBNRVBlbmRpbmctCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBU
aW1lb3V0OiBSYW5nZSBBQkMsIFRpbWVvdXREaXMrIE5ST1ByUHJQLSBMVFIrCgkJCSAxMEJp
dFRhZ0NvbXAtIDEwQml0VGFnUmVxLSBPQkZGIE5vdCBTdXBwb3J0ZWQsIEV4dEZtdC0gRUVU
TFBQcmVmaXgtCgkJCSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbiBOb3QgU3VwcG9ydGVkLCBF
bWVyZ2VuY3lQb3dlclJlZHVjdGlvbkluaXQtCgkJCSBGUlMtIExOIFN5c3RlbSBDTFMgTm90
IFN1cHBvcnRlZCwgVFBIQ29tcC0gRXh0VFBIQ29tcC0gQVJJRndkKwoJCQkgQXRvbWljT3Bz
Q2FwOiBSb3V0aW5nLSAzMmJpdC0gNjRiaXQtIDEyOGJpdENBUy0KCQlEZXZDdGwyOiBDb21w
bGV0aW9uIFRpbWVvdXQ6IDUwdXMgdG8gNTBtcywgVGltZW91dERpcy0gTFRSKyAxMEJpdFRh
Z1JlcS0gT0JGRiBEaXNhYmxlZCwgQVJJRndkLQoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0g
RWdyZXNzQmxjay0KCQlMbmtDYXAyOiBTdXBwb3J0ZWQgTGluayBTcGVlZHM6IDIuNS04R1Qv
cywgQ3Jvc3NsaW5rLSBSZXRpbWVyLSAyUmV0aW1lcnMtIERSUy0KCQlMbmtDdGwyOiBUYXJn
ZXQgTGluayBTcGVlZDogOEdUL3MsIEVudGVyQ29tcGxpYW5jZS0gU3BlZWREaXMtCgkJCSBU
cmFuc21pdCBNYXJnaW46IE5vcm1hbCBPcGVyYXRpbmcgUmFuZ2UsIEVudGVyTW9kaWZpZWRD
b21wbGlhbmNlLSBDb21wbGlhbmNlU09TLQoJCQkgQ29tcGxpYW5jZSBQcmVzZXQvRGUtZW1w
aGFzaXM6IC02ZEIgZGUtZW1waGFzaXMsIDBkQiBwcmVzaG9vdAoJCUxua1N0YTI6IEN1cnJl
bnQgRGUtZW1waGFzaXMgTGV2ZWw6IC0zLjVkQiwgRXF1YWxpemF0aW9uQ29tcGxldGUtIEVx
dWFsaXphdGlvblBoYXNlMS0KCQkJIEVxdWFsaXphdGlvblBoYXNlMi0gRXF1YWxpemF0aW9u
UGhhc2UzLSBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0KCQkJIFJldGltZXItIDJSZXRpbWVy
cy0gQ3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJQ2FwYWJpbGl0aWVzOiBbODBdIE1TSTog
RW5hYmxlKyBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0LQoJCUFkZHJlc3M6IGZlZTAwMjk4
ICBEYXRhOiAwMDAwCglDYXBhYmlsaXRpZXM6IFs5MF0gU3Vic3lzdGVtOiBBY2VyIEluY29y
cG9yYXRlZCBbQUxJXSBEZXZpY2UgMTE0ZQoJQ2FwYWJpbGl0aWVzOiBbYTBdIFBvd2VyIE1h
bmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxhZ3M6IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1eEN1
cnJlbnQ9MG1BIFBNRShEMCssRDEtLEQyLSxEM2hvdCssRDNjb2xkKykKCQlTdGF0dXM6IEQw
IE5vU29mdFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxp
dGllczogWzEwMCB2MV0gQWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5nCgkJVUVTdGE6CURMUC0g
U0RFUy0gVExQLSBGQ1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1h
bGZUTFAtIEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLQoJCVVFTXNrOglETFAtIFNERVMtIFRM
UC0gRkNQLSBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENtcGx0KyBSeE9GLSBNYWxmVExQLSBF
Q1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlVRVN2cnQ6CURMUCsgU0RFUy0gVExQLSBGQ1At
IENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YrIE1hbGZUTFArIEVDUkMtIFVu
c3VwUmVxLSBBQ1NWaW9sLQoJCUNFU3RhOglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xs
b3Zlci0gVGltZW91dC0gQWR2Tm9uRmF0YWxFcnItCgkJQ0VNc2s6CVJ4RXJyLSBCYWRUTFAt
IEJhZERMTFAtIFJvbGxvdmVyLSBUaW1lb3V0LSBBZHZOb25GYXRhbEVycisKCQlBRVJDYXA6
CUZpcnN0IEVycm9yIFBvaW50ZXI6IDAwLCBFQ1JDR2VuQ2FwLSBFQ1JDR2VuRW4tIEVDUkND
aGtDYXAtIEVDUkNDaGtFbi0KCQkJTXVsdEhkclJlY0NhcC0gTXVsdEhkclJlY0VuLSBUTFBQ
ZnhQcmVzLSBIZHJMb2dDYXAtCgkJSGVhZGVyTG9nOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAwMAoJCVJvb3RDbWQ6IENFUnB0RW4tIE5GRVJwdEVuLSBGRVJwdEVuLQoJ
CVJvb3RTdGE6IENFUmN2ZC0gTXVsdENFUmN2ZC0gVUVSY3ZkLSBNdWx0VUVSY3ZkLQoJCQkg
Rmlyc3RGYXRhbC0gTm9uRmF0YWxNc2ctIEZhdGFsTXNnLSBJbnRNc2cgMAoJCUVycm9yU3Jj
OiBFUlJfQ09SOiAwMDAwIEVSUl9GQVRBTC9OT05GQVRBTDogMDAwMAoJQ2FwYWJpbGl0aWVz
OiBbMTQwIHYxXSBBY2Nlc3MgQ29udHJvbCBTZXJ2aWNlcwoJCUFDU0NhcDoJU3JjVmFsaWQr
IFRyYW5zQmxrKyBSZXFSZWRpcisgQ21wbHRSZWRpcisgVXBzdHJlYW1Gd2QtIEVncmVzc0N0
cmwtIERpcmVjdFRyYW5zLQoJCUFDU0N0bDoJU3JjVmFsaWQtIFRyYW5zQmxrLSBSZXFSZWRp
ci0gQ21wbHRSZWRpci0gVXBzdHJlYW1Gd2QtIEVncmVzc0N0cmwtIERpcmVjdFRyYW5zLQoJ
Q2FwYWJpbGl0aWVzOiBbMjIwIHYxXSBTZWNvbmRhcnkgUENJIEV4cHJlc3MKCQlMbmtDdGwz
OiBMbmtFcXVJbnRycnVwdEVuLSBQZXJmb3JtRXF1LQoJCUxhbmVFcnJTdGF0OiAwCglLZXJu
ZWwgZHJpdmVyIGluIHVzZTogcGNpZXBvcnQKCjAwOjFjLjQgUENJIGJyaWRnZTogSW50ZWwg
Q29ycG9yYXRpb24gMTAwIFNlcmllcy9DMjMwIFNlcmllcyBDaGlwc2V0IEZhbWlseSBQQ0kg
RXhwcmVzcyBSb290IFBvcnQgIzUgKHJldiBmMSkgKHByb2ctaWYgMDAgW05vcm1hbCBkZWNv
ZGVdKQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgMTE0ZQoJ
Q29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FT
bm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1
czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJv
cnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAs
IENhY2hlIExpbmUgU2l6ZTogNjQgYnl0ZXMKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRv
IElSUSAxMjUKCUJ1czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTA0LCBzdWJvcmRpbmF0ZT0z
Yywgc2VjLWxhdGVuY3k9MAoJSS9PIGJlaGluZCBicmlkZ2U6IDYwMDAtNmZmZiBbc2l6ZT00
S10gWzE2LWJpdF0KCU1lbW9yeSBiZWhpbmQgYnJpZGdlOiA2NDAwMDAwMC03YTBmZmZmZiBb
c2l6ZT0zNTNNXSBbMzItYml0XQoJUHJlZmV0Y2hhYmxlIG1lbW9yeSBiZWhpbmQgYnJpZGdl
OiAyZmQwMDAwMDAwLTJmZjFmZmZmZmYgW3NpemU9NTQ0TV0gWzMyLWJpdF0KCVNlY29uZGFy
eSBzdGF0dXM6IDY2TUh6LSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQt
IDxUQWJvcnQtIDxNQWJvcnQrIDxTRVJSLSA8UEVSUi0KCUJyaWRnZUN0bDogUGFyaXR5LSBT
RVJSKyBOb0lTQS0gVkdBLSBWR0ExNi0gTUFib3J0LSA+UmVzZXQtIEZhc3RCMkItCgkJUHJp
RGlzY1Rtci0gU2VjRGlzY1Rtci0gRGlzY1RtclN0YXQtIERpc2NUbXJTRVJSRW4tCglDYXBh
YmlsaXRpZXM6IFs0MF0gRXhwcmVzcyAodjIpIFJvb3QgUG9ydCAoU2xvdCspLCBNU0kgMDAK
CQlEZXZDYXA6CU1heFBheWxvYWQgMTI4IGJ5dGVzLCBQaGFudEZ1bmMgMAoJCQlFeHRUYWct
IFJCRSsKCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBS
ZXEtCgkJCVJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3AtCgkJ
CU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDEyOCBieXRlcwoJCURldlN0YToJ
Q29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdyKyBUcmFu
c1BlbmQtCgkJTG5rQ2FwOglQb3J0ICM1LCBTcGVlZCA4R1QvcywgV2lkdGggeDQsIEFTUE0g
bm90IHN1cHBvcnRlZAoJCQlDbG9ja1BNLSBTdXJwcmlzZS0gTExBY3RSZXArIEJ3Tm90KyBB
U1BNT3B0Q29tcCsKCQlMbmtDdGw6CUFTUE0gRGlzYWJsZWQ7IFJDQiA2NCBieXRlcywgRGlz
YWJsZWQtIENvbW1DbGstCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50
LSBBdXRCV0ludC0KCQlMbmtTdGE6CVNwZWVkIDIuNUdUL3MsIFdpZHRoIHgwCgkJCVRyRXJy
LSBUcmFpbisgU2xvdENsaysgRExBY3RpdmUtIEJXTWdtdC0gQUJXTWdtdC0KCQlTbHRDYXA6
CUF0dG5CdG4tIFB3ckN0cmwtIE1STC0gQXR0bkluZC0gUHdySW5kLSBIb3RQbHVnKyBTdXJw
cmlzZSsKCQkJU2xvdCAjNCwgUG93ZXJMaW1pdCAyNVc7IEludGVybG9jay0gTm9Db21wbCsK
CQlTbHRDdGw6CUVuYWJsZTogQXR0bkJ0bi0gUHdyRmx0LSBNUkwtIFByZXNEZXQrIENtZENw
bHQtIEhQSXJxLSBMaW5rQ2hnLQoJCQlDb250cm9sOiBBdHRuSW5kIFVua25vd24sIFB3cklu
ZCBVbmtub3duLCBQb3dlci0gSW50ZXJsb2NrLQoJCVNsdFN0YToJU3RhdHVzOiBBdHRuQnRu
LSBQb3dlckZsdC0gTVJMLSBDbWRDcGx0LSBQcmVzRGV0KyBJbnRlcmxvY2stCgkJCUNoYW5n
ZWQ6IE1STC0gUHJlc0RldC0gTGlua1N0YXRlLQoJCVJvb3RDYXA6IENSU1Zpc2libGUtCgkJ
Um9vdEN0bDogRXJyQ29ycmVjdGFibGUtIEVyck5vbi1GYXRhbC0gRXJyRmF0YWwtIFBNRUlu
dEVuYS0gQ1JTVmlzaWJsZS0KCQlSb290U3RhOiBQTUUgUmVxSUQgMDAwMCwgUE1FU3RhdHVz
LSBQTUVQZW5kaW5nLQoJCURldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogUmFuZ2UgQUJD
LCBUaW1lb3V0RGlzKyBOUk9QclByUC0gTFRSKwoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRh
Z1JlcS0gT0JGRiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1l
cmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1
Y3Rpb25Jbml0LQoJCQkgRlJTLSBMTiBTeXN0ZW0gQ0xTIE5vdCBTdXBwb3J0ZWQsIFRQSENv
bXAtIEV4dFRQSENvbXAtIEFSSUZ3ZCsKCQkJIEF0b21pY09wc0NhcDogUm91dGluZy0gMzJi
aXQtIDY0Yml0LSAxMjhiaXRDQVMtCgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1
MHVzIHRvIDUwbXMsIFRpbWVvdXREaXMtIExUUisgMTBCaXRUYWdSZXEtIE9CRkYgRGlzYWJs
ZWQsIEFSSUZ3ZC0KCQkJIEF0b21pY09wc0N0bDogUmVxRW4tIEVncmVzc0JsY2stCgkJTG5r
Q2FwMjogU3VwcG9ydGVkIExpbmsgU3BlZWRzOiAyLjUtOEdUL3MsIENyb3NzbGluay0gUmV0
aW1lci0gMlJldGltZXJzLSBEUlMtCgkJTG5rQ3RsMjogVGFyZ2V0IExpbmsgU3BlZWQ6IDIu
NUdUL3MsIEVudGVyQ29tcGxpYW5jZS0gU3BlZWREaXMtCgkJCSBUcmFuc21pdCBNYXJnaW46
IE5vcm1hbCBPcGVyYXRpbmcgUmFuZ2UsIEVudGVyTW9kaWZpZWRDb21wbGlhbmNlLSBDb21w
bGlhbmNlU09TLQoJCQkgQ29tcGxpYW5jZSBQcmVzZXQvRGUtZW1waGFzaXM6IC02ZEIgZGUt
ZW1waGFzaXMsIDBkQiBwcmVzaG9vdAoJCUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMg
TGV2ZWw6IC0zLjVkQiwgRXF1YWxpemF0aW9uQ29tcGxldGUtIEVxdWFsaXphdGlvblBoYXNl
MS0KCQkJIEVxdWFsaXphdGlvblBoYXNlMi0gRXF1YWxpemF0aW9uUGhhc2UzLSBMaW5rRXF1
YWxpemF0aW9uUmVxdWVzdC0KCQkJIFJldGltZXItIDJSZXRpbWVycy0gQ3Jvc3NsaW5rUmVz
OiB1bnN1cHBvcnRlZAoJQ2FwYWJpbGl0aWVzOiBbODBdIE1TSTogRW5hYmxlKyBDb3VudD0x
LzEgTWFza2FibGUtIDY0Yml0LQoJCUFkZHJlc3M6IGZlZTAwMmI4ICBEYXRhOiAwMDAwCglD
YXBhYmlsaXRpZXM6IFs5MF0gU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBE
ZXZpY2UgMTE0ZQoJQ2FwYWJpbGl0aWVzOiBbYTBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lv
biAzCgkJRmxhZ3M6IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShE
MCssRDEtLEQyLSxEM2hvdCssRDNjb2xkKykKCQlTdGF0dXM6IEQwIE5vU29mdFJzdC0gUE1F
LUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzEwMCB2MV0g
QWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5nCgkJVUVTdGE6CURMUC0gU0RFUy0gVExQLSBGQ1At
IENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAtIEVDUkMtIFVu
c3VwUmVxLSBBQ1NWaW9sLQoJCVVFTXNrOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRP
KyBDbXBsdEFicnQtIFVueENtcGx0KyBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1cFJlcS0g
QUNTVmlvbC0KCQlVRVN2cnQ6CURMUCsgU0RFUy0gVExQLSBGQ1AtIENtcGx0VE8tIENtcGx0
QWJydC0gVW54Q21wbHQtIFJ4T0YrIE1hbGZUTFArIEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9s
LQoJCUNFU3RhOglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0g
QWR2Tm9uRmF0YWxFcnItCgkJQ0VNc2s6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAtIFJvbGxv
dmVyLSBUaW1lb3V0LSBBZHZOb25GYXRhbEVycisKCQlBRVJDYXA6CUZpcnN0IEVycm9yIFBv
aW50ZXI6IDAwLCBFQ1JDR2VuQ2FwLSBFQ1JDR2VuRW4tIEVDUkNDaGtDYXAtIEVDUkNDaGtF
bi0KCQkJTXVsdEhkclJlY0NhcC0gTXVsdEhkclJlY0VuLSBUTFBQZnhQcmVzLSBIZHJMb2dD
YXAtCgkJSGVhZGVyTG9nOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMAoJ
CVJvb3RDbWQ6IENFUnB0RW4tIE5GRVJwdEVuLSBGRVJwdEVuLQoJCVJvb3RTdGE6IENFUmN2
ZC0gTXVsdENFUmN2ZC0gVUVSY3ZkLSBNdWx0VUVSY3ZkLQoJCQkgRmlyc3RGYXRhbC0gTm9u
RmF0YWxNc2ctIEZhdGFsTXNnLSBJbnRNc2cgMAoJCUVycm9yU3JjOiBFUlJfQ09SOiAwMDAw
IEVSUl9GQVRBTC9OT05GQVRBTDogMDAwMAoJQ2FwYWJpbGl0aWVzOiBbMTQwIHYxXSBBY2Nl
c3MgQ29udHJvbCBTZXJ2aWNlcwoJCUFDU0NhcDoJU3JjVmFsaWQrIFRyYW5zQmxrKyBSZXFS
ZWRpcisgQ21wbHRSZWRpcisgVXBzdHJlYW1Gd2QtIEVncmVzc0N0cmwtIERpcmVjdFRyYW5z
LQoJCUFDU0N0bDoJU3JjVmFsaWQtIFRyYW5zQmxrLSBSZXFSZWRpci0gQ21wbHRSZWRpci0g
VXBzdHJlYW1Gd2QtIEVncmVzc0N0cmwtIERpcmVjdFRyYW5zLQoJQ2FwYWJpbGl0aWVzOiBb
MjIwIHYxXSBTZWNvbmRhcnkgUENJIEV4cHJlc3MKCQlMbmtDdGwzOiBMbmtFcXVJbnRycnVw
dEVuLSBQZXJmb3JtRXF1KwoJCUxhbmVFcnJTdGF0OiAwCglLZXJuZWwgZHJpdmVyIGluIHVz
ZTogcGNpZXBvcnQKCjAwOjFmLjAgSVNBIGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gSE0x
NzUgQ2hpcHNldCBMUEMvZVNQSSBDb250cm9sbGVyIChyZXYgMzEpCglTdWJzeXN0ZW06IEFj
ZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSAxMTRlCglDb250cm9sOiBJL08rIE1lbSsg
QnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBw
aW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6LSBVREYt
IEZhc3RCMkItIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFi
b3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwCgowMDoxZi4yIE1lbW9yeSBj
b250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiAxMDAgU2VyaWVzL0MyMzAgU2VyaWVzIENo
aXBzZXQgRmFtaWx5IFBvd2VyIE1hbmFnZW1lbnQgQ29udHJvbGxlciAocmV2IDMxKQoJU3Vi
c3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgMTE0ZQoJQ29udHJvbDog
SS9PLSBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFy
RXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwLSA2
Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJv
cnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCVJlZ2lvbiAw
OiBNZW1vcnkgYXQgNjM1MTAwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9
MTZLXQoKMDA6MWYuMyBBdWRpbyBkZXZpY2U6IEludGVsIENvcnBvcmF0aW9uIENNMjM4IEhE
IEF1ZGlvIENvbnRyb2xsZXIgKHJldiAzMSkKCVN1YnN5c3RlbTogQWNlciBJbmNvcnBvcmF0
ZWQgW0FMSV0gRGV2aWNlIDExNGUKCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNw
ZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZh
c3RCMkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFy
RXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBF
UlItIElOVHgtCglMYXRlbmN5OiAzMiwgQ2FjaGUgTGluZSBTaXplOiA2NCBieXRlcwoJSW50
ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDEzMgoJUmVnaW9uIDA6IE1lbW9yeSBhdCAy
ZmYzMDEwMDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTE2S10KCVJlZ2lv
biA0OiBNZW1vcnkgYXQgMmZmMzAwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBb
c2l6ZT02NEtdCglDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9u
IDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVudD01NW1BIFBNRShE
MC0sRDEtLEQyLSxEM2hvdCssRDNjb2xkKykKCQlTdGF0dXM6IEQzIE5vU29mdFJzdCsgUE1F
LUVuYWJsZSsgRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzYwXSBNU0k6
IEVuYWJsZSsgQ291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNzOiAwMDAwMDAw
MGZlZTAwM2I4ICBEYXRhOiAwMDAwCglLZXJuZWwgZHJpdmVyIGluIHVzZTogc25kX2hkYV9p
bnRlbAoJS2VybmVsIG1vZHVsZXM6IHNuZF9oZGFfaW50ZWwKCjAwOjFmLjQgU01CdXM6IElu
dGVsIENvcnBvcmF0aW9uIDEwMCBTZXJpZXMvQzIzMCBTZXJpZXMgQ2hpcHNldCBGYW1pbHkg
U01CdXMgKHJldiAzMSkKCVN1YnN5c3RlbTogQWNlciBJbmNvcnBvcmF0ZWQgW0FMSV0gRGV2
aWNlIDExNGUKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXItIFNwZWNDeWNsZS0gTWVt
V0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lO
VHgtCglTdGF0dXM6IENhcC0gNjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZTRUw9
bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0K
CUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAxNgoJUmVnaW9uIDA6IE1lbW9yeSBh
dCAyZmYzMDE0MDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTI1Nl0KCVJl
Z2lvbiA0OiBJL08gcG9ydHMgYXQgNTA0MCBbc2l6ZT0zMl0KCUtlcm5lbCBkcml2ZXIgaW4g
dXNlOiBpODAxX3NtYnVzCglLZXJuZWwgbW9kdWxlczogaTJjX2k4MDEKCjAxOjAwLjAgVkdB
IGNvbXBhdGlibGUgY29udHJvbGxlcjogTlZJRElBIENvcnBvcmF0aW9uIEdQMTA2TSBbR2VG
b3JjZSBHVFggMTA2MCBNb2JpbGVdIChyZXYgYTEpIChwcm9nLWlmIDAwIFtWR0EgY29udHJv
bGxlcl0pCglTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSAxMTRl
CglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZH
QVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3Rh
dHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRB
Ym9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTog
MCwgQ2FjaGUgTGluZSBTaXplOiA2NCBieXRlcwoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQg
dG8gSVJRIDEyOAoJUmVnaW9uIDA6IE1lbW9yeSBhdCA2MjAwMDAwMCAoMzItYml0LCBub24t
cHJlZmV0Y2hhYmxlKSBbc2l6ZT0xNk1dCglSZWdpb24gMTogTWVtb3J5IGF0IDUwMDAwMDAw
ICg2NC1iaXQsIHByZWZldGNoYWJsZSkgW3NpemU9MjU2TV0KCVJlZ2lvbiAzOiBNZW1vcnkg
YXQgNjAwMDAwMDAgKDY0LWJpdCwgcHJlZmV0Y2hhYmxlKSBbc2l6ZT0zMk1dCglSZWdpb24g
NTogSS9PIHBvcnRzIGF0IDQwMDAgW3NpemU9MTI4XQoJRXhwYW5zaW9uIFJPTSBhdCA2MzA4
MDAwMCBbZGlzYWJsZWRdIFtzaXplPTUxMktdCglDYXBhYmlsaXRpZXM6IFs2MF0gUG93ZXIg
TWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4
Q3VycmVudD0wbUEgUE1FKEQwLSxEMS0sRDItLEQzaG90LSxEM2NvbGQtKQoJCVN0YXR1czog
RDAgTm9Tb2Z0UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJp
bGl0aWVzOiBbNjhdIE1TSTogRW5hYmxlKyBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0KwoJ
CUFkZHJlc3M6IDAwMDAwMDAwZmVlMDAzMTggIERhdGE6IDAwMDAKCUNhcGFiaWxpdGllczog
Wzc4XSBFeHByZXNzICh2MikgRW5kcG9pbnQsIE1TSSAwMAoJCURldkNhcDoJTWF4UGF5bG9h
ZCAyNTYgYnl0ZXMsIFBoYW50RnVuYyAwLCBMYXRlbmN5IEwwcyB1bmxpbWl0ZWQsIEwxIDw2
NHVzCgkJCUV4dFRhZysgQXR0bkJ0bi0gQXR0bkluZC0gUHdySW5kLSBSQkUrIEZMUmVzZXQt
IFNsb3RQb3dlckxpbWl0IDc1VwoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZh
dGFsRXJyLSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFudEZ1bmMtIEF1eFB3
ci0gTm9Tbm9vcCsKCQkJTWF4UGF5bG9hZCAyNTYgYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5
dGVzCgkJRGV2U3RhOglDb3JyRXJyKyBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVx
KyBBdXhQd3ItIFRyYW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDhHVC9zLCBX
aWR0aCB4MTYsIEFTUE0gTDBzIEwxLCBFeGl0IExhdGVuY3kgTDBzIDw1MTJucywgTDEgPDR1
cwoJCQlDbG9ja1BNKyBTdXJwcmlzZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0Q29tcCsK
CQlMbmtDdGw6CUFTUE0gRGlzYWJsZWQ7IFJDQiA2NCBieXRlcywgRGlzYWJsZWQtIENvbW1D
bGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0K
CQlMbmtTdGE6CVNwZWVkIDIuNUdUL3MgKGRvd25ncmFkZWQpLCBXaWR0aCB4MTYKCQkJVHJF
cnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZS0gQldNZ210LSBBQldNZ210LQoJCURldkNh
cDI6IENvbXBsZXRpb24gVGltZW91dDogUmFuZ2UgQUIsIFRpbWVvdXREaXMrIE5ST1ByUHJQ
LSBMVFIrCgkJCSAxMEJpdFRhZ0NvbXAtIDEwQml0VGFnUmVxLSBPQkZGIFZpYSBtZXNzYWdl
LCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90
IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLSBUUEhD
b21wLSBFeHRUUEhDb21wLQoJCQkgQXRvbWljT3BzQ2FwOiAzMmJpdC0gNjRiaXQtIDEyOGJp
dENBUy0KCQlEZXZDdGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IDUwdXMgdG8gNTBtcywgVGlt
ZW91dERpcy0gTFRSKyAxMEJpdFRhZ1JlcS0gT0JGRiBEaXNhYmxlZCwKCQkJIEF0b21pY09w
c0N0bDogUmVxRW4tCgkJTG5rQ2FwMjogU3VwcG9ydGVkIExpbmsgU3BlZWRzOiAyLjUtOEdU
L3MsIENyb3NzbGluay0gUmV0aW1lci0gMlJldGltZXJzLSBEUlMtCgkJTG5rQ3RsMjogVGFy
Z2V0IExpbmsgU3BlZWQ6IDhHVC9zLCBFbnRlckNvbXBsaWFuY2UtIFNwZWVkRGlzLQoJCQkg
VHJhbnNtaXQgTWFyZ2luOiBOb3JtYWwgT3BlcmF0aW5nIFJhbmdlLCBFbnRlck1vZGlmaWVk
Q29tcGxpYW5jZS0gQ29tcGxpYW5jZVNPUy0KCQkJIENvbXBsaWFuY2UgUHJlc2V0L0RlLWVt
cGhhc2lzOiAtNmRCIGRlLWVtcGhhc2lzLCAwZEIgcHJlc2hvb3QKCQlMbmtTdGEyOiBDdXJy
ZW50IERlLWVtcGhhc2lzIExldmVsOiAtMy41ZEIsIEVxdWFsaXphdGlvbkNvbXBsZXRlKyBF
cXVhbGl6YXRpb25QaGFzZTErCgkJCSBFcXVhbGl6YXRpb25QaGFzZTIrIEVxdWFsaXphdGlv
blBoYXNlMysgTGlua0VxdWFsaXphdGlvblJlcXVlc3QtCgkJCSBSZXRpbWVyLSAyUmV0aW1l
cnMtIENyb3NzbGlua1JlczogdW5zdXBwb3J0ZWQKCUNhcGFiaWxpdGllczogWzEwMCB2MV0g
VmlydHVhbCBDaGFubmVsCgkJQ2FwczoJTFBFVkM9MCBSZWZDbGs9MTAwbnMgUEFURW50cnlC
aXRzPTEKCQlBcmI6CUZpeGVkLSBXUlIzMi0gV1JSNjQtIFdSUjEyOC0KCQlDdHJsOglBcmJT
ZWxlY3Q9Rml4ZWQKCQlTdGF0dXM6CUluUHJvZ3Jlc3MtCgkJVkMwOglDYXBzOglQQVRPZmZz
ZXQ9MDAgTWF4VGltZVNsb3RzPTEgUmVqU25vb3BUcmFucy0KCQkJQXJiOglGaXhlZC0gV1JS
MzItIFdSUjY0LSBXUlIxMjgtIFRXUlIxMjgtIFdSUjI1Ni0KCQkJQ3RybDoJRW5hYmxlKyBJ
RD0wIEFyYlNlbGVjdD1GaXhlZCBUQy9WQz1mZgoJCQlTdGF0dXM6CU5lZ29QZW5kaW5nLSBJ
blByb2dyZXNzLQoJQ2FwYWJpbGl0aWVzOiBbMjUwIHYxXSBMYXRlbmN5IFRvbGVyYW5jZSBS
ZXBvcnRpbmcKCQlNYXggc25vb3AgbGF0ZW5jeTogNzE2ODBucwoJCU1heCBubyBzbm9vcCBs
YXRlbmN5OiA3MTY4MG5zCglDYXBhYmlsaXRpZXM6IFsyNTggdjFdIEwxIFBNIFN1YnN0YXRl
cwoJCUwxU3ViQ2FwOiBQQ0ktUE1fTDEuMisgUENJLVBNX0wxLjErIEFTUE1fTDEuMisgQVNQ
TV9MMS4xKyBMMV9QTV9TdWJzdGF0ZXMrCgkJCSAgUG9ydENvbW1vbk1vZGVSZXN0b3JlVGlt
ZT0yNTV1cyBQb3J0VFBvd2VyT25UaW1lPTEwdXMKCQlMMVN1YkN0bDE6IFBDSS1QTV9MMS4y
LSBQQ0ktUE1fTDEuMS0gQVNQTV9MMS4yLSBBU1BNX0wxLjEtCgkJCSAgIFRfQ29tbW9uTW9k
ZT0wdXMgTFRSMS4yX1RocmVzaG9sZD0wbnMKCQlMMVN1YkN0bDI6IFRfUHdyT249MTB1cwoJ
Q2FwYWJpbGl0aWVzOiBbMTI4IHYxXSBQb3dlciBCdWRnZXRpbmcgPD8+CglDYXBhYmlsaXRp
ZXM6IFs0MjAgdjJdIEFkdmFuY2VkIEVycm9yIFJlcG9ydGluZwoJCVVFU3RhOglETFAtIFNE
RVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9GLSBNYWxm
VExQLSBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlVRU1zazoJRExQLSBTREVTLSBUTFAt
IEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRi0gTWFsZlRMUC0gRUNS
Qy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJVUVTdnJ0OglETFArIFNERVMrIFRMUC0gRkNQKyBD
bXBsdFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9GKyBNYWxmVExQKyBFQ1JDLSBVbnN1
cFJlcS0gQUNTVmlvbC0KCQlDRVN0YToJUnhFcnItIEJhZFRMUC0gQmFkRExMUC0gUm9sbG92
ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyKwoJCUNFTXNrOglSeEVyci0gQmFkVExQLSBC
YWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gQWR2Tm9uRmF0YWxFcnIrCgkJQUVSQ2FwOglG
aXJzdCBFcnJvciBQb2ludGVyOiAwMCwgRUNSQ0dlbkNhcC0gRUNSQ0dlbkVuLSBFQ1JDQ2hr
Q2FwLSBFQ1JDQ2hrRW4tCgkJCU11bHRIZHJSZWNDYXAtIE11bHRIZHJSZWNFbi0gVExQUGZ4
UHJlcy0gSGRyTG9nQ2FwLQoJCUhlYWRlckxvZzogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDAKCUNhcGFiaWxpdGllczogWzYwMCB2MV0gVmVuZG9yIFNwZWNpZmljIElu
Zm9ybWF0aW9uOiBJRD0wMDAxIFJldj0xIExlbj0wMjQgPD8+CglDYXBhYmlsaXRpZXM6IFs5
MDAgdjFdIFNlY29uZGFyeSBQQ0kgRXhwcmVzcwoJCUxua0N0bDM6IExua0VxdUludHJydXB0
RW4tIFBlcmZvcm1FcXUtCgkJTGFuZUVyclN0YXQ6IDAKCUtlcm5lbCBkcml2ZXIgaW4gdXNl
OiBub3V2ZWF1CglLZXJuZWwgbW9kdWxlczogbm91dmVhdQoKMDE6MDAuMSBBdWRpbyBkZXZp
Y2U6IE5WSURJQSBDb3Jwb3JhdGlvbiBHUDEwNiBIaWdoIERlZmluaXRpb24gQXVkaW8gQ29u
dHJvbGxlciAocmV2IGExKQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBE
ZXZpY2UgMTE0ZQoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBN
ZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlz
SU5UeC0KCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNF
TD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0K
CUxhdGVuY3k6IDAsIENhY2hlIExpbmUgU2l6ZTogNjQgYnl0ZXMKCUludGVycnVwdDogcGlu
IEIgcm91dGVkIHRvIElSUSAxNwoJUmVnaW9uIDA6IE1lbW9yeSBhdCA2MzAwMDAwMCAoMzIt
Yml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xNktdCglDYXBhYmlsaXRpZXM6IFs2MF0g
UG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBE
Mi0gQXV4Q3VycmVudD0wbUEgUE1FKEQwLSxEMS0sRDItLEQzaG90LSxEM2NvbGQtKQoJCVN0
YXR1czogRDAgTm9Tb2Z0UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJ
Q2FwYWJpbGl0aWVzOiBbNjhdIE1TSTogRW5hYmxlLSBDb3VudD0xLzEgTWFza2FibGUtIDY0
Yml0KwoJCUFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwMDAgIERhdGE6IDAwMDAKCUNhcGFiaWxp
dGllczogWzc4XSBFeHByZXNzICh2MikgRW5kcG9pbnQsIE1TSSAwMAoJCURldkNhcDoJTWF4
UGF5bG9hZCAyNTYgYnl0ZXMsIFBoYW50RnVuYyAwLCBMYXRlbmN5IEwwcyB1bmxpbWl0ZWQs
IEwxIDw2NHVzCgkJCUV4dFRhZysgQXR0bkJ0bi0gQXR0bkluZC0gUHdySW5kLSBSQkUrIEZM
UmVzZXQtIFNsb3RQb3dlckxpbWl0IDc1VwoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxF
cnItIEZhdGFsRXJyLSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFudEZ1bmMt
IEF1eFB3ci0gTm9Tbm9vcCsKCQkJTWF4UGF5bG9hZCAyNTYgYnl0ZXMsIE1heFJlYWRSZXEg
NTEyIGJ5dGVzCgkJRGV2U3RhOglDb3JyRXJyKyBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVu
c3VwUmVxKyBBdXhQd3ItIFRyYW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDhH
VC9zLCBXaWR0aCB4MTYsIEFTUE0gTDBzIEwxLCBFeGl0IExhdGVuY3kgTDBzIDw1MTJucywg
TDEgPDR1cwoJCQlDbG9ja1BNKyBTdXJwcmlzZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0
Q29tcCsKCQlMbmtDdGw6CUFTUE0gRGlzYWJsZWQ7IFJDQiA2NCBieXRlcywgRGlzYWJsZWQt
IENvbW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRC
V0ludC0KCQlMbmtTdGE6CVNwZWVkIDIuNUdUL3MgKGRvd25ncmFkZWQpLCBXaWR0aCB4MTYK
CQkJVHJFcnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZS0gQldNZ210LSBBQldNZ210LQoJ
CURldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogUmFuZ2UgQUIsIFRpbWVvdXREaXMrIE5S
T1ByUHJQLSBMVFIrCgkJCSAxMEJpdFRhZ0NvbXAtIDEwQml0VGFnUmVxLSBPQkZGIFZpYSBt
ZXNzYWdlLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rp
b24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJT
LSBUUEhDb21wLSBFeHRUUEhDb21wLQoJCQkgQXRvbWljT3BzQ2FwOiAzMmJpdC0gNjRiaXQt
IDEyOGJpdENBUy0KCQlEZXZDdGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IDUwdXMgdG8gNTBt
cywgVGltZW91dERpcy0gTFRSLSAxMEJpdFRhZ1JlcS0gT0JGRiBEaXNhYmxlZCwKCQkJIEF0
b21pY09wc0N0bDogUmVxRW4tCgkJTG5rU3RhMjogQ3VycmVudCBEZS1lbXBoYXNpcyBMZXZl
bDogLTMuNWRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZS0gRXF1YWxpemF0aW9uUGhhc2UxLQoJ
CQkgRXF1YWxpemF0aW9uUGhhc2UyLSBFcXVhbGl6YXRpb25QaGFzZTMtIExpbmtFcXVhbGl6
YXRpb25SZXF1ZXN0LQoJCQkgUmV0aW1lci0gMlJldGltZXJzLSBDcm9zc2xpbmtSZXM6IHVu
c3VwcG9ydGVkCglDYXBhYmlsaXRpZXM6IFsxMDAgdjJdIEFkdmFuY2VkIEVycm9yIFJlcG9y
dGluZwoJCVVFU3RhOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBDbXBsdEFicnQt
IFVueENtcGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlV
RU1zazoJRExQLSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBs
dC0gUnhPRi0gTWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJVUVTdnJ0OglE
TFArIFNERVMrIFRMUC0gRkNQKyBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9G
KyBNYWxmVExQKyBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlDRVN0YToJUnhFcnItIEJh
ZFRMUC0gQmFkRExMUC0gUm9sbG92ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyKwoJCUNF
TXNrOglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gQWR2Tm9u
RmF0YWxFcnIrCgkJQUVSQ2FwOglGaXJzdCBFcnJvciBQb2ludGVyOiAwMCwgRUNSQ0dlbkNh
cC0gRUNSQ0dlbkVuLSBFQ1JDQ2hrQ2FwLSBFQ1JDQ2hrRW4tCgkJCU11bHRIZHJSZWNDYXAt
IE11bHRIZHJSZWNFbi0gVExQUGZ4UHJlcy0gSGRyTG9nQ2FwLQoJCUhlYWRlckxvZzogMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAKCUtlcm5lbCBkcml2ZXIgaW4gdXNl
OiBzbmRfaGRhX2ludGVsCglLZXJuZWwgbW9kdWxlczogc25kX2hkYV9pbnRlbAoKMDI6MDAu
MCBOZXR3b3JrIGNvbnRyb2xsZXI6IFF1YWxjb21tIEF0aGVyb3MgUUNBNjE3NCA4MDIuMTFh
YyBXaXJlbGVzcyBOZXR3b3JrIEFkYXB0ZXIgKHJldiAzMikKCVN1YnN5c3RlbTogRm94Y29u
biBJbnRlcm5hdGlvbmFsLCBJbmMuIERldmljZSBlMDlkCglDb250cm9sOiBJL08tIE1lbSsg
QnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBw
aW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYt
IEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9y
dC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiA2
NCBieXRlcwoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDEzMwoJUmVnaW9uIDA6
IE1lbW9yeSBhdCA2MzIwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0y
TV0KCUNhcGFiaWxpdGllczogWzQwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZs
YWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTM3NW1BIFBNRShEMCssRDEt
LEQyLSxEM2hvdCssRDNjb2xkKykKCQlTdGF0dXM6IEQwIE5vU29mdFJzdC0gUE1FLUVuYWJs
ZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzUwXSBNU0k6IEVuYWJs
ZSsgQ291bnQ9MS84IE1hc2thYmxlKyA2NGJpdC0KCQlBZGRyZXNzOiBmZWUwMDNkOCAgRGF0
YTogMDAwMAoJCU1hc2tpbmc6IDAwMDAwMGZlICBQZW5kaW5nOiAwMDAwMDAwMAoJQ2FwYWJp
bGl0aWVzOiBbNzBdIEV4cHJlc3MgKHYyKSBFbmRwb2ludCwgTVNJIDAwCgkJRGV2Q2FwOglN
YXhQYXlsb2FkIDI1NiBieXRlcywgUGhhbnRGdW5jIDAsIExhdGVuY3kgTDBzIHVubGltaXRl
ZCwgTDEgPDY0dXMKCQkJRXh0VGFnLSBBdHRuQnRuLSBBdHRuSW5kLSBQd3JJbmQtIFJCRSsg
RkxSZXNldC0gU2xvdFBvd2VyTGltaXQgMTBXCgkJRGV2Q3RsOglDb3JyRXJyLSBOb25GYXRh
bEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLQoJCQlSbHhkT3JkKyBFeHRUYWctIFBoYW50RnVu
Yy0gQXV4UHdyLSBOb1Nub29wLQoJCQlNYXhQYXlsb2FkIDI1NiBieXRlcywgTWF4UmVhZFJl
cSA1MTIgYnl0ZXMKCQlEZXZTdGE6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0g
VW5zdXBSZXEtIEF1eFB3cisgVHJhbnNQZW5kLQoJCUxua0NhcDoJUG9ydCAjMCwgU3BlZWQg
Mi41R1QvcywgV2lkdGggeDEsIEFTUE0gTDBzIEwxLCBFeGl0IExhdGVuY3kgTDBzIDw0dXMs
IEwxIDw2NHVzCgkJCUNsb2NrUE0rIFN1cnByaXNlLSBMTEFjdFJlcC0gQndOb3QtIEFTUE1P
cHRDb21wKwoJCUxua0N0bDoJQVNQTSBMMSBFbmFibGVkOyBSQ0IgNjQgYnl0ZXMsIERpc2Fi
bGVkLSBDb21tQ2xrKwoJCQlFeHRTeW5jaC0gQ2xvY2tQTSsgQXV0V2lkRGlzLSBCV0ludC0g
QXV0QldJbnQtCgkJTG5rU3RhOglTcGVlZCAyLjVHVC9zLCBXaWR0aCB4MQoJCQlUckVyci0g
VHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQtIEFCV01nbXQtCgkJRGV2Q2FwMjog
Q29tcGxldGlvbiBUaW1lb3V0OiBOb3QgU3VwcG9ydGVkLCBUaW1lb3V0RGlzKyBOUk9QclBy
UC0gTFRSKwoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBWaWEgbWVzc2Fn
ZSwgRXh0Rm10LSBFRVRMUFByZWZpeC0KCQkJIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uIE5v
dCBTdXBwb3J0ZWQsIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uSW5pdC0KCQkJIEZSUy0gVFBI
Q29tcC0gRXh0VFBIQ29tcC0KCQkJIEF0b21pY09wc0NhcDogMzJiaXQtIDY0Yml0LSAxMjhi
aXRDQVMtCgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRp
bWVvdXREaXMtIExUUisgMTBCaXRUYWdSZXEtIE9CRkYgRGlzYWJsZWQsCgkJCSBBdG9taWNP
cHNDdGw6IFJlcUVuLQoJCUxua0NhcDI6IFN1cHBvcnRlZCBMaW5rIFNwZWVkczogMi41R1Qv
cywgQ3Jvc3NsaW5rLSBSZXRpbWVyLSAyUmV0aW1lcnMtIERSUy0KCQlMbmtDdGwyOiBUYXJn
ZXQgTGluayBTcGVlZDogMi41R1QvcywgRW50ZXJDb21wbGlhbmNlLSBTcGVlZERpcy0KCQkJ
IFRyYW5zbWl0IE1hcmdpbjogTm9ybWFsIE9wZXJhdGluZyBSYW5nZSwgRW50ZXJNb2RpZmll
ZENvbXBsaWFuY2UtIENvbXBsaWFuY2VTT1MtCgkJCSBDb21wbGlhbmNlIFByZXNldC9EZS1l
bXBoYXNpczogLTZkQiBkZS1lbXBoYXNpcywgMGRCIHByZXNob290CgkJTG5rU3RhMjogQ3Vy
cmVudCBEZS1lbXBoYXNpcyBMZXZlbDogLTZkQiwgRXF1YWxpemF0aW9uQ29tcGxldGUtIEVx
dWFsaXphdGlvblBoYXNlMS0KCQkJIEVxdWFsaXphdGlvblBoYXNlMi0gRXF1YWxpemF0aW9u
UGhhc2UzLSBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0KCQkJIFJldGltZXItIDJSZXRpbWVy
cy0gQ3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJQ2FwYWJpbGl0aWVzOiBbMTAwIHYyXSBB
ZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcKCQlVRVN0YToJRExQLSBTREVTLSBUTFAtIEZDUC0g
Q21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRi0gTWFsZlRMUC0gRUNSQy0gVW5z
dXBSZXEtIEFDU1Zpb2wtCgkJVUVNc2s6CURMUC0gU0RFUy0gVExQLSBGQ1AtIENtcGx0VE8t
IENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAtIEVDUkMtIFVuc3VwUmVxLSBB
Q1NWaW9sLQoJCVVFU3ZydDoJRExQKyBTREVTKyBUTFAtIEZDUCsgQ21wbHRUTy0gQ21wbHRB
YnJ0LSBVbnhDbXBsdC0gUnhPRisgTWFsZlRMUCsgRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wt
CgkJQ0VTdGE6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAtIFJvbGxvdmVyLSBUaW1lb3V0LSBB
ZHZOb25GYXRhbEVyci0KCQlDRU1zazoJUnhFcnItIEJhZFRMUC0gQmFkRExMUC0gUm9sbG92
ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyKwoJCUFFUkNhcDoJRmlyc3QgRXJyb3IgUG9p
bnRlcjogMDAsIEVDUkNHZW5DYXAtIEVDUkNHZW5Fbi0gRUNSQ0Noa0NhcC0gRUNSQ0Noa0Vu
LQoJCQlNdWx0SGRyUmVjQ2FwLSBNdWx0SGRyUmVjRW4tIFRMUFBmeFByZXMtIEhkckxvZ0Nh
cC0KCQlIZWFkZXJMb2c6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwCglD
YXBhYmlsaXRpZXM6IFsxNDggdjFdIFZpcnR1YWwgQ2hhbm5lbAoJCUNhcHM6CUxQRVZDPTAg
UmVmQ2xrPTEwMG5zIFBBVEVudHJ5Qml0cz0xCgkJQXJiOglGaXhlZC0gV1JSMzItIFdSUjY0
LSBXUlIxMjgtCgkJQ3RybDoJQXJiU2VsZWN0PUZpeGVkCgkJU3RhdHVzOglJblByb2dyZXNz
LQoJCVZDMDoJQ2FwczoJUEFUT2Zmc2V0PTAwIE1heFRpbWVTbG90cz0xIFJlalNub29wVHJh
bnMtCgkJCUFyYjoJRml4ZWQtIFdSUjMyLSBXUlI2NC0gV1JSMTI4LSBUV1JSMTI4LSBXUlIy
NTYtCgkJCUN0cmw6CUVuYWJsZSsgSUQ9MCBBcmJTZWxlY3Q9Rml4ZWQgVEMvVkM9ZmYKCQkJ
U3RhdHVzOglOZWdvUGVuZGluZy0gSW5Qcm9ncmVzcy0KCUNhcGFiaWxpdGllczogWzE2OCB2
MV0gRGV2aWNlIFNlcmlhbCBOdW1iZXIgMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAKCUNhcGFi
aWxpdGllczogWzE3OCB2MV0gTGF0ZW5jeSBUb2xlcmFuY2UgUmVwb3J0aW5nCgkJTWF4IHNu
b29wIGxhdGVuY3k6IDMxNDU3MjhucwoJCU1heCBubyBzbm9vcCBsYXRlbmN5OiAzMTQ1NzI4
bnMKCUNhcGFiaWxpdGllczogWzE4MCB2MV0gTDEgUE0gU3Vic3RhdGVzCgkJTDFTdWJDYXA6
IFBDSS1QTV9MMS4yKyBQQ0ktUE1fTDEuMSsgQVNQTV9MMS4yKyBBU1BNX0wxLjErIEwxX1BN
X1N1YnN0YXRlcysKCQkJICBQb3J0Q29tbW9uTW9kZVJlc3RvcmVUaW1lPTUwdXMgUG9ydFRQ
b3dlck9uVGltZT0xMHVzCgkJTDFTdWJDdGwxOiBQQ0ktUE1fTDEuMi0gUENJLVBNX0wxLjEt
IEFTUE1fTDEuMi0gQVNQTV9MMS4xLQoJCQkgICBUX0NvbW1vbk1vZGU9MHVzIExUUjEuMl9U
aHJlc2hvbGQ9MG5zCgkJTDFTdWJDdGwyOiBUX1B3ck9uPTQ0dXMKCUtlcm5lbCBkcml2ZXIg
aW4gdXNlOiBhdGgxMGtfcGNpCglLZXJuZWwgbW9kdWxlczogYXRoMTBrX3BjaQoKMDM6MDAu
MCBFdGhlcm5ldCBjb250cm9sbGVyOiBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ28uLCBMdGQu
IFJUTDgxMTEvODE2OC84NDExIFBDSSBFeHByZXNzIEdpZ2FiaXQgRXRoZXJuZXQgQ29udHJv
bGxlciAocmV2IDE1KQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZp
Y2UgMTE0ZQoJQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1X
SU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5U
eCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1m
YXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxh
dGVuY3k6IDAsIENhY2hlIExpbmUgU2l6ZTogNjQgYnl0ZXMKCUludGVycnVwdDogcGluIEEg
cm91dGVkIHRvIElSUSAxOQoJUmVnaW9uIDA6IEkvTyBwb3J0cyBhdCAzMDAwIFtzaXplPTI1
Nl0KCVJlZ2lvbiAyOiBNZW1vcnkgYXQgNjM0MDQwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNo
YWJsZSkgW3NpemU9NEtdCglSZWdpb24gNDogTWVtb3J5IGF0IDYzNDAwMDAwICg2NC1iaXQs
IG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTE2S10KCUNhcGFiaWxpdGllczogWzQwXSBQb3dl
ciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDErIEQyKyBB
dXhDdXJyZW50PTM3NW1BIFBNRShEMCssRDErLEQyKyxEM2hvdCssRDNjb2xkKykKCQlTdGF0
dXM6IEQwIE5vU29mdFJzdCsgUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNh
cGFiaWxpdGllczogWzUwXSBNU0k6IEVuYWJsZS0gQ291bnQ9MS8xIE1hc2thYmxlLSA2NGJp
dCsKCQlBZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDAwICBEYXRhOiAwMDAwCglDYXBhYmlsaXRp
ZXM6IFs3MF0gRXhwcmVzcyAodjIpIEVuZHBvaW50LCBNU0kgMDEKCQlEZXZDYXA6CU1heFBh
eWxvYWQgMTI4IGJ5dGVzLCBQaGFudEZ1bmMgMCwgTGF0ZW5jeSBMMHMgPDUxMm5zLCBMMSA8
NjR1cwoJCQlFeHRUYWctIEF0dG5CdG4tIEF0dG5JbmQtIFB3ckluZC0gUkJFKyBGTFJlc2V0
LSBTbG90UG93ZXJMaW1pdCAxMFcKCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBG
YXRhbEVyci0gVW5zdXBSZXEtCgkJCVJseGRPcmQrIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQ
d3ItIE5vU25vb3AtCgkJCU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDQwOTYg
Ynl0ZXMKCQlEZXZTdGE6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBS
ZXEtIEF1eFB3cisgVHJhbnNQZW5kLQoJCUxua0NhcDoJUG9ydCAjMCwgU3BlZWQgMi41R1Qv
cywgV2lkdGggeDEsIEFTUE0gTDBzIEwxLCBFeGl0IExhdGVuY3kgTDBzIHVubGltaXRlZCwg
TDEgPDY0dXMKCQkJQ2xvY2tQTSsgU3VycHJpc2UtIExMQWN0UmVwLSBCd05vdC0gQVNQTU9w
dENvbXArCgkJTG5rQ3RsOglBU1BNIEwxIEVuYWJsZWQ7IFJDQiA2NCBieXRlcywgRGlzYWJs
ZWQtIENvbW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNKyBBdXRXaWREaXMtIEJXSW50LSBB
dXRCV0ludC0KCQlMbmtTdGE6CVNwZWVkIDIuNUdUL3MsIFdpZHRoIHgxCgkJCVRyRXJyLSBU
cmFpbi0gU2xvdENsaysgRExBY3RpdmUtIEJXTWdtdC0gQUJXTWdtdC0KCQlEZXZDYXAyOiBD
b21wbGV0aW9uIFRpbWVvdXQ6IFJhbmdlIEFCQ0QsIFRpbWVvdXREaXMrIE5ST1ByUHJQLSBM
VFIrCgkJCSAxMEJpdFRhZ0NvbXAtIDEwQml0VGFnUmVxLSBPQkZGIFZpYSBtZXNzYWdlL1dB
S0UjLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24g
Tm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLSBU
UEhDb21wLSBFeHRUUEhDb21wLQoJCQkgQXRvbWljT3BzQ2FwOiAzMmJpdC0gNjRiaXQtIDEy
OGJpdENBUy0KCQlEZXZDdGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IDUwdXMgdG8gNTBtcywg
VGltZW91dERpcy0gTFRSKyAxMEJpdFRhZ1JlcS0gT0JGRiBEaXNhYmxlZCwKCQkJIEF0b21p
Y09wc0N0bDogUmVxRW4tCgkJTG5rQ2FwMjogU3VwcG9ydGVkIExpbmsgU3BlZWRzOiAyLjVH
VC9zLCBDcm9zc2xpbmstIFJldGltZXItIDJSZXRpbWVycy0gRFJTLQoJCUxua0N0bDI6IFRh
cmdldCBMaW5rIFNwZWVkOiAyLjVHVC9zLCBFbnRlckNvbXBsaWFuY2UtIFNwZWVkRGlzLQoJ
CQkgVHJhbnNtaXQgTWFyZ2luOiBOb3JtYWwgT3BlcmF0aW5nIFJhbmdlLCBFbnRlck1vZGlm
aWVkQ29tcGxpYW5jZS0gQ29tcGxpYW5jZVNPUy0KCQkJIENvbXBsaWFuY2UgUHJlc2V0L0Rl
LWVtcGhhc2lzOiAtNmRCIGRlLWVtcGhhc2lzLCAwZEIgcHJlc2hvb3QKCQlMbmtTdGEyOiBD
dXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtNmRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZS0g
RXF1YWxpemF0aW9uUGhhc2UxLQoJCQkgRXF1YWxpemF0aW9uUGhhc2UyLSBFcXVhbGl6YXRp
b25QaGFzZTMtIExpbmtFcXVhbGl6YXRpb25SZXF1ZXN0LQoJCQkgUmV0aW1lci0gMlJldGlt
ZXJzLSBDcm9zc2xpbmtSZXM6IHVuc3VwcG9ydGVkCglDYXBhYmlsaXRpZXM6IFtiMF0gTVNJ
LVg6IEVuYWJsZSsgQ291bnQ9NCBNYXNrZWQtCgkJVmVjdG9yIHRhYmxlOiBCQVI9NCBvZmZz
ZXQ9MDAwMDAwMDAKCQlQQkE6IEJBUj00IG9mZnNldD0wMDAwMDgwMAoJQ2FwYWJpbGl0aWVz
OiBbMTAwIHYyXSBBZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcKCQlVRVN0YToJRExQLSBTREVT
LSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRi0gTWFsZlRM
UC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJVUVNc2s6CURMUC0gU0RFUy0gVExQLSBG
Q1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAtIEVDUkMt
IFVuc3VwUmVxLSBBQ1NWaW9sLQoJCVVFU3ZydDoJRExQKyBTREVTKyBUTFAtIEZDUCsgQ21w
bHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRisgTWFsZlRMUCsgRUNSQy0gVW5zdXBS
ZXEtIEFDU1Zpb2wtCgkJQ0VTdGE6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAtIFJvbGxvdmVy
LSBUaW1lb3V0LSBBZHZOb25GYXRhbEVyci0KCQlDRU1zazoJUnhFcnItIEJhZFRMUC0gQmFk
RExMUC0gUm9sbG92ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyKwoJCUFFUkNhcDoJRmly
c3QgRXJyb3IgUG9pbnRlcjogMDAsIEVDUkNHZW5DYXArIEVDUkNHZW5Fbi0gRUNSQ0Noa0Nh
cCsgRUNSQ0Noa0VuLQoJCQlNdWx0SGRyUmVjQ2FwLSBNdWx0SGRyUmVjRW4tIFRMUFBmeFBy
ZXMtIEhkckxvZ0NhcC0KCQlIZWFkZXJMb2c6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwMDAwCglDYXBhYmlsaXRpZXM6IFsxNDAgdjFdIFZpcnR1YWwgQ2hhbm5lbAoJCUNh
cHM6CUxQRVZDPTAgUmVmQ2xrPTEwMG5zIFBBVEVudHJ5Qml0cz0xCgkJQXJiOglGaXhlZC0g
V1JSMzItIFdSUjY0LSBXUlIxMjgtCgkJQ3RybDoJQXJiU2VsZWN0PUZpeGVkCgkJU3RhdHVz
OglJblByb2dyZXNzLQoJCVZDMDoJQ2FwczoJUEFUT2Zmc2V0PTAwIE1heFRpbWVTbG90cz0x
IFJlalNub29wVHJhbnMtCgkJCUFyYjoJRml4ZWQtIFdSUjMyLSBXUlI2NC0gV1JSMTI4LSBU
V1JSMTI4LSBXUlIyNTYtCgkJCUN0cmw6CUVuYWJsZSsgSUQ9MCBBcmJTZWxlY3Q9Rml4ZWQg
VEMvVkM9ZmYKCQkJU3RhdHVzOglOZWdvUGVuZGluZy0gSW5Qcm9ncmVzcy0KCUNhcGFiaWxp
dGllczogWzE2MCB2MV0gRGV2aWNlIFNlcmlhbCBOdW1iZXIgMDEtMDAtMDAtMDAtNjgtNGMt
ZTAtMDAKCUNhcGFiaWxpdGllczogWzE3MCB2MV0gTGF0ZW5jeSBUb2xlcmFuY2UgUmVwb3J0
aW5nCgkJTWF4IHNub29wIGxhdGVuY3k6IDMxNDU3MjhucwoJCU1heCBubyBzbm9vcCBsYXRl
bmN5OiAzMTQ1NzI4bnMKCUNhcGFiaWxpdGllczogWzE3OCB2MV0gTDEgUE0gU3Vic3RhdGVz
CgkJTDFTdWJDYXA6IFBDSS1QTV9MMS4yKyBQQ0ktUE1fTDEuMSsgQVNQTV9MMS4yKyBBU1BN
X0wxLjErIEwxX1BNX1N1YnN0YXRlcysKCQkJICBQb3J0Q29tbW9uTW9kZVJlc3RvcmVUaW1l
PTE1MHVzIFBvcnRUUG93ZXJPblRpbWU9MTUwdXMKCQlMMVN1YkN0bDE6IFBDSS1QTV9MMS4y
LSBQQ0ktUE1fTDEuMS0gQVNQTV9MMS4yLSBBU1BNX0wxLjEtCgkJCSAgIFRfQ29tbW9uTW9k
ZT0wdXMgTFRSMS4yX1RocmVzaG9sZD0wbnMKCQlMMVN1YkN0bDI6IFRfUHdyT249MTUwdXMK
CUtlcm5lbCBkcml2ZXIgaW4gdXNlOiByODE2OQoJS2VybmVsIG1vZHVsZXM6IHI4MTY5Cgo=


--------------lS5SUTwfL0SlAT94caQJNMwq--

