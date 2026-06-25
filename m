Return-Path: <netdev+bounces-301847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qndGLpKWPGqXpggAu9opvQ
	(envelope-from <netdev+bounces-301847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:46:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C036C2733
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:46:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kp0oRg3s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301847-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301847-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A18A63022056
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F72279DC9;
	Thu, 25 Jun 2026 02:46:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EACF22D7A9;
	Thu, 25 Jun 2026 02:46:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355599; cv=none; b=ttH+C6BdhPUQsDWNdKvhlQujRG9aIyqkQcCGFOj1SGfvqeLFENp9K0pTeGuCBd10cCXCSumWQGMNs3POWlKOpnPHu37jrrusHH7qnAVzg5HMZCjHf+xwlHkleI+kzoOOOQHku05ElGESsZXQRh+E3p4kHHR+42egH9WFh3go/II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355599; c=relaxed/simple;
	bh=BhzY+rbfs1JEflXE0RnwVSiR6UjR3BP2XZSAPZGKsxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X++ygu61/stdRSdKV+N+ZTOm4n9NyFtTWp0xCHY6PPhcAMhEj4PnMFKscCo+TQ6IPPfa0yioyBKsAXIWxec2ZXEWt6hJVROTpj5WbTlxB+RKgJaN+XxfImgeT/rjEQ5F4cFsE6iyUs58uZ7MZITxD7OK1NUI7xYAzVWuT7GDh2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp0oRg3s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE4E1F000E9;
	Thu, 25 Jun 2026 02:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782355598;
	bh=qqLSgi8tZ+sERewRYYSbz/rljystIb5K9oefx4Of0ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kp0oRg3s+3H8r8m+ZpvKw/98d0lCjuDOKnIatwbX2sAltpkHMZDJEcv9sgHscCn9c
	 YEy/VppRdKc8AamXDZlVZcPKNtWDw+aFDDnlI69bdw+XGi97BY7Up6BMDuGD2Xwvfy
	 PeAxHRgR5gsOguaHipSHchCzBDXxDa9nEDuiH40sreUvUhaFK41IpimUL80jd17ITz
	 KKysud7FR4U6suqPu5tJbHs9jE1E0m31mgZ7Uaz8E7eVsSSOeEA54Yd8M4jyn9rxz9
	 W+hmJUNvTxU7toxSHb0kjyRl43EKh/KJFvcV78bcZVmX9xMk8v8X4c1BpF302pJwb2
	 DAGv9XbLlcrbA==
Date: Wed, 24 Jun 2026 19:46:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: madalin.bucur@nxp.com, sean.anderson@linux.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] fsl/fman: make enable() return void
Message-ID: <20260624194637.51158fd8@kernel.org>
In-Reply-To: <20260625005600.3400023-1-haoxiang_li2024@163.com>
References: <20260625005600.3400023-1-haoxiang_li2024@163.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301847-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:madalin.bucur@nxp.com,m:sean.anderson@linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03C036C2733

On Thu, 25 Jun 2026 08:56:00 +0800 Haoxiang Li wrote:
> The enable() helper always returns 0 and has no failure path.
> Make it return void and update the only caller accordingly.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.2,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after June 29th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


