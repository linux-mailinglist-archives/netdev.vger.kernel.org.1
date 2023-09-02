Return-Path: <netdev+bounces-31815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465317905AB
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 08:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2641C208F5
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 06:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D18920E0;
	Sat,  2 Sep 2023 06:59:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F91FC5
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 06:59:40 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6491704
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 23:59:39 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d7bae413275so964357276.0
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 23:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693637979; x=1694242779; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9vgJtk1P0GVCv1lG+UlE4WZbYsQVpow+TSAKbO8j5ok=;
        b=GI5aDV4g87QGBkDQd+sHBhe2ahVVBDmkOAjIA20XXrCmV60LelB6evG6Jke/dG+q/7
         8uJF1DqgKTGOY6vU6YnOtui6fgqEiuKXmFs65ssIFml0pxFbVMtF9pnNuZIJ4UGliDAH
         KNKbNfOfvgvZMDojq8g8K0ibl3ZDIgGw9M5z7hwSKrY5vRDqd5+tDFcKI+IrPN7FuPEa
         LsJ1BKHbE45LN2kb49OZ8fVu78jiqnwURbcFmzSsvrDzssdvY+ERZ6hlpQWg/CQUzclz
         T7LR+Amio8KSTdcNi84+UPCV6dHsznF/zzZEaq/8MXU8sp2VR5TXG68L9Jb/oGgr1Ltg
         8tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693637979; x=1694242779;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vgJtk1P0GVCv1lG+UlE4WZbYsQVpow+TSAKbO8j5ok=;
        b=CJYN09QKRgPrwCOt4MU2p9vV6EwSN1VMcUydNxiAeFU3Y3ZZpw5TWqQkq67kef/tLd
         ezWnE6ybKo1kN455zePiRA+HDoih0e3vVW6AgFuQQmN2EwucxuT6dVQdc9NG+DS/cQ95
         5NxfZNFOzZRQ8Nk1000IM3r05pbCsPpkiJ5+37o34fhA47WbuaGH1lDV18kwzbx2Ez2e
         IPjjPZPAaO42FapZWl1s5kdZlSux49k50vHNzSW24ZIdIXZH2iPb+vyCPgkKR0pA6n0n
         GpqwrMM52tfCXQwTdvdU75d35+oX/umpsjrrxs9y/MwdXME67J7tal7jujsCIv0dnP+J
         ZxNA==
X-Gm-Message-State: AOJu0YyrkRToGe7UTWSgzqYnz6SgVFcugUkGwOBVoiUzawQO1VR+TfZ0
	/mbZKCSoF+lKW26qF2AV/eBjSQ==
X-Google-Smtp-Source: AGHT+IHZ5snHmZS/uqJ41JK07bKxxG6P64O//VWLVg4VF9iP5rMts9VpybpcHmms+LpcruwWAcDsxA==
X-Received: by 2002:a25:a56a:0:b0:d66:9fcb:1fc1 with SMTP id h97-20020a25a56a000000b00d669fcb1fc1mr6686474ybi.24.1693637978717;
        Fri, 01 Sep 2023 23:59:38 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s11-20020a25900b000000b00c62e0df7ca8sm1240186ybl.24.2023.09.01.23.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 23:59:38 -0700 (PDT)
Date: Fri, 1 Sep 2023 23:59:26 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Dave Hansen <dave.hansen@linux.intel.com>
cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
    Bagas Sanjaya <bagasdotme@gmail.com>, 
    Lai Jiangshan <laijs@linux.alibaba.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Gregory Greenman <gregory.greenman@intel.com>, 
    Ben Greear <greearb@candelatech.com>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Linux Networking <netdev@vger.kernel.org>, 
    Linux Wireless <linux-wireless@vger.kernel.org>, 
    Linux RCU <rcu@vger.kernel.org>
Subject: Re: Fwd: RCU indicates stalls with iwlwifi, causing boot failures
In-Reply-To: <c3f9b35c-087d-0e34-c251-e249f2c058d3@candelatech.com>
Message-ID: <f0f6a6ec-e968-a91c-dc46-357566d8811@google.com>
References: <c1caa7c1-b2c6-aac5-54ab-8bcc6e139ca8@gmail.com> <c3f9b35c-087d-0e34-c251-e249f2c058d3@candelatech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Dave,

