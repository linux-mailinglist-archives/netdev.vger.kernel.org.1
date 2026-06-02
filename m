Return-Path: <netdev+bounces-294322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DGzRMBwbH2oPgAAAu9opvQ
	(envelope-from <netdev+bounces-294322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:04:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 193DB630EBB
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:04:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nwHcIuu1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294322-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294322-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3428430459CE
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 17:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5131F3FF884;
	Tue,  2 Jun 2026 17:54:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08323FDBFD;
	Tue,  2 Jun 2026 17:54:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422897; cv=none; b=MqfVqUxTq8xKIrx6ZHkXni4XVidX7iVaIrLjRI0mk5o0cjGCr5Bi157+SmvClce25zWNEJ9JDNE1m3y0WeuHhlDZWEly+12QijMQQ60NgU2qtLv05MREjnGKvR8IjJTDvg3Mi7A2yRMLANbkNkdabS5e4D+mB5VL7q6DHt9v25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422897; c=relaxed/simple;
	bh=DvCBSLijMmUehZDN7BL7ZQVfGkdmcQHWOlVEMk6Dbvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XT7SsQE7Ok4PgdrTyA+cE1O1iIF3QhqeuHM53QWEt3Gr/dw3U8/lH56oo8lca36rsqNAsF8xUhDKeRA6SOSvAERAxYNi/KXTlKcqz5BXbkxXu1IcPWuUtmtv3T04EQKR+f21SIT9iUgx0wWIj6dcbBhRj2R2D05w+AwwPB0y2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwHcIuu1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DC01F00893;
	Tue,  2 Jun 2026 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780422894;
	bh=GKc/rx9c0FGYhJ5we5IkWoI6K2nf82lJdy9YDt3Co+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nwHcIuu1i0fuvDfS6+57Nb7sQ0B0g05eo+K8d16OelMizlHYeFFcenJHn5cD1n6HN
	 rQS+aykB5PE2HwmG6FmU/TcDP2Ea58XjBws8RD9JCXfMFZmdJlm1Ryv1SwzU1HA5S8
	 0rGAekdgIuJ9HbHHlrJuPJy9RytXw62F6KogNaDjocOpw3GGknM4Nm6OIkymLIBuXP
	 2LmAbAJMd2krUC3aw6eoV8YppEhX2U8/N3TDdFPumG7i3aReiDuJkBvUhhzSzJ0a0n
	 OIs2AM3fJjKJSyD2h0xe3ZAekNogGy5+twgPTlEUGkJYb93jSneX9F0wZ/mnyFCE59
	 /KApCR8hYuuMQ==
Date: Tue, 2 Jun 2026 10:54:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 stfomichev@gmail.com, kernel-team@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: bnxt_en: suspicious RCU usage in bnxt_fw_reset_task() qdisc
 path in 7.1-rc6
Message-ID: <20260602105451.18a7390f@kernel.org>
In-Reply-To: <ah726OtFX-Qw3U-R@gmail.com>
References: <ah726OtFX-Qw3U-R@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,meta.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294322-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:stfomichev@gmail.com,m:kernel-team@meta.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 193DB630EBB

On Tue, 2 Jun 2026 08:33:31 -0700 Breno Leitao wrote:
> This looks like a regression from:
> 
>   850d9248d2ea ("Revert "bnxt_en: bring back rtnl_lock() in the
>                   bnxt_open() path"")
> 
> That revert dropped rtnl_lock() from the bnxt_open() paths and left
> bnxt_fw_reset_task() holding only the instance lock around bnxt_open().
> 
> I can send a patch restoring rtnl_lock() around the bnxt_open() call in
> bnxt_fw_reset_task() (re-taking rtnl before the instance lock, matching the
> pre-revert code), but I wanted to report it first to make sure I am in the
> right direction.

Yes, we need to revert the revert. Per my recent ethtool locking series
netif_set_num_tx_queues needs rtnl_lock for now.

