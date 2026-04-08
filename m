Return-Path: <netdev+bounces-276671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJUpO+iX1mlSGggAu9opvQ
	(envelope-from <netdev+bounces-276671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:01:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8EC3BFEAB
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 186E53007AC1
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC9D3537FC;
	Wed,  8 Apr 2026 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Azy4N4mz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PvB9HLVB"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FEB4317D;
	Wed,  8 Apr 2026 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671266; cv=none; b=oqpdcvxfo1JP2AP6VkvUcFBlVBhasWX01S0/DVh3Xd60eBPpynXpODm1CODs7d+dqxky43SLeYobX8i7o2ImoA4bGlH5LC+5PQYelA9FDPUChy4VI0jvTos50AQwy82nJ38CBnuR4t3sqj5N+LpnrCL11qiEQohplZJR5lBgE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671266; c=relaxed/simple;
	bh=QC5gkRPIAuhh0lxly35F9zV0BbUKfHHCyyHTCdeEfYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCqEGtmjBP4vFjmjE+qmZuSzeYFZXgsQl54CZEElm9KDyqqkhqnOtfcojPCjUjTC63yeDG8rKtotQtHNoBreCZ9ZNGUK6ck0ygS7xaBkffm2rDjaVq8e3lftgU2mOjTJz0FdZWfmqyeaIhjT6nY5Qic4CRO4hDuy0+vbpxUaM/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Azy4N4mz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PvB9HLVB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1A94F1D00281;
	Wed,  8 Apr 2026 14:01:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 08 Apr 2026 14:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775671261; x=
	1775757661; bh=b8nHCVt3ibsu0+QXfjS3MVb3Q+x9ehwEWmyQgygbBs0=; b=A
	zy4N4mzst171FX8vmaEfzbjEE5ipXaVBT7q32K1WSaCyY6TB7PP3MZI8HSnelozN
	KzKw6EZH5W+4ZLiNf4QRDxLyfApPjzR8ltRKwMjZj0AQA+lfVS4OZih+FxZgd3o2
	3mvz9vB7ya6DtOUCJAUgCysgQVzltW2cHLDW8IHKbrCOx0E0eN+tEo0vIEpgBdQ4
	2nWcqT6+BOjxijtT0kXW0cT3BROxZ8no8Q+XR/5hhx9PiatcgyOgyO8SkPzsLSLw
	Ayq35ZWGjB6w/eIL2OYefeLWPzgcWBEh7akqH7RLRpXvEBrpp1SzMHcOKWEQ+2J4
	Vpqx1RdqvKKhRT0vpPkJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775671261; x=1775757661; bh=b8nHCVt3ibsu0+QXfjS3MVb3Q+x9ehwEWmy
	QgygbBs0=; b=PvB9HLVBkhcggCOQCtTstGsGm75ZoJ/smC4l6zWVBy1yHw3+gQQ
	NNB+/Lr+UduVthP9jiOfYang0XKZCZuCfIcBHbXLKxpZEZ1KvLFv+Z8eLx0qVR0C
	c+xhoXygg/qDSVmuyUA1WWHUQ94YLqnpL2PNP72A6rR27VXJKe1S7gW2RpUFcc4N
	VBurwKS7wsXhn+LAUBiMGhTyb29QqmlZEp1oynEV5bhCUzvb4AH/ghVEeQPZEM6e
	bB11am9qq/97OQtRs4CSiG0AMXkJbWO2ESwQ8CMtFKLk7vrHwUK5b4TjwcBgRgCh
	q++mngXqBwg6S47jxH4dGaMMI1nPeIhLClQ==
X-ME-Sender: <xms:3JfWaQTdclOEXjjqpiy7wHnTORAGAbB9UaUjZmX1DNK7yidNhAUJKA>
    <xme:3JfWaX29E4vtDNOWhukXkFdlBhlJxumRyBpyBQQreaFXNUkJtcLfD6tl7obAuGjoZ
    eOKJWbo6AksGguxILE1nHwwoYI6REKHLin6yN4j_mGNDo5pYEaFNNM>
X-ME-Received: <xmr:3JfWaSxIjBacaHVdcMaixHWm8IBxrtNkmfeSOLhLBJYpsiotRQN5t9bghqR6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtrhgrthhiuhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvg
    hmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgv
X-ME-Proxy: <xmx:3JfWabwlEM3gFeMfhnHgppiagH5RW9cAWDllqFHTQTXG4SFY--K2Pw>
    <xmx:3JfWaW_s3EDfhsRnHGrOStIgI9Wj4omLcMGiARoTbd-2IIUeD4a-Ag>
    <xmx:3JfWad-yRxqu3SvwlDqazcsOcjNrx3eIIpK7VX703bo3I5q_zpQooQ>
    <xmx:3JfWaW7KTxMVbfM8uA3DnSNZ0TRMFNr-I_W26Q4oTQ6cTHdomyADXA>
    <xmx:3ZfWac6mpwsPxKlR77jBAefg8KpZ9QkimYSxT3JdwB3Tv3a8_z_IHYHX>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 14:01:00 -0400 (EDT)
Date: Wed, 8 Apr 2026 20:00:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, David Wei <dw@davidwei.uk>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net v8 1/4] selftests: Migrate nsim-only MACsec tests to
 Python
Message-ID: <adaX2szD10INOMxp@krikkit>
References: <20260408115240.1636047-1-cratiu@nvidia.com>
 <20260408115240.1636047-2-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408115240.1636047-2-cratiu@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276671-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC8EC3BFEAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-08, 14:52:37 +0300, Cosmin Ratiu wrote:
> Move MACsec offload API and ethtool feature tests from
> tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh to
> tools/testing/selftests/drivers/net/macsec.py using the NetDrvEnv
> framework so tests can run against both netdevsim (default) and real
> hardware (NETIF=ethX). As some real hardware requires MACsec to use
> encryption, add that to the tests.
> 
> Netdevsim-specific limit checks (max SecY, max RX SC) were moved into
> separate test cases to avoid failures on real hardware.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  tools/testing/selftests/drivers/net/Makefile  |   1 +
>  tools/testing/selftests/drivers/net/config    |   1 +
>  tools/testing/selftests/drivers/net/macsec.py | 202 ++++++++++++++++++
>  .../selftests/drivers/net/netdevsim/Makefile  |   1 -
>  .../drivers/net/netdevsim/macsec-offload.sh   | 117 ----------
>  5 files changed, 204 insertions(+), 118 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/macsec.py
>  delete mode 100755 tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

