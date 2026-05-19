Return-Path: <netdev+bounces-289217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPS/KrurC2omLAUAu9opvQ
	(envelope-from <netdev+bounces-289217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:15:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49109575753
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B71CC3019E64
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B01D130E;
	Tue, 19 May 2026 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9ife/fX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB87A1ABEDE;
	Tue, 19 May 2026 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149752; cv=none; b=P9K8V1Youihl4LBlOjCH4+/bfXhVeWcaoXhE3IsuDFs49h8ZWzOMX/W/2DYJNULWoGftnwDlzco8kUDgcnEn3KVY4XJN5hQWDk0ibezFhvGlLq4RIhykPaLjQdIpkrJduk8AYgSFa8FfWd3ps3ddizKHVlBLpQFHOgrPbaqHntQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149752; c=relaxed/simple;
	bh=XHVsuByL/XktUso1vX3AnXp0EPgic3oUXah4axgYY4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjE4uhh2TDTy8yYDDFpOzbdCVxVp/QkaH+YRDbj4Up0v1C2V0/XOyGCTXR0Yu5pDmFyS8+w3xuvg3S0b9lyIA7/1j4JX8iois+DMFKHllTA7Z2jUADd7UIaxu6S4JQjvMleMbVVTE2FTZJOTvCLeDeI1Nm/FXB0ZGzByURydF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9ife/fX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CA8C2BCB7;
	Tue, 19 May 2026 00:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779149752;
	bh=XHVsuByL/XktUso1vX3AnXp0EPgic3oUXah4axgYY4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J9ife/fXOK+EBsZdyTT4wL4hQFIy6eXeSywWFoiykKGUSyR20S5aoYzrIj2UhIbox
	 Y5an5MPmYjBHSmgghmtDMhn45ZtnjkWXBRDTAurw45ukSUovGAya4Y23Q09ml4sAFy
	 G7+WiGO6XA3YpYEwI9oMBKwP7uDPOGikQ6kyW/0QJZIlFenEkZPfOaKtwcJoGwuKJJ
	 lzb8YjohOn/Onhe4FpCe1sKXggQAnVS+a3du9m45g7iPtCb/dexkshDrRi7VhHRSgs
	 j7s6mDTTk73a0qHNIsEvAyKUyZeggZYW0qhK0tQBBkRYWZoRIYPNy4XakCTh69ux6O
	 jpqs6gkvAnjAQ==
Date: Mon, 18 May 2026 17:15:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/3] net: phy: micrel: Code clean-up
Message-ID: <20260518171551.1eb8b09c@kernel.org>
In-Reply-To: <cover.1778856199.git.christophe.jaillet@wanadoo.fr>
References: <cover.1778856199.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289217-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[wanadoo.fr];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 49109575753
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 15 May 2026 16:50:23 +0200 Christophe JAILLET wrote:
> This serie is only some clean-up related to
> drivers/net/mdio/mdio-mscc-miim.c
> 
> It depends on a patch called "[PATCH net-next] net: phy: micrel: use dev_err_probe()"
> that has been sent recently.
> 
> Note that in the 2nd patch, the order of the calls in the remove
> function is changed. I don't think that it matters, but I'm always
> relunctent to change such things.
> 
> The patches are compile tested only.

... against the wrong base tree I suspect? :S

Applying: net: mdio: mscc-miim: Remove some redundant code
Applying: net: mdio: mscc-miim: Use devm_clk_get_optional_enabled()
error: patch failed: drivers/net/mdio/mdio-mscc-miim.c:318
error: drivers/net/mdio/mdio-mscc-miim.c: patch does not apply
Patch failed at 0002 net: mdio: mscc-miim: Use devm_clk_get_optional_enabled()
hint: Use 'git am --show-current-patch=diff' to see the failed patch
-- 
pw-bot: cr

