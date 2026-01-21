Return-Path: <netdev+bounces-251680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ5QGncncGmyWwAAu9opvQ
	(envelope-from <netdev+bounces-251680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:10:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C65F4EE85
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAD1C842F17
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95122E62DA;
	Wed, 21 Jan 2026 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC+4dAny"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F8A2DECAA;
	Wed, 21 Jan 2026 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957808; cv=none; b=S8EP69PXIDirytKGIiUWcjDydmUd/Mg2mcVo/Rax0W1LF4dAmnhikR516Euwiy/FJU0kMfTsjbFVswJjfgm+cYFrXWQTq7p6N6Qq5+inaHz/+MtwkxIvQdsJaEdwfFJmvcgLLtEBla0IvmZL3fyPiAyuOuwGfv7VVdpk4UEdOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957808; c=relaxed/simple;
	bh=BxaNh7NlfTOD8Pd851C5gREI76ONSHj0XlS1kksYByo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQAeuCDFhcxDLusLjsd/6QpRxdG3wT4P2aUFLt+LPPId237qqWdry3sW0RTIa+Wgn3+QF+ZbburoQhJ7dxyYgrJQTQfF1tiiLksjlnN0uw1JDxtYPr6PWIHDedexS7vSIOgp+4syEZkqtz4JidSBywnpL44X9rqojXArhEz52iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC+4dAny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0DFC19423;
	Wed, 21 Jan 2026 01:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768957808;
	bh=BxaNh7NlfTOD8Pd851C5gREI76ONSHj0XlS1kksYByo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VC+4dAnyLorb0XoMiORXp/RxEMsK4AjzTUVsVy0st2nAnd7ExgJghmzn9m8jVtFfa
	 pU3DF26PD5FEtP0fTXllKqXfnePgFh+hn8JP0W6fHVAJ2ZEqX5bh5AcEK+72g9RuP8
	 SUmYh9c249K87SZcLQL0mZAE/jALYbyf/Z5pEVLVp8kGgyHU5jt12OtvARpW7AgccS
	 xs+VzInip1B5in+e2v4zUn/TiDPj0jmrqGVrldqbxPtflOp3jT0DOx8KCJUC/V+Qj1
	 eMLkRcjb+I4Ly0jFyJP5hgwx/sRb3UaKhZRemS8WTg15E2eExpEdvQ4vFBGuPWc/IC
	 yS/b+IKn/9xSw==
Date: Tue, 20 Jan 2026 17:10:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jian Zhang" <zhangjian.3032@bytedance.com>
Cc: "Jeremy Kerr" <jk@codeconstruct.com.au>, "Matt Johnston"
 <matt@codeconstruct.com.au>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <mkl@pengutronix.de>
Subject: Re: [PATCH net-next v2 v2 1/2] net: mctp-i2c: notify user space on
 TX failure
Message-ID: <20260120171007.23667da5@kernel.org>
In-Reply-To: <20260116085840.1946398-1-zhangjian.3032@bytedance.com>
References: <20260116085840.1946398-1-zhangjian.3032@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-251680-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1C65F4EE85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 16 Jan 2026 16:58:39 +0800 Jian Zhang wrote:
> Report local transmit errors from the MCTP I2C transport using
> sock_queue_err_skb(), allowing the socket layer to be notified
> of failed transmissions.

Shouldn't you hide this behind a setsockopt() knob?
Existing applications will not expect having to service the error queue.
-- 
pw-bot: cr

