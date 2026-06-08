Return-Path: <netdev+bounces-296717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r1PVOfApJ2o1swIAu9opvQ
	(envelope-from <netdev+bounces-296717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:45:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E46965A814
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:45:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SyActZqu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296717-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296717-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2988B3013BBF
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 20:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E12838E8C2;
	Mon,  8 Jun 2026 20:45:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED42F0C62;
	Mon,  8 Jun 2026 20:45:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951535; cv=none; b=QyCHlEVdY8RJf5SU/CQFNhFu7boKpXGzQzzoq8M4UvDZwS5YR/KXV2wwWUXGlp8Sk8AWHCNPX6rQ/n9ZCabejA0GHcVKy/bYB4xoSu7F+9GnOlLBK/rogADX5t/3Pv25Th5kOSiuGDJkPEsQJlv0dS7hL9Bx1rvF1W7OajhuczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951535; c=relaxed/simple;
	bh=0yKgsyRZNBCvlQrLy2LkSBz6n8qsmfBW/vYA10y0Ot4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKLxXTSHSpAAfKN2Pvamhw9q6Jlu15MmZghgXz9I83roiZj7PXkU/F91ngUxQ2nLxLAyRwD/B8GOVnWZ5N14mrQU/fqW7i47srbH1Lgz21th2Vxi5HnRZckWEQKAPrllwJyRZIez28OdWc/zVJIeAh21mCYI0NWoF27sgP4IIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyActZqu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA17B1F00893;
	Mon,  8 Jun 2026 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780951534;
	bh=OG9PZ7u0QUcc4fqLN8++8Hw9vcqT7GJrGbPHfdSBAA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SyActZquLhUiXv9WHZFcGy4Eev1WRClaPpq4IyU7kWOULAg38+nws0jK6gsEo0Y9U
	 bW70lcikUNDlxVRf8ch5wWoJAMkj7yyihsGdGioFcR92k1bBg54QWpgqMhql6SV0cE
	 rsvuW4alsKkMkKkqW8telli2khGw9bZ+9ygyUcz6fLqPtHcTFNqbmbaYZvrZc/YJ/a
	 AYeLzg9Oj8T4G/UpNmfTnballY4L18Aq4Ddic8QM+VbTg3UqCDhSFAsuDP8FDgKKsL
	 DhD47H3M0lu3IWWrl9QuP7eMUa8FRfZbC7Z2I2qN5OUyJOTcahe+r/bcXaz6GCF8iN
	 u+qr767wIpNDw==
Date: Mon, 8 Jun 2026 13:45:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/12] dpaa2-switch: add support for LAG
 offload
Message-ID: <20260608134533.1c913041@kernel.org>
In-Reply-To: <7qgoy4ksmvswiaikzjzgiribtglsftmu3nfzhyem2uom5va63s@w4ruzw4fzzba>
References: <20260603143623.3712024-3-ioana.ciornei@nxp.com>
	<20260606021047.4124576-1-kuba@kernel.org>
	<7qgoy4ksmvswiaikzjzgiribtglsftmu3nfzhyem2uom5va63s@w4ruzw4fzzba>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296717-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ioana.ciornei@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E46965A814

On Mon, 8 Jun 2026 12:14:07 +0300 Ioana Ciornei wrote:
> Please let me know how I should proceed.

TBH I saw ~30 bugs and assumed that at least one of them must be real.
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260603143623.3712024-2-ioana.ciornei@nxp.com
and
https://sashiko.dev/#/patchset/20260603143623.3712024-2-ioana.ciornei@nxp.com

LMK if all are actually false positives. If not just ignore the silly
ones. 

