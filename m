Return-Path: <netdev+bounces-259956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLCMKdAenGkZ/wMAu9opvQ
	(envelope-from <netdev+bounces-259956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:33:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14838173F07
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B9E43006B08
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC80E34EF15;
	Mon, 23 Feb 2026 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HMdIFtum"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC20234D39B
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839052; cv=none; b=DzYkN29ccigwBw3mqzUGG7Lem1Z1P8dbjwGbwXnJZXbzPCo2yq6RZE8wmq/vaxnTmX78Uo//s+i3o8KxF8yfKlGtTxgnqwze+S2C0rvb5HVM19CzMZBVj0Z07Nq/f/44w3xN1S/8gdIM4TdjAclqEvB0yIb2xoeL4co4E7mNx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839052; c=relaxed/simple;
	bh=B18fyNiWjPhL1krCA78zLN0qDKJ48UCuNSyAOiiK7tU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAnioPvsr/NaDdhjL/aWsWOpwIUTveuSK6vM19mzzeBFm9O4HO4wD8hmjqy3PqCHVVpW43BHjNsLHgg/uZtzX4rusOT1ycvO7R5riRKgpDK4kqp/IszGaFUjC7dLRf4e3fY0BzcVaXMTeoPV10ZtRuMzUmMMkPRBaOmXS806Bic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HMdIFtum; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5ADC34E41028;
	Mon, 23 Feb 2026 09:30:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F3D55FD43;
	Mon, 23 Feb 2026 09:30:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE55410368F3B;
	Mon, 23 Feb 2026 10:30:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771839048; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1xpehb9uuBUbAFpjtW2R24XgwW6FQOe69kXhgLRyK0M=;
	b=HMdIFtumQv1IbULVcg621JzXZYbxX8ryg/ilGwtUDg6AXTEMc9ubszhYd/xYWr4a7yC8EF
	UNkqRJj1DknErvl2FhSL6BSky9QS62ArOSDXc9ME1vl6QbwGoq3TyoXf7miFRLjgeBHUBT
	cyXxyi+ea4ZMGDXPstQL9yq214i9OqSxVusISdZGbkfVIn3KTvYv39XrcHNvJwhclXaUlY
	t7r6uyJUalp8J7qjXjgjU6K79ytXANx60BGqEXJDmtZrO5SX3P9mOuL9eGODn3A+A0brCQ
	HH/sYJ68yHkgf8BXJhiRnsGLnL27fCA1tSR3mlJZtARrrHwP0jSZN9WPymBz4g==
Date: Mon, 23 Feb 2026 10:30:45 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net] MAINTAINERS: include all of framer under pef2256
Message-ID: <20260223103045.1799df87@bootlin.com>
In-Reply-To: <20260221011858.3403605-1-kuba@kernel.org>
References: <20260221011858.3403605-1-kuba@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herve.codina@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14838173F07
X-Rspamd-Action: no action

Hi Jakub,

On Fri, 20 Feb 2026 17:18:58 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> The "framer" infrastructure only has one driver - pef2256
> and is not covered by any MAINTAINERS entry of its own.
> This leads to author not being CCed on patches.
> Let's include all of framer/ under the pef2256 entry.
> We can split it in the very unlikely event of another
> driver appearing.
> 
> Link: https://lore.kernel.org/aZefB5f3EAkQQM1m@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

