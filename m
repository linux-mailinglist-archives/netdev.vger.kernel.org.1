Return-Path: <netdev+bounces-280532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0uxrGw8S6WlOUAIAu9opvQ
	(envelope-from <netdev+bounces-280532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 20:23:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFDB449AE8
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 20:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81B9C30406A5
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2038C2DF;
	Wed, 22 Apr 2026 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7q0e6QS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998A717DE36;
	Wed, 22 Apr 2026 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776882188; cv=none; b=gVWOcKCGTGHtKyE7zN85BqcL34A2BqVyMDnLfvD/ZTC2+F2KCZRccFS9ABxhkT0f6cSMP4/VYXG+N6J65QyGywap6cgLf2jk8mqsJQPtD5bC5VYGDAyg1jMSJx2/wyEA8Oba8V81u84ja7yTwbRAYj9+sktZPpB9Fj0En2+vnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776882188; c=relaxed/simple;
	bh=ObVVfZ7MFRaxaEq78UjYsEvYcdtg2AtIl4XwzsM5VaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tD/gOBfUKyS0hVp+wHSfpA+Vu75eXiyQUSXAtEt7t6q8r0K351siMBI/+fBzU+HWC4Yl8Lxrp2lDuRXdkhMXV9yaH8lrZCdlJK+RGLcChkMR/xbzkTbnAzXIextMROJr2ZrUgIrSL7K/CbNVobhB9mgJu3lgVa7gzcOW3d7pbFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7q0e6QS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9463C19425;
	Wed, 22 Apr 2026 18:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776882188;
	bh=ObVVfZ7MFRaxaEq78UjYsEvYcdtg2AtIl4XwzsM5VaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7q0e6QSbMf6LZdq+iHFpNWQUhWS/t9eaSBbO1iIChuv1F2ivt5WfcEUr82CNscQJ
	 +pSsUCNyQ6BZIUr0+cfBImsWepP1fVPPitudPcm0N6k+9O7BfOPpY/gfj2JNmHzkxw
	 30SDQxHlItKU6V/CTRaAPTPdYGFoaTwoGqw2JNJdT7k9GUoFcP9pI9rrV3TRWNNzEV
	 c+eEEYNeoUGbJTTW+zhzD2NYy5EPodyHPAvMJAMQMNjcTUYFtXH0OPnMjTcFi+ykT+
	 H7jJWe7C+3GnAQ4hplSbrMftJKPjcrp7PTHyMQZphhjjZadttiMjnGDyByIVVorliU
	 LUBQH3xB6Vpcg==
Date: Wed, 22 Apr 2026 19:23:02 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net v2] net: dsa: mt7530: fix .get_stats64 sleeping in
 atomic context
Message-ID: <20260422182302.GR651125@horms.kernel.org>
References: <58aff8b5b1d691872342a6ffd3315f27854788a6.1776595131.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58aff8b5b1d691872342a6ffd3315f27854788a6.1776595131.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280532-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org,linux.dev,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arinc9.com:email]
X-Rspamd-Queue-Id: CEFDB449AE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 11:43:05AM +0100, Daniel Golle wrote:
> The .get_stats64 callback runs in atomic context, but on
> MDIO-connected switches every register read acquires the MDIO bus
> mutex, which can sleep:
> [   12.645973] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:609
> [   12.654442] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 759, name: grep
> [   12.663377] preempt_count: 0, expected: 0
> [   12.667410] RCU nest depth: 1, expected: 0
> [   12.671511] INFO: lockdep is turned off.
> [   12.675441] CPU: 0 UID: 0 PID: 759 Comm: grep Tainted: G S      W           7.0.0+ #0 PREEMPT
> [   12.675453] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
> [   12.675456] Hardware name: Bananapi BPI-R64 (DT)
> [   12.675459] Call trace:
> [   12.675462]  show_stack+0x14/0x1c (C)
> [   12.675477]  dump_stack_lvl+0x68/0x8c
> [   12.675487]  dump_stack+0x14/0x1c
> [   12.675495]  __might_resched+0x14c/0x220
> [   12.675504]  __might_sleep+0x44/0x80
> [   12.675511]  __mutex_lock+0x50/0xb10
> [   12.675523]  mutex_lock_nested+0x20/0x30
> [   12.675532]  mt7530_get_stats64+0x40/0x2ac
> [   12.675542]  dsa_user_get_stats64+0x2c/0x40
> [   12.675553]  dev_get_stats+0x44/0x1e0
> [   12.675564]  dev_seq_printf_stats+0x24/0xe0
> [   12.675575]  dev_seq_show+0x14/0x3c
> [   12.675583]  seq_read_iter+0x37c/0x480
> [   12.675595]  seq_read+0xd0/0xec
> [   12.675605]  proc_reg_read+0x94/0xe4
> [   12.675615]  vfs_read+0x98/0x29c
> [   12.675625]  ksys_read+0x54/0xdc
> [   12.675633]  __arm64_sys_read+0x18/0x20
> [   12.675642]  invoke_syscall.constprop.0+0x54/0xec
> [   12.675653]  do_el0_svc+0x3c/0xb4
> [   12.675662]  el0_svc+0x38/0x200
> [   12.675670]  el0t_64_sync_handler+0x98/0xdc
> [   12.675679]  el0t_64_sync+0x158/0x15c
> 
> For MDIO-connected switches, poll MIB counters asynchronously using a
> delayed workqueue every second and let .get_stats64 return the cached
> values under a spinlock. A mod_delayed_work() call on each read
> triggers an immediate refresh so counters stay responsive when queried
> more frequently.
> 
> MMIO-connected switches (MT7988, EN7581, AN7583) are not affected
> because their regmap does not sleep, so they continue to read MIB
> counters directly in .get_stats64.
> 
> Fixes: 88c810f35ed5 ("net: dsa: mt7530: implement .get_stats64")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v2:
>  * use spin_lock_bh()/spin_unlock_bh() to prevent potential deadlock
>  * rate-limit mod_delayed_work() refresh to at most once per 100ms
>  * move cancel_delayed_work_sync() after dsa_unregister_switch()
>  * add mt753x_teardown() callback to cancel the stats work
>  * fix commit message

FWIIW, I looked over the feedback generated by Sashiko for this patch,
and I believe the issues it flags are false positives.

