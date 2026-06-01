Return-Path: <netdev+bounces-293895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO+oKBnaHWr6fQkAu9opvQ
	(envelope-from <netdev+bounces-293895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 21:14:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B91E624822
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 21:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EA6230598FF
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 19:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8910E37E30F;
	Mon,  1 Jun 2026 19:14:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5061937EFE3;
	Mon,  1 Jun 2026 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341253; cv=none; b=JQbtiXzzKe7jzbjYh/38M+XGlpfWYhed80lq6/jvPLm+AB3sPieWVkyPNtv0N6IV96LH3YciP64k3P5l337i38USbPO56pzLZGYCzht0AZIRufaE4gpJaYZTEAVea8vyKwDAimjB77q9C24fr8SM1RffblsC/Qua5JLahyI4XnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341253; c=relaxed/simple;
	bh=2GZdPKnuDFwv9TzCgyR3qloWSbuzRFCFLEo3Yn12uUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5i5HFUI5vMZsqCEbgLIWLpVtxJ2UPSLp3ZBDnwAh4pDSINiO7h14ETOEGyQpxNxJD69hfiKnjPPLLHrJYeGb4KYf/y3uqUsT+Jkq9NT4CmXLAGPgZ5qIJkLB8dEUKJy3XpY08ObYPa/n9qBCS3JxVAI7fk1LWNvr5VXlPDlEhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B756460AA2; Mon, 01 Jun 2026 21:14:08 +0200 (CEST)
Date: Mon, 1 Jun 2026 21:14:08 +0200
From: Florian Westphal <fw@strlen.de>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: net-next 32-bit clang build error in
 net/netfilter/nf_synproxy_core.o
Message-ID: <ah3aAO7oFuh7xei5@strlen.de>
References: <20260528123911.284536-26-johannes@sipsolutions.net>
 <178001352190.1565998.2039430206651171575.git-patchwork-notify@kernel.org>
 <a28df759-d0e9-41c0-97c7-5f89a18d54e2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28df759-d0e9-41c0-97c7-5f89a18d54e2@oss.qualcomm.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-293895-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Queue-Id: 2B91E624822
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jeff Johnson <jeff.johnson@oss.qualcomm.com> wrote:
> wireless-next/main has fast-forwarded to e7d6bd24e883 and I'm in the process
> of also fast-forwarding ath/ath-next, but I'm seeing a build failure:
> 
> In file included from ../net/netfilter/nf_synproxy_core.c:7:
> In file included from ../include/linux/skbuff.h:26:
> In file included from ../include/net/checksum.h:21:
> In file included from ../arch/x86/include/asm/checksum.h:9:
> ../arch/x86/include/asm/checksum_32.h:149:6: error: inline assembly requires more registers than available
>   149 |         asm("addl 0(%1), %0     ;\n"
>       |             ^
> 1 error generated.
> make[5]: *** [../scripts/Makefile.build:289: net/netfilter/nf_synproxy_core.o] Error 1
> 
> This is with "ARCH=i386 LLVM=llvm-19.1.7-x86_64/bin/"
> 
> I use a config made via: make $allmodconfig
> 
> A lore search doesn't show any recent instances of this issue.
> 
> Rebuilding from scratch shows the same issue.
> 
> Any thoughts?

Happens since 403cec8ab6d0 ("netfilter: add option for GCOV
profiling").  'allmodconfig' sets CONFIG_GCOV_PROFILE_NETFILTER=y

Same problem after revert or plain 7.0 when I set CONFIG_GCOV_PROFILE_ALL=y
(which depends on !COMPILE_TEST so its off for 'make allmodconfig').

