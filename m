Return-Path: <netdev+bounces-250965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 856BAD39DD6
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 06:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 848E83004F3B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 05:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DDE311952;
	Mon, 19 Jan 2026 05:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="vGo2lUOS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA413A3F7
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768800980; cv=pass; b=Umajxh0gDwLN2bDUfLr1hjqhIFwU8S1/bZyb3fUlfGZfLuq8pi2JoeJyOkR4gsmTfCYuiSWf9wyOB1+1cdHTUIhOuhgbr0hEt/+o4jZluwZHSj98xS4SzyHRZOb98Cc8/EZIjEq7ntv2cO/+ge7q5NJxcF7qaxPwPDUjUt+t+Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768800980; c=relaxed/simple;
	bh=pmFunN1tivUicaz50zBAmtcCQOoz4Xig64J24f2upYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjcoTeGfwuGWS5XHQJtzB3zRXPxC4wzswPmccAHDU5nmtDB7P+P+H23oVtk/Oj5+Snh7Y1CdjIZTsAymQML+O5tKpYAUP2SuBTsFcsGYfEKOWHgvCKAW35WA2d8bWlZfqd7gyPW8xanG/9hkN7gu+KYSu24PYaRk2n4VyTaQNAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=vGo2lUOS; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so1763748f8f.3
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 21:36:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768800977; cv=none;
        d=google.com; s=arc-20240605;
        b=LXQiG17dYV89BhMLH73gDp3nX2ND3fEF0WbU9kpZuRDRDY4Pp2x6XGk9xlN9E7xIs3
         k23bKDmNsWoo4i9/Qy5pDA6QAE6q/SRLCxhkQDFZArbNrSeaXM2fWK/T4GvHhaBXzDnk
         TmTge8LtJCAWYSB8cN4/Iw4mc6HgaWB7UzGwSgvvnhDkPdWybCWOT7Wldcj1PYlI0gpt
         0OmglgXP+516h1K2knuIlDqxqMyA+PeIHgqw6GQPEmomQXe7ANPbWFcWlgAZ6Nhj6FBJ
         N19Xr+Ur/gkgXZhAzb75f4iIV62psKBcHYRJs5dVDTd3e0B38t7ghH8hwcpULJXz2Ke3
         lD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/AHZwn8sKOj0g/0V6Pc0Jb8sQ9rvm5bvjlgIp9vt/BY=;
        fh=JQ4K06u/x/q1Mg6BK8peLgismuxKx0TTijDbLyQbYTk=;
        b=SwtkBffqWyOjLKOC8RzegUyluK5LupvLfF5AKZ1wdip1FwOdS04E81yUKtAAVPVMAt
         eQ89tilBrjiovDgNKNYE8AagFQXVmpWyrp27k+aAthglwaMkzp3H4vvQe2LozIKvEPHa
         HkrZ+mqaJGp8LGC27C1zzIpCPRPfVgLMShwpExfNRRJ4iOa7CSIY+ePpBMtX3DegKOeC
         eOMkSuLyED+K7TPP/Hng2DjfBvjM2jCFPaq+5sPdCxhxlkw1eTRp1lTE9iBZ4QtzOV5B
         iHl2hGhIIpR9BN7lhuE3fqBFIlM87whz9x/c7R4vFoy0/a782Q10jy2s9QBZKEdm4Bqx
         1unA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1768800977; x=1769405777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AHZwn8sKOj0g/0V6Pc0Jb8sQ9rvm5bvjlgIp9vt/BY=;
        b=vGo2lUOS/+0Ofe7I0fpuGN1I55owSQiFKE6Bd3aF31VP+tbcmPJ+8XAfnRMeSknh6p
         KSfYIhGGJlmEhNZFAFQJo1zrPGJVblUZkm+HyS1OnTYgLc+sH7B34Q/FbTKmwcRJPmj1
         8uftraq82KcW/DP8RNbcRUxmmxAPJXd2452fyZddGhGPmOC0ZAeeLA+k36aiGQAjuHe1
         TNNOaMcUOVzaoJrrEtOOWFSuWJxuWitF8N7yRy+VDG451257WYabjHfrb2qV4xCYP4m4
         fvyvBzhi99bcgs8jznPrNGEAXUhai1fn9xPsOB4ggVDiKmFmDOWzzs3/afEyk4ujIzZo
         MBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768800977; x=1769405777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/AHZwn8sKOj0g/0V6Pc0Jb8sQ9rvm5bvjlgIp9vt/BY=;
        b=dG/+/7ZRb0tGcCnEkdv8FHkHdVK8pwHQMkKSuwbQVnRQGEEK1ERTZVsNSJz7fbkHS3
         rwge+3UdXKKUV1eyQMbbRPNncUiD1WtQV628QUuEhf/jRjHrlL/mHMFaZ8aRXuhnJikn
         vX3O9TEfJfn8UE8lJWbV49AasaOxwpYq3xM+/VHKz67stKFErVbE+Unni5mG8VM+yyqm
         87Rpiautq2ShdninjOulx592roKermUgO1B/0TQrSLH17HhMNvXnRXBizKg7TpgTKPRx
         qolyHaXee3vbtiHtOR9dzKNYbArpYhjMXWBA5HnADouhyUTnRX63KTfpxKx7evXreocL
         2iZg==
