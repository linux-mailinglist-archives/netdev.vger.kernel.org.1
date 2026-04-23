Return-Path: <netdev+bounces-280705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA9rMnn36WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:42:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6142D450D4E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F34A301751B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818993DEFF7;
	Thu, 23 Apr 2026 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="kcaT4jBm"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648CC3DEAFC;
	Thu, 23 Apr 2026 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776940908; cv=none; b=TyQob6q0pdNbMZl/Uog2nEhRrA1skV5S91ggEECHxSHi7gLc2TV9n7OiEfDgK8JOVTc/LSrnt1t1iiOJom1a8Nz5yz16mr0esKsb2WCvvzaVMskFWAhtRzJMan4dV44tjaYmJGQIJm5tZ4UJHKwrGGN6ITjftSs01+csddPH3xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776940908; c=relaxed/simple;
	bh=J35DKQmrsyBFmjMn0B0gxEu5sVpSIBU+C27i3+p3yqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJEY8OXKmLXle5wjnwC19Zae06EzBVmib5X0zQlcX8iqwAAOKIb4LDqB5fRJr3+YY/ip410cCf18iOXDqZL3rF6gcXcpKShVbylADDT2OXxWcuEnyti//zxIe1uhTbbgFOnTCtIT0Jqh2k+aq0Lw0DoUVzwEEQmGPx1/c+FbxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=kcaT4jBm; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49DC8285D81;
	Thu, 23 Apr 2026 12:41:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1776940903; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Woabk+WpQCTtZd2aZmzwJRaJxF21D3fu5BZ7DelnC/U=;
	b=kcaT4jBmyrv132Aui5zcaI+JQ8n92e2qr0jR9EE/AaxsmgMYjYed1P2gzjtZgoq54ihU5Z
	B+3THt8efHO+ZTCwzcRUf5ojCXIUvxJ4Ht0t39KjT9E2+p7fY6vjMT+9bo/SXpg7NHxBvk
	wjnPJRMbCGJF7m+w3OYiCKaUz3keq9P5fTHKb/2NVdU6XqKQ5l6KaXXu9VVGR6KRfiD32K
	zSj2dIgtweASxVGLlkr8hs863coj9xvEsTrDgr0r8BGIGjc3+CyGRdMJURpcY34BrEN0TH
	4dBujDtoGS5t6DbVLi/YQnqjoWVnnQr5wwWdJ418CIr9YyMFi9ex1Luw0aayfg==
