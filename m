Return-Path: <netdev+bounces-284161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNYiDVNR+Wlm7wIAu9opvQ
	(envelope-from <netdev+bounces-284161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:09:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD8F4C5EB9
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FC47301DEDB
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D346377542;
	Tue,  5 May 2026 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE6JLjxK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621154654;
	Tue,  5 May 2026 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946958; cv=none; b=daUC4kdYjYXXmCmD0yfPCduxh6qR+ttbqbQOBqX8FqrWrp762K8P6Tjjbs+88f8Ko4BzjaEQkfmT33cBE+Csr36A/Sq4dex8Xq4ug3KOrlcUOjYRw9eTyPNR3iyBH86A4BVbpRdfxwB1wxwOVkjsRd1nS3YN+i0kwiT15cwA99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946958; c=relaxed/simple;
	bh=QtDHwztUbtw1r8LVMFG5qgo2DJenZ9aKj8SbaeEsMfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rq/BHMNshDyH3mLD670Dt3ZDlTuyeYeBGsco1Yb4yR6icT5x8ONgHjQ2SlKhw+rLwVdB6G0ffAi2E6FXdMR72Kp727tmCqa5omEOLrkb4zMwJFBNiEMTbKyHrWargZc2XPiXUmoIEmmCY+aaGINC+X+IaBTQTrMvmySI787hJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE6JLjxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EB8C2BCB8;
	Tue,  5 May 2026 02:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777946957;
	bh=QtDHwztUbtw1r8LVMFG5qgo2DJenZ9aKj8SbaeEsMfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XE6JLjxKZC4HEko31wkvlqePBhoxYjIBWP+jqh7gKzFtXLH2TzbpvbsNbxc6fwWpA
	 UjjV9tfoCWnB6yfJm86bJt1OW3jm+unx1t0rfaGddO30KasIEzBjTcnaFJ1X8RQBtR
	 HWR6rXCzwEUIZMRYyISRLaelEmyFTkt20181JqEzIVbVucYttYER/AHj3RrY6Ery8b
	 iFbJF2IkuHvARaeD6+T9pHtt4F63G0YAwyVomtB969ggxhnds7cUyAKpVPZtdZu5uK
	 aXsr36b7Hb9SmZljhpMaQldmd8775uYDcjw2QpSYJHjwW/GKq++QWrJ+BAhsPUtq7B
	 2VsRYvcdrubuQ==
Date: Mon, 4 May 2026 19:09:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, Yong Wang
 <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy
 <ujjal@alumnux.com>, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v6 0/5] net: bridge: mcast: support exponential
 field encoding
Message-ID: <20260504190914.0070bbc3@kernel.org>
In-Reply-To: <20260502131907.987-1-royujjal@gmail.com>
References: <20260502131907.987-1-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0FD8F4C5EB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284161-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Sat,  2 May 2026 13:19:01 +0000 Ujjal Roy wrote:
> - Added Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

You don't have to repost just to add tags.
Our tooling will pick them up when applying the series.

