Return-Path: <netdev+bounces-284092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLgdJi0w+WnA6QIAu9opvQ
	(envelope-from <netdev+bounces-284092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:47:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF8E4C4F16
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13615300863F
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4642D3DA5B5;
	Mon,  4 May 2026 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0ODceSY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DDF35A38C;
	Mon,  4 May 2026 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777938472; cv=none; b=Gf9Ik/FN0qapJF/ov1WFf3CIdlQopDVrq/6nlClvEJwqfcFTt7tBcHfHdsLUfVnveM6KzToOOSwEr29Qu/QP7GZAerZ+9Z6AwogtxmYkPqbgx20Ic+9DpS2GPPrN1bXT0O/S6JV00Ix2W/xNpk79seyUIYS6Hop6dHLkku7MNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777938472; c=relaxed/simple;
	bh=zlNl/31cJlXFe729EzijjaD7RKBh3+E2pVeQT84vO6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDjhKtMzBxtsO4tXtJ7xKGkHmVBOmGJOsTKYWLSk0a8L7W3nncKCNDqnAALxNH/FsyNaYchuKAIUd7WbMgl3dew/LR594N5HarzhJhm5OZlCFIJ7KJGVKqNoufN+Q0JDnZRupMg14sJcVzALBEzyEZdRKMieF3LuUgJx+PHyOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0ODceSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E0FC2BCB8;
	Mon,  4 May 2026 23:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777938471;
	bh=zlNl/31cJlXFe729EzijjaD7RKBh3+E2pVeQT84vO6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S0ODceSYBvsK2yl3SNJBAbm9Qcjrx9s51vrrGC+isk9qJjzgxDpr7dVrx9OKcls3q
	 3B+3b41MsxIVIRgz9zEasNIj/bxpKuerlgA4JuS34h9bdLlEPTlVUyCKaeAq87+mn5
	 Hyy1y8pYx+dXs60EY9As0tyrCNdF/1hQYxuSdcbb8tr1U2omib5OCRgT2AHXGn1rHv
	 F6JkT2s7s7zKTVJNdx9Ox8Mck31DKQ6rJ8vA3uWIaDZkccKhO9QkR55zLdewO2h4kZ
	 zX0mI2CBEHKKE7rynbQLRv2SWUCicE+1R0Bpw4pc+4h6V8XGINmpzpW9YrvKN9KXu6
	 gGEYWjPr3dMNg==
Date: Mon, 4 May 2026 16:47:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Parvathi Pudi
 <parvathi@couthit.com>, Roger Quadros <rogerq@kernel.org>, Mohan Reddy
 Putluru <pmohan@couthit.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>, Felix Gu
 <ustc.gu@gmail.com>
Subject: Re: [PATCH net] i2c: sun6i-p2wi: fix of_node reference leak in
 probe
Message-ID: <20260504164750.5eb6c55a@kernel.org>
In-Reply-To: <20260504193834.3516862-1-shitalkumar.gandhi@cambiumnetworks.com>
References: <20260504193834.3516862-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ECF8E4C4F16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284092-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,couthit.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,linaro.org,vger.kernel.org,lists.infradead.org,cambiumnetworks.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Tue,  5 May 2026 01:08:34 +0530 Shitalkumar Gandhi wrote:
> Subject: [PATCH net] i2c: sun6i-p2wi: fix of_node reference leak in probe

This is obviously not something that should go via the networking tree 