From: Eric Naim <dnaim@cachyos.org>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Eric Naim <dnaim@cachyos.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] ntfs: Avoid NULL pointer dereference in ntfs_iomap_submit_read()
Date: Thu, 23 Apr 2026 18:41:18 +0800
Message-ID: <20260423104119.414765-1-dnaim@cachyos.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cachyos.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[cachyos.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280705-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cachyos.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dnaim@cachyos.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6142D450D4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ctx->read_ctx can be NULL when ntfs_iomap_submit_read is called, leading
to below trace:

[   44.977614] BUG: kernel NULL pointer dereference, address: 0000000000000=
040
[   44.977617] #PF: supervisor write access in kernel mode
[   44.977618] #PF: error_code(0x0002) - not-present page
[   44.977619] PGD 0 P4D 0
[   44.977621] Oops: Oops: 0002 [#1] SMP
[   44.977623] CPU: 0 UID: 1000 PID: 5010 Comm: pool-4 Kdump: loaded Tainte=
d: G     U     OE       7.0.1-1-cachyos-bmq-hakuu-tlto-gdc7bc3c05102 #7 PRE=
EMPT(full)  c202625180654aea7fdad2184acc19b9c28ed6ee
[   44.977626] Tainted: [U]=3DUSER, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[   44.977626] Hardware name: ASUSTeK COMPUTER INC. ASUS TUF Gaming F16 FX6=
07JV_FX607JV/FX607JV, BIOS FX607JV.316 10/13/2025
[   44.977627] RIP: 0010:ntfs_swap_activate.llvm.1224280209124021557+0x2d/0=
x3c0 [ntfs]
[   44.977631] Code: fa 0f 1f 44 00 00 48 c7 c1 78 76 93 a2 e9 2b 2d cc de =
cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 48 8b 7f 18 <48=
> c7 47 40 60 04 aa a2 e9 56 c9 fd de cc cc cc cc cc cc f3 0f 1e
[   44.977632] RSP: 0018:ffffc90023c27648 EFLAGS: 00010282
[   44.977633] RAX: ffffffffa2aa0440 RBX: ffffc90023c27758 RCX: 00000000000=
01000
[   44.977634] RDX: 0000000000001000 RSI: 0000000006f20000 RDI: 00000000000=
00000
[   44.977635] RBP: 0000000006f20000 R08: 0000000000000000 R09: ffffc90023c=
27680
[   44.977636] R10: 0000000000000009 R11: 0000000006f203ff R12: ffffc90023c=
27650
[   44.977637] R13: ffffea000810e0c0 R14: ffffffffa2937678 R15: ffffc90023c=
27658
[   44.977638] FS:  00007fffa7fff6c0(0000) GS:ffff888d29052000(0000) knlGS:=
0000000000000000
[   44.977639] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.977640] CR2: 0000000000000040 CR3: 0000000160320004 CR4: 0000000000f=
72ef0
[   44.977641] PKRU: 55555554
[   44.977641] Call Trace:
[   44.977642]  <TASK>
[   44.977643]  iomap_read_folio+0xe2/0x180
[   44.977647]  ntfs_read_folio.llvm.1224280209124021557+0x69/0xe0 [ntfs df=
169bf55ac22e619ebd511d6378b3aa21a54f15]
[   44.977650]  do_read_cache_folio.llvm.11351189850855672942+0x1a9/0x310
[   44.977652]  ? cleanup_module+0x1f0/0x1f0 [fat f3f47899f717abaf282870f38=
0e376f623b66fa1]
[   44.977654]  ntfs_mft_record_alloc+0x8df/0x2bd0 [ntfs df169bf55ac22e619e=
bd511d6378b3aa21a54f15]
[   44.977657]  ntfs_get_parent.llvm.15803940035981701475+0x569/0x1780 [ntf=
s df169bf55ac22e619ebd511d6378b3aa21a54f15]
[   44.977659]  ? kmem_cache_alloc_noprof+0x187/0x420
[   44.977660]  ntfs_create.llvm.15803940035981701475+0x106/0x170 [ntfs df1=
69bf55ac22e619ebd511d6378b3aa21a54f15]
[   44.977662]  path_openat+0x541/0xdb0
[   44.977664]  do_file_open+0xd7/0x190
[   44.977666]  do_sys_openat2+0x76/0xe0
[   44.977668]  __x64_sys_openat+0x80/0xa0
[   44.977669]  do_syscall_64+0xf8/0x350
[   44.977671]  ? do_statx_fd+0x100/0x140
[   44.977672]  ? ext4_listxattr+0x1d9/0x200
[   44.977674]  ? listxattr+0xfe/0x150
[   44.977675]  ? __x64_sys_flistxattr+0x7a/0xa0
[   44.977677]  ? do_syscall_64+0x133/0x350
[   44.977678]  ? __x64_sys_flistxattr+0x7a/0xa0
[   44.977679]  ? do_syscall_64+0x133/0x350
[   44.977681]  ? rcu_report_qs_rdp+0xca/0x180
[   44.977683]  ? sched_clock+0x10/0x20
[   44.977684]  ? sched_clock_cpu+0x10/0x190
[   44.977685]  ? irqtime_account_irq+0x28/0xa0
[   44.977687]  ? do_syscall_64+0x133/0x350
[   44.977688]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   44.977689] RIP: 0033:0x7ffff58b00e2
[   44.977713] Code: 08 0f 85 b1 3d ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   44.977714] RSP: 002b:00007fffa7ffd8c8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000101
[   44.977715] RAX: ffffffffffffffda RBX: 00007fffa00db6a0 RCX: 00007ffff58=
b00e2
[   44.977716] RDX: 00000000000800c1 RSI: 00007fffa00db940 RDI: fffffffffff=
fff9c
[   44.977716] RBP: 00007fffa0069970 R08: 0000000000000000 R09: 00000000000=
00000
[   44.977717] R10: 00000000000001a4 R11: 0000000000000246 R12: 00007fffa00=
68f10
[   44.977717] R13: 0000000000000000 R14: 00007fffa7ffdb90 R15: 00005555580=
ea620
[   44.977719]  </TASK>
[   44.977719] Modules linked in: uinput(E) ccm(E) rfcomm(E) snd_seq_dummy(=
E) snd_hrtimer(E) snd_seq(E) nft_masq(E) nft_ct(E) veth(E) nft_reject_ipv4(=
E) nf_reject_ipv4(E) nft_reject(E) act_csum(E) cls_u32(E) sch_htb(E) nf_con=
ntrack_netlink(E) xt_nat(E) xt_tcpudp(E) xt_conntrack(E) xt_MASQUERADE(E) b=
ridge(E) stp(E) llc(E) xfrm_user(E) xfrm_algo(E) tun(E) xt_set(E) ip_set(E)=
 nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv=
