Return-Path: <netdev+bounces-35107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323167A7160
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 05:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C877D281B01
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 03:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAE81FDF;
	Wed, 20 Sep 2023 03:59:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCCC1FC1
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 03:59:26 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F584AC
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 20:59:24 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-414ba610766so232711cf.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 20:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695182363; x=1695787163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9Ycw/9hA+zPDGYn+bxgsaVXjgOgiTsVBuBxIwxP8UU=;
        b=oF9fC093JQw2+7yZPj8Hps4QYiL6pg6MF6zyYLhjw5uHkfCCTTvd+N1WQ/LOvPuEVj
         sXzI0JCokbqz8jChvjs3B6e2Aoq+BZ8GG38jI546lbR3Kh2yar2Wk0y8dShsoY4/7qrn
         jivUHwe+0l6eFgauEpg5esOLAm2U6LRfDV/kJ3mRXmIhV9jKGtuTkytTUMol6dXeGaSn
         HihzheOZcWpkZ0jrVaiMKO1uSglVkQrc4H2b545CAQD2Sg+vP+eaM9IpBAKdm5cAVMBP
         mkg4qenWTWc0W6SwXXMZhhPZfRRpwWdYeldossdZDu5ND6u0XbwHDGj8dd62kk6vwtBp
         Yg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695182363; x=1695787163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9Ycw/9hA+zPDGYn+bxgsaVXjgOgiTsVBuBxIwxP8UU=;
        b=TeimB4/1rqIwDf40dBCIN70HqYGLVZvVrEZ9N2aNeTsDmCkMjZ1LyvOlA33wsjwHmw
         h5SOrXWsGp0gDlfpGUmdmY26+Vl2rFTxEoQhQaStoAEA0k0m5/Q1dRHGgkuWXsjg+sw+
         epteFUBSYMV02fs9anEQUsmWU/IdGp1apcXZQagvn7JHKUnsWH+kei59FM34hw/SO+7x
         uh4VHqS0kpUXAWIop79hBbjMhuEmw1SFWzZVx3KuWfz4qFm6PrwNf7Npv15e3iyol1Gf
         5OY2K9eJCAYHpUZC4cQ4Qe4495nEq3mPCoBbFuKU20FpyFNwQsUrhFcxbWOKwQGxHuEr
         7IrQ==
X-Gm-Message-State: AOJu0YzyAS9eu9TwIsp3Oif73c56yZeCZUU1jHQMMIx5c6eBn8dfGp7F
	nu/U6mW5SN7ZmAHUSPUa3UIFeVXMOnf94UwXlaiBCA==
X-Google-Smtp-Source: AGHT+IFayKogvSuHafvD9Y6iE7tOQYR0mmh4U6Xhi/Ate8rozJ8gc5ITjwotTr3UFnqiIBGHLMTQg9ikaSFr6bs9SUU=
X-Received: by 2002:a05:622a:211:b0:417:8dd5:df0d with SMTP id
 b17-20020a05622a021100b004178dd5df0dmr97137qtx.9.1695182362875; Tue, 19 Sep
 2023 20:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com> <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
 <8a62f57a9454b0592ab82248fca5a21fc963995b.camel@redhat.com>
 <CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
 <43ED0333-18AB-4C38-A615-7755E5BE9C3E@gmail.com> <5A853CC5-F15C-4F30-B845-D9E5B43EC039@gmail.com>
 <A416E134-BFAA-45FE-9061-9545F6DCC246@gmail.com>
In-Reply-To: <A416E134-BFAA-45FE-9061-9545F6DCC246@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Sep 2023 05:59:11 +0200
Message-ID: <CANn89iKXxyAQG-N+mdhNA8H+LEf=OK+goMFxYCV6yU1BpE=Xvw@mail.gmail.com>
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
To: Martin Zaharinov <micron10@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>, 
	patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, kuba+netdrv@kernel.org, dsahern@gmail.com, 
	Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 10:09=E2=80=AFPM Martin Zaharinov <micron10@gmail.c=
om> wrote:
>
> Hi Eric
>
> Yes this patch is not come in 6.5 kernel and queue for 6.6 i test but not=
 ok for now.

