Return-Path: <netdev+bounces-119419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04349558B6
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 17:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8ACFB21134
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D206D7D417;
	Sat, 17 Aug 2024 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V7sXCKsr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CEC8F40;
	Sat, 17 Aug 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723909132; cv=none; b=qWexu8QnUbQYmfT9qBXw8sCM1AH3hIwirpv69WgqWmLTe3MPGky3LHkqsNhI9MtK1xBhRvUd+qTeSYy99MEgxTreB3IyFNKYYUy2U3yacbbHs9JAxaIY7Vqn/ov67XWNPr3Bk8IOqwRyn/YRfuJCLDuo2NlxLqViuF1tPROzIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723909132; c=relaxed/simple;
	bh=5Uj2/LCT4xIeiI7PoyH1kJVm5dMofpNTE/pOQkqqHco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX9T8Nc+ga0VdNQhO36VcxvgKqpGz7Fv+UiDBQSd6x+eoVCKJ9Daotr95dIkee05gpQCNy9lZPPDP/6UK+KODpgNf9XvyWnRyL4RJ7lJtdA6ibv6qyTV6+5+0LEpTEH3YRniM53cbV3XalrRc0fm+kv6Ua60pcW0N5DSBcItNTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V7sXCKsr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dddiX3MU+x7AJwuIy7HkslI+ScPQ1EPrha6bb8Jm4L8=; b=V7sXCKsrIDLSnQ9Qo3NOZGY0hX
	1PMM0g7R7oRe8bPd5kmU0Mn9qInSq+FfbgCFl6nnc3+fE9qfZZDG3C1ZEoKOQBDp03RQ642oiJjpt
	E/DnIC7TWU5YT0MFx5Dp7Vv4XSjyBigJvawjIbbZ4iMIvSqb7ykrHU5FplJneSgmDI84=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sfLVY-0050Gy-T1; Sat, 17 Aug 2024 17:38:24 +0200
Date: Sat, 17 Aug 2024 17:38:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Frank Sae <Frank.Sae@motor-comm.com>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuanlai.cui@motor-comm.com,
	hua.sun@motor-comm.com, xiaoyong.li@motor-comm.com,
	suting.hu@motor-comm.com, jie.han@motor-comm.com
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add driver for Motorcomm
 yt8821 2.5G ethernet phy
Message-ID: <13950b5b-d596-4205-a808-72219e78b158@lunn.ch>
References: <20240816060955.47076-1-Frank.Sae@motor-comm.com>
 <20240816060955.47076-3-Frank.Sae@motor-comm.com>
 <ZsCLMQWoZcVV+7xR@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsCLMQWoZcVV+7xR@shell.armlinux.org.uk>

> Also, it would be nice to have phydev->supported_interfaces populated
> (which has to be done when the PHY is probed) so that phylink knows
> before connecting with the PHY which interface modes are supported by
> the PHY. (Andrew - please can we make this a condition for any new PHYs
> supported by phylib in the future?)

O.K i will add it to my mental checklist.

	Andrew

