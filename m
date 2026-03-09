Return-Path: <netdev+bounces-265769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNV7Htk5r2kPQQIAu9opvQ
	(envelope-from <netdev+bounces-265769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 22:21:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D65224191A
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 22:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D649030244C7
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 21:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA7330EF6C;
	Mon,  9 Mar 2026 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYSj+h9z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CB425A2B4
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091287; cv=none; b=Zk9S+AjI9MOXvE5CmxYE899o/oviJ4bLhOuFGS4XgXoQMkbhYuceU0Refxw9qhULAHJ9J8Q1OGWY8aTlR602BIb+41PWYeVkE+vok2U4Ks4IPjAdi4YwX66iDjKV9tVwjkcxK1Up4qBpQbnJigrudDv7s6TQNz7f0E4ICGGHmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091287; c=relaxed/simple;
	bh=oe9ddW4pLbC7lONtqKIRzyfPji7D5xo0kfNqyHjFWnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/U+xk1h9mL84USMCyXZSWXxb88itjIuVsAGktNcWWdqILoq35k6I8R0Mie66FV079cCnc2h5ukX3WCWHd87WSfMUHWOePuITl5/K8lYHk9q6MsKAu+//o5DjZMXfCIY+UTw1Cl19xvAau0+eX87v+TJTTLGUFvxLTvlz5aCWSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYSj+h9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D53EC4CEF7;
	Mon,  9 Mar 2026 21:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773091287;
	bh=oe9ddW4pLbC7lONtqKIRzyfPji7D5xo0kfNqyHjFWnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uYSj+h9zYUbUy5/w5ZnNU5AiRYrtoqxr3z3I9ntmG3XdDTtOGJknHkeCsZ7QWsKw9
	 ysWOh81mPvfWSfmRzApGyIj4hql3weofWoT3TaY8Cx8uW0G0X+qHwj2P4xSCbMSpEO
	 AG2wziet9/04roW2zHsjaI1EcbKq38IAnlCv9tLcUugvsoWH8+J/MgqLqwc/3ZHgb8
	 5jTkJqoCfvsQohJbVDVNiv4JiCfhjZXM5DzgyXyWy2gkPhtKmcIICpHIn4Co4qB5NV
	 DIEkTR7WWLM/yUomnHESX6hPijsmsGLLvJJZpBr7Z9uVvV5vFO/lwjvNTl4LIgC6sS
	 qjMfT9BX586eQ==
Date: Mon, 9 Mar 2026 14:21:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "sd@queasysnail.net" <sd@queasysnail.net>,
 "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net v3 0/3] macsec: Add support for VLAN filtering in
 offload mode
Message-ID: <20260309142126.2fe0cd73@kernel.org>
In-Reply-To: <678c4e9e9f2e54e47e67005e1a230641300e40dd.camel@nvidia.com>
References: <20260306151004.2862198-1-cratiu@nvidia.com>
	<20260306115353.28f322e0@kernel.org>
	<20260306115405.0febac64@kernel.org>
	<678c4e9e9f2e54e47e67005e1a230641300e40dd.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4D65224191A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265769-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 9 Mar 2026 16:23:22 +0000 Cosmin Ratiu wrote:
> What's your request here?
> Would you like me to move that test out of netdevsim and have it work
> with real devices as well? Or just add the VLAN part as a separate test
> somewhere? Or we leave it like this and keep it in mind for future
> tests.

The first option - adding a test that can run on real HW as well as
netdevsim will increase the code the test exercises by an order of
magnitude.

