Return-Path: <netdev+bounces-204247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F8EAF9AF8
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 21:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65623B543C
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263EF78F32;
	Fri,  4 Jul 2025 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l68ysHwa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF71520ED;
	Fri,  4 Jul 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751655694; cv=none; b=WDXPEe/uqZfUrb0AMc/bEIItZ/RqGeainFdDwxiEOiUSsmhkMuM1Pt18gGMa/ij8i88z29NwG2+hAOocBELaIQ3vi1DMDqAwXG7dafQPsYVr1NfpY6m9JuQ1D1kIxDLKfPVMWjbQTVBxsZ8uDxh0XOxlswlHcn+mQxiuAKoPS/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751655694; c=relaxed/simple;
	bh=nv17Saw3Fdh+J4Wo0yhTSTltT33k+ZRe5jgVr3g9wJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btKSJmllykkPhzJ2gtw9ZkhQ+W3nolwqh8r43DbQw6K7k7b4V6uXe+l2uduPJ5o4bMa+1YaVZjqU/umQO7YC0nvSdhsMvRM8qI6HcEeUT1dD9BSZa9PEWteBhWFMUiC1PsPDGEkW5Ep4lfAFENPpi8dbZdfOEO4RTW9X9Dg66vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l68ysHwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F71C4CEE3;
	Fri,  4 Jul 2025 19:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751655693;
	bh=nv17Saw3Fdh+J4Wo0yhTSTltT33k+ZRe5jgVr3g9wJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l68ysHwanmSrrr9KKyhEGwdMozT8d4ArZDiFt/Srr0HCx8TwkBEOcEDhp0NzFmzpI
	 A1Hd865ta5tcjHn4pMYYzcAKiP/PBf4QxCe9FDyfGLJaBK0LYGfLBZRseMwcavszSd
	 71IFd1cQzjCdztnFc0YiYroiMda0cfALJMx7pULbJ9dK0aFq792n0U1xnrPO2SjSDA
	 QUfGnstQAxDCDiWiQWITTZbdiP/zj7+LVOdEgrQEtaoXsSeS1H/npcmE2m8euQfGXe
	 yfcqvlTi6rSdH6uhYOAWSts0rEhhuCp6OvzB5uWWfNk0g6m6+V5/N/BtSHsNK8IDod
	 DexPsoOlsxJ6A==
Date: Fri, 4 Jul 2025 20:01:28 +0100
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mingo@kernel.org, tglx@linutronix.de,
	pwn9uin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: atm: Fix incorrect net_device lec check
Message-ID: <20250704190128.GB356576@horms.kernel.org>
References: <20250703052427.12626-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703052427.12626-1-linma@zju.edu.cn>

