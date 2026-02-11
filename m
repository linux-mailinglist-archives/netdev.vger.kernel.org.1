Return-Path: <netdev+bounces-258268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEe5LCZwjGluoAAAu9opvQ
	(envelope-from <netdev+bounces-258268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:03:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8ED12410D
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33F323011BEE
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F5C319852;
	Wed, 11 Feb 2026 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poBFCdyA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C4917B505;
	Wed, 11 Feb 2026 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811427; cv=none; b=ghaFBNTtkmW4s162BymgL8UFrvvyId0rmtezwMXYwLSDKSKtemECzMuPKdoHM6Iammasq9PxhPmomZIW4mmZlx/f1WgnaXwKxzHx4nHMpOre1s01CIaTq6Le7MUWMTEol+RshaKj3hSNGwfRAUNGGigSSKB0UR28OcW2mX1783E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811427; c=relaxed/simple;
	bh=TsPe4y8+7MiWbuGiIUsDmqXfQqHvkX0CMkrLCBdVL4c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kv5Vuj7IMfSxKLDrJ/HxAtSVI6CbcVIf49v+5QtlXbJQB3dKkgD3E6SwilbwkLLR0aqMRKlWwxGzAgClUMawq/wAEbV5rmonQx9052XeLIo7VyBhVyfEDNj/w4hT1SKuLRmASGxtUiJKvkPl0Muo8pBGzPcCdWqE0yb25YmSGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poBFCdyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10786C19421;
	Wed, 11 Feb 2026 12:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770811426;
	bh=TsPe4y8+7MiWbuGiIUsDmqXfQqHvkX0CMkrLCBdVL4c=;
	h=From:Subject:Date:To:Cc:From;
	b=poBFCdyA3wQlLYBPH1jsRsTr6lA5o2/+en4tRbKV/YA4L7MUR+Db/bSSfiZhB3ADW
	 u5/Qc0U/a8Av1T3qovrcfc/FYdihvR0xmZnkiTf/TeVomy7xH/MGKipE2ogl8zW5Tq
	 pqzKacgWwMQLWf9vXempOuB07fjj/gRqM9PCfzNYJGBkhddPhXzC7qsrlNxvoheyNj
	 6ey2mYFKu+U37tFmwRUJk681B3bwicJTqrGMABDzWRjl/0lQmFqloM12Axz/pvaDsV
	 dfITzvYWDdDqd8aPa0mc7mVs3NNcca8q9OUbfpTEW4spsNYTCliHzdzVu+NmlNi+o9
	 Tn1NwRoQk2Ohw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH iproute2 0/2] mptcp: support colors & display iface name
Date: Wed, 11 Feb 2026 13:03:16 +0100
Message-Id: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAVwjGkC/x3MQQqAIBBA0avErBNUoqCrRAvTsQZKZawIpLsnL
 d/i/wIZmTDD2BRgvClTDBWqbcBuJqwoyFWDlrqXWilxpNMmYeMeWbjOu34Z0KjFQC0So6fnv01
 AieN1oob5fT9cox2QZwAAAA==
X-Change-ID: 20260211-mptcp-color-d4fd6b7ea1ba
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=724; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TsPe4y8+7MiWbuGiIUsDmqXfQqHvkX0CMkrLCBdVL4c=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ7ChTY2323/5/9Nfjj4UdvCvmroj0WKC56+UfM59e5u
 P1vXi/83FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjAROy1Ghu1GfxdM+ep9iP30
 z6UXJJOP9Tq1OGWV/jitKjUnN3PPlbmMDE+i2b8Yc/iVByS4fYpKOfne/lCiSe6/5scixrMDPi1
 3ZwcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258268-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D8ED12410D
X-Rspamd-Action: no action

Here are two small patches to support colors in "ip mptcp endpoint show"
and "ip mptcp monitor" commands.

Now the IP addresses and interface names are printed in the
corresponding colors. "ip mptcp monitor" will also print the interface
name if any.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: monitor: also show iface name
      mptcp: display addr & ifname in color

 ip/ipmptcp.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)
---
base-commit: 72f679c0d07629fe9e462c2c52bbe48aaeaa7f83
change-id: 20260211-mptcp-color-d4fd6b7ea1ba

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


