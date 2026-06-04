Return-Path: <netdev+bounces-295092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ia9iKnM2IWq0BAEAu9opvQ
	(envelope-from <netdev+bounces-295092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:25:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E675D63DFA4
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:25:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=f15e3XuX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295092-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295092-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EFBA303A116
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73263A1E7E;
	Thu,  4 Jun 2026 08:17:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA8C1F4174
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:17:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561042; cv=none; b=A37VKpNI0jLZHzm5MxFFTzoC3e6H51Rob7qGlJvEWTdei0Cpp+WioMqjmAPaUSN3KjMXPZgG5zmGziPHPd4d7tzvCUdV2iWtqlZgrlrGC+7DM20rs0qC+wx92fHJojYr93vfq7D5cRIbb5GBH1uXJqm3sYJ9jM2WKeTBGoayL00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561042; c=relaxed/simple;
	bh=MbBXDLLN2+8AL4Ih5EYGErcv9YBkh34L7MTEz/ptLxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUD5tmiNj53t9atODJWgN2bEM3NRKjy6zCW1a0U+/sUKiYNd/pWaqrPKxufng/hqZjb+OJg8/4cBD1Pkv/upi4EeYf5HUkF03PaVQyoAG0gj61AjCUCQXdPalJZmJSW47AyfrBy3Cpiv8YfVeJW0YmTvrU0wS5fZut13whCP5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=f15e3XuX; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zyVYfWEZgqIx/CQc1BEe2jo/5M+qhbsyRuWc13UO/SE=; b=f15e3XuXyyggszA8ILLWruGBYF
	rZn2V/nhqLu1lpx0pHYD7NlPRK0etmLgcX53VCHPNbVs5ziJQWvKzOuaee8768+NZfsf0hC/B6ayG
	9cUIfqfoY6B3BtM80bkaMHM3Y4X7shnifyWoeUIzUsZnm9nQFXTU+yl9mPay/bELpo4GVZmzV7lMB
	XC50MvomF2X/VqIRo/Y9P0cBDvhzQgGxsWKuWp7yoje6tg6fqP7XWS3cBNPxCcqdDTvph4rUqahQO
	DD+HxHG8OiSj5Gr6ocmDpUEmxQ8VSroq5HyVZLldxJXzXxlnpuMSHY8QDorF8c/+QgRd+wPQLdyJz
	JGwl+BQw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wV3GK-004Nel-02;
	Thu, 04 Jun 2026 08:17:12 +0000
Date: Thu, 4 Jun 2026 01:17:07 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, sdf@fomichev.me, 
	aleksandr.loktionov@intel.com
Subject: Re: [PATCH net] Reapply "bnxt_en: bring back rtnl_lock() in the
 bnxt_open() path"
Message-ID: <aiE0Z74p1ey14I5A@gmail.com>
References: <20260603195845.2574426-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603195845.2574426-1-kuba@kernel.org>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295092-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:sdf@fomichev.me,m:aleksandr.loktionov@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E675D63DFA4

On Wed, Jun 03, 2026 at 12:58:45PM -0700, Jakub Kicinski wrote:
> This reverts commit 850d9248d2eac662f869c766a598c877690c74e5.
> This reapplies commit 325eb217e41f ("bnxt_en: bring back rtnl_lock()
> in the bnxt_open() path").
> 
> Breno reports a lockdep warning in bnxt. During FW reset the driver
> may end up calling netif_set_real_num_tx_queues() (if queue count
> changes), so calls to bnxt_open() still require rtnl_lock.
> 
>   net/sched/sch_generic.c:1416 suspicious rcu_dereference_protected() usage!
> 
>    dev_qdisc_change_real_num_tx+0x54/0xe0
>    netif_set_real_num_tx_queues+0x4ed/0xa80
>    __bnxt_open_nic+0x9cb/0x3490
>    bnxt_open+0x1cb/0x370
>    bnxt_fw_reset_task+0x80d/0x1e80
>    process_scheduled_works+0x9c1/0x13b0
> 
> The reverted commit was just an optimization / experiment
> so let's go back to taking the lock.
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Link: https://lore.kernel.org/ah726OtFX-Qw3U-R@gmail.com
> Fixes: 850d9248d2ea ("Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

