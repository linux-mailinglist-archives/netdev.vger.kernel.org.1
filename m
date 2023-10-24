Return-Path: <netdev+bounces-43700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F411F7D4469
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229E41C20B82
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827C363AC;
	Tue, 24 Oct 2023 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0UEdfMj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75261523E
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:01:52 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A538AD7E
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:01:50 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7789923612dso274579685a.0
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698109309; x=1698714109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iX/8Evm3AKef86dzGTemrUj7lOQSxgz0Ra/9GWq1lVA=;
        b=h0UEdfMjg/0naE/aCLVGYVlxfa+cVqnkZOJqr323zGSA/BbOLNYR+pv9RnDicJq8Lm
         EV2F7k0azUrM+/3JAU6PQsNckmTHAd7ruMF7VWvwG6THtu8s15XsjjqYgqBEHeofXTgZ
         lSaL0fMpGEdb1ys5v/A2FqiFGLB/Cc9vB9hgu7jxmTeF9Jh8ZOLFZe2gXbPZF+4+pkiN
         yquEfCl/C8sC0zdeoQY1M0e+4vxDIS0M87pSkG8hjo+yvyQ62fQFvwUKJ5Gses3dssfF
         ohMwyRAzJg7HwB7Bwx+YOFnUvazVS4BCqNLRyxUHchIfhOIpdk7VlfpuEIs+9AR5oAzb
         e3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698109309; x=1698714109;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iX/8Evm3AKef86dzGTemrUj7lOQSxgz0Ra/9GWq1lVA=;
        b=qYHfsleaEeq/eDqczSDrpFh5f9gfZ37dhQFXziWVgzhG8JK1AlTePd2dGAXxA//yzj
         V1TDy5TsTcuwoq6u1t+tLW8hFyuDvt075Lg8NA4E43pgLl1fSK04gEVTIpFuKwDZCwkU
         dBUcC3PDqNp47rbwecHn+YMYR6KfWm56QEgWb928i6pjmFWIv/W7bmHpy6eId1t6kGsf
         mvqgaT4UsFaiD0LJ8aYVH9bEALiIZXOTMszPiHbtKcwRVz/xOTiPI7Xq8H/0pN7x6huB
         0bdtE3LKhINkV42WyRHpJo0c/hQzcVpfgxlNAUtHRG15xz9l0dNpbKsUl8Pr3FtK83Om
         i8hw==
X-Gm-Message-State: AOJu0YxI4QQxKdM67uZBjRMU5xiU3xckmgsmnW8j0sKXyIcvTgtTs7Kt
	ANSuFQka2FjSpSDpueK1R+M50tn5f30=
X-Google-Smtp-Source: AGHT+IGhYAJLXZDGeSvq9TnoQmGS1p6Kaxq1pZluL9vNYugWmsHorAktR8vpLdDPI/3An+kgzb3SwQ==
X-Received: by 2002:a05:620a:430f:b0:773:c792:bdda with SMTP id u15-20020a05620a430f00b00773c792bddamr12290826qko.53.1698109309492;
        Mon, 23 Oct 2023 18:01:49 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a408800b007759e9b0eb8sm3107450qko.99.2023.10.23.18.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 18:01:48 -0700 (PDT)
Message-ID: <96efddab-7a50-4fb3-a0e1-186b9339a53a@gmail.com>
Date: Mon, 23 Oct 2023 18:01:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: swiotlb dyn alloc WARNING splat in wireless-next.
Content-Language: en-US
To: Ben Greear <greearb@candelatech.com>, netdev <netdev@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Petr Tesarik <petr@tesarici.cz>
References: <4f173dd2-324a-0240-ff8d-abf5c191be18@candelatech.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <4f173dd2-324a-0240-ff8d-abf5c191be18@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+Christoph, Petr

