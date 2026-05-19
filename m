Return-Path: <netdev+bounces-289546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAyIDk6dDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:26:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BED0583055
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 692E13006992
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B35529ACC5;
	Tue, 19 May 2026 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RFEdccnz"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E3F2F12B3;
	Tue, 19 May 2026 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211591; cv=none; b=algyTKpWGNdeaq6rF8YhLoBvPGK7lYSKgU6w1sKSRnKWyoi+1wcpX7sBp0N0n63Bsow3P30HEt/4ytg6wBZ9iVSJp9zqBDI3Sf5i25rLAEefK5YG/iYuYYFNgjyji6UVklbZ//xO2bA9jCJwP7gk081oJWT0mulOHagT3HDMl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211591; c=relaxed/simple;
	bh=IILKB4PhlaSh6utBxiA5BQJrzH/TLqMqW0LbkuvBIHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGA3qLluArS0/AJXxMKyBGMcPQStzsdHsU4MKB5LbrqvhBAyPngk9A54BkWXTrjMB9hsThNmU0xJkf8MOPWNh8pUj7b2AckW3o417qIDeCP+UinEiZYG22zU7nkpWag0vq9ecpKdMfUG24pANKgmZ/YRtoH1iSijcsNOzLKEzt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RFEdccnz; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779211587;
	bh=IILKB4PhlaSh6utBxiA5BQJrzH/TLqMqW0LbkuvBIHA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RFEdccnzL6usDX9R7w/E4SedKOaa9RDkyJJOXveGBP3tJbIvMb4XJR8l7mbRwUTb0
	 gdM2TY4wnytCEzynVQCXRp1U0PaI+pIgV2rAVNPjR8GoobR0TlnbNSOOtbCYI32dS9
	 Sp4xzErrp3WWViR2JOjLHil/rvmgV7BSd4uGlvwhtKebpL6WIlYFKYIVPJP2RgCSrs
	 59+ocExaNvhx/JxjlPLhaTzbybmVNRGywoQt9uylZh4zLgAG93za47B8oVnRtbUkcE
	 7i6XwvyHOQktSNdeXBr1FuSdi6xdWXWfsX55YRN7ZZUmWmAg9MkIcxDp2TftUsP5BX
	 4IDiVZsXClJlg==
Received: from [100.113.117.42] (unknown [163.114.132.129])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 81C1360354;
	Wed, 20 May 2026 01:26:23 +0800 (AWST)
Message-ID: <727b95fc18b26dcf71cc65d8d8a2824cee12aaa3.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] mctp: i2c: Use named initializers for struct
 i2c_device_id
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= "(The Capable Hub)"
	 <u.kleine-koenig@baylibre.com>, Matt Johnston <matt@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 19 May 2026 10:26:10 -0700
In-Reply-To: <20260519153613.1594429-2-u.kleine-koenig@baylibre.com>
References: <20260519153613.1594429-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[codeconstruct.com.au:server fail,sin.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-289546-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,codeconstruct.com.au:email,codeconstruct.com.au:mid,codeconstruct.com.au:dkim]
X-Rspamd-Queue-Id: 5BED0583055
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

> While being less compact,

oh no! :D

> using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>=20
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>=20
> While touching this array, unify usage of whitespace in the list
> terminator to what most other arrays are using.

Looks good, thanks. The overall i2c_device_id plan makes sense.

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy

