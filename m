Return-Path: <netdev+bounces-299530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0GeQAIcmMGoBPAUAu9opvQ
	(envelope-from <netdev+bounces-299530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:21:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 888F5688498
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:21:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QUvqjTjP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299530-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299530-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0BA3306F0CC
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D9940B386;
	Mon, 15 Jun 2026 16:12:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9D409605
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:12:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539972; cv=none; b=RHtBa6nbtJpShTUn12rpcSYEmbvvutnczlBvNFStVg6HdXJlNjUyY+1bRDDvzPzM770i4yhVTiQucvQasXdOS1nhCnryQKeU+mMSzaeC9gG6rf0C3yHTtp/bcW4en4shx8nNSUaif+qqWAG0mQkms6mRzbQcKsbALxdX1eSc0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539972; c=relaxed/simple;
	bh=YwZ+kCVyK2xSqpBm8pp4/Zv0vA+BZUfc8cwMrJdw8yw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKLmva+IjpK2SB1lxwFVpc+NVpNYGLpCAg5HSO1IRD/C74mlKDhfX2aOtq8ciMHbGDw3kmNYQw/OQqHS1PGRqKzdpoRF4aXpRqGdNEf12v3kNKxvMR0UQeN1dodWZiE+Qy3/KFDiHH9AcB4fanV0DfZVCqQF8UMgmXftUgM8j50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUvqjTjP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F371F00A3A;
	Mon, 15 Jun 2026 16:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781539971;
	bh=h4STy60C+UcS7ZfXKqBKqFZyV+JKFtqK+XBVbAB2TWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QUvqjTjP1bP3e/FYo57hpGVahgCrXsiyhTKY4kBX60Io+lpRQZP+CbuNGWJxziJ7W
	 fev7soXeIfwMesN1WyI7oZ0ztwQNKQ3HlJWt7Rcpa0fru7/stFznTPvrcz5KbU/tHZ
	 Ellwl+wDYfSbzdtnReHwr93XoXv+xxWCblpAcBYZI+CluLLgFndBdAT3NKdP6v1oyV
	 gZbT9YMyyhd1t0rvEadzKv+alm2ABRN0k6P2pJVXs+j3VKkzV1UVy58wM7GekWod2m
	 D4buPvI+6XHWDz3ZsxV+bq7hIiReQnxnQZ+lmeRFRAiIvjGJt4JJulx38d+sCvWO9t
	 991kP35PMsIpQ==
Date: Mon, 15 Jun 2026 09:12:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>, Kees
 Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@kernel.org>, Breno Leitao <leitao@debian.org>, Larysa
 Zaremba <larysa.zaremba@intel.com>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 (The Capable Hub)" <u.kleine-koenig@baylibre.com>, Fabio Baltieri
 <fabio.baltieri@gmail.com>
Subject: Re: [PATCH net-next v7 0/5] net: wangxun: timeout and error
Message-ID: <20260615091250.399ac106@kernel.org>
In-Reply-To: <20260615065016.21672-1-jiawenwu@trustnetic.com>
References: <20260615065016.21672-1-jiawenwu@trustnetic.com>
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
	TAGGED_FROM(0.00)[bounces-299530-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:gregkh@linuxfoundation.org,m:tglx@kernel.org,m:leitao@debian.org,m:larysa.zaremba@intel.com,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,kernel.org,linuxfoundation.org,debian.org,baylibre.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 888F5688498

On Mon, 15 Jun 2026 14:50:11 +0800 Jiawen Wu wrote:
> It is about adding the Tx timeout process and pci_error_handlers.
> When a PCIe error occurs, the txgbe device is able to recover on platform
> that support AER interrupt. And for Tx timeout, the txgbe driver can
> recover the device by reset process.
> 
> For ngbe devices, due to the absence of the current function, it cannot
> br fully recovered once there is a PCIe error or Tx timeout. Its
> function will be completed in the future.

net-next is closed, please repost after the merge window
-- 
pw-bot: defer

