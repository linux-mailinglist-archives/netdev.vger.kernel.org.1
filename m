Return-Path: <netdev+bounces-265031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFbDGcSYq2mzegEAu9opvQ
	(envelope-from <netdev+bounces-265031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:17:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 707FC229CDC
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DB7B3002D2B
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC0C292B44;
	Sat,  7 Mar 2026 03:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNfva24N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E986331;
	Sat,  7 Mar 2026 03:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853425; cv=none; b=gTcG3wcQpcZO0K0l3UsOUTjTRz9Fm60wnlP47ziiCAxBQKFJOuth34s6TAktktjBFhJtAPE5ajXE63NjsehxBrR5Ux9f1LWTSYS5rx47FB5gAmsQ3fbFLmEvpAxzYRDEFj+Oz7ZA0XjRrC9Pzj/O6amUKtkFxkhP4fro2uAIkMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853425; c=relaxed/simple;
	bh=V0kw35rQpJ4oypB76t7tXjIf/03M4MzSXMI2cFpf1kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aS0PRa4j3KpYwcnojv6K3dd9+KK2ZYLXSnI0TYbfQkV5BBqALBJczKEeDp4M9Zx9X76xC1ZUyxsmZpHuGPvp/MBU0WAIsmyHJiaeJvbr1g1DsV+q4YJNKaQtLBYN8oHo74uk2iRAarxQSOohDkuEOdsoT59kCi9Fq02mSivVwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNfva24N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6180AC19422;
	Sat,  7 Mar 2026 03:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772853425;
	bh=V0kw35rQpJ4oypB76t7tXjIf/03M4MzSXMI2cFpf1kc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uNfva24NHzWKGR4VboNMUOYDq/HhwJHot2Mijc6vfQ+b3odz0ocelbSp8emCQVxft
	 BndFmN2hw/Ge0CeoYsdpClQn+KPIpgpXWRwwCAwWSaPZbLm3UH1TkXObBnzPYH0Xbk
	 0duDoR409MzuooJCCAixpU1lOoDUxrWH0hDO0wU1SWEyUqnm18xdtaKFjG7t9ThXfC
	 TGv6uj0SRSJR6ripUChe6kAo6e/trsXLPvVigvVeLPVpfp8HtwprnbVxTHQATXjMO/
	 s/MHyrsvDPcINu/7Kr1X3ORKROeU900K3elKAmHbGJp3ed4b+vZI3Kx+oyzJXlzHrD
	 EbRmRNtYmwieQ==
Date: Fri, 6 Mar 2026 19:17:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: david.laight.linux@gmail.com
Cc: Johannes Zink <j.zink@pengutronix.de>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Bartosz
 Golaszewski <brgl@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Gatien
 Chevallier <gatien.chevallier@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH net-next 1/1] net: stmac: actually error requests to
 change the auxiliary snapshot capture channel
Message-ID: <20260306191703.1b67087a@kernel.org>
In-Reply-To: <20260305104133.3101-1-david.laight.linux@gmail.com>
References: <20260305104133.3101-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 707FC229CDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265031-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[pengutronix.de,foss.st.com,bootlin.com,lunn.ch,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,gmail.com,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu,  5 Mar 2026 10:41:33 +0000 david.laight.linux@gmail.com wrote:
> Subject: [PATCH net-next 1/1] net: stmac: actually error requests to change the auxiliary snapshot capture channel

please fix the typo in the subject (stmmac) and CC PTP maintainers and
reviewers

