Return-Path: <netdev+bounces-152587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D957E9F4B1B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E0E188ADF7
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE781F131A;
	Tue, 17 Dec 2024 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaIEdBiy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DED1F12FA;
	Tue, 17 Dec 2024 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439214; cv=none; b=nR9ngiRJIaiz3EM2zGaYy0YHkQypyTG/1ffFbk1x6u+bEdsDNYQPPw7dlP2RxqjJKuWlcM8GyQ7D9z9EgEPj9zjLCtWXXvnFFKKw3J3avYChaZP5ohLzZYp9v+dlAPBr5h1CTNrcihj+mOAk+2DLty30yQVC3+cSxER9Y5xGgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439214; c=relaxed/simple;
	bh=kuP4mugSVFEkML66fr2SZrKUOz6ScKGEefhRFZmpmqU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O/1g+tROjg+pt5xCI3MrsQYxv7UlrlRp740T8vPWuFoOCWYIxjISCQSV5YcTGoScbINMIdvfbBl2pf+ChOj+ThmM5FANa0SJPlMqluLJOu0clfsbFljHM+rHUps6ilmm/kMywg0Sg4Rw86cfngfpB9lUO27F795Zr/BRxoQxTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaIEdBiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ED7C4CED3;
	Tue, 17 Dec 2024 12:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734439213;
	bh=kuP4mugSVFEkML66fr2SZrKUOz6ScKGEefhRFZmpmqU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CaIEdBiyh8u+blmWy3bvE6I0x3G2WAoLacIUM8zYtG3k/Ni2gRILYI1oQ9Y1AH+4S
	 KPy0PsIh7q/iT5OwLzOrilyzGvrIdvuVo2t2G4eoqPF43kOM896P29JEGE/nRwhMMg
	 vb670Fh/WLYDIJODt7ktTG7Zw+GnUNG/w7CxtjmZhC3qQYFUv/DcFMpeS0zheIp1sz
	 ZaJJGgeUSojy2ttTzjo37LtOkzlGvMS4gRcHISjucDUHQcrCnnkwl1/U477wcpxBiq
	 xaEeYEI7inw2V14xNoT2mx5/m1BqDd3YsnzckOj2Vh5VBCo7Vi+b8JuIjbA4q3Ymw/
	 wiP1M7N5L0Ozg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CA73806656;
	Tue, 17 Dec 2024 12:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] rust: net::phy scope ThisModule usage in the
 module_phy_driver macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173443923101.882122.15033663641815587249.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 12:40:31 +0000
References: <20241214194242.19505-1-sergeantsagara@protonmail.com>
In-Reply-To: <20241214194242.19505-1-sergeantsagara@protonmail.com>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
 andrew@lunn.ch, fujita.tomonori@gmail.com, aliceryhl@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 14 Dec 2024 19:43:06 +0000 you wrote:
> Similar to the use of $crate::Module, ThisModule should be referred to as
> $crate::ThisModule in the macro evaluation. The reason the macro previously
> did not cause any errors is because all the users of the macro would use
> kernel::prelude::*, bringing ThisModule into scope.
> 
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] rust: net::phy scope ThisModule usage in the module_phy_driver macro
    https://git.kernel.org/netdev/net-next/c/d22f955cc2cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



