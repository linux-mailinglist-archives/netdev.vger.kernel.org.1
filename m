Return-Path: <netdev+bounces-47856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB2E7EB92A
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 23:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0E3B20912
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB402E82A;
	Tue, 14 Nov 2023 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoqU4DaU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C952E821
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 22:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57876C433C8;
	Tue, 14 Nov 2023 22:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699999799;
	bh=DnWTo6FpqVWKC3zytTTU/5aOouys1eDiIwq/Iah5HMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uoqU4DaUOfRIXk3+JqeO9u9dluJ2NOomuxsEMkaRKTVGj+1h4kjyta8wev3xfPMj4
	 E3t6B7k5jDtRfcosv7BzhcjRivjcvpPX8VeCyytRM6EY7Obb878WGwgLumG22a758b
	 +lXISUeUAzL7lDK/KLzntJzfmXpTfBP1TGj79ngY6ptUkTybNNOKiGD5LpsDJPGAcf
	 FvCmXGH0AQg1nZLwqPMNx+pv8xu9AjaPdkXmg96SK2iBm8ZLiE/tsXC9Je94YCF+Z/
	 aZJL0nqYBAWtWFhoB8JFaTnq5uKqrChLm68dbdWFSXoFi2dr68jiaYRO6zqNMAKDIf
	 YG0We6tElENQQ==
Date: Tue, 14 Nov 2023 17:09:56 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH net v2] ravb: Fix races between ravb_tx_timeout_work()
 and net related ops
Message-ID: <20231114170956.7bddff5b@kernel.org>
In-Reply-To: <TYBPR01MB534172F049F8072E3F77AC25D8B2A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231019113308.1133944-1-yoshihiro.shimoda.uh@renesas.com>
	<TYBPR01MB534172F049F8072E3F77AC25D8B2A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 08:52:29 +0000 Yoshihiro Shimoda wrote:
> Gentle ping. I confirmed that I could apply this patch on
> the latest net.git / main branch.

At a glance the suggestion from Sergei makes sense.
You need to reply to him.

