Return-Path: <netdev+bounces-304505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1rM7JY6ZR2q6bwAAu9opvQ
	(envelope-from <netdev+bounces-304505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:14:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE1701B23
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:14:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-dortmund.de header.s=unimail header.b=Z8mODJ3v;
	dmarc=pass (policy=none) header.from=tu-dortmund.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304505-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304505-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13621310B67A
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC33D9DCC;
	Fri,  3 Jul 2026 10:44:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C933D9520;
	Fri,  3 Jul 2026 10:44:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075479; cv=none; b=hQkwnhjapV7taRAuSdAfiLSxpF5kuPdtwKqWDDQmaWZdf6+SuyJNxrBTwjqgw8Awx5Q3xyfwfJ12RnDcgZN9BX5ZC7YzVlFs6BK+she3nfr5vyVWGT1fc1AP+8U+dxynUj0UhXFysfFr74DSSUWDR4O8I3X8RrOfUiGbqATs5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075479; c=relaxed/simple;
	bh=XnxoIlVwr9J3rE7etf3DG7iiZqvV3ZVvgQqIrj4dN14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEYbazPooAA2VbwdfnZ1SXr9wLunEJI8g4CIPdXYDc+6qgN4rqJWmR5/byrWvQuRdyYfzOv0K2FnkF4fQ/jp3MftOK1Cg4/w5D4+mdO0emqu3VI2ZeUoAFamIQ1YHKLUZZvMDyOhlgo/6H4SvW7os13x7LjgPA5BrenCYuS0DAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=Z8mODJ3v; arc=none smtp.client-ip=129.217.128.51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1783075279;
	bh=qctwS9LPST2/33+gavfp9uKFDcxocIgaWfG6gvJZ2CM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z8mODJ3vew8ISCrnXa3eXTetlCZc4xBF8FSQ1qPgQyn3Fb4c1/4sk3Au0bUu+7Anc
	 2FXZxL8TQ+tkGKfCWEvTsAxIKshd6XWREyKa4uE5m57D945kwRZPC6b8KRIRORRmp2
	 oaRXnp0rQoddd/bL6jD827WscgeVFZ8f29Q3YszE=
Received: from [129.217.186.105] ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 663AfJMl029086
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 3 Jul 2026 12:41:19 +0200 (CEST)
Message-ID: <a1bae349-61a1-4c65-a531-179850576642@tu-dortmund.de>
Date: Fri, 3 Jul 2026 12:41:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
        Tim Gebauer
 <tim.gebauer@tu-dortmund.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org, Brett Sheffield <bacs@librecast.net>,
        regressions@lists.linux.dev, netdev@vger.kernel.org
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304505-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:kuba@kernel.org,m:tim.gebauer@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:bacs@librecast.net,m:regressions@lists.linux.dev,m:netdev@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,tu-dortmund.de,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,vger.kernel.org,librecast.net,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tu-dortmund.de:from_mime,tu-dortmund.de:dkim,tu-dortmund.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90DE1701B23

On 7/1/26 21:16, Brett Sheffield wrote:
> TL;DR - Commit 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 causes
> significant performance regressions with TAP interfaces and multithreaded
> network code. Please revert.

Micheal, I am convinced that netdev_tx_stop_queue() and
netdev_tx_wake_queue() are too slow. The communication between the CPUs
is just too slow. We already spent *a lot* of time speeding it up, the
patchset was only merged at v12...

Yes, I would *love* to have qdisc backpressure on by default but I do
not see how anything could speed it up.


*Is there any issue if we introduce IFF_BACKPRESSURE?*
I implemented it and it is a simple patch that only executes the
stopping / waking  if ((tun->flags & IFF_BACKPRESSURE)).
I could submit that to [net] very soon.

Thank you,
Simon


