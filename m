Return-Path: <netdev+bounces-42332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A507CE558
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3591C20A99
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924C03FB3D;
	Wed, 18 Oct 2023 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQvQZrbm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A73C072
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 17:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5B0C433C7;
	Wed, 18 Oct 2023 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697651557;
	bh=pEMo/s1CYzAXTPRWhiJJZWc3Q7TNy0usITMHoUHBgzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fQvQZrbmuIBukMHt5kZ5fRWijKo2QPDyG6ixF8pVw3gBvDoUySHEd05VlWGIOJ+XW
	 T3mnsgcSOG4K9qW5O+gb7T3tOmbUIBI+LG9JDcEciLFuy5aOQ1J1JX/v5xvquShwvl
	 nbsJaphSqgUan5oKQtIBW8lfBwR2PvrcLTybLza5hYH0D+TTykjcrAtMn7TIu0E7Dw
	 jWry0UXDwiX9quGh+KuG8+JgiegQGLkjATFMAYz5OpbQEIdcwQR9RMJ0+aPB4UaV2N
	 vZBm27pASprqFHXvc7iU3PWVLl2nTcm7YCbe24ZVaKZLNRa/Qp6NUzKysbKgv3vZqu
	 qvm/t3EgiCgbA==
Date: Wed, 18 Oct 2023 10:52:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Ravi Gunasekaran <r-gunasekaran@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <rogerq@ti.com>, <andrew@lunn.ch>,
 <f.fainelli@gmail.com>, <horms@kernel.org>, <linux-omap@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
 Thejasvi Konduru <t-konduru@ti.com>,
 <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: Fix the
 revision string for J721E
Message-ID: <20231018105236.347b2354@kernel.org>
In-Reply-To: <20231018154448.vlunpwbw67xeh4rj@unfasten>
References: <20231018140009.1725-1-r-gunasekaran@ti.com>
	<20231018154448.vlunpwbw67xeh4rj@unfasten>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 10:44:48 -0500 Nishanth Menon wrote:
> A) netdev maintainers could provide me an rc1 based immutable tag

FWIW that shouldn't be a problem, assuming my script to do so didn't
bit rot :)

Does it really have to be rc1 or something more recent would work?

