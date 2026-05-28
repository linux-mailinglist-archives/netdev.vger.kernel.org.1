Return-Path: <netdev+bounces-292643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LWmNaETGGrKbggAu9opvQ
	(envelope-from <netdev+bounces-292643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:06:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C955F02D4
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 584E7301A162
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5C338656D;
	Thu, 28 May 2026 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkUwgDz/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475883783B5;
	Thu, 28 May 2026 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962698; cv=none; b=hQJ3xcl5g4lBM8l8Z30Kjs6Xoe9Rn/y+U8na2Fj8nE8W46vKecNnvGeHVbRRajQ7MxwNdJOSCbXR5sRilBThjK9XdELR6ZZM21aEoyU/NbTKc8Cj/0e9ua4o9BNLmergWz8gluujVmlsdVxmdru6xTGrvEctD5CKbSYCVFcwIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962698; c=relaxed/simple;
	bh=QoP7l8m4J9iMwRF+bg5hnUa7DwdXtxu322JHk/Kep2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVo+jyOlgw1+70m/RD6SUZmHIVDycmk/BkamGCqkWT5Fa60r9M2PVlSj0ozIWqhCGBuL8aM14vTnbyu2ZJA82ZKGLPn3F36ldrM1PkGEhNSjV1o2ifDsfzdYoQVsLr8wW/2eAX2i9IMKn1beSKL/Ht6P5XL0UIvjTqCGhT5ds34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkUwgDz/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8156B1F000E9;
	Thu, 28 May 2026 10:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779962696;
	bh=ZUtr641Tb8/9Ppyf1hBIVtsR1pCzSTByWE9Y4T0unpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dkUwgDz/qjst0SG10cPF/178DIQU+F0P2JEaNxLY8k2f7XRBk40umv9ZeP736FzjS
	 AGz6EUrkMg+N5TalQqAWPKHvtMWm1vvGA654KhWUAkqaaAdhA8JnBbJJ3Wmmz1b0MA
	 OIBIWKnDDjBk4BcVI17F/m10NHUf14TB72CfGU4u33YScepfDOfBKALPe86x0o/aYC
	 r5p+3deywq+0NXt4Tk5qWrGzXlEwzwk5MOWRL0IDQvCFIfDz+c8yGMLcI38QRvoKRi
	 aiVzB1Ocw/vu9vdxceZl4FIAL1br3BsiuYcnkCoXle/6zIg7+gqwHwpIAexWY9DLKs
	 El1IFP/V/FC4A==
Date: Thu, 28 May 2026 11:04:52 +0100
From: Simon Horman <horms@kernel.org>
To: Len Bao <len.bao@gmx.us>
Cc: m.grzeschik@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arcnet: com90xx: Mark cards and numcards variables as
 __ro_after_init
Message-ID: <20260528100452.GP2256768@horms.kernel.org>
References: <20260516134628.30672-1-len.bao@gmx.us>
 <20260520201644.1528107-3-horms@kernel.org>
 <ahCNnuSAr2QpLl37@ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahCNnuSAr2QpLl37@ubuntu>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292643-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.us];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 94C955F02D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 05:08:46PM +0000, Len Bao wrote:
> On Wed, May 20, 2026 at 09:16:46PM +0100, Simon Horman wrote:

...

> Hi Simon,
> 
> I'm a newbie in the linux kernel development and I believe I don't have the
> experience to fix all the issues showed in this review by myself.
> 
> Also, you tell me to leave it be as is because it has no real attention.
> So, my question is:
> 
> Is it worth that I try to solve the issues mentioned or not?
> I am totally confused.

Hi Len,

Sorry for the confusion.
My suggestion is to leave it be.

