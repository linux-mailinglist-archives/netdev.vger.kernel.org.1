Return-Path: <netdev+bounces-298349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oHNKOq0dK2qe2wMAu9opvQ
	(envelope-from <netdev+bounces-298349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:42:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D18F6753E9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:42:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VBp4UK2A;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298349-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298349-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E6B4302808A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B31C4C9544;
	Thu, 11 Jun 2026 20:42:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256E369206
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:42:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210532; cv=none; b=UyiouNW0hNKyXpVVFCzqUhUXDF44fYaLectwbJMN2q0uSfgn5xnfWjAFUjDyJgwmjARg+FnEQWW3c9FXGHf9jAQG41QQ7tcqSfotvKXl2dsI3gOL5l0AKfyo9WRh19JmredABJRCDviCdVBqwupip3CqU7/VNSZaWmSgxWc0dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210532; c=relaxed/simple;
	bh=DZoh7eHDw1pjLYVXJOvOB3qcHVXYn6hq7RYP/gXthgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0+cNzreNAvnHQ3inLnAG8F/3HXmj5XecncJCjejL8xIXL70/YsikcK2J6p5GO6TDSnmadABahCmRnZyONf5ecvaVcWVDxoX+uSbibDqowtnFLqhIXZN5fbWT9YRnijRxO9BgR3FI1SIjStKVsYFCNC3EYc/XgFbdZFU1Gm/TBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBp4UK2A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2051F00A3A;
	Thu, 11 Jun 2026 20:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781210530;
	bh=DZoh7eHDw1pjLYVXJOvOB3qcHVXYn6hq7RYP/gXthgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VBp4UK2ApMEOQIqjP3mHQc2VMikWbA5LHo3Jq+5NfQhLVvq3FV0kghLMRRrRiu/Qg
	 VJzLU/lPi7XDf0SJZrkWNOx2L/eROgmmzJJJC2Jyqz/WSXBF86Ysq9Qz59Nk2opUm/
	 UyLMTDLJFmPYtpIkOO2DiNtynDY32jgA2Mv+HFAszQxQJyZgcCg7dgozw2onYaLY3B
	 0W9lbLATGC01BUgIx/fSpTTkfU4WgjFN5/pJmA6651vsSaFGPTiUybwu1s/FqUTmPf
	 EJmy6bXn++px9hx0vNUrkMeM+w/QBWe8kfkEf4VBChPRyKSeVR+upXbwqgM+weUMyq
	 x5b92nZqSwUCw==
Date: Thu, 11 Jun 2026 13:42:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, Tonghao Zhang
 <tonghao@bamaicloud.com>
Subject: Re: [PATCH net-next] bonding: add sysfs interface for
 broadcast_neighbor
Message-ID: <20260611134209.37e3b040@kernel.org>
In-Reply-To: <1f949cfc-eebc-4813-9dfc-b9a9ec79494d@blackwall.org>
References: <20260610120812.49054-1-laoar.shao@gmail.com>
	<1f949cfc-eebc-4813-9dfc-b9a9ec79494d@blackwall.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298349-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:razor@blackwall.org,m:laoar.shao@gmail.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:tonghao@bamaicloud.com,m:laoarshao@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,bamaicloud.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D18F6753E9

On Wed, 10 Jun 2026 15:30:11 +0300 Nikolay Aleksandrov wrote:
> Then update your iproute2 package, sysfs use for options is discouraged
> and is not being extended on purpose. Move to netlink.

FWIW -- ynl also supports rtnl and bonding options, so even less of a
reason for sysfs these days.

