Return-Path: <netdev+bounces-47149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DE67E8407
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F3A1C20A69
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B6E3B7BE;
	Fri, 10 Nov 2023 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uvtc7Fii"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E9A3B7B8;
	Fri, 10 Nov 2023 20:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F339AC433CA;
	Fri, 10 Nov 2023 20:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699648699;
	bh=J1TZwWLV6yVUWyO4na8dwzHU+ynkMEAL64DX0dAmeh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uvtc7Fii7WXfVbIntIp/wTtuIOsUbWE+DR3tmNidcRa7XV3midH1Hd+dIrVPTPFhu
	 JUWImKrzO+a77mobGWCkG7rrH+DfWsdoBhMOzyR1o67Mi/eNLK08S7Bo/EkWHyV4HZ
	 nh6ywkRicisAHPEs/TYs7MEoGBrj/abMBK2agQmjkdPJcnxBW0C5K2pUuxENgNlG0J
	 d0AC+/Ouzbguv330LyCH50DL+tyHPUeCRnIeLMkmb6V1d1B48R2Tmn+4LxOc20/LeM
	 At0WaKq7t1cAHsbSO2g4zhmCVpMmG/NMoR07AMsr0ycHCcGts9ZsP1XwEryQcnYPox
	 CBcvD/Nu4Birw==
Date: Fri, 10 Nov 2023 12:38:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 fancer.lancer@gmail.com, Jose.Abreu@synopsys.com, chenhuacai@loongson.cn,
 linux@armlinux.org.uk, dongbiao@loongson.cn, guyinggang@loongson.cn,
 loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
 loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v5 0/9] stmmac: Add Loongson platform support
Message-ID: <20231110123817.25099f26@kernel.org>
In-Reply-To: <cover.1699533745.git.siyanteng@loongson.cn>
References: <cover.1699533745.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 17:08:44 +0800 Yanteng Si wrote:
> v4: <https://lore.kernel.org/loongarch/cover.1692696115.git.chenfeiyang@loongson.cn/>
> v3: <https://lore.kernel.org/loongarch/cover.1691047285.git.chenfeiyang@loongson.cn/>
> v2: <https://lore.kernel.org/loongarch/cover.1690439335.git.chenfeiyang@loongson.cn/>
> v1: <https://lore.kernel.org/loongarch/cover.1689215889.git.chenfeiyang@loongson.cn/>

## Form letter - net-next-closed

The merge window for v6.7 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Nov 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

