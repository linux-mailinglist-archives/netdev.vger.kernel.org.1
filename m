Return-Path: <netdev+bounces-270745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFfMFLqxwWnlUgQAu9opvQ
	(envelope-from <netdev+bounces-270745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:33:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 139812FDC35
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7614A303BA6E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D1637B032;
	Mon, 23 Mar 2026 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ7BrXW0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407A232C316;
	Mon, 23 Mar 2026 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301621; cv=none; b=dXHSrPIyEQdYuSJeta6nlGfhKRaN43o8eWP/GP4BEvbhkRtSji5q8WBH0oiFBIyq1mT2YK52hgtbWoBBZj9LHKr7YWe+km8b+SgjTB0dRoAa/WQsWP6FzNRr9C6mKQQNYY7PHsLi8hChkFLK5Ot56PKqvCDLULKN9Twvn4K/RgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301621; c=relaxed/simple;
	bh=Bm59YAzyDpK4C2ZKVj0piaIgg6U14XZFE5AY6HNaUU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndbZv/cDmbpiRLht6kobURK03lpryb+DqdVTYd5sjFc0chUWQmfzNzs3NmZHT36YVJtWmW6vjSCxaQd2W0cKIJqTPdWMidHnTjPyqqBjU1DMryfSu0DEeWOecFl2Iv/sGFbsYZNwzwRvgObzWdfOogrcTescsq45BC8149kIKzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ7BrXW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CF6C4CEF7;
	Mon, 23 Mar 2026 21:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774301620;
	bh=Bm59YAzyDpK4C2ZKVj0piaIgg6U14XZFE5AY6HNaUU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bZ7BrXW0h6FCTjzFL3jZJ/DG3xaxDYu8InFYI4rDkE/PysqUL1ateWzqOBwogqHuC
	 /bMiAQZh2ZgbRqxh6QR66A4LzkxO/YW1W8FjR3jtm5GXqk9Z5NzABVpQPWbzNa8yVT
	 L05Bl/TFDWTeC9SALARMNcDF5OrhFEUkzlbIGGmGfngKDlg4d7gIQGVTyN20evuZNg
	 GT1AgeNUJ/V9X0Ocau9GCS7vafIJndzbIYQCqlOZLOcfqSbqIQkbg97vsWGK7savXa
	 SIBTILM6AisQH1h9/Djiopks670gMQ883liG0BSIxW0IQdJVA3nL97tL6TokeWpbzZ
	 9QSj3anMvz37w==
Date: Mon, 23 Mar 2026 14:33:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Johan Hovold <johan@kernel.org>, Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee802154: atusb: drop redundant device reference
Message-ID: <20260323143335.41cb1ce0@kernel.org>
In-Reply-To: <3e1d00af-de85-46e0-9d94-2e8fdd29928d@datenfreihafen.org>
References: <20260305104313.15898-1-johan@kernel.org>
	<d71db3f0-12b0-485b-afec-ea5eeed35305@datenfreihafen.org>
	<3e1d00af-de85-46e0-9d94-2e8fdd29928d@datenfreihafen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,bootlin.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270745-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 139812FDC35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 22 Mar 2026 23:30:58 +0100 Stefan Schmidt wrote:
> Given that this does not actually go through my tree an Acked-by would 
> be more appropriate here. Sorry, its late.
> 
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> 
> > Jakub, Dave or Paolo can you folks please pick this up into net-next? I 
> > waited a moment but I have nothing else for wpan-next in the queue for 
> > now, so it would be silly to have a pull-request just for this.

Will do, thanks!

