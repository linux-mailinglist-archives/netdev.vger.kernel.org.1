Return-Path: <netdev+bounces-251476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FW3CQFRcGlvXQAAu9opvQ
	(envelope-from <netdev+bounces-251476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:07:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FBC50CCA
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34DBF668069
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817E642669F;
	Tue, 20 Jan 2026 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlmOhSO+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E5219F40A;
	Tue, 20 Jan 2026 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912243; cv=none; b=lIxTeCgBKkUnSuEdCDua8fwrDJ+nC5CcGmW5VMdri0V1CUjBZGwwTVAAdvPlz539EPCwGCYUJIaAZJLCBR22NutTDZblGgW/eNxgyiKbUbf2ViET9c0ywA7AEPYXcyqI9IYyvQi0aOPvRW0oiJ8oyfbVmGgCyB0Wl+G5dMIu/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912243; c=relaxed/simple;
	bh=PAiDS+aD8ZlPmqw5dS1dSflt1QD3pt5BZfWhYrMM3D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlybIrV4DjCOM+YiN2E3gn7djup8gvdEcEwnNQjglLvZqYojHhpzahVDINCV4Ltuv64cOIvS/KE/Rs01Zvjm6BsEeiZuaf1izD03C9EERKEXmBKKaYnuSUlRzamCCUy24R22SPM+XEDQkpxLYwwaHj9Hu+MFzUZouud38wGrZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlmOhSO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F64C16AAE;
	Tue, 20 Jan 2026 12:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768912242;
	bh=PAiDS+aD8ZlPmqw5dS1dSflt1QD3pt5BZfWhYrMM3D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlmOhSO+C0vVYfQEbtcDTLPsYZnmqCzpq/zS2iDwnl01gRyA6D0QFmewFDEyTtUw4
	 unAD678trNkmXAFr9c1yP3ZJgZepsurcT3slG6sh47w8+OvymgLP4Q5V4YTo1nl2AL
	 Rla2cLcG1FP+GsB2T2FjAzKcUWKuurfHcis+36FD+Wul7WMDViHHsjq3A154vOzSkD
	 7mxOl5ODPPB/uqs1KofyvmbsQevDCkaZ+PdBbRwW3QRBIFxtwZ3R7dcHIJDOMDifs4
	 TTjxecgnFR9lSN3H93YGPHywq1xWnxzCqiyqMjh6w5F/XNjnlX46xoDXmG12CfXBHQ
	 InsoSHOH1BYTw==
Date: Tue, 20 Jan 2026 12:30:37 +0000
From: Simon Horman <horms@kernel.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mani@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Nuzaihan <zaihan@unrealasia.net>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [net-next v7 5/8] net: wwan: add NMEA port support
Message-ID: <aW91bYu1ueczfGTh@horms.kernel.org>
References: <20260115114625.46991-1-slark_xiao@163.com>
 <20260115114625.46991-6-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115114625.46991-6-slark_xiao@163.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251476-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,unrealasia.net,quicinc.com,linaro.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B4FBC50CCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Jan 15, 2026 at 07:46:22PM +0800, Slark Xiao wrote:

...

> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c

...

> +#else
> +static inline int wwan_port_register_gnss(struct wwan_port *port)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void wwan_port_unregister_gnss(struct wwan_port *port)
> +{
> +	WARN_ON(1);	/* This handler cannot be called */
> +}

Please don't use the inline keyword in .c files unless there is a
demonstrable - usually performance - reason to do so. Rather, let the
compiler inline code as it sees fit.

Using the inline keyword in .h is of course fine.

> +#endif
> +

...

