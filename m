Return-Path: <netdev+bounces-285426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBJ6IMm6/GkqTAAAu9opvQ
	(envelope-from <netdev+bounces-285426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:16:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B1A4EC0A8
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66557312D2E6
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A06744B68D;
	Thu,  7 May 2026 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCuMcWr9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8582288CB;
	Thu,  7 May 2026 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170214; cv=none; b=UuFyGxyJnu2Zo4cqWOWJbggltxc7XemJHBqnn+8RclW3w0jzZYbJXVZblVFwPBC2GWx/T9l4vbTjPKpQxQQJYpk7hXV+3Q4vCEP5lZVlIjhiRUWCk979iATCAPZk1vi4ZJDaUTaz4IGMRYl7p7SQmzcrP/UNxFOL1KNvMctFUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170214; c=relaxed/simple;
	bh=fxwf3I7h7jhgXQ9lw8NOcAt3++3EMEiDRO+U9K4nGPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdtEGukPvb9iOZQ7lgmSebRADSUHD6FEnC5m/mTOfBfSK9Bqn73VVC9pHWIXrpV11UV7kQtax9v3KJSvQKq0NL7lxnv4GtawaKj4Y0CSqkVVwNoD6FOIZBq9b7chwlQ8h++UZY6WTqsNi3oNrFpspTCGcYEvAPhi/nOzg9voFhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCuMcWr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DA5C2BCB2;
	Thu,  7 May 2026 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778170214;
	bh=fxwf3I7h7jhgXQ9lw8NOcAt3++3EMEiDRO+U9K4nGPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uCuMcWr9E0ZYLfq7TWoM2JB4UuCJ5bmGDp0CgS8YV6u1Fu0kGSIeqXuQ+gVHco7Yh
	 zCswGy+R6KX6gxhvA1t8Q7c59bspjQE2GEETMR7FN9xMOXyqgfD3OTEhn7WRAikeFz
	 EC7RaHAG3XRcRMCf5VuwHJUTYism9BYK94Jdwit95i01F0BVQWJuLqjVQYFr1n5sZl
	 B5TkDpQz9BHM0Rpo0gR0IfFVcdnBI4NiLJkMnsg56gBUZmpKy6vAARBhOvfFNlgMhu
	 dEw12El0DxT3k8NKYtbojeCWFp/dpFPqO8zc7d/ijxCMyDylN6kGvHu9xwpqrRTQFE
	 EFbSf7FyaNXpg==
Date: Thu, 7 May 2026 09:10:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
 <UNGLinuxDriver@microchip.com>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
 <bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, <kees@kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-rt-devel@lists.linux.dev>,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v2 0/4] net: sparx5: misc fixes for sparx5 and
 lan969x
Message-ID: <20260507091012.7eeb17f5@kernel.org>
In-Reply-To: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
References: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 23B1A4EC0A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285426-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 6 May 2026 09:25:35 +0200 Daniel Machon wrote:
>       net: sparx5: fix wrong chip ids for TSN SKUs
>       net: sparx5: configure serdes for 1000BASE-X in sparx5_port_init()

Let me grab these two already. patch 1 I think needs more work,
patch 2 is probably fine but maybe we should address the sashiko
issue in the same series

