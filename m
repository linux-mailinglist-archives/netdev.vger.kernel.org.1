Return-Path: <netdev+bounces-285198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gESvNqhZ/GnMOQAAu9opvQ
	(envelope-from <netdev+bounces-285198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:21:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B4E4E5B61
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC2293191C0C
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5C63A1E7E;
	Thu,  7 May 2026 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq3QP/GO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75F39C003;
	Thu,  7 May 2026 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144230; cv=none; b=nyyypDB4KX7cISqIWfu0DopTd2kRCaWmij/blitgdT/00fZrbZMmV8Kj7vG4Sb55HKmGxpv/8aztNV7/gZly+RpMyquzhOnTg9CiGg9bpXPE55leGRwKRN4Ni2jmMdmfS6F06xAVY5rEptrMfS4p4LpS4AEHxH4+5054i+Ks1fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144230; c=relaxed/simple;
	bh=KHnsuv8PSnzH3bS4Zcp1oie8hhZSPC5c5EQTgXJTpMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dHjYMMwyGv65FO+H7aQDn4TQqNVSAWg/Gsc4qP4xE3o+cUMbstzjburPVst6Sn9owsSeKfa7Zru/QXNTuKWjJpLzDXxF6ChXTL7JK0dOF3+Q4T+HMfsGMR0WmX0Cr1EzOFqiiBmHXzoLnhGaFtkdpielx8I1//nINE60c0m0tEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq3QP/GO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F43C2BCB2;
	Thu,  7 May 2026 08:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778144227;
	bh=KHnsuv8PSnzH3bS4Zcp1oie8hhZSPC5c5EQTgXJTpMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lq3QP/GOCve19nvoroqfZJ19IVDZVeohvuT58U/VtY8+5Kl83xNeudbdtkgB0vJI6
	 Ad6hKlqqAq+hb1UQsq6xT0PA4pjbPjg01RbrSr+d/nhi95S83WBjLh556eu1kgCUn6
	 7hMoKRb7PKUyy+SSb/IoUPFp8LXhYnIw2peWfgp+NckuMivTwgCUuBnNjaJIC6JY0b
	 L4DrYR29zYniG8vQx3+PYZuVfoU9ZgrBSd32sJIV0Jh3vUh1+P26UgY8FFgpqwsMlv
	 kEOgANOZMAgdIhPUBUywazzYZk1xQLymoEis13wAiJIgB8IJycIuStCh+5tCcljUo6
	 NHQvUxAsdNXXg==
From: Thomas Gleixner <tglx@kernel.org>
To: syzbot <syzbot+ae231e0552fa77b26ea1@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, peterz@infradead.org,
 syzkaller-bugs@googlegroups.com
Cc: bridge@lists.linux.dev, Nikolay Aleksandrov <razor@blackwall.org>, Ido
 Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Subject: Re: [syzbot] [kernel?] WARNING: ODEBUG bug in smpboot_thread_fn
In-Reply-To: <87qznowlfs.ffs@tglx>
References: <69f88fc0.050a0220.3460d5.0004.GAE@google.com>
 <87qznowlfs.ffs@tglx>
Date: Thu, 07 May 2026 10:57:04 +0200
Message-ID: <87bjerwqan.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 77B4E4E5B61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285198-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev,ae231e0552fa77b26ea1];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Wed, May 06 2026 at 18:29, Thomas Gleixner wrote:
> On Mon, May 04 2026 at 05:23, syzbot wrote:
>>
>> ------------[ cut here ]------------
>> ODEBUG: free active (active state 0) object: ffff888033a47278 object type: timer_list hint: br_ip6_multicast_port_query_expired+0x0/0x380 net/bridge/br_multicast.c:-1
>
>                                                                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> An object which contains an active timer is RCU freed....

Unlike the other timer in the same object, the own_query timer is not
shut down in br_multicast_port_ctx_deinit()

Something kike the below.

Thanks,

        tglx
---
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2030,8 +2030,10 @@ void br_multicast_port_ctx_deinit(struct
 
 #if IS_ENABLED(CONFIG_IPV6)
 	timer_delete_sync(&pmctx->ip6_mc_router_timer);
+	timer_delete_sync(&pmctx->ip6_own_query_timer);
 #endif
 	timer_delete_sync(&pmctx->ip4_mc_router_timer);
+	timer_delete_sync(&pmctx->ip4_own_query_timer);
 
 	spin_lock_bh(&br->multicast_lock);
 	del |= br_ip6_multicast_rport_del(pmctx);

