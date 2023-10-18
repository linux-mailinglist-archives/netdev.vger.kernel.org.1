Return-Path: <netdev+bounces-42119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D77CD2C2
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 05:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6A12811E7
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CF153B7;
	Wed, 18 Oct 2023 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Ohi+8Lrb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5726AD6
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 03:43:53 +0000 (UTC)
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 20:43:51 PDT
Received: from mr85p00im-ztdg06021101.me.com (mr85p00im-ztdg06021101.me.com [17.58.23.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A31BA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 20:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1697600274;
	bh=5JmYFj+C6zcb0FNRY6Pmc0sarNogG/J91kTW+GmjNAg=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=Ohi+8LrbQLiW7dQd62wlUHsBKkHmfWFoBaGoGKW2OVbSXzncrIEgqA/xgZSHrLlpj
	 D9w9lTZIx7SA3qFTz3Vd7QMVYGE8HnDkYaaVWZoTKmX939BGSH03LeGJCkqsY0shpL
	 AoEmZP/LnKDrUiSlbQrngfOaEByMIZfGIREZqjko5rttTndBp/ZbAf5rZqxw2zV1B2
	 mCuzIwmJY0n1ke1RbUD6g+1iAO+Lf0LVfyN9L3wpa+pviK6Uqqx9T8UyMZFVWjcpZ6
	 uSTapqhu+N3O8MnFS4c8xpt/JCQNtvf5MJXP1nWc79DCPHIgMA73G5A5qBolBu1Eu+
	 tAGVgRmOy7N8w==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021101.me.com (Postfix) with ESMTPSA id CD0248024E;
	Wed, 18 Oct 2023 03:37:53 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2 net-next 3/8] inet: implement lockless IP_TOS
From: Christoph Paasch <christophpaasch@icloud.com>
In-Reply-To: <20230922034221.2471544-4-edumazet@google.com>
Date: Tue, 17 Oct 2023 20:37:43 -0700
Cc: David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>,
 netdev <netdev@vger.kernel.org>,
 Eric Dumazet <eric.dumazet@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC9C9B9C-6F03-4ABD-A180-95100737B2EE@icloud.com>
References: <20230922034221.2471544-1-edumazet@google.com>
 <20230922034221.2471544-4-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Proofpoint-ORIG-GUID: gPE8WDUiL6s6DECtxbWoppK66NIaTErz
X-Proofpoint-GUID: gPE8WDUiL6s6DECtxbWoppK66NIaTErz
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2310180030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Eric,

> On Sep 21, 2023, at 8:42=E2=80=AFPM, Eric Dumazet =
<edumazet@google.com> wrote:
>=20
> Some reads of inet->tos are racy.
>=20
> Add needed READ_ONCE() annotations and convert IP_TOS option lockless.
>=20
> v2: missing changes in include/net/route.h (David Ahern)
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> include/net/ip.h                              |  3 +-
> include/net/route.h                           |  4 +--
> net/dccp/ipv4.c                               |  2 +-
> net/ipv4/inet_diag.c                          |  2 +-
> net/ipv4/ip_output.c                          |  4 +--
> net/ipv4/ip_sockglue.c                        | 29 ++++++++-----------
> net/ipv4/tcp_ipv4.c                           |  9 +++---
> net/mptcp/sockopt.c                           |  8 ++---
> net/sctp/protocol.c                           |  4 +--
> .../selftests/net/mptcp/mptcp_connect.sh      |  2 +-
> 10 files changed, 31 insertions(+), 36 deletions(-)

This patch causes a NULL-pointer deref in my syzkaller instances:

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 12bad6067 P4D 12bad6067 PUD 12bad5067 PMD 0=20
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 2750 Comm: syz-executor.5 Not tainted =
6.6.0-rc4-g7a5720a344e7 #49
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 =
04/01/2014
RIP: 0010:tcp_get_metrics+0x118/0x8f0 net/ipv4/tcp_metrics.c:321
Code: c7 44 24 70 02 00 8b 03 89 44 24 48 c7 44 24 4c 00 00 00 00 66 c7 =
44 24 58 02 00 66 ba 02 00 b1 01 89 4c 24 04 4c 89 7c 24 10 <49> 8b 0f =
48 8b 89 50 05 00 00 48 89 4c 24 30 33 81 00 02 00 00 69
RSP: 0018:ffffc90000af79b8 EFLAGS: 00010293
RAX: 000000000100007f RBX: ffff88812ae8f500 RCX: ffff88812b5f8f01
RDX: 0000000000000002 RSI: ffffffff8300f080 RDI: 0000000000000002
RBP: 0000000000000002 R08: 0000000000000003 R09: ffffffff8205eca0
R10: 0000000000000002 R11: ffff88812b5f8f00 R12: ffff88812a9e0580
R13: 0000000000000000 R14: ffff88812ae8fbd2 R15: 0000000000000000
FS: 00007f70a006b640(0000) GS:ffff88813bd00000(0000) =
knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000012bad7003 CR4: 0000000000170ee0
Call Trace:
<TASK>
tcp_fastopen_cache_get+0x32/0x140 net/ipv4/tcp_metrics.c:567
tcp_fastopen_cookie_check+0x28/0x180 net/ipv4/tcp_fastopen.c:419
tcp_connect+0x9c8/0x12a0 net/ipv4/tcp_output.c:3839
tcp_v4_connect+0x645/0x6e0 net/ipv4/tcp_ipv4.c:323
__inet_stream_connect+0x120/0x590 net/ipv4/af_inet.c:676
tcp_sendmsg_fastopen+0x2d6/0x3a0 net/ipv4/tcp.c:1021
tcp_sendmsg_locked+0x1957/0x1b00 net/ipv4/tcp.c:1073
tcp_sendmsg+0x30/0x50 net/ipv4/tcp.c:1336
__sock_sendmsg+0x83/0xd0 net/socket.c:730
__sys_sendto+0x20a/0x2a0 net/socket.c:2194
__do_sys_sendto net/socket.c:2206 [inline]
__se_sys_sendto net/socket.c:2202 [inline]
__x64_sys_sendto+0x28/0x30 net/socket.c:2202
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x47/0xa0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x6e/0xd8

The reason is that setting IP_TOS calls sk_reset_dst, which then causes =
these issues in the places where we assume that the dst in the socket is =
set (specifically, the tcp_connect-path).

Here is the syzkaller reproducer:

# {Threaded:true Repeat:true RepeatTimes:0 Procs:1 Slowdown:1 =
Sandbox:none SandboxArg:0 Leak:false NetInjection:false NetDevices:true =
NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:true KCSAN:false =
DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false =
IEEE802154:false Sysctl:false Swap:false UseTmpDir:false =
HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false =
Fault:false FaultCall:0 FaultNth:0}}
r0 =3D socket$inet(0x2, 0x1, 0x0)
sendto$inet(r0, 0x0, 0x0, 0x20000841, &(0x7f0000000080)=3D{0x2, 0x4e20, =
@dev=3D{0xac, 0x14, 0x14, 0x15}}, 0x10) (async)
setsockopt$inet_int(r0, 0x0, 0x1, &(0x7f00000002c0)=3D0x81, 0x4)


