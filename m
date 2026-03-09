Return-Path: <netdev+bounces-265391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMk3DvJ7rmnoFAIAu9opvQ
	(envelope-from <netdev+bounces-265391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 08:51:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A873E2350BD
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 08:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA9B3081069
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 07:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA06036AB76;
	Mon,  9 Mar 2026 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CM3Z6Dxb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D77636A022
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042399; cv=pass; b=jjkrA6mFN2aZKaWugqdRWylZmGoCrGkxhM52kkAvjQ2bu7RJJ96Xexm6DRvGZrHoayM/cq8Fc+cM2qNjyQDePrHM7XSbJLUjsV8c/hUqgG0MzXP8JI3OXEoxuM1MmsGitUNtklyCFKZxWBQV8VWdKlirVrVvgVI2SJbmVFpntmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042399; c=relaxed/simple;
	bh=eacRXzXf/aiA5OgRGa3k7SPsaozGRTTdOpU1VEE4zBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJ1Prk0i1tvnREZGc0yn4H8wk8n17+I7MAqZhEc43hLa/U7YaeG6M7IJXd0ayzPOlwPB9rojavnMrvE5wy+fE9407FFnXuu6OFSi9NRMTqxI0fbbd4fo4C/BN8g9ws1JM1rZj/eam5ExaKE2C6EZhbjgaZErJts6Irg2D2xiLRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CM3Z6Dxb; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899e43ae2e1so73223136d6.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 00:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773042396; cv=none;
        d=google.com; s=arc-20240605;
        b=HQwoEaQ6g3+CMSf0IzF1QnySgld/CnVX8WdsC9LmnPzVP/5G9MQiBCOnxKYdB58bJA
         HFqAkRQ5fv+4D3BrLUIdx8v3f6wQsqTdSbVgkf4f/bTOM/KKSZgbKo1iEJcu54o1oN++
         HvhJW+YIAw81ckDji1OrDJhKHOhmhSQQ7gk9PYV+RcsGOHCTsSErJeXVU3CmYwxt8cwq
         JNAby2C1Nn9OdKMlEIfaByq6AItMVwMNWk3sdZt+oNN24NPClZ+ZoqnYkXE3XIudFiaS
         FkvnW0KbyPslOqFmUvZQHkSYK8KblTEXIEhfF1IKci84wFzX7TB5kvzck299IXJ6fqQv
         e7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dy2wEMRvx8pDR1Qm7aqueQadBuYC5mw6ZCVKfgZ4OGs=;
        fh=1sXoUbT8TE5r/mp6ip8L8fpo6P3EjOcO4D8N9Xk4tx4=;
        b=CbpxX+DjdXmZLIjtQOlySlm84S3qGjJQ/oDpMMOvIswXxAXLFwfRZFQcWUQoLpJHUy
         C5TJagl76DK8AFf3mdJHDT40ftBdC7KgUToXkRQhIMi35PrubirXkPNsOCi4OiGkMwon
         BrXb3G+eqPLoQrrT5zZooTpSNN7pFfyfK3dh2Buo+0ya0zPzlYVfLX3pdGw7QsPt6njr
         e2gB4C/7Ia7RyfL6ZKN//4H/eTmoiqpG5B972mdFbPn7GCGnArPuKPxBXQ9TtcBSeVob
         raYSoAl51mqhXM1YfK0rF1RMKBxVJGlR2pk/76qtsnt4n8lkUUZ6w3faGQ/q9oiGfMsu
         WysQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773042396; x=1773647196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dy2wEMRvx8pDR1Qm7aqueQadBuYC5mw6ZCVKfgZ4OGs=;
        b=CM3Z6Dxbp7+Ddn//y5svnSSY6FXarjiZ5dEo/L8O44/6ecvDdJr7l3fKO/ub2GD/vn
         K0M0Zo5T738xnAgeGI/y5nSSLc29XyiYCXo9cMvcremUMi46bXsze8+eIu0iSLprQ6Vg
         gSvPI7TxolYx5J/MNPxpFzEy+VF+ZavGMnVz+88jK9A/Dbc4MFvI0/PNfdg3hO27xHfT
         BqKTV/Rdzy1S+s6kCyjztP+eKdP8Cb4YdSODXIr24fLCRjr6aa/wLZZgO0V0FKXFdtbx
         NQAMNPfDtk07kpMUooAk7V8yePGa+FBZZnGq2AoR12kT8EAsgo2qM4Eb8yCaus8tC3MR
         /Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773042396; x=1773647196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dy2wEMRvx8pDR1Qm7aqueQadBuYC5mw6ZCVKfgZ4OGs=;
        b=oGOtDC77Tza31/88jyeEeJw3AzV87IkXQ37/0GivDZqs6TvXaoQnTgLj6FeoySOcWO
         z3h/segDNtxYRBZMaB4Y9uOH1KCtP5E3ntdzUpVP7uPDkNxBPYLejte1yS3qr73fPpsG
         Skm41A9GCs1leSAOsBx0R+Cnx7AXqDT3/6S01BwBeWYy/u/lNiLvUlV8VzHigp4nt+wJ
         B+NQnf+Pl9Nd3wEkEEVq+EDJk6nR1nAaiDbZr+lqJ7yw3BorbY4sUQktJW+a9uaYHnRf
         FmTcS4eHjvlzOm4nTh8GTXvpc6O2mjd95/NqD5XOuAqoSCroKvLy56u1tIUcRq3Xxb3D
         KamQ==
X-Gm-Message-State: AOJu0Yy21P9R0S4U8YcDaGSf7bTZVO3LyjKssPq8BTzhdO99MO8BI/lV
	glgID3OR+tmjNSfDjRqGAX3FTyXNMrKTHh1knOHD9LZBRtnSNFp5adJGoXjZf9NbG2egC/z3FXi
	Qjhx5JVgnlyzi/IppLX/dKJdB1WvUbHeJpCUYq9gS
X-Gm-Gg: ATEYQzz+MX7DA+VBVjSZebJ2r14bLzcVvt9W57o6VWBzarKVUnT3URnwYQUxd8tX/X3
	+ckcZjx+wCdz2LpetbhXWbVpCfBMC0E6dtRJfSYH8V5zJoytlmQGamAAbkI3unRBDNrpWzLXlO8
	ZICP5lG49wiCANYxC6FFkRM7VHonDpdFYdD9XIoZm7IP607mQtPMteHE5E6fLu5If61oIGgee41
	Bp+eHMEZax4uBOLZhNxW+EMt1JMdgxii6NsjLJPc5QJ6qKSWST7pOHxIAJ8XEFLfU9UYHYAnbjC
	BZ0SEvg=
X-Received: by 2002:a05:6214:f0e:b0:899:f691:fd3a with SMTP id
 6a1803df08f44-89a30a5ac53mr155765816d6.27.1773042395649; Mon, 09 Mar 2026
 00:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260309030702.128520-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 08:46:24 +0100
X-Gm-Features: AaiRm51LwOtGnsLFGw5-TXI1ygOjcbArZhKBv2Arly_DVU4Sw2FiUsW3cGuVy-o
Message-ID: <CANn89i+SCJmUuQo2pSVv_4YhjvXGvnGDH_HNo2XY6KxDX1Kcgg@mail.gmail.com>
Subject: Re: [PATCH net v5 0/2] net,bpf: fix null-ptr-deref in
 xdp_master_redirect() for bonding and add selftest
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, razor@blackwall.org, jiayuan.chen@shopee.com, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A873E2350BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265391-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,shopee.com,jvosburgh.net,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,google.com,linutronix.de,goodmis.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:email,linux.dev:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 4:07=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> syzkaller reported a kernel panic [1] with the following crash stack:
>
> Call Trace:
> BUG: unable to handle page fault for address: ffff8ebd08580000
> PF: supervisor write access in kernel mode
> PF: error_code(0x0002) - not-present page
> PGD 11f201067 P4D 11f201067 PUD 0
> Oops: Oops: 0002 [#1] SMP PTI
> CPU: 2 UID: 0 PID: 451 Comm: test_progs Not tainted 6.19.0+ #161 PREEMPT_=
RT
> RIP: 0010:bond_rr_gen_slave_id+0x90/0xd0
> RSP: 0018:ffffd3f4815f3448 EFLAGS: 00010246
> RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffff8ebc8728b17e
> RDX: 0000000000000000 RSI: ffffd3f4815f3538 RDI: ffff8ebc8abcce40
> RBP: ffffd3f4815f3460 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffd3f4815f3538
> R13: ffff8ebc8abcce40 R14: ffff8ebc8728b17f R15: ffff8ebc8728b170
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff8ebd08580000 CR3: 000000010a808006 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  bond_xdp_get_xmit_slave+0xc0/0x240
>  xdp_master_redirect+0x74/0xc0
>  bpf_prog_run_generic_xdp+0x2f2/0x3f0
>  do_xdp_generic+0x1fd/0x3d0
>  __netif_receive_skb_core.constprop.0+0x30d/0x1220
>  __netif_receive_skb_list_core+0xfc/0x250
>  netif_receive_skb_list_internal+0x20c/0x3d0
>  ? eth_type_trans+0x137/0x160
>  netif_receive_skb_list+0x25/0x140
>  xdp_test_run_batch.constprop.0+0x65b/0x6e0
>  bpf_test_run_xdp_live+0x1ec/0x3b0
>  bpf_prog_test_run_xdp+0x49d/0x6e0
>  __sys_bpf+0x446/0x27b0
>  __x64_sys_bpf+0x1a/0x30
>  x64_sys_call+0x146c/0x26e0
>  do_syscall_64+0xd3/0x1510
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Please, can you always provide symbols in such traces ?
You can use scripts/decode_stacktrace.sh to make the trace really
nice, instead of ugly.

>
> Problem Description
>
> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> when the bond mode is round-robin. If the bond device was never brought
> up, rr_tx_counter remains NULL.
>
> The XDP redirect path can reach this code even when the bond is not up:
> bpf_master_redirect_enabled_key is a global static key, so when any bond
> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> interception is enabled for all bond slaves system-wide.
>
> Solution
>
> Patch 1: Add a NULL check with unlikely() in bond_rr_gen_slave_id() befor=
e
> dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was never
> opened), fall back to get_random_u32() for slave selection. The existing
> allocation in bond_open() is kept, with WRITE_ONCE() added to pair with
> the READ_ONCE() in the NULL check.
> Patch 2: Add a selftest that reproduces the above scenario.
>
> Changes since v4:
> https://lore.kernel.org/netdev/20260304074301.35482-1-jiayuan.chen@linux.=
dev/
> - Reverted unconditional alloc in bond_init(); instead add a NULL check
>   with unlikely()/READ_ONCE() in bond_rr_gen_slave_id() and WRITE_ONCE()
>   in bond_open(), avoiding memory waste for non-RR modes
>   (Suggested by Nikolay Aleksandrov, patch by Jay Vosburgh)
>
> Changes since v3:
> https://lore.kernel.org/netdev/20260228021918.141002-1-jiayuan.chen@linux=
.dev/T/#t
> - Added code comment and commit log explaining why rr_tx_counter is
>   allocated unconditionally for all modes (Suggested by Jay Vosburgh)
>
> Changes since v2:
> https://lore.kernel.org/netdev/20260227092254.272603-1-jiayuan.chen@linux=
.dev/T/#t
> - Moved allocation from bond_create_init() helper into bond_init()
>   (ndo_init), which is the natural single point covering both creation
>   paths and also handles post-creation mode changes to round-robin
>
> Changes since v1:
> https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.=
dev/T/#t
> - Moved the guard for NULL rr_tx_counter from xdp_master_redirect()
>   into the bonding subsystem itself
>   (Suggested by Sebastian Andrzej Siewior <bigeasy@linutronix.de>)
>
> [1] https://syzkaller.appspot.com/bug?extid=3D80e046b8da2820b6ba73
>
> Jiayuan Chen (2):
>   bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
>   selftests/bpf: add test for xdp_master_redirect with bond not up
>
>  drivers/net/bonding/bond_main.c               |   9 +-
>  .../selftests/bpf/prog_tests/xdp_bonding.c    | 101 +++++++++++++++++-
>  2 files changed, 106 insertions(+), 4 deletions(-)
>
> --
> 2.43.0
>

