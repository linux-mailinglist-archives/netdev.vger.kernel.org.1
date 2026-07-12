Return-Path: <netdev+bounces-306987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mzNeD40TVGoDhwMAu9opvQ
	(envelope-from <netdev+bounces-306987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 00:22:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9520474625B
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 00:22:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="Zlz/oish";
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306987-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306987-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBC0C30262F4
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F6F37DAAE;
	Sun, 12 Jul 2026 22:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662937A4B9;
	Sun, 12 Jul 2026 22:20:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894836; cv=none; b=Ql4bnVzQgscb1td/kjdWVOPnpL7uCAaJXGm0Kwn2OTeAWHh8nODhfZS9OKuRtYfHlVGepXtN+B/GXHiD5n6P/FA2wnfhyUlee7+gl/tpfQ6wrgvefK6dAZejFpnsfiDCGNsvHE2lSWRIxyYRLtnhMtiZyOSSxv9wEGqTEwfqqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894836; c=relaxed/simple;
	bh=l8L1S0WVJd3eIxG600JhnGrxD1zRu3/XiIkZq2hIjPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cac+eiMZJyC/I9uIwBCIVkc0Qae4H273dKog3HtzXlBzcWXVbyIjwNoxA8wCsTEG6TJF7Y2wc8lilyefXfHyKa1+br1teYWA1mYw67PjDlQBo5Ajfp2qWudYvp8ayHURczrVunGojMFfweTr4xEOK1QuVONXKafgVg79TAg6TfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zlz/oish; arc=none smtp.client-ip=91.218.175.178
Message-ID: <165fca2f-2259-42c0-bac7-58685a4c5ebd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783894822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6q/hlROSEnFud0PHhVOe6WrK0uQOXKUk0FXkjVG+KKw=;
	b=Zlz/oishFwOb1KgPbTqWMa2/pW9Au8C36nuXU/NgYYU8l/sEKuyLaHd6q95t7HcLRKKN0x
	OdofgN+is6lVy2iZdZd4PHrXEdD9DXaMjXH3Ut3EL9cN7G/SaTdpCvWkbfBG9T9aPIB5l/
	bvQhJL10FL2Gdt6qmnkCw7s+XvqpwEk=
Date: Sun, 12 Jul 2026 23:19:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: rnpgbe: Pass an expression directly in
 rnpgbe_rm_adapter()
To: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Yibo Dong <dong100@mucse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-306987-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[web.de,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,ti.com,redhat.com,baylibre.com,mucse.com];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:Markus.Elfring@web.de,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:danishanwar@ti.com,m:mgr@kernel.org,m:pabeni@redhat.com,m:u.kleine-koenig@baylibre.com,m:dong100@mucse.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9520474625B

On 12/07/2026 19:35, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 12 Jul 2026 20:25:10 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function “rnpgbe_rm_adapter”.

The null check in rnpgbe_rm_adapter() looks more like defensive
programming, which got into the code unnoticed. pdev will not exist if
netdev is not allocated, where mucse is netdev private data.

