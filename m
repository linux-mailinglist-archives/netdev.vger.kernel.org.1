Return-Path: <netdev+bounces-31832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE5D79089C
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 17:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613372816C3
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5D18830;
	Sat,  2 Sep 2023 15:59:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58C3C1E
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 15:59:51 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4838210D4
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 08:59:50 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b9a2416b1cso79891a34.2
        for <netdev@vger.kernel.org>; Sat, 02 Sep 2023 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693670389; x=1694275189; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AnEkQcajTlSloQfs6AhM0nt/JC6HaPWBmgZ2b8nds0w=;
        b=cIJW5ueKkmPmKs4QZr8oxj37x6qJYXYZ6qtYMj2EZkMoxfGYcl/v0L1EDg8oULU6Jv
         WfaU+4LyRJGL3sx6rfS2yW0xB+hZQ8pcR4yu63k4FoBsdrW/rrca28IXKqC06bUyViha
         iTL71ISGplrt3FEF0E0jN/NU682ZaJD/0quSf+kiL+mMNrJsCTI7df19zkHJftgdEFwr
         +QGLjqqImI0NqslAgI6XhMZ53LuhsRgItzYMvRIcdM14RG9YQwz7/18xaxtWqu+uMhLf
         PeqB7Ga3kC8N4exQHXXpTHTSPbOQ4ioWkXwi9jWWLCUhraa5yo/JwLk7DHiha5RGgu0d
         YTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693670389; x=1694275189;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnEkQcajTlSloQfs6AhM0nt/JC6HaPWBmgZ2b8nds0w=;
        b=ZJ0/KEpkrIBhd3M/agAAFQiwGNnUBCT3mUzA594sT/Ze8uIoYY2cfnU88x4LpHUXPe
         8eBhe+BwnR1lQm91R+bVF8BRmKFGT+9/XwhLVE0fp52HyVavJuaRqX9/MyDoan5s1ui7
         ehn1g2XPOCT2cBoL3O4VpiUDjfe8DCCTfFHWXGwktImYsmDoORgBoCLzFC37iTnSt2Da
         ga5uW5wOuO6U9wXJaWVIbXkQOXBCkhOjG3P1ZNR1n5v6qoCFt2/4KBXAyTxJJS13LvKK
         pTBmta2b6wT75sJj76lyb7IzcpIHCeCuluc2ep0YOj/LWqywCscmCjDM8DE692GIVXbP
         N7Xg==
X-Gm-Message-State: AOJu0YxmG0oHb9f2m0oRiWPylOzWISINkhfmbsrLIs/hHhV0oXE2bZnw
	RP9EnJthvdA2slWQv6pChn9InuEbwlQeKjlhg6mliw==
X-Google-Smtp-Source: AGHT+IHNbQyj6+mHCs/scBX7rqIDKtIjCI5Qe+jbvEVFWGZhIBJKzoOvDyF7NvyL7m3U/GHewnPAGA==
X-Received: by 2002:a9d:739a:0:b0:6bc:f276:717f with SMTP id j26-20020a9d739a000000b006bcf276717fmr5539891otk.13.1693670389356;
        Sat, 02 Sep 2023 08:59:49 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p1-20020a25d801000000b00d7baaf6094asm1465838ybg.13.2023.09.02.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 08:59:48 -0700 (PDT)
Date: Sat, 2 Sep 2023 08:59:46 -0700 (PDT)
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
In-Reply-To: <f0f6a6ec-e968-a91c-dc46-357566d8811@google.com>
Message-ID: <35f03286-eb1-b7a4-8649-a43945223fe4@google.com>
References: <c1caa7c1-b2c6-aac5-54ab-8bcc6e139ca8@gmail.com> <c3f9b35c-087d-0e34-c251-e249f2c058d3@candelatech.com> <f0f6a6ec-e968-a91c-dc46-357566d8811@google.com>
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
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 1 Sep 2023, Hugh Dickins wrote:

