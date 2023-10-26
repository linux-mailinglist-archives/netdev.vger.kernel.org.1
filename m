Return-Path: <netdev+bounces-44564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2617D8AE3
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 23:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEBF1C20EC4
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 21:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884493D990;
	Thu, 26 Oct 2023 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toS75VrT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D63D989
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 21:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC67C433C7;
	Thu, 26 Oct 2023 21:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698357138;
	bh=Ar47rK4VoU9HotPJMrv49W+xY9ALyh8WYdwKhKQgUjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=toS75VrT71cikMeUq+SfNasbWtSG1FISHYIJFDSUO0ISgit075mYCrh1WTa96gqPk
	 B4Ho5FKtAF9MAaCg9k9C4EFXLyF6ncBFhU9Mt2qYJNLwAF1ftJPxlHjLqQi4qpuYTm
	 Qee57m3AjAjykTLJfW+C0S85VION5dk47IDxHcwPM8jsnAZ4EIdjPp0KMdcnHUr1jN
	 H1Gjou0ILvGoQZANolOE1wDuky0MwqaK+OtnnlcijosFr061irIm8KNpwIFIimabRH
	 DIxjo7PAf2Hb67ywTo4VIEPMnQCz3ZeXdZ1THQFQykeZKZ/F6arfAU99Iu0Amo3ocy
	 6qOjLI9h9hZSw==
Date: Thu, 26 Oct 2023 14:52:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>, Geethasowjanya Akula <gakula@marvell.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>, Hariprasad Kelam
 <hkelam@marvell.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>
Subject: Re: [EXT] Re: [PATCH net] octeontx2-pf: Fix holes in error code
Message-ID: <20231026145217.4b840baa@kernel.org>
In-Reply-To: <0d1cb5d7-53e8-45bd-ad45-48fae64b8d9c@intel.com>
References: <20231026030154.1317011-1-rkannoth@marvell.com>
	<5819e6c8-d887-40ca-9791-07c733126e64@intel.com>
	<MWHPR1801MB1918043F69F45C9D69656449D3DDA@MWHPR1801MB1918.namprd18.prod.outlook.com>
	<0d1cb5d7-53e8-45bd-ad45-48fae64b8d9c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 12:56:26 +0200 Wojciech Drewek wrote:
> I'd add to the commit msg that some error values were wrong and it it
> was fixed, but it's a nit.

Agreed, it should be explained in the commit message.
Borderline it deserves to be a separate fix.
-- 
pw-bot: cr

