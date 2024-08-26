Return-Path: <netdev+bounces-121976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823F795F742
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4F5282D6F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD7197A95;
	Mon, 26 Aug 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQJPxk9V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07881194AEB;
	Mon, 26 Aug 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691542; cv=none; b=ZdlsSd8LqP6v/YifNsmgB7bd7Wq/7zZCCfBiCTQmXKQgqyrR+wQ2VdzN1bnC5U+SGaGen8ml9EdeZReREtpJryMDOjiM8lsZ6yHSr0kkj2x3OSF90yWfMQL7cscRZb4RYzeS3U/xhF9yRzv7DmO/EQRde+8wZKuw5opTT9iTtEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691542; c=relaxed/simple;
	bh=MsRmBzsqatymuoxmA8JB9Szhb0A1DgmeDXe2YwQ+ECc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqtFbRPPE+x1Kbcs6iT71b46azipVWOD3L90SIDJQK47HNlCOq8dXfqY7YnJXk3a9qvSAheixcSquvxWoT9+21XkBbS2jOtv+TldEBhXknqTav2pr1IN5PB4EEX68iL6pjkM/VWa38uDO+2R9HCPXAhdRNdlQOPADk4mAW1xaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQJPxk9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4878FC4FF1A;
	Mon, 26 Aug 2024 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724691541;
	bh=MsRmBzsqatymuoxmA8JB9Szhb0A1DgmeDXe2YwQ+ECc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CQJPxk9VuIxeG5ijvAZHounJqXhKvpDb9c3IrRAI3NM0f1cAII8XSb+U/FubWfTjf
	 GSqkgimFSy1pzEq/S57Ghh0qVBKdpeCBJR7gaV/qtCuHDaApAAEziYygmnZupRygO+
	 1QCSzAF5OOoFFsCcGityuqt5+3puUw9Acpq2+67VzOdJ2aCOxzheHM/HoezPiv6z8M
	 YzyAJKGYyzMPjCHj8wmpk2NpJGl7TJCGi07mZjKP2gSoYJK/YE4QjfWqBK8Pc7XGUX
	 01sdTnBBD2qtRJHIgiOmaaalBsoQzZRW0aeFcJ5IM7NiZNcPQfbbRYMlgFMMa4G+MY
	 fRllQkvgqUcWw==
Date: Mon, 26 Aug 2024 09:59:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 o.rempel@pengutronix.de
Subject: Re: [PATCHv3 net-next] net: ag71xx: get reset control using devm
 api
Message-ID: <20240826095900.0f8f8c89@kernel.org>
In-Reply-To: <20240824181908.122369-1-rosenp@gmail.com>
References: <20240824181908.122369-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 11:18:56 -0700 Rosen Penev wrote:
> -	struct reset_control *mdio_reset;
>  	struct clk *clk_mdio;
>  };

If you send multiple patches which depend on each other they must be
part of one series. I'll apply the clk_eth patch shortly but you gotta
resend this one, our CI couldn't apply and test it.
-- 
pw-bot: cr

