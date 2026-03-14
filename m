Return-Path: <netdev+bounces-267755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAm/IdqCtWkr1QAAu9opvQ
	(envelope-from <netdev+bounces-267755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:46:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1088328DBD1
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF9AC3019B84
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7464B239E76;
	Sat, 14 Mar 2026 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmWoQ+Vs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3943ABC;
	Sat, 14 Mar 2026 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773503191; cv=none; b=KI73e29mpP7Mf/zOvfw8WdCUoP9Vn3PoO1mdWzD1VeQ+rC5Rb04Hiwxs8XI5DFHndEt6hWibl0NAr1gdsGSUa/8830vffkCCHIu4faAeJOvKGR3mTavwpmJA1ewj44vTwmi14DtP5FqyjxXgdKai4npiYJKSK/1ZOjksHFRSOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773503191; c=relaxed/simple;
	bh=8l/s0G9J9WtFbDksNaMS61k+B7tVhTYZ6jTOHA06bdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9BlmkQ64lLTM1I45yj3JfF42xNlq66x6VIwSExItNiRaErdQJvvMiQRKOlG8jOPpr44cnS/T/G5mzWX5K+wPJEMZZuorNfOeJ5L0rz86VsKwxj3XDmeh+yI8q3oVzRp/6ZVC1XQuZoChPWDqus5IAL/YfjwSr1053PI88CtxJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmWoQ+Vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB56C116C6;
	Sat, 14 Mar 2026 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773503190;
	bh=8l/s0G9J9WtFbDksNaMS61k+B7tVhTYZ6jTOHA06bdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WmWoQ+VseRbZfkHPli1j5Au/tqhBfc2flTpB9gOY9JuQmvMFVVI4NLkfMQgNeGqs3
	 tJr8ldfDkIxVYI4llBeNOr+xEmVqkylUlI/BFBcSFmovqUV18pYCHSbiyR/PkOnKWN
	 enTs7EB6sB1wdlSJJH0uSaQt6Bk+sjmGNpINrIOqfKZQd7hGL/sY0Zsyhf+UKIE0w8
	 ROZu3+dMH5p24CqXYSE4kBqVg7s+fkn+TWfW9g4XylCzCg3okOq9uRgNR3LdIoLD5T
	 o3mQ+meSd22Z/BMi9PkmaFADQSFcnliZdeW8c4Msxy2XiTnOVhQb92u6OYHwcSEWdy
	 tovLU5/TXtkEw==
Date: Sat, 14 Mar 2026 08:46:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] octeontx2-af: CGX: use kzalloc_flex for name
Message-ID: <20260314084629.05b10268@kernel.org>
In-Reply-To: <20260313003240.123975-1-rosenp@gmail.com>
References: <20260313003240.123975-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267755-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1088328DBD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 17:32:40 -0700 Rosen Penev wrote:
> Don't bother allocating separately. There's no good reason to do so for
> a small string like this.
> 
> Remove name kfrees as a result.

This is not worth bothering with.
-- 
pw-bot: reject