X-Forwarded-Encrypted: i=1; AJvYcCXl1ExkrkXmnnn48bd37LTK3S2l6ToaWjlBs0yNgkTMN9FJc+FTMJ3YsKy7mnLLwCckswexVf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6DuP9jjjG1otjOHclxjbud/9pzmNSABFDjRYRBsqQdNs7g0/z
	vK6vjtwCYkraWLiDCGGiSS+ERsuE/V06j8v29HE0J+f2J4BXm51XrsT1ILC0rELg9lBYX9G2R+e
	vmHsk6q3kOzR/idk560xVDyjl/1ZlTl73D3/QAaZKiQ==
X-Gm-Gg: AZuq6aKHrhJSlJxkHA9d9tLPRRW6O+qarRWcrMElAa8IGpfabdPV2QVKr4rCcdlEy7v
	KRIs8JeS8a/JxPaM4hdhuqd3AeL9dJL/DABvOaQFUwS1VH6vYU8mNqyTKSUNEw63PrVFtMBUhmT
	nCdqn+AGjzZHBKGejiThkle4Jdf9g4UgatYCp5eI/BrpuYM9mmNroF0hZolJvmdp8wcSCimToYy
	nV8RtkE4JLecuVq6vXrftBC0MDSS6g7ZCB0bcYz6fKG42NfGIrQSQKfePrwRhMmEhG1eCEngIsR
	MQclK/fswrE642KJ+GVoT02FpQ==
X-Received: by 2002:a05:6000:2085:b0:432:c0e6:cfcc with SMTP id
 ffacd0b85a97d-4356a029c8emr13158192f8f.23.1768800976937; Sun, 18 Jan 2026
 21:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3_Gnogt7GR0gZVZwQ4vXXav6TpXMK6t=QTLsqKOaX3Bo_tNA@mail.gmail.com>
 <CANn89iLVq=3d7Ra7gKmTpLcMzuWv+KamYs=KjUHH2z3cPpDBDA@mail.gmail.com>
 <CAA3_GnrVyeXtLjhZ_d9=0x58YmK+a9yADfp+LRCBHQo_TEDyvw@mail.gmail.com>
 <CANn89iJN-fcx-szsR3Azp8wQ0zhXp0XiYJofQU1zqqtdj7SWTA@mail.gmail.com>
 <CACwEKLp42TwpK_3FEp85bq81eA1zg3777guNMonW9cm2i7aN2Q@mail.gmail.com>
 <CAA3_Gnqo37RxLi2McF0=oRPZSw_P3Kya_3m3JBA2s6c0vaf5sw@mail.gmail.com> <CANn89iL8FnPG9bD6zW0eHmeSNzc33SJgrUR7Aab4PFG-O4nfTw@mail.gmail.com>
