Return-Path: <netdev+bounces-266884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFwwHygusmmzJQAAu9opvQ
	(envelope-from <netdev+bounces-266884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:08:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CF326CA11
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 456613029E7C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA7F383C60;
	Thu, 12 Mar 2026 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwzWAe3v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C337CD45;
	Thu, 12 Mar 2026 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773284890; cv=none; b=ccvOcDkaciOUorWGS294zERj6RWJHrDSrjf9xL5G6Ro/6zFhKoj+s1i6mLvFZ8qQa3w+BF11ub9HgGLZ97Fs86E1PTrzEA9lRINgG+PAHpXI/MrlBMBG29LkpOIQvVa8YnGrYAzhJHrTw8j+2LNQ6JoGCA6VlNTntJWwZ9R70rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773284890; c=relaxed/simple;
	bh=6Jh5akto6GTbsD5SBDHoAtMj0y3raTEJ/OL+GEg6Nv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxaMBdiDeN+eo0trm1lmPywWJlEiyM+oadmEdXGwqUWrAFqIwz5NuCYI2JMQWyNiZaPwTkJKtgYejV8+GmKaoN0av0l6MACwRU7qao1QTr4D83wOWTd4SlMcGLcXoCtykRwq+zySg+IW9tQvBlwJ91iEH1fAP1yuVVfWnH6tSc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwzWAe3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F937C4CEF7;
	Thu, 12 Mar 2026 03:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773284889;
	bh=6Jh5akto6GTbsD5SBDHoAtMj0y3raTEJ/OL+GEg6Nv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VwzWAe3vg4xkXf0PSS9T3X1PZT9cZEHUcCZ9181ArNBsA54kWnL+CNqMPPMsbS0qV
	 SxaosZWnMEovqygTfx019iWD+LMkZmeOpu3HKBqAkA03VOWoAq0amW7Ol7YQNk1k33
	 bmET2Kc8V9+ect7BQpYtfEBgKiAeKFrsdIwqV6U++GywUNtJ+e4iWZYQKOLd60Aygk
	 JV/cdnbU0GrRIIEBvNwkaspgWUrU7hQHuICBxkc7A88s8SrqM9TnH3q2l4RaF+/Q4z
	 E6+V5Bs9CtECkWt5cTXavSe6JueJFghdbHW5PqA10UQbVzcpqP++qCXHHGku18OJgS
	 fB315APd28Etw==
Date: Wed, 11 Mar 2026 20:08:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Aaron Conole
 <aconole@redhat.com>, Ilya Maximets <imaximet@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH net v4 0/5] selftests: net: fix false failures due to
 missing features and host interference
Message-ID: <20260311200808.6287d90c@kernel.org>
In-Reply-To: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
References: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266884-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1CF326CA11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon,  9 Mar 2026 15:20:08 +0000 Aleksei Oladko wrote:
> Subject: [PATCH net v4 0/5] selftests: net: fix false failures due to missing features and host interference

Please post for net-next, "PATCH net-next v5"

