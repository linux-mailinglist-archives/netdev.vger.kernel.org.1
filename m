Return-Path: <netdev+bounces-280730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMyQJ9wE6mk/rQIAu9opvQ
	(envelope-from <netdev+bounces-280730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:39:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4342E451635
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9B743006B42
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9073806D8;
	Thu, 23 Apr 2026 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="dkBsT92e"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA530E857;
	Thu, 23 Apr 2026 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944346; cv=none; b=rOtF1Ggp6Y/VRrlxpSrwf5NwWnf7mb6WC0Hgswiej10x/J9cS715ANqEvULHcrh3jQPI9n2W0R8liZ0UR+C1t8ASINlYqpll1LljSJHpzO18aEnjZcUj1p8ou4HcNOgr6kuHOKixyZTayLtqA0sqnXWLTZ6fbZNccGiUBJw0p8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944346; c=relaxed/simple;
	bh=n7tqJRSrFf1N5EDGBZ4fr3tvKY/ibclI0D0paEkoqOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+OiRKhlPdNXlhO6rtaaws7Dg4xhBFdYl5YFVRp+pFB/+3n5XVcL6vICPI+zUT3fCQ1LZnlXdPHSzjQ53dsZU5O4KGdMyMFUvUfvMLHWGJ2oojq3l2OspSVWnJE+HslBX42NrDcl+HfUZHAQE3DvULM/u/PDknC6gg8hWzDBC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=dkBsT92e; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7FA8A285D9C;
	Thu, 23 Apr 2026 13:38:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1776944341; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=o7+Mm0Xw4b3lgSBUL+MV/F/uVp7ggKPelivWAV/NqMI=;
	b=dkBsT92eO0/jzEvyAgOXADn4dOf3iF0zveu7KwN3VnO+dK4sTQsm/Qe0ZW0DOSYkozERNP
	moC2G1FGJ+iTzMBHTxS0x1mWyEilmXDV9+n3hxFESFxDdv7VhKxKNBV6dfZeN85N9yDvkl
	eYi8K+h4KPM7xGebNUxt8yLvjD6N6ch2JHMzhDDAX9uVGpvQF0SA4C0BRbSG6NiePKnMht
	NIEfJ/SK8Y/gk2B9yvXEFESHvUOIpoEDLYOfQ+vm7UkFfEdSRd2HAe2EHtB3NU17iWGlIG
	Z5EzpL+nCxrIf7ld4zZI69ba52fxqIGBjydFUtEsISCPhXvQds3+BPAPOUcVaA==
Message-ID: <96fbbaf4-281c-4789-b170-4cee26bce011@cachyos.org>
Date: Thu, 23 Apr 2026 11:38:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ntfs: Avoid NULL pointer dereference in
 ntfs_iomap_submit_read()
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, llvm@lists.linux.dev
References: <20260423104119.414765-1-dnaim@cachyos.org>
From: Eric Naim <dnaim@cachyos.org>
In-Reply-To: <20260423104119.414765-1-dnaim@cachyos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cachyos.org,quarantine];
	R_DKIM_ALLOW(-0.20)[cachyos.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280730-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cachyos.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dnaim@cachyos.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4342E451635
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/23/26 6:41 PM, Eric Naim wrote:
> ctx->read_ctx can be NULL when ntfs_iomap_submit_read is called, leadin=
g
> to below trace:
>=20
> [   44.977614] BUG: kernel NULL pointer dereference, address: 000000000=
0000040
> [   44.977617] #PF: supervisor write access in kernel mode
> [   44.977618] #PF: error_code(0x0002) - not-present page
> [   44.977619] PGD 0 P4D 0
> [   44.977621] Oops: Oops: 0002 [#1] SMP
> [   44.977623] CPU: 0 UID: 1000 PID: 5010 Comm: pool-4 Kdump: loaded Ta=
inted: G     U     OE       7.0.1-1-cachyos-bmq-hakuu-tlto-gdc7bc3c05102 =
#7 PREEMPT(full)  c202625180654aea7fdad2184acc19b9c28ed6ee
> [   44.977626] Tainted: [U]=3DUSER, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MO=
DULE
> [   44.977626] Hardware name: ASUSTeK COMPUTER INC. ASUS TUF Gaming F16=
 FX607JV_FX607JV/FX607JV, BIOS FX607JV.316 10/13/2025
> [   44.977627] RIP: 0010:ntfs_swap_activate.llvm.1224280209124021557+0x=
2d/0x3c0 [ntfs]
> [   44.977631] Code: fa 0f 1f 44 00 00 48 c7 c1 78 76 93 a2 e9 2b 2d cc=
 de cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 48 8b 7f =
18 <48> c7 47 40 60 04 aa a2 e9 56 c9 fd de cc cc cc cc cc cc f3 0f 1e
> [   44.977632] RSP: 0018:ffffc90023c27648 EFLAGS: 00010282
> [   44.977633] RAX: ffffffffa2aa0440 RBX: ffffc90023c27758 RCX: 0000000=
000001000
> [   44.977634] RDX: 0000000000001000 RSI: 0000000006f20000 RDI: 0000000=
000000000
> [   44.977635] RBP: 0000000006f20000 R08: 0000000000000000 R09: ffffc90=
023c27680
> [   44.977636] R10: 0000000000000009 R11: 0000000006f203ff R12: ffffc90=
023c27650
> [   44.977637] R13: ffffea000810e0c0 R14: ffffffffa2937678 R15: ffffc90=
023c27658
> [   44.977638] FS:  00007fffa7fff6c0(0000) GS:ffff888d29052000(0000) kn=
lGS:0000000000000000
> [   44.977639] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   44.977640] CR2: 0000000000000040 CR3: 0000000160320004 CR4: 0000000=
000f72ef0
> [   44.977641] PKRU: 55555554
> [   44.977641] Call Trace:
> [   44.977642]  <TASK>
> [   44.977643]  iomap_read_folio+0xe2/0x180
> [   44.977647]  ntfs_read_folio.llvm.1224280209124021557+0x69/0xe0 [ntf=
s df169bf55ac22e619ebd511d6378b3aa21a54f15]
> [   44.977650]  do_read_cache_folio.llvm.11351189850855672942+0x1a9/0x3=
10
> [   44.977652]  ? cleanup_module+0x1f0/0x1f0 [fat f3f47899f717abaf28287=
0f380e376f623b66fa1]
> [   44.977654]  ntfs_mft_record_alloc+0x8df/0x2bd0 [ntfs df169bf55ac22e=
619ebd511d6378b3aa21a54f15]
> [   44.977657]  ntfs_get_parent.llvm.15803940035981701475+0x569/0x1780 =
[ntfs df169bf55ac22e619ebd511d6378b3aa21a54f15]
> [   44.977659]  ? kmem_cache_alloc_noprof+0x187/0x420
> [   44.977660]  ntfs_create.llvm.15803940035981701475+0x106/0x170 [ntfs=
 df169bf55ac22e619ebd511d6378b3aa21a54f15]
> [   44.977662]  path_openat+0x541/0xdb0
> [   44.977664]  do_file_open+0xd7/0x190
> [   44.977666]  do_sys_openat2+0x76/0xe0
> [   44.977668]  __x64_sys_openat+0x80/0xa0
> [   44.977669]  do_syscall_64+0xf8/0x350
> [   44.977671]  ? do_statx_fd+0x100/0x140
> [   44.977672]  ? ext4_listxattr+0x1d9/0x200
> [   44.977674]  ? listxattr+0xfe/0x150
> [   44.977675]  ? __x64_sys_flistxattr+0x7a/0xa0
> [   44.977677]  ? do_syscall_64+0x133/0x350
> [   44.977678]  ? __x64_sys_flistxattr+0x7a/0xa0
> [   44.977679]  ? do_syscall_64+0x133/0x350
> [   44.977681]  ? rcu_report_qs_rdp+0xca/0x180
> [   44.977683]  ? sched_clock+0x10/0x20
> [   44.977684]  ? sched_clock_cpu+0x10/0x190
> [   44.977685]  ? irqtime_account_irq+0x28/0xa0
> [   44.977687]  ? do_syscall_64+0x133/0x350
> [   44.977688]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   44.977689] RIP: 0033:0x7ffff58b00e2
> [   44.977713] Code: 08 0f 85 b1 3d ff ff 49 89 fb 48 89 f0 48 89 d7 48=
 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f =