4(E) xt_addrtype(E) nft_compat(E) x_tables(E) nf_tables(E) overlay(E) cdc_n=
cm(E) cdc_ether(E) usbnet(E) mii(E) ipheth(E) vmnet(OE) cmac(E) algif_hash(=
E) algif_skcipher(E) af_alg(E) bnep(E) nls_utf8(E) vfat(E) ntfs(E) fat(E) h=
id_logitech_hidpp(E) uvcvideo(E) uvc(E) btusb(E) videobuf2_vmalloc(E) btmtk=
(E) videobuf2_memops(E) btrtl(E) videobuf2_v4l2(E) btbcm(E) videobuf2_commo=
n(E) btintel(E) apple_mfi_fastcharge(E) videodev(E) bluetooth(E) snd_hda_co=
dec_intelhdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_=
intel_hda_generic(E) soundwire_intel(E)
[   44.977739]  snd_sof_intel_hda_sdw_bpt(E) snd_sof_intel_hda_common(E) sn=
d_soc_hdac_hda(E) intel_uncore_frequency(E) snd_sof_intel_hda_mlink(E) inte=
l_uncore_frequency_common(E) intel_tcc_cooling(E) snd_sof_intel_hda(E) soun=
dwire_cadence(E) x86_pkg_temp_thermal(E) snd_sof_pci(E) intel_powerclamp(E)=
 snd_sof_xtensa_dsp(E) coretemp(E) snd_sof(E) iwlmld(E) snd_sof_utils(E) sn=
d_soc_acpi_intel_match(E) snd_soc_acpi_intel_sdca_quirks(E) snd_hda_codec_a=
lc269(E) ucsi_acpi(E) soundwire_generic_allocation(E) mac80211(E) snd_hda_c=
odec_realtek_lib(E) snd_soc_sdw_utils(E) typec_ucsi(E) snd_hda_scodec_compo=
nent(E) kvm_intel(E) snd_soc_acpi(E) ptp(E) typec(E) snd_hda_codec_generic(=
E) soundwire_bus(E) pps_core(E) roles(E) spd5118(E) mei_hdcp(E) mei_pxp(E) =
intel_rapl_msr(E) asus_nb_wmi(E) libarc4(E) snd_hda_codec_nvhdmi(E) snd_soc=
_sdca(E) snd_hda_codec_hdmi(E) kvm(E) crc8(E) irqbypass(E) snd_soc_avs(E) g=
hash_clmulni_intel(E) aesni_intel(E) snd_soc_hda_codec(E) processor_thermal=
_device_pci(E) gf128mul(E) asus_armoury(E)
[   44.977755]  snd_hda_ext_core(E) snd_hda_intel(E) rapl(E) processor_ther=
mal_device(E) snd_hda_codec(E) snd_usb_audio(E) intel_cstate(E) processor_t=
hermal_power_floor(E) iwlwifi(E) firmware_attributes_class(E) r8169(E) snd_=
soc_core(E) snd_usbmidi_lib(E) snd_hda_core(E) processor_thermal_wt_hint(E)=
 spi_nor(E) processor_thermal_wt_req(E) asus_wmi(E) snd_ump(E) snd_hda_scod=
