Return-Path: <netdev+bounces-270511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBhXBaUwwWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:23:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7412F1DCB
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08F13300ADA3
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC2939DBDA;
	Mon, 23 Mar 2026 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="K0GgSRfV"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA92C37BE79
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268506; cv=none; b=rtJxwP/w8WJTIWN2PXZiaFGBYB4aj2mKKk9Ly7MuA8Ew995MIpCO/Gw2k+FpwtZ2J4mK9x0RqbFTDkxRQCmE8yeTdlqvko7VZjDF2utjPMv4Hs3MkoK5iigtEOhEZgqFNQAU770m8ZSAK4eW5uG/U2Dt987tVoyTyyz6hPTIKYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268506; c=relaxed/simple;
	bh=COc3GKdZVNXQxjCS9rIYAUgGC3mtgllDMRgV11gJ1/w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inkGe3kB9/tjPZSW1tRTl2zxRiCqN/uRo3wvLURlfSmkN7OcDRm1TbxKi655PesuikyJhv1txxDEsCbZC11ewdz5BOoO+NkovHLX7mUYBGMerjgzEq8NDXRNNiPyV/yDpn0yjifWYzdZmZ1zU+jJ5J0eGxXUz47fT4La+1qL7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=K0GgSRfV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id BC8A3207B0;
	Mon, 23 Mar 2026 13:21:41 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EsNzV8Hnrewy; Mon, 23 Mar 2026 13:21:41 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4245F20561;
	Mon, 23 Mar 2026 13:21:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4245F20561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774268501;
	bh=lSxkH6EDkrszrB77Jg8ED3MdVTZgNPMVXiT8/wPdoCY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=K0GgSRfVJ5Gorc3exwZvt7+c/cefnRDGw3I5oAfRgoFlKkK96dUsAGmOeKKMEETxO
	 BKRehjmEb8Nlm2tH3FKxdNDZqt0Yq2/om0RgYhq3gjJ38EhWstqjRmTGTycJTey+el
	 YzOAyP/jGfSfU9WN8F5dZUcpd9QNPYHFvcTBA3cBwTzX8PTUtR31KTvi2zD4umFSTo
	 lG6LU+AxNaXDn7zNdLf63HNteg2bIMceDA3uMSk7qobZwJSPOUmNHnFX94ZLvzpHvM
	 SeB0PA4MgnJuk/pHIRSFifFlpfjFsx+6K829ZTgEdad+tjRF4Mwt1iHGsoIw4GgHqJ
	 oMVigstwlqY4Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 13:21:40 +0100
Received: (nullmailer pid 2865874 invoked by uid 1000);
	Mon, 23 Mar 2026 12:21:40 -0000
Date: Mon, 23 Mar 2026 13:21:40 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
Subject: Re: [PATCH] xfrm: clear trailing padding in build_polexpire()
Message-ID: <acEwVDyy7dDQs6og@secunet.com>
References: <20260321210421.2504711-1-yasuakitorimaru@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260321210421.2504711-1-yasuakitorimaru@gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270511-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1D7412F1DCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 06:04:21AM +0900, Yasuaki Torimaru wrote:
> build_expire() clears the trailing padding bytes of struct
> xfrm_user_expire after setting the hard field via memset_after(),
> but the analogous function build_polexpire() does not do this for
> struct xfrm_user_polexpire.
> 
> The 7 bytes of padding after the __u8 hard field are left
> uninitialized from the heap allocation, and are then sent to
> userspace via netlink multicast to XFRMNLGRP_EXPIRE listeners,
> leaking kernel heap memory contents.
> 
> Add the missing memset_after() call, matching build_expire().
> 
> Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>

Can you please add a 'Fixes:' tag, so it can be backported?

Thanks!