05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
> [   44.977714] RSP: 002b:00007fffa7ffd8c8 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000101
> [   44.977715] RAX: ffffffffffffffda RBX: 00007fffa00db6a0 RCX: 00007ff=
ff58b00e2
> [   44.977716] RDX: 00000000000800c1 RSI: 00007fffa00db940 RDI: fffffff=
fffffff9c
> [   44.977716] RBP: 00007fffa0069970 R08: 0000000000000000 R09: 0000000=
000000000
> [   44.977717] R10: 00000000000001a4 R11: 0000000000000246 R12: 00007ff=
fa0068f10
> [   44.977717] R13: 0000000000000000 R14: 00007fffa7ffdb90 R15: 0000555=
5580ea620
> [   44.977719]  </TASK>
> [   44.977719] Modules linked in: uinput(E) ccm(E) rfcomm(E) snd_seq_du=
mmy(E) snd_hrtimer(E) snd_seq(E) nft_masq(E) nft_ct(E) veth(E) nft_reject=
_ipv4(E) nf_reject_ipv4(E) nft_reject(E) act_csum(E) cls_u32(E) sch_htb(E=
) nf_conntrack_netlink(E) xt_nat(E) xt_tcpudp(E) xt_conntrack(E) xt_MASQU=
ERADE(E) bridge(E) stp(E) llc(E) xfrm_user(E) xfrm_algo(E) tun(E) xt_set(=
E) ip_set(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E)=
 nf_defrag_ipv4(E) xt_addrtype(E) nft_compat(E) x_tables(E) nf_tables(E) =
