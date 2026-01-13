Return-Path: <netdev+bounces-249299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E02D1687B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41A4D3010E58
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D325393B;
	Tue, 13 Jan 2026 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rC066VBe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2E20F08C
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275693; cv=none; b=j5vlindVNRhJtQ21lNx+tFktt7MwBVvfmZd2FVd5j6fS5k43vgyPO8ktrCeZ7Gpb+cLHA5JdZEbDCXqnXwO86exJBd0WydarIPf/poJWmKwPFCHdt+WaSEst/X8tbpXXR7FA6W/PhredThXnOh03ytn/2Q4CaulTBov2GBVfZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275693; c=relaxed/simple;
	bh=lujyGgYFhKtg6NaigfP+JG0y0rdG/yD3ZHDE9ux/Fxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/bPJBYa1h+6i/DwSIsrmKA2DKrm9Igh2rpXRYxndjPYOaQ5LuBGhomryw06siaKc9/DamfnZa6+Ph/f1tbYSl21vylX9Qc6gk0Ul5UwLNiFLo3VljP7LPJf/gAxfTqUR3xpEWJdsznR1UHCzxhfHqLV/RE4i57+RRuyj/QBhMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rC066VBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A05C116D0;
	Tue, 13 Jan 2026 03:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768275693;
	bh=lujyGgYFhKtg6NaigfP+JG0y0rdG/yD3ZHDE9ux/Fxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rC066VBeI2UKnDYScTJEZSOcIqrwcrAhbQEl5zn2nKk/xA/q3WwhdHEDqReHUb9c9
	 h3P/2XWdoUc6KXUKpY4xl/DFnPPVnLrmqGR5ze3uARv5LH7ZtoUeeFaMfwJhPIAhu3
	 TJIB6h0eL+S8oN0+RSA0yj71Aaj0OYGrW/QcJAKB6hq+wZb7R4nK93ERDRlij9Nna+
	 7NN8tIh1lshbUgo/M2lrNDRukiogSCSvBOxFO7GN4kE0zoXiSSMCqoXzcyqrlsyUHb
	 w8q+MFx1qMCC8FWcslrZ0TJrlJREIhIfKnvOUiZTbQtEl8qwBzrFvVrRnDpm+q/8su
	 kZO9zZZpAM2dQ==
Date: Mon, 12 Jan 2026 19:41:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: remove unused fixup unregistering
 functions
Message-ID: <20260112194131.2d2979b4@kernel.org>
In-Reply-To: <03339a9d-121b-40ce-bc6f-a3000cab6925@gmail.com>
References: <03339a9d-121b-40ce-bc6f-a3000cab6925@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Jan 2026 19:02:06 +0100 Heiner Kallweit wrote:
> No user of PHY fixups unregisters these. IOW: The fixup unregistering
> functions are unused and can be removed.

They seem to be referenced in Documentation/networking/phy.rst
Also would be good to add to the commit msg when they were last used or
if never used - when added (commit hash)
-- 
pw-bot: cr

