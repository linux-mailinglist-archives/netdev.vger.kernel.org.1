Return-Path: <netdev+bounces-56642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCC680FB46
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615671C20D6A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9266472E;
	Tue, 12 Dec 2023 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtEAI2K9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4291A660E3
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 23:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B611C433C7;
	Tue, 12 Dec 2023 23:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702423428;
	bh=KwRraPl+S6WmazlLNqOJ7U472XTL+/fDGulYB+j/FLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BtEAI2K97P4K3o2dTr9wLUIpp5Fd7FshRQzuKgCImTlqG7pISseimEd/dyIWmN3qp
	 SnyunpjfhBl978TWs57HDJf0wyhZzAXq8wqNdH077Mn7Xggx602NtRwtwQy/zJg4DY
	 eFaW0MNfUc/KBzIzvV4qCGdQeYvtdlDWKLEYQbOvCFtkE8FvTYRWI4JzkmatZ+FFsl
	 JUxq1BBpkAz2IY5Mm1txEtBKcnbRe0TxQ3IwK7wCBdBw98vmA2k14p47ymK2nXSegA
	 wVMaU8WlhtppPwey/4s66Hh46QeWbd1UMIBFEBEoID0J2h0e7346dii8RGNyhib6WQ
	 EX5BxvpaWIdDw==
Date: Tue, 12 Dec 2023 15:23:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <Jose.Abreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, James Li <James.Li1@synopsys.com>,
 Martin McKenny <Martin.McKenny@synopsys.com>, "open list:STMMAC ETHERNET
 DRIVER" <netdev@vger.kernel.org>, "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>, "moderated list:ARM/STM32
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Message-ID: <20231212152347.167007f3@kernel.org>
In-Reply-To: <CY5PR12MB63727C24923AE855CFF0D425BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com>
References: <CY5PR12MB63727C24923AE855CFF0D425BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 14:05:02 +0000 Jianheng Zhang wrote:
> Adds the HW specific support for Frame Preemption handshaking on XGMAC3+
> cores.
> 
> Signed-off-by: Jianheng Zhang <Jianheng.Zhang@synopsys.com>

I defer to Vladimir on whether to trust that the follow up with
the ethtool API support will come later (and not require rewrite
of existing code); or we should request that it's part of the same
series.
-- 
pw-bot: needs-ack

