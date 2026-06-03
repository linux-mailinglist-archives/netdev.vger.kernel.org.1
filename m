Return-Path: <netdev+bounces-294745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9kdVJCglIGpnxQAAu9opvQ
	(envelope-from <netdev+bounces-294745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:59:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3B7637C8C
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:59:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=WWtIP2He;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294745-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294745-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A976F30B5A43
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2269746AF27;
	Wed,  3 Jun 2026 12:53:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63A3C769F;
	Wed,  3 Jun 2026 12:53:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491216; cv=none; b=ZAvsyOEYMtghKpBGPrpSA5iQx8VVBDSJ5ecFS+ksEPSy84N8kkKd7yP6fBKmWtpPeil2WMlQmKznQcdYtzhgYfoVbDEIvrWolOrOc/ygADlpC7i5ViNPFU6hZtHBrfoQC4WJsFh7FJEsewjVG5ka2fKXhJaIJNMnfJZPIXheK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491216; c=relaxed/simple;
	bh=0a77u00Cn4EaVqOsZqzGDCQxFKPaDEqfan7/n3ITd28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+fqNKskJMTGmgTBOdGteG6M8/nrin/Q74Y0zE6pmwf8Jaz6KtWlZhyfFPlI3M5bodZO+hvlPSqxvbfpoHZxBNhgPtsv0edT9ymisYKRWRbY84M2jMVwdIG0Lcm2aPaPmF7fAHdY1YAtx0cDg8HrkRoeUaqQQnhgP+qWPQc+C2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WWtIP2He; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uC1PhjryjQEehRxVK6H0z0ohScXVNe3TGPj343eUIGw=; b=WWtIP2Heus+2IUH1D00ixJCf51
	DnBQTlSIAczHHayMHsqUWyBiiiEBDuzOxezDVdkod2+SvU2SO6w4EVk+PCAZWWT3RAyjDCg1iaWDs
	cdpb8wwhX6fTZil6QGQ5aSuvqGlZst8GYJ2UsPoh6IDwSzvqL7lw+NMemCAqnXPs9gy8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUl62-005sV4-2v; Wed, 03 Jun 2026 14:53:22 +0200
Date: Wed, 3 Jun 2026 14:53:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shaoxu Liu <shaoxul@foxmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] rndis_host: add Telit LE310X1 RNDIS USB
 ID
Message-ID: <ec67be00-2fd9-4fd2-9478-8073ef314e65@lunn.ch>
References: <20260602090528.2544-1-shaoxul@foxmail.com>
 <tencent_F1AF1F5AD39C56485BD16C6DB2415E5B9508@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F1AF1F5AD39C56485BD16C6DB2415E5B9508@qq.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294745-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:shaoxul@foxmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[foxmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,foxmail.com:email,lunn.ch:mid,lunn.ch:dkim,lunn.ch:from_mime,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC3B7637C8C

On Tue, Jun 02, 2026 at 05:05:27PM +0800, Shaoxu Liu wrote:
> Add a device match entry for Telit Cinterion LE310X1 RNDIS interface
> (VID:PID 1bc7:7030).
> 
> This is a functional no-op and keeps using the generic rndis_info for now.
> Power-management behavior is handled in a follow-up patch.
> 
> Signed-off-by: Shaoxu Liu <shaoxul@foxmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

