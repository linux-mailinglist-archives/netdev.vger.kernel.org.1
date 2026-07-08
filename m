Return-Path: <netdev+bounces-305952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mxa3BSOZTmoYQQIAu9opvQ
	(envelope-from <netdev+bounces-305952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:38:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6068372994D
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:38:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=x0BNaDdM;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=XTGNHbM7;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305952-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305952-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDD883037E7E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016E44C8FF3;
	Wed,  8 Jul 2026 18:37:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CD33EB7FD;
	Wed,  8 Jul 2026 18:37:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535872; cv=none; b=Lze6/xBPleIlrLHHjZmYX9gOmqSjlqFNJV8pfs16J7dl+EB+jrzABt2FMAwV++lckBUYCAEq0ZRM27zccSwjq5BwZLZ+o0vBxq/MOFUjIPNc1/ZQKJx+YE2nU+p63btZw9NNrURNZhRsy191Pn3+nyNx0YYfDmH4D/vOZ97eiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535872; c=relaxed/simple;
	bh=IgXJAq9SYCHbCWqof8xOyQ6qnglHx0GjGd1Ey2P1qcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6gnyTZXJe5nXFZc2UbfUCw4nuRj/kTCls5/1fHfkSIti+ImG1TDS50GAqA2VA3G/miCzBJDpAVmsRX/pHLr4hvT0vbDZM6TG7o3H0KpK357BtJirACVTEtWeUNam3MmdhR8Xew80i1/9idnmkw/FXhtnb3YhHdw1Ah60/PqkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=x0BNaDdM; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=XTGNHbM7; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535869;
	bh=IgXJAq9SYCHbCWqof8xOyQ6qnglHx0GjGd1Ey2P1qcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=x0BNaDdMW/npC6xPihbAjLFu19jm9ECMSGcBHL8NRr25qhGESo6g2D2Zmyp61hE9a
	 0rIcB5slMBdbcUz9kK46mvGBbfoMszM6ODb1krICJxgnPBlChqO+roy7uRDfLBTYzP
	 jsMi7V08T9+QTMcZqIclwuFFC2reEnzCSMMZk94hJFMhNyqvh7/xhzSEtoDuwX9UEP
	 i6W4Sy5dF4EvqU5RRnZBYyNcF8O60G8X6mBJRLANXT7rQaRG81q6zwj9oElqWdNdCD
	 VLJ1Gdm9A7FfwS+LpNDXQCtwiMBlL2k+qmIAH6s+ezL88QMWwvuCE0iRoqnEwMfqPg
	 nBO1NlNIDv5gA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E3AFD4943A; Wed,  8 Jul 2026 18:37:49 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535867;
	bh=IgXJAq9SYCHbCWqof8xOyQ6qnglHx0GjGd1Ey2P1qcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XTGNHbM7hjYV3OACi0teXx/8y7p0GbWw54TiIkeO4DwZQxYywNOAL0hitGC7pwWAz
	 3jhSYjNSkkccYUQIG+bxSnp8j3BQBGJWtHyaqVb8hcAatnBNv4oBIJNc/eDWW59ua4
	 RuqGAywhETjHPN7X2gGpm1sk3+DwgI8zShvHE3h9xBY/z9chWSiw4OFiNWO9hKHv8K
	 u6qRC/JMv0IJU8f0vSrjIdaGABjMvMQcmxp0+kYO27lbs6KoUiqLIj3nRkOwZfZPaF
	 RG4EUUrsmfIY4KN+Q4DIzi1vyDjugSbU5vR8HN29UU5StqtUWgOtwy/BQ1pIXdsoCr
	 m3IUb+cMvVOLA==
Received: from [IPV6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd] (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 9CA3B493DD;
	Wed,  8 Jul 2026 18:37:47 +0000 (UTC)
Message-ID: <b6f8cb08-7f06-4a08-af79-fa2a31556acb@birger-koblitz.de>
Date: Wed, 8 Jul 2026 20:37:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ax88179_178a: Add HW support for AX179A-based chips
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-2-13685df67515@birger-koblitz.de>
 <0b75cedb-691f-44ca-891c-d42d5cd24fd2@redhat.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <0b75cedb-691f-44ca-891c-d42d5cd24fd2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:from_mime,birger-koblitz.de:dkim,birger-koblitz.de:mid,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6068372994D

Thanks for reviewing the patch-series, Paolo!

> 
> Does not build successfully:
> 
> ../drivers/net/usb/ax88179_178a.c: In function ‘ax88179_reset’:
> ../drivers/net/usb/ax88179_178a.c:2376:33: error: ‘AX_VLAN_CONTROL_VFE’
> undeclared (first use in this function)
>   2376 |                         *tmp |= AX_VLAN_CONTROL_VFE;
> 
> Full log here:
> 
> https://netdev-ctrl.bots.linux.dev/logs/build/1119419/14655119/build_32bit/stderr
Fixed in v2.

> 
> Side process note: the patch series shoudl include the target tree
> ('net-next' in this case).

Sorry about that. v2 will be sent out with correct prefix.

Birger

