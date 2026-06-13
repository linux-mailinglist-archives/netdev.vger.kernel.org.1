Return-Path: <netdev+bounces-299038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G280BH66LWqYjAQAu9opvQ
	(envelope-from <netdev+bounces-299038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:15:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 952E767F9D6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:15:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SgUqkyKs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299038-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299038-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29B213004900
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C91A38AC9A;
	Sat, 13 Jun 2026 20:15:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F52384CCE
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:15:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381756; cv=none; b=eyigr3YzWpmYbckcj9zckq+etGNaAN7F7CwNnmN0t/Png+S2YxKAaUlJ0ng+ItoXSDhSohm3H2By+RVpKUT2sgjRsDU+JUUaa91XxTmVn/L2qh31heJBUSXo7B0pElC9D3YsMko5LN4esCT2Yx9QqcCg1PM9Ct9uDmleCfcdaT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381756; c=relaxed/simple;
	bh=rRTrySV9yA+xCHLUqvVcKeYYsa143+FfetzEjN7PA/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWyzLxKLN1sVd8VaAy72QgTCDSIENTTK2Y8wxUVavGk0tVRBjO4O23u/plVJ6T651T2Fpwh5fl6LKzZ1kBecPBLpWJ0BxwB+kpcs8oJ3iRfEASuOnqCLteNKa/F6Dix3CU7g3JX7tJbyoQ/1eSl0kinUC7zjZ6BFV/d7a1U0Wa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgUqkyKs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8D81F000E9;
	Sat, 13 Jun 2026 20:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781381753;
	bh=WxlDaEHrnY/6JpLw+e+NURKreiTOAGVQZU7Q0fzZ2rQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SgUqkyKsJvlAKY2uqdo90cEAFV4syPBT72UjAZAGJFluOga3/Mow9/XZNfE+jECx5
	 G6laIXnqgOc4ggUvvwSmRTwvTel60ZNLNhrC5Q4GCBr76+nHOV9IcOjTS/GZcHgfu9
	 UbVrQrHGORWwzFQINPCCQlCP1bhoSKP6hxJjAXEhGOAth+J+QYlEgHQ89snkBb5tn6
	 xmYpxSkz/fE5/AdUGlc6V4amVf/eNW8IXvPvWT9oAXTlcRe+VWVaGp1oDw3xDXzA9J
	 erJI1AU8QP1Z4vi4aemjvUNw0YvB3Ktf9uS55mzDx/bJd9ZHOFGUwbT0yptIxGWox2
	 qXr472M3lKFNA==
Date: Sat, 13 Jun 2026 13:15:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>, Antony Antony
 <antony.antony@secunet.com>
Cc: David Miller <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/18] pull request (net-next): ipsec-next 2026-06-12
Message-ID: <20260613131552.2562d433@kernel.org>
In-Reply-To: <20260612074725.1760473-1-steffen.klassert@secunet.com>
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:antony.antony@secunet.com,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-299038-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 952E767F9D6

On Fri, 12 Jun 2026 09:46:16 +0200 Steffen Klassert wrote:
> 3) Add a new netlink message XFRM_MSG_MIGRATE_STATE that
>    allows migrating individual IPsec SAs independently of
>    their policies. The existing XFRM_MSG_MIGRATE is tightly coupled
>    to policy+SA migration, lacks SPI for unique SA identification,
>    and cannot express reqid changes or migrate Transport mode
>    selectors. The new interface identifies the SA via SPI and mark,
>    supports reqid changes, address family changes, encap removal,
>    and uses an atomic create+install flow under x->lock to prevent
>    SN/IV reuse during AEAD SA migration.
>    From Antony Antony.

Hi! There are some Sashiko comments here, please follow up:

https://sashiko.dev/#/patchset/20260612074725.1760473-8-steffen.klassert@secunet.com

