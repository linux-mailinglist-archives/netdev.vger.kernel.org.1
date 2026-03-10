Return-Path: <netdev+bounces-266240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEr9GThHsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:30:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20416254D0A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6792231433B8
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3813C661B;
	Tue, 10 Mar 2026 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV3PgCH9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5A3C6618;
	Tue, 10 Mar 2026 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160217; cv=none; b=dffQEcGbLgobOfeifaWxWnjZUgx9DvVasFl4VKdNQjnrLw6sb/oNPeNcmeLeTNRq9ELlCGbKXlNGcipyfwOc3ud2f1wKxLz3Gd5uoYhbEDHxEcsGuzCjCpKYCMJnhlNmkV6cyEXU0lConk1HE0sRiN2+sEANcJLcfoYSEXYr1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160217; c=relaxed/simple;
	bh=aazP9WDp7oQZgfYVvJIJlhcRaGXmjDzUPO0HIS5x2k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DY3UCjr/SBW9/x7pYASU1AXLmkfFE0YK3FZjeTRrkakq/+L5iqeWiLSRMBPaL0HSg1Qx1qXdOkc5ieAUnqfAf/MK4qXli/GuRM4cJbUnofDc3B8paO9V9KhfzzDGB7NLJyA46Oj7AEQeM/GI8J3KuNuNMRc/O5mx90kCp8H/pHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV3PgCH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8D3C19423;
	Tue, 10 Mar 2026 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773160217;
	bh=aazP9WDp7oQZgfYVvJIJlhcRaGXmjDzUPO0HIS5x2k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZV3PgCH96sggM95sFEZBU/nSDWJnkqB7fr6rJ3sOS96URBrBCeBjOmAV01NwKA4Z/
	 wGG5CamL7zSsU8/aZ+y0SQdBe1528JCji7Qvg0HQQW2SJhRSTDLWgqGND0/NredD3E
	 h8utKZaMwf0r8p8nkphzvDxkKa3Fn4qESz04Ak95Rj2nrGUUTCxHCvEm7fYW10A3tc
	 bP7fzU0h9W+k5BBFtb0jiNlMPAyj1LMu25qUaanekdHLhDcH7qspKyYFDoSqaZ4kAU
	 u5wvvZIVQ3cPGr+y65zDXr3+vlcpPeAeEtPp8dRBdOQR0QjcP4NQNUh+PBurxVaoFt
	 4S04xZa8Cx1wQ==
Date: Tue, 10 Mar 2026 16:30:13 +0000
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net-next] net: mvneta: support EPROBE_DEFER when
 reading MAC address
Message-ID: <abBHFYwdoMQvIF-I@horms.kernel.org>
References: <20260307031709.640141-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307031709.640141-1-rosenp@gmail.com>
X-Rspamd-Queue-Id: 20416254D0A
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
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-266240-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,horms.kernel.org:mid]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 07:17:09PM -0800, Rosen Penev wrote:
> If nvmem loads after the ethernet driver, mac address assignments will
> not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
> case so we need to handle that to avoid eth_hw_addr_random.
> 
> Add extra goto section to just free stats as they are allocated right
> above.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: free stats on probe defer.

Reviewed-by: Simon Horman <horms@kernel.org>


