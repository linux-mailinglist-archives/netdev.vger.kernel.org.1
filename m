Return-Path: <netdev+bounces-257405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I9ZHoNShWmV/wMAu9opvQ
	(envelope-from <netdev+bounces-257405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:31:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D158FF9556
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D503007E33
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4FA1EBA14;
	Fri,  6 Feb 2026 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAGUFPhQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B525156CA
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345088; cv=none; b=LiM7dqzDNFDFvQQXw1n8yTsYo5UckFfdkR0iYTp7ZbM7MxDpXibCne3yondJz8r9KOQKikSNB3WdZf9ssaxVeVn3QwYwlFW16PaM0Oz4H3Z0mJxngXJCE0Y8+beUFwIwNJtzfD5396w0tFrZ1cc1UAKy4r+NUy5awCjeDBrm9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345088; c=relaxed/simple;
	bh=LfDC8c1TOuPis2+WjXN+wy3rzOlJG1jqTEo2izbXR6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m86uoLmkwx/h+kYq+zVla/Y2x0M3UP3okiLYKt02ef9+OiAS07rR5QLot/wC3JY5nnMwO7Rbgz0jNZokuXS0P1f+zI/fcgBy9GppJgIuW0pfdIsZQf0PMHwDZFsIgRLI4YaoTEUmEZRQgEaIFqxlRivqWfCbGRzJR188F5BgygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAGUFPhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F418BC4CEF7;
	Fri,  6 Feb 2026 02:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770345088;
	bh=LfDC8c1TOuPis2+WjXN+wy3rzOlJG1jqTEo2izbXR6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sAGUFPhQUBbW6HQ0GFH0dauX0rZlsg1hpDDTRxHSdb+K7CMpp9B7dUpc6fk+DRoRL
	 93fuL93NT7R1883nWrohQY3jT0XLv5Jit+BWpk2RY+JYyRR3Rr1hNjC79iacn8pqkq
	 Wf8h1Gme1EMDMdjfT9tov0FKrvPrgOPKYJLFNtzoPyqcSXq6jFg9IdRJsj/KR4tQbM
	 Ww01q5OvZlY01B48kx+mgXZBLDzgEw2RfW3UyA7GvimXZKVNfCACE6ouThrK+pMbBS
	 5YEbAZg5ay2y3Sc30W8z/XGvMSqhlLA1mrs/JNMNRItrXOId3ZyXvzoN3PetdQqdy/
	 W05BN1QWu541A==
Date: Thu, 5 Feb 2026 18:31:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc =?UTF-8?B?U3XDscOp?= <marcdevel@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 netdev@vger.kernel.org, dborkman@kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v3 0/4] discard ARP/NDP b/mcast/null announce
 (poison)
Message-ID: <20260205183127.3a76aca3@kernel.org>
In-Reply-To: <cover.1770241104.git.marcdevel@gmail.com>
References: <cover.1770241104.git.marcdevel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257405-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D158FF9556
X-Rspamd-Action: no action

On Wed,  4 Feb 2026 23:11:57 +0100 Marc Su=C3=B1=C3=A9 wrote:
> The current ARP and NDP implementations accept announcements with
> multicast (broadcast incl.) and null MAC addresses as Sender HW Address
> (SHA) in ARP or src/target lladdr in NDP, and updates the cache
> for that neighbour.

Doesn't apply for me:

$ git checkout net-next/main=20
$ git pw series apply 1050919

Failed to apply patch:
Applying: arp: discard invalid sha addr (b/mcast ARP poison)
Applying: selftests/net: add no ARP b/mcast,null poison test
Applying: neigh: discard invalid lladdr (b/mcast poison)
Applying: selftests/net: add no NDP b/mcast,null poison test
error: sha1 information is lacking or useless (tools/testing/selftests/net/=
Makefile).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort=
".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0004 selftests/net: add no NDP b/mcast,null poison test
--=20
pw-bot: cr

