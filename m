Return-Path: <netdev+bounces-111497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21F4931631
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8B91F223F1
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2D518E761;
	Mon, 15 Jul 2024 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dShP6U3u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5640F186282
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051793; cv=none; b=eNNHfa8YJKklutj5bqewN2Yyg8mg5dhthZ65jr0YXUP73lOz0w5r12S1DPRDT05rbaK6CkoGHMOu6909Ip5ByG1bc6fgpwds7jVqhIP4vxzUKq/Zc/JogDUPMlLjP/wCjsqeKOGpgMs8BRx02s8jt4wFI+dk3Kqv2oQH48MFQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051793; c=relaxed/simple;
	bh=i8N5RHXd19rYgCW0cURiW3KWrzYbZFXcWaQ0Wcz7VBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEPgW7Uxyq/SDm8482OaYLArOhY5Dsz5gIQHK1Vou6S/rzlLrYsD29MJixrVWoUQBtH82QxR8/uiElHuVha4ngv1wDUtEsQy9uBxWNooAJeFfUFhg2P+qEL6+RQkq3U7cTlQH3alX7M47fUuVjUJaMlVZEP0gSpLNfFKnQ89ecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dShP6U3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A171CC32782;
	Mon, 15 Jul 2024 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721051792;
	bh=i8N5RHXd19rYgCW0cURiW3KWrzYbZFXcWaQ0Wcz7VBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dShP6U3u5H4BQwzN3WolSHZRq0cBiq6YXl3T2nPt5apYLWpbuaLEtt8+NK3hwZ7B6
	 1nkwsM+ND6rZFsrExPpKeChCocESJbk+QJsVKHSDMZEYDGfcN7JIyGUeCcKL2f/7qm
	 hDM07yDtUJqvrKhSEmJLksyi42EJRoz49Q7xCTdG8+VYHNxsqjrweVxla5CeohpQCb
	 d74RBo4A5ZjtbZzmUoVZMkNDjQPxrPWzKi6hDoHwc6w2SpDs/FKyjWcLTD5xYLnmVv
	 jyg0WzC5h56SkJOTTcrZXeGEoqBMglp80Kr/3bw7uGMX5VrGgL9ttJp/2oYR1Qw+D3
	 jRCSgQAJykO3Q==
Date: Mon, 15 Jul 2024 06:56:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/7] pull request (net): ipsec 2024-07-11
Message-ID: <20240715065631.06edc935@kernel.org>
In-Reply-To: <20240711100025.1949454-1-steffen.klassert@secunet.com>
References: <20240711100025.1949454-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 12:00:18 +0200 Steffen Klassert wrote:
> Please pull or let me know if there are problems.

There are problems.. with the pw-bot, it seems.
So replying manually - applied, thanks! :)