ec_cs35l41_spi(E) realtek(E) snd_intel_dspcfg(E) ac97_bus(E) intel_uncore(E=
) mousedev(E) joydev(E) sparse_keymap(E) wmi_bmof(E) pcspkr(E) mtd(E) nvidi=
a_wmi_ec_backlight(E) snd_rawmidi(E) processor_thermal_rfim(E) snd_hda_scod=
ec_cs35l41_i2c(E) hid_logitech_dj(E) snd_pcm_dmaengine(E) mdio_devres(E) sn=
d_intel_sdw_acpi(E) cfg80211(E) processor_thermal_mbox(E) i2c_i801(E) snd_s=
eq_device(E) snd_hda_scodec_cs35l41(E) snd_compress(E) snd_hwdep(E) libphy(=
E) platform_temperature_control(E) snd_soc_cs_amp_lib(E) i2c_smbus(E) snd_p=
cm(E) processor_thermal_rapl(E) i2c_mux(E) snd_soc_cs35l41_lib(E) mdio_bus(=
E) uas(E) snd_timer(E) cs_dsp(E) rfkill(E)
[   44.977771]  intel_rapl_common(E) mei_me(E) snd(E) processor_thermal_soc=
_slider(E) mei(E) hid_cmedia(E) usb_storage(E) mc(E) soundcore(E) platform_=
profile(E) serial_multi_instantiate(E) intel_pmc_core(E) intel_pmc_ssram_te=
lemetry(E) pmt_telemetry(E) int3400_thermal(E) pmt_discovery(E) int3403_the=
rmal(E) thunderbolt(E) pmt_class(E) pinctrl_alderlake(E) int340x_thermal_zo=
ne(E) acpi_thermal_rel(E) acpi_pad(E) acpi_tad(E) mac_hid(E) tcp_bbr(E) sch=
_cake(E) vmmon(OE) sg(E) vmw_vmci(E) ntsync(E) dm_mod(E) i2c_dev(E) pkcs8_k=
ey_parser(E) crypto_user(E) nfnetlink(E) zram(E) 842_decompress(E) 842_comp=
ress(E) lz4hc_compress(E) lz4_compress(E) xe(E) nvme(E) nvme_core(E) nvidia=
_drm(OE) intel_vsec(E) nvme_keyring(E) drm_gpusvm_helper(E) nvme_auth(E) nv=
idia_uvm(OE) drm_suballoc_helper(E) hkdf(E) gpu_sched(E) nvidia_modeset(OE)=
 drm_gpuvm(E) drm_exec(E) i2c_algo_bit(E) drm_display_helper(E) intel_lpss_=
pci(E) spi_intel_pci(E) cec(E) intel_lpss(E) spi_intel(E) idma64(E) drm_bud=
dy(E) serio_raw(E) nvidia(OE) drm_ttm_helper(E) video(E)
[   44.977790]  wmi(E) ttm(E)
[   44.977791] Unloaded tainted modules: acpi_cpufreq(E):1 fjes(E):2 ie3120=
0_edac(E):1
[   44.977793] CR2: 0000000000000040
[   44.977795] ---[ end trace 0000000000000000 ]---

Return early if it is NULL.

Fixes: 8b4064e6146e ("ntfs: zero out stale data in straddle block beyond in=
itialized_size")
Signed-off-by: Eric Naim <dnaim@cachyos.org>
---
 fs/ntfs/aops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 1fbf832ad165..f39b6eda251e 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -41,6 +41,9 @@ static void ntfs_iomap_bio_submit_read(const struct iomap=
_iter *iter,
 	struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio =3D ctx->read_ctx;
+	if (!bio)
+		return;
+
 	bio->bi_end_io =3D ntfs_iomap_read_end_io;
 	submit_bio(bio);
 }
--=20
2.54.0


