Return-Path: <netdev+bounces-63593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758E682E2B1
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 23:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FB31C2204E
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 22:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C681B5B8;
	Mon, 15 Jan 2024 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2cy7pJY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FE618EA8
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705358501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6B+XhN0Sl3d143ZNKi1yxgLVPZ6MxfEunEq6hA5l0dY=;
	b=c2cy7pJYUv8lIapC+hmaRVLlzJcYb7bDABoCPa9frUc3yUgq7EF68G2NfTWOUVOCNMWtFS
	+2Q6Rhg6BnMrEPp8T11Mr7iA7T61SZqtjznwFCtiRkjCxdepaReBaaz1IoWZ4WvxzB7LIZ
	J+jtsA5MVAdcS2itTyoOfGXIS8BVF6I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-zAfIIsinNjKZfLTiEaevOw-1; Mon, 15 Jan 2024 17:41:40 -0500
X-MC-Unique: zAfIIsinNjKZfLTiEaevOw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6815c3dd94eso28955766d6.0
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 14:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705358500; x=1705963300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6B+XhN0Sl3d143ZNKi1yxgLVPZ6MxfEunEq6hA5l0dY=;
        b=YBT1mZhhOmVFp163tJSYWnJILbMXHuwn0R3TaSDr1UXSegWqHeoy29UW9cRtvns0Vt
         /97vuH/lDEKFiteZjlLc9Xf3l9iKNsGXzUOfIKPmmr+5BLF4zSet4FcU/3ikpzmJUph1
         g64sArHuPAMaL7jGs6dI/yQRVuIh3VzCmM3p9SkILnpgSa9ooS31ixLrK5J/jWnXSLMk
         mpuku/a8wDrv2qZE8kmZgjt3DWZ38wNzFDG92bDUe/+N1jA1MAu9wfcvxwP6HP20OG/K
         bVnkzvixTRPJOL2sCudgaqLcr1rp6jAUlLeGQAy6IwTPbVkKDRMnjQ+CLXstzDo/0xKf
         1pgQ==
X-Gm-Message-State: AOJu0YwmXmbaeAJk0pIKqxS2RhcbLtW+6lGK+W+aI78xhJ192QSGQMJu
	b8K8ErX0SyKZMjQYEWrFP10EW7LK+1H6Dzt5RKiV2rz/Sa9vV7o+lYWA2nbA0w9OfOoTBemH33/
	XMlsS4DjN7c+sa1Ob2DVBHxLK
X-Received: by 2002:a05:6214:202f:b0:681:5ab7:5c6d with SMTP id 15-20020a056214202f00b006815ab75c6dmr4165704qvf.104.1705358499884;
        Mon, 15 Jan 2024 14:41:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyYyKDLPgUx06nVctT4CqmE6KlB8zdFcjluXJpyalKyPtJCCw/vu3+O4yxDCNJeXa9TqzIng==
X-Received: by 2002:a05:6214:202f:b0:681:5ab7:5c6d with SMTP id 15-20020a056214202f00b006815ab75c6dmr4165696qvf.104.1705358499601;
        Mon, 15 Jan 2024 14:41:39 -0800 (PST)
Received: from [10.0.0.97] ([24.225.234.80])
        by smtp.gmail.com with ESMTPSA id ew1-20020a0562140aa100b0067f2c03d4adsm3618339qvb.100.2024.01.15.14.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 14:41:39 -0800 (PST)
Message-ID: <b17a1cda-2a3e-2a79-ff88-7f7fe3c30f37@redhat.com>
Date: Mon, 15 Jan 2024 17:41:38 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC,net-next] tcp: add support for read with offset when using
 MSG_PEEK
