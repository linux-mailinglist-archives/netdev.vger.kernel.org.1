Return-Path: <netdev+bounces-226220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09358B9E33C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81B1382A5F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A663728134F;
	Thu, 25 Sep 2025 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDLWvDDh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60027F727;
	Thu, 25 Sep 2025 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791354; cv=none; b=n/M3EK2wFUavS+hqTnd43x0cNsiUx4+YllGW9pPMzBR6BloSruSDsGjEsr21a9vgDIg8aZgZNQt058yDiAHUCAq8XHTc2TPFDwz9FUSPdL2fFstV1pHulhM+3x+RYyQZar/jX3KEHlTxNm5QikH+6iriGRaEVylHCGwLfHgURP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791354; c=relaxed/simple;
	bh=vx1+GVmdGAh7G1XlskSjRpo8G1f7QPkX7IN4Zaeb/78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5nhuq7nybdrJkkxxY0eP8HVbfJwRmaImtbpMcm8FohL8U8Mu0tQB4ndq2mikO/QwdocUlhZ4iT8HOAtun/nIACraKyz1GlZbG7gXyAO5JlOP27UY05qfwl0Qy0R6++8XtmmvqxhOF3F4RQ64oTWbYjH2GjxH4YI6spsvHHHLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDLWvDDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382C8C116D0;
	Thu, 25 Sep 2025 09:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758791354;
	bh=vx1+GVmdGAh7G1XlskSjRpo8G1f7QPkX7IN4Zaeb/78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDLWvDDhUCMHnXbsNfOpfG6mEWQKloTWo9MC37mAs4WC4M0kZkQwhEr1+gnZnwszy
	 6i1ZXXihtAp6KDCp57Xcd+yYJqjftudrem82THA5bAmihHRV4S9DD6ByQoDD4bkFcf
	 pIFmxMywD82jNR3s3YD4dkviTg/zKi9b3vruKeNimLL64zqq9qFoagVG3KgU+md4AJ
	 sWaOCcgLpGl+sEaCoUnJ7myAWTxXtGHnFNWzevswpuQ2PcQtZeQxy7wwKcp0/k1pTW
	 2NCj6uvlt3IvUIyoBvaHWYQ0nbM88XCexDTO77kE48y/JSKggIh/04JhOskO9VR/2E
	 /Yh1u7Dv9s/hw==
Date: Thu, 25 Sep 2025 10:09:10 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: dns_resolver: Move dns_query()
 explanation out of code block
Message-ID: <20250925090910.GZ836419@horms.kernel.org>
References: <20250924020626.17073-1-bagasdotme@gmail.com>
 <20250924020626.17073-3-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924020626.17073-3-bagasdotme@gmail.com>

On Wed, Sep 24, 2025 at 09:06:24AM +0700, Bagas Sanjaya wrote:
> Documentation for dns_query() is placed in the function's literal code
> block snippet instead. Move it out of there.
> 
> Fixes: 9dfe1361261b ("docs: networking: convert dns_resolver.txt to ReST")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

