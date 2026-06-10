Return-Path: <netdev+bounces-297375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sNZ6MKK5KGrTIgMAu9opvQ
	(envelope-from <netdev+bounces-297375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:10:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8358C665236
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:10:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=I6eie08k;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297375-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297375-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ABE4308550D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ECC223323;
	Wed, 10 Jun 2026 01:03:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A741C5D59;
	Wed, 10 Jun 2026 01:03:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053427; cv=none; b=rIV/bM/4G2KR5XeOea/tFSSeXDce7qHTcR1VSohDlc2ENXdwbCM2Lx+2CDNtMctGDN5euOzLeivVsmcyVDBZp+0R7zy+nYWBJDsAQsdx+LfXCfHMPmoFBzwLX9FBeNgNIQ4BXXKnYY+07Zn+M281S/zdfmWb1Qhy5XZIVyoCJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053427; c=relaxed/simple;
	bh=fZBEKuDVT12AWDpvKEuztfeKBJqN88ZgmqcJ2ftIf3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJBD9WlV1+MqjAFWJiWGeKlc/iKmEyUbaJZclZj4xDXlRUC1x0WagYNFFJvayG8pckomt4ORAOLBMMI5MpBUyuuSb/mwTDA9hquW6NVRbg320ZPHaE1pOrTjFjU1U22kp9CBYCUEo11uIJ6y1QGTdH4OHtpvgFM92f0kWjSi+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6eie08k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66511F00893;
	Wed, 10 Jun 2026 01:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053426;
	bh=Mz4zABv2K+JZzneh/w8kTCcXsSuy5cWoOaYAkzYhTK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I6eie08kCH3ikrsn57Lm0Xmk5XYoLSXCRCVrAW+KhlcZTUViDdqSdwDUV/qBTUeH6
	 O31N5zNlgURhRCx18ceHy4cMCdQ+qgHkhXa0aiUALKEOYQDmbkHFQPkedN0/OOuY5S
	 rmN54C15JN8B7YQ5mFFG6gRe7apIj54MfqyWE5p9QuGCpw2YaeytC3bPuxwnykZF99
	 4+jblE8T2oYrbN6hk0J9SNnUKSdeVoxkTGtxIOAZSiLFfQt0cRjXggoIZcYXNBWsGe
	 Dey9LkzQGAvBtY1YEB4mRakKAfTMreULlJrYCcxwOah/ZtQgNvmLeYYzPj15lVnLQf
	 vd0Smwv9+0HUA==
Date: Tue, 9 Jun 2026 18:03:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-net-drivers@amd.com,
 netdev@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Edward
 Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] drivers/net/ethernet/sfc/falcon/ethtool: Use
 strscpy() to copy strings into arrays
Message-ID: <20260609180345.6650f2b4@kernel.org>
In-Reply-To: <20260608095523.2606-1-david.laight.linux@gmail.com>
References: <20260608095523.2606-1-david.laight.linux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297375-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-net-drivers@amd.com,m:netdev@vger.kernel.org,m:arnd@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:ecree.xilinx@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:davidlaightlinux@gmail.com,m:andrew@lunn.ch,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,amd.com,lunn.ch,davemloft.net,gmail.com,google.com,redhat.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8358C665236

On Mon,  8 Jun 2026 10:54:45 +0100 david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Replacing strcpy() with strscpy() ensures that overflow of the target
> buffer cannot happen.

all unit_formats are (obviously) compile time constants here
-- 
pw-bot: reject