On 10/22/2023 11:48 AM, Ben Greear wrote:
> Hello,
> 
> I saw this in a system with 16GB of RAM running a lot of wifi traffic
> on 16 radios.  System appears to mostly be working OK, so not sure if it is
> a real problem or not.
> 
> [76171.488627] WARNING: CPU: 2 PID: 30169 at mm/page_alloc.c:4402 
> __alloc_pages+0x19c/0x200
> [76171.488634] Modules linked in: tls nf_conntrack_netlink nf_conntrack 
> nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 bpfilter vrf 8021q garp mrp stp 
> llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg 
> intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 iTCO_vendor_support 
> snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic 
> ledtrig_audio coretemp intel_rapl_common iwlmvm intel_tcc_cooling 
> x86_pkg_temp_thermal mt7921e intel_powerclamp mt7921_common mt792x_lib 
> mt76_connac_lib kvm_intel snd_hda_intel mt76 snd_intel_dspcfg 
> snd_hda_codec snd_hda_core mac80211 kvm snd_hwdep iwlwifi snd_seq 
> irqbypass snd_seq_device pcspkr cfg80211 snd_pcm intel_wmi_thunderbolt 
> i2c_i801 i2c_smbus snd_timer bfq tpm_crb snd soundcore mei_hdcp mei_pxp 
> tpm_tis tpm_tis_core intel_pch_thermal tpm acpi_pad nfsd auth_rpcgss 
> nfs_acl lockd grace sch_fq_codel sunrpc fuse zram raid1 dm_raid raid456 
> libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx 
> raid6_pq i915 igb i2c_algo_bit drm_buddy intel_gtt drm_display_helper
> [76171.488690]  drm_kms_helper cec rc_core ttm drm agpgart ixgbe mdio 
> dca xhci_pci hwmon mei_wdt xhci_pci_renesas i2c_core video wmi [last 
> unloaded: nfnetlink]
> [76171.488701] CPU: 2 PID: 30169 Comm: kworker/2:2 Not tainted 
> 6.6.0-rc5+ #13
> [76171.488704] Hardware name: Default string Default string/SKYBAY, BIOS 
> 5.12 02/21/2023
> [76171.488705] Workqueue: events swiotlb_dyn_alloc
> [76171.488708] RIP: 0010:__alloc_pages+0x19c/0x200
> [76171.488711] Code: ff ff 00 0f 84 56 ff ff ff 80 ce 01 e9 4e ff ff ff 
> 83 fe 0a 0f 86 db fe ff ff 80 3d ba c9 4a 01 00 75 09 c6 05 b1 c9 4a 01 
> 01 <0f> 0b 45 31 e4 e9 4f ff ff ff a9 00 00 08 00 75 43 89 d9 80 e1 7f
> [76171.488713] RSP: 0018:ffffc9000babfd78 EFLAGS: 00010246
> [76171.488714] RAX: 0000000000000000 RBX: 0000000000000cc4 RCX: 
> 0000000000000000
> [76171.488716] RDX: 0000000000000000 RSI: 000000000000000e RDI: 
> 0000000000000cc4
> [76171.488717] RBP: 000000000000000e R08: 0000000000000000 R09: 
> 0000000000000000
> [76171.488718] R10: ffff88811ff99000 R11: 0000000000000000 R12: 
> ffff888110070400
> [76171.488719] R13: 0000000000000000 R14: 0000000003ffffff R15: 
> ffff8881100586b0
> [76171.488720] FS:  0000000000000000(0000) GS:ffff88845dc80000(0000) 
> knlGS:0000000000000000
> [76171.488722] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [76171.488723] CR2: 0000000003519000 CR3: 0000000002634004 CR4: 
> 00000000003706e0
> [76171.488725] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [76171.488726] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [76171.488727] Call Trace:
> [76171.488729]  <TASK>
> [76171.488730]  ? __alloc_pages+0x19c/0x200
> [76171.488732]  ? __warn+0x78/0x130
> [76171.488736]  ? __alloc_pages+0x19c/0x200
> [76171.488738]  ? report_bug+0x169/0x1a0
> [76171.488742]  ? handle_bug+0x41/0x70
> [76171.488744]  ? exc_invalid_op+0x13/0x60
> [76171.488747]  ? asm_exc_invalid_op+0x16/0x20
> [76171.488751]  ? __alloc_pages+0x19c/0x200
> [76171.488753]  swiotlb_alloc_pool+0x102/0x280
> [76171.488756]  swiotlb_dyn_alloc+0x2a/0xa0
> [76171.488757]  process_one_work+0x15d/0x330
> [76171.488759]  worker_thread+0x2e8/0x400
> [76171.488762]  ? drain_workqueue+0x120/0x120
> [76171.488763]  kthread+0xdc/0x110
> [76171.488766]  ? kthread_complete_and_exit+0x20/0x20
> [76171.488769]  ret_from_fork+0x28/0x40
> [76171.488771]  ? kthread_complete_and_exit+0x20/0x20
> [76171.488774]  ret_from_fork_asm+0x11/0x20
> [76171.488778]  </TASK>
> [76171.488778] ---[ end trace 0000000000000000 ]---
> 
> Thanks,
> Ben
> 

-- 
Florian

