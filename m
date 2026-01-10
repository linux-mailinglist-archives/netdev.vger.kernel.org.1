Return-Path: <netdev+bounces-248754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D35BBD0DEAD
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39F6E302F6AF
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF917221F12;
	Sat, 10 Jan 2026 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw4xxi2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854791FBEB0;
	Sat, 10 Jan 2026 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768085384; cv=none; b=ptR00W1aFTHtZcu4iiPYvq+EOdxRcwkNKoIDEjo+vTJElNpBclRQHvQKy5/+WhCgaOsCCFbPIF7cDdTte+d7KbET1pj9y2mZ/5wtnRSfgfKet7hJWWWH3WLXcNmc2K/4QgI9pnS3esqjWZlxDNCzPF4MLZxyRR2YVabSIlqJ5gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768085384; c=relaxed/simple;
	bh=6iIGBl4TWZ8+sk8kYV6QvyRovKffZosUoLSoSCj3b60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoohJkMzupeiRkUuhvG7loq8Ty1+raPmPBS41avxrFPCMjbmI1V0Ab3RZgjOY1o5tlQRZfSN/yQ0ZZRUMJ4D1HqHN850STYtsWoRJW5gXwBCO76ymL4LEM00w5P8C7/3pnCEbTUGTmD80aYhIvpCpiY1oWeJS5xJnbHxcYnVs1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw4xxi2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7A8C4CEF1;
	Sat, 10 Jan 2026 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768085384;
	bh=6iIGBl4TWZ8+sk8kYV6QvyRovKffZosUoLSoSCj3b60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aw4xxi2VM183EiE+vOiLtPLfO+p83W4Ct8uMicG5g6CM7Y3nixSo7DoHh2RD3ZU8+
	 NCG9Ok1Hd6V2MA2U2gkcBIaUuSPRk6Z91EhCTP0uhzLeqpLN1fE+pi69e+rBY73yZ3
	 jjZuf50mCISNUr2dL8BC0sqgWnO41b4GmbnFTy5twvprwYvtfp0ebgy0acdSM5sYSu
	 Ek+62JF0/zbVm4hyKwGRVWOIYFS65b6h1IEP2CMC8GSb0CFFjvm6Qr4oxxjv4Ktk7W
	 tFGYmrDRvD/bmzUuj+pfuQ/vYxaUaFFNnVwXX9xweRL9bsIwOzgVKZ8+cVJIuUfs7z
	 YUtOwIRsizUJA==
Date: Sat, 10 Jan 2026 14:49:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v3 00/10] Switch support
Message-ID: <20260110144942.010076a0@kernel.org>
In-Reply-To: <20260109103035.2972893-1-rkannoth@marvell.com>
References: <20260109103035.2972893-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 16:00:25 +0530 Ratheesh Kannoth wrote:
> Subject: [PATCH net-next v3 00/10] Switch support

The 15 patch limit applies to all your outstanding submissions.
It does not mean that you can submit 2 13 patch series at the same time.
I'm dropping this from patchwork.

I pointed out the tools to run to validate your patches. You are
at v3 and apparently still there are trivial code linting warnings.
The patch limit is to motivate people to run the linters locally
instead of bombarding the list with patches that don't even build.
-- 
pw-bot: defer

