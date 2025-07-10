Return-Path: <netdev+bounces-205616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84088AFF6B4
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EAB816C28F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4162227F018;
	Thu, 10 Jul 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxerFq3l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57F27F00E
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114008; cv=none; b=gIOPvyRSX0Bv1eZjxihbs+Pm0WBTweBS+HxwPkJX7rIN+7YA9FBYsiE9PMh4gJZog4fH+CNi8BWPfDupdlmTPLItaoNNsRd6TTqbaIy+mk+fbwDDdJK8JJa20H0m6cE42L6M2fV7/2OtADjbpyBgMO6d13TffnxlJ6EZgc1/Na8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114008; c=relaxed/simple;
	bh=DW/D7JVqK0xt8qLXrHJGXyltu1qAFr5ZVskNry40R48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGvhNUay+Ou9QLVCCWDrCwrhezQ1UHqCSzxTbqjvGSgjNz0rQbNhz96zpxqY4G1r3XlbDSQd58eqDgrTPSMjNro8et3QgqLTxnWkQ1kSYc3xZ6o1GPwibw2DmnxzHnOJlFatyJK6CfUs2ADSnk7bvnAWkMvQ8wod+H5NcGIEDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxerFq3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3839C4CEEF;
	Thu, 10 Jul 2025 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752114008;
	bh=DW/D7JVqK0xt8qLXrHJGXyltu1qAFr5ZVskNry40R48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qxerFq3labb2ipRm8sQ0knK3Q0XiXittIqeq2VyKVkva15u1/eW8pzNwDuPW/nQQ7
	 +eNYnSLc0z5Y1pIxGywxgQWvPH17SCUD3z89fDJ/Nmi4XHhwv2dGMzc456MlDV3qca
	 XOYHv6HcmEs3qtr7x/vuc/19krQohPKA7JCIF92Hlm5DFhnZ2OjMfMAHRVzWQxY0vA
	 4Dl5MG1xRpf6y4uiV8aYuoTvgjzQDgLuGLYdk6sG1Zi5weXRVzxxGFCJRtSGN+6nuS
	 LLG9jX4RNDEoZrajS/HOp1vvMHxV9TC2cmNGTAQ+RudRvsb7md/jkpzvmuR/WW+Vnn
	 kpcCufKpEkBEg==
Date: Wed, 9 Jul 2025 19:20:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: netdevsim: Support setting
 dev->perm_addr on port creation
Message-ID: <20250709192007.145b8919@kernel.org>
In-Reply-To: <20250706-netdevsim-perm_addr-v3-1-88123e2b2027@redhat.com>
References: <20250706-netdevsim-perm_addr-v3-0-88123e2b2027@redhat.com>
	<20250706-netdevsim-perm_addr-v3-1-88123e2b2027@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 06 Jul 2025 16:45:31 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> +	ret =3D sscanf(buf, "%u %hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &port_index,
> +		     &eth_addr[0], &eth_addr[1], &eth_addr[2], &eth_addr[3],
> +		     &eth_addr[4], &eth_addr[5]);
> +	switch (ret) {
> +	case 7:
> +		addr_set =3D true;
> +		fallthrough;

Feels like we should run is_valid_ether_addr() over the address.
--=20
pw-bot: cr

