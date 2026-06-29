Return-Path: <netdev+bounces-302684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KPgvHOWAQmrg8gkAu9opvQ
	(envelope-from <netdev+bounces-302684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:27:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 094B76DC070
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:27:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=I6NYFZ3X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302684-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302684-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0381300B58D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FC93769F9;
	Mon, 29 Jun 2026 14:25:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E7368D41;
	Mon, 29 Jun 2026 14:25:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743128; cv=none; b=SygjAB9RTvDONhX5tr8maxFoK27rzuLcbaTm8cb/mFjV6z4iC+2LhUSQSZkRh/rkNaOil/MUpzkimyryInjV2BMGw7owJz43nWuQzUibT9AwvGalkTDwJY06/JjfFNw3VEvVZDYSYfNFKYMtuNG1SQRoBJr0WedUs1XlRn0p1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743128; c=relaxed/simple;
	bh=TEQcXdZNRYnlRpn9eNHCJVZvtCsb2D9qXkQze9KDWmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBI9k8dGgojSTinuZnKsNnjAWK0uLuKvJd3YGrRuIPSJj+moKJdZiGRNPO9yK+UcDdYLuP3TbKlucPaTtWf4M316t2mXOcKh3WJAxFo/OwMtxUDqBZ4BP4X4msLmPhE6sLYXwteY/nZJ3JQFRehB2Wq1MAJMchfWwm5eeD21rOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=I6NYFZ3X; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AiVP8oFBaGaJCmP+ZHLJxwxGEx1QcBfUrH02wQSzL74=; b=I6NYFZ3X3OE6vjJwc9oOTYRmzW
	bU4v2tKTSVQYtEsqgAqG9DCBnt7MxYrYiYXMaCRCt+A/+Ru1JVC6NiGO5fAcdFNV+fx+Jah9SzRzD
	rJ8EIhQYhlvpESRYzN5C6eSTzF/izKNFn+bWygf8nXgO/ZiX3DlVRRWks6SlGlWQqbnI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weCvF-009loX-07; Mon, 29 Jun 2026 16:25:17 +0200
Date: Mon, 29 Jun 2026 16:25:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fan Gong <gongfan1@huawei.com>
Cc: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Zheng Jiezhen <zhengjiezhen@h-partners.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v10 1/5] hinic3: Add ethtool queue ops
Message-ID: <b1720d92-1b72-46b4-b45a-f7d4ca415667@lunn.ch>
References: <cover.1782718232.git.wudi234@huawei.com>
 <3414df08001307c6d96c17ffc0921206c62f85a1.1782718232.git.wudi234@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3414df08001307c6d96c17ffc0921206c62f85a1.1782718232.git.wudi234@huawei.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302684-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gongfan1@huawei.com,m:wudi234@huawei.com,m:tengpeisen@huawei.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:ioana.ciornei@nxp.com,m:mohsin.bashr@gmail.com,m:dimitri.daskalakis1@gmail.com,m:hramamurthy@google.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:luosifu@huawei.com,m:guoxin09@huawei.com,m:zhoushuai28@huawei.com,m:wulike1@huawei.com,m:shijing34@huawei.com,m:zhengjiezhen@h-partners.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,m:dimitridaskalakis1@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[huawei.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,nxp.com,gmail.com,h-partners.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 094B76DC070

> @@ -315,21 +315,28 @@ static void hinic3_link_status_change(struct net_device *netdev,
>  {
>  	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
>  
> +	if (!mutex_trylock(&nic_dev->state_lock))
> +		return;
> +
>  	if (link_status_up) {
>  		if (netif_carrier_ok(netdev))
> -			return;
> +			goto err_unlock;

So ignoring a link status change, leaving the carrier set wrongly,
because some other thread has the mutex locked, is O.K? It would be
good to explain in the commit message why this is correct, because it
is not obvious.

   Andrew

