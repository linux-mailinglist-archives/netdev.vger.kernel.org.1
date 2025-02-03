Return-Path: <netdev+bounces-162301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A42CA26701
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 23:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966D4162DC8
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8130E2101B5;
	Mon,  3 Feb 2025 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q78kTbCp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B107210F44
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622400; cv=none; b=N2aUHrAH5k9BhKEVDk+XG1H5mPDDZJoksiZv4k6eXdRASSpsUoKkQjeicE3aWg9IVYEkksvPQkvM4jYSqou6HUJxxxheUwVex8c0ZYdB9FQlgwNtcoCRRJOCJ05qmHH17QRnTiMJfvSD7DMT0V+nuXGC4cgNog+wb9yVnvIeZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622400; c=relaxed/simple;
	bh=qFB0wnvJqyGjzKgvicZUJcS1TXMYyYiBBPpI19uIBKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOFbURpnOJ4KgwsBpZ/2P8nTqm3IdKhJHkF8NThkVzw+5fKpiGm6QHpiHgg4hwEHfvk7QlDQiK52XkCJzHm+hXZKbx+7rlwmotqguYxbsICj6XIp8VwoPL0pMbIa42O77L0ksezBmVyg1AkrPmN6XRjVHwGlkkFFyjOP/cD4L3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q78kTbCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1E2C4CED2;
	Mon,  3 Feb 2025 22:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738622399;
	bh=qFB0wnvJqyGjzKgvicZUJcS1TXMYyYiBBPpI19uIBKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q78kTbCpur0Q2Zk7PMa6h+wOTXm5c+e0h0WzX4gVp39v/ArJpXxcKleKWcvD19Ohy
	 Lc3Hd8ISiKyq/Z1NUod2WSB1Z40hsmUxBDJolizo56FFwjTdhB+UB239UcVycLf4wB
	 8zowxu6veAp2kK/BJEl4cCNGZJ5mapPzLISpcyeaf7segqujeQyAgYL+ZQ/8e0z5En
	 6boknTACHaLd6WHLAZ1ai1z7sSxRfiHof/YrpgkOP3fDjREuwHYi9muomqPSVAC7iT
	 jFVUqPbG0vsBGpWBsOwKF+/9Pvy0vZNv9LmFVRUsqQEA+8AINzJ2Q6nXHCCfGwqzwS
	 oW+kEGiyni0Jw==
Date: Mon, 3 Feb 2025 14:39:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: netdevsim: Support setting dev->perm_addr
Message-ID: <20250203143958.6172c5cd@kernel.org>
In-Reply-To: <20250203-netdevsim-perm_addr-v1-1-10084bc93044@redhat.com>
References: <20250203-netdevsim-perm_addr-v1-1-10084bc93044@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 03 Feb 2025 18:21:24 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Network management daemons that match on the device permanent address
> currently have no virtual interface types to test against.
> NetworkManager, in particular, has carried an out of tree patch to set
> the permanent address on netdevsim devices to use in its CI for this
> purpose.
>=20
> To support this use case, add a debugfs file for netdevsim to set the
> permanent address to an arbitrary value.

netdevsim is not for user space testing. We have gone down the path
of supporting random features in it already, and then wasted time trying
to maintain them thru various devlink related perturbations, just to
find out that the features weren't actually used any more.

NetworkManager can do the HW testing using virtme-ng.

If you want to go down the netdevsim path you must provide a meaningful=20
in-tree test, but let's be clear that we will 100% delete both the test
and the netdevsim functionality if it causes any issues.
--=20
pw-bot: cr