On Thu, Jul 03, 2025 at 01:24:27PM +0800, Lin Ma wrote:
> There are two sites in atm mpoa code that believe the fetched object
> net_device is of lec type. However, both of them do just name checking
> to ensure that the device name starts with "lec" pattern string.
> 
> That is, malicious user can hijack this by creating another device
> starting with that pattern, thereby causing type confusion. For example,
> create a *team* interface with lecX name, bind that interface and send
> messages will get a crash like below:
> 
> [   18.450000] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> [   18.452366] BUG: unable to handle page fault for address: ffff888005702a70
> [   18.454253] #PF: supervisor instruction fetch in kernel mode
> [   18.455058] #PF: error_code(0x0011) - permissions violation
> [   18.455366] PGD 3801067 P4D 3801067 PUD 3802067 PMD 80000000056000e3
> [   18.455725] Oops: 0011 [#1] PREEMPT SMP PTI
> [   18.455966] CPU: 0 PID: 130 Comm: trigger Not tainted 6.1.90 #7
> [   18.456921] RIP: 0010:0xffff888005702a70
> [   18.457151] Code: .....
> [   18.458168] RSP: 0018:ffffc90000677bf8 EFLAGS: 00010286
> [   18.458461] RAX: ffff888005702a70 RBX: ffff888005702000 RCX: 000000000000001b
> [   18.458850] RDX: ffffc90000677c10 RSI: ffff88800565e0a8 RDI: ffff888005702000
> [   18.459248] RBP: ffffc90000677c68 R08: 0000000000000000 R09: 0000000000000000
> [   18.459644] R10: 0000000000000000 R11: ffff888005702a70 R12: ffff88800556c000
> [   18.460033] R13: ffff888005964900 R14: ffff8880054b4000 R15: ffff8880054b5000
> [   18.460425] FS:  0000785e61b5a740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [   18.460872] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   18.461183] CR2: ffff888005702a70 CR3: 00000000054c2000 CR4: 00000000000006f0
> [   18.461580] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   18.461974] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   18.462368] Call Trace:
> [   18.462518]  <TASK>
> [   18.462645]  ? __die_body+0x64/0xb0
> [   18.462856]  ? page_fault_oops+0x353/0x3e0
> [   18.463092]  ? exc_page_fault+0xaf/0xd0
> [   18.463322]  ? asm_exc_page_fault+0x22/0x30
> [   18.463589]  ? msg_from_mpoad+0x431/0x9d0
> [   18.463820]  ? vcc_sendmsg+0x165/0x3b0
> [   18.464031]  vcc_sendmsg+0x20a/0x3b0
> [   18.464238]  ? wake_bit_function+0x80/0x80
> [   18.464511]  __sys_sendto+0x38c/0x3a0
> [   18.464729]  ? percpu_counter_add_batch+0x87/0xb0
> [   18.465002]  __x64_sys_sendto+0x22/0x30
> [   18.465219]  do_syscall_64+0x6c/0xa0
> [   18.465465]  ? preempt_count_add+0x54/0xb0
> [   18.465697]  ? up_read+0x37/0x80
> [   18.465883]  ? do_user_addr_fault+0x25e/0x5b0
> [   18.466126]  ? exit_to_user_mode_prepare+0x12/0xb0
> [   18.466435]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   18.466727] RIP: 0033:0x785e61be4407
> [   18.467948] RSP: 002b:00007ffe61ae2150 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
> [   18.468368] RAX: ffffffffffffffda RBX: 0000785e61b5a740 RCX: 0000785e61be4407
> [   18.468758] RDX: 000000000000019c RSI: 00007ffe61ae21c0 RDI: 0000000000000003
> [   18.469149] RBP: 00007ffe61ae2370 R08: 0000000000000000 R09: 0000000000000000
> [   18.469542] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> [   18.469936] R13: 00007ffe61ae2498 R14: 0000785e61d74000 R15: 000057bddcbabd98
> 
> Refer to other net_device related subsystem, checking netlink_ops seems
> like the correct way out, e.g., see how xgbe_netdev_event() validates
> the netdev object. Hence, add correct comparison with lec_netdev_ops to
> safeguard the casting. Since the *lec_netdev_ops* is defined in lec.c,
> add one helpful function *is_netdev_lec()*.
> 
> By the way, this bug dates back to pre-git history (2.3.15), hence use
> the first reference for tracking.
> 
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> ---
> V2 -> V3: add a helpful function to ensure the changes can compile.
> 
>  net/atm/lec.c | 5 +++++
>  net/atm/lec.h | 2 ++
>  net/atm/mpc.c | 5 ++++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/net/atm/lec.c b/net/atm/lec.c
> index 73078306504c..46f0b5a00200 100644
> --- a/net/atm/lec.c
> +++ b/net/atm/lec.c
> @@ -565,6 +565,11 @@ static const struct net_device_ops lec_netdev_ops = {
>  	.ndo_set_rx_mode	= lec_set_multicast_list,
>  };
>  
> +bool is_netdev_lec(const struct net_device *dev)
> +{
> +	return dev->netdev_ops == &lec_netdev_ops;
> +}
> +

Can start_mpc() run on dev before this function is called?
If so, does the check above still work as expected?

>  static const unsigned char lec_ctrl_magic[] = {
>  	0xff,
>  	0x00,
> diff --git a/net/atm/lec.h b/net/atm/lec.h
> index be0e2667bd8c..399726484097 100644
> --- a/net/atm/lec.h
> +++ b/net/atm/lec.h
> @@ -152,4 +152,6 @@ struct lec_vcc_priv {
>  
>  #define LEC_VCC_PRIV(vcc)	((struct lec_vcc_priv *)((vcc)->user_back))
>  
> +bool is_netdev_lec(const struct net_device *dev);
> +
>  #endif				/* _LEC_H_ */
> diff --git a/net/atm/mpc.c b/net/atm/mpc.c
> index 583c27131b7d..48ce67a1cf4d 100644
> --- a/net/atm/mpc.c
> +++ b/net/atm/mpc.c
> @@ -275,6 +275,9 @@ static struct net_device *find_lec_by_itfnum(int itf)
>  	sprintf(name, "lec%d", itf);
>  	dev = dev_get_by_name(&init_net, name);
>  
> +	if (!dev || !is_netdev_lec(dev))
> +		return NULL;
> +
>  	return dev;
>  }
>  

1) Is this code path reachable by non-lec devices?
2) Can the name of a lec device be changed?
   If so, does it cause a problem here?

> @@ -1006,7 +1009,7 @@ static int mpoa_event_listener(struct notifier_block *mpoa_notifier,
>  	if (!net_eq(dev_net(dev), &init_net))
>  		return NOTIFY_DONE;
>  
> -	if (strncmp(dev->name, "lec", 3))
> +	if (!is_netdev_lec(dev))
>  		return NOTIFY_DONE; /* we are only interested in lec:s */
>  
>  	switch (event) {
> -- 
> 2.17.1
> 

