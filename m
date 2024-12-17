Return-Path: <netdev+bounces-152626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9AE9F4ED3
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D2D188B4EC
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80921F5421;
	Tue, 17 Dec 2024 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ1A4wbT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FB1E8855;
	Tue, 17 Dec 2024 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447793; cv=none; b=ptvUxAhu5u/V8BoX6wRamSJjUAIGsZTVuYafe1lTw7nB2WAt14OjV131pHu79D6h+bTcPyQtmNPzPyzuNJ//sDSMpvamvQAMp+jP1YOD38SQisQ6qplrqQEQhufRMjQ6y3KToMpOA+hXMOM4tVNrzGAXBypDKQgkEQm5HJyJe6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447793; c=relaxed/simple;
	bh=YjeHqn7JMtfcLWDTg6uquZsAt1ZAnNU7dpzXtPwL3Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHuu4yQZrPmNLFZeg8TAGqWK70ZnwO2mKBE3oh3RAWNfTJ+N4j5CRJkFApHAIuJcEYnksuv93noCvcKyOsqs8Mteu3ZGy+SaatPFaaJdut7pfrJOxh23cuo0pl1Ys7Rcc4WB1o5eEr+GNCbiNQFOfhEohBooTqW8ylzIquh/N5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ1A4wbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BEAC4CED3;
	Tue, 17 Dec 2024 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447793;
	bh=YjeHqn7JMtfcLWDTg6uquZsAt1ZAnNU7dpzXtPwL3Bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LQ1A4wbT7Za8PMBkb2n0TW8RJgkLNHJyjeMBcxKz4/BAFYHasK/wq/dX13CXaA8Po
	 ypnLkzDSAWvf22W6cDWBRuBhroWVmLtxBNYCnAkekcoL2XdezusefarDo/T9e+qzcZ
	 im9bKLadYyve4wMneVjwb+vgeuwi0NkJUErvi1WHAqUsUB69PDozBlY7ZHOG4ojTBW
	 V4DzN18bPriFEU8PYozLF6hOqZhojdf+x1dcCWiAmXJDsErIrovtvrbdvW8kRYPKhC
	 /teFWbk/a3pQ0ryt7PsXOmzC/AY8Q0qzCVL17kCA2IZgzr7vb1D/IPhpXirhQgkEwv
	 qm3kfiEE0+JNA==
Date: Tue, 17 Dec 2024 07:03:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: Move callback comments from
 struct to kernel-doc section
Message-ID: <20241217070311.1c867d32@kernel.org>
In-Reply-To: <Z2EO45xuUkzlw-Uy@pengutronix.de>
References: <20241206113952.406311-1-o.rempel@pengutronix.de>
	<e6a812ba-b7ea-4f8a-8bdd-1306921c318f@redhat.com>
	<Z1hJ4Wopr_4BJzan@shell.armlinux.org.uk>
	<20241210063704.09c0ac8a@kernel.org>
	<Z2AbBilPf2JRXNzH@pengutronix.de>
	<20241216175316.6df45645@kernel.org>
	<Z2EO45xuUkzlw-Uy@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 06:40:51 +0100 Oleksij Rempel wrote:
> > > Please rephrase, I do not understand.
> > > 
> > > Should I resend this patch with corrected "Return:" description, or
> > > continue with inlined comments withing the struct and drop this patch?  
> > 
> > I'm not talking about Returns, I'm talking about the core idea of
> > the patch. The duplicate definitions seem odd, can we teach kernel-doc
> > to understand function args instead? Most obvious format which comes 
> > to mind:
> > 
> > 	* ...
> > 	* @config_init - Initialize the PHY, including after a reset.
> > 	* @config_init.phydev: The PHY device to initialize.
> > 	*
> > 	* Returns: 0 on success or a negative error code on failure.
> > 	* ...  
> 
> It will be too many side quests to me for now. I can streamline comments
> if there is agreement how it should look like. But fixing kdoc - I would leave
> it to the experts.
> 
> What do you prefer, proceed with stats patch without fixing comments or
> fix comment without fixing kdoc?

The former. And you're using the word "fix" very loosely here, IMHO.

