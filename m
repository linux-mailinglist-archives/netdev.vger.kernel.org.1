Return-Path: <netdev+bounces-256810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKY3Duqkg2nprQMAu9opvQ
	(envelope-from <netdev+bounces-256810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 20:58:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C924EC4EC
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 20:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2227030087B4
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 19:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2303D9043;
	Wed,  4 Feb 2026 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="U7bu5OUn"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE33B95F9
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235111; cv=none; b=qC9RFw84+mUKhF6782kS+HSIm4xF/rSKDSLnFdExSqpY+tX2XXeaoqWexy5+7/AO/TafJCbUKIcr6H5mhUUhGEiZACK5KaufgUYkduGpdnArTgKo46/hZyjaL9ok50qMUe1LPlK5TG9t54y8+Dk/Djkw2309KAtaQb3jE7RP6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235111; c=relaxed/simple;
	bh=dt3Z/Cgo0Nl3MpY57b0JubP2dxKNjWvqAO/32zYPcho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqOiPmszUSQ1ME+nZXTGZB1ehPMg3XoBfomDzpfOZR+VFRcUBvuqWvX5rpBxvJUmcpgvH3QODXYOMs5pxrfwSHXP/tfBq5KaZcNy+3hhHIkYCZFgTE9GhBdrExruptKsdzpR5e9lWg0AG/Gr9yUSPn/K3uEVebEc2uAq13N2YYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=U7bu5OUn; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=dt3Z/Cgo0Nl3MpY57b0JubP2dxKNjWvqAO/32zYPcho=; b=U7bu5OUniqo6Olu36IlqocMsH+
	262O4zregLAcmwC6jveuusa2Sc8guXWhDH8ABrJctf3y7GAfRJCxxbghqzBQENbXev8sms9d0t5kG
	Cnlxo7V8hE/KFlAhN13b70IQ+wP5H08DYcN8UNXGiINPhJK7mHlKgLQref/mYUAKKca+dCkwLzgAI
	5bvsB4emNIkMJjpF66WesCuWhU/HYV41NDr5oufKN+RcfTdQjPj1E8wRPTqcHULOl4USJmN1L+9jI
	PrbfS4kax2fHuEhMdkSPeTQgShNLgYJzSyAzMlWWmQCtKzDgscEwjWJHPUNKOcc7okFqe4pwAZsqQ
	6D7Oasow==;
Received: from i53875ac7.versanet.de ([83.135.90.199] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vnj12-0070vf-PN; Wed, 04 Feb 2026 20:58:21 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Subject:
 Re: [PATCH net-next 2/6] net: stmmac: rk: replace empty set_to_rmii() with
 supports_rmii
Date: Wed, 04 Feb 2026 20:58:20 +0100
Message-ID: <10482755.VV5PYv0bhD@diego>
In-Reply-To: <E1vnYxq-00000007hor-3yXt@rmk-PC.armlinux.org.uk>
References:
 <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYxq-00000007hor-3yXt@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256810-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,sntech.de:dkim,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C924EC4EC
X-Rspamd-Action: no action

Am Mittwoch, 4. Februar 2026, 10:14:22 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Russell King (Oracle):
> Rather than providing a now-empty set_to_rmii() method to indicate
> that RMII is supported, switch to setting ops->supports_rmii instead.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de> #px30,rk3328,rk3568,rk3588




