Return-Path: <netdev+bounces-272469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULC3JG9HxmmgIAUAu9opvQ
	(envelope-from <netdev+bounces-272469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:01:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5863416A7
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CD2A30474CC
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D793D9DA6;
	Fri, 27 Mar 2026 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZNWkgPYO"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279353D8134;
	Fri, 27 Mar 2026 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601844; cv=none; b=Fhje0eyzv68OJKJ/0Or43dtdC5FWVP7NrxsWf/XnF/ioVnP8AZ5vkOTgOEaPKbCLq59tyWTtYC9oKq2+ft1w13SmxXEmHcRPd19jDS5K/O/6xEEOO36Hzzf8zCCW4pnNJHz94nle+iNCesgPaQl838dEq1xsTCI/nik00GSuJSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601844; c=relaxed/simple;
	bh=2DihIhE9AlPJDi2G5eFd7c4OwoVutuYzGxb0IOq9hgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRO/eYRT1nDseRFCsBYUUwanTCD19RO85M+zdmmXb+mwpGAhwSX3wRnKPaRMOFj3Djgpqcb+jUFlZakNhfiQWQCZj7lHIWMjayBhWUH3zBip1PPmRLiKh5AR5ZeYsWynccfbholkCbDeO5TeJ5PSx/O0tVg12DH60HzxhbIORqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZNWkgPYO; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 244AAC40404;
	Fri, 27 Mar 2026 08:57:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 79AFE60230;
	Fri, 27 Mar 2026 08:57:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E7B010450F33;
	Fri, 27 Mar 2026 09:57:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774601840; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=pvtElVp5xygJ6fmrxxIv/UTyawbe5ihs7mmlh0Bvlds=;
	b=ZNWkgPYOZFB97dJPdBse30Q3KfyKnoLqh70FMFPJPbRLEBen5uMAw7s4fTufVsrGx6uJ3p
	69JK09RcYJKRy42FD0vQjshPO0o54NMmyOKFsmOan9f2VqVNzt5StGKPEqC0WMLkVR7Jd6
	PxYMGdmjTRkZcFZZhF2Pif3b4C+gk1+y9S7LzWN7Xf3cejhxUs+j4YpySPi2QNUuQtRqhV
	Wod3GQeQOonohYWQLYc5MJsXmXuPDR9piYOVmwxi7sqwuu9C8r/TrIot9A9lQEP/pxb5ZW
	c6QxB1DAaCY6mnVFhhz6lwnr4H6Ulpy2EWb7mFbtX2REXEJKG4pt72UlQo/knA==
Message-ID: <e4495d4b-8613-4f28-aee9-7eb1d292ccaf@bootlin.com>
Date: Fri, 27 Mar 2026 09:57:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/12] ethtool: Add loopback netlink UAPI
 definitions
To: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Naveen Mamindlapalli <naveenm@marvell.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Leon Romanovsky
 <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Saeed Mahameed <saeedm@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260325145022.2607545-1-bjorn@kernel.org>
 <20260325145022.2607545-4-bjorn@kernel.org>
 <20260326152337.2cff3c24@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260326152337.2cff3c24@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272469-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com,kernel.org,nvidia.com,bootlin.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: ED5863416A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26/03/2026 23:23, Jakub Kicinski wrote:
> On Wed, 25 Mar 2026 15:50:10 +0100 Björn Töpel wrote:
>> +      -
>> +        name: depth
>> +        type: u8
>> +        doc: |
>> +          Ordering index within a component instance. When a component
>> +          has multiple loopback points of the same type (e.g. two PCS
>> +          blocks inside a rate-adaptation PHY), depth distinguishes
>> +          them. Lower depth values are closer to the host side, higher
>> +          values are closer to the line/media side. Defaults to 0 when
>> +          there is only one loopback point per (component, name) tuple.
>> +      -
>> +        name: supported
>> +        type: u8
>> +        enum: loopback-direction
>> +        enum-as-flags: true
>> +        doc: Bitmask of supported loopback directions
>> +      -
>> +        name: direction
>> +        type: u8
>> +        enum: loopback-direction
>> +        doc: Current loopback direction, 0 means disabled
> 
> u32, Netlink attrs are padded to 4B anyway

That's my bad, I was the one suggesting u8 :( I didn't have the padding
thing in mind at that time :/

Maxime