"not ok for now" ? What does this mean?
Pointing out patches that are not related to your issue is a waste of time.
If this was to bring my attention, this is a bad strategy, because I
will probably not read your future emails.

>
> One more i find same error have in old kernel 6.4.8  , update to kernel 6=
.5.4 and same error is come .
>
> Like this is hard to catch bug
>
> see logs :
>
>
> [1462610.861373] ------------[ cut here ]------------
> [1462610.861480] rcuref - imbalanced put()
> [1462610.861491] WARNING: CPU: 22 PID: 0 at lib/rcuref.c:267 rcuref_put_s=
lowpath+0x5f/0x70
> [1462610.861718] Modules linked in: nft_limit nf_conntrack_netlink  pppoe=
 pppox ppp_generic slhc nft_ct nft_nat nft_chain_nat nf_tables netconsole c=
oretemp bonding ixgbe mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_connt=
rack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipmi_si ipmi_devintf ipmi_msghan=
dler rtc_cmos
> [1462610.862004] CPU: 22 PID: 0 Comm: swapper/22 Tainted: G           O  =
     6.4.8 #1
> [1462610.863244] Hardware name: Supermicro Super Server/X10SRW-F, BIOS 3.=
4 06/05/2021
> [1462610.863368] RIP: 0010:rcuref_put_slowpath+0x5f/0x70
> [1462610.863469] Code: 31 c0 eb e2 80 3d 02 cd e6 00 00 74 0a c7 03 00 00=
 00 e0 31 c0 eb cf 48 c7 c7 7f 68 e5 a4 c6 05 e8 cc e6 00 01 e8 e1 ab c7 ff=
 <0f> 0b eb df cc cc cc cc cc cc cc cc cc cc cc cc cc 48 89 fa 83 e2
> [1462610.863637] RSP: 0018:ffffaee60070cc38 EFLAGS: 00010292
> [1462610.863736] RAX: 0000000000000019 RBX: ffffa1cdc35e5780 RCX: 0000000=
0fff7ffff
> [1462610.863857] RDX: 00000000fff7ffff RSI: 0000000000000001 RDI: 0000000=
0ffffffea
> [1462610.864129] RBP: ffffa1cf6aeb8de8 R08: 0000000000000000 R09: 0000000=
0fff7ffff
> [1462610.864250] R10: ffffa1d51b000000 R11: 0000000000000003 R12: ffffa1c=
dc35e5740
> [1462610.864370] R13: ffffa1cdc35e57a8 R14: ffffa1d51fda9008 R15: 0000000=
0ade2eb6e
> [1462610.864489] FS:  0000000000000000(0000) GS:ffffa1d51fd80000(0000) kn=
lGS:0000000000000000
> [1462610.864615] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [1462610.864713] CR2: 00007f057b8ad000 CR3: 0000000141881003 CR4: 0000000=
0001706e0
> [1462610.864833] Call Trace:
> [1462610.864928]  <IRQ>
> [1462610.865021]  ? __warn+0x6c/0x130
> [1462610.865124]  ? report_bug+0x1e4/0x260
> [1462610.865223]  ? handle_bug+0x36/0x70
> [1462610.865318]  ? exc_invalid_op+0x17/0x1a0
> [1462610.865414]  ? asm_exc_invalid_op+0x16/0x20
> [1462610.865517]  ? rcuref_put_slowpath+0x5f/0x70
> [1462610.865618]  ? rcuref_put_slowpath+0x5f/0x70
> [1462610.865719]  dst_release+0x2c/0x60
> [1462610.865817]  rt_cache_route+0xbd/0xf0
> [1462610.865913]  rt_set_nexthop.isra.0+0x1b6/0x440
> [1462610.866008]  ip_route_input_slow+0x90e/0xc60
> [1462610.866116]  ? nf_conntrack_udp_packet+0x16c/0x230 [nf_conntrack]
> [1462610.866229]  ip_route_input_noref+0xed/0x100
> [1462610.866328]  ip_rcv_finish_core.isra.0+0xb1/0x410
> [1462610.866425]  ip_rcv+0xed/0x130
> [1462610.866522]  ? ip_rcv_core.constprop.0+0x350/0x350
> [1462610.866621]  process_backlog+0x10c/0x230
> [1462610.866719]  __napi_poll+0x20/0x180
> [1462610.866818]  net_rx_action+0x2a4/0x390
> [1462610.866921]  __do_softirq+0xd0/0x202
> [1462610.867020]  do_softirq+0x58/0x80
> [1462610.867116]  </IRQ>
> [1462610.867206]  <TASK>
> [1462610.867298]  flush_smp_call_function_queue+0x3f/0x60
> [1462610.867403]  do_idle+0x14d/0x210
> [1462610.867500]  cpu_startup_entry+0x14/0x20
> [1462610.867602]  start_secondary+0xec/0xf0
> [1462610.867701]  secondary_startup_64_no_verify+0xf9/0xfb
> [1462610.867799]  </TASK>
> [1462610.867891] ---[ end trace 0000000000000000 ]=E2=80=94
>
>
> And this si 6.5.4 :
>
> [39651.441371] ------------[ cut here ]------------
> [39651.441455] rcuref - imbalanced put()
> [39651.441470] WARNING: CPU: 12 PID: 0 at lib/rcuref.c:267 rcuref_put_slo=
wpath+0x5f/0x70
> [39651.441633] Modules linked in: nft_limit pppoe pppox ppp_generic slhc =
nft_ct nft_nat nft_chain_nat nf_tables netconsole coretemp igb i2c_algo_bit=
 i40e ixgbe mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp =
