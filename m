Return-Path: <netdev+bounces-294325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aCvrLbYcH2p5gQAAu9opvQ
	(envelope-from <netdev+bounces-294325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:11:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 293A5630F5B
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:11:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Tn9uTPgf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294325-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294325-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 070293003732
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5443264D5;
	Tue,  2 Jun 2026 18:09:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A655932A3E5;
	Tue,  2 Jun 2026 18:09:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423751; cv=none; b=Mwiio12Ao5REN0dFo5VQGoSk4Esffy9ElyUZ+Xxe9AvcQOXowGujH2nA4WWgPRHY0KQCYl+Hwmd2BrECta5DdWhTNrfpptwVl9Vnoqsk8ETnDbjz8KXdApQ5rRztatJbbHh+/NUIceak+PO+9EOr/us4+oqqDmoAPTrxn/rKlTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423751; c=relaxed/simple;
	bh=gZKBwOhQWFMxK8VXhUcXl8FPrwuuYzOd707FIGARVkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEJr9XINdN7uD0YtA6YB7YA08dixBhLvqS7aLABPemPWixTpzuq0ZFwesMMnHYd1qViVqGpe4oGAyvzFECrH8Xk0V4/WmsztnaJxguxAvHVPnJbMjIVAD16R1aSzcPuggXo9Xibc7EQMX/XndU23n6JBEsVYI3y+BmfugpjNCGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn9uTPgf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF731F00A0F;
	Tue,  2 Jun 2026 18:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780423746;
	bh=gZKBwOhQWFMxK8VXhUcXl8FPrwuuYzOd707FIGARVkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tn9uTPgf4U0NDyRm8U4SHboCRMFqRm7jFx0LY9MGO5GWbeR0+aif5+nFiMOqr8CTm
	 LXH3nYbN1zV+v6anTWTuvMvSdFCIzgKvOx778RrpBS37glhZt2Z7a3TXdgeSnA3rhQ
	 yUXRE1fSBOweAwaVw1tfM1BVfww9oHea8cXpME95iSCUcQ6nMv/PjJPy/baWHZtGkP
	 1AIig1y7AgSBUxzufYwYJ045hJgjFQXUn8PgLtL4MKUFJEldScTNc+gcFfnMvnUkP1
	 sxa6zSkgeF4TQLpf28LJboIBAHSnAENYknoczC3AdWVj/Wr1x7TOmEIh1GMcpjvrR+
	 EloD62pryZgKQ==
Date: Tue, 2 Jun 2026 11:09:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, Ping-Ke
 Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH] rtase: Avoid sleeping in get_stats64()
Message-ID: <20260602110904.47b149b6@kernel.org>
In-Reply-To: <c3ca6a679d694890828ac9e7cc2d6305@realtek.com>
References: <20260601062447.64027-1-justinlai0215@realtek.com>
	<f4b96c08-c6f7-422f-aceb-aa48fa2bfef6@intel.com>
	<c3ca6a679d694890828ac9e7cc2d6305@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294325-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:justinlai0215@realtek.com,m:aleksander.lobakin@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pkshih@realtek.com,m:larry.chiu@realtek.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 293A5630F5B

On Tue, 2 Jun 2026 10:50:13 +0000 Justin Lai wrote:
> I'll add the Fixes tag and resend this patch targeting
> the net tree.

You can just reply with the Fixes tag here, our tooling collects those
from the list, like it does review tags. No need to repost.

