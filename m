Return-Path: <netdev+bounces-256532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGjIM8m5gmlVZQMAu9opvQ
	(envelope-from <netdev+bounces-256532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:15:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FEEE132F
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B98213013959
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0C03BB48;
	Wed,  4 Feb 2026 03:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXBN8J8+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D13EBF26
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 03:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770174919; cv=none; b=KQUWJSo2QgHm3HY6EsafvtK/Xdtd0yCeIcDIO3GplWoj9anLbzJZz5T8r0hhx7l5mBVwDMkfcCfm+D85Q84GvFtILLzBXKrBa2bpR+fYD7CwWByj/pILGKmCuWASe9snMWgByXP/UsmLvJVaFtxT/NrsoI8jKaQhh3GORgMlRQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770174919; c=relaxed/simple;
	bh=WNtV6lr+9OybHsbgZBF3Gu8UxedDcgkNqdE+QvYmtDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e717xh2+XLjPLvDYooJEUGIn118aTljfRLcAVYBVKU/KLj2VUh+JrVKFr+1uSNAwyaS3AwbgsuC53M6ALl7VDkcYPJP+l+G4bO6Sge/dEEqmqsatkWJqieOsFth4xpolI5j9tPLY3VK7lfjFAaXRr9iRAfOLvGalayXj7K+ojmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXBN8J8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99C9C116D0;
	Wed,  4 Feb 2026 03:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770174919;
	bh=WNtV6lr+9OybHsbgZBF3Gu8UxedDcgkNqdE+QvYmtDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RXBN8J8+m/mk/X409pQGAAPUSg/4U5ghTgRDhdvzO4fZhrkeR2id5YcB32ih7Dbzb
	 F5S4BuMVqnTjB0xGvsUUi1Ip9jcDCTo16dIn+ui/U0UgXWDDE8Mqof+kPnWsgh31En
	 5MkF8ngce+XnSvNsNv0aUpbVZnxdemWk+R2vgTxuGatJcXQbwzf7HL2PBO2xP3+Gc5
	 qpNEqymUDVqDtc2iMDuOxAxXPkx2suEwzPjxyXB33IlJci8B5RnbFLW29fex1iz6p2
	 +m6FRj28xtDEZT0c88wE4yYETuFQr5LZ1nbcLh5Sob2Q2pP9S0myYS3900XB5SgBRU
	 LYWlP8EEG2X8A==
Date: Tue, 3 Feb 2026 19:15:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Elad Nachman <enachman@marvell.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, Alok Tiwari
 <alok.a.tiwari@oracle.com>, tchornyi@marvell.com, vmytnyk@marvell.com,
 yevhen.orlov@plvision.eu, vkochan@marvell.com, taras.chornyi@plvision.eu,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] net: marvell: prestera: fix FEC error message
 for SFP ports
Message-ID: <20260203191517.024dab80@kernel.org>
In-Reply-To: <795c3351-d65b-4a9a-83dc-b530177b9d28@gmail.com>
References: <20260202052816.28191-1-alok.a.tiwari@oracle.com>
	<795c3351-d65b-4a9a-83dc-b530177b9d28@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256532-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,marvell.com,plvision.eu,redhat.com,google.com,davemloft.net,lunn.ch,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74FEEE132F
X-Rspamd-Action: no action

On Mon, 2 Feb 2026 11:26:00 +0100 Jonas Gorski wrote:
> On 02/02/2026 06:28, Alok Tiwari wrote:
> > In prestera_ethtool_set_fecparam(), the error message is opposite of
> > the condition checking PRESTERA_PORT_TCVR_SFP. FEC configuration is
> > not allowed on SFP ports, but the message says "non-SFP ports", which
> > does not match the condition.
> >
> > diff --git a/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c b/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
> > index 2f52daba58e6..a259da9f30f4 100644
> > --- a/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
> > +++ b/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
> > @@ -718,7 +718,7 @@ static int prestera_ethtool_set_fecparam(struct net_device *dev,
> >  	}
> >  
> >  	if (port->caps.transceiver == PRESTERA_PORT_TCVR_SFP) {
> > -		netdev_err(dev, "FEC set is not allowed on non-SFP ports\n");
> > +		netdev_err(dev, "FEC set is not allowed on SFP ports\n");
> >  		return -EINVAL;
> >  	}
> >    
> 
> I'm pretty sure that the condition here is wrong, not the error message.
> 
> AFAIK it doesn't make sense to configure FEC on ethernet/copper ports,
> but for SFP ports, it may be required depending on the transceiver or
> cable used, especially for fiber modules.
> 
> I may be wrong though.
> 
> This check was introduced with bb5dbf2cc64d ("net: marvell: prestera:
> add firmware v4.0 support"), but that commit does not offer any
> explanation for it in the commit message.

Elad, could you clarify this? A bit hard to tell whether CR is included
in "SFP" from glancing at the code.

