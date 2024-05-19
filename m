Return-Path: <netdev+bounces-97136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC578C94EE
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 16:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92EAEB2124F
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147B9487B3;
	Sun, 19 May 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="icFD95q1"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661291A2C10;
	Sun, 19 May 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716127985; cv=none; b=eRO/mIz9gB+fMn0IOLbkRggatFxG2HSv03d5X6LXHcalKRMAOgDtxq0lEimDWSrXjXLT9KcobRLA4V2yhu0MImHP5NyeuIbLY07HTA/cyK3zjTEgu9sDAxnhkikY++sTIhGByFOrYOxvwUlxLZUyTxCQI5qHsfyTvEVWhJMo42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716127985; c=relaxed/simple;
	bh=sqrJgiov1S8OV8gwoeyirPsm3GKX/ZNG47C/+9hLNLg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=U1hThjh2qL1GUvV4p7KDgnRtqPPWgFLX/iWHQ7/Tp1K2wIEpzZPzB7wvBH5oB2x3YyLBp74FoTdewdTQQMWZMkb6uS+BBfgSv2WN33PWOw/gRtMgkWesFbkq564YFHDJEmuHWLiWl57xpNyFlw/NI54A4bNwq+4CLx9h6D4ZUZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=icFD95q1; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716127949; x=1716732749; i=markus.elfring@web.de;
	bh=dAeAJYtoA3G4hdbrQG7B7Q7VA51ccBWxx6sLjghi+pU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=icFD95q1djTXs/44EJrOyEkwrlRbc44WYWRfYH/8VheFfdpxzEyS75PEFbGwGPo7
	 nYHl0wHewewtyn4bxtBYTlmsJidR6iRB314KMFEI2Y5mO4ywr6bsrxP86SQI8V2V3
	 ihLxxJ0psofg6ibA408OHFGdeqSk5MHgyhZvAbQjOqGTvPo5WDjK5OsgMMmKVhduM
	 0+rIhM3UoSWAlyb6bOf79OZ+WjHKS2frT57eLxXN/3V8BNJSts6AxtJTUoidiGX9L
	 rkhiaonbJw+utTXdB0CTVWy7HJOG/2OlMCaDClwUXIqYceNjMBtmvQopYWzyJy4VG
	 B4Kke7ouP2euEjNLdQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7ux6-1sCZA72QNe-004wwn; Sun, 19
 May 2024 16:12:29 +0200
Message-ID: <2d7edd9b-f11c-4b8d-a63c-cecb104aa91c@web.de>
Date: Sun, 19 May 2024 16:12:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Siddharth Vadapalli <s-vadapalli@ti.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 MD Danish Anwar <danishanwar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
 Roger Quadros <rogerq@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 Misael Lopez Cruz <misael.lopez@ti.com>, Sriramakrishnan <srk@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20240518124234.2671651-24-s-vadapalli@ti.com>
Subject: Re: [RFC PATCH net-next 23/28] net: ethernet: ti: cpsw-proxy-client:
 add sw tx/rx irq coalescing
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240518124234.2671651-24-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gQ/I3jsXIWIpJOWU7j9MO1tyEW0hzfE/+mC7fOg3nJAg0yi+H0d
 F7q3CJzVJTvvb4u87peGhcLmQAemkoWX6UM0eGOKFTKJpX2DkDKxs+vk5sqkpKwU4QiB2du
 SaWaZUeD+PxmCgDtiZUx09lS6fHTsMCOnugmnCGiJ26I9hefBVQ67+BEE+bLT/xtsqAWtRA
 7dI2Py1WRiPDvzbP7XDGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tJ/qgRkzrIo=;jjTDvIgRZp/mIogqIqJa3Eu+L6x
 G+MT1/nmT0G7Vwx+01dEjtjSL67XhgzGod6vrXX9+C3+sKbuQIa7y/7YJQW8Cay/rO1g6/cQ6
 vUjj7Izgds1H3rWRVSDX7y5wCpaZibYntk67v2TlQSVrbs94b+qkUP3o96zUVQKfU0UkVCMR/
 wmBmM/cKJksBFvr3YWNi5G8yEnGdW5Pg5NRLxGJaimrWP37duxIvbSPi967MuCNovY60Z8Tdt
 /xjRVFjUMIT+nCcfh707SWYga+u3le988OlgY4bQ9vLrqPBSYl2XpS169nUWl005FGDv+NQC2
 FE01fwbbXoLt2Vgyad+R/tN6oGMmnsJez8zW3UEWD8x90R8c7DXW/QwKfb6yr7UiB1b3yleGx
 tM6xtgQIxoxnJuCBETJnMIIDSwUftjyD8JupQiVljDfLDwvYxwza946qoWYInpEqEh7SqZ6i/
 WZWJZSxYWKnSPmGqx3n0r/zpRG3JZz2VtRmOLel+iT/sJa7qgTkQV2L2dF9VvIxHXdOjm1NgF
 tfu/JI5CeGYTDW+64fCfnosdsREfVHTDiWFeepr10CqWdXPpqyeH3USNLamUvAjvFSErtv57R
 5KhLWQezfTaPiHgqxf4zmHKhEwj3iaC9CRAPFTftoYpFymopCxEAaP2JA4nV9nebjgidwBth2
 cCJQiebpHJ5h7ZSBiATWTZLXzPCJXSCNqjtjYOB8FOGeoYxAIBUUGE0frFUeN1QMAxdTEKc/7
 po4uxPTKkHm+NnRvhQXzrQ9QomYZiDxN6YUshE7nHwuCi/jTVBWPWMYL8Axr4tRsbkg2Y9DXV
 yXqqJT7l3jGLdSqxUM23SXvHGGVRDa7wpAc7s7VymyvMI=

=E2=80=A6
> +++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
=E2=80=A6
> @@ -996,8 +1001,15 @@ static int vport_tx_poll(struct napi_struct *napi_=
tx, int budget)
=E2=80=A6
> +		if (unlikely(tx_chn->tx_pace_timeout && !tdown)) {
> +			hrtimer_start(&tx_chn->tx_hrtimer,
> +				      ns_to_ktime(tx_chn->tx_pace_timeout),
> +				      HRTIMER_MODE_REL_PINNED);
> +		} else {
> +			enable_irq(tx_chn->irq);
> +		}
=E2=80=A6
> @@ -1179,12 +1191,38 @@ static int vport_rx_poll(struct napi_struct *nap=
i_rx, int budget)
=E2=80=A6
> +			if (unlikely(rx_chn->rx_pace_timeout)) {
> +				hrtimer_start(&rx_chn->rx_hrtimer,
> +					      ns_to_ktime(rx_chn->rx_pace_timeout),
> +					      HRTIMER_MODE_REL_PINNED);
> +			} else {
> +				enable_irq(rx_chn->irq);
> +			}
=E2=80=A6

Would you like to omit curly brackets at a few source code places?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.9#n197

Regards,
Markus

