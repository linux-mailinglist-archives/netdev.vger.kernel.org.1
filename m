Return-Path: <netdev+bounces-253550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CXmAOGed2kCjQEAu9opvQ
	(envelope-from <netdev+bounces-253550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:05:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E268B43A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0BCA3002F50
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC38F346791;
	Mon, 26 Jan 2026 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvv01XqX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887132BD02A
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447132; cv=none; b=CD1iPvioNUe3TOs/Um2N6/bvyBE+/dBhk7LJntXK0/CPpyIVl8dvM5FkePkR4p2W6MF2bx+heTx51UfhL4l6548rRTsAyVb0qNOG3j98du7YPdEJmUzIeA2XfmJc632B+4Kc3Y8yG07tBkrlE9qKYeHfj0XsUt3Ev/BwGQjNwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447132; c=relaxed/simple;
	bh=G6A6OEJCL8j3M7ufls0zWK9TTkkDIkhB2fxweN5h6Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PChrWQp9W49YiDZyJTQQ8mnu+zmjm8E7g4dUQST9PODDsb0bPAXDYrKu9Pw6b+nvxOBbqI2M6uC+MXYUEc8KmmuWLDhOY9NY4zGELUHAOv55bJwhO4fxr43X8o/NweU90rXy9eTJqhtrAYKAi5yHEScYxLdywlHL4CM/Gqgzbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvv01XqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8AEC116C6;
	Mon, 26 Jan 2026 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769447132;
	bh=G6A6OEJCL8j3M7ufls0zWK9TTkkDIkhB2fxweN5h6Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvv01XqXo1G6FipoHEov5b5sRqSayqhPvW0/DI5plRGd8YWfZK3zK5mNHFdxjo20+
	 QzP6IVQQv2epjqaCxwX6837oswMABam9f7CRFp+zuQhzFAhgX6KWqqijGSr71V0Hg9
	 qXH5aaOwP4SZ+04VIo5ud83vJVfQrUBa/MSo9ZGlJvPP9nhO7AtC7NamcO69XVGVam
	 4YICTi8vxxR1CB0kOzq8XuvrjmDzSkDwEE1vJehP+T2n/JHU9MXVYon7BbsVJkDMBJ
	 JOi+I+b6uK07eS7gSM8mXnDXKhp9yYh8ftZ5nool2ZH8CGpvaz38tCbp3gyolqzQ3Q
	 2Mq0w5zslWhpQ==
Date: Mon, 26 Jan 2026 17:05:28 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: remove optional size argument in calls
 to strscpy
Message-ID: <aXee2KLc9KTVWXhh@horms.kernel.org>
References: <d560ec66-848e-4290-818a-ce28f39de493@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d560ec66-848e-4290-818a-ce28f39de493@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253550-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 62E268B43A
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 10:30:15PM +0100, Heiner Kallweit wrote:
> Minor simplification of the code by removing the optional size argument.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


