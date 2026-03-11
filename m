Return-Path: <netdev+bounces-266413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B6GHRnNsGkKnQIAu9opvQ
	(envelope-from <netdev+bounces-266413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:02:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 190EE25A926
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0BDB305E999
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0C628B4E2;
	Wed, 11 Mar 2026 02:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D18de6zN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD528466C;
	Wed, 11 Mar 2026 02:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194497; cv=none; b=RbY7Tse/g5nKb2A0HQjR2QBOb5Mj9AA7i/l2T8HN47glFQKR5MlbQ6MbtzWhhh2uEsyNzCjbLwnGI4G/2aqPDqZdQTwGKdgGOi8z4MJmmT2N5lhPcPVnansSo+WEOoogftS/NICN49AX8yroK07izkTjtOeLOwmRHUdhox9hmrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194497; c=relaxed/simple;
	bh=jjSf6t0rz0WN9K4TZKbj7NWiKQ4Tck4SVuqN+DqDt3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rN/tLkysEt+96aKxE/edIPD3fu3sGqTxBENIEfzbNm/UMO0QeoyNdq/auMxkity6AZCNqF8y3d2BnRb2qAAeqvmAjwl7UjQq+Q6OxbmeE8c+O4xe3FDgsnNdx9RWMgG3nVSe5P6qTWxAnURRxUNWJrqp2MrwRfQcoYbOa8YaHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D18de6zN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F065EC19423;
	Wed, 11 Mar 2026 02:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773194496;
	bh=jjSf6t0rz0WN9K4TZKbj7NWiKQ4Tck4SVuqN+DqDt3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D18de6zNMT5FsImD9VgfA8IgzsrO4FGcav/px+r4OAr5LHzKOqoyUOkYzn7lrSxvy
	 pZTPULvni91FgWm0TUP7D1iAtomIfTZJ0uHRGL3ABlwj5hWLNXlX6qokviCAS5WwsQ
	 lRHE2vyGXOei+tguyXBBu5VoSOVsz2pwPR3bQGSquVp/JE2pQFSv15PHYqyA4xjfr5
	 tCeEhqKgSw8F4ncJfx5HATLPrMCJQRRALMkZXMlHjgCkwmavD17vFpI5+yrRSJKbvO
	 EznkeaBVTVQCTxPmMxhdekiM1g/xz6WgM8wuzjTwnH7T/qazfxI/XESL3PmiIMt1me
	 Mi8ZeS0YTSOuw==
Date: Tue, 10 Mar 2026 19:01:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: ShravyaPanchagiri <shravy112@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH] docs:octeontx2: fix typo in documentation Fix spelling
 mistake "Crate" to "Create"
Message-ID: <20260310190135.422b6074@kernel.org>
In-Reply-To: <20260308191142.172363-1-shravy112@gmail.com>
References: <20260308191142.172363-1-shravy112@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 190EE25A926
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266413-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun,  8 Mar 2026 14:11:42 -0500 ShravyaPanchagiri wrote:
> Subject: [PATCH] docs:octeontx2: fix typo in documentation Fix spelling mistake "Crate" to "Create"

space after docs:
I think you wanted the repetition of the sentence to be in the commit
msg body? Please fix and repost
-- 
pw-bot: cr