overlay(E) cdc_ncm(E) cdc_ether(E) usbnet(E) mii(E) ipheth(E) vmnet(OE) c=
mac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) nls_utf8(E) vfat=
(E) ntfs(E) fat(E) hid_logitech_hidpp(E) uvcvideo(E) uvc(E) btusb(E) vide=
obuf2_vmalloc(E) btmtk(E) videobuf2_memops(E) btrtl(E) videobuf2_v4l2(E) =
btbcm(E) videobuf2_common(E) btintel(E) apple_mfi_fastcharge(E) videodev(=
E) bluetooth(E) snd_hda_codec_intelhdmi(E) snd_sof_pci_intel_tgl(E) snd_s=
of_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E)
> [   44.977739]  snd_sof_intel_hda_sdw_bpt(E) snd_sof_intel_hda_common(E=
) snd_soc_hdac_hda(E) intel_uncore_frequency(E) snd_sof_intel_hda_mlink(E=
) intel_uncore_frequency_common(E) intel_tcc_cooling(E) snd_sof_intel_hda=
(E) soundwire_cadence(E) x86_pkg_temp_thermal(E) snd_sof_pci(E) intel_pow=
erclamp(E) snd_sof_xtensa_dsp(E) coretemp(E) snd_sof(E) iwlmld(E) snd_sof=
_utils(E) snd_soc_acpi_intel_match(E) snd_soc_acpi_intel_sdca_quirks(E) s=
nd_hda_codec_alc269(E) ucsi_acpi(E) soundwire_generic_allocation(E) mac80=
211(E) snd_hda_codec_realtek_lib(E) snd_soc_sdw_utils(E) typec_ucsi(E) sn=
d_hda_scodec_component(E) kvm_intel(E) snd_soc_acpi(E) ptp(E) typec(E) sn=
d_hda_codec_generic(E) soundwire_bus(E) pps_core(E) roles(E) spd5118(E) m=
ei_hdcp(E) mei_pxp(E) intel_rapl_msr(E) asus_nb_wmi(E) libarc4(E) snd_hda=
_codec_nvhdmi(E) snd_soc_sdca(E) snd_hda_codec_hdmi(E) kvm(E) crc8(E) irq=
bypass(E) snd_soc_avs(E) ghash_clmulni_intel(E) aesni_intel(E) snd_soc_hd=
a_codec(E) processor_thermal_device_pci(E) gf128mul(E) asus_armoury(E)
> [   44.977755]  snd_hda_ext_core(E) snd_hda_intel(E) rapl(E) processor_=
thermal_device(E) snd_hda_codec(E) snd_usb_audio(E) intel_cstate(E) proce=
ssor_thermal_power_floor(E) iwlwifi(E) firmware_attributes_class(E) r8169=
(E) snd_soc_core(E) snd_usbmidi_lib(E) snd_hda_core(E) processor_thermal_=
wt_hint(E) spi_nor(E) processor_thermal_wt_req(E) asus_wmi(E) snd_ump(E) =
snd_hda_scodec_cs35l41_spi(E) realtek(E) snd_intel_dspcfg(E) ac97_bus(E) =
intel_uncore(E) mousedev(E) joydev(E) sparse_keymap(E) wmi_bmof(E) pcspkr=
(E) mtd(E) nvidia_wmi_ec_backlight(E) snd_rawmidi(E) processor_thermal_rf=
im(E) snd_hda_scodec_cs35l41_i2c(E) hid_logitech_dj(E) snd_pcm_dmaengine(=
E) mdio_devres(E) snd_intel_sdw_acpi(E) cfg80211(E) processor_thermal_mbo=
x(E) i2c_i801(E) snd_seq_device(E) snd_hda_scodec_cs35l41(E) snd_compress=
(E) snd_hwdep(E) libphy(E) platform_temperature_control(E) snd_soc_cs_amp=
_lib(E) i2c_smbus(E) snd_pcm(E) processor_thermal_rapl(E) i2c_mux(E) snd_=
soc_cs35l41_lib(E) mdio_bus(E) uas(E) snd_timer(E) cs_dsp(E) rfkill(E)
> [   44.977771]  intel_rapl_common(E) mei_me(E) snd(E) processor_thermal=
_soc_slider(E) mei(E) hid_cmedia(E) usb_storage(E) mc(E) soundcore(E) pla=
tform_profile(E) serial_multi_instantiate(E) intel_pmc_core(E) intel_pmc_=
ssram_telemetry(E) pmt_telemetry(E) int3400_thermal(E) pmt_discovery(E) i=
nt3403_thermal(E) thunderbolt(E) pmt_class(E) pinctrl_alderlake(E) int340=
x_thermal_zone(E) acpi_thermal_rel(E) acpi_pad(E) acpi_tad(E) mac_hid(E) =
tcp_bbr(E) sch_cake(E) vmmon(OE) sg(E) vmw_vmci(E) ntsync(E) dm_mod(E) i2=
c_dev(E) pkcs8_key_parser(E) crypto_user(E) nfnetlink(E) zram(E) 842_deco=
mpress(E) 842_compress(E) lz4hc_compress(E) lz4_compress(E) xe(E) nvme(E)=
 nvme_core(E) nvidia_drm(OE) intel_vsec(E) nvme_keyring(E) drm_gpusvm_hel=
