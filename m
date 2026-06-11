Return-Path: <netdev+bounces-298104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GnVqBuKiKmp8uAMAu9opvQ
	(envelope-from <netdev+bounces-298104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:58:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C09671943
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:58:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MtrwLgQ6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298104-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298104-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03B37312F865
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A85E3CAE7F;
	Thu, 11 Jun 2026 11:56:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EB73BED74;
	Thu, 11 Jun 2026 11:56:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179011; cv=none; b=UEjWb6HoL1aq+GNEx1tHIzRye9HSWuEWYoJK91bAZXxbPeJsHzSBdK+0/OJdMSXfyPXQf4goUtY8S2Cgobz0/mImzMMX0vxb5Mwb5cLDlJ+mxKZbKRoWk1bDC6/4yfYJgcp4DPGCM8UU89cc7COPFIDdUU5tlGviFdHFXMw5KUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179011; c=relaxed/simple;
	bh=p+z2Cb+IYqw0oF+ulEcKkpYQyMc55w2fHKqiVKP4B0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAaA1wgayXlsUzQXYhc+15A/fT2Mx1AbK1W5Hdviv4EBwHvp17gvDDotBXOY55dthSzNGb96zL6QPSq95uGo9oNZU7a6mlqXjZUweSUBI+AnXeXv9P0uqqzHAtczmDkXfIw4AwjDmqjDxPsLLDN2MWOiT56TcAmF6OVAQXBG18U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtrwLgQ6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1721F00893;
	Thu, 11 Jun 2026 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781179010;
	bh=p+z2Cb+IYqw0oF+ulEcKkpYQyMc55w2fHKqiVKP4B0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MtrwLgQ6J4LUv5hkXoos/e/FjkDLL6BZyozh+84eapQ9D2wJMrgbqwkUAv3fsfz+F
	 idy+h06nwp0JIQwxvFRUpDpanrKXiQnK9Z3ahs4nk00LPBCBa3hChS5q03HlshSwoD
	 SsNJU+UMmmYmNeibXZbIDEsM1ALvmER06/OnYwj+q39Cye+d9ueGQ2TqlYxq/XW8jt
	 zljVjt+lRe+VZyoL77vWTvnZDLWu2k8D9eWTRR/gpsTWdCYXVH2YXGOoYM28LpTAp/
	 NzTRFnrisXo/0b7wFjeXpvZIhlJDR8EcZ61tDzi1rbDz0pz5AILFzPdApUPBhj7zCA
	 uL5qKlJMzsFrA==
Date: Thu, 11 Jun 2026 14:56:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jihong Min <hurryman2212@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Antoine Tenart <atenart@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] xfrm: extend ESP offload infrastructure for packet
 engines
Message-ID: <20260611115646.GN327369@unreal>
References: <20260523121522.3023992-1-hurryman2212@gmail.com>
 <20260523121522.3023992-2-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260523121522.3023992-2-hurryman2212@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hurryman2212@gmail.com,m:ansuelsmth@gmail.com,m:atenart@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298104-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,gondor.apana.org.au,davemloft.net,lunn.ch,google.com,redhat.com,secunet.com,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unreal:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57C09671943

On Sat, May 23, 2026 at 09:15:20PM +0900, Jihong Min wrote:
> Some ESP offload engines operate on whole ESP packets rather than the
> generic software trailer layout. They can generate outbound ESP padding,
> next-header and ICV bytes in hardware, and inbound decapsulation can
> return an already-trimmed packet with the recovered next-header value.

How does this differ from the existing IPsec packet‑offload support in the
Linux kernel?

Thanks

