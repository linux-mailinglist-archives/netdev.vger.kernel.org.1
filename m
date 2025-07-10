Return-Path: <netdev+bounces-205614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B8DAFF6AC
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7488E18996E6
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5683B264FB3;
	Thu, 10 Jul 2025 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqW8UxJy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113419D065
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752113880; cv=none; b=Cs9oAtdFeA09qEXZ4OQOMOVOEZuaE7lEYuQQjQf6QgJw3BluaE46ipUYyadLd3HQj/Oy2iwHhLqnwSHRW7agw0nWv/CSB6Ox0Q+R1zF7ZM/6bi7NPxPZdiKB4ScY59L8OHeQmApYEliLpa9hyXgY+J58tMLQHNdTrZLKOZw6PlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752113880; c=relaxed/simple;
	bh=Rcgyg3uusi8Z7x+CmCMOMJwA3EzGlsr+gbgsK3S9taU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbTo5dSJYlE+p51Z1kKhuC7RoT9ciaQcL1/YG/gEU6689e0QLk/nKL1U2uDakccalofbt3Y4CHLNhGeqx2+CG4+jZudApMk8DXNweYA0vr+uqAhe7fs5abOHXFWs456QOkkPBLqLTla8TQ6f7YhhodGgfivhUKDFpQKprecxNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqW8UxJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BBDC4CEEF;
	Thu, 10 Jul 2025 02:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752113879;
	bh=Rcgyg3uusi8Z7x+CmCMOMJwA3EzGlsr+gbgsK3S9taU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EqW8UxJyERoB8UAPe4Evw2zrgtpN3aPo9LT2KkBL6EjB5wt2i6/H3Z45FrRhq8Kxt
	 pssz8iXZXbsz5lLZv/9w95+f6BvpnWg6jg0vbPOtc9QhA2eJz7aMCUhiKp0qYhz2vf
	 b1tV8N1vIjLTV+f7S/keSMulLBRZfxXI7nI87JFyT7uUif/cP+ZLZ9hcwyo459LF1P
	 G5km6W9d6sLU06Pq4Jjyxx/77VimH179e9wQ0RZSVOZTfz0kSG9DCuMT7c0ozbpAnK
	 k6UT9DXS8gDPsQbXIjqRp9j16LkUOtDnVAN+q0K7JEgph1mB0EfxB6Ix8LoAQdR7/N
	 y/QE1V4m0uQ2Q==
Date: Wed, 9 Jul 2025 19:17:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] selftests: net: add netdev-l2addr.sh
 for testing L2 address functionality
Message-ID: <20250709191758.26bb5607@kernel.org>
In-Reply-To: <20250706-netdevsim-perm_addr-v3-2-88123e2b2027@redhat.com>
References: <20250706-netdevsim-perm_addr-v3-0-88123e2b2027@redhat.com>
	<20250706-netdevsim-perm_addr-v3-2-88123e2b2027@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 06 Jul 2025 16:45:32 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> +    output=3D$(ip -n "$ns" link show dev "$dev" | grep "link/")

Please use -j and jq

