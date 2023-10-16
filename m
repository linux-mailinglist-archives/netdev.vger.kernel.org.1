Return-Path: <netdev+bounces-41585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF5F7CB5B8
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9976B2108B
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE8D38DF9;
	Mon, 16 Oct 2023 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUdMzvBy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CBE38BD8
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 21:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2C4C433C7;
	Mon, 16 Oct 2023 21:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697493172;
	bh=XoagB7RssmrdXCC7ca9EuXuf2feY9l34Rct0YBrHnIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EUdMzvBy0CVPhC8fRRYEKHIaC3aEURLSY48+sgoFBvUYurCdlDuZSFv7mYi8xBO/Z
	 1KmuBG7KTNDyUmCWksYynhzY60BFUVYkhIdRqId4m1ffXBru+1tvlFG6AjZ+h08iMi
	 Y+hSklqhJXM6JZgTDHdmlxpQCYBHu5aZD7G+TsB6Sz2z2OcaP7DCuYs46lSZ1iI1Tr
	 NqE5+uBdmP1Gjljoh1bxASoQWyizNoeKmBkhXUIEiyx+IoI2AIGO83+rWCreCmb9l8
	 dl0JbYtfci3Ih5exVyVumt1fjHd8vgGdauXBCoG8/vEtGRu+A3NRO2XGzppfaYl+Fn
	 Lr8mYSxz0h6Jg==
Date: Mon, 16 Oct 2023 14:52:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "egallen@redhat.com" <egallen@redhat.com>, Haseeb Gani <hgani@marvell.com>,
 "mschmidt@redhat.com" <mschmidt@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Sathesh B Edara <sedara@marvell.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Vimlesh Kumar
 <vimleshk@marvell.com>
Subject: Re: [EXT] Re: [net PATCH v2] octeon_ep: update BQL sent bytes
 before ringing doorbell
Message-ID: <20231016145250.68fc1616@kernel.org>
In-Reply-To: <PH0PR18MB473487DDE40F83927FEBDC8CC7D2A@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <PH0PR18MB47342FEB8D57162EE5765E3CC7D3A@PH0PR18MB4734.namprd18.prod.outlook.com>
	<20231012101706.2291551-1-srasheed@marvell.com>
	<20231012170147.5c0e8148@kernel.org>
	<PH0PR18MB473487DDE40F83927FEBDC8CC7D2A@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 09:04:07 +0000 Shinas Rasheed wrote:
> Apologizing for the format errors on my part. Should I send the v2
> patch again separately in a new thread, or will this be enough for
> now to avoid the clutter?

Sorry, I meant to get to this on Friday but run out of hours.

No need to repost, my comments were just for future reference
since you have sent multiple patches already and will likely
send more :)

