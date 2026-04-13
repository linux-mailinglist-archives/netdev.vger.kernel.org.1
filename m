Return-Path: <netdev+bounces-278629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCpmF80H32nuNwAAu9opvQ
	(envelope-from <netdev+bounces-278629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:36:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA09D40001E
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBC9C302B74B
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 03:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1812D7812;
	Wed, 15 Apr 2026 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXBdgfGi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6351E8332
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224202; cv=none; b=Ml7YK0+1zM3pFvlE+85wcU8A7NHKm1g3o8eGZYilE+uFOD79vgAN5wv5cJoj3awEjZO09cvb5nscjrXmikAFLRiRIuDZWgtavtziKWiezAyzpdw5YvT2hj0fYk22PMfxrglF5sTcZM7DVJIvsyaKg1mstOiDA6Qo/g8dRpuycC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224202; c=relaxed/simple;
	bh=C/B1iyGzAeco8mG6XbmyXE51qKv69U4KUwCwz/s2yqs=;
	h=Message-ID:MIME-Version:Date:Subject:From:To:Cc; b=rlHFZRrfGJ6T5d1v+Gn1wlH2PiC21da5u9md7whPOD0h0BPbM7EA/ZhMuv+ENClvZCaV4VVoasreazcgZwma2957hGMj7DM8gzGTnvviu5EaG1dQjYR66kykd2yFYF+2gQsSQHA3fJ33PEns9FFMWi3Gur9riOgQZ8W2gvoKPJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXBdgfGi; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c794baca11dso950864a12.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 20:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776224200; x=1776829000; darn=vger.kernel.org;
        h=resent-message-id:resent-subject:resent-to:resent-from:resent-date
         :cc:to:from:subject:date:mime-version:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ZLYidU8KdyVrc/NNKWv09N00LRazE5EQKYln5mJeJc=;
        b=JXBdgfGi0fAKE/4deKhGlWEyxY3af0MthNe9LtfV10IBwpM8gUwJPL4NeZiBZhHmiW
         TX/CVCZikcaXuai8HxL0gi3uIu/AB5wPU9SPgc3VdcIUpvimGjVxNQ/0GyGw0bJGmywf
         029Sb+Bbq+RYGK8FFVFUMPiD2SdKoIorolBUPFPUZ3ZGvou8lBAWaIVoPw++cvMZPrTq
         v1W4wG917dWDCpbuPjmlcGAD1tJelUcVoB1VJwEGJYyOlRkUj6eKdJNdXgU8mXeufVK5
         plCMjHzKWYbP614Tp8LkEnBLR1ZEPzn1CBHJX7pIwsPAEeqI/8kNYBhXMr9CkTVrQA4Y
         lHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776224200; x=1776829000;
        h=resent-message-id:resent-subject:resent-to:resent-from:resent-date
         :cc:to:from:subject:date:mime-version:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZLYidU8KdyVrc/NNKWv09N00LRazE5EQKYln5mJeJc=;
        b=VUpaEIWm9sUa5E+HW6Y2b80WTICrA8XuVMGCUMKGWy+EsB38cnmrcwcNy4UyrCXd9A
         LdToXtchUy/awWX5LrKA6wBvLxrbckjt1U61ltQipG83W6lqO8iV7NfflM+3/sU1ekfs
         AobAFsjQrAor27DqUmnSB1L3SJao9OwpFPRYo5x1tH1WFLCrbXvSwSMFjBrJOl8YFQAY
         GoaJpzJjpNmUaswsxBZZF2UBzftk+G331BiuE1WNwX/3lqmpgzznNy5RsHapcUpyWJnd
         R8uqJKvqSSKMO5fgpxoHElvV4a2MPFqL7nc3LrIDLg4oECW1hdCByptbUD1rWdZej/q1
         f2Qg==
X-Forwarded-Encrypted: i=1; AFNElJ/g/qFv0KAYbhC22s3Ne2Yh+zeHudGJrud2gzXFXe1cZ4wd2/ySY2zMaYyBS8diDEtMAXek3r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQouuKXoKlzHjk3Q/DbYeOJgNS87aZnnjiBrGPMRHoOTerndLT
	Rl79WxTPh427/hpzte6nIFIZtdYujfJaWF26unqRSMa/haMOmWEgNS9NTmXfsQ==
X-Gm-Gg: AeBDievsCkY0bjg6BumMEdWhas/dfu82HvZ88AIkmenIfH2VL3kglS3YN3BhMDA1DBj
	Kst/VIiO0kUSuGZQJEmJ7kpG10UW5MjFSL9R0zPhAwzI7/AuDIaBEubTL0ftHEqUa2UrH1wYS45
	x3LwW1GsxylJG9MhGA4Kbpd1Sd6jzcf/HAdenLLPUbudXrozPTZuGYpHfmChh+LVZuVxgViRAz3
	7DZCJkYt0kcAJ5wNHIfoZqs4cx7MvvsD+UXwqBjwlKCCl9WsaFeVUW0Qv5CSIZCiUOg1IsYeU+u
	J0Lo0mcWe5mzq8GFT24Vl88pafqaEd4J2cfCMPQOopidxvhR9YVqgj5a3qvWClxo+6M3DxqyXWM
	p3aU3+eFQ3yXDbFtzEfzsSU2HGDEv4H7TtcULp3um4qM9eCIMSaYtdnV8yBwmMPXhVhx2nSldkx
	vZMsH5YBkFB7CUJY3T8bc+HKcny5Rt2/7x4BH5bK7QhfW2APWeVFHXzyegj/lr0g==
X-Received: by 2002:a05:6a21:3384:b0:39f:3ca8:a331 with SMTP id adf61e73a8af0-39fe3d0e147mr22603896637.16.1776224199868;
        Tue, 14 Apr 2026 20:36:39 -0700 (PDT)
Received: from smtp.rather.puzzling.org ([122.199.47.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957eeaabesm306595a12.10.2026.04.14.20.36.38
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 20:36:39 -0700 (PDT)
Message-ID: <69df07c7.630a0220.281396.60d8@mx.google.com>
Received: from dirac.rather.puzzling.org (dirac.rather.puzzling.org [192.168.1.17])
	by smtp.rather.puzzling.org (Postfix) with ESMTPS id 79E0D20261
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:36:35 +1000 (AEST)
Received: by dirac.rather.puzzling.org (Postfix, from userid 738)
	id 0DDEE20840; Wed, 15 Apr 2026 13:36:35 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by dirac.rather.puzzling.org (Postfix) with ESMTP id 02DC6207C5
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:36:35 +1000 (AEST)
X-Return-Path: <tim.w.connors@gmail.com>
X-Original-To: tconnors
X-Delivered-To: tconnors@rather.puzzling.org
X-Received: by smtp.rather.puzzling.org (Postfix, from userid 738)
	id A2E3420219; Tue, 14 Apr 2026 00:01:38 +1000 (AEST)
X-Received: from imap.gmail.com [172.253.118.108]
	by smtp.rather.puzzling.org with IMAP (fetchmail-6.4.37 polling imap.gmail.com account tim.w.connors@gmail.com folder INBOX)
	for <tconnors@localhost> (single-drop); Tue, 14 Apr 2026 00:01:37 +1000 (AEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 00:01:29 +1000
Subject: Re: RE: [Intel-wired-lan] Bug#1104670: linux-image-6.12.25-amd64:
 system does not shut down - GHES: Fatal hardware error
From: Tim Connors <tim.w.connors@gmail.com>
To: 1104670@bugs.debian.org
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Hutchings, Ben"
 <ben@decadent.org.uk>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, linux-pci <linux-pci@vger.kernel.org>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>,
 Laurent Bonnaud <L.Bonnaud@laposte.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
ReSent-Date: Wed, 15 Apr 2026 13:36:29 +1000 (AEST)
ReSent-From: Tim Connors <tconnors@rather.puzzling.org>
ReSent-To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
ReSent-Subject: Re: RE: [Intel-wired-lan] Bug#1104670: linux-image-6.12.25-amd64:
 system does not shut down - GHES: Fatal hardware error
ReSent-Message-ID: <ab0f452b-ba91-e165-21c0-3964ee6de636@rather.puzzling.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	DATE_IN_PAST(1.00)[37];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-278629-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,decadent.org.uk,lists.osuosl.org,vger.kernel.org,broadcom.com,laposte.net];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mx.google.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FROM_NEQ_ENVFROM(0.00)[timwconnors@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: AA09D40001E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 14 Jul 2025 09:21:25 +0000 "Loktionov, Aleksandr" <
aleksandr.loktionov@intel.com> wrote:
> > On Sun, 2025-05-04 at 13:45 +0200, Laurent Bonnaud wrote:
> > [...]
> > >   - Previously the kernel would output an error in
> > /var/lib/systemd/pstore/ but would shutdown anyway.
> > >
> > >   - Now, with kernel 6.1.135-1, the shutdown is blocked as with
> > 6.12.x kernels (see below).
> > > <30>[  961.098671] systemd-shutdown[1]: Rebooting.
> > > <6>[  961.098743] kvm: exiting hardware virtualization <6>[
> > > 961.361878] megaraid_sas 0000:17:00.0: megasas_disable_intr_fusion
> > is
> > > called outbound_intr_mask:0x40000009 <6>[  961.414526] ACPI: PM:
> > > Preparing to enter system sleep state S5 <0>[  963.828210]
> > > {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error
> > > Source: 5 <0>[  963.828213] {1}[Hardware Error]: event severity:
> > fatal <0>[  963.828214] {1}[Hardware Error]:  Error 0, type: fatal
> > > <0>[  963.828216] {1}[Hardware Error]:   section_type: PCIe error
> > > <0>[  963.828216] {1}[Hardware Error]:   port_type: 0, PCIe end
> > point
> > > <0>[  963.828217] {1}[Hardware Error]:   version: 3.0
> > > <0>[  963.828218] {1}[Hardware Error]:   command: 0x0002, status:
> > 0x0010
> > > <0>[  963.828220] {1}[Hardware Error]:   device_id: 0000:01:00.1
> > > <0>[  963.828221] {1}[Hardware Error]:   slot: 6
>>> <0>[  963.828222] {1}[Hardware Error]:   secondary_bus: 0x00
>>> <0>[  963.828223] {1}[Hardware Error]:   vendor_id: 0x8086,
>> device_id: 0x1563
>>> <0>[  963.828224] {1}[Hardware Error]:   class_code: 020000
>>> <0>[  963.828225] {1}[Hardware Error]:   aer_uncor_status:
>> 0x00100000, aer_uncor_mask: 0x00018000
>>> <0>[  963.828226] {1}[Hardware Error]:   aer_uncor_severity:
>> 0x000ef010
>>> <0>[  963.828227] {1}[Hardware Error]:   TLP Header: 40000001
>> 0000000f 90028090 00000000
>> [...]
>>
>> It seems that this is a known bug in the BIOS of several Dell
>> PowerEdge models including (in this case) the R540.

Yup, R730XD here.

>> A workaround was added to the tg3 driver
>> <https://git.kernel.org/linus/e0efe83ed325277bb70f9435d4d9fc70bebdcca8
>>
>> and a similar change was proposed (but not accepted) in the i40e
>> driver <https://lore.kernel.org/all/20241227035459.90602-1-
>> yue.zhao@shopee.com/>.
>> On tihis system the erorr log points to a deivce handled by the ixgbe
>> driver, and no workaround has been implemented for that.
>>
>> Since this issue seems to affect multiple different NIC vendors and
>> drivers, would it make more sense to implement this workaround as a
>> PCI quirk?

It's not just network devices either.

<5>[965917.449277] sd 4:0:0:0: [sda] Synchronizing SCSI cache
<6>[965917.614364] [drm] PCIE GART of 256M enabled (table at
0x000000F47FF80000).
<6>[965917.820364] [drm] UVD and UVD ENC initialized successfully.
<6>[965917.921559] [drm] VCE initialized successfully.
<6>[965917.926574] amdgpu 0000:04:00.0: [drm] Cannot find any crtc or sizes
<6>[965917.934684] amdgpu 0000:04:00.0: [drm] Cannot find any crtc or sizes
<0>[965919.725575] {1}[Hardware Error]: Hardware error from APEI Generic
Hardware Error Source: 3
<0>[965919.725582] {1}[Hardware Error]: event severity: fatal
<0>[965919.725587] {1}[Hardware Error]:  Error 0, type: fatal
<0>[965919.725591] {1}[Hardware Error]:   section_type: PCIe error
<0>[965919.725595] {1}[Hardware Error]:   port_type: 1, legacy PCI end point
<0>[965919.725598] {1}[Hardware Error]:   version: 1.16
<0>[965919.725602] {1}[Hardware Error]:   command: 0x0407, status: 0x0010
<0>[965919.725607] {1}[Hardware Error]:   device_id: 0000:04:00.1
<0>[965919.725611] {1}[Hardware Error]:   slot: 0
<0>[965919.725614] {1}[Hardware Error]:   secondary_bus: 0x00
<0>[965919.725617] {1}[Hardware Error]:   vendor_id: 0x1002, device_id:
0xaae0
<0>[965919.725622] {1}[Hardware Error]:   class_code: 040300
<0>[965919.725625] {1}[Hardware Error]:   aer_cor_status: 0x00002000,
aer_cor_mask: 0x000031c0
<0>[965919.725630] {1}[Hardware Error]:   aer_uncor_status: 0x00100000,
aer_uncor_mask: 0x00010000
<0>[965919.725635] {1}[Hardware Error]:   aer_uncor_severity: 0x004e7030
<0>[965919.725638] {1}[Hardware Error]:   TLP Header: 40008001 00000a0f
96a121a0 00000000
<0>[965919.725646] GHES: Fatal hardware error but panic disabled
<0>[965919.725650] Kernel panic - not syncing: GHES: Fatal hardware error
<4>[965919.725662] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: P
  O       6.14.11-5-bpo12-pve #1
<4>[965919.725676] Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE
<4>[965919.725689] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS
2.19.0 12/12/2023
<4>[965919.725694] Call Trace:
<4>[965919.725700]  <NMI>
<4>[965919.725706]  dump_stack_lvl+0x27/0xa0
<4>[965919.725722]  dump_stack+0x10/0x20
<4>[965919.725729]  panic+0x358/0x3b0
<4>[965919.725742]  __ghes_panic+0x60/0x80
<4>[965919.725756]  ghes_notify_nmi+0x1d5/0x380
<4>[965919.725768]  nmi_handle.part.0+0x58/0x160
<4>[965919.725781]  default_do_nmi+0x131/0x170
<4>[965919.725792]  exc_nmi+0x1c4/0x290
<4>[965919.725799]  end_repeat_nmi+0xf/0x53
<4>[965919.725816] RIP: 0010:intel_idle+0x51/0x90
<4>[965919.725824] Code: 2d 80 ca 2b 00 eb 52 cc cc cc 48 89 f0 0f 1f 00 31
d2 48 89 d1 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0 0f 01 c9
<f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 ea
<4>[965919.725830] RSP: 0018:ffffffff8ec03db0 EFLAGS: 00000046
<4>[965919.725837] RAX: 0000000000000020 RBX: ffff8aa2ffa44680 RCX:
0000000000000001
<4>[965919.725841] RDX: 0000000000000000 RSI: ffffffff8ec107c0 RDI:
0000000000000004
<4>[965919.725849] RBP: ffffffff8ec03df0 R08: 0000000000000020 R09:
0000000000000000
<4>[965919.725854] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000004
<4>[965919.725857] R13: ffffffff8ee86960 R14: ffffffff8ee86b18 R15:
0000000000000004
<4>[965919.725866]  ? intel_idle+0x51/0x90
<4>[965919.725873]  ? intel_idle+0x51/0x90
<4>[965919.725879]  </NMI>
<4>[965919.725882]  <TASK>
<4>[965919.725884]  ? cpuidle_enter_state+0x85/0x450
<4>[965919.725895]  cpuidle_enter+0x2e/0x50
<4>[965919.725908]  call_cpuidle+0x22/0x60
<4>[965919.725918]  do_idle+0x1de/0x240
<4>[965919.725925]  cpu_startup_entry+0x29/0x30
<4>[965919.725930]  rest_init+0xd0/0xd0
<4>[965919.725934]  start_kernel+0x779/0xb60
<4>[965919.725941]  ? load_ucode_intel_bsp+0x43/0xa0
<4>[965919.725952]  x86_64_start_reservations+0x18/0x30
<4>[965919.725961]  x86_64_start_kernel+0xbf/0x110
<4>[965919.725968]  common_startup_64+0x13e/0x141
<4>[965919.725980]  </TASK>
<0>[965919.726136] Kernel Offset: 0xb600000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)


04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Lexa PRO [Radeon 540/540X/550/550X / RX 540X/550/550X] (rev c7) (prog-if 00
[VGA controller])
        Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Lexa PRO [Radeon
540/540X/550/550X / RX 540X/550/550X]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 174
        NUMA node: 0
        IOMMU group: 29
        Region 0: Memory at 38000000000 (64-bit, prefetchable) [size=2G]
        Region 2: Memory at 38080000000 (64-bit, prefetchable) [size=2M]
        Region 4: I/O ports at 2000 [size=256]
        Region 5: Memory at 96a00000 (32-bit, non-prefetchable) [size=256K]
        Expansion ROM at 96a60000 [disabled] [size=128K]
        Capabilities: <access denied>
        Kernel driver in use: amdgpu
        Kernel modules: amdgpu

04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Baffin HDMI/DP
Audio [Radeon RX 550 640SP / RX 560/560X]
        Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Baffin HDMI/DP
Audio [Radeon RX 550 640SP / RX 560/560X]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 172
        NUMA node: 0
        IOMMU group: 30
        Region 0: Memory at 96a40000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel

Was completely idle and unused all boot session, and reboot was routine
after patching. kernel 6.14.11-5-bpo12 from proxmox backports (so ubuntu
backports, essentially).

> I support the idea of PCI workaround, but who will implement it ?



