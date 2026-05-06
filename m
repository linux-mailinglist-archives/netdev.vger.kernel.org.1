Return-Path: <netdev+bounces-284831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFn6BaA9+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:09:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5214DABB8
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85F993067955
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F583F1676;
	Wed,  6 May 2026 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uw7/ezzI"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096253F9F4B
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072697; cv=none; b=g29Xau1nBiG0hpTZxQocvHgorKvdcZv3mxBlYD5xKriO5/CI1bFDLAdzz49CuO3QKqtgDc2JiZW6T7gzKqqdLoWIMn8MXpRdZBxk80ZKtYS1hwhnpw+WPs5ME/ZFRlQiqV99en1MYIjm+0B27rHuoT9IsbMe3boZYIKhYF32qFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072697; c=relaxed/simple;
	bh=7vf9+i6AHyONbumqmEideqiYlV6PkC+bLroWjZP/9e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/e6YDIqDrhRBrvtBxKi3v5mh7f2l12cBI7HIL+NWwCgWaEYi8dH8z3y1sinNvsiartzcty/k1giVs1Gy5OlmzhVUyNWIokJnY99g1/ShUX4qZeRmNyqPlcQro4wv9B/kXueo2s3S6vRO1OjxohLFgP3ky2Io1TaHiGJUXxKi+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uw7/ezzI; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 26758C5DC4A
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 13:05:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D93A16053C;
	Wed,  6 May 2026 13:04:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9290102F24CF;
	Wed,  6 May 2026 15:04:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778072684; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/+T6umy0cooM1bnJ96FCKLXxkBj53jFxTV9fG9xlUUE=;
	b=uw7/ezzItWXZd6VOaFfgqWWjKBh08wozppnv6qGzVuNdf8MgR0ewetkTMHZVVvnpft/YCG
	MPK6vyqMy4sByAhxftcmPFm53dui1ihbOgBTjEjaoAqHgKERsW7QL1RknZXpKJgS7hArEq
	sBjAWIdNb2xqRwRD2kwcwUIfd9ViuBj9O/AQfTuPmMmVjA/rxkMv5280u3sC7+bjIXEXHc
	fYaHXE/2+BFsnHj/J84BbAbtBGn3ibn8SzN+NAtwWqaR/1AynJDzw1kfUcSUyVmiOhJsnO
	gnnTI5xHCz4LF9/JeIRfhhHeyrUQDJaM5IeRhwDWkKHHBRc/SBdL6rXQR1FZnA==
Message-ID: <f9b8840d-94ba-4bde-9ace-fb81eb733ff9@bootlin.com>
Date: Wed, 6 May 2026 15:04:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
To: Andrew Lunn <andrew@lunn.ch>,
 Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
 <BEZP281MB22458F571CC8251C141D933CD93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <7778cd41-cf36-4524-a347-408a8fb0bde0@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <7778cd41-cf36-4524-a347-408a8fb0bde0@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 7C5214DABB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284831-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]



On 06/05/2026 14:39, Andrew Lunn wrote:
>> So for me it somewhere happens in phylink_validate_mac_and_pcs()
> 
> I was expecting to see more debug output, but reading the code, i was
> also thinking we need to look at phylink_validate_mac_and_pcs().
> 
> You are going in the correct direction putting lots of printk() in the
> code. We need to find where it returns EINVAL:

[...]

> 
> In the end, we are probably going to find that what the MAC says its
> capabilities are don't match what the PCS says it can do.
> 
> Thinking about that, it says phy mode RGMII. You generally don't use a
> PCS with RGMII, so that is suspicious.
> 

Another thing to consider is that in this case, we're attaching to a
dp83tc811, so a 100BaseT1 PHY. Does the PHY driver correctly populates
the supported features ?

Could be that we're getting an empty-ish phydev->supported after reading
the abilities, as this is not a typical BaseT PHY

Maxime


