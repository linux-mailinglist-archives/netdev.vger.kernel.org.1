Return-Path: <netdev+bounces-294339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0dJfAdMiH2o3hwAAu9opvQ
	(envelope-from <netdev+bounces-294339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:37:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E079463123B
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:37:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ad7zBaJc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294339-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294339-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84B193006921
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E7C3955FE;
	Tue,  2 Jun 2026 18:35:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F99392C2A;
	Tue,  2 Jun 2026 18:35:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425342; cv=none; b=ZfqCdYKGafeD5LqVR2oDKOCoeDW1ite7SeeE9/82nipXlTD53zaX+y+HPrQ+yaG+ZuroFr9urUdbCnbt3/7vUbX6dqgRpV+ttgaQAXEWMY72zkzs99mzv1UGNNWD7s5cHzUCVY8f5kZUwQ99cNlaUXmR4VEJw0WdJ/x8bErmkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425342; c=relaxed/simple;
	bh=Hya/UdUh3aa9UmIrMS6FKrBFfOGCGENfCShgMLRp/zA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHL7+xB8lwxMj9Hvs4oOi3DEvRTyMqw+LQIJ34QX5UKnoWsbQ0Wst6EMDlhUWgnonVtf5gg9elqt/rkZbm9IMqD0R6lNxuuGallO4sXFmKckb1O2j+T4tzB3fVfTtlCBbiTD5ZQw6OuJhKd3OSQnCENA4CsuARP9EfyREC+tkzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad7zBaJc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4A91F00893;
	Tue,  2 Jun 2026 18:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780425341;
	bh=7kcXypgquC2xK5CHUVjnx1SyX6pAdVky6vU+VX4o3a4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ad7zBaJcs9Gw3VWTB5r1gJU0wg5FIB1kTmiOsXqmvurE9CNjcPTwcanWXE/jCq2WH
	 kPHBjFEcsH61rzrt8CyUaOxq/Eo9X/UCzDtJ06s6dbkZBJGtckvR7b/LcDu/rA0lGf
	 rUny2/F0T/TLmkxqK8HIM9hCycDTotXjUEgJ/ssbJj34pe4EZ5yhoG/rDoEijL/KBM
	 yjvOZqoH5WWpHxwgQcbDQ3ACkKqH2MbVNh3lF5iOCx9OGnJ4P6Uu1zDg7tiqTaSoa9
	 dvfofCqG6yRxXJZog0YhXDiG0HGgZk77/RgpdsCDkurw1AFqE+uQwWR6I+/Pe+A+ny
	 Ug1qEfcBpawIg==
Date: Tue, 2 Jun 2026 11:35:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Yury M." <yurypm@arista.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: tg3: guard napi_disable and
 pci_disable_device calls
Message-ID: <20260602113540.2243f7f1@kernel.org>
In-Reply-To: <208dc7c2-971b-4335-bd64-a107be8c6018@arista.com>
References: <20260527115535.1686932-1-yurypm@arista.com>
	<20260601195049.766544fb@kernel.org>
	<208dc7c2-971b-4335-bd64-a107be8c6018@arista.com>
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
	TAGGED_FROM(0.00)[bounces-294339-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yurypm@arista.com,m:pavan.chebbi@broadcom.com,m:mchan@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E079463123B

On Tue, 2 Jun 2026 12:12:39 +0100 Yury M. wrote:
> On 6/2/26 03:50, Jakub Kicinski wrote:
> > On Wed, 27 May 2026 11:55:35 +0000 Yury Murashka wrote:  
> >> During PCIe hot-plug events, uncorrectable errors can be reported and
> >> AER recovery for the tg3 device is initiated by the AER kernel driver.
> >> The tg3_io_error_detected function is the AER error recovery handler.  
> > IDK, I really hate this NAPI specific tracking. Can we add a callback
> > to struct pci_error_handlers to let the driver know that things went
> > fully belly up and the driver should pack up its toys? Sounds to me
> > like the key issue here is that there's a side exit thru the state
> > machine.  
> 1. We already have a similar check in the bnxt driver. Please check the 
> BNXT_STATE_NAPI_DISABLED flag.

I'm painfully aware.

> 2. I'm trying to fix a specific issue in this specific driver.
> 3. Your suggested changes are a long-term option for the fix. They 
> require a redesign of the AER feature. Plus, I'm not sure they will be 
> accepted.

There's only one way to find out.