On Fri, 1 Sep 2023, Ben Greear wrote:
> On 9/1/23 5:29 PM, Bagas Sanjaya wrote:
> > Hi,
> > 
> > I notice a bug report on Bugzilla [1]. Quoting from it:
> 
> Try booting with pcie=noaer ?
> 
> That fixes only known iwlwifi bug we have found in 6.5, but we are also using
> mostly
> backports iwlwifi driver...
> 
> Thanks,
> Ben
> 
> > 
> >> I'm seeing RCU warnings in Linus's current tree (like
> >> 87dfd85c38923acd9517e8df4afc908565df0961) that come from RCU:
> >>
> >> WARNING: CPU: 0 PID: 0 at kernel/rcu/tree_exp.h:787
> >> rcu_exp_handler+0x35/0xe0
> >>
> >> But they *ONLY* occur on a system with a newer iwlwifi device:
> >>
> >> aa:00.0 Network controller: Intel Corporation Wi-Fi 6 AX210/AX211/AX411
> >> 160MHz (rev 1a)
> >>
> >> and never in a VM or on an older device (like an 8260).  During a bisect
> >> the only seem to occur with the "83" version of the firmware.
> >>
> >> iwlwifi 0000:aa:00.0: loaded firmware version 83.e8f84e98.0
> >> ty-a0-gf-a0-83.ucode op_mode iwlmvm
> >>
> >> The first warning gets spit out within a millisecond of the last printk()
> >> from the iwlwifi driver.  They eventually result in a big spew of RCU
> >> messages like this:
> >>
> >> [   27.124796] rcu: INFO: rcu_preempt detected expedited stalls on
> >> CPUs/tasks: { 0-...D } 125 jiffies s: 193 root: 0x1/.
> >> [   27.126466] rcu: blocking rcu_node structures (internal RCU debug):
> >> [   27.128114] Sending NMI from CPU 3 to CPUs 0:
> >> [   27.128122] NMI backtrace for cpu 0 skipped: idling at
> >> intel_idle+0x5f/0xb0
> >> [   27.159757] loop30: detected capacity change from 0 to 8
> >> [   27.204967] rcu: INFO: rcu_preempt detected expedited stalls on
> >> CPUs/tasks: { 0-...D } 145 jiffies s: 193 root: 0x1/.
> >> [   27.206353] rcu: blocking rcu_node structures (internal RCU debug):
> >> [   27.207751] Sending NMI from CPU 3 to CPUs 0:
> >> [   27.207825] NMI backtrace for cpu 0 skipped: idling at
> >> intel_idle+0x5f/0xb0
> >>
> >> I usually see them at boot.  In that case, they usually hang the system and
> >> keep it from booting.  I've also encountered them at reboots and also seen
> >> them *not* be fatal at boot.  I suspect it has to do with which CPU gets
> >> wedged.
> > 
> > See Bugzilla for the full thread and attached full dmesg output.
> > 
> > Thanks.
> > 
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217856

I just took a look at your dmesg in bugzilla: I see lots of page tables
dumped, including "ESPfix Area", and think you're hitting my screwup: see

https://lore.kernel.org/linux-mm/CABXGCsNi8Tiv5zUPNXr6UJw6qV1VdaBEfGqEAMkkXE3QPvZuAQ@mail.gmail.com/

Please give the patch from the end of that thread a try:

[PATCH] mm/pagewalk: fix bootstopping regression from extra pte_unmap()

[ Commit message now written, but let's see if Dave can confirm it too ]

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 2022333805d3..9e7d0276c38a 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -58,7 +58,7 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			pte = pte_offset_map(pmd, addr);
 		if (pte) {
 			err = walk_pte_range_inner(pte, addr, end, walk);
-			if (walk->mm != &init_mm)
+			if (walk->mm != &init_mm && addr < TASK_SIZE)
 				pte_unmap(pte);
 		}
 	} else {
-- 
2.35.3

