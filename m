Return-Path: <netdev+bounces-269429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJaQD+Tlu2njpQIAu9opvQ
	(envelope-from <netdev+bounces-269429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:02:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC992CAD30
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AAF53243755
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2EC3909B4;
	Thu, 19 Mar 2026 11:56:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97CD375F83;
	Thu, 19 Mar 2026 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921380; cv=none; b=B2XIplfNp6tTr+B56dfEUEidhsmxrCTbgziHnAhr9kwtmBgddphopjYTySvFxXWxtu02gTYkx3gfqxI93A/zloW4jREzgo/g2oL08c1xpbNNMpdT1Zvb/KOi/apkYH76R0SmjerDnhcc/OMxdEWMfIcb9bEYghgTIX57qiWXJ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921380; c=relaxed/simple;
	bh=U8S6+x8KALQvgwaexlGFBr++P357T8IURtV0VjjNlD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+zxoVD9yxaqQ4Gulj+cbzCi5IxTZW7KJKF484kufhl1pTRes7MuG2aWoj342yYE8WC7oYd1acsX3yGfXSm2GWawHcxb6DybI2KnGhlaoLwBY8sWW8hawhmVB7NKP+FGTkG3atuIZGqPnUcX8kB81i0RmpBMdQnVT3xFO5Yv0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w3Byt-000000003kZ-2Gdp;
	Thu, 19 Mar 2026 11:56:03 +0000
Date: Thu, 19 Mar 2026 11:56:00 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v5 2/2] net: dsa: mxl862xx: implement bridge
 offloading
Message-ID: <abvkUHCRI0yJdlgK@makrotopia.org>
References: <cover.1773591297.git.daniel@makrotopia.org>
 <0cf66a043eff3585270785a35e821e9a44afd6b6.1773591297.git.daniel@makrotopia.org>
 <16a4ac6c-abde-4121-9032-7626640facbe@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a4ac6c-abde-4121-9032-7626640facbe@redhat.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	TAGGED_FROM(0.00)[bounces-269429-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.564];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:mid]
X-Rspamd-Queue-Id: BBC992CAD30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 09:51:40AM +0100, Paolo Abeni wrote:
> On 3/15/26 5:20 PM, Daniel Golle wrote:
> > +static int mxl862xx_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
> > +{
> > +	struct mxl862xx_cfg param;
> > +	int ret;
> > +
> > +	ret = MXL862XX_API_READ(ds->priv, MXL862XX_COMMON_CFGGET, param);
> 
> AI review says:
> 
> Is the param struct initialized here? Looking at MXL862XX_API_READ(), it
> expands to mxl862xx_api_wrap() which writes the contents of the data buffer
> to firmware MDIO registers before sending the GET command. This would send
> uninitialized kernel stack data to the firmware hardware.
> 
> Every other MXL862XX_API_READ() call site in the driver uses a
> zero-initialized struct. For example, in mxl862xx_setup():
> 
> 	struct mxl862xx_cfg cfg = {};
> 	...
> 	ret = MXL862XX_API_READ(priv, MXL862XX_COMMON_CFGGET, cfg);
> 
> Should param be initialized with = {} here?
> 

While I agree that just sending over uninitialized memory is kinda ugly,
for this specific firmware API call it is not a problem because it
completely discards what ever is sent, and fully overwrites all
struct members before sending it back to the host.

Anyway zero-initializing it with {} is probably still good practise
and I'll do that, so AI or static analysis tools don't complain about
that.

