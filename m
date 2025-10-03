Return-Path: <netdev+bounces-227727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF7ABB63A3
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 10:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B003BDD00
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99274228CA9;
	Fri,  3 Oct 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjJpwBHQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39A8C1F;
	Fri,  3 Oct 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759479453; cv=none; b=QhUcP8sW6balveo3fXoo3o7TVyqv+iDR/aBF8yKPko1io7eev5FT+sqQ7YZlsBjcjzEOmBu+0j6DPyTQkX7yNjDLoOIiDijoFvHrATZ8GryEgbirWJ28jEybbUImsD5wWKJ/0x0FvPgyrOuVTHgntSu0qelHPwzAY+wUSNqiPmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759479453; c=relaxed/simple;
	bh=iBCFNMMyNV4Rxo6BSgm5yEWsJ3CMCwo7Q9j7QSQ9aHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpr6dXlgEMvequMaLvUtZyf1dBuStvNmEfO8z+sOH2PgHh+i0DrTj4nhaoEQcznF9imhPvEOR+WtjxHW1j0+JoIEg+nZZFp14XMDBTlVaLu6slWvgz7Y0x7oC6dNuWAjSVBdCjmNf9QjzJVAj1Lk4dwYA6HuLbvP8MBONWmbxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjJpwBHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68662C4CEF5;
	Fri,  3 Oct 2025 08:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759479453;
	bh=iBCFNMMyNV4Rxo6BSgm5yEWsJ3CMCwo7Q9j7QSQ9aHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjJpwBHQ2PPJDhnVMXsFpEk2IHhuK+r5fTD8vKh6QR1RhdBOfL2Q2/42gmOsba/Zy
	 lenOkNHG6kMtSVQPCAy0gDup9tND6pSEHPjtYEZ73HT7l1AycJOf8VPheedh1giDME
	 aL4mac2PVFAl4hfwv8gnuRDMvN6BQ9VLjsITFFUtx3a7X6OdTHd5S3/WFxzCrrBKGZ
	 hsXjyfRuGFFRc6EgQjaCxWMX64aJ3+QM+6Kun3X0D60gAmzDdInXj7o8Iof6veLt+t
	 KzD7axWIYvdQkrdIXKyh1xBXgUUk69KW3Rw6217LatiI9TA/ge/mPYwSSoZRI+JVw+
	 Jm9Hki9aebF1w==
Date: Fri, 3 Oct 2025 09:17:29 +0100
From: Simon Horman <horms@kernel.org>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dlink: use dev_kfree_skb_any instead of
 dev_kfree_skb
Message-ID: <20251003081729.GB2878334@horms.kernel.org>
References: <20251003022300.1105-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003022300.1105-1-yyyynoom@gmail.com>

On Fri, Oct 03, 2025 at 11:23:00AM +0900, Yeounsu Moon wrote:
> Replace `dev_kfree_skb()` with `dev_kfree_skb_any()` in `start_xmit()`
> which can be called from hard irq context (netpoll) and from other
> contexts.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
> Tested-on: D-Link DGE-550T Rev-A3

Hi,

I am curious to know why this problem has come up now.
Or more to the point, why it has not come up since the cited commit
was made, 20 years ago.

I am also curious to know how the problem was found.
By inspection? Through testing? Other?

...