> Hi Dave,
> 
> On Fri, 1 Sep 2023, Ben Greear wrote:
> > On 9/1/23 5:29 PM, Bagas Sanjaya wrote:
> > > Hi,
> > > 
> > > I notice a bug report on Bugzilla [1]. Quoting from it:
> > 
> > Try booting with pcie=noaer ?
> > 
> > That fixes only known iwlwifi bug we have found in 6.5, but we are also using
> > mostly
> > backports iwlwifi driver...
> > 
> > Thanks,
> > Ben
> > 
> > > 
> > >> I'm seeing RCU warnings in Linus's current tree (like
> > >> 87dfd85c38923acd9517e8df4afc908565df0961) that come from RCU:
> > >>
> > >> WARNING: CPU: 0 PID: 0 at kernel/rcu/tree_exp.h:787
> > >> rcu_exp_handler+0x35/0xe0
> > >>
> > >> But they *ONLY* occur on a system with a newer iwlwifi device:
> > >>
> > >> aa:00.0 Network controller: Intel Corporation Wi-Fi 6 AX210/AX211/AX411
> > >> 160MHz (rev 1a)
> > >>
> > >> and never in a VM or on an older device (like an 8260).  During a bisect
> > >> the only seem to occur with the "83" version of the firmware.
> > >>
> > >> iwlwifi 0000:aa:00.0: loaded firmware version 83.e8f84e98.0
> > >> ty-a0-gf-a0-83.ucode op_mode iwlmvm
> > >>
> > >> The first warning gets spit out within a millisecond of the last printk()
> > >> from the iwlwifi driver.  They eventually result in a big spew of RCU
> > >> messages like this:
> > >>
> > >> [   27.124796] rcu: INFO: rcu_preempt detected expedited stalls on
> > >> CPUs/tasks: { 0-...D } 125 jiffies s: 193 root: 0x1/.
> > >> [   27.126466] rcu: blocking rcu_node structures (internal RCU debug):
> > >> [   27.128114] Sending NMI from CPU 3 to CPUs 0:
> > >> [   27.128122] NMI backtrace for cpu 0 skipped: idling at
> > >> intel_idle+0x5f/0xb0
> > >> [   27.159757] loop30: detected capacity change from 0 to 8
> > >> [   27.204967] rcu: INFO: rcu_preempt detected expedited stalls on
> > >> CPUs/tasks: { 0-...D } 145 jiffies s: 193 root: 0x1/.
> > >> [   27.206353] rcu: blocking rcu_node structures (internal RCU debug):
> > >> [   27.207751] Sending NMI from CPU 3 to CPUs 0:
> > >> [   27.207825] NMI backtrace for cpu 0 skipped: idling at
> > >> intel_idle+0x5f/0xb0
> > >>
> > >> I usually see them at boot.  In that case, they usually hang the system and
> > >> keep it from booting.  I've also encountered them at reboots and also seen
> > >> them *not* be fatal at boot.  I suspect it has to do with which CPU gets
> > >> wedged.
> > > 
> > > See Bugzilla for the full thread and attached full dmesg output.
> > > 
> > > Thanks.
> > > 
> > > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217856
> 
> I just took a look at your dmesg in bugzilla: I see lots of page tables
> dumped, including "ESPfix Area", and think you're hitting my screwup: see
> 
> https://lore.kernel.org/linux-mm/CABXGCsNi8Tiv5zUPNXr6UJw6qV1VdaBEfGqEAMkkXE3QPvZuAQ@mail.gmail.com/
> 
> Please give the patch from the end of that thread a try:

Mikhail confirmed it for his case, and Linus already took it into his tree:
ee40d543e97d mm/pagewalk: fix bootstopping regression from extra pte_unmap()

But I couldn't see the WARN_ON_ONCE I was expecting from __rcu_read_unlock()
in your dmesg - ah, but it is only when CONFIG_PROVE_LOCKING is enabled.

Hugh