Content-Language: en-US
To: Martin Zaharinov <micron10@gmail.com>
Cc: netdev <netdev@vger.kernel.org>
References: <F0655F8D-EBEB-403E-BA89-0C8AAAE56E1D@gmail.com>
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <F0655F8D-EBEB-403E-BA89-0C8AAAE56E1D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-01-15 16:51, Martin Zaharinov wrote:
> Hi Jon
>
> After apply the patch on kernel 6.7.0 system hang with this bug report :
Hmm,
I have been running this for weeks without any problems, on x86_64 with 
current net and net-next.
There must be some difference between our kernels.
Which configuration are you using?
It would also be interesting to see your test program.

Regards
///jon


>
> Jan 15 22:27:39 6.7.0,1,863,194879739,-,caller=T3523;BUG: unable to handle page fault for address: 00007fff333174e0
> Jan 15 22:27:39 6.7.0,1,864,194879876,-,caller=T3523;#PF: supervisor read access in kernel mode
> Jan 15 22:27:39 6.7.0,1,865,194879976,-,caller=T3523;#PF: error_code(0x0001) - permissions violation
> Jan 15 22:27:39 6.7.0,6,866,194880075,-,caller=T3523;PGD 107cbd067 P4D 107cbd067 PUD 22055d067 PMD 10a384067 PTE 8000000228b00067
> Jan 15 22:27:39 6.7.0,4,867,194880202,-,caller=T3523;Oops: 0001 [#1] SMP
> Jan 15 22:27:39 6.7.0,4,868,194880297,-,caller=T3523;CPU: 12 PID: 3523 Comm: server-nft Tainted: G           O       6.7.0 #1
> Jan 15 22:27:39 6.7.0,4,869,194880420,-,caller=T3523;Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./EP2C612D8, BIOS P2.30 04/30/2018
> Jan 15 22:27:39 6.7.0,4,870,194880547,-,caller=T3523;RIP: 0010:tcp_recvmsg_locked+0x498/0xea0
> Jan 15 22:27:39 6.7.0,4,871,194880709,-,caller=T3523;Code: a3 07 00 00 80 fa 02 0f 84 88 07 00 00 84 d2 0f 84 f1 04 00 00 41 8b 8c 24 d8 05 00 00 49 8b 53 20 4c 8d 7c 24 44 89 4c 24 44 <48> 83 3a 00 0f 85 e5 fb ff ff 49 8b 73 30 48 83 fe 01 0f 86 c4 04
> Jan 15 22:27:39 6.7.0,4,872,194880876,-,caller=T3523;RSP: 0018:ffffa47b01307d00 EFLAGS: 00010202
> Jan 15 22:27:39 6.7.0,4,873,194880975,-,caller=T3523;RAX: 0000000000000002 RBX: ffff8cf8c3209800 RCX: 00000000a87ac03c
> Jan 15 22:27:39 6.7.0,4,874,194881096,-,caller=T3523;RDX: 00007fff333174e0 RSI: ffffa47b01307e18 RDI: ffff8cf8c3209800
> Jan 15 22:27:39 6.7.0,4,875,194881217,-,caller=T3523;RBP: ffffa47b01307d78 R08: ffffa47b01307d90 R09: ffffa47b01307d8c
> Jan 15 22:27:39 6.7.0,4,876,194881338,-,caller=T3523;R10: 0000000000000002 R11: ffffa47b01307e18 R12: ffff8cf8c3209800
> Jan 15 22:27:39 6.7.0,4,877,194881458,-,caller=T3523;R13: 0000000000000000 R14: 0000000000000000 R15: ffffa47b01307d44
> Jan 15 22:27:39 6.7.0,4,878,194881579,-,caller=T3523;FS:  00007f4941b0ad80(0000) GS:ffff8d001f900000(0000) knlGS:0000000000000000
> Jan 15 22:27:39 6.7.0,4,879,194881703,-,caller=T3523;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jan 15 22:27:39 6.7.0,4,880,194881802,-,caller=T3523;CR2: 00007fff333174e0 CR3: 000000010df04002 CR4: 00000000003706f0
> Jan 15 22:27:39 6.7.0,4,881,194881922,-,caller=T3523;DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Jan 15 22:27:39 6.7.0,4,882,194882043,-,caller=T3523;DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Jan 15 22:27:39 6.7.0,4,883,194882164,-,caller=T3523;Call Trace:
> Jan 15 22:27:39 6.7.0,4,884,194882257,-,caller=T3523; <TASK>
> Jan 15 22:27:39 6.7.0,4,885,194882347,-,caller=T3523; ? __die+0xe4/0xf0
> Jan 15 22:27:39 6.7.0,4,886,194882442,-,caller=T3523; ? page_fault_oops+0x144/0x3e0
> Jan 15 22:27:39 6.7.0,4,887,194882539,-,caller=T3523; ? zap_pte_range+0x6a4/0xdc0
> Jan 15 22:27:39 6.7.0,4,888,194882638,-,caller=T3523; ? exc_page_fault+0x5d/0xa0
> Jan 15 22:27:39 6.7.0,4,889,194882736,-,caller=T3523; ? asm_exc_page_fault+0x22/0x30
> Jan 15 22:27:39 6.7.0,4,890,194882834,-,caller=T3523; ? tcp_recvmsg_locked+0x498/0xea0
> Jan 15 22:27:39 6.7.0,4,891,194882931,-,caller=T3523; ? __call_rcu_common.constprop.0+0xbc/0x770
> Jan 15 22:27:39 6.7.0,4,892,194883031,-,caller=T3523; ? rcu_nocb_flush_bypass.part.0+0xec/0x120
> Jan 15 22:27:39 6.7.0,4,893,194883133,-,caller=T3523; tcp_recvmsg+0x5c/0x1e0
> Jan 15 22:27:39 6.7.0,4,894,194883228,-,caller=T3523; inet_recvmsg+0x2a/0x90
> Jan 15 22:27:39 6.7.0,4,895,194883325,-,caller=T3523; __sys_recvfrom+0x15e/0x200
> Jan 15 22:27:39 6.7.0,4,896,194883423,-,caller=T3523; ? wait_task_zombie+0xee/0x410
> Jan 15 22:27:39 6.7.0,4,897,194883539,-,caller=T3523; ? remove_wait_queue+0x1b/0x60
> Jan 15 22:27:39 6.7.0,4,898,194883635,-,caller=T3523; ? do_wait+0x93/0xa0
> Jan 15 22:27:39 6.7.0,4,899,194883729,-,caller=T3523; ? __x64_sys_poll+0xa7/0x170
> Jan 15 22:27:39 6.7.0,4,900,194883825,-,caller=T3523; __x64_sys_recvfrom+0x1b/0x20
> Jan 15 22:27:39 6.7.0,4,901,194883921,-,caller=T3523; do_syscall_64+0x2c/0xa0
> Jan 15 22:27:39 6.7.0,4,902,194884018,-,caller=T3523; entry_SYSCALL_64_after_hwframe+0x46/0x4e
> Jan 15 22:27:39 6.7.0,4,903,194884116,-,caller=T3523;RIP: 0033:0x7f4941fe92a9
> Jan 15 22:27:39 6.7.0,4,904,194884210,-,caller=T3523;Code: 0c 00 64 c7 02 02 00 00 00 eb bf 66 0f 1f 44 00 00 80 3d a9 e0 0c 00 00 41 89 ca 74 1c 45 31 c9 45 31 c0 b8 2d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 67 c3 66 0f 1f 44 00 00 55 48 83 ec 20 48 89
> Jan 15 22:27:39 6.7.0,4,905,194884377,-,caller=T3523;RSP: 002b:00007fff33317468 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
> Jan 15 22:27:39 6.7.0,4,906,194884499,-,caller=T3523;RAX: ffffffffffffffda RBX: 00007fff333174e0 RCX: 00007f4941fe92a9
> Jan 15 22:27:39 6.7.0,4,907,194884620,-,caller=T3523;RDX: 0000000000000001 RSI: 00007fff333174e0 RDI: 0000000000000005
> Jan 15 22:27:39 6.7.0,4,908,194884740,-,caller=T3523;RBP: 00007fff33317550 R08: 0000000000000000 R09: 0000000000000000
> Jan 15 22:27:39 6.7.0,4,909,194884860,-,caller=T3523;R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
> Jan 15 22:27:39 6.7.0,4,910,194884980,-,caller=T3523;R13: 0000000000000000 R14: 0000000000000000 R15: 00007f49418850a0
> Jan 15 22:27:39 6.7.0,4,911,194885101,-,caller=T3523; </TASK>
> Jan 15 22:27:39 6.7.0,4,912,194885191,-,caller=T3523;Modules linked in: nft_limit pppoe pppox ppp_generic slhc nft_ct nft_nat nft_chain_nat nf_tables netconsole coretemp bonding igb i2c_algo_bit i40e ixgbe mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos aesni_intel crypto_simd cryptd
> Jan 15 22:27:39 6.7.0,4,913,194885507,-,caller=T3523;CR2: 00007fff333174e0
> Jan 15 22:27:39 6.7.0,4,914,194885602,-,caller=T3523;---[ end trace 0000000000000000 ]---
> Jan 15 22:27:39 6.7.0,4,915,194885698,-,caller=T3523;RIP: 0010:tcp_recvmsg_locked+0x498/0xea0
> Jan 15 22:27:39 6.7.0,4,916,194885797,-,caller=T3523;Code: a3 07 00 00 80 fa 02 0f 84 88 07 00 00 84 d2 0f 84 f1 04 00 00 41 8b 8c 24 d8 05 00 00 49 8b 53 20 4c 8d 7c 24 44 89 4c 24 44 <48> 83 3a 00 0f 85 e5 fb ff ff 49 8b 73 30 48 83 fe 01 0f 86 c4 04
> Jan 15 22:27:39 6.7.0,4,917,194887079,-,caller=T3523;RSP: 0018:ffffa47b01307d00 EFLAGS: 00010202
> Jan 15 22:27:39 6.7.0,4,918,194887177,-,caller=T3523;RAX: 0000000000000002 RBX: ffff8cf8c3209800 RCX: 00000000a87ac03c
> Jan 15 22:27:39 6.7.0,4,919,194887298,-,caller=T3523;RDX: 00007fff333174e0 RSI: ffffa47b01307e18 RDI: ffff8cf8c3209800
> Jan 15 22:27:39 6.7.0,4,920,194887418,-,caller=T3523;RBP: ffffa47b01307d78 R08: ffffa47b01307d90 R09: ffffa47b01307d8c
> Jan 15 22:27:39 6.7.0,4,921,194887538,-,caller=T3523;R10: 0000000000000002 R11: ffffa47b01307e18 R12: ffff8cf8c3209800
> Jan 15 22:27:39 6.7.0,4,922,194887658,-,caller=T3523;R13: 0000000000000000 R14: 0000000000000000 R15: ffffa47b01307d44
> Jan 15 22:27:39 6.7.0,4,923,194887779,-,caller=T3523;FS:  00007f4941b0ad80(0000) GS:ffff8d001f900000(0000) knlGS:0000000000000000
> Jan 15 22:27:39 6.7.0,4,924,194887901,-,caller=T3523;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jan 15 22:27:39 6.7.0,4,925,194888000,-,caller=T3523;CR2: 00007fff333174e0 CR3: 000000010df04002 CR4: 00000000003706f0
> Jan 15 22:27:39 6.7.0,4,926,194888120,-,caller=T3523;DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Jan 15 22:27:39 6.7.0,4,927,194888240,-,caller=T3523;DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Jan 15 22:27:39 6.7.0,0,928,194888360,-,caller=T3523;Kernel panic - not syncing: Fatal exception
> Jan 15 22:27:40 6.7.0,0,929,195391096,-,caller=T3523;Kernel Offset: 0x1f000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> Jan 15 22:27:40 6.7.0,0,930,195391224,-,caller=T3523;Rebooting in 10 seconds..
>
>
>
> m.
>


