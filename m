Return-Path: <netdev+bounces-280483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DxAOHn36GlYSQIAu9opvQ
	(envelope-from <netdev+bounces-280483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:29:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC69448A97
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 739C3313D136
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7524237CD3C;
	Wed, 22 Apr 2026 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="gqsFv7Ch"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C537CD5F
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874715; cv=pass; b=srW/mzIw5nFXxNp148p+IO6M3dajVds+fwjXPYJTYvb6sfcXdJboL6VOJarv62KQFduHLT6JVjUM8aoocdRRWStHBLBnM5Ljmh2gHxmPRExSKNMJhFD3w/6vZshxEWBjgkZqc5Q00j8xuIJdkRYfEok4owbbh82gfClCbR/K3EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874715; c=relaxed/simple;
	bh=oDvmun/mpkbdFe5KbfiOqQ5qbkZGf6LIMQ199FbfwvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gs18XAXGdjhMNIHHXZOq38/sUrKUnViPgO0GFKfxdjsxcpm4DY6Ah6L3B54ZOKiUG6nTINiphuwlVrOPZi7ALJ0thMSWiLQVMmnzClDYen4Esfy4bmZqgiKZ+DgUtJWhJbLaDUOzkjroMa56yrjArNE/6K4eAnrUWPwsHOgKQmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=gqsFv7Ch; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso3544738e0c.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776874711; cv=none;
        d=google.com; s=arc-20240605;
        b=P2H0nNY6rinC1W8lp0SWQUOff8QXjYO4iRhPO8zv++wqjDUT6Tf+XTF0MRwwJUFHYH
         oy2cmUt2dBNy5MM/z2aUv8e9L4thwPUfKN0RTvuNFcCfbabdmA6n0M2tHDFDe4xlrXkr
         M/qdkgxx5F9McJahI++Gxq44PBuPFWU7v0g1XHrT5ZfkYBU4wd8zZs6iQ/1pEVCplez2
         3pLWa3ApdrL4h9Q3jnl5dwdmdtAkoH+DH0MCnvxKvDI5j+agG785ukDugcH6QEIPF983
         WHFJdUGQAf4NSN8ta1vs7FWgLxzKZQpy5TG4y88EXXy4xW2KSIh3AXbGpjjymDd+5Y5N
         lSVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hw04PJ1Olfth6P5lyuNSXVnKzJGrw6fCD1UCZ291rDM=;
        fh=Mi/k46xFtaw1L6Ge/q6PCztNOC4H8StGBCKOXNkhO6Q=;
        b=VnbuFNARt2TwUS4o5GUS9rxRZC2KsOQ1xp339UKbJIGEV1jFKgc5wtVjxNGS28q+eo
         z/RjB4TGKrNan5R2D9ZSuD/iRbJpYPZFFRAK35DYiCgayrDl1P/Mg4oZfenmcGyd56F1
         UnyNZCzQ3ikw7k0fzp9r55a99XkcEBklSEWZwP/vyqr44u2+lqXzoYWO78OpOuyvAHjV
         fgfexmEu1O++1Yq4UaFgf2ttI5CAwdQxGWGjPJfI1wylUT3j/CBN5A2YxP3Atwm75KIZ
         RlQ/7QPGUSHQZkAU71Qt80P2gY2ycahSBOiQZfuVrLiVUKStbZRIwj5nHH5kaxqhTe85
         GQxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1776874711; x=1777479511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hw04PJ1Olfth6P5lyuNSXVnKzJGrw6fCD1UCZ291rDM=;
        b=gqsFv7Ch31RsjPWqiUEmWCl9Rp04i+qTQ3qqEND7YllSoDj3XEbCep+xImy5kxZlql
         h+8Bq9/+0ZJ9qujOHqMjlgfg9Otav4Oay37iqFDm0XgpxzAeTpQdcXv7ZHLPaPvVc7Nk
         +8Bsr0/zNo7xIf4XCPgkM/NdxlDoReW5zn3ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776874711; x=1777479511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hw04PJ1Olfth6P5lyuNSXVnKzJGrw6fCD1UCZ291rDM=;
        b=BM8/Bc/bp3yV/ufvY1mNpKztUIEK4Xj5p7JJBdTs1EdvVLB6pdP28x/7vYJ1tqzR/C
         kLjFtzmNvSzsJSVDqyUEdUcZup0sJkPSF+qOKvGLk5tKROIsMfNMJ1/GPsd4LO5dEkz9
         Tf2Iu827uZXWtwcF7X3j1UZS6f4M+XBVKxdawcuMS0/nw8tCut0t2QzcFQJ0QYhhamXa
         UpU3xRcz6jk542D1SYcEk+KYB9dn4yeLB4GFqLu7of3IoDprCKhsS58a+YL0s/3FmmNb
         v0oEbqLIRkHE26S7Gkmr5SURy3vt00QuBfmVwLFQzxwaRWj+vLFrsVfszC5wtwgyTbjv
         9bOw==
X-Gm-Message-State: AOJu0YypPsDK1gzcBWVfLnfHYZuUKDU7vuUNtX1GZjde9DQOidE9BEQG
	oK4YRFu7yrGbNKNZA6Z1krIW0fjK8BOkuhyKvM8yfHGe8L7H6Y+spK0yV5EX4RSnL2iw+fwJQYO
	X4cHoQ/t4XgDiqi1jS75JWK2hRaAL4YQ3qDmhVUuAww==
X-Gm-Gg: AeBDievW+jJPF6vjTGxLe6ioZFzZpuMRyKPz/JP3/aUyO0tiVN/VSLoX6oUloMwdyQx
	BtOf7lgfQRW8RINf3S68WkhczPgWIlzxOg3ybjZdUACcUJsfmnDrK6LI/EhuPMU444UFLCFc6p3
	u8KE/LPxewNk7rx8a/bWnm5ZZp+fiHCgMimnDv0IlOOvAcr3A/KvQmb9mO2GazOzbpEOrfI6jwq
	J6uNEhRIzN05/nffG/VvfnWZY/Ba7zaX3MI3Ut0FEM3fn+6k6wgbcItq5apy7NonUd6lGN6ElL4
	rFZnC/qOkaPZH8vs9Uk=
X-Received: by 2002:a05:6122:1aaa:b0:56b:7023:1393 with SMTP id
 71dfb90a1353d-56fa59be5eemr9209709e0c.11.1776874710598; Wed, 22 Apr 2026
 09:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhRvkyFrKO3O=D9YZoWWVwykCZ1-fXkzA9NyaJ8aaX9b-pcXw@mail.gmail.com>
 <2593154.1776874118@warthog.procyon.org.uk>
In-Reply-To: <2593154.1776874118@warthog.procyon.org.uk>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Wed, 22 Apr 2026 13:18:19 -0300
X-Gm-Features: AQROBzDqRZtKH5nbThwKf17GaU0jKhFZgWmjpHgIeRh1F0zIKPhf4NHlR7ZdYmA
Message-ID: <CAPhRvkxnyd0Xe_cCuw47Y78-tLKwLNmhM-AQKekwQnTjt_37Lg@mail.gmail.com>
Subject: Re: [BUG] rxrpc: Client connection leak and BUG() call during kernel
 IO thread exit
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	Jeffrey Altman <jaltman@auristor.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[allelesecurity.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280483-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,allelesecurity.com:dkim,allelesecurity.com:url,0.0.0.2:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2FC69448A97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

On Wed, Apr 22, 2026 at 1:08=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Do you by any chance have a reproducer program for this?

Yes, you can find it below. The code is not polished, but it works.

> David
>

#include <stdio.h>
#include <string.h>
#include <keyutils.h>

struct rxrpc_key_data_v1 {
uint16_t             security_index;
uint16_t             ticket_length;
uint32_t             expiry;
uint32_t             kvno;
uint8_t              session_key[8];
uint8_t              ticket[];
};

#define TICKET_LENGTH 16349

int main(int argc,char *argv[]){
struct rxrpc_key_data_v1 *v1;
key_serial_t key;
char *key_description =3D "afs@2";
char payload[16384 + 4 + 100];
char ticket[16384 + 4];
char session_key[8];
unsigned int plen;
uint32_t kver =3D 1;

memset(&payload, '\0', sizeof(payload));
memset(&ticket, '\0', sizeof(ticket));
memset(&session_key, '\0', sizeof(session_key));
memcpy(&payload, &kver, sizeof(kver));

v1 =3D (struct rxrpc_key_data_v1 *)((char *)&payload + sizeof(kver));

v1->security_index =3D 2;
v1->ticket_length =3D TICKET_LENGTH;
v1->kvno =3D 1;

memcpy(v1->session_key, session_key, sizeof(v1->session_key));
memcpy(v1->ticket, &ticket, TICKET_LENGTH);

plen =3D sizeof(kver) + sizeof(struct rxrpc_key_data_v1) + TICKET_LENGTH;

key =3D add_key("rxrpc", key_description, payload, plen,
KEY_SPEC_PROCESS_KEYRING);

keyctl(KEYCTL_READ, key, payload, 4096);

return 0;
}

It generates the following splat.

[  123.636173] ------------[ cut here ]------------
[  123.636176] WARNING: CPU: 2 PID: 1528 at net/rxrpc/key.c:778
rxrpc_read+0x109/0x5c0 [rxrpc]
[  123.636214] Modules linked in: fcrypt pcbc rxrpc ip6_udp_tunnel
krb5 udp_tunnel rfkill nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
nf_tables intel_rapl_msr intel_rapl_common
intel_uncore_frequency_common intel_pmc_core pmt_telemetry
pmt_discovery pmt_class qrtr intel_pmc_ssram_telemetry intel_vsec rapl
vmw_balloon sunrpc vmxnet3 i2c_piix4 i2c_smbus binfmt_misc joydev loop
dm_multipath nfnetlink zram lz4hc_compress lz4_compress
vmw_vsock_vmci_transport vsock vmw_vmci xfs nvme nvme_core
polyval_clmulni ghash_clmulni_intel nvme_keyring vmwgfx nvme_auth hkdf
drm_ttm_helper ata_generic pata_acpi ttm serio_raw scsi_dh_rdac
scsi_dh_emc scsi_dh_alua i2c_dev fuse
[  123.636257] CPU: 2 UID: 1000 PID: 1528 Comm: poc Not tainted
6.18.13-200.fc43.x86_64 #1 PREEMPT(lazy)
[  123.636259] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[  123.636260] RIP: 0010:rxrpc_read+0x109/0x5c0 [rxrpc]
[  123.636284] Code: 03 66 83 f8 02 0f 85 5e 02 00 00 80 7b 02 00 74
9f f6 05 89 df 2a 00 04 0f 85 87 58 01 00 b8 28 00 00 00 b9 24 00 00
00 eb b1 <0f> 0b 48 c7 c0 fb ff ff ff 48 8b 54 24 40 65 48 2b 15 19 da
ea c3
[  123.636285] RSP: 0018:ffffc9000274bc70 EFLAGS: 00010202
[  123.636287] RAX: ffff8881082e0000 RBX: ffff888104a78e20 RCX: 00000000000=
00000
[  123.636288] RDX: 0000000000000000 RSI: ffff88810aeac000 RDI: ffff8881037=
bf1f4
[  123.636289] RBP: 0000000000004004 R08: 0000000000001000 R09: 00000000000=
00001
[  123.636289] R10: 0000000000000004 R11: ffff88810aeac000 R12: 00000000000=
00010
[  123.636290] R13: ffff88810aeac000 R14: 0000000000001000 R15: ffff8881023=
e9f00
[  123.636291] FS:  00007f6f8611d740(0000) GS:ffff8882af726000(0000)
knlGS:0000000000000000
[  123.636293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  123.636293] CR2: 00007fff0bf73000 CR3: 0000000108146006 CR4: 00000000003=
706f0
[  123.636312] Call Trace:
[  123.636314]  <TASK>
[  123.636316]  ? keyctl_read_key+0xec/0x230
[  123.636320]  keyctl_read_key+0x131/0x230
[  123.636322]  do_syscall_64+0x7e/0x7f0
[  123.636325]  ? __folio_mod_stat+0x2d/0x90
[  123.636328]  ? set_ptes.isra.0+0x36/0x80
[  123.636329]  ? do_anonymous_page+0x100/0x520
[  123.636332]  ? __handle_mm_fault+0x551/0x6a0
[  123.636334]  ? count_memcg_events+0xd6/0x220
[  123.636337]  ? handle_mm_fault+0x248/0x360
[  123.636339]  ? do_user_addr_fault+0x21a/0x690
[  123.636341]  ? clear_bhb_loop+0x50/0xa0
[  123.636344]  ? clear_bhb_loop+0x50/0xa0
[  123.636345]  ? clear_bhb_loop+0x50/0xa0
[  123.636346]  ? clear_bhb_loop+0x50/0xa0
[  123.636347]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  123.636349] RIP: 0033:0x7f6f8621338d
[  123.636356] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 43 5a 0f 00 f7 d8 64 89
01 48
[  123.636357] RSP: 002b:00007fff0bf70528 EFLAGS: 00000246 ORIG_RAX:
00000000000000fa
[  123.636358] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6f862=
1338d
[  123.636359] RDX: 00007fff0bf74640 RSI: 000000003809ba43 RDI: 00000000000=
0000b
[  123.636360] RBP: 00007fff0bf70600 R08: 00000000fffffffe R09: 00000030000=
00008
[  123.636361] R10: 0000000000001000 R11: 0000000000000246 R12: 00007fff0bf=
787e8
[  123.636362] R13: 0000000000000001 R14: 00007f6f86361000 R15: 00000000004=
02df0
[  123.636364]  </TASK>
[  123.636365] ---[ end trace 0000000000000000 ]---




--
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

