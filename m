Return-Path: <netdev+bounces-284643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAKzJ9CX+mk6QAMAu9opvQ
	(envelope-from <netdev+bounces-284643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:22:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2970E4D53A2
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5168B3029ADD
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C7E231A3B;
	Wed,  6 May 2026 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7Aqt45n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58411EF09B
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778030541; cv=none; b=XBtSRkvBhcOSSStLZaawh/L922pUc/RhV9t3EW5Qndrvz1inA53Szwpna7yU2sBMkRRZLqpMX/C67Vej3oG+EoMViGfh3/h/hYfg8jmK1o/kUfvxXw8c72ljDGRaGFOkQLSHxAMuwarvZwgR2FDRv8f11WJp3AlOibjmQVci6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778030541; c=relaxed/simple;
	bh=tBZznMZhe/z/vc4OOIqsH+actGAsU1Pg7notBrzzcdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTOGisoTaPXF1dkxzU6Oi0G+KS8cbAfr5vx+x230DUiWGofXKGA0Q5HH44FffQeYOOy01BAe1npFnKDKh+Z2qcmYuBB9kUeATPvS9/zdO4zd30O9d9n4qsilu1uuxxyUDXDev4PgbpYB9Dba5qAQNU4vA0ZX01sYOMWoDu2Xqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7Aqt45n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EE0C2BCB4;
	Wed,  6 May 2026 01:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778030541;
	bh=tBZznMZhe/z/vc4OOIqsH+actGAsU1Pg7notBrzzcdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D7Aqt45nWyh18DTHzQ7+alG28Pi7knAAMEh8vClY7mWFq30Onz9PnX/RK9415DXnc
	 fjqdkDgJlRSEH/D7HB+1x1zfK7iBaCgwduNvYmy5tIxX/p+yRNyw8Eji+2aRqnKxzt
	 MeVpcmFbUnBEOdIftVAZQRM90UDGLqwPZ54BqIGSe8Sysv+HR3x4lb81eh1zny8ROZ
	 3Vueo9mt8xzEjzfiHLYLiy2oYY8B52xm74O0/KEnxCM99L1vhfdqWveNGq5/wEmpI3
	 HkwGycho9d9miJXd9+y8HPU/rs3SlDB72MEu2GsvNjRndNcC5VwFQMeip+xTf2WsUq
	 0DFb5UNoHK94g==
Date: Tue, 5 May 2026 18:22:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 andrew+netdev@lunn.ch, chleroy@kernel.org, qiang.zhao@nxp.com,
 horms@kernel.org
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: return NETDEV_TX_OK if skb
 was freed
Message-ID: <20260505182220.29e5f34e@kernel.org>
In-Reply-To: <20260504174406.2229693-1-holger.brunck@hitachienergy.com>
References: <20260504174406.2229693-1-holger.brunck@hitachienergy.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2970E4D53A2
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-284643-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon,  4 May 2026 19:44:06 +0200 Holger Brunck wrote:
> If the skb was freed in the ucc_hdlc_tx function and the packet marked
> as dropped we need to return NETDEV_TX_OK. Otherwise the above layer
> will try to requeue an already freed skb.

Is this really true? I thought negative returns mean drop.

