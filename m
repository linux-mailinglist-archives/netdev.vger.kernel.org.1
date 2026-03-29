Return-Path: <netdev+bounces-272987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAOBF+KByWmBygUAu9opvQ
	(envelope-from <netdev+bounces-272987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:47:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E36353D35
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 452B830039AB
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31D924BBEB;
	Sun, 29 Mar 2026 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8IpYZQJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907331C8634
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774813664; cv=none; b=EBwKbupIO+akVz/NUZ2hUH9sWjX0JYHL0YNWToIxAVo7AjIRlLKZS62GkSQAZMRfCqXZZzgrYGuk6+drjkihlGAdSvYLKfpaRnLC6WIbK3pUaFUbhX7G6rpA6Gk6rwGHKZV+XzGZ+BAUpTMPyjayraO4vHlUASToI/L1NVt7WA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774813664; c=relaxed/simple;
	bh=ndlA4niNQM+1xuXcb2OMtxp9xaf3AM5hSCYo9sPDDIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1yqRRdVwirFAfoxe8+rnylEZuKk7r1f5BEbuWOwNSi8/nHY6rV5cJ7yG4WUKQfOdrSrXvp0hKDtV65yQxcSyp+9V5AB9CKOFSpB5YSXWfNKK25Y4PkfaRupRee9FGQ6dj6hYq+fxYt1l8NouWww0BEmxL7cKxv3ZtvbhHLIgrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8IpYZQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DE8C116C6;
	Sun, 29 Mar 2026 19:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774813664;
	bh=ndlA4niNQM+1xuXcb2OMtxp9xaf3AM5hSCYo9sPDDIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o8IpYZQJ6JLlJ01J1ZluWQivhVe5/H/WLJN3ca0oJXD7LmkF7CnH1bkUZuC7DHuKK
	 QFhXikX8TiKgCJ26hXNsOi5TwkbQlOZ/Xh/dDDCqDDjFi197+4V2s8J/BiKAwJggTV
	 eMG8wpyuokLqhWtT7cz0U31Nym5pCF7dvOs/zgzLBZVBCJjIdxDMBiKDtkzVK2ErlM
	 ErNbUfW0QJSCYecko/DrGfWrzMlLjZW+4/15Ch2mlYlb4Pok6W/AR/foYlIMWinMU6
	 seSOfJbO5qYgbut3vDi8i3xtI+aTj79NQjMtucsRN5HL7JJxIcSjd8yruBpvLdgXE8
	 OS8Y++uAmpjmA==
From: Jakub Kicinski <kuba@kernel.org>
To: pvalerio@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	lorenzo@kernel.org,
	theo.lebrun@bootlin.com,
	nb@tipi-net.de
Subject: Re: [PATCH net-next v6 2/7] net: macb: rename rx_skbuff into rx_buff
Date: Sun, 29 Mar 2026 12:47:42 -0700
Message-ID: <20260329194742.2781331-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323221047.2749577-3-pvalerio@redhat.com>
References: <20260323221047.2749577-3-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272987-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02E36353D35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
No issues found.

