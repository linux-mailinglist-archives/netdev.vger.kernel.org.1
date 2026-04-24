Return-Path: <netdev+bounces-280908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1t8tJ+jH6mmtDgAAu9opvQ
	(envelope-from <netdev+bounces-280908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:31:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1601B458BC2
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E211300A4DC
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3B119D07E;
	Fri, 24 Apr 2026 01:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUOn+NUO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A47BA34
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 01:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994276; cv=none; b=cxIZ/89jp5ExIR6Kobs62FyXSbfH/hs4l8dMq/m8QoTiawLnXsR/Ia+R6t7OLvonfIBF1uuWLdmrb5ux5XsKlyqSIJ72HUGgojHRiFsWaaMtl/CdJGr97A4gXUqCMZNdDN6RrcC3oc6nEmLFz/c3zx4Kp5VecUNi1PV1YH7if2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994276; c=relaxed/simple;
	bh=3mgW5zjHqs7EzXR4RLAYSETXNNCBa2QhsAQTOQZP4aw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fU1ILELoZvY+TxxR9if4r2ScUpU6bSbwIjNRKEZPpPpMnio5Qy47AyE61gxf5p50qux4cVONqzd/hC10Hq7Vfy7sWKgMRAi2Bd2Ytw2NXzi1QKb9wRulyAmK3Nn1x7uDfaNc91Qu5gbXjQmHa2IW27uoUJxjArZrXj+ykWxZ0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUOn+NUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2774C2BCAF;
	Fri, 24 Apr 2026 01:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776994276;
	bh=3mgW5zjHqs7EzXR4RLAYSETXNNCBa2QhsAQTOQZP4aw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gUOn+NUO6pX3WM8ZOmNCrXpncXxXtEqa1Owj8j6/ffChaDbR6IkeWgbGCSvQqfi9d
	 6LWKNBKxXOiJDhzJoV4vQ8DL3vDmUUJ+EdMgyGyTjXzMr0ueG/S25dF4Hs5ZCoxYmw
	 ihMSylbilKkUDaZqSUOY2KC5zeLtrH1RIfM1/3Q98EjG5arwCrylFR9fbumA5AyrEY
	 E6lYIGGTJ2uw0ZY6Ysv8PnXxMJl7X4Dv0LMzYyESEQJ3MKCX0qRfO+AEwU+0ewc06o
	 g+2V/iFyqz8cGviaNslg0sSlbo+9UwJTLSgzru/FivFqwPfvrR1uNLaLn4bgP0k+eC
	 kxS9xHQTly2Cw==
Date: Thu, 23 Apr 2026 18:31:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?w4FsdmFybw==?= Costa <alvaroc.dev@gmail.com>
Cc: jiri@resnulli.us, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] devlink/param: replace deprecated strcpy() with
 strscpy()
Message-ID: <20260423183114.560396c1@kernel.org>
In-Reply-To: <20260424012037.89619-1-alvaroc.dev@gmail.com>
References: <20260424012037.89619-1-alvaroc.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1601B458BC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280908-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Thu, 23 Apr 2026 22:20:22 -0300 =C3=81lvaro Costa wrote:
> Replace strcpy() call used to extract a string parameter from param_data
> with strscpy(). Since strscpy() already performs bounds checking and
> ensures the destination string is NUL-terminated, remove the string
> length check as well.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.1,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Apr 27th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#de=
velopment-cycle
--=20
pw-bot: defer
pv-bot: closed