nf_nat_tftp nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntra=
ck nf_defrag_ipv6 nf_defrag_ipv4 ipmi_si ipmi_devintf ipmi_msghandler rtc_c=
mos
> [39651.441805] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G           O    =
   6.5.3 #1
> [39651.441911] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.=
M./EP2C612D8, BIOS P2.30 04/30/2018
> [39651.442035] RIP: 0010:rcuref_put_slowpath+0x5f/0x70
> [39651.442131] Code: 31 c0 eb e2 80 3d 86 ae e6 00 00 74 0a c7 03 00 00 0=
0 e0 31 c0 eb cf 48 c7 c7 68 f6 e2 9a c6 05 6c ae e6 00 01 e8 11 71 c7 ff <=
0f> 0b eb df cc cc cc cc cc cc cc cc cc cc cc cc cc 48 89 fa 83 e2
> [39651.442294] RSP: 0018:ffffbb9a404b4de8 EFLAGS: 00010296
> [39651.442390] RAX: 0000000000000019 RBX: ffffa13ac9a32640 RCX: 00000000f=
ff7ffff
> [39651.442513] RDX: 00000000fff7ffff RSI: 0000000000000001 RDI: 00000000f=
fffffea
> [39651.442630] RBP: ffffa13a44a04000 R08: 0000000000000000 R09: 00000000f=
ff7ffff
> [39651.442748] R10: ffffa1419ae00000 R11: 0000000000000003 R12: ffffa13ab=
640bec0
> [39651.442866] R13: 0000000000000000 R14: 0000000000000010 R15: ffffbb9a4=
04b4f60
> [39651.442985] FS:  0000000000000000(0000) GS:ffffa1419f900000(0000) knlG=
S:0000000000000000
> [39651.443106] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [39651.443201] CR2: 0000564f9e23f6e0 CR3: 000000010bcea002 CR4: 000000000=
03706e0
> [39651.443319] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [39651.443438] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [39651.443558] Call Trace:
> [39651.443647]  <IRQ>
> [39651.443736]  ? __warn+0x6c/0x130
> [39651.443829]  ? report_bug+0x1e4/0x260
> [39651.443924]  ? handle_bug+0x36/0x70
> [39651.444016]  ? exc_invalid_op+0x17/0x1a0
> [39651.444109]  ? asm_exc_invalid_op+0x16/0x20
> [39651.444202]  ? rcuref_put_slowpath+0x5f/0x70
> [39651.444297]  ? rcuref_put_slowpath+0x5f/0x70
> [39651.444391]  dst_release+0x2c/0x60
> [39651.444487]  __dev_queue_xmit+0x56c/0xbd0
> [39651.444582]  ? nf_hook_slow+0x36/0xa0
> [39651.444675]  ip_finish_output2+0x27b/0x520
> [39651.444770]  process_backlog+0x10c/0x230
> [39651.444866]  __napi_poll+0x20/0x180
> [39651.444961]  net_rx_action+0x2a4/0x390
> [39651.445055]  __do_softirq+0xd0/0x202
> [39651.445148]  do_softirq+0x3a/0x50
> [39651.445241]  </IRQ>
> [39651.445329]  <TASK>
> [39651.445416]  flush_smp_call_function_queue+0x3f/0x50
> [39651.445516]  do_idle+0x14d/0x210
> [39651.445609]  cpu_startup_entry+0x14/0x20
> [39651.445702]  start_secondary+0xe1/0xf0
> [39651.445797]  secondary_startup_64_no_verify+0x167/0x16b
> [39651.445893]  </TASK>
> [39651.445982] ---[ end trace 0000000000000000 ]=E2=80=94
>
>
> best regards,
> Martin

