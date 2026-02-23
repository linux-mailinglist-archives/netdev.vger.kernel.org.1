Return-Path: <netdev+bounces-260249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A5bJ4bbnGkrLwQAu9opvQ
	(envelope-from <netdev+bounces-260249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:58:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 331CF17EA38
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A1EE304246B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6593783BB;
	Mon, 23 Feb 2026 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcRnVQMG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D955695;
	Mon, 23 Feb 2026 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887491; cv=none; b=HryZjCvotTXlLjg1T9V0ED3Cg+98kJnEbKCEgYOjjQnwkT0Aw/fAXSDBGZMazUenZM8c31nvPniRrKo+WPHEI6x3crhLIn51cJVfJ6gllaYo0RWmv+UtMt0avhWlsp+YQ1CriRe4xacpGMReOA009BIVjSM1ay3w+cSDLakdLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887491; c=relaxed/simple;
	bh=tUqvefmi8CDcdF8Vy4DDRRBlk0IzlDcg6OEUzW1Xh9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvwjKN5Y+BAGcYpxkTLcEiihk9ynzqx5KY9JXXsRotMVGNTP6q+6EPVyWTKfdTzX/2bVL7BE0Pvo40f5ZNxyWwSVwxSIAy6MwGRRK3JOrsnf9W1YABi/37c6s8TEQ6HRc6WIx5Z2dui3OU+6ouRt5DNLJaWT4eJpQt/GZ7m7fPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcRnVQMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604E6C116C6;
	Mon, 23 Feb 2026 22:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887490;
	bh=tUqvefmi8CDcdF8Vy4DDRRBlk0IzlDcg6OEUzW1Xh9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rcRnVQMGwtHaC0ENicTpRocT2ZVi4jC24aST2/zQmMKa/55d7Aeq5LL1HlQbHD6qq
	 0Vofi0DVLg8kOGRXGai6M6fZ6+ZSle8A0CufSAxVQQmuLzT8RJ+muz3fEwwnlCw3lc
	 Y4VSlIkH8BOqfX+Ty4EHULKh81xNwR7D/lmtFrHC03FalGpMUB2G9f775EeCAX9HeM
	 2HSuGQA00e3pLJbwCX6sAJtK0o+bSBwuZ0QkJ1IcQt3F4pFPsXjGRYAAzMcAvSJrlP
	 AZJdFm86iyHONWxjpRSzvj1hTqwYcMyGpcnc2npB3R31xdzIJtZiReI1db5TEgiCDi
	 nQQkJBhy/vEFQ==
Date: Mon, 23 Feb 2026 14:58:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] docs: net: document neigh gc_interval and
 gc_stale_time sysctls
Message-ID: <20260223145809.2369117c@kernel.org>
In-Reply-To: <zevfldlqbbprujyld3v3jdl7jlifbmn7ixhrdcpyj34eepv7m4@j55q7mptwqyt>
References: <20260219162200.510325-1-g.goller@proxmox.com>
	<zevfldlqbbprujyld3v3jdl7jlifbmn7ixhrdcpyj34eepv7m4@j55q7mptwqyt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-260249-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 331CF17EA38
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 11:23:29 +0100 Gabriel Goller wrote:
> Superseded by:
> - [PATCH net-next v2] docs: net: document neigh gc_stale_time sysctl
>   https://lore.kernel.org/netdev/20260223101257.47563-1-g.goller@proxmox.com/
> 
> --
> pw-bot: superseded

Where did you get the idea to send this email??

