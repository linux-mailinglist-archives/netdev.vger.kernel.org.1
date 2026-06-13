Return-Path: <netdev+bounces-299021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9sYoJFqmLWrviAQAu9opvQ
	(envelope-from <netdev+bounces-299021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:50:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D047E67F5A6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:50:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299021-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299021-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 399D4301D6AC
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BD230D3FC;
	Sat, 13 Jun 2026 18:49:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F419D8A8;
	Sat, 13 Jun 2026 18:49:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781376599; cv=none; b=tLDOK2rS9thdLjrbEHsB/d7OpvMGoON24YGZm1VHF9Ps8T4CsW7afVc0IRssjPPglwi0XlTRC/oGn22Pyc1O2s8z9o96s4hQeQDjzDBJ9PwTjeKYiGljXEecgZQvgTL7lYAHsQNlVaO8xjDUDG7CfEiRWHj/0DpCOxNp1kFnRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781376599; c=relaxed/simple;
	bh=RlRUfgopsbWVaWBaOek+H2Oc4hnhMw4e9+ZafHhhHuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7yfzQle4ryF+l4EaYnR5D5KqhBPWJz6NphqJ6fFJ1+5bkavVFOEac8FCX88zdQm4NO9s2VnjAJRIzxwqnGFf5+u66p0aBUL27dvXmlycs10qpTXtajaDKEJrY5N2DTC/j1KuE0Bv3z1ZiiJrGm0pmmhun2tWxZy9aqJOnl/uk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYTQa-000000002X1-3L0y;
	Sat, 13 Jun 2026 18:49:56 +0000
Date: Sat, 13 Jun 2026 19:49:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH net-next v5 3/4] net: dsa: initial MT7628 tagging driver
Message-ID: <ai2mUbNT8acedvc0@makrotopia.org>
References: <20260613181845.111877-1-joey@tinyisr.com>
 <20260613181845.111877-4-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613181845.111877-4-joey@tinyisr.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-299021-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:joey@tinyisr.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:olteanv@gmail.com,m:andrew@lunn.ch,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:arinc.unal@arinc9.com,m:Landen.Chao@mediatek.com,m:dqfext@gmail.com,m:sean.wang@mediatek.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,arinc9.com,mediatek.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tinyisr.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email,makrotopia.org:email,makrotopia.org:mid,makrotopia.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D047E67F5A6

On Sat, Jun 13, 2026 at 09:18:44PM +0300, Joris Vaisvila wrote:
> Add support for the MT7628 embedded switch's tag.
> 
> The MT7628 tag is merged with the VLAN TPID field when a VLAN is
> appended by the switch hardware. It is not installed if the VLAN tag is
> already there on ingress. Due to this hardware quirk the tag cannot be
> trusted for port 0 if we don't know that the VLAN was added by the
> hardware. As a workaround for this the switch is configured to always
> append the port PVID tag even if the incoming packet is already tagged.
> The tagging driver can then trust that the tag is always accurate and
> the whole VLAN tag can be removed on ingress as it's only metadata for
> the tagger.
> 
> On egress the MT7628 tag allows precise TX, but the correct VLAN tag
> from tag_8021q is still appended or the switch will not forward the
> packet.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

