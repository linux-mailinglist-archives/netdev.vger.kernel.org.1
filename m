Return-Path: <netdev+bounces-30962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E2378A3CF
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 03:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54ED280DC1
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 01:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC97063F;
	Mon, 28 Aug 2023 01:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C4F36D
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 01:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8DDDC433C9;
	Mon, 28 Aug 2023 01:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693185031;
	bh=yKKE7NcvkrG2KAPbm552N47r7GnLB6Dc8UDhGM7ph9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LI1vGpnGO8aNGk1C0wtB5o1mKBnRnklSRJ/01EFWGENqrup04HqhYhSWy5uZsuKZV
	 Q5GusEWm3tqjITW66muNmf+PCj0TGICqSkmFxVF97Be4jORUzPntdRe0wOia9XCXg3
	 IoIHrmn1IFhwJA9CVOB41J1Yl0V3PSB0SCaTxc7YiJZVMR1IiewhERq9HrSxihrVis
	 WkRC5d/gM+JdNmTLsuan4k4IMPrLzxWdJFcRRT2ex7ydCc/Dao8lVMHHK3xZ4y1vAX
	 HKJ/Y7YPeUMDf3zhvtIGK/qedeUeSRCmCHsJvXSu4WCKes19zr1JuY6DAJNLmYj96l
	 QRED6LlaQondQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4C3FE21EDF;
	Mon, 28 Aug 2023 01:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/17] tls: expand tls_cipher_size_desc to simplify
 getsockopt/setsockopt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169318503173.15537.3848147900342525852.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 01:10:31 +0000
References: <cover.1692977948.git.sd@queasysnail.net>
In-Reply-To: <cover.1692977948.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Aug 2023 23:35:05 +0200 you wrote:
> Commit 2d2c5ea24243 ("net/tls: Describe ciphers sizes by const
> structs") introduced tls_cipher_size_desc to describe the size of the
> fields of the per-cipher crypto_info structs, and commit ea7a9d88ba21
> ("net/tls: Use cipher sizes structs") used it, but only in
> tls_device.c and tls_device_fallback.c, and skipped converting similar
> code in tls_main.c and tls_sw.c.
> 
> [...]

Here is the summary with links:
  - [net-next,01/17] selftests: tls: add test variants for aria-gcm
    https://git.kernel.org/netdev/net-next/c/84e306b08340
  - [net-next,02/17] selftests: tls: add getsockopt test
    https://git.kernel.org/netdev/net-next/c/f27ad62fe38c
  - [net-next,03/17] selftests: tls: test some invalid inputs for setsockopt
    https://git.kernel.org/netdev/net-next/c/4bfb6224ed80
  - [net-next,04/17] tls: move tls_cipher_size_desc to net/tls/tls.h
    https://git.kernel.org/netdev/net-next/c/fd0fc6fdd889
  - [net-next,05/17] tls: add TLS_CIPHER_ARIA_GCM_* to tls_cipher_size_desc
    https://git.kernel.org/netdev/net-next/c/200e23165109
  - [net-next,06/17] tls: reduce size of tls_cipher_size_desc
    https://git.kernel.org/netdev/net-next/c/037303d67607
  - [net-next,07/17] tls: rename tls_cipher_size_desc to tls_cipher_desc
    https://git.kernel.org/netdev/net-next/c/8db44ab26beb
  - [net-next,08/17] tls: extend tls_cipher_desc to fully describe the ciphers
    https://git.kernel.org/netdev/net-next/c/176a3f50bc6a
  - [net-next,09/17] tls: validate cipher descriptions at compile time
    https://git.kernel.org/netdev/net-next/c/0d98cc02022d
  - [net-next,10/17] tls: expand use of tls_cipher_desc in tls_set_device_offload
    https://git.kernel.org/netdev/net-next/c/3524dd4d5f1f
  - [net-next,11/17] tls: allocate the fallback aead after checking that the cipher is valid
    https://git.kernel.org/netdev/net-next/c/d2322cf5ed59
  - [net-next,12/17] tls: expand use of tls_cipher_desc in tls_sw_fallback_init
    https://git.kernel.org/netdev/net-next/c/e907277aeb6c
  - [net-next,13/17] tls: get crypto_info size from tls_cipher_desc in do_tls_setsockopt_conf
    https://git.kernel.org/netdev/net-next/c/5f309ade49c7
  - [net-next,14/17] tls: use tls_cipher_desc to simplify do_tls_getsockopt_conf
    https://git.kernel.org/netdev/net-next/c/077e05d13548
  - [net-next,15/17] tls: use tls_cipher_desc to get per-cipher sizes in tls_set_sw_offload
    https://git.kernel.org/netdev/net-next/c/d9a6ca1a9758
  - [net-next,16/17] tls: use tls_cipher_desc to access per-cipher crypto_info in tls_set_sw_offload
    https://git.kernel.org/netdev/net-next/c/48dfad27fd40
  - [net-next,17/17] tls: get cipher_name from cipher_desc in tls_set_sw_offload
    https://git.kernel.org/netdev/net-next/c/f3e444e31f9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



