Return-Path: <netdev+bounces-52802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4145180040F
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8E91C20E2A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 06:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20B4523F;
	Fri,  1 Dec 2023 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPKCJevK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1EF59529;
	Fri,  1 Dec 2023 06:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2A7C433C7;
	Fri,  1 Dec 2023 06:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701412823;
	bh=nOID4CFf2d2gxuQ4yTAHQXQgTI6oj5aMcFGj7jjKdUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cPKCJevKfvslVRIJ5HQjWfQQhr2Oqu3+LYCMaZKh4UShFDVv2xmkohqiyj/5Pbcqt
	 ilIjSWERb5R/rWtetR1vZghZ91XSU/j149xRjL90uxet37kcKfP5zwNmwfhfowLVKV
	 Y/9FOxeVChwy2+4YjJHCTxauFz/8uu4hoh7q9rQcW9qoQZaZECFy7Fh5IyhxsuAUuQ
	 9cFQJKMGsGoCWzEaQodACWsDJJXYbZkwa+MXh5iQ6M+WZo0hsRIimNOyfBN+gl2PxH
	 kt4WOLx0EAXY78kT7SuilIWZLSDmOBt9MDCREtbExJw7KuLWAoKAlz91W2tjxe71/S
	 01raUSnV7ss2w==
Date: Thu, 30 Nov 2023 22:40:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Alexander Lobakin
 <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for
 lan9303_get_strings()
Message-ID: <20231130224021.41d1d453@kernel.org>
In-Reply-To: <170138159609.3648803.17052375712894034660.b4-ty@chromium.org>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
	<170138159609.3648803.17052375712894034660.b4-ty@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 13:59:58 -0800 Kees Cook wrote:
> Applied to for-next/hardening, thanks!
> 
> [1/1] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
>       https://git.kernel.org/kees/c/f1c7720549bf

Please drop this, it got changes requested on our end because
I figured Alexander's comment is worth addressing.