per(E) nvme_auth(E) nvidia_uvm(OE) drm_suballoc_helper(E) hkdf(E) gpu_sch=
ed(E) nvidia_modeset(OE) drm_gpuvm(E) drm_exec(E) i2c_algo_bit(E) drm_dis=
play_helper(E) intel_lpss_pci(E) spi_intel_pci(E) cec(E) intel_lpss(E) sp=
i_intel(E) idma64(E) drm_buddy(E) serio_raw(E) nvidia(OE) drm_ttm_helper(=
E) video(E)
> [   44.977790]  wmi(E) ttm(E)
> [   44.977791] Unloaded tainted modules: acpi_cpufreq(E):1 fjes(E):2 ie=
31200_edac(E):1
> [   44.977793] CR2: 0000000000000040
> [   44.977795] ---[ end trace 0000000000000000 ]---
>=20
> Return early if it is NULL.
>=20
> Fixes: 8b4064e6146e ("ntfs: zero out stale data in straddle block beyon=
d initialized_size")
> Signed-off-by: Eric Naim <dnaim@cachyos.org>
> ---
>  fs/ntfs/aops.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
> index 1fbf832ad165..f39b6eda251e 100644
> --- a/fs/ntfs/aops.c
> +++ b/fs/ntfs/aops.c
> @@ -41,6 +41,9 @@ static void ntfs_iomap_bio_submit_read(const struct i=
omap_iter *iter,
>  	struct iomap_read_folio_ctx *ctx)
>  {
>  	struct bio *bio =3D ctx->read_ctx;
> +	if (!bio)
> +		return;
> +
>  	bio->bi_end_io =3D ntfs_iomap_read_end_io;
>  	submit_bio(bio);
>  }

Argh, sorry for the noise. This is impossible because of 19fb5f978075. Pl=
ease
disregard this.

--=20
Regards,
  Eric

