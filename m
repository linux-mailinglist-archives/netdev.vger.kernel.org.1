Return-Path: <netdev+bounces-42515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F57CF1A3
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 09:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD52B20F1D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 07:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B5DDD7;
	Thu, 19 Oct 2023 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6iW2LsG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860DBDDBB
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 07:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D123C433C7;
	Thu, 19 Oct 2023 07:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697701705;
	bh=/IibyOpnao9r42xVPYOHLw6LmFSE6ulAzWAstoK31EI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=G6iW2LsGTTXAxOM+c/AJWwsFNlQr4ki6Py/d/AmmljrMajbIsu6a2FouXp63PAvW4
	 8pOSmU9tJIGU46clTK0MEEOIR5sODxC5ShcDPWYAbJl5FA+j8mg+y/QkzODpSDJEc6
	 eQVMaihONSc8Se9L1rNfGpEFRX9BFiBh1TcNKhJSbur9mGCh+QIcOwjJ7OJOItTUeJ
	 W9V873YiRJBpMK6Xq+q0GZqBqOL0oGDnk8nRV8P+G0h9VIv2jUW2o54sjKtdNLBWSm
	 yQQBtyQSEX3JDSyN0AD353wEyl7hy5A5wHN/IfVHa1d1BxzkoQxQ6EuPoFtxPt+Pfu
	 rGAjZkoF6drRg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231018111343.176ac1b9@hermes.local>
References: <20231018154804.420823-1-atenart@kernel.org> <20231018154804.420823-2-atenart@kernel.org> <20231018111343.176ac1b9@hermes.local>
Subject: Re: [RFC PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from device attributes
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, mhocko@suse.com
To: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 19 Oct 2023 09:48:22 +0200
Message-ID: <169770170247.433869.3027675693618433446@kwain>

Quoting Stephen Hemminger (2023-10-18 20:13:43)
> On Wed, 18 Oct 2023 17:47:43 +0200
> Antoine Tenart <atenart@kernel.org> wrote:
>=20
> > +static inline struct kernfs_node *sysfs_rtnl_lock(struct kobject *kobj,
> > +                                               struct attribute *attr,
> > +                                               struct net_device *ndev)
> Still reviewing the details here.

Thanks!

> But inline on static functions is not the code policy in networking
> related code. The argument is compiler will inline anyway if useful.

Right, I'll fix that.

Antoine

