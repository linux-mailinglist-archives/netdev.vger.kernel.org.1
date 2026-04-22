Return-Path: <netdev+bounces-280507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LBWKHH56GnLSQIAu9opvQ
	(envelope-from <netdev+bounces-280507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:38:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E812C448C46
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFCDC300CA0C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A87C38422A;
	Wed, 22 Apr 2026 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="QNgpaYLP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142D382F23
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875875; cv=pass; b=hEXUJW+zDVBbToXsvjP30dYny5CZwhANmVwrCCWJ0rU/MHOA/PV+s5DH4z7AVLq4Dduaw6LOT5CARxDl0N1V3Jwbg4Y3NbyN6OwjsOm8t2SPhNZRgGECC6Xzht2kfLlHY5GX2FTOEgYG66DGYT57E/h7PwNlPaHtzeZH6dyM9SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875875; c=relaxed/simple;
	bh=O1Y7XhV/SEJMT0EYAMr1jXrv4yiLJEREcCCTIVezGTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxeBOyg8bptDSvOoIVtjPWm/+LRlJ5/nPudTbdoK7P5EDC252NfCzUi3f8T5FqB7+5lw5LWJmy+1dhA6J2NiDx0ek+sOy/oonyA39DuuEYnuF3e9bFqL9YRI0SPtXa3WgstA9gMO+AX/7NuxTsTNkI9Nbwd2qdhV5fLEK3+W86Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=QNgpaYLP; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56e91f17a99so3678560e0c.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776875872; cv=none;
        d=google.com; s=arc-20240605;
        b=CLFg2v85rzTGaHJKoZMHYOjX01tpiZTNfDVN56buh0H7UinXeMQ0vzY9gtvftQ9EVR
         AbyeSa6csPwemoF4OTqnj/eV0fyzgpsZSWMM5CN3wAvA1X4XRhP2Zp06U6MeMPvbaU9d
         uszchWz/TjrJh5ptNf9xaEA7dROuSbZLApsSZ3iazENn0TO/23+//8UwfEz5MeFzyEhB
         8GZdfZnQnWavrmbLdRN1VXeujgtUsXMPgBOToy6bPT7dQ8DgaJoCkuPIIyFChVyqore3
         ezKzHo9yqbpjsHAak+724XPiHiUNhV2EmfFOVxKeL2D2Iw1ztjV9o55/p/YxiICVoj8u
         ymRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+pI6ICe8AuxeVi/aZdscWU0aklZ+v3dI18ODCbdesmQ=;
        fh=Mi/k46xFtaw1L6Ge/q6PCztNOC4H8StGBCKOXNkhO6Q=;
        b=NRtLCSjMM+gKQeDbcnwB2sAp6EAK2L6L1fQMFScM8Rlj1vHUu5z1nO0IOAjdLslUPI
         CW1+inhS+UhcNJUmgpnXOb5ZGAoUr+sBzVb3isxcCnFFr/Su4P0BoEZQYwzd8Sxiw/n4
         rSpMs60d6MlX1yMVTKPAN6tgV6o3G7D6Td6JN2EuTcPmXMnrfPHYMWUug8smtQARm5js
         f5bHaFi8zQBsPl+j0ILRmq8cd7zV+fQD4YLs/UQ4gPTghUQVjZgaDlwLpJYV/H+f/ihM
         1IJxXK3dIyUikoo0atB0F0D5U7ucbeVYnaY9fTCLD3b8PSfCHtU/TWURqGg02+hTnSKV
         MWTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1776875872; x=1777480672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pI6ICe8AuxeVi/aZdscWU0aklZ+v3dI18ODCbdesmQ=;
        b=QNgpaYLPGahEQWZKj7gRurbduT3K1nM0vVwcga7N4mnidhWoSFBHW7t6CnIz94a/bv
         rB6jZNKnqU+8rnyyNQ1/RlOwuiJofyAHlsVI0TC/rmMUc/F7XDx4LeDgaV19+Egj2Y6Q
         t8aJ9jEmgukZ0cNz6S2ks+QxrqlJ1gP0vvoRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875872; x=1777480672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+pI6ICe8AuxeVi/aZdscWU0aklZ+v3dI18ODCbdesmQ=;
        b=HxID5jmbpzl8u/QGTEujNkqD2BfttMVQfkHlhyToawfnVRGGgiSwVJpWZFiDHw4cdz
         lqQs5mV0a1smKYialbBH1I+MF280/eVpAeTBuW8CzEE2WFpaRA7e32FRd+9//7QBMzCI
         ox+6IWI+Jz77xAF1LAgkJWVX8Jm+Ca0DGh02aRFUf7Jc5mfhnyylASTvhSfGCFS9IMCP
         xuIsd8U2X4qSvdvRX/T7ud2bcgxNrDQE3CaPc34rHA90Q1h6Rm2j1ou4Gj8JHWG6adkc
         dqRn2PthQGItnieetgEhopjjbGpaT7svb65oMFV4vcdUUOME9yOIh4lKwkVIwJVM3Kp9
         xZsQ==
X-Gm-Message-State: AOJu0YxdLgsraOU4FtBzlAesy/EG+jFpe9lhiQLFKrYyRbRwFj45kXe5
	Bqs4Kch+xFZtBnKlL/WdXTe0Fbo7rvD+a+qPAGomP49X8DoAL+CzokTkrJq5ZiVg8bcfCNurBYC
	UoaaXnTNKxUOw+/XgxizcbGILlt5tqtoJ4g+k4aMpFuqBw44/PYLclO32mQ==
X-Gm-Gg: AeBDiet3FBnrYlfoN/QANuQ2GMC+sXYyiYy57/52M9S70Z1EFa1I1QkQ6qZK9j8IiLN
	XQ/8SbqKVgk/uE/y68rnpgyvVSQw48KqJHZCLF05lBlbdfl93PR4JgdMt/19VgeNMBe3JJhO1J+
	AAXIYiwCrCT10sXDE04yO2zQjJXnlYvosJeAEZmwH4dxcSyLNN3yIEGmTlA9X/EM1k1BC+x6Re0
	ozowdPmfGOjGQowRn8/5ubjLNDaGCWa54eB0g7Gq+T3LhKXk05uzKTg3+sHILIhbnl38sX6+iUr
	wk1dQIW8sh7H5cN8QNHDYuYDyZNZ/Q==
X-Received: by 2002:a05:6122:1823:b0:56d:31e1:2c9c with SMTP id
 71dfb90a1353d-56fa5811767mr11969596e0c.3.1776875872252; Wed, 22 Apr 2026
 09:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhRvkyFrKO3O=D9YZoWWVwykCZ1-fXkzA9NyaJ8aaX9b-pcXw@mail.gmail.com>
 <2593154.1776874118@warthog.procyon.org.uk> <CAPhRvkyCQQM1cv+zQgZjbQDhQ2YVxJ26PG9UrkA6B7uTCguhPQ@mail.gmail.com>
In-Reply-To: <CAPhRvkyCQQM1cv+zQgZjbQDhQ2YVxJ26PG9UrkA6B7uTCguhPQ@mail.gmail.com>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Wed, 22 Apr 2026 13:37:40 -0300
X-Gm-Features: AQROBzAUzCAUSy6CJLnRos9ZTnoyWxRq6J21jQyNGXiBsQwIFPcsRF8SZ231jqc
Message-ID: <CAPhRvkyZGKHRTBhV3P2PCCRxmRKGEvJQ0W5a9SMW3qwS2hp2Qw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280507-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,allelesecurity.com:email,allelesecurity.com:dkim,allelesecurity.com:url,mail.gmail.com:mid,transport.family:url]
X-Rspamd-Queue-Id: E812C448C46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 1:25=E2=80=AFPM Anderson Nascimento
<anderson@allelesecurity.com> wrote:
>
> Hi David,
>
> On Wed, Apr 22, 2026 at 1:08=E2=80=AFPM David Howells <dhowells@redhat.co=
m> wrote:
> >
> > Do you by any chance have a reproducer program for this?
> >
>
> Sorry, I mixed things up and ended up sending a different reproducer.
> I do have it, I will test it now and send here in a few minutes.

