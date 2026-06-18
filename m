Return-Path: <netdev+bounces-300549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XllPGNeENGrpaAYAu9opvQ
	(envelope-from <netdev+bounces-300549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:52:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D21246A3225
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:52:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UklqvM8Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300549-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300549-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DF0F3024978
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 23:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1418733B6DA;
	Thu, 18 Jun 2026 23:52:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2491D432D;
	Thu, 18 Jun 2026 23:52:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781826773; cv=none; b=riPxQFH0tj1uKjYSPkgo2hnSd7aBA+ViZ5ZBE481CLt4O8jcaNtZEBl3hB2km3Wj1nmhktbHdqMyPMOZaYgpAF4uygPUOF4vm/CI4QEFfw5ramve5JFnLIc/Fm5+/IMAH9qFu1nojYF1oA3iFTR71cduOURBEFlhDts2U/kdKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781826773; c=relaxed/simple;
	bh=1fMqCeRAzURot3QR7lnU+VM1Zf5r7iFO0oCmPKSJWw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J02SBhJ6IfZ/EXCWPN2SI1Bg3KksOS6uMrRV77lqekXRX7nUnS4YwHdOTpRLYShNVX/NFqfihes8r5VsX29xbI6Xvy9gygPGOVLjqg87qCUlqa80gjiLiq/0E4D7Dh/kguyDg73oq3SJbW5qR3sNpqqlO15Tre40nN3tbDwUS/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UklqvM8Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E431F000E9;
	Thu, 18 Jun 2026 23:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781826771;
	bh=uUCIzc/GnjW1ATBDBpZJKy40lW/N/F06z5xK86WsEIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UklqvM8QmWzogHOkXT/md8DiJUOadKR2qXqlQJjz4HBaMRVsY58p+RkBp5GUCI1Wh
	 R2slRd5aFQWYCLDsg47OVrnXsBeu84czwgZ6Fbycbd7j4w++Ta4RBSppFaTeApdYQD
	 jZeZXP9hUbXvf3Ii/x51K90+I21P56Kdz6itQdEaxVrxNkzrH2CtLLtEQZdzNruIMM
	 B/Xid6ivj6HlxYjNIOS3DY2udJWpNQbNit+S9XGgM/sOdkv621DtwhOR3rsywkF8ss
	 kLAqXc8tmLq+GDjk9YKk44T7jitea4gPb6gntmKwc8FzlK5W7xPYtz0Dxpd9ZqyeWy
	 BfsVso+wwojEA==
Date: Thu, 18 Jun 2026 16:52:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: sanan.hasanou@gmail.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, contact@pgazz.com
Subject: Re: general protection fault in fou_nl_add_doit
Message-ID: <20260618165250.0cdfefd3@kernel.org>
In-Reply-To: <6a346fa4.26cc5c6d.1ace13.9d21@mx.google.com>
References: <6a346fa4.26cc5c6d.1ace13.9d21@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-300549-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sanan.hasanou@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,m:contact@pgazz.com,m:sananhasanou@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D21246A3225

On Thu, 18 Jun 2026 15:22:28 -0700 (PDT) sanan.hasanou@gmail.com wrote:
> We found a bug using a modified version of syzkaller.
> 
> Kernel Branch: 7.0-rc1

That's an old kernel. Did you re-run this on 7.1?

