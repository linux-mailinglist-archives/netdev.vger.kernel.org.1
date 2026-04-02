Return-Path: <netdev+bounces-274600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBupOe6NzmkbogYAu9opvQ
	(envelope-from <netdev+bounces-274600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:40:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE3D38B588
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16EE4302199A
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A4737474B;
	Thu,  2 Apr 2026 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D392ZXZS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9A33A007;
	Thu,  2 Apr 2026 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144270; cv=none; b=UdovXm6J7Wl3EY38MA5e1+BNrJnc4Im7U1Bnn6eryhEAvNFfzpBpcKyQaGvM9WRaCBMZ+yOse0YpkRuGlJoOlgJTOwsbWHEn0R9lZ1j3NWk/Bu/3EW2nJlu+QKD9b2DwW8ZlIBElRT8XwOKpfttxPO4OTU8KcSEfeOehvMhhfK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144270; c=relaxed/simple;
	bh=ohZ2HDtp4Z/Z6WJrkpeUxDLSzAUSROOullIzOzd8hmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfMYYj8kanDE3TmTHi0aXblBbFqTqoZIX0PgmkZy/IHzwCpjtfAOVXfcL61B46b1Rqf47lMkrq5jToRc+NFXtB8rKLrT3jjho6DxZYOIZKTy1eeaNWa0BP9WKQMc58dWQatfDrsfjzNfaYU5AJF0/U2vL7dQtKY6UHXOjgLREHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D392ZXZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81EAC116C6;
	Thu,  2 Apr 2026 15:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775144269;
	bh=ohZ2HDtp4Z/Z6WJrkpeUxDLSzAUSROOullIzOzd8hmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D392ZXZSh4jR48UCxYhNi9SeatNR+FbXthOJM98LYHxJS9/Q6CONIEPD74QcqMxQa
	 EP1c6Pistguv12W1E7eSJMU7joPtxbgo/dcwshmT3/9oPnicJ4D3slH5e+RYqBfu5L
	 RApvGw0q/8xSqB3md7/+O/g75ejuU5M7szSbBuiZeLs4QM+lXnYPELyuMaWIpzVS60
	 81KIfgxKH1k3mxUyJ7VQyyMJkCEuMxkQ71KMHPgkgPRATCEN1QU9KzEUVsXRPHvf0D
	 aqa2DCPNmhvLAotVQTPrGaMNAGjY4uF5yCQBrMbJiuYnhTJ0Z0GooBanRADjFJWqRi
	 Tb4uru2vjG0Zg==
Date: Thu, 2 Apr 2026 08:37:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Zefir Kurtisi <zefir.kurtisi@westermo.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Simon
 Horman <horms@kernel.org>, bpf@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: enetc: pad short frames in software
Message-ID: <20260402083747.4f496c9a@kernel.org>
In-Reply-To: <20260401172246.1075883-3-vladimir.oltean@nxp.com>
References: <20260401172246.1075883-1-vladimir.oltean@nxp.com>
	<20260401172246.1075883-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274600-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DE3D38B588
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed,  1 Apr 2026 20:22:45 +0300 Vladimir Oltean wrote:
> The ENETC does not support BUF_LEN or FRM_LEN in TX buffer descriptors
> less than 16. This is written in the reference manual of all SoCs
> supported by the driver: LS1028A, i.MX943, i.MX95 etc.
> 
>   Frames must not have a FRM_LEN that is less than 16 bytes. Frames of
>   0-15 bytes are not supported.
>   (...)
>   The first descriptor in a chain must not have a BUFF_LEN that is less
>   than 16 bytes.
> 
> I don't think proper attention was paid to this during development, we
> found the text at the end of a bug investigation. Therefore, the driver
> does not enforce this.

AI points out that the frame may be longer than 16B but fragmented.
Only the Ethernet header is guaranteed to be in the linear part.
So you may need to also toss something like pskb_may_pull(16) after
that padding call.
-- 
pw-bot: cr

