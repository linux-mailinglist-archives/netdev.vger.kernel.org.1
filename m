Return-Path: <netdev+bounces-275594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOhjB0+202nLkgcAu9opvQ
	(envelope-from <netdev+bounces-275594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:34:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA7C3A3950
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A99F300616C
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 13:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80EB21CC4F;
	Mon,  6 Apr 2026 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="vhLkpoeT"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65F1F192E;
	Mon,  6 Apr 2026 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482433; cv=none; b=JPwU8VP0XLBfaRpCznn9rtl/WXEqGPaxfnvhRJTcbJBddNMP3+I4CxopRdj6l90wIF7Oewa4gL+7pXvnkHnFplAmI8r36pOsnXGTlA71jQpHDJSEVJ/7Yze5Q/TGegUV0Uv4+Qh2+rgHGJWU/lSoXzfUH71qGuS0NFtWVH8ySa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482433; c=relaxed/simple;
	bh=rby7I+8Zk1SNZO7WH40Wj1O8cmV/OD8smQdiIDeejsw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RLv9wRd/8UK8RDIEifDMkXFJR7X9w4a+uVv2Uq8vYOk4J0D64FYfnFs0YJscWrZdlNxDuePveNcuFnsvE2og7iZMonaMTV/KKxKi3zSdxgGgHqvFeNFuYS+3TtkrTz2UIPnFt+Mc7Kaf6nzpMaxhimUZPa+N1EenfjtTKYbCDj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=vhLkpoeT; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16353A5888;
	Mon,  6 Apr 2026 15:33:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775482424; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yEwxY8e/7wqrX1mbmXoSy1MbXgqbAyCZJyVMeKm7HOQ=;
	b=vhLkpoeTEriohvJIdBFXLtzWp9zgDaYiSvXMvuBGaRxmw+JG1D1qTBn4PjsYcA5jazGWNP
	3F1/AYi2K1mj7SdgIOenpL8rObxF0J4Fc3LCDuTVq4xXBNqObaJ4bRUsagooItUdE9+vgt
	XpTxF5gu/odEkUPvhdz+qVnWQglKCT3T+8M9uKGd7Vsp5FfZm1JYWlRrxwCWeggZAJCdQw
	OyTYPNd3uRdRkbPlETt6Lda13ZmdAxbLvSJ7Yirpao7Rgkh0vxAd7ea+6YX9fv0dZ5Pv52
	HuiThUvXwyUPq/REhZDqseaTczoxw65geTMdaesVhxfRqGj8a45wyx4uxbYxVQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Apr 2026 15:33:40 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: phy: add support for disabling
 autonomous EEE
In-Reply-To: <a1cf8f6a-b338-4dd7-aced-7e19e4d0fdb7@lunn.ch>
References: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
 <a1cf8f6a-b338-4dd7-aced-7e19e4d0fdb7@lunn.ch>
Message-ID: <9272c5dd653039b3def8caaea3e631c5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:?];
	TAGGED_FROM(0.00)[bounces-275594-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	NEURAL_HAM(-0.00)[-0.646];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[tipi-net.de:s=dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEA7C3A3950
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6.4.2026 15:17, Andrew Lunn wrote:
> On Mon, Apr 06, 2026 at 09:13:06AM +0200, Nicolai Buchwitz wrote:
>> Some PHYs implement autonomous EEE where the PHY manages EEE
>> independently
> 
> I suppose we should discuss naming. As far as i know, IEEE 802.3 does
> not include this feature, so it does not provide a guide to how we
> should name it.
> 
> In the past we have used SmartEEE, but that is Atheros's vendor
> name. Broadcom seem to call it AutoGrEEEn.
> 
> Autonomous EEE seems like a reasonable name, and appears to be vendor
> agnostic. Are we happy with this?

"Autonomous EEE" works for me (obviously). It kinda describes what
happens (the PHY acts autonomously) without being tied to a specific
vendor's marketing name.

That said, I feel Russell's argument that it doesn't type well. But
even after some walks in the woods I wasn't able to come up with a
better name yet.

> 
> What i guess is unclear is what part of the network stack is acting
> autonomously. In the context of a PHY driver op,
> .disable_autonomous_eee is clear. But when we go further to actually
> making use of it, do we need to report to user space if we are using
> IEEE 802.3 EEE or "autonomous EEE". But i guess it is no worse than
> SmartEEE or AutoGrEEEn which also make no indication where EEE is
> happening.

I think for now it's fine to not expose this. From the user's 
perspective,
EEE is either on or off. Whether the PHY or MAC manages LPI is an
implementation detail. ethtool --set-eee should just do the right thing:

- MAC supports LPI: use MAC-managed EEE
- MAC doesn't, but PHY has autonomous EEE: use that instead
- Neither: EOPNOTSUPP

I don't think there's a meaningful use case for letting users choose
between the two. Or is there?

> 
> Thoughts?
> 
> 	Andrew

Nicolai

