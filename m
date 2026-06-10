Return-Path: <netdev+bounces-297366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iqD3CTKzKGpMIQMAu9opvQ
	(envelope-from <netdev+bounces-297366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:43:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCD1665044
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:43:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G3pLhlPY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297366-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297366-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1276D3006096
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954271E5B70;
	Wed, 10 Jun 2026 00:43:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25319049B;
	Wed, 10 Jun 2026 00:43:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052202; cv=none; b=rMU65kbEkmi55m6toAuEmPA3qrmjEKEZESKHMVwu/PfJypi7NxtYuHFr2m+mbnGq379bB53JzHU73PUJb2NchYdSunlHbNhxNR6MiuY/tzJAJ5lA3uGYHcZBenMgTeoQ75FQc/zXtkWV4DcqFXoVCrNWJYrRVv6di1GfHPNhQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052202; c=relaxed/simple;
	bh=y47u2mojQaFgIzaPP5iBdXeet/tU+xRwGluaeHMiS1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAnIqE4l+FLe1P6P+LwVcczU5Q4vQuMAw6IClewApuMRtJkiUPOLQl6FttUZDGcmjQdBNia/k94ufany2ldqWeQEx0xlf9y4Chc1Go0bv/hPpbvdvU4OZeu9mdJPp7DTphWRQGeP+oGu48AAGtA6pHsdkkXfF7jhKUPgyshshPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3pLhlPY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622011F00893;
	Wed, 10 Jun 2026 00:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781052199;
	bh=QZIx+Tf8azM7qG2aSAnz24Idnsi94Gnzu2yNxGl6AFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G3pLhlPY7OcLPI8qk5azFogdQrAv8gtzAi0zNlhtXA6mjCOEZ+2A/LNObiD3YJjXi
	 OiKLfKC6aBa+u/w6LuKFGqMuryGcl1PJpuCy8zNwk+schZzDjhcTNA53dpH0Y9McSH
	 G1nCN3BV/lfS5Af0ndRySQDiz2gTuyT2aAkkdL7Y3Zv/YEoPsC3sXiDvuC4Cle2jrT
	 lAaWFCBf/LAVyQEHiCZPHxrL5Gkbk1sXAp8EFGl1mOOVxqgOow2dPu6xPrULP0+Nm5
	 eblA/buDTF0U2395T0hPoj5+QohTKXRPl2Z79rOLBo2GNuI+goWNysVvHOrW87BWo9
	 OFc2U8akHuUWQ==
Date: Tue, 9 Jun 2026 17:43:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, Jose.Abreu@synopsys.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] net: stmmac: fix l3l4 filter rejecting
 unsupported offload requests
Message-ID: <20260609174318.3e34e62b@kernel.org>
In-Reply-To: <20260605090114.16028-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260605090114.16028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
	<20260605090114.16028-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-297366-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,altera.com:email,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FCD1665044

On Fri,  5 Jun 2026 02:01:13 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> +	/* Both network proto and transport proto not present in the key */
> +	if (!match.mask || !(match.mask->n_proto || match.mask->ip_proto))
> +		return -EOPNOTSUPP;
> +
> +	/* If the proto is present in the key and is not full mask */
> +	if ((match.mask->n_proto && match.mask->n_proto != ETHER_TYPE_FULL_MASK) ||
> +	    (match.mask->ip_proto && match.mask->ip_proto != IP_PROTO_FULL_MASK))
> +		return -EOPNOTSUPP;
> +
> +	/* Network proto is present in the key and is not IPv4 */
> +	if (match.mask->n_proto && match.key->n_proto != cpu_to_be16(ETH_P_IP))
> +		return -EOPNOTSUPP;
> +
> +	/* Transport proto is present in the key and is not TCP or UDP */
> +	if (match.mask->ip_proto &&
> +	    match.key->ip_proto != IPPROTO_TCP &&
> +	    match.key->ip_proto != IPPROTO_UDP)
> +		return -EOPNOTSUPP;

Please add extack messages to let user know which part of the match is
unsupported. Extack pointer is somewhere inside struct flow_cls_offload 

FWIW Sashiko points out a bunch of other potential issues, not sure if
they matter
https://sashiko.dev/#/patchset/20260605090114.16028-2-muhammad.nazim.amirul.nazle.asmade@altera.com
-- 
pw-bot: cr

