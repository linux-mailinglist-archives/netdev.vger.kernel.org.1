Return-Path: <netdev+bounces-259789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MImVM9f0mGkaOgMAu9opvQ
	(envelope-from <netdev+bounces-259789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 00:57:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E68216B765
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 00:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00FCB3008D0C
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 23:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F523090DD;
	Fri, 20 Feb 2026 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6pqJ8as"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673322DCC03
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771631819; cv=none; b=Pkm1zZARpAiMF9kJO6IftcwJxmrmsMAzQ/bi8vFpqIHjdvy+mUFRAzZsmYAK4ykkaikBdSxUWBRi1EXcJBzoDAM6sPX5vLxo2kr+P9ozBok/Mm9fQS9CMAdbe2CK5aDxGWHEqvMbo+WM1aydKlHnfaaj7HoLiRqqagebkInIgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771631819; c=relaxed/simple;
	bh=LKxC9G4UYXLTZYebYqLWaIJRz21m9bJ64d7X8EA0544=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLn0Bx6ey9rymDGpvI+vnSIy31iY7s8PvYzsfnGB6tl7lkihfv3bNfdDxZPpKYaLaATdUzZmuTI/S9a1HNBFp6WF3RPGDHywNDbQhNB8W4tUNZHp4QVtR+wn09d3rFPWcoSjgEHh1xR7Lf0HmbxpYArthdMgV52wizEQd9R8JFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6pqJ8as; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E51C116C6;
	Fri, 20 Feb 2026 23:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771631819;
	bh=LKxC9G4UYXLTZYebYqLWaIJRz21m9bJ64d7X8EA0544=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l6pqJ8asxoGF34+i/VYeWW0+aBjqxBwcSXQKV4KhaDkNC9oW2lOPaxlOLtDDM0zo3
	 kJ6/fobIrwXlvrn4V8CkFQNos8NRp9I+cUdnNaf4jJVDFfFg9uNB432qpoFeELldtQ
	 P/92n/kxfWPxYWzVJXzikoGBAflzKYifGxZCyogW77GT5zKcWxbmuFLINShtp3KzjU
	 HxpL3PGSjwbPwQk8SiLKmU76CaSxUB81MN074+bXxlltSZog+PE0bY1SmnPJXVEkcX
	 98tYOkwELvpYJM9Spdauj9ChH3XRWajQ5U62NbirNEyz0kBysR08k4W/9AJ5TtEukD
	 2+jzloqxMC5sg==
Date: Fri, 20 Feb 2026 15:56:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: satishkh@cisco.com, netdev@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update enic and usnic maintainers
Message-ID: <20260220155657.45c0575b@kernel.org>
In-Reply-To: <20260220082157.GD10607@unreal>
References: <20260219-enic-maintainers-update-v2-v1-1-c58aa11c2ea8@cisco.com>
	<20260220082157.GD10607@unreal>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259789-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E68216B765
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 10:21:57 +0200 Leon Romanovsky wrote:
> Jakub,
> 
> I assume you will handle this; is that ok?

Can do, thanks for the ack!

