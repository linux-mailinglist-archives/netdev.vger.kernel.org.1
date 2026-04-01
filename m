Return-Path: <netdev+bounces-274283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOceMT2xzWmifwYAu9opvQ
	(envelope-from <netdev+bounces-274283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:58:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C784381D58
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56B11303779C
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 23:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FF53DCDA1;
	Wed,  1 Apr 2026 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBi4eR9A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634053BAD8C;
	Wed,  1 Apr 2026 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087930; cv=none; b=f5y9S0iFgMF2m2yh67mzOZ/H3QxknzStGvF8AVxzfV5YONt2o/XsX1pQXHweHZDCik/M4s8VPYlevoC352iA1Ji3V2DULjSf6kxGenK+BVW7Ahdc3qybbZPsL4Qa6RSI9bMirBfkcDqQfCvcrbXrm09dfWsDFCyzG3WKLO84Fb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087930; c=relaxed/simple;
	bh=7nbU16U0zLeYTBFzm8QkBhBZuwMLrkDQjPlA/qHkw+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6JwVpctPzOUUnVFXxZ3/8G1tJCrz+NMRAyK3spgV0MkDb4uk7TyC6RyZgtWREhn5TjaQaAyK1Q3d3YoBhUkI/8TocN3pe9HDPVuCku1nFYpy8bmGPilWrypWb4hfM6vAGhtY6RN6+U7Vea2G0FKmfPuNmyMm0dfnIyD7ieqSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBi4eR9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD805C4CEF7;
	Wed,  1 Apr 2026 23:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775087930;
	bh=7nbU16U0zLeYTBFzm8QkBhBZuwMLrkDQjPlA/qHkw+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bBi4eR9AobchAUuEOTQFoGyz11Htasa8mN38Clsu/RHSTSnioYNnmLHCZDWWwD13p
	 2UXkA+7tDrCI9mZxvvUsU26yCxfreEyU9OKW6cWzNR2JEjtCBVtJC7sEfsRJymPcvq
	 0QgynzWgEMQOis0SOk3sABlRS70oBOodaLDrr9ua0LU6GUZZzkRAP8+zWgDU3YnayY
	 49wNX5YeXOKYv5v5lleP2V7Vy/keIeJRRaHcbUxeHRQpFxBhps45FZ5XW5GYhwAQGk
	 erF1947ON59NwNCRHVW/viwoOIYkmTbf8BJ0ySliJJRrRL7SejnwNIbe/acUW+zQJI
	 usPLj4gUNp7eQ==
Date: Wed, 1 Apr 2026 16:58:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, petrm@nvidia.com, willemb@google.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: py: color the basics in the
 output
Message-ID: <20260401165846.6aeddf20@kernel.org>
In-Reply-To: <ac2OJvW8ZfzDFtHr@mini-arch>
References: <20260401183309.378671-1-kuba@kernel.org>
	<ac2OJvW8ZfzDFtHr@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274283-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C784381D58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 1 Apr 2026 14:29:10 -0700 Stanislav Fomichev wrote:
> (not sure why you think this might be controversial)

I'd like the "libraries" to be minimal, so any increase in LoC has to
strongly justify itself. Whenever I work on something in ksft I tend
to produce a bunch of "improvements" of this sort but usually lose
confidence and don't send them out. The coloring thing has been
annoying me for a while but mostly in NIPA context (on the web).

