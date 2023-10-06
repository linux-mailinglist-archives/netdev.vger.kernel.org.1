Return-Path: <netdev+bounces-38603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5C87BBA2F
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99631C209AC
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00905266BC;
	Fri,  6 Oct 2023 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFSZ0Snm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9393C157
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 14:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FA0C433C8;
	Fri,  6 Oct 2023 14:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696602375;
	bh=HeJt1ypgXjuNt6xsHJELoxplYIVXB8WYLchsi/6sW6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sFSZ0SnmSt3PzAwq+R36W2yRhX5h4mxS94LXVggXe39rWkSZVM9r1XmNQEHQG0IMQ
	 nI9Dz7oHFVGPNY7CAw+f3tdJ7JLTp+jRlp7sY20i1rdtMHUKE+ub6kWI1dSHB6EbSM
	 laAK+dB/aCsOtseu5+aNxqdyd+mTdIwWiG7BAtpY0couefipNz6aZLMU70/N2MnokS
	 748yL8stY62k5zgoOPW0/InhyIOMELvvl5Eda8pkrHKp0rWmf3xg+UbV8vbDx9j7rf
	 /6nsPVyEXfnV6OEu6Evn6lo801QWXUuiKZuPG4vbCJiTVXLdl49OTY8SEEtslBuu9V
	 GhC2IK48U8M4g==
Date: Fri, 6 Oct 2023 07:26:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] net: cpmac: remove driver to prepare
 for platform removal
Message-ID: <20231006072614.33f68e2f@kernel.org>
In-Reply-To: <20230922061530.3121-6-wsa+renesas@sang-engineering.com>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
	<20230922061530.3121-6-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Sep 2023 08:15:26 +0200 Wolfram Sang wrote:
> AR7 is going to be removed from the Kernel, so remove its networking
> support in form of the cpmac driver. This allows us to remove the
> platform because this driver includes a platform specific header.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to net-next (98bdeae9502b), thanks!

