Return-Path: <netdev+bounces-295416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RAUXKY/gIWpwQAEAu9opvQ
	(envelope-from <netdev+bounces-295416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 22:31:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 789086435AB
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 22:31:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WFVdvQVg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295416-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295416-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7420305687E
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 20:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A9C2472B6;
	Thu,  4 Jun 2026 20:27:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E302305687;
	Thu,  4 Jun 2026 20:27:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604867; cv=none; b=lcRnIglIy29F0Fb07rZIVfz9BbhdHfZhnlgAT+8aQCaQPSoCirq6DZBQDdttlr5ev4cssEE4AXgCOHGEJa6MF73Ax9aerkPkbgNBq6s19/mrUl14dXPqjK/3KHqooSKeab2FycGi+GhHnuareU6kmYK9iJbK9HZJLKJ40UR20mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604867; c=relaxed/simple;
	bh=ejZO0+YHvSC6cN1LsWOGJBdvJceZZp5oXWQLJx3JaI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZwcWMSpIV3MqS5YrovbC8x643vVVXBhO+c1D1lsZTZTnJnGCnazRleUo9qnmEx9zrdgygiAs0WDtTMECNH6tOJYiKB57WZiNnRxU/LcgyjxNVFBvxRJ0hhLN8fjUbN8jG9wiNNmOZxpg7xm+/2sRt0UiV8dT0UVcMWZn3BfTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFVdvQVg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF7B1F00893;
	Thu,  4 Jun 2026 20:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604866;
	bh=qlbBo0BasZ82nFDL8mjICrf2XEvRYJ6dG1w7R6FaHQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WFVdvQVgMEwFersfhvSiAG7LFn7pfTaJsJ+LyT30LRy+IVIlR1tRZOWWrOX1SfmFs
	 2bCd0JzbmIC7k4gKXCaz/nK3t/58JA5CIJpm0Z4Xf0BPbjxStiahPyiPcHuTlCV/ZZ
	 ZxIxI1I7LOYLQA3/wZ+qowj6hS8TJhJ1kF+n/QDPwHaRVarCvVug08fLx2ZWW+9U5d
	 QW0MQryyQz60uB7iMUuf+hNS8pYoyh6kgEvSgHXuAzumsBMDxLP1eSLmWYH/w3K/YO
	 0cDpS3IqvKQHSRJNlMQ5l3CekJ6PkfOhQtY3Lc6elTnPd+o9ssD6g/YLUkK78EnLEf
	 m2Lp9PiDH90eQ==
Date: Thu, 4 Jun 2026 13:27:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Networking <netdev@vger.kernel.org>, Johannes Berg
 <johannes.berg@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20260604132745.7b24401d@kernel.org>
In-Reply-To: <aiGJDaHV4UlCexIQ@sirena.org.uk>
References: <aiGJDaHV4UlCexIQ@sirena.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295416-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:broonie@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:johannes.berg@intel.com,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 789086435AB

On Thu, 4 Jun 2026 15:17:49 +0100 Mark Brown wrote:
> Caused by commit
> 
>    cb9959ab5f996 (wifi: cfg80211: enforce HE/EHT cap/oper consistency)

Hi, stupid nit but FWIW the quoting format seems to be off in this
notification type - missing quotation marks around the subject.