In-Reply-To: <CANn89iL8FnPG9bD6zW0eHmeSNzc33SJgrUR7Aab4PFG-O4nfTw@mail.gmail.com>
From: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Date: Mon, 19 Jan 2026 14:36:04 +0900
X-Gm-Features: AZwV_QhqLBcmX3NkzHszzN6BHk8S3x0foOSuvxMbmN81wAwJu0zi8IYU_2ZGcFo
Message-ID: <CAA3_GnpijQeBNVOqy6QtUMDjhy_ku_b54uf30zfEq=etMTqKrA@mail.gmail.com>
Subject: Re: [PATCH net] bonding: Fix header_ops type confusion
To: Eric Dumazet <edumazet@google.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?5bCP5rGg5oKg55Sf?= <yuki.koike@gmo-cybersecurity.com>, 
	=?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your quick response.

The following information is based on Linux kernel version 6.12.65,
the latest release in the 6.12 tree.
The kernel config is identical to that of the kernelCTF instance
(available at: https://storage.googleapis.com/kernelctf-build/releases/lts-=
6.12.65/.config)


This type confusion occurs in several locations, including,
for example, `ipgre_header` (`header_ops->create`),
where the private data of the network device is incorrectly cast as
`struct ip_tunnel *`.

```
static int ipgre_header(struct sk_buff *skb, struct net_device *dev,
      unsigned short type,
      const void *daddr, const void *saddr, unsigned int len)
{
  struct ip_tunnel *t =3D netdev_priv(dev);
  struct iphdr *iph;
  struct gre_base_hdr *greh;
...
```

When a bond interface is given to this function,
it should not reference the private data as `struct ip_tunnel *`,
because the bond interface uses the private data as `struct bonding *`.
(quickly confirmed by seeing drivers/net/bonding/bond_netlink.c:909)

```
struct rtnl_link_ops bond_link_ops __read_mostly =3D {
    .kind            =3D "bond",
    .priv_size        =3D sizeof(struct bonding),
...
```

The stack trace below is the backtrace of all stack frame during a
call to `ipgre_header`.

```
ipgre_header at net/ipv4/ip_gre.c:890
dev_hard_header at ./include/linux/netdevice.h:3156
packet_snd at net/packet/af_packet.c:3082
packet_sendmsg at net/packet/af_packet.c:3162
sock_sendmsg_nosec at net/socket.c:729
__sock_sendmsg at net/socket.c:744
__sys_sendto at net/socket.c:2213
__do_sys_sendto at net/socket.c:2225
__se_sys_sendto at net/socket.c:2221
__x64_sys_sendto at net/socket.c:2221
do_syscall_x64 at arch/x86/entry/common.c:47
do_syscall_64 at arch/x86/entry/common.c:78
entry_SYSCALL_64 at arch/x86/entry/entry_64.S:121
```

This causes memory corruption during subsequent operations.

The following stack trace shows a General Protection Fault triggered
when sending a packet
to a bonding interface that has an IPv4 GRE interface as a slave.

