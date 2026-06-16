Return-Path: <netdev+bounces-299741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sn6fOXnlMGrLYQUAu9opvQ
	(envelope-from <netdev+bounces-299741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 07:56:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F72C68C4A6
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 07:56:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=h7E3ix+e;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299741-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299741-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67E4B3023310
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 05:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76583D75BE;
	Tue, 16 Jun 2026 05:56:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4753D6CB2
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:56:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589367; cv=none; b=hSf58WFnetZ5bHp71DEVEgAyjsBGu+NslFvh1Uu6B2xm8k+siySnO9WY17G25XAIMD7PYNwqbCO2/ORGl/SWW9RlDWRyE6JeC+OJgY3/UYXsr63TIpATuKkEyl9S3bqCt8w8LgAoQbnQt2u9loTaBrVWlFTqpxVq61ExZMYNEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589367; c=relaxed/simple;
	bh=NyfookAa63q1ictUDIoV585GRd6fpY8Rc4VWSwwaJv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8x4WC6fE+AL15i7h0dYdtnGqBWybXFD2a7dBnOksRDWWDfNzjqxpBwnJwg0zUzSydVIeKUUzzZAg08t0YqIqtIcSl76pGEVEpWA3ZvuYHubo+2CJmQArX5NDRFOiLBtdL9p/3AWWLMSVN6K2ZCSVgHH7OApkdMhVhIyFU8hB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h7E3ix+e; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AF5DBC2BB2B;
	Tue, 16 Jun 2026 05:56:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22FDF601A9;
	Tue, 16 Jun 2026 05:56:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB68F106C99FF;
	Tue, 16 Jun 2026 07:55:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781589361; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ppjhNAIB/2tNSgO5JKwtJnxCIz21sN2sjhPw6SrZ4Cw=;
	b=h7E3ix+eJBEkVbo9Hx2TAJ+kno+HlZGcXuBSJAcT3lL0tthbRz9tynX4JKoagrRzknJK5r
	fBVOAkWSY4DzVqpnyw5QtgovdL0ZwEztdhLV03xwPpAIlFwhNRiKi194BNELmxLbmmmrTY
	C0IMFfWDf7Qu82a96ERGtSbW82OxCx0SYBJ9idaJnqrVWjdMuJLGj7giqefvnAKmiY56Fn
	l8MSlfL5+xaV/otM2tNKEiIF+4MKD0cPrkzsh7HSu1GchNuhqEBW8Vk4RtYD2kIW7myxZF
	0eanb3TgnXtbev19BYsSnbSH262vBIm+UagB9lqR4/tpN1Dtbr0h3ArOGlJdbQ==
Message-ID: <f15e8b91-36b8-4821-b027-5cec6599f3f0@bootlin.com>
Date: Tue, 16 Jun 2026 07:55:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
To: Johan Alvarado <contact@c127.dev>, linusw@kernel.org,
 alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, namiltd@yahoo.com, luizluca@gmail.com,
 linux-kernel@vger.kernel.org
References: <0100019ecd045b3f-a7bfbb9d-6659-45c6-8fca-9cdce637092c-000000@email.amazonses.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <0100019ecd045b3f-a7bfbb9d-6659-45c6-8fca-9cdce637092c-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299741-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:contact@c127.dev,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:namiltd@yahoo.com,m:luizluca@gmail.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[c127.dev,kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[armlinux.org.uk,yahoo.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F72C68C4A6

Hi Johan,

On 6/15/26 22:41, Johan Alvarado wrote:
>> This comment implies that you could deal with SGMII aneg at some point.
>> [...] makes me wonder if this whole SGMII/2500BaseX series should be
>> represented as a PCS phylink driver.
> 
> Hi Maxime,
> 
> You're right, and I'll convert the SerDes path to a phylink_pcs for v4.
> It splits the MAC and SerDes layers cleanly, drops the "ext then sds"
> branches in mac_link_up/down, and makes future in-band aneg an additive
> change instead of a rewrite.

great !

> 
> One point I'd like to confirm on scope: I can only test the forced-link
> path on my MR80X (fixed-link / conventional PHY), and I have no setup to
> exercise SGMII in-band autonegotiation. My plan is to do the PCS refactor
> keeping the link forced (outband / no in-band AN), and leave actual
> in-band aneg support for a follow-up once I have hardware to validate it.
> Does limiting v4 to the forced path sound acceptable, or would you prefer
> in-band aneg implemented up front? I'd rather not add a code path I can't
> test.

That's fine by me, it's usually better to have something smaller but fully
tested :)

> 
> I'll also reword the misleading "disable in-band aneg" comment.
> 
> net-next being closed until the 29th gives me time to do this properly,
> so v4 will carry the PCS conversion, retested on the MR80X v2.20.

Thanks,

Maxime

> 
> Best regards,
> Johan


