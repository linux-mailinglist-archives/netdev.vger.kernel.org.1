Return-Path: <netdev+bounces-298909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jT/DL7oELWqbZAQAu9opvQ
	(envelope-from <netdev+bounces-298909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:20:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E8F67DF93
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:20:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FLpxwiUK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298909-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298909-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB573050C86
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 07:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5123B390CAA;
	Sat, 13 Jun 2026 07:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439493537FB;
	Sat, 13 Jun 2026 07:20:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781335223; cv=none; b=tllJIR26N2L5baLhpjLF3WW5o8zO+LuO/fyDJ3vUkY3P9saN0LHFX3SIx336yHa6nZuJoiho39YfOZwnMTr1reh7oOKPUJ/POBm9x8bx7uOEUP/DB1c6bmIujd87otB1IXGVF24/EAdakjZzjyhwgz8uBLFMrNL1+TcQG3fGH9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781335223; c=relaxed/simple;
	bh=000EMMK7WLb3OkYXRa/zDtdHVW8z+EQTEhVnpyjicq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akXk6XP4R/lCsOXNxqSaO1gFD7iNmt+LM5n453HVVM+VcqM1Rv7mPK5V9CTPvr8H2qM256LHntfpKUJlNiTMe+bmCQWC0IBz7P+4sWaX19NvRGXpFSsxqXeKFLxKlnREIiwmLEHEy86uvoncdaY53oGzCG1CXM1PkWDKV6JXf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLpxwiUK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4D41F000E9;
	Sat, 13 Jun 2026 07:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781335222;
	bh=mLUE4ceu8NuY6XaMIMUV6+2WUrhjPHcDpzVZyXgXFV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FLpxwiUKk/oYLyU3rqIc1Llmd5Yhu+Jz36wOA1E7he8vtkbdm+KjUynPQ4d4ByXAx
	 kEArUQK5H2wGUalhz638zcpGuLCwcYkf11XHxooa+AK0LT0xad3u7u8b67UkX7lVO+
	 jaI5kmgIqjXBshv0+LIb2G5ywupXEsrYMftMAU90ZcQ07GyJzWTfe33A0intcorq/t
	 P600GQZobNSwGsj5Tcex/MFcBYmNWsUEUz/wIj37kIgsaLB1rmcF6GVEAQu1mmpZEL
	 B9ztjTnn40pvnokW8kBViRtagsnysoZSaT7JxRRJ2O8CIcHQUC2ywrGdO75NIF9wsl
	 Cqaff6j80cewQ==
Date: Sat, 13 Jun 2026 08:20:16 +0100
From: Simon Horman <horms@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: netdev@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
	sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, amakarov@marvell.com,
	tduszynski@marvell.com, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net 0/2] octeontx2: quiesce stale mailbox IRQ state
 before request_irq()
Message-ID: <20260613072016.GA712698@horms.kernel.org>
References: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298909-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:netdev@vger.kernel.org,m:sgoutham@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:amakarov@marvell.com,m:tduszynski@marvell.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14E8F67DF93

On Fri, Jun 12, 2026 at 12:00:12AM +0800, Runyu Xiao wrote:
> Both OTX2 mailbox registration paths currently install their IRQ
> handlers before clearing stale local mailbox interrupt state, even
> though the code comments already say that the clear is needed first to
> avoid spurious interrupts.
> 
> This issue was found by our static analysis tool and manually audited on
> Linux v6.18.21. Directed QEMU no-device validation further showed that
> the real PF and VF mailbox handlers are already reachable in that
> pre-clear window and can touch the same mailbox and workqueue carrier
> before local quiesce has completed.
> 
> This series keeps the change minimal:
> 
> - clear stale mailbox interrupt state before request_irq()
> - keep interrupt enabling after the handler is installed
> 
> That closes the early-IRQ window without introducing a new
> enable-before-handler window.
> 
> Patch 1 fixes the PF mailbox registration path.
> Patch 2 fixes the VF mailbox registration path.
> 
> Build-tested by compiling otx2_pf.o and otx2_vf.o.
> 
> No OTX2 hardware was available for end-to-end runtime testing.
> 
> Runyu Xiao (2):
>   octeontx2-pf: clear stale mailbox IRQ state before request_irq()
>   octeontx2-vf: clear stale mailbox IRQ state before request_irq()

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>


