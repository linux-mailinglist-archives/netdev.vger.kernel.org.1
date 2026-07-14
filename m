Return-Path: <netdev+bounces-307399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B6X3B0/9VWrmxQAAu9opvQ
	(envelope-from <netdev+bounces-307399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:11:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E4D752B23
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:11:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=Og+Gnu9V;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307399-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307399-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA6B6309E3F5
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7D43CECA;
	Tue, 14 Jul 2026 09:09:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C063632B100
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 09:09:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020192; cv=none; b=NAV0zkEW+xCYW67KpdFu1Flrism9ort9WWqkwxRm5PmVQHXKVShEZHJeqEu/6m3mFf4GkIJI+PuLoiG6pE8aMnW7TtpHUMSios1ifU+Wf9K2kFynGHISgAxmCngXZR6I5ArTE1xOy8oYIYIeNPj0Mo1yRZthyPus64522pfcygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020192; c=relaxed/simple;
	bh=WZ2FWZnT9dmDPMzlD5FMdwCiYfQY2yZo7icyCqbtwQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pa7kgGnqcR+HYN9V4J7hvcEXzVdMOfZIa2A7Ar4rHhx8++BaFC3hmjLBTH+jRVoOLjxNHSFpACnbuBVwE7TKlkRPsdsRrD/IrrHmI4m9/0VgzKcmik5NuK2R242e5zzU8vE7q+Cr44iCXhrbUiJ6CqlhQukIbcQ2bjiZ0ax/yw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Og+Gnu9V; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C19964E40DA5;
	Tue, 14 Jul 2026 09:09:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 798D660346;
	Tue, 14 Jul 2026 09:09:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E13F511BD3B3A;
	Tue, 14 Jul 2026 11:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784020180; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ozSa3T9ij+0lBWz7LHW34zppRGNM+3YLXw6TADfiaAM=;
	b=Og+Gnu9VdoPhUouB0iDiUx5rU+l/y4uo9o2CPSCbqSpTi7WO54hAq6lCHBf48GQ7Wm5O9X
	wdCEx7ZL6RRNr+FRb3cxjISSBOJbJUUvLEesiTLGLztt8l5LbT1lmA+jCfFGPDbRdMLfwC
	JHQgRv2gQQk09rY5T6GrccVa00Y5lHWl1j9l+Curv7qypMsjhJ5G1Dy7OehMw3R5IjPv3O
	xcKKDYbJhkJi4PQ+L97zhGXbaEoTHlgp8l6LgjAHYqtVfIOv0GRJlgvPYGIphHIP7FPaVF
	WZA7DozlH35dYUfRAgg47CA4koWBCeuT3xLQXltVhEtw5s2rIlFlhJqzC5pxFw==
Message-ID: <222c0e2e-93b2-4209-b20e-0895090cf655@bootlin.com>
Date: Tue, 14 Jul 2026 11:09:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] net: stmmac: fix l3l4 filter rejecting
 unsupported offload requests
To: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org
References: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260714023716.29865-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260714023716.29865-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307399-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:from_mime,bootlin.com:mid,bootlin.com:email,bootlin.com:dkim,vger.kernel.org:from_smtp,altera.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67E4D752B23

Hi,

On 7/14/26 04:37, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The basic flow parser in tc_add_basic_flow() does not validate match
> keys before proceeding. Unsupported offload configurations such as
> partial protocol masks, non-IPv4 network proto, or non-TCP/UDP transport
> proto are silently accepted instead of returning -EOPNOTSUPP.
> 
> Add validation to return -EOPNOTSUPP early for:
> - No network or transport proto present in the key
> - Partial protocol mask (only full mask supported)
> - Network proto is not IPv4
> - Transport proto is not TCP or UDP
> 
> Each rejection includes an extack message so the user knows which part
> of the match is unsupported.
> 
> Also propagate -EOPNOTSUPP from tc_add_basic_flow() in tc_add_flow()
> by returning it directly rather than using break. The break was silently
> discarding the error for FLOW_CLS_REPLACE operations where entry->in_use
> is already true, causing tc_add_flow() to return 0 (success) for
> unsupported replace requests.
> 
> Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


