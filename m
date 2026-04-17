Return-Path: <netdev+bounces-279252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDZ3FEbk4WmKzgAAu9opvQ
	(envelope-from <netdev+bounces-279252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:41:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EACBE418124
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 928BA317197E
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 07:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAF037A4AF;
	Fri, 17 Apr 2026 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="XGQ818jg"
X-Original-To: netdev@vger.kernel.org
Received: from buffalo.ash.relay.mailchannels.net (buffalo.ash.relay.mailchannels.net [23.83.222.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A564363C46;
	Fri, 17 Apr 2026 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411355; cv=pass; b=IT7pZQixw/10iOih72NbUbd9llGR98J1EJsiEmvkWlXylpQdnvWRp3oobegfuIzQOFj8LC7eA37ofVPYm44xefT14cGJb+sAzIK9fit8yCowNkiVKFrdbmgITRFJASm5g5UZYlXCeQGjSWQ4KfCu2JREWmKY9OG3iXSsNhDcyzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411355; c=relaxed/simple;
	bh=1UUVQqBD2RI7b71Kp0vhyVxQXbLQuE0evr3VahpozZo=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Date; b=i97hlw56d6uQVAkggDIwKTxlyQBnG9eooNRNNxP8VEU8wR+fomJDiiK2+Eq9SmjtCYLmvXneoNSgmCoNoVobcOcVXzM4QAJUzqNLbTW0OfAipOMMJq+qDOt76ONzfX1vJ8HFeJHi9TIQp3kIBSMsgWq2VkGVnX9LcjL7o1S3Zsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=XGQ818jg; arc=pass smtp.client-ip=23.83.222.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DAA32223A24;
	Fri, 17 Apr 2026 07:35:51 +0000 (UTC)
Received: from de-fra-smtpout6.hostinger.io (trex-green-7.trex.outbound.svc.cluster.local [100.102.173.237])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7D046224550;
	Fri, 17 Apr 2026 07:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1776411351;
	b=xwqOTTHuxZqySqgXbolI7aGsz2fNhJV3L1ETsaC4yE+dp7CvqvuiQ+rBrVMdsPq+zGk+b5
	A9Ri/iwgpGloCikYMGfKtA/hs/P+Pl95vX7Y+VeqykxF7an5PtyTVsM2oSebZqogfzkXgE
	D2w3orsAshuICG+bQhvhrQ2rmslNG79hSJXyHYDPOKNzB6nfthTgEKaqwnpubY9QBmGNb3
	9OK85+yGnu51XaBiJkGrOzex5M6B1KmCovwcaXSWJ4kI8n2ItY4iVUl4fCMhEtJO8O6r0M
	nkLTBJmNNsn/3hRTvOgFNeVYj59NzGBS9MsuICPhYC9qB0JLEPDw/XZuIXNxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1776411351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sZFa0Y6SNH7feOYzK068DAaPycmuuvoLtoILesXaXIs=;
	b=W6mziUDblUsuJWbUr81pUGH5B3dd5ZLiCCX9iIUPTeScaqldXtzsSrt/cGWhdSY8KqEgov
	KeiDdTZ1S7f9jfEitG2dbZBKVdv8ENvpwq3o2jPVWWWBApXUlwGbs9Gtyk0RcIPTNnut+F
	1q+ZoBtQ+DM/kfOH7w4xI98jszighe9nxAM4Yt6HckYktJOe1on6HUHkcrg8gnUCLmoLai
	YZrapebMRXp/nakF1aTVL+P3aoiM/bkj1Eg7aGKONZsRHAkM+aLNF//Hr5FmiF/B+FpooC
	gGoIc26hNUIt+Aesf3JPMdx0HlcxAC6+AvOLapZi5Mcbsnn9grhupRnqY9pl/A==
ARC-Authentication-Results: i=1;
	rspamd-7d86dcc447-npfvn;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=chester.a.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Inform-Slimy: 41d77b480404f0d9_1776411351723_2444533645
X-MC-Loop-Signature: 1776411351723:3074567578
X-MC-Ingress-Time: 1776411351723
Received: from de-fra-smtpout6.hostinger.io (de-fra-smtpout6.hostinger.io
 [148.222.55.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.173.237 (trex/7.1.5);
	Fri, 17 Apr 2026 07:35:51 +0000
Received: from ehlo.thunderbird.net (188-125-220-177.ptr188.nosmadeira.net [188.125.220.177])
	(Authenticated sender: chester.a.unal@arinc9.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4fxmrf1kvbz3wbs;
	Fri, 17 Apr 2026 07:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1776411346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZFa0Y6SNH7feOYzK068DAaPycmuuvoLtoILesXaXIs=;
	b=XGQ818jgpQF9iqR/beBmkyF9WPzcyfS5cxybvBAN/xMIyUhWjaayDqcTSjN7Ljy+Us8ipX
	iil2jK79/jf7kXnJFQkkU0PR3PftpGUnaxyIC5mgYhWt+B20ZMLZ3pwNFRAYCE7j2xiBqx
	RAkVX6/cu+ZBKJabkMx9BoKf6PNeIMX4cYeLfa0bnVTjekBY3EmEdpkH4JjbJdA6vh4Npl
	2e3b0rA5u+eNZiGpfT+z3i4S/b7xOC9ZtIfCXVp5ji0DH5DIEcidaylM2QowPW8FWCB0Ci
	pGRyUxXxkyiRxEqJlVHWiuUPqD279LruHQ06Choi4XcRn0lEkhyxWD6EHsPNlA==
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>,
 Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
CC: Frank Wunderlich <frank-w@public-files.de>, John Crispin <john@phrozen.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net=5D_net=3A_dsa=3A_mt7530=3A_fix_?=
 =?US-ASCII?Q?=2Eget=5Fstats64_sleeping_in_atomic_context?=
User-Agent: Thunderbird for Android
In-Reply-To: <79dc0ec5b6be698b14cb66339d6f63033ca2934a.1776397542.git.daniel@makrotopia.org>
References: <79dc0ec5b6be698b14cb66339d6f63033ca2934a.1776397542.git.daniel@makrotopia.org>
Message-ID: <C88911FE-2012-4D29-B7F2-6BEA28122854@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 07:35:46 +0000 (UTC)
X-CM-Envelope: MS4xfGMnf4xyOlqFiRWYPA7TjCq6fCjtOr83QCRHuakxWqjqJwYwN6buyRH81bL23RSsr91fdHIOrfSjLmrK7Ol1NauHM6b3Zs9t5MxTSk8z23WCRZ8oWOFD 3uTgX5R+ddPKZ4JC25csEc5ZsC9zLPUNY+1YwKSQJbvvWE+4keGwIIfkg3dKtawMm6MoGvebUjz4bCYUzePzaEELTFrOXHmYQNPY5h1dAFcPQpkGIfslaS+X XnbWog820YKIfl4aBu8AfepTFF6a6w9ZrDu4kkd4/RUPr8vSK6p0WBD8OpdC3LzaQP6N9POCPQKlG3DV1d5gG2ppmIhyu0y9HnK8ZcrMMhsjd9yBzIFw9S/F 5db+aYm3DKzjREHtclLjoLjdOgGXkuQHIoe8sHdShqGogVuoDXKBkRkAYh+axsNpOSqdkt7aCW8AWzu3RL8opJ4hCkAYZUs3KgfXmW6lRmdQqjoyIP/kxXLC KsVBc342cmx2eH680j6qPXMtnggUya22vSccCuQNhnznCwYCUcABcRJcc6ThsmOsRS76gtu1+zAGyB3dYj7WQ5gF0IiL/gq/kdjg/QWK/VGmNfbdn07k/PUJ Y9ZH77LjBmCGgWP1K2RsqVarQrcVSVqOsdsMbggPlQacKnfN4pE6Ni8IBSOjNQvfV7GfR0XpMZ89BwxiopcmSc/wTRFwY4grXIzxGSVcFOpw9M/s9hhhPsWq iBmr76jcr0Gh7XIxax18HRDNkFqpHl5SvjbXVcsRpChsevnVbHomk00jKoVjjZnp7I8ZcdNXfFg=
X-CM-Analysis: v=2.4 cv=etGNzZpX c=1 sm=1 tr=0 ts=69e1e2d2 a=KoLBVwjZwhb06KCzuzBB7w==:117 a=KoLBVwjZwhb06KCzuzBB7w==:17 a=IkcTkHD0fZMA:10 a=puQWGBksFvoA:10 a=VT4XjZGOAAAA:8 a=GvHEsTVZAAAA:8 a=zaLEu0xVIz8BohAw39kA:9 a=QEXdDO2ut3YA:10 a=6CpsfURP9XNmmWg3j1mJ:22 a=aajZ2D0djhd3YR65f-bR:22
X-AuthUser: chester.a.unal@arinc9.com
X-Spamd-Result: default: False [0.55 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arinc9.com,none];
	R_DKIM_ALLOW(-0.20)[arinc9.com:s=hostingermail-a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[public-files.de,phrozen.org];
	TAGGED_FROM(0.00)[bounces-279252-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,makrotopia.org:email,arinc9.com:email,arinc9.com:dkim,arinc9.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[chester.a.unal@arinc9.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arinc9.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EACBE418124
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17 April 2026 04:55:57 WEST, Daniel Golle <daniel@makrotopia=2Eorg> wrot=
e:
>The =2Eget_stats64 callback runs in atomic context, but on
>MDIO-connected switches every register read acquires the MDIO bus
>mutex, which can sleep:
>[   12=2E645973] BUG: sleeping function called from invalid context at ke=
rnel/locking/mutex=2Ec:609
>[   12=2E654442] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 7=
59, name: grep
>[   12=2E663377] preempt_count: 0, expected: 0
>[   12=2E667410] RCU nest depth: 1, expected: 0
>[   12=2E671511] INFO: lockdep is turned off=2E
>[   12=2E675441] CPU: 0 UID: 0 PID: 759 Comm: grep Tainted: G S      W   =
        7=2E0=2E0+ #0 PREEMPT
>[   12=2E675453] Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=3DWARN
>[   12=2E675456] Hardware name: Bananapi BPI-R64 (DT)
>[   12=2E675459] Call trace:
>[   12=2E675462]  show_stack+0x14/0x1c (C)
>[   12=2E675477]  dump_stack_lvl+0x68/0x8c
>[   12=2E675487]  dump_stack+0x14/0x1c
>[   12=2E675495]  __might_resched+0x14c/0x220
>[   12=2E675504]  __might_sleep+0x44/0x80
>[   12=2E675511]  __mutex_lock+0x50/0xb10
>[   12=2E675523]  mutex_lock_nested+0x20/0x30
>[   12=2E675532]  mt7530_get_stats64+0x40/0x2ac
>[   12=2E675542]  dsa_user_get_stats64+0x2c/0x40
>[   12=2E675553]  dev_get_stats+0x44/0x1e0
>[   12=2E675564]  dev_seq_printf_stats+0x24/0xe0
>[   12=2E675575]  dev_seq_show+0x14/0x3c
>[   12=2E675583]  seq_read_iter+0x37c/0x480
>[   12=2E675595]  seq_read+0xd0/0xec
>[   12=2E675605]  proc_reg_read+0x94/0xe4
>[   12=2E675615]  vfs_read+0x98/0x29c
>[   12=2E675625]  ksys_read+0x54/0xdc
>[   12=2E675633]  __arm64_sys_read+0x18/0x20
>[   12=2E675642]  invoke_syscall=2Econstprop=2E0+0x54/0xec
>[   12=2E675653]  do_el0_svc+0x3c/0xb4
>[   12=2E675662]  el0_svc+0x38/0x200
>[   12=2E675670]  el0t_64_sync_handler+0x98/0xdc
>[   12=2E675679]  el0t_64_sync+0x158/0x15c
>
>For MDIO-connected switches, poll MIB counters asynchronously using a
>delayed workqueue every second and let =2Eget_stats64 return the cached
>values under a per-port spinlock=2E A mod_delayed_work() call on each
>read triggers an immediate refresh so counters stay responsive when
>queried more frequently=2E
>
>MMIO-connected switches (MT7988, EN7581, AN7583) are not affected
>because their regmap does not sleep, so they continue to read MIB
>counters directly in =2Eget_stats64=2E
>
>Fixes: 88c810f35ed5 ("net: dsa: mt7530: implement =2Eget_stats64")
>Signed-off-by: Daniel Golle <daniel@makrotopia=2Eorg>
>---
>This bug highlights a bigger problem and the actual cause:
>Locking in the mt7530 driver deserves a cleanup, and refactoring
>towards cleanly and directly using the regmap API=2E
>I've prepared this already and am going to submit a series doing
>most of that using Coccinelle semantic patches once net-next opens
>again=2E

Acked-by: Chester A=2E Unal <chester=2Ea=2Eunal@arinc9=2Ecom>

Chester A=2E

