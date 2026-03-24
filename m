Return-Path: <netdev+bounces-270821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBJDAmnYwWkaXQQAu9opvQ
	(envelope-from <netdev+bounces-270821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:18:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECED2FF8BA
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DB413038328
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CA01FC7C5;
	Tue, 24 Mar 2026 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkt45Pdy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D20D78F26;
	Tue, 24 Mar 2026 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311486; cv=none; b=cOC5Is5dZfQMlzMTxrf/ygdzKm9aMLu1ZxtzgG+/wfJXu4aaoEaQm5+d+IEUqh8BiOVoSFGqXMj0/PdBiNbOQWKVj7Qa3tRZNgb4dl34YaR55pJ1GWEfAVMjYIrLymqrr8MFivCleKU9aU+2AIpFmX+EAFOxxrVzoEJtcRCCmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311486; c=relaxed/simple;
	bh=mBitpoQXvogW9UOH5+8mD5clOqD//aOwti5hId6Y2No=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=tHqQGjZOkwz26X3iz4vkkDddXTxMvzheiYYa+z3sVGvnzYqeQGMMx5hkb7EXBKt1m6kaKdkk9owGuQYHToniWStzzJCOSEU7x/buZrogOd72dxw2hBxTIEeiaWmutwIGDhC1KZqdWSaptsmvVrwO6Ej/sI8VEOOzc2p48S0DMtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkt45Pdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44D0C4CEF7;
	Tue, 24 Mar 2026 00:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311486;
	bh=mBitpoQXvogW9UOH5+8mD5clOqD//aOwti5hId6Y2No=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=qkt45Pdy1OfDzs88N1FqRGBmJDh4R/jkPlEO4A2Jz1h3Z3uFvlDmRLbCPL2cmCGJ7
	 g1Q3RWM533SkSfddCicFK8rkKS7LqXeSRrlxv+4GlU7mVKJaANUp9Nqwv9cJmlH2xE
	 B7X6TUFcQhIVA9T913DBq/AtGo18HdYmvfTJjViuh0gIU2VyI0FYxD5sVOEE4mZmjy
	 BwpL4FxooZvvuiPKcJgVKKVFF4tHmF1N5au/E9qHk4zucdn/zTpcqG8/UlbTzjDe3w
	 tBfwRlrvH18alNPakK46dsg7LXiFpn5n2JJiB04KwGJX0GYQD56C7oU1wfDpSIt+So
	 qnsmfR4w/bpQg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260224111821.3491352-1-andriy.shevchenko@linux.intel.com>
References: <20260224111821.3491352-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 1/1] clk: baikal-t1: Remove not-going-to-be-supported code for Baikal SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Brian Masney <bmasney@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 23 Mar 2026 17:18:03 -0700
Message-ID: <177431148399.5403.17869158368644573054@lazor>
User-Agent: alot/0.12
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270821-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sboyd@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,pengutronix.de,infradead.org,linux.intel.com,redhat.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 9ECED2FF8BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Quoting Andy Shevchenko (2026-02-24 03:17:18)
> As noticed in the discussion [1] the Baikal SoC and platforms
> are not going to be finalized, hence remove stale code.
>=20
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@i=
nfradead.org/ [1]
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

