Return-Path: <netdev+bounces-266267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MKNOkRVsGkJiQIAu9opvQ
	(envelope-from <netdev+bounces-266267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:30:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5108D255978
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05B2A305D6D9
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C97E3D3488;
	Tue, 10 Mar 2026 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGUpgX8e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B305E3D3499;
	Tue, 10 Mar 2026 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163657; cv=none; b=XHVVDP+lpybwUyV0GuOGisC94EhKnEXoyugYsW62SvJsIe0mQhvY/pbEvsUHkw90IJpbLsIO0rOEGb9BuZ8G349BUB1296IfpnbbXkPYv4yrMnBGl48raO4BywicyxcWOsQxWAONG9i30Bl4bmBno9Zd1lyDSPOpOjxAFgflpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163657; c=relaxed/simple;
	bh=YJOrQ1EeSYmYr1fTeFIDSndaSyodcyB1pQCAfy0Zev0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1MLoNXiiL14GAHAeSItiBFpCniob9EV9wiMsfHtGnTMIkdN7U9xZsVJ77Bta4mYYTvW5bX6g0BnfP4s+PKkU3xBbLvG1FKaZ6uYdGGhVN4s2yTtv+0PyI1C2q9xFsSfFZZdnPzljNZXrJzA6DLDvvQnYiwXPEPdkNbQ7b+WcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGUpgX8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93ADC19423;
	Tue, 10 Mar 2026 17:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773163657;
	bh=YJOrQ1EeSYmYr1fTeFIDSndaSyodcyB1pQCAfy0Zev0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGUpgX8eN94G532WfputAf8qD9RsPHtkk52PGAiBJllCwM/7bEr0gcpILSYeU7vjb
	 yBVypD8nPXlvpoZbSrhV9Ea9Fgv+a+lvT5nXCCO9IOUEe0yKCJ+g5YvWDrZPOsYwBk
	 4WfaLfZLSVQJnZRmQ2YFvA2ond2XY0Gx59pPzccRMDa02nNY1faVmlvvuh6ULoB64L
	 PnfXCgX7ulqvntbxUl5lkQltIz07LuEbDkg51gKsepBgdr/NrTyqwZtFLQU+8JiYWX
	 tWSmp04nrRTI+akZOLdrn2zPTMU4yAKrm3a5mIUT69O17QXzfm+8NsM1p2OhMSE4NV
	 jLZP5w1VRAVlA==
Date: Tue, 10 Mar 2026 17:27:32 +0000
From: Simon Horman <horms@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Tobias Waldekranz <tobias@waldekranz.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: mdio: mvusb: drop redundant device reference
Message-ID: <20260310172732.GM461701@kernel.org>
References: <20260309082641.15574-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309082641.15574-1-johan@kernel.org>
X-Rspamd-Queue-Id: 5108D255978
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[waldekranz.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-266267-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:26:41AM +0100, Johan Hovold wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


