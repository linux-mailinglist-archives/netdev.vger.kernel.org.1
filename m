Return-Path: <netdev+bounces-128003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A65A977757
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD1D1C20A8A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400F51779A5;
	Fri, 13 Sep 2024 03:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4eMzv3Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AD814B092;
	Fri, 13 Sep 2024 03:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726198046; cv=none; b=eh3RG6lfED5taQXETJRYPDcxfiZuBEQCpeGTqvRJNlgrTlkG/QiZkj0QBzLnDTsljuinAIm2cQolare4jRY5ErIBjwAdExppKB8JAXEf/7EbfjQchcUWG7f8CQUGn07R4tDz8HZNqRQ6xmtxtQgvUkQCBvpXIv99D5p4jTnV0uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726198046; c=relaxed/simple;
	bh=xa9tUHzs31GSerzTQVMOiGNkX22hy7JPxtXLEUAGl9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BK9vPgY/7t25iCx+NhUaemTX2z/di6Roi/WdMWu8vqxCW9itAZxy4T6c04kDW3d2awFR62oBRKWGGkYgN5mvpoC/dzdLdz33PqUZuaifofsHuQUubXkhwA9toliAEwcMHD5qt0Mu0vF4dA253Bah+C6Cx96uSTelTzsYFIaRKFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4eMzv3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19606C4CEC3;
	Fri, 13 Sep 2024 03:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726198045;
	bh=xa9tUHzs31GSerzTQVMOiGNkX22hy7JPxtXLEUAGl9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e4eMzv3QZD1rtg/YX7cyfy59qIyevEo5rixl6/Ug9khulUzuD0P7D9/w7XE8CFhNF
	 NPWklv4Mi9Ys92EAww+ROK/O5Ch5S8OIwgh7H9d50+/zbpCnuwVp+KWtpoOmxeWLtb
	 kz5JQ4xLVIdClr72JvQBzvzQGAH70/DsMD84DOwANK4vN7OvnxMe3hFvqXMMkdRD2a
	 E+5Me+dW3uRIV/XCxJFQjIk5EUB4ziDap0DT2ITXiRMWb2VjjAuaD9Kr0H+ef2ZQje
	 iJAJutv5CJdzESqiaLZUJF7jPxk4+Rfi98FrVRDEzsq7XpEcFum1SJhc0AJq2arhD3
	 19CS0MtBOA5ow==
Date: Thu, 12 Sep 2024 20:27:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Qianqiang Liu <qianqiang.liu@163.com>, Chris
 Snook <chris.snook@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 kernel@collabora.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: ag71xx: Remove dead code
Message-ID: <20240912202724.10ce9c29@kernel.org>
In-Reply-To: <20240912174222.6de55d16@kernel.org>
References: <20240911135828.378317-1-usama.anjum@collabora.com>
	<ZuHfcDLty0IULwdY@pengutronix.de>
	<CANn89i+xYSEw0OX_33=+R0uTPCRgH+kWMEVsjh=ec2ZHMPsKEw@mail.gmail.com>
	<20240912174222.6de55d16@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 17:42:22 -0700 Jakub Kicinski wrote:
> On Thu, 12 Sep 2024 17:56:11 +0200 Eric Dumazet wrote:
> > I do not see any credits given to  Qianqiang Liu, who is desperate to get his
> > first linux patch...
> > 
> > https://lore.kernel.org/netdev/20240910152254.21238-1-qianqiang.liu@163.com/  
> 
> Right, odd, is there a reason you took over from Qianqiang Liu?
> Otherwise I'd prefer if they could send the next version.
> Last thing we need is arguments about ownership of trivial
> patches.
> 
> This v2 has an unnecessary Fixes tag, this is not a fix.

Oh, I guess it may be a v2 of your own change:

https://lore.kernel.org/all/20240911105924.4028423-1-usama.anjum@collabora.com/

Are you both using the same tool? 5 year old code and suddenly we get
the same fix two times.