Cheers,
Christoph

>=20
> diff --git a/include/net/ip.h b/include/net/ip.h
> index =
46933a0d98eac2db40c2e88006125588b8f8143e..6fbc0dcf4b9780d60b5e5d6f84d6017f=
bf57d0ae 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -258,7 +258,7 @@ static inline u8 ip_sendmsg_scope(const struct =
inet_sock *inet,
>=20
> static inline __u8 get_rttos(struct ipcm_cookie* ipc, struct inet_sock =
*inet)
> {
> - return (ipc->tos !=3D -1) ? RT_TOS(ipc->tos) : RT_TOS(inet->tos);
> + return (ipc->tos !=3D -1) ? RT_TOS(ipc->tos) : =
RT_TOS(READ_ONCE(inet->tos));
> }
>=20
> /* datagram.c */
> @@ -810,6 +810,5 @@ int ip_sock_set_mtu_discover(struct sock *sk, int =
val);
> void ip_sock_set_pktinfo(struct sock *sk);
> void ip_sock_set_recverr(struct sock *sk);
> void ip_sock_set_tos(struct sock *sk, int val);
> -void  __ip_sock_set_tos(struct sock *sk, int val);
>=20
> #endif /* _IP_H */
> diff --git a/include/net/route.h b/include/net/route.h
> index =
51a45b1887b562bfb473f9f8c50897d5d3073476..5c248a8e3d0e3ed757ad95f546032c2c=
49729eec 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -37,7 +37,7 @@
>=20
> #define RTO_ONLINK 0x01
>=20
> -#define RT_CONN_FLAGS(sk)   (RT_TOS(inet_sk(sk)->tos) | sock_flag(sk, =
SOCK_LOCALROUTE))
> +#define RT_CONN_FLAGS(sk)   (RT_TOS(READ_ONCE(inet_sk(sk)->tos)) | =
sock_flag(sk, SOCK_LOCALROUTE))
> #define RT_CONN_FLAGS_TOS(sk,tos)   (RT_TOS(tos) | sock_flag(sk, =
SOCK_LOCALROUTE))
>=20
> static inline __u8 ip_sock_rt_scope(const struct sock *sk)
> @@ -50,7 +50,7 @@ static inline __u8 ip_sock_rt_scope(const struct =
sock *sk)
>=20
> static inline __u8 ip_sock_rt_tos(const struct sock *sk)
> {
> - return RT_TOS(inet_sk(sk)->tos);
> + return RT_TOS(READ_ONCE(inet_sk(sk)->tos));
> }
>=20
> struct ip_tunnel_info;
> diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
> index =
69453b936bd557c77a790a27ff64cc91e5a58296..1b8cbfda6e5dbd098a58d92639a64bc8=
db83ff23 100644
> --- a/net/dccp/ipv4.c
> +++ b/net/dccp/ipv4.c
> @@ -511,7 +511,7 @@ static int dccp_v4_send_response(const struct sock =
*sk, struct request_sock *req
> err =3D ip_build_and_send_pkt(skb, sk, ireq->ir_loc_addr,
>    ireq->ir_rmt_addr,
>    rcu_dereference(ireq->ireq_opt),
> -    inet_sk(sk)->tos);
> +    READ_ONCE(inet_sk(sk)->tos));
> rcu_read_unlock();
> err =3D net_xmit_eval(err);
> }
> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index =
e13a84433413ed88088435ff8e11efeb30fc3cca..1f2d7a8bd060e59baeb00fcb1c6aabfc=
b3bb213d 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -134,7 +134,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, =
struct sk_buff *skb,
> * hence this needs to be included regardless of socket family.
> */
> if (ext & (1 << (INET_DIAG_TOS - 1)))
> - if (nla_put_u8(skb, INET_DIAG_TOS, inet->tos) < 0)
> + if (nla_put_u8(skb, INET_DIAG_TOS, READ_ONCE(inet->tos)) < 0)
> goto errout;
>=20
> #if IS_ENABLED(CONFIG_IPV6)
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index =
2be281f184a5fe5a695ccd51fabe69fa45bea0b8..85320f92e8363d59e92c54139044cbab=
7e0561fa 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -544,7 +544,7 @@ EXPORT_SYMBOL(__ip_queue_xmit);
>=20
> int ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi =
*fl)
> {
> - return __ip_queue_xmit(sk, skb, fl, inet_sk(sk)->tos);
> + return __ip_queue_xmit(sk, skb, fl, READ_ONCE(inet_sk(sk)->tos));
> }
> EXPORT_SYMBOL(ip_queue_xmit);
>=20
> @@ -1438,7 +1438,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
> iph =3D ip_hdr(skb);
> iph->version =3D 4;
> iph->ihl =3D 5;
> - iph->tos =3D (cork->tos !=3D -1) ? cork->tos : inet->tos;
> + iph->tos =3D (cork->tos !=3D -1) ? cork->tos : READ_ONCE(inet->tos);
> iph->frag_off =3D df;
> iph->ttl =3D ttl;
> iph->protocol =3D sk->sk_protocol;
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index =
6d874cc03c8b4e88d79ebc50a6db105606b6ae60..50c008efbb6de7303621dd30b178c90c=
b3f5a2fc 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -585,25 +585,20 @@ int ip_recv_error(struct sock *sk, struct msghdr =
*msg, int len, int *addr_len)
> return err;
> }
>=20
> -void __ip_sock_set_tos(struct sock *sk, int val)
> +void ip_sock_set_tos(struct sock *sk, int val)
> {
> + u8 old_tos =3D READ_ONCE(inet_sk(sk)->tos);
> +
> if (sk->sk_type =3D=3D SOCK_STREAM) {
> val &=3D ~INET_ECN_MASK;
> - val |=3D inet_sk(sk)->tos & INET_ECN_MASK;
> + val |=3D old_tos & INET_ECN_MASK;
> }
> - if (inet_sk(sk)->tos !=3D val) {
> - inet_sk(sk)->tos =3D val;
> + if (old_tos !=3D val) {
> + WRITE_ONCE(inet_sk(sk)->tos, val);
> WRITE_ONCE(sk->sk_priority, rt_tos2priority(val));
> sk_dst_reset(sk);
> }
> }
> -
> -void ip_sock_set_tos(struct sock *sk, int val)
> -{
> - lock_sock(sk);
> - __ip_sock_set_tos(sk, val);
> - release_sock(sk);
> -}
> EXPORT_SYMBOL(ip_sock_set_tos);
>=20
> void ip_sock_set_freebind(struct sock *sk)
> @@ -1050,6 +1045,9 @@ int do_ip_setsockopt(struct sock *sk, int level, =
int optname,
> return 0;
> case IP_MTU_DISCOVER:
> return ip_sock_set_mtu_discover(sk, val);
> + case IP_TOS: /* This sets both TOS and Precedence */
> + ip_sock_set_tos(sk, val);
> + return 0;
> }
>=20
> err =3D 0;
> @@ -1104,9 +1102,6 @@ int do_ip_setsockopt(struct sock *sk, int level, =
int optname,
> }
> }
> break;
> - case IP_TOS: /* This sets both TOS and Precedence */
> - __ip_sock_set_tos(sk, val);
> - break;
> case IP_UNICAST_IF:
> {
> struct net_device *dev =3D NULL;
> @@ -1593,6 +1588,9 @@ int do_ip_getsockopt(struct sock *sk, int level, =
int optname,
> case IP_MTU_DISCOVER:
> val =3D READ_ONCE(inet->pmtudisc);
> goto copyval;
> + case IP_TOS:
> + val =3D READ_ONCE(inet->tos);
> + goto copyval;
> }
>=20
> if (needs_rtnl)
> @@ -1629,9 +1627,6 @@ int do_ip_getsockopt(struct sock *sk, int level, =
int optname,
> return -EFAULT;
> return 0;
> }
> - case IP_TOS:
> - val =3D inet->tos;
> - break;
> case IP_MTU:
> {
> struct dst_entry *dst;
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index =
f13eb7e23d03f3681055257e6ebea0612ae3f9b3..1f89ba58e71eff74d8ed75019de9e70d=
2f4d5926 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1024,10 +1024,11 @@ static int tcp_v4_send_synack(const struct =
sock *sk, struct dst_entry *dst,
> if (skb) {
> __tcp_v4_send_check(skb, ireq->ir_loc_addr, ireq->ir_rmt_addr);
>=20
> - tos =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reflect_tos) ?
> - (tcp_rsk(req)->syn_tos & ~INET_ECN_MASK) |
> - (inet_sk(sk)->tos & INET_ECN_MASK) :
> - inet_sk(sk)->tos;
> + tos =3D READ_ONCE(inet_sk(sk)->tos);
> +
> + if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reflect_tos))
> + tos =3D (tcp_rsk(req)->syn_tos & ~INET_ECN_MASK) |
> +      (tos & INET_ECN_MASK);
>=20
> if (!INET_ECN_is_capable(tos) &&
>    tcp_bpf_ca_needs_ecn((struct sock *)req))
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index =
8260202c00669fd7d2eed2f94a3c2cf225a0d89c..155e8472ba9b83c35c6f827b2bb35c0b=
e4127917 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -734,11 +734,11 @@ static int mptcp_setsockopt_v4_set_tos(struct =
mptcp_sock *msk, int optname,
>=20
> lock_sock(sk);
> sockopt_seq_inc(msk);
> - val =3D inet_sk(sk)->tos;
> + val =3D READ_ONCE(inet_sk(sk)->tos);
> mptcp_for_each_subflow(msk, subflow) {
> struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>=20
> - __ip_sock_set_tos(ssk, val);
> + ip_sock_set_tos(ssk, val);
> }
> release_sock(sk);
>=20
> @@ -1343,7 +1343,7 @@ static int mptcp_getsockopt_v4(struct mptcp_sock =
*msk, int optname,
>=20
> switch (optname) {
> case IP_TOS:
> - return mptcp_put_int_option(msk, optval, optlen, inet_sk(sk)->tos);
> + return mptcp_put_int_option(msk, optval, optlen, =
READ_ONCE(inet_sk(sk)->tos));
> }
>=20
> return -EOPNOTSUPP;
> @@ -1411,7 +1411,7 @@ static void sync_socket_options(struct =
mptcp_sock *msk, struct sock *ssk)
> ssk->sk_bound_dev_if =3D sk->sk_bound_dev_if;
> ssk->sk_incoming_cpu =3D sk->sk_incoming_cpu;
> ssk->sk_ipv6only =3D sk->sk_ipv6only;
> - __ip_sock_set_tos(ssk, inet_sk(sk)->tos);
> + ip_sock_set_tos(ssk, inet_sk(sk)->tos);
>=20
> if (sk->sk_userlocks & tx_rx_locks) {
> ssk->sk_userlocks |=3D sk->sk_userlocks & tx_rx_locks;
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index =
2185f44198deb002bc8ed7f1b0f3fe02d6bb9f09..94c6dd53cd62d1fa6236d07946e8d5ff=
68eb587d 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -426,7 +426,7 @@ static void sctp_v4_get_dst(struct sctp_transport =
*t, union sctp_addr *saddr,
> struct dst_entry *dst =3D NULL;
> union sctp_addr *daddr =3D &t->ipaddr;
> union sctp_addr dst_saddr;
> - __u8 tos =3D inet_sk(sk)->tos;
> + u8 tos =3D READ_ONCE(inet_sk(sk)->tos);
>=20
> if (t->dscp & SCTP_DSCP_SET_MASK)
> tos =3D t->dscp & SCTP_DSCP_VAL_MASK;
> @@ -1057,7 +1057,7 @@ static inline int sctp_v4_xmit(struct sk_buff =
*skb, struct sctp_transport *t)
> struct flowi4 *fl4 =3D &t->fl.u.ip4;
> struct sock *sk =3D skb->sk;
> struct inet_sock *inet =3D inet_sk(sk);
> - __u8 dscp =3D inet->tos;
> + __u8 dscp =3D READ_ONCE(inet->tos);
> __be16 df =3D 0;
>=20
> pr_debug("%s: skb:%p, len:%d, src:%pI4, dst:%pI4\n", __func__, skb,
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh =
b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index =
b1fc8afd072dc6ddde8d561a675a5549a9a37dba..61a2a1988ce69ffa17e0dd8e629eac55=
0f4f7d99 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -716,7 +716,7 @@ run_test_transparent()
> # the required infrastructure in MPTCP sockopt code. To support TOS, =
the
> # following function has been exported (T). Not great but better than
> # checking for a specific kernel version.
> - if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
> + if ! mptcp_lib_kallsyms_has "T ip_sock_set_tos$"; then
> echo "INFO: ${msg} not supported by the kernel: SKIP"
> mptcp_lib_result_skip "${TEST_GROUP}"
> return
> --=20
> 2.42.0.515.g380fc7ccd1-goog
>=20
>=20


