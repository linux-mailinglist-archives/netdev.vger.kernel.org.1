Return-Path: <netdev+bounces-300272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /5bNOrkuM2rb+AUAu9opvQ
	(envelope-from <netdev+bounces-300272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:33:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D37869CCEC
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:33:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Pe2T3+LF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300272-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300272-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3710303662C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3453E1DE4F1;
	Wed, 17 Jun 2026 23:33:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41782233927;
	Wed, 17 Jun 2026 23:33:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781739191; cv=none; b=Y0ur+QkYbVpttYmuxMWXk87i7EnwizztBo5VsYSYggBaWib6cHLa3wP4IYCGc8BqzvQ8V3Ymw84FUr2lz/m9g3fUjEutk0Bgm6mtbXojvClNaqb4q3sqenTcIM10Gkd1pZRn1/VB0k54AkSJTEeDaGpoG5D9kPAkOVRugR7szM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781739191; c=relaxed/simple;
	bh=gSRScAjoNruAA7mK7nwgGLD94bj30iuT3rfSfEN3ER8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnjtwDYjxKrDgA8h2rR95xXy5JeE39zFsR332502Sw1+CTGsA/KjiW2O3/zpFHSUrDPadDuHhZM/+ZonBMBd5IbWIuyUUjtQQkrrsJmKxO61h6rq703+ILnXqQgJbjEgWlG9ui44aCQXVYfEoAbKHMYb+ucaPHAYqB/8y1QjqKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe2T3+LF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F221F000E9;
	Wed, 17 Jun 2026 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781739189;
	bh=YWz9pOu0z95gQdi03IszD/naS9Day5Wu/VQ664au8oQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pe2T3+LFNY/fMa5+jNaVg3nuepf49NwYd1eFHOXe7WNCx44+Rhd8XCwnBuBwC5Byl
	 S6VIAfVAH7k76Mt/B9tR9yCiYTb5VlON0K/TfSk0XPlgpEGZc1KOXC8F5QvdM7WTQK
	 OWKPRWJQ9KEPhz9mS8FWUutuXEaV08xwV1+nKSb1Kzcm+7xPHEcButWaHcxEA2lyEU
	 vdgFWRnAQoTZQBTFl93kiXD6l2jpyGS6b/VaO+BPwNNtzb/ZFsd+P2o75vLz9GTR15
	 1SahyIPrdFybmbc72ehxAPkeMouxkrGhqtNQchnuWFSNZ0q2MsJFeXYv4NV4FNCtDe
	 vgS5lRWxjd30Q==
Date: Wed, 17 Jun 2026 16:33:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tn40xx: fix netdev and NAPI leak in probe error
 paths
Message-ID: <20260617163308.2a6fb097@kernel.org>
In-Reply-To: <20260615064256.1068059-1-zhaojinming@uniontech.com>
References: <20260615064256.1068059-1-zhaojinming@uniontech.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300272-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaojinming@uniontech.com,m:fujita.tomonori@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fujitatomonori@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D37869CCEC

On Mon, 15 Jun 2026 14:42:56 +0800 ZhaoJinming wrote:
> In tn40_probe(), after tn40_netdev_alloc() and netif_napi_add() succeed,
> none of the subsequent error paths call netif_napi_del() or free_netdev()
> to undo these operations.  On any probe failure after netif_napi_add() the
> NAPI structure (embedded in the netdev private data) remains on the
> per-netdev napi_list while the backing memory is never freed, causing:

it's devm_ allocated:

	ndev = devm_alloc_etherdev(&pdev->dev, sizeof(struct tn40_priv));

you're introducing a bug instead of fixing one..
-- 
pw-bot: reject
pv-bot: slop

