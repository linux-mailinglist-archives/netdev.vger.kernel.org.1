Return-Path: <netdev+bounces-285071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AMJCpPG+2l5EgAAu9opvQ
	(envelope-from <netdev+bounces-285071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:54:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB3D4E1684
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7587300B04A
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB523D1709;
	Wed,  6 May 2026 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U43K/eWC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B883B0AFA;
	Wed,  6 May 2026 22:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778108036; cv=none; b=BRkeBQl8/RIad0gZ87cP5FEaxb5oGl1+N4w8rSxR6TdORongQnJuwt75fdZGVtgZ/V0icIpSstpDGbaTmus3P8ZpiNSNsxT3NMWKSYCQryqiYeIq1Id6uGP2OQ+KakPkr7tDR/6fto4dxu8A9bPTWGen5AyBNYHLJWSTEtR0JHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778108036; c=relaxed/simple;
	bh=AhgvMPJ1nVhCG5ZGFgqTS1qy9nsqEXa7LOnXSqo5EPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaDg5YFCBXhiCJaUrCgGh+fPqPRLzfjfkRv++Xgn+JZDHauXYLaH28Spz/MWCMCwF1tQNQd+aXBeZFZThBbxAh8fajDSwURGaTitNMFPq2Q96mN1pLS4sHXLr2FmW12R0OXvBVgfUErVeUFSzkvjOiu3fLKaRbIHlWHjtx8Vyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U43K/eWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E63EC2BCB0;
	Wed,  6 May 2026 22:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778108035;
	bh=AhgvMPJ1nVhCG5ZGFgqTS1qy9nsqEXa7LOnXSqo5EPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U43K/eWC2JvJ8SNDndflV2NMV/YU/63rctFGfIpnpwwkJE45jqFp3ynsOSOnKEs5F
	 y22R/vU6XrP+jOD+pxBhb0/ebFmzzhZOAHKXAkQEs8C5FoMJTcaXi7KCw6xqZE8Ldn
	 E2ulRuRCcvg4dwKmvvbOH/pSj8YnA04qi9EsCbanHBvyeVaA7kQE3k6zzdz1xPN89y
	 OSin7c0xdh63txJ2v/o/qRg/ULUwm3lI7cdqdbvr+uun77PfEbszz6Fkx2mQaaoQmB
	 fqNT3HTM2UbCC/6ypGsedrFbtojdmlETCnN/RzV3tv39YTzEGUQRTQwUc1Mwfsyyk3
	 yYPZLJXwLoUSg==
Date: Wed, 6 May 2026 15:53:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch net-next v1 1/7] r8169: add support for multi irqs
Message-ID: <20260506155354.49e3c297@kernel.org>
In-Reply-To: <20260506081326.767-2-javen_xu@realsil.com.cn>
References: <20260506081326.767-1-javen_xu@realsil.com.cn>
	<20260506081326.767-2-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ABB3D4E1684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285071-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 6 May 2026 16:13:19 +0800 javen wrote:
> RSS uses multi rx queues to receive packets, and each rx queue needs one
> irq and napi. So this patch adds support for multi irqs and napi here.

drivers/net/ethernet/realtek/r8169_main.c:5205:16: warning: variable 'irqflags' set but not used [-Wunused-but-set-variable]
 5205 |         unsigned long irqflags;
      |                       ^