You can find the reproducers below. I run them simultaneously in a
bash while loop on two different SSH shells. I can trigger running
only one server and one client, but when I discovered the bug I was
running 2 servers and 2 clients simultaneously. You can try both, and
here it doesn't take long to trigger it. My virtual machine is
configured to have 4 cores.

while true; do ./server; done
while true; do ./client; done

server.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <linux/rxrpc.h>
#include <pthread.h>

#define RXRPC_ADD_CHARGE_ACCEPT(control, ctrllen) \
do { \
struct cmsghdr *__cmsg; \
__cmsg =3D (void *)(control) + (ctrllen); \
__cmsg->cmsg_len =3D CMSG_LEN(0); \
__cmsg->cmsg_level =3D SOL_RXRPC; \
__cmsg->cmsg_type =3D RXRPC_CHARGE_ACCEPT; \
(ctrllen) +=3D __cmsg->cmsg_len; \
\
} while (0)

int sk;

void *__close(void *a){

close(sk);

return NULL;
}

int main(void){
struct sockaddr_rxrpc sockaddr_rxrpc_server;
struct msghdr msg;
struct iovec iov;
char buffer_msg_control[4096];
size_t control_len =3D 0;
pthread_t th[2];

memset(&sockaddr_rxrpc_server,'\0',sizeof(sockaddr_rxrpc_server));
memset(&buffer_msg_control,'\0',sizeof(buffer_msg_control));
memset(&msg,'\0',sizeof(msg));
memset(&iov,'\0',sizeof(iov));

sk =3D socket(AF_RXRPC, SOCK_DGRAM, PF_INET);

sockaddr_rxrpc_server.srx_family =3D AF_RXRPC;
sockaddr_rxrpc_server.srx_service =3D 1234;
sockaddr_rxrpc_server.transport_type =3D SOCK_DGRAM;
sockaddr_rxrpc_server.transport_len =3D
sizeof(sockaddr_rxrpc_server.transport.sin);

sockaddr_rxrpc_server.transport.family =3D AF_INET;
        sockaddr_rxrpc_server.transport.sin.sin_port =3D htons(7000);

bind(sk, (struct sockaddr *)&sockaddr_rxrpc_server,
sizeof(sockaddr_rxrpc_server));

listen(sk,10);

RXRPC_ADD_CHARGE_ACCEPT(buffer_msg_control, control_len);

msg.msg_control =3D buffer_msg_control;
msg.msg_controllen =3D control_len;

sendmsg(sk, &msg, 0);

pthread_create(&th[0],NULL,&__close,NULL);

pthread_join(th[0],NULL);

return 0;
}

