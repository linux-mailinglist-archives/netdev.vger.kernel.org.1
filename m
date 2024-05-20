Return-Path: <netdev+bounces-97229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0C08CA2E4
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 21:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28451F22554
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 19:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DA01386CC;
	Mon, 20 May 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc1Cmh1d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217618C06;
	Mon, 20 May 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234631; cv=none; b=c6o2sUxpMOn3AuJX2uQSnnKP0vrs9y3+Zh+CDP5XwOS13H4aqUxHZuv3aYGBLvay+VOHneg5PImAC0wWrmA1n2zmVTCEL0llAlL8FcdhXPkKM/2jPfew7JeycSFt20vXIJpfw37sw314aF/IWEr4kd8wy67fB5YRqV2LOCN+pkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234631; c=relaxed/simple;
	bh=EvgQOLJlhEDLuvEcXOFO1LKZforMGGSKQWSuu1CIxy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ilmb7qgs43HmLa2/tvj7wX2fR3McdtjOOThNRHRLLM/bQu6mfa8NTPki4PtHzt5HIpdXgiJr3NU69UY0gawooxG9s30feUlPA8PiZQybD4TXgYeOnkGR46kzfymhbwhc47hk66yqkKwrV1/Kyu56g3bonSw4BYce6D4TGjrh+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc1Cmh1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 965A9C4AF07;
	Mon, 20 May 2024 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716234630;
	bh=EvgQOLJlhEDLuvEcXOFO1LKZforMGGSKQWSuu1CIxy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vc1Cmh1dyaHUlTzuHmyzA8EkgAib/Qwfh1vj9sEYyuKgXfdenGeo53qKzsqUIJhwB
	 xiuv7P5yL7bc1nK/eRCb9v7hJRSuQDwutVxpDBv+YxVtUk5lUKe3M2QHfRw2bgH6MW
	 dI7+N7uBWenfbVxheOq7S1KDzA75UcN5okBT6qUUXEZ3n5e0btPpeLp5dsiQorCZEn
	 gzDYkv2AKf4Dayzto/MUg1YwWmINCYZ5NqBIVTUzQYI/6x8NK88cSRcXOXMlxZsl7n
	 BdJ99WZEp9fQ0OP26iGUjfMgLmv/CEsRf2ax/OCC6adGeF1pRmczmKZySrebdoktU7
	 J/+CnNY4DVz9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79A39C54BB0;
	Mon, 20 May 2024 19:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Bluetooth: hci_core: Refactor hci_get_dev_list()
 function
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171623463049.16907.5107608936857144260.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 19:50:30 +0000
References: <AS8PR02MB72371852645FF17D07AE0CA98BEF2@AS8PR02MB7237.eurprd02.prod.outlook.com>
In-Reply-To: <AS8PR02MB72371852645FF17D07AE0CA98BEF2@AS8PR02MB7237.eurprd02.prod.outlook.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 keescook@chromium.org, gustavoars@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 18 May 2024 10:30:37 +0200 you wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "dl" variable is a pointer to "struct hci_dev_list_req" and this
> structure ends in a flexible array:
> 
> struct hci_dev_list_req {
> 	[...]
> 	struct hci_dev_req dev_req[];	/* hci_dev_req structures */
> };
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: hci_core: Prefer struct_size over open coded arithmetic
    https://git.kernel.org/bluetooth/bluetooth-next/c/d2526ccaab74
  - [v2,2/2] Bluetooth: hci_core: Prefer array indexing over pointer arithmetic
    https://git.kernel.org/bluetooth/bluetooth-next/c/68b1e55bdf24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



