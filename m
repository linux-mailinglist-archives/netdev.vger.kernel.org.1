Return-Path: <netdev+bounces-284645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP6ZN+yY+mmRQAMAu9opvQ
	(envelope-from <netdev+bounces-284645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:27:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8324D5401
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 233063032747
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4B25F98B;
	Wed,  6 May 2026 01:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAzRo0FD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF43770B;
	Wed,  6 May 2026 01:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778030800; cv=none; b=jTYZ1Rcir53+ntIdM17V6LLYmvl1vkhHwFFdOltTMgKOJu2eIF0ytjEoP0aVocAM+uPdpcx4mNUC1QkrF5I7fpj+JBwkvbzyqG+tUTZhpYSjr4k2fq0Er8Js/R2ArgeobY/MLcWIZzbGHriZFS5N0suDVFp2gnX64D8sy+61zc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778030800; c=relaxed/simple;
	bh=OcTJZt2T6EAjkGBgEFJnlNJNmLQI8RCYJhS4pT8MLlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwUOwL3ulmlseMZBIsmBcG5Zb5aTnWA5WZKBNuH+ruSSRQLHm7Durf0VzdVnAZ0Zaf/trHtjIQ/7cYGPtNh4vjvUFhTOh76uB+0V4+6kiS28v7W1rhUA+oer2yB9Cc68WRrhBjLBiMYOG9XkAzpvagr+fUs+T9451erVtv+anfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAzRo0FD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E66C2BCB4;
	Wed,  6 May 2026 01:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778030800;
	bh=OcTJZt2T6EAjkGBgEFJnlNJNmLQI8RCYJhS4pT8MLlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uAzRo0FDaWXEXUqpY/yMIpDaSxTc00HnH8PmybDFU+gfEv4mmgqBNoLxZ2XRHWJjl
	 HQyL/lCOoGzF+7sLWoFd67+twxkQbb2+hMJmsiAd8DYsWFqr0LklUmiVpSxjwucFSV
	 Yaowdu1cdXCiBcPtHh7rGXDom/eg7+/uNwxCiGn+8+DR38Bx5M0qEy1myy9NU1VP8i
	 wLb/auqVxFgx0x9Km8/X5jQbYctDt/MiOHl/Yc9cYh/N3vUxb2LwGQsnzmNFC7OXPF
	 23SDGgeqhZT85RIr8M8uvM3w0zogPlL+MiwDoDxM+l/7yfRRzB2bVhUfoYC9eNakFE
	 xS/lFubyzMyFg==
Date: Tue, 5 May 2026 18:26:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, Alvin
 =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 4/8] net: dsa: realtek: rtl8365mb: add table
 lookup interface
Message-ID: <20260505182638.6b543f5b@kernel.org>
In-Reply-To: <20260503-realtek_forward-v2-4-d064e220b391@gmail.com>
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
	<20260503-realtek_forward-v2-4-d064e220b391@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6D8324D5401
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284645-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, 03 May 2026 03:18:24 -0300 Luiz Angelo Daros de Luca wrote:
> +int rtl8365mb_table_query(struct realtek_priv *priv,
> +			  enum rtl8365mb_table table,
> +			  enum rtl8365mb_table_op op, u16 *addr,
> +			  enum rtl8365mb_table_l2_method method,
> +			  u16 port, u16 *data, size_t size)
> +{
> +	bool addr_as_input = true;
> +	bool write_data = false;
> +	int ret = 0;
> +	u32 cmd;
> +	u32 val;
> +	u32 hit;
> +
> +	if (!addr) {
> +		dev_err(priv->dev, "%s: addr is NULL\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (!data) {
> +		dev_err(priv->dev, "%s: data is NULL\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (size > RTL8365MB_TABLE_ENTRY_MAX_SIZE) {
> +		dev_err(priv->dev, "%s: size too big: %zu\n", __func__, size);
> +		return -E2BIG;
> +	}
> +
> +	if (size == 0) {
> +		dev_err(priv->dev, "%s: size is 0\n", __func__);
> +		return -EINVAL;
> +	}

Defensive checks are discouraged in the kernel. AI will make short work
of finding such trivial violations.

