Return-Path: <netdev+bounces-281143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CoRHOBHR7WkHoAAAu9opvQ
	(envelope-from <netdev+bounces-281143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 10:47:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D76A469261
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 10:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7CEB300D464
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC37271456;
	Sun, 26 Apr 2026 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/iwhKZF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5319E819;
	Sun, 26 Apr 2026 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777193206; cv=none; b=RXdxXmkQlesL23PRTJy7oPak+S5WhqfOU+2P6d+1o7sgQUsPvXr31wbArvBz5nYr4y8mWFJYbe05fLVPp4juwTEark+L6sf1S9qfE6RyRWw042UQZlOmv8lCRmz7DVC7Xu7lluQqxREPd3ibkseq/p2BNA/XRTVChVOi23kyqBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777193206; c=relaxed/simple;
	bh=7Xam0TgLCaVeJI5K19pRX9TessTTUSIm68O5xYtzmW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ox7wHOJPMgXanL7YpZlMnaLBLW3qeJrre8j2lf4Zg4k9MGEdvMnTx+HyxIkkvsLEElp9JAweUGGRrStVknV+L4jwho4dcrzr+/nMnZZhhvP3dQRiDQQ+xNLkRjikWgA/ZXXA4CcTB2jY/X5bnC8Wqyz3OTQCj2vlzU9T7Ao+9wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/iwhKZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E97BC2BCAF;
	Sun, 26 Apr 2026 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777193205;
	bh=7Xam0TgLCaVeJI5K19pRX9TessTTUSIm68O5xYtzmW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/iwhKZF+IiRBtgzrm1kBwmA2q+eMMYyib2dF2RQeDPWEzxZiYl4b6BA3u4SO1NtZ
	 rAplh9dTlswNesN6XmJMV7NL0yvmX15cBpwbO3XJC9i3YFOYcGXyY+0a2+i7KPzxVH
	 khOSDUzt3syoq+X6RphKFDbd3k99nhin07WM9ytBvp3tzw5NzDpZSTkD7SIb6yQ8GL
	 Lwmy4J8uOi3LSuFMf1pmHm3OWGNcugJUHCEJ7ZoC+Rx6GRe39Wm8jNlbwN+ZyM0IW+
	 R9pngtAzx0MJ2xJy+zz6Zyt0bBCvhP3b1mXNyOwbPQck0fwUtstLJdj+C+8qycYpDa
	 4fBlFhLaRhYYw==
Date: Sun, 26 Apr 2026 09:46:40 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Keiichi Kii <k-keiichi@bx.jp.nec.com>,
	Satyam Sharma <satyam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wood <thepacketgeek@gmail.com>, asantostc@gmail.com,
	gustavold@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net 1/3] netconsole: return count instead of strnlen(buf,
 count) from store callbacks
Message-ID: <20260426084640.GN900403@horms.kernel.org>
References: <20260423-netconsole_ai_fixes-v1-0-92b8b7de9a2c@debian.org>
 <20260423-netconsole_ai_fixes-v1-1-92b8b7de9a2c@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-netconsole_ai_fixes-v1-1-92b8b7de9a2c@debian.org>
X-Rspamd-Queue-Id: 4D76A469261
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-281143-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bx.jp.nec.com,infradead.org,linux-foundation.org,gmail.com,vger.kernel.org,meta.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 02:41:15AM -0700, Breno Leitao wrote:
> Several configfs store callbacks in netconsole end with:
> 
> 	ret = strnlen(buf, count);
> 
> This under-reports the number of bytes consumed when the input
> contains an embedded NUL within count, telling the VFS that fewer
> bytes were written than userspace actually handed in. A conformant
> partial-write loop would then retry the trailing bytes against a
> callback that has already accepted them.
> 
> Every other configfs driver in the tree returns count directly from
> its store callbacks once parsing has succeeded, including
> drivers/nvme/target/configfs.c, drivers/gpio/gpio-sim.c,
> drivers/most/configfs.c, drivers/block/null_blk/main.c,
> drivers/pci/endpoint/pci-ep-cfs.c, and the rest of the configfs
> users. netconsole was the outlier (along with
> drivers/infiniband/core/cma_configfs.c, which has the same latent
> issue).
> 
> Align netconsole with the rest of the configfs ecosystem: return
> count once the parser/validator has accepted the input. The numeric
> and boolean parsers (kstrtobool, kstrtou16, mac_pton,
> netpoll_parse_ip_addr) have already validated the meaningful prefix;
> any trailing bytes are padding and should simply be reported as
> consumed.
> 
> Fixes: 0bcc1816188e ("[NET] netconsole: Support dynamic reconfiguration using configfs")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR: Sashiko has provided an AI generated review of this patch.
Like it's review of patch 3/3 - which I forwarded separately -
it flags that trim_newline() may perform an OOB access
if passed an empty string. But this is not correct because
trim_newline() correctly handles this case.

