Return-Path: <netdev+bounces-34007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1D77A164F
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 08:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB941C20929
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 06:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18696122;
	Fri, 15 Sep 2023 06:45:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEFF2591
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 06:45:22 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606A3CCD
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 23:45:20 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-415155b2796so147971cf.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694760319; x=1695365119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvwiqqx7BcBIIqhMe2ijZb4+H4pqKVV4KLfWr6jeEvA=;
        b=b4C1bYPXUd2B5pzJ5gQJOUWdYVPmchNzIw17+Lc9OWbZ53Gh3r6DTqtP0Ztx5uKNwD
         8Nh/8nPWFu+0K5LGYEbDxNCvUfM9Vp2WHniZxJGleguUt30GDAJiU9NbvTvbk7Plqh0l
         iIrjxy5B7Zu1gLPNW9ahBGWgm8iWu+6m/A6kBWgewXvYyZMTl85JQNeTpK9GR3unRmHd
         jpNznckGuKi2r9tQncSk7IckibUvm9lwbRs/FN0Jy0SaxIeY87hXkRFr/P1/m7GsSfhX
         dZLvldFleWMtGWaiqZMs3tbLM7dpCpaq6nLCNyFYUgHq/cdUFfggHZEuN/+RB5UcR6uP
         F+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694760319; x=1695365119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvwiqqx7BcBIIqhMe2ijZb4+H4pqKVV4KLfWr6jeEvA=;
        b=Q+PhJPnKUenGSMGA8c4iPbOuuzijV50rRP6jTmq+qrGdW+E9e6gQSmlIGcZBIet7+R
         fuhwRe5yxwdjmwRuEatl6P9WjJKs7EJzO3fhZYerWTitinGsaaJXNn4MMwCz5FK2NsQj
         4KvIKHd3/HryblpkdPwJSUgt6HmBN6gBQSARKixyF6Z7hlmbjsD7YjvKgiM/SzJhtBHT
         kvNvPiUI9KG/KVbl+NkJ8FJiJXjb2MZpqdZgO8CUkzajlRjvVd89jntHA2FbIqsrJJ+Q
         WErLAvK4994uhQ/ON28oLHw6evw7TGs9lg/zZOK2DEpCgfLtJuMxerLOXNQkT8hRM/S3
         3OUg==
X-Gm-Message-State: AOJu0YzLGCEL6p0rZsis7TDzGH8PQ/UdesJOQV0HbAhNXZjV5jJR2k+U
	KlyAs6iOayzWQFfdfIAsYrz55EZFImVaMeNR5l9cFg==
X-Google-Smtp-Source: AGHT+IE8dhLna9CPA/02i1/GKpBBcS0I/fWlPfIklbqb7uegAO76G+g1VGPsIznVndDoGYorOjRYU/ujbWeZaw/HzJ4=
X-Received: by 2002:ac8:5847:0:b0:3f5:2006:50f1 with SMTP id
 h7-20020ac85847000000b003f5200650f1mr203977qth.12.1694760319240; Thu, 14 Sep
 2023 23:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
