Return-Path: <netdev+bounces-299015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EJa7MtqhLWpHiAQAu9opvQ
	(envelope-from <netdev+bounces-299015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:30:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A3067F4F4
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:30:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Tu862N2v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299015-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299015-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 043613011760
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879813090F5;
	Sat, 13 Jun 2026 18:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BE2C3768;
	Sat, 13 Jun 2026 18:29:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781375383; cv=none; b=WrzhEI2AUabgJkFA2lSL9QCcMQs5RXodMIAzJbjAgYVxB0VvG62d2vdgrF0iQMGRYR1/QF5jHaxIUvbek9wdTDVanKC/xLfpwVWs3AlC8/Sf+3CosZ6vW6kPrRGAc+S5znUtQLp8ntp+2AWbj5Xg+L8BCaWoo8rv8nwhDZFY38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781375383; c=relaxed/simple;
	bh=odhDIPcmbzSFuqoxnLoIctZ7h3NQAX+GnBVpYDbr8i8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEwp0hf5ga+7wz3Gk4UGnGCO8DwaqzY8b2M35qoMZIhKKf+Brze0QsGEKTM118dSQNAUGkAtvZRKykAlO3RCJ7Hdloe/k4IZdke3i3SRUKfNdOBmqwskjNizjXzZ8BCxuqiCKHdNugaxZhnw886PUb9sL3X39T5iOKbm3Fi9AtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu862N2v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13E01F000E9;
	Sat, 13 Jun 2026 18:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781375382;
	bh=gF727nZWftSXwKewt3391E5lZl87wD+IcPkpef8dLKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tu862N2vey18lzZiVIY/QTNjsaZBal0RR7RihTnqySWxoBrIMd1TjUVkkUDUZwDat
	 ZU3fZZExDDkv/AbRRxlGUrkbjZgbF4sNfOnc/SjM+/kXM4S3rN7Jl2mzclMSQCW3fy
	 RrnvTs+gPHbXqlznjLp4srmnWmrdphsSg5TjCXU6PL/FWYO7BN6tnt7HfQeHv9nhjg
	 Jt8S+ivOUZiLUTzamQocQ1dyemo2dpLKW92K7OUkallGqUg5M2yVWnlUFfIcIOdJGb
	 TFsGoGjNknkpFTeK7DEwKrNGuU4YVylQQWrc1iiRSG8SqOFD3GAENhN7arY4WwRljl
	 0c+O1/WJJ3+gA==
Date: Sat, 13 Jun 2026 11:29:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 sdf.kernel@gmail.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 luka.perkov@sartura.hr
Subject: Re: [PATCH net-next] net: sparx5: change ndo_set_rx_mode_async
 return type to int
Message-ID: <20260613112940.05bba5ff@kernel.org>
In-Reply-To: <20260611101151.426050-1-robert.marko@sartura.hr>
References: <20260611101151.426050-1-robert.marko@sartura.hr>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299015-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:robert.marko@sartura.hr,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:Steen.Hegelund@microchip.com,m:daniel.machon@microchip.com,m:UNGLinuxDriver@microchip.com,m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:luka.perkov@sartura.hr,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,microchip.com,gmail.com,vger.kernel.org,lists.infradead.org,sartura.hr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27A3067F4F4

On Thu, 11 Jun 2026 12:11:13 +0200 Robert Marko wrote:
> Commit ("net: add retry mechanism to ndo_set_rx_mode_async") changed the
> ndo_set_rx_mode_async return type to int, however it did not update the
> SparX-5 driver.
> 
> So, simply update the sparx5_set_rx_mode return type to int, propagate
> return from __hw_addr_sync_dev or simply return 0.
> 
> Fixes: d90b85c23b3d ("net: add retry mechanism to ndo_set_rx_mode_async")

This commit does not exist, as I said in:
https://lore.kernel.org/all/20260507091012.7eeb17f5@kernel.org/
the first two patches of that series were _not_ applied.
-- 
pw-bot: reject

