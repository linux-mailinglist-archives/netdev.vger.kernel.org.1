Return-Path: <netdev+bounces-297411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5wG7IWvNKGouJwMAu9opvQ
	(envelope-from <netdev+bounces-297411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:35:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D69665754
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:35:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RCs+5kqI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297411-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297411-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82CA93022DD7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4222A80D;
	Wed, 10 Jun 2026 02:35:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D058212542;
	Wed, 10 Jun 2026 02:35:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058920; cv=none; b=VRenTxdzNP+rdbhNET98abqwrJ+Sa8fmt8G8gg5CH+z0XvadjjEimTVCt2erUJsXd2Aw1QTyAABx8OoYhUBIcdzMtt+aSJThij4RFOmqUF3Ehj3gOCj733EAbdngZzPO5yv4YHmYUrmIwwTHpq6lbCgOTk6aX39i6lpzMuEnwwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058920; c=relaxed/simple;
	bh=uq5Kq3q9DuiW7B0IJWEur3aUbTWBB0MDDX5R68QimZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aU+rzTxAt9WCSaibfX+JyzFC/a/0i+lKaLTobLljx/bH3ftsM/LTs1Yp9offHy0PA0QucY+dhfxGUo3GID5KZMX3lgvLnNjCCdPojoIULRszMXbFolusqIMaB9SUzqoRA2AHVBAEkP025tNVxumqA1zEe/NAmxMX1coti0eUTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCs+5kqI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC3E1F00893;
	Wed, 10 Jun 2026 02:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781058919;
	bh=noMLgspnG/ngW5l+lWAJlspzNQSpY9ROCjd+ZiYPsjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RCs+5kqIF8Vn4eJTfXf7y23lJVsq1oejkO+AX+5zWTw3oQxegzR+AOHdFxIDcLhxJ
	 AWi2Okgcvq+5322/Hm0lVaOl6BRBucYpQns7scX2N90suku9P7bsfEk+Oc8hbc1RMY
	 RFNVT+7rEyis6NHDuDoRYbBzJpBrhlo62WdRGNua4B8Rj5gd2Tr7YjD0nCNGz9G2ip
	 uNHoHcAynygYChWd1xQj8JNZL+YMoU/AUcoo/kKyWo2GdQkt4QeFpdNTontp22BhF+
	 A5pdjF8K8htEqrkGY2tbmrJ3Z17WqDaYF/uimjDyhLh+Gd/85tGPp6b8NcUx9bGH8M
	 JKYk5Ltd5mVmQ==
Date: Tue, 9 Jun 2026 19:35:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Alvin =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v13 2/9] net: dsa: realtek: rtl8365mb: reject
 unsupported topologies
Message-ID: <20260609193517.1ca93f1c@kernel.org>
In-Reply-To: <617aa489-4f0c-4fe0-8cf3-55c98f4d4d9e@yahoo.com>
References: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
	<20260606-realtek_forward-v13-2-b9e409687cbe@gmail.com>
	<617aa489-4f0c-4fe0-8cf3-55c98f4d4d9e@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297411-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:namiltd@yahoo.com,m:luizluca@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7D69665754

On Sun, 7 Jun 2026 14:55:07 +0200 Mieczyslaw Nalewaj wrote:
> >drivers/net/dsa/realtek/rtl8365mb.c:rtl8365mb_get_stats64() {
> >    ...
> >	mb = priv->chip_data;
> >	p = &mb->ports[port];
> >	spin_lock(&p->stats_lock);
> >	memcpy(s, &p->stats, sizeof(*s));
> >	spin_unlock(&p->stats_lock);
> >}  
> 
> Sashiko reports a potential deadlock around stats_lock, however I
> couldn't find a call chain reaching rtl8365mb_get_stats64() from
> softirq context. Can anyone point to such a path?

I'm not sure where it got that from either, but it keeps complaining
about ndo_get_stats64 from BH on multiple drivers.