In-Reply-To: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 Sep 2023 08:45:07 +0200
Message-ID: <CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2jypN_Qf9oojw@mail.gmail.com>
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
To: Martin Zaharinov <micron10@gmail.com>
Cc: netdev <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, kuba+netdrv@kernel.org, dsahern@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 6:05=E2=80=AFAM Martin Zaharinov <micron10@gmail.co=
m> wrote:
>
> Hi All
> This is report from kernel 6.5.2 after 4 day up system hang and reboot af=
ter this error :
>
>
>
> Sep 15 04:32:29 205.254.184.12 [399661.971344][   C31] kernel tried to ex=
ecute NX-protected page - exploit attempt? (uid: 0)
> Sep 15 04:32:29 205.254.184.12 [399661.971470][   C31] BUG: unable to han=
dle page fault for address: ffffa10c52d43058
> Sep 15 04:32:29 205.254.184.12 [399661.971586][   C31] #PF: supervisor in=
struction fetch in kernel mode
> Sep 15 04:32:29 205.254.184.12 [399661.971680][   C31] #PF: error_code(0x=
0011) - permissions violation
> Sep 15 04:32:29 205.254.184.12 [399661.971775][   C31] PGD 12601067 P4D 1=
2601067 PUD 80000002400001e3
> Sep 15 04:32:29 205.254.184.12 [399661.971871][   C31] Oops: 0011 [#1] PR=
EEMPT SMP
> Sep 15 04:32:29 205.254.184.12 [399661.971963][   C31] CPU: 31 PID: 0 Com=
m: swapper/31 Tainted: G        W  O       6.5.2 #1
> Sep 15 04:32:29 205.254.184.12 [399661.972079][   C31] Hardware name: Sup=
ermicro SYS-5038MR-H8TRF/X10SRD-F, BIOS 3.3 10/28/2020
> Sep 15 04:32:29 205.254.184.12 [399661.972197][   C31] RIP: 0010:0xffffa1=
0c52d43058
> Sep 15 04:32:29 205.254.184.12 [399661.972289][   C31] Code: 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 58 30 d4 5=
2 0c a1 ff ff 00 00 00 00 00 00
> Sep 15 04:32:29 205.254.184.12 [399661.972448][   C31] RSP: 0018:ffffad0e=
0097ccc8 EFLAGS: 00010282
> Sep 15 04:32:29 205.254.184.12 [399661.972543][   C31] RAX: ffffa10c52d43=
058 RBX: ffffa10c52d43000 RCX: 0000000000000000
> Sep 15 04:32:29 205.254.184.12 [399661.972659][   C31] RDX: 0000000000002=
712 RSI: 0000000000000246 RDI: ffffa10c52d43000
> Sep 15 04:32:29 205.254.184.12 [399661.972774][   C31] RBP: ffffa10c52d43=
000 R08: 0000000127a83c46 R09: 0000000000004d8c
> Sep 15 04:32:29 205.254.184.12 [399661.972889][   C31] R10: ffffe840ca0f7=
c00 R11: 0000000000000000 R12: ffffa10c8e764d80
> Sep 15 04:32:29 205.254.184.12 [399661.973005][   C31] R13: ffffa10c92b4c=
760 R14: 0000000000000058 R15: ffffa10c92b4c600
> Sep 15 04:32:29 205.254.184.12 [399661.973123][   C31] FS:  0000000000000=
000(0000) GS:ffffa1125fdc0000(0000) knlGS:0000000000000000
> Sep 15 04:32:29 205.254.184.12 [399661.973244][   C31] CS:  0010 DS: 0000=
 ES: 0000 CR0: 0000000080050033
> Sep 15 04:32:29 205.254.184.12 [399661.973338][   C31] CR2: ffffa10c52d43=
058 CR3: 00000001059b8001 CR4: 00000000003706e0
> Sep 15 04:32:29 205.254.184.12 [399661.973454][   C31] DR0: 0000000000000=
000 DR1: 0000000000000000 DR2: 0000000000000000
> Sep 15 04:32:29 205.254.184.12 [399661.973569][   C31] DR3: 0000000000000=
000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Sep 15 04:32:29 205.254.184.12 [399661.973684][   C31] Call Trace:
> Sep 15 04:32:29 205.254.184.12 [399661.973773][   C31]  <IRQ>
> Sep 15 04:32:29 205.254.184.12 [399661.973859][   C31]  ? __die+0xe4/0xf0
> Sep 15 04:32:29 205.254.184.12 [399661.973949][   C31]  ? page_fault_oops=
+0x144/0x3e0
> Sep 15 04:32:29 205.254.184.12 [399661.974043][   C31]  ? exc_page_fault+=
0x92/0xa0
> Sep 15 04:32:29 205.254.184.12 [399661.974136][   C31]  ? asm_exc_page_fa=
ult+0x22/0x30
> Sep 15 04:32:29 205.254.184.12 [399661.974228][   C31]  ? kfree_skb_reaso=
n+0x33/0xf0
> Sep 15 04:32:29 205.254.184.12 [399661.974321][   C31]  ? tcp_mtu_probe+0=
x3a6/0x7b0
> Sep 15 04:32:29 205.254.184.12 [399661.974416][   C31]  ? tcp_write_xmit+=
0x7fa/0x1410
> Sep 15 04:32:29 205.254.184.12 [399661.974509][   C31]  ? __tcp_push_pend=
ing_frames+0x2d/0xb0
> Sep 15 04:32:29 205.254.184.12 [399661.974603][   C31]  ? tcp_rcv_establi=
shed+0x381/0x610
> Sep 15 04:32:29 205.254.184.12 [399661.974695][   C31]  ? sk_filter_trim_=
cap+0xc6/0x1c0
> Sep 15 04:32:29 205.254.184.12 [399661.974787][   C31]  ? tcp_v4_do_rcv+0=
x11f/0x1f0
> Sep 15 04:32:29 205.254.184.12 [399661.974877][   C31]  ? tcp_v4_rcv+0xfa=
1/0x1010

Your reports are not usable. Please make sure to include symbols next time.

Please read these parts (and possibly complete files)

Documentation/admin-guide/bug-hunting.rst:55:quality of the stack
trace by using file:`scripts/decode_stacktrace.sh`.

Documentation/admin-guide/reporting-issues.rst:978:
[user@something ~]$ sudo dmesg |
./linux-5.10.5/scripts/decode_stacktrace.sh ./linux-5.10.5/vmlinux
Documentation/admin-guide/reporting-issues.rst:985:
[user@something ~]$ sudo dmesg |
./linux-5.10.5/scripts/decode_stacktrace.sh \



> Sep 15 04:32:29 205.254.184.12 [399661.974968][   C31]  ? ip_protocol_del=
iver_rcu+0x1b/0x270
> Sep 15 04:32:29 205.254.184.12 [399661.975062][   C31]  ? ip_local_delive=
r_finish+0x6d/0x90
> Sep 15 04:32:29 205.254.184.12 [399661.976257][   C31]  ? process_backlog=
+0x10c/0x230
> Sep 15 04:32:29 205.254.184.12 [399661.976352][   C31]  ? __napi_poll+0x2=
0/0x180
> Sep 15 04:32:29 205.254.184.12 [399661.976442][   C31]  ? net_rx_action+0=
x2a4/0x390
> Sep 15 04:32:29 205.254.184.12 [399661.976534][   C31]  ? __do_softirq+0x=
d0/0x202
> Sep 15 04:32:29 205.254.184.12 [399661.976626][   C31]  ? do_softirq+0x3a=
/0x50
> Sep 15 04:32:29 205.254.184.12 [399661.976718][   C31]  </IRQ>
> Sep 15 04:32:29 205.254.184.12 [399661.976805][   C31]  <TASK>
> Sep 15 04:32:29 205.254.184.12 [399661.976890][   C31]  ? flush_smp_call_=
function_queue+0x3f/0x50
> Sep 15 04:32:29 205.254.184.12 [399661.976988][   C31]  ? do_idle+0x14d/0=
x210
> Sep 15 04:32:29 205.254.184.12 [399661.977078][   C31]  ? cpu_startup_ent=
ry+0x14/0x20
> Sep 15 04:32:29 205.254.184.12 [399661.977168][   C31]  ? start_secondary=
+0xe1/0xf0
> Sep 15 04:32:29 205.254.184.12 [399661.977262][   C31]  ? secondary_start=
up_64_no_verify+0x167/0x16b
> Sep 15 04:32:29 205.254.184.12 [399661.977359][   C31]  </TASK>
> Sep 15 04:32:29 205.254.184.12 [399661.977448][   C31] Modules linked in:=
 nft_limit nf_conntrack_netlink  pppoe pppox ppp_generic slhc nft_ct nft_na=
t nft_chain_nat nf_tables netconsole coretemp bonding i40e nf_nat_sip nf_co=
nntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_=
nat_ftp nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos
> Sep 15 04:32:29 205.254.184.12 [399661.977720][   C31] CR2: ffffa10c52d43=
058
> Sep 15 04:32:29 205.254.184.12 [399661.977809][   C31] ---[ end trace 000=
0000000000000 ]---
> Sep 15 04:32:29 205.254.184.12 [399661.977901][   C31] RIP: 0010:0xffffa1=
0c52d43058
> Sep 15 04:32:29 205.254.184.12 [399661.977992][   C31] Code: 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 58 30 d4 5=
2 0c a1 ff ff 00 00 00 00 00 00
> Sep 15 04:32:29 205.254.184.12 [399661.978150][   C31] RSP: 0018:ffffad0e=
0097ccc8 EFLAGS: 00010282
> Sep 15 04:32:29 205.254.184.12 [399661.978243][   C31] RAX: ffffa10c52d43=
058 RBX: ffffa10c52d43000 RCX: 0000000000000000
> Sep 15 04:32:29 205.254.184.12 [399661.978358][   C31] RDX: 0000000000002=
712 RSI: 0000000000000246 RDI: ffffa10c52d43000
> Sep 15 04:32:29 205.254.184.12 [399661.978472][   C31] RBP: ffffa10c52d43=
000 R08: 0000000127a83c46 R09: 0000000000004d8c
> Sep 15 04:32:29 205.254.184.12 [399661.978587][   C31] R10: ffffe840ca0f7=
c00 R11: 0000000000000000 R12: ffffa10c8e764d80
> Sep 15 04:32:29 205.254.184.12 [399661.978702][   C31] R13: ffffa10c92b4c=
760 R14: 0000000000000058 R15: ffffa10c92b4c600
> Sep 15 04:32:29 205.254.184.12 [399661.978818][   C31] FS:  0000000000000=
000(0000) GS:ffffa1125fdc0000(0000) knlGS:0000000000000000
> Sep 15 04:32:29 205.254.184.12 [399661.978940][   C31] CS:  0010 DS: 0000=
 ES: 0000 CR0: 0000000080050033
> Sep 15 04:32:29 205.254.184.12 [399661.979036][   C31] CR2: ffffa10c52d43=
058 CR3: 00000001059b8001 CR4: 00000000003706e0
> Sep 15 04:32:29 205.254.184.12 [399661.979150][   C31] DR0: 0000000000000=
000 DR1: 0000000000000000 DR2: 0000000000000000
> Sep 15 04:32:29 205.254.184.12 [399661.979265][   C31] DR3: 0000000000000=
000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Sep 15 04:32:29 205.254.184.12 [399661.979381][   C31] Kernel panic - not=
 syncing: Fatal exception in interrupt
> Sep 15 04:32:29 205.254.184.12 [399662.084038][   C31] Kernel Offset: 0x1=
e000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xfff=
fffffbfffffff)
> Sep 15 04:32:29 205.254.184.12 [399662.084162][   C31] Rebooting in 10 se=
conds..
>
>
> Please if find fix update me .
>
> m.

