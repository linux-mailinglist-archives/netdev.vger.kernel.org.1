Return-Path: <netdev+bounces-294734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aRj8Ot4dIGpwwAAAu9opvQ
	(envelope-from <netdev+bounces-294734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:28:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 573D86377F5
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:28:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=RbYOz33H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294734-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294734-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0760430EAB6B
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 12:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F2C3A16AB;
	Wed,  3 Jun 2026 12:23:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2D1EA84;
	Wed,  3 Jun 2026 12:23:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489435; cv=none; b=oZ6f40AqRNz4/m/t59yTM1yyp8NcGxVoDS9Vw27+U8++ZcLcKFv8+h31J49oVR/FWSlaf2h5BoOcbSAxnepy4IhvdrY9055wZ3UnC3p1QBeC9x/u05YEGpUWHnmkgTJX8E68W4xgeBTOiA6Vqc7qtja/ZS1WZeS9Ik3/MKe2sC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489435; c=relaxed/simple;
	bh=0fq6dlmqoFWoUWO6Bv/3PDuoVk+2yOUZaAdedx4hpfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coxGs2wMUl6zSmiBEV1VjVKUJ/Ppgk3JYJN1y2o0fyNtArbJUrO46V6dtThE89iVAX7LIKFdtl06tOXQxuwYAJ0nGAEHHW+EgCbTgYFNJrvaSrlif+lmM4xigRuZx3+TW/iUnAoLfZS5vpsMS71qrbARoAik58MzdkLWr7encnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RbYOz33H; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/R3A7M1BaRA7JqvcsTrouVp/JPp/RtHWssFfmUkvdsM=; b=RbYOz33HhdmYfs0pbYAu6ZaRyM
	wsF7zVyGu7ZN6vUpZK1W5IM/DIreDzLJ4IwHnnQPowgjNy9HXS/DzNfSbOuRMWpvSfqQg/aZ1/SXv
	aA2ymEA01R05TIxcTerAqYogOU0cKyQj8kcIS37C9YFFdJpkrzuGDgL9+aRHDRlAo/G0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUkdJ-005sGH-9j; Wed, 03 Jun 2026 14:23:41 +0200
Date: Wed, 3 Jun 2026 14:23:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksandrova Alyona <aga@itb.spb.ru>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: dsa: sja1105: reject zero pin duration for PTP
 perout
Message-ID: <e8b9ca74-add9-4499-b3a1-c7658d985986@lunn.ch>
References: <20260603110216.5202-1-aga@itb.spb.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603110216.5202-1-aga@itb.spb.ru>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294734-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linuxtesting.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:aga@itb.spb.ru,m:olteanv@gmail.com,m:f.fainelli@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:lvc-project@linuxtesting.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 573D86377F5

On Wed, Jun 03, 2026 at 02:02:16PM +0300, Aleksandrova Alyona wrote:
> pin_duration is converted from the user-provided period to SJA1105
> clock ticks and is later passed as the cycle_time argument to
> future_base_time().
> 
> Very small period values may become zero after the conversion,
> which can lead to a division by zero in future_base_time().
> 
> Reject zero pin_duration values and values that exceed the
> supported range.

Which is better, reject, or round up to 1?

      Andrew

