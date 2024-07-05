Return-Path: <netdev+bounces-109341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A29928055
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 04:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3726AB24875
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 02:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D25171B0;
	Fri,  5 Jul 2024 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InxUReRC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0F26AD3;
	Fri,  5 Jul 2024 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146036; cv=none; b=WIkYFqCIM6JHslI4V7q567TgA5CCuNm2HPiO7OIX1r/x+5/bVdblVSXl1i3pXKwx/LTVZFvORVGqGPuOV+7D/XACrRBWV77rFZK8V9ndbsUh7e4iT91BdzM6gfMMALyM/EXCE2UZ0c8mCY+rItcuqbJDKipFVdWsMcnLFjC/Wjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146036; c=relaxed/simple;
	bh=tvLRJDCk+E1jX++mHsoM7UErsMPtSUXq6zUTe386MfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bphbESBPBdF/G1s5xoWCMQaIwL0cDqmAf28uqueujJ/MJPZPw7I1t7RPovleTZdaxyyxNP31LWArk11VN2b2jwQsV56xy+qDP9g88k9zrJc3G6PF3Qp8apoxjrEnA4ktQNgCa7G0Dc460MfLapC9uYw5o9zPs7wipH+r/o92yEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InxUReRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0CCC3277B;
	Fri,  5 Jul 2024 02:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720146036;
	bh=tvLRJDCk+E1jX++mHsoM7UErsMPtSUXq6zUTe386MfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=InxUReRCjF5pntZkgg/36WwAcHOj+59o2648G31tqAqh9cjxrnzQ5ydgi8+i1svMN
	 /ShHuNnoj0Alq+ZXLbK4swQeqDp3UvWUoIrGOUO1FaDM76Ytqnw1E+mv+B720MLxb9
	 aHbvEFXRwLncQFMHFJhWj0gAxpPOkJYICIWmrw0eWYmhQ0X7IF32NvepwsJvKTrzC2
	 rV6SUdFN94zZ0+5OwUBrrwWzg3aoi+GUb1wRjRwXI103S5BWF0iY5y112UxFeJai7B
	 KwvIzg0xazESknu4JvNrlWMXVxSuJg4gruyX71v9zqVUVRgCDp6bpHDN7bbDta2Ub4
	 0geq6BhoKZKSw==
Date: Thu, 4 Jul 2024 19:20:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Eggers <ceggers@arri.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Juergen Beisert <jbe@pengutronix.de>, Stefan Roese
 <sr@denx.de>, Juergen Borleis <kernel@pengutronix.de>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] dsa: lan9303: consistent naming for PHY address
 parameter
Message-ID: <20240704192034.23304ee8@kernel.org>
In-Reply-To: <20240703145718.19951-2-ceggers@arri.de>
References: <20240703145718.19951-1-ceggers@arri.de>
	<20240703145718.19951-2-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 16:57:18 +0200 Christian Eggers wrote:
> Name it 'addr' instead of 'port' or 'phy'.

Unfortunately the fix has narrowly missed today's PR.
Please resend this for net-next in a week+.

