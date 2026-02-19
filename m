Return-Path: <netdev+bounces-259580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKr7KHBml2nfxwIAu9opvQ
	(envelope-from <netdev+bounces-259580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:37:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC54162119
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82DDE300D303
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE0D2FFF9B;
	Thu, 19 Feb 2026 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xwqaymds"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9E2D7D47;
	Thu, 19 Feb 2026 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771529837; cv=none; b=CUx/uixXjLplT8p47JOHGvwTquUcin6QX1tX2UK889b+EJFX72l2IKJhuM8NHe1XgeWQgAZaRRiU3Kf7nIE0H/2MrzARAQVg7T3i9ysXAAFeyXwJFT4L4LcskaCWbXYOGA3rgmO40sZ67+tOt4cqjbguO7G3G7NyHS7HdwF8CS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771529837; c=relaxed/simple;
	bh=T1l+ndD4KNNDUJKggkE0M2NN5sbRxUEHt5PR7Ad08Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpucHiv9OAdXsnHzM/zE2JOf+hDOap0FXfceZ/mE8YZjpkBjPe6Lth14sLD55XoD31M6aZlYLk60AVdAGr18RoddCRkTFaafUI1ssmGZ63E9ggMl0qDkSIZHCmc7zdjDgubzphbDDMNMozSYEZHBPxkgsBfreM/CetuxEkq/pIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xwqaymds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0C0C4CEF7;
	Thu, 19 Feb 2026 19:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771529837;
	bh=T1l+ndD4KNNDUJKggkE0M2NN5sbRxUEHt5PR7Ad08Ds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XwqaymdsENZCNHFjT956/HqCCVpnBHBtci6+CbJoar4DQus7chxHpj42HUQArZ91l
	 YV3jRGMTUmifkadQ5z1w+gire/FmcaekiuruASva3nC7sMRcgIKqMW6b2dtjfV3ZzL
	 Ztej0Kw6wAhIVX8Io6YTglVFR52lZyighvsu5AmOwAMZbiXapB6HnEeupTjOhqbpQZ
	 lvt9D5ZwXvfGeJ/JUwV3DfOYlXsB7MUUtGu8Vkq3A9ZV0WfZeOmKjSndSMQ01HxszT
	 LKa8Adx4UH0dTu66Mlmto00HN1BZiQlcbar22uxGMvoZEqfG5a0eJxCvbWYs8V44ZD
	 uPbgiQcr7Enbw==
Date: Thu, 19 Feb 2026 11:37:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: tomasz.unger@yahoo.pl
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: pn544: i2c: Replace strcpy() with strscpy()
Message-ID: <20260219113716.0a499b70@kernel.org>
In-Reply-To: <20260219192416.97654-1-tomasz.unger@yahoo.pl>
References: <20260219192416.97654-1-tomasz.unger.ref@yahoo.pl>
	<20260219192416.97654-1-tomasz.unger@yahoo.pl>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259580-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.pl];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yahoo.pl:email]
X-Rspamd-Queue-Id: 1CC54162119
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 20:24:16 +0100 tomasz.unger@yahoo.pl wrote:
> strcpy() does not limit the number of bytes copied which can lead to
> buffer overflow. Replace with strscpy() which is safer as it limits
> the copy to the size of the destination buffer.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.0,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 23rd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