client.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <linux/rxrpc.h>

static const unsigned char local_addr[4] =3D { 127, 0, 0, 1 };

#define RXRPC_ADD_CALLID(control, ctrllen, id) \
do { \
struct cmsghdr *__cmsg; \
__cmsg =3D (void *)(control) + (ctrllen); \
__cmsg->cmsg_len =3D CMSG_LEN(sizeof(unsigned long)); \
__cmsg->cmsg_level =3D SOL_RXRPC; \
__cmsg->cmsg_type =3D RXRPC_USER_CALL_ID; \
*(unsigned long *)CMSG_DATA(__cmsg) =3D (id); \
(ctrllen) +=3D __cmsg->cmsg_len; \
\
} while (0)

int main(void){
struct msghdr msg;
struct sockaddr_rxrpc sockaddr_rxrpc_local;
struct sockaddr_rxrpc sockaddr_rxrpc_client;
char buffer_msg_control[4096];
size_t control_len;
int sk;

memset(&sockaddr_rxrpc_local,'\0',sizeof(sockaddr_rxrpc_local));
memset(&sockaddr_rxrpc_client,'\0',sizeof(sockaddr_rxrpc_client));
memset(&buffer_msg_control,'\0',sizeof(buffer_msg_control));
memset(&msg,'\0',sizeof(msg));

sk =3D socket(AF_RXRPC, SOCK_DGRAM, PF_INET);

sockaddr_rxrpc_local.srx_family =3D AF_RXRPC;
sockaddr_rxrpc_local.srx_service =3D 0;
sockaddr_rxrpc_local.transport_type =3D SOCK_DGRAM;
sockaddr_rxrpc_local.transport_len =3D sizeof(sockaddr_rxrpc_local.transpor=
t.sin);

sockaddr_rxrpc_local.transport.family =3D AF_INET;
sockaddr_rxrpc_local.transport.sin.sin_port =3D htons(7001);

memcpy(&sockaddr_rxrpc_local.transport.sin.sin_addr, &local_addr, 4);

bind(sk, (struct sockaddr *)&sockaddr_rxrpc_local,
sizeof(sockaddr_rxrpc_local));

sockaddr_rxrpc_client.srx_family =3D AF_RXRPC;
sockaddr_rxrpc_client.srx_service =3D 1234;
sockaddr_rxrpc_client.transport_type =3D SOCK_DGRAM;
sockaddr_rxrpc_client.transport_len =3D
sizeof(sockaddr_rxrpc_client.transport.sin);
sockaddr_rxrpc_client.transport.family =3D AF_INET;
sockaddr_rxrpc_client.transport.sin.sin_port =3D htons(7000);

memcpy(&sockaddr_rxrpc_client.transport.sin.sin_addr, &local_addr, 4);

connect(sk, (struct sockaddr *)&sockaddr_rxrpc_client,
sizeof(sockaddr_rxrpc_client));

control_len =3D 0;
RXRPC_ADD_CALLID(buffer_msg_control, control_len, 0x1234);

msg.msg_control =3D buffer_msg_control;
msg.msg_controllen =3D control_len;

sendmsg(sk, &msg, 0);

return 0;
}

The report I have just triggered.

