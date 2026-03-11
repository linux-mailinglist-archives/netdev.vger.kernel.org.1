Return-Path: <netdev+bounces-266744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNkzCfW4sWmxEwAAu9opvQ
	(envelope-from <netdev+bounces-266744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:48:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F07A268DA9
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 292C53021C14
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811113EBF01;
	Wed, 11 Mar 2026 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="vbnC+Vk3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E23EB812
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254846; cv=none; b=UTq/m8lomgkt8YLHKpL2cuZNSDPVMr1ZxLmuDnFRvVK8jMepOMgI30skByl8c4FrUE7y20cR3jlwJVk0P1Vnqq9oM1bdUKNZmK7Rquk9XI3pYpwVPYbGOinlWg/GunqS+zidcvr8N/9SKV4bS/Ya1dlCfqq++GyVcT7Cg8KHCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254846; c=relaxed/simple;
	bh=Jl7leThxnp/lGPAmTErmrNimY7QkLMfU1aZqqvKoU40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtozXVGW9WG66HglPHKZH6tQ6QVaTeFmI5q5P4jPTcExbhouZHKwrs6s5iZ3frpcjGnSI8NmKt3NGuimfAkMb2Mb6zrLJsdcHXLRJHVxwG97Pr0kXbN9NDAIQv1UAeGgWs4Ezcs4uiIVMe5fAojFzEm/dCObRJ224/XZpVef5a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=fail smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=vbnC+Vk3; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773254829; x=1773514029;
	bh=Jl7leThxnp/lGPAmTErmrNimY7QkLMfU1aZqqvKoU40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vbnC+Vk3tCDm99skCrj6obm6wxp1HQZt8aS+bc1z+/aa69PTErRtp37kWoM/dpVVB
	 7DTxpUUJUyhq9vyAbZlPRzCS3vI0y2P/MV9zlLr8w46e9aRzNmnXMFwy9GCZOvjopd
	 G9k/kfyfCnpZfRwP7ppQRnZrQfqI1aAgG/2xw41rJF7kdoLJzMJEaI5x9Uvm/nQpnW
	 E8ovvpErJJTYcUvpj4kJ7UkO78UYQwYZv9B9LsZugaII7tKsN5CDN6fVBOFHwra/7K
	 3PQxI1OrJYbkTox3ccDj0Ix8wwKLpfh2y/oy+YcldZ9erwpd8v8vhUeoSrPYNXexNU
	 dq2Sq47WAsbnQ==
Date: Wed, 11 Mar 2026 18:47:05 +0000
To: Simon Horman <horms@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: edumazet@google.com, stable@vger.kernel.org, herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, steffen.klassert@secunet.com, chopps@labn.net, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [net] xfrm: iptfs: only publish mode_data after clone setup
Message-ID: <gMKu-eP2Z17VRGWDt3UsswTDUTaUJjm9BDstYEsXaGoK7ZFwEFDiflQT85gbZ1IiVx2mjZ09xI6Mn72M23V-3oYTNL8nMgb112XEGMoXcJY=@1g4.org>
In-Reply-To: <20260311171134.1134085-1-horms@kernel.org>
References: <20260309173033.537743-1-p@1g4.org> <20260311171134.1134085-1-horms@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: ffd8969943b7fec8d286fa5d2d15212eda546b76
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266744-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[1g4.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F07A268DA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
> > Fixes: 4b3faf610cc63 ("xfrm: iptfs: add new iptfs xfrm mode impl")
>=20
> Should this Fixes tag point to 6be02e3e4f37 instead?
>=20

Yes

Thanks,
Paul

