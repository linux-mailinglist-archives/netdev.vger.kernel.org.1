Return-Path: <netdev+bounces-295580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VEa6EkQuImo6TgEAu9opvQ
	(envelope-from <netdev+bounces-295580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:02:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF0644934
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:02:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AtUSOQS9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295580-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295580-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F90C3014016
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A67C3B0AE3;
	Fri,  5 Jun 2026 02:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6136493F
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 02:01:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780624909; cv=none; b=MNE5naiTZ89Jjwo7nhjdVROGJ6DYrJSGb6WmIhC7TIMCfM5P2fnziaRqjJjVGU+g7m61XWsSsqz4USjKDiAQyswwtP1FTwNcE8aZ3Tw8tZBkvLCkdr1YLZCC49gXNpqp2jHZyToPhFAfcWfa2dfrbRQOy0hXNgYYTTszLy2Hm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780624909; c=relaxed/simple;
	bh=LLmQk/fAGaFis3s5YQoxAFKusr+v4hOtjqfghPcTyI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbBvwv/EVLnPVOCRRavceygH1IEjnMl2dRCPto6UpQ22sBl4YwlFX4L9l6LkLsGdODrVZMBHUbrk/jr4Aj/UBBd0DpwXYYv8s9hH4UqeIWQr77zjVXsmwy2vZdeigs4ZXzdipV9tGQZ41MxI5043CmK+nuJ/thHWFLheWXSzpeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtUSOQS9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C281F00893;
	Fri,  5 Jun 2026 02:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780624903;
	bh=pKHwinsi5Lypn1fkSdH2aiWKw9t4V2Hlvbu40fHCDok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AtUSOQS9klYTHlFeR/Ql9Oj5tk1ey6o50pHsP3yWqORfv+U9bLY8skGcVMAcRTCxp
	 cKJdP/s9cV+yTNiS4mIvtCImWyT+zuW47wmqaRCFbyXMWgU+TIeus6X8d67HLkl+Cu
	 DRjZ8VwRCgOHKLML2wkpxRdl7r/1nuvmVkvjU/g5QoKpKIzGgWdVhIYEOjTMkGyj/H
	 LKDCSdmJ++kOQ4ItjmFEZsrOnA/dClawxMdeaecd9U/5qss+9dh2X1SOwWDzD5fNt0
	 1TRWP9uyXg6lwqDGaTCd2WwTWqI1xMwymZwTaWtJ0kWdPqzgxXPCx4xCcGVhYTMppy
	 JxfK3KLzZgItw==
Date: Thu, 4 Jun 2026 19:01:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/3] net: add retry mechanism to
 ndo_set_rx_mode_async
Message-ID: <20260604190142.0ef0d119@kernel.org>
In-Reply-To: <20260603223535.2504695-3-sdf@fomichev.me>
References: <20260603223535.2504695-1-sdf@fomichev.me>
	<20260603223535.2504695-3-sdf@fomichev.me>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295580-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98DF0644934

On Wed,  3 Jun 2026 15:35:34 -0700 Stanislav Fomichev wrote:
> +	netdev_ops_assert_locked(dev);

One thing, I guess, since I applied the rename I think this should
become netdev_assert_locked_ops_compat(). Not that it matters in
practice.