[  473.601077] rxrpc: AF_RXRPC: Leaked client conn 00000000bf02a6a7 {1}
[  473.601115] ------------[ cut here ]------------
[  473.601117] kernel BUG at net/rxrpc/conn_client.c:64!
[  473.601169] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[  473.601180] CPU: 0 UID: 0 PID: 1107239 Comm: krxrpcio/7001 Not
tainted 6.18.13-200.fc43.x86_64 #1 PREEMPT(lazy)
[  473.601193] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[  473.601205] RIP: 0010:rxrpc_purge_client_connections+0x58/0xa0 [rxrpc]
[  473.601261] Code: 28 01 00 00 00 74 25 31 c0 48 8d 74 24 0c 48 89
cf 89 44 24 0c 48 89 0c 24 e8 d4 ec c2 c1 48 89 c6 48 85 c0 0f 85 49
dd 01 00 <0f> 0b 31 f6 48 89 cf 48 89 0c 24 e8 c8 aa c4 c1 48 8b 0c 24
85 c0
[  473.601280] RSP: 0018:ffffc900159cfdd8 EFLAGS: 00010246
[  473.601288] RAX: 0000000000000000 RBX: ffff88810a6b4800 RCX: 00000000000=
00000
[  473.601297] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88810a6=
b4920
[  473.601305] RBP: ffff888123398000 R08: ffffc900159cfdb8 R09: ffff88810a6=
b4928
[  473.601313] R10: 0000000000000018 R11: 0000000040000000 R12: ffff88810a9=
cda00
[  473.601322] R13: ffff88810a6b4800 R14: ffffc900159cfe70 R15: ffff88812d0=
c2800
[  473.601330] FS:  0000000000000000(0000) GS:ffff8882af626000(0000)
knlGS:0000000000000000
[  473.601339] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  473.601347] CR2: 00007faf20630030 CR3: 000000000382e002 CR4: 00000000003=
706f0
[  473.601380] Call Trace:
[  473.601387]  <TASK>
[  473.601393]  rxrpc_destroy_local+0xc9/0xe0 [rxrpc]
[  473.601443]  rxrpc_io_thread+0x65d/0x750 [rxrpc]
[  473.601487]  ? __pfx_rxrpc_io_thread+0x10/0x10 [rxrpc]
[  473.601527]  kthread+0xfc/0x240
[  473.601536]  ? __pfx_kthread+0x10/0x10
[  473.601542]  ret_from_fork+0xf4/0x110
[  473.601550]  ? __pfx_kthread+0x10/0x10
[  473.601558]  ret_from_fork_asm+0x1a/0x30
[  473.601574]  </TASK>
[  473.601578] Modules linked in: vsock_diag fcrypt pcbc rxrpc
ip6_udp_tunnel krb5 udp_tunnel rfkill nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 nf_tables intel_rapl_msr intel_rapl_common
intel_uncore_frequency_common intel_pmc_core pmt_telemetry
pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec rapl
vmw_balloon sunrpc qrtr vmxnet3 i2c_piix4 i2c_smbus binfmt_misc joydev
loop dm_multipath nfnetlink zram lz4hc_compress lz4_compress
vmw_vsock_vmci_transport vsock vmw_vmci xfs nvme nvme_core
nvme_keyring polyval_clmulni ghash_clmulni_intel nvme_auth vmwgfx hkdf
drm_ttm_helper ata_generic ttm pata_acpi serio_raw scsi_dh_rdac
scsi_dh_emc scsi_dh_alua i2c_dev fuse
[  473.601690] ---[ end trace 0000000000000000 ]---
[  473.601698] RIP: 0010:rxrpc_purge_client_connections+0x58/0xa0 [rxrpc]
[  473.601794] Code: 28 01 00 00 00 74 25 31 c0 48 8d 74 24 0c 48 89
cf 89 44 24 0c 48 89 0c 24 e8 d4 ec c2 c1 48 89 c6 48 85 c0 0f 85 49
dd 01 00 <0f> 0b 31 f6 48 89 cf 48 89 0c 24 e8 c8 aa c4 c1 48 8b 0c 24
85 c0
[  473.601813] RSP: 0018:ffffc900159cfdd8 EFLAGS: 00010246
[  473.601820] RAX: 0000000000000000 RBX: ffff88810a6b4800 RCX: 00000000000=
00000
[  473.601829] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88810a6=
b4920
[  473.601837] RBP: ffff888123398000 R08: ffffc900159cfdb8 R09: ffff88810a6=
b4928
[  473.601845] R10: 0000000000000018 R11: 0000000040000000 R12: ffff88810a9=
cda00
[  473.602211] R13: ffff88810a6b4800 R14: ffffc900159cfe70 R15: ffff88812d0=
c2800
[  473.602599] FS:  0000000000000000(0000) GS:ffff8882af626000(0000)
knlGS:0000000000000000
[  473.603301] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  473.604869] CR2: 00007faf20630030 CR3: 000000000382e002 CR4: 00000000003=
706f0

Best regards,
--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

