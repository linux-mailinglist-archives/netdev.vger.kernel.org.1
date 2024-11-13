Return-Path: <netdev+bounces-144281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06939C6706
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 03:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E121F22238
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72BE42A91;
	Wed, 13 Nov 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brBwWDNV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8269A22081
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463325; cv=none; b=GzdYpUfb3c3RAgh1AbXd4ut3nufHQs5uJYxtqIi/zyy6+W0E62KpxOBCEii8qf+JIGq4jIumfVjKSG9soE/dqLAk1dhmDkNPaFq6nJ52zFrZzScwOy/fUon+sWUHUHs9yWZpR/tgWTwW3KkS8DOhBoZzEW7I3p5Abqqe/Jk7y8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463325; c=relaxed/simple;
	bh=Ccj/sftJI+jCz7TIn1xy2GhHA1TGP8Ab/BXDPPUhX84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hr3gxQJ9ARH0je8IS5bWsFUn3gr8LOZ7eDqpVKfBdm0WTO2zkcCr/oB50k8eTv1nYz24ZFT5L+yuiokztYE5QdUpt5lf5G457QaSc9TdZr3j0fKMnZ5CBxLXcU+xjMKMNuOZqTH/kfaxlcfsDWZ+u0M4olBbD6gwotP2T1pLznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brBwWDNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAD7C4CECD;
	Wed, 13 Nov 2024 02:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731463324;
	bh=Ccj/sftJI+jCz7TIn1xy2GhHA1TGP8Ab/BXDPPUhX84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=brBwWDNVS67i0zBVgccKcK+zNMlNTg8YPZtQZJZN5IXytbKXfHv9Jc8hce9bOZ+ZR
	 fWRh5hJSGJ4PrrxSQVfGZ1GnSGn7LBMmi2PcnW7nwgqCOnLE7xsr9YYaFVFytKYShd
	 p00hH5w4aL0PDYfBHkBMbzs3eWMijj+ub3uIpJiGejc6Kj16xRq8PWrSsePR0YoPt+
	 X94rxuyUvVzw9m6XZWjku4SiHo2FSTCkuJ5w0aAxZGxUkcUo/6Qwhm540c8sOnyTtk
	 lw/F1rNp8tiR+DTaLRcPld4zzNa0xPHsIbZYJMiQ5B/ISA5+e5BYMnVWX8pCixQ5cf
	 XUltLyeDMvCjw==
Date: Tue, 12 Nov 2024 18:02:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ecree.xilinx@gmail.com, jdamato@fastly.com, davem@davemloft.net,
 mkubecek@suse.cz, martin.lau@linux.dev, netdev@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH ethtool-next v3] rxclass: Make output for RSS context
 action explicit
Message-ID: <20241112180203.42d34eb7@kernel.org>
In-Reply-To: <e9de21b76807da310658dbfd46d6177c1c592fe7.1731462244.git.dxu@dxuuu.xyz>
References: <e9de21b76807da310658dbfd46d6177c1c592fe7.1731462244.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 18:45:43 -0700 Daniel Xu wrote:
>     # ./ethtool -n eth0 rule 0
>     Filter: 0
>             Rule Type: Raw IPv6
>             Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>             Dest IP addr: <redacted> mask: ::
>             Traffic Class: 0x0 mask: 0xff
>             Protocol: 0 mask: 0xff
>             L4 bytes: 0x0 mask: 0xffffffff
>             Action: Direct to RSS context id 1

Acked-by: Jakub Kicinski <kuba@kernel.org>