```
[    1.712329] Oops: general protection fault, probably for
non-canonical address 0xdead0000cafebabe: 0000 [#1] SMP NOPTI
[    1.712972] CPU: 0 UID: 1000 PID: 205 Comm: exp Not tainted 6.12.65 #1
[    1.713344] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Arch Linux 1.17.0-2-2 04/01/2014
[    1.713890] RIP: 0010:skb_release_data+0x8a/0x1c0
[    1.714162] Code: c0 00 00 00 49 03 86 c8 00 00 00 0f b6 10 f6 c2
01 74 48 48 8b 70 28 48 85 f6 74 3f 41 0f b6 5d 00 83 e3 10 40 f6 c6
01 75 24 <48> 8b 06 ba 01 00 00 00 4c 89 f7 48 8b 00 ff d0 0f 1f 00 41
8b6
[    1.715276] RSP: 0018:ffffc900007cfcc0 EFLAGS: 00010246
[    1.715583] RAX: ffff888106fe12c0 RBX: 0000000000000010 RCX: 00000000000=
00000
[    1.716036] RDX: 0000000000000017 RSI: dead0000cafebabe RDI: ffff8881059=
c4a00
[    1.716504] RBP: ffffc900007cfe10 R08: 0000000000000010 R09: 00000000000=
00000
[    1.716955] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00002
[    1.717429] R13: ffff888106fe12c0 R14: ffff8881059c4a00 R15: ffff888106e=
57000
[    1.717866] FS:  0000000038e54380(0000) GS:ffff88813bc00000(0000)
knlGS:0000000000000000
[    1.718350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.718703] CR2: 00000000004bf480 CR3: 00000001009ec001 CR4: 00000000007=
72ef0
[    1.719109] PKRU: 55555554
[    1.719297] Call Trace:
[    1.719461]  <TASK>
[    1.719611]  sk_skb_reason_drop+0x58/0x120
[    1.719891]  packet_sendmsg+0xbcb/0x18f0
[    1.720166]  ? pcpu_alloc_area+0x186/0x260
[    1.720421]  __sys_sendto+0x1e2/0x1f0
[    1.720691]  __x64_sys_sendto+0x24/0x30
[    1.720948]  do_syscall_64+0x58/0x120
[    1.721174]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    1.721509] RIP: 0033:0x42860d
[    1.721713] Code: c3 ff ff ff ff 64 89 02 eb b9 0f 1f 00 f3 0f 1e
fa 80 3d 5d 4a 09 00 00 41 89 ca 74 20 45 31 c9 45 31 c0 b8 2c 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 6b c3 66 2e 0f 1f 84 00 00 00 00 00 55
489
[    1.722837] RSP: 002b:00007fff597e95e8 EFLAGS: 00000246 ORIG_RAX:
000000000000002c
[    1.723315] RAX: ffffffffffffffda RBX: 00000000000003e8 RCX: 00000000004=
2860d
[    1.723721] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00310
[    1.724103] RBP: 00007fff597e9880 R08: 0000000000000000 R09: 00000000000=
00000
[    1.724565] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff597=
e99f8
[    1.725010] R13: 00007fff597e9a08 R14: 00000000004b7828 R15: 00000000000=
00001
[    1.725441]  </TASK>
[    1.725594] Modules linked in:
[    1.725790] ---[ end trace 0000000000000000 ]---
[    1.726057] RIP: 0010:skb_release_data+0x8a/0x1c0
[    1.726339] Code: c0 00 00 00 49 03 86 c8 00 00 00 0f b6 10 f6 c2
01 74 48 48 8b 70 28 48 85 f6 74 3f 41 0f b6 5d 00 83 e3 10 40 f6 c6
01 75 24 <48> 8b 06 ba 01 00 00 00 4c 89 f7 48 8b 00 ff d0 0f 1f 00 41
8b6
[    1.727285] RSP: 0018:ffffc900007cfcc0 EFLAGS: 00010246
[    1.727623] RAX: ffff888106fe12c0 RBX: 0000000000000010 RCX: 00000000000=
00000
[    1.728052] RDX: 0000000000000017 RSI: dead0000cafebabe RDI: ffff8881059=
c4a00
[    1.728467] RBP: ffffc900007cfe10 R08: 0000000000000010 R09: 00000000000=
00000
[    1.728908] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00002
[    1.729323] R13: ffff888106fe12c0 R14: ffff8881059c4a00 R15: ffff888106e=
57000
[    1.729744] FS:  0000000038e54380(0000) GS:ffff88813bc00000(0000)
knlGS:0000000000000000
[    1.730236] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.730597] CR2: 00000000004bf480 CR3: 00000001009ec001 CR4: 00000000007=
72ef0
[    1.730988] PKRU: 55555554
```


2026=E5=B9=B41=E6=9C=8815=E6=97=A5(=E6=9C=A8) 20:07 Eric Dumazet <edumazet@=
google.com>:
>
> On Thu, Jan 15, 2026 at 11:33=E2=80=AFAM =E6=88=B8=E7=94=B0=E6=99=83=E5=
=A4=AA <kota.toda@gmo-cybersecurity.com> wrote:
> >
> > Hello, Eric and other maintainers,
> >
> > I hope you=E2=80=99re doing well. I=E2=80=99m following up on our email=
, sent during
> > the holiday season, in case it got buried.
> >
> > When you have a moment, could you please let us know if you had a
> > chance to review it?
> >
> > Thank you in advance, and I look forward to your response.
> >
>
> I think it would be nice to provide an actual stack trace of the bug,
> on a recent kernel tree.
>
> We had recent patches dealing with dev->hard_header_len changes.

