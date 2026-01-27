Return-Path: <netdev+bounces-253677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBi5OlkweGk2owEAu9opvQ
	(envelope-from <netdev+bounces-253677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:26:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9BC8F8F5
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E56BD300371C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D721330AD10;
	Tue, 27 Jan 2026 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqBZJIAF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324530AAD4;
	Tue, 27 Jan 2026 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484373; cv=none; b=uKnpf3ZbqrAbNyO8LQfNg9P1WDl2aQTxfQF8WqNK5sW6sdlk+U04ndXyjJ2yLn2edUlB2C/Ff2YI2h5ltsvFn+gUIdQzvWcpTt+8sU2iNdJTZak9SDQKnfoFU9Yxrs8z9GQ8wwp75Lf+Kmi2luXUNpH8M88Li5NqfvA4bFDxZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484373; c=relaxed/simple;
	bh=VWFT2HK8lhAJqIqtWpl4sBYhEGC7xC+w6rj3d1c8KIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyA4YIQHFyf5sBNx8cd8qIy/1y7o45v7yYPp/2T+d2h23A5TP1dgJ7mPTkKFfaSsQ/66GV0OxVBEA9lVQ9uwKUrnEf2E8hwMynWgki2xgdpTW6ZhWzKl60fNyLYbNW+nkbqPmNOy6UqtgaE0TuGB1vWGy+IhAt5r8fs9V1JCQk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqBZJIAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1496C116C6;
	Tue, 27 Jan 2026 03:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769484373;
	bh=VWFT2HK8lhAJqIqtWpl4sBYhEGC7xC+w6rj3d1c8KIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rqBZJIAFP5v3VMNkgZuFc5mKGmCyWQ12gBSzz4Mi1I7XeDSJ6tbD3+JUNj89epI97
	 P/EniW5JbzPN2Y5hspUdPrsgv6Vcq6smVQFS8WDakcV/8NUkHQBBP5eIfqvhzJai7G
	 HBNqQyzjj+DifN3Z7hh8HZW9GcE3ZjHO1tWCaK8hbnv0nV2sokzFbsMf+7rkXewj/M
	 fX3/nepaPNLRalHv5lVURs/wOtT+ua4+rOlGWngg4UZ9BU2GttBpwjQwvKE3jfQKdb
	 L5bfLFtPpKdSWwqOZPvFmLqUUpDnPdO2TvHHWkLBURo5gaYZQuxERCG6NMFPMTuu1j
	 eA12odtD/H00A==
Date: Mon, 26 Jan 2026 19:26:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH net-next] net: usb: sr9700: remove code to drive
 nonexistent multicast filter
Message-ID: <20260126192611.5ca0e9f1@kernel.org>
In-Reply-To: <20260123065842.53669-1-enelsonmoore@gmail.com>
References: <20260123065842.53669-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253677-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E9BC8F8F5
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 22:58:32 -0800 Ethan Nelson-Moore wrote:
> +	else if (netdev->flags & IFF_ALLMULTI || netdev_mc_count(netdev) > 0)

nit: netdev_mc_empty()
-- 
pw-bot: cr

