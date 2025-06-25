Return-Path: <netdev+bounces-201311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3997AE8F1A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9513B1897928
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C640E1FE47B;
	Wed, 25 Jun 2025 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDh3UKRt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28A31F3B8A
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750881845; cv=none; b=Xx1101m8nG41Hks6tvbqqdG0M7Sm1wTGQ8VSdrVyFlj/DQExwiRJIF3PbgG+RbJmRejG9NlG6ahRtn8dwDLSOhkO00GzIYxRGSMTo3cvTqQriC843ba4XtjY+vbosWnPklGuIA6DYfoOWFQNVc3ihvkehNkMM7IOGQGaH8IvIR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750881845; c=relaxed/simple;
	bh=DGvJtGPnW3uRrdA7yMLuNDJa0iBFaxtRvSFmv4Q4NGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtCuWIF9RpyBBbdRNgDf7Br31EhuwwQ/w/WxLZrErw+e1KG3lx/Rj1FS/hBRxIjneGqFeyud1VJ+5H0Har4HwQj9K3Fno4AJexmQUkeNCvFx6Vv/pVz0Ie095bChjnQ8cWhEJ+DpUd7MhduIaHeYk6O1IwOIhRM4IurDMb11j6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDh3UKRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAA5C4CEEE;
	Wed, 25 Jun 2025 20:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750881845;
	bh=DGvJtGPnW3uRrdA7yMLuNDJa0iBFaxtRvSFmv4Q4NGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uDh3UKRt1k+kn0XNjc14slDLDMnCub+ci+KDbjYcKCsmH8atXz+GkQnU+DyW+B683
	 Z6u8lcE6uLIkf3ZzxZ65QgCTbh1jAY1S65Y5k23OqaN1Wz7m2dFkEtv1mOhsirGOJD
	 bRJP9Oz7lHEVkUgD78rGnF1aRwFa8DX9olfuIVr2d//OIoTpol30aRODfUPKoIY+/Z
	 8+hqSqe6zn8S7bHlKslCEZ9dbB4za8Z20uvxASFx/mYFhWPYoePscGDhBLPXfPem7I
	 3OrMlsRH+kMBRiGsRttV7KoG7TD/En0peb7vyuZE5y40mUnrLiXCdiH9nf3AXruHbK
	 Cc15tjxNMFbGQ==
Date: Wed, 25 Jun 2025 13:04:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, jdamato@fastly.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2 8/8] selftests: drv-net: test RSS Netlink
 notifications
Message-ID: <20250625130404.6c8fa985@kernel.org>
In-Reply-To: <m2sejocfw2.fsf@gmail.com>
References: <20250623231720.3124717-1-kuba@kernel.org>
	<20250623231720.3124717-9-kuba@kernel.org>
	<m2sejocfw2.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 10:46:53 +0100 Donald Hunter wrote:
> > +def _ethtool_create(cfg, act, opts):
> > +    output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
> > +    # Output will be something like: "New RSS context is 1" or
> > +    # "Added rule with ID 7", we want the integer from the end
> > +    return int(output.split()[-1])  
> 
> I think .split() is not required because you can access strings as
> arrays.
> 
> Will this only ever need to handle single digit values?

nosir, IIUC split splits on whitespace, so from:

	"Added rule with ID 7"  -> [.."ID", "7"]
	"Added rule with ID 71" -> [.."ID", "71"]

and we take the last elem, the ID. We use similar code in the rss_ctx
test, I think it works..

Unfortunately there is no plan to migrate the flow steering to netlink.
And ethtool only supports JSON output in the netlink code :S
Mountains of technical debt :)

