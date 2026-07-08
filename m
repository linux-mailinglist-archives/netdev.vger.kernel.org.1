Return-Path: <netdev+bounces-305950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8OVoLVmZTmooQQIAu9opvQ
	(envelope-from <netdev+bounces-305950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:39:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B084729978
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:39:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=FWnKfKcP;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b="QRQwhK/6";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305950-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305950-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B94DF309D206
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7B34CA291;
	Wed,  8 Jul 2026 18:35:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F014CA289;
	Wed,  8 Jul 2026 18:35:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535757; cv=none; b=pw6Rq7noyfUp+VwPesKo9W6BlOBZV+Zq23G1HHWPjZ3Mls1QwDnIXz1h9nOjC4BiRad4ddEDNSHhm/O04Hoi5RrEKuiXlAoUKskndxnU9Dag7cDVpNlOR5DFqbNkBmq+OT07jgAoeoSxAm4+Ima8+xutjZqKFWEcGv5LXzmYKu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535757; c=relaxed/simple;
	bh=1UEiUotR6YP92NkOtC0IXPBWHRIN+4TvnG0Ic8rM18I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSWoVfTna1ugE4EV5+NUaswLhxPZNfcWPQnesUuWr1KM7CE4R+cuTmaL8NhCR84LQ4UsPPJ+oVjz28UMoUlv4BSJDVgX4SxLL5Yb0PNifuAVMMA1gYIh8fWtx57fVcTn6crEuaSe9Wl0onV3SGtqnR1An49Rob9aSULny1ZV1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=FWnKfKcP; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=QRQwhK/6; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535754;
	bh=1UEiUotR6YP92NkOtC0IXPBWHRIN+4TvnG0Ic8rM18I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FWnKfKcPJ+Bo6FdHNhg+DcBetKJ2DRFbpzfqsI2dBiOPf2//eirTfiVRZVpSrgQTp
	 /cGdnitsevHOBe7zv8R9PDVU3xBtvqD5Lit6xm6DyJor/wIupGC78LYIL22bIrH7ne
	 AeLvhNziOq2uIOdkt67RQyaoOWOZQiY50vpKgvrCHW9e4ReuT8bS7j32iccYByVHXE
	 VnNfWJjFPO+7E/w8Hyi0dag9T4XkmLRSopkiB/tJEZ/4+3q2EVmhCXNwfuU4AgsNLn
	 NNPGsi5EWQm7gmjqYYyRykFOo9XYhbSdgH/mfAIjpFeJfhuWCRnjoAnw3UdOlg4qWW
	 WmCHWAyGoIF9g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 80566493ED; Wed,  8 Jul 2026 18:35:54 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535753;
	bh=1UEiUotR6YP92NkOtC0IXPBWHRIN+4TvnG0Ic8rM18I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QRQwhK/6TkNjg0/MpyB0m8g8dejsEO/L8YFWCGddhNwZoMjARZye8PpKLcJA6E7W/
	 rshdyiVv2YN8pdgrmveNNORo3/X45aTPet01S+oblx/o25x/x8sfdDUKypIXenr1TY
	 YPuyzbLL8CZ4OU0ek1e2zxUXcahIvwFHls3Jd4mAP4/oD2C34UBu5eiZTN3ZzooTcr
	 Q+UVZDp7ono4yR751SES23uVl0vuVmJ6dzP7x7+ijvmZFfBuPfgBEWqJ5gQYCHi5Y8
	 kln4ufi/uHr6Pj1JxByR54xhjzP3LUDaoL2IscF00i/wu/Re38yqCu2SDvy8xXlEYC
	 8qY1MiqjwTkFw==
Received: from [IPV6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd] (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id A8EAB493D0;
	Wed,  8 Jul 2026 18:35:53 +0000 (UTC)
Message-ID: <547ea4c5-85e5-40a5-9724-61a3e2418a31@birger-koblitz.de>
Date: Wed, 8 Jul 2026 20:35:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] ax88179_178a: Add support for ethtool pause parameter
 configuration
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-5-13685df67515@birger-koblitz.de>
 <587499ee-d87e-4056-8d2a-8fda2ef3f0f1@bootlin.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <587499ee-d87e-4056-8d2a-8fda2ef3f0f1@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305950-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,birger-koblitz.de:from_mime,birger-koblitz.de:dkim,birger-koblitz.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B084729978

On 7/1/26 12:04, Maxime Chevallier wrote:
> pause autoneg is not the same as link-wide autoneg. If link autoneg is disabled,
> you have to keep track on how pause autoneg was configured by user, so that this
> can be re-applied when link aneg gets re-enabled.
> 
Will be fixed in v2 as suggested.

> The best way to have this correct is to use phylink, but for that you'd need to
> have a proper PHY driver instead of using the mii_ API here.

phylink was discussed elsewhere.

Birger