You keep sending traces without symbols, nobody here will even look at them=
.

Again, your best route is a bisection.

>
> > On 17 Sep 2023, at 14:55, Martin Zaharinov <micron10@gmail.com> wrote:
> >
> > Hi Eric
> > is it possible bug to come from this patch : https://patchwork.kernel.o=
rg/project/netdevbpf/cover/20230911170531.828100-1-edumazet@google.com/
> >
> >
> > m.
> >
> >> On 17 Sep 2023, at 14:40, Martin Zaharinov <micron10@gmail.com> wrote:
> >>
> >> One more in changelog for kernel 6.5 : https://cdn.kernel.org/pub/linu=
x/kernel/v6.x/ChangeLog-6.5
> >>
> >> I see have many bug reports with :
> >>
> >> Sep 17 11:43:11  [127675.395289][    C2]  ? process_backlog+0x10c/0x23=
0
> >> Sep 17 11:43:11  [127675.395386][    C2]  ? __napi_poll+0x20/0x180
> >> Sep 17 11:43:11  [127675.395478][    C2]  ? net_rx_action+0x2a4/0x390
> >>
> >>
> >> In all server have simple nftables rulls , ethernet card is intel xl71=
0 or 82599. its a very simple config.
> >>
> >> m.
> >>
> >>
> >>
> >>
> >>> On 16 Sep 2023, at 12:04, Martin Zaharinov <micron10@gmail.com> wrote=
:
> >>>
> >>> Hi Paolo
> >>>
> >>> in first report machine dont have out of tree module
> >>>
> >>> this bug is come after move from kernel 6.2 to 6.3
> >>>
> >>> m.
> >>>
> >>> On Sat, Sep 16, 2023, 11:27 Paolo Abeni <pabeni@redhat.com> wrote:
> >>> On Sat, 2023-09-16 at 02:11 +0300, Martin Zaharinov wrote:
> >>>> one more log:
> >>>>
> >>>> Sep 12 07:37:29  [151563.298466][    C5] ------------[ cut here ]---=
---------
> >>>> Sep 12 07:37:29  [151563.298550][    C5] rcuref - imbalanced put()
> >>>> Sep 12 07:37:29  [151563.298564][ C5] WARNING: CPU: 5 PID: 0 at lib/=
rcuref.c:267 rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
> >>>> Sep 12 07:37:29  [151563.298724][    C5] Modules linked in: nft_limi=
t nf_conntrack_netlink vlan_mon(O) pppoe pppox ppp_generic slhc nft_ct nft_=
nat nft_chain_nat nf_tables netconsole coretemp bonding i40e nf_nat_sip nf_=
conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp n=
f_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv=
4 nf_xnatlog(O) ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos [last unloade=
d: BNGBOOT(O)]
> >>>> Sep 12 07:37:29  [151563.298894][    C5] CPU: 5 PID: 0 Comm: swapper=
/5 Tainted: G           O       6.5.2 #1
> >>>
> >>>
> >>> You have out-of-tree modules taint in all the report you shared. Plea=
se
> >>> try to reproduce the issue with such taint, thanks!
> >>>
> >>> Paolo
> >>>
> >>
> >
>

