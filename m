Return-Path: <netdev+bounces-26591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC4778485
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F6A281DB1
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 00:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF44620;
	Fri, 11 Aug 2023 00:29:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52750163
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A73BC433C7;
	Fri, 11 Aug 2023 00:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691713739;
	bh=+c5/OsEBgDnJX2KvgJ9pc4qBsjp8YGnODvKI3Jus9tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ij2sVd4uf9Z5r88ZswuOjfOvTEbqxEszS2bGHGgnzp5V80Hu+QMCQHxOOV/yPlPuA
	 bCGo81r4IV8MxgBmvJ+SxPtikZ4UpPd2Hji1zvRmDY0P+MhYcz6h9LBn3w1grLQ4jz
	 DIBJptSYz+gzImJy8+9r5JYwge7AtLLZjyYzToqKDjLOlkwYyieU2fX9xWgiJP0izI
	 TdDMth64J+GDoFV0lDTFYiRQcydxw5NvrvtELqxmPTcxgbJxMRxed6Ymr1hOeACMjj
	 el4h+kZrl60foSK/y5vJX9qYPE0ayYo/Z8pBgeOWCtnuZZd1k4Eo+xs20QewJBUeEY
	 wdx1SZzgsXP1g==
Date: Thu, 10 Aug 2023 17:28:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, Nathan
 Chancellor <nathan@kernel.org>, Daniel Kolesa <daniel@octaforge.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Sven Volkinsfeld
 <thyrc@gmx.net>, Nick Desaulniers <ndesaulniers@google.com>,
 x86@kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 torvalds@linux-foundation.org, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [tip: x86/bugs] x86/srso: Fix build breakage with the LLVM
 linker
Message-ID: <20230810172858.12291fe6@kernel.org>
In-Reply-To: <20230810162524.7c426664@kernel.org>
References: <20230809-gds-v1-1-eaac90b0cbcc@google.com>
	<169165870802.27769.15353947574704602257.tip-bot2@tip-bot2>
	<20230810162524.7c426664@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 16:25:24 -0700 Jakub Kicinski wrote:
> On Thu, 10 Aug 2023 09:11:48 -0000 tip-bot2 for Nick Desaulniers wrote:
> > The following commit has been merged into the x86/bugs branch of tip:  
> 
> Hi folks, is there an ETA on this getting to Linus?
> The breakage has propagated to the networking trees, if the fix reaches
> Linus soon we'll just hold off on applying stuff and fast forward again.

Are the commit IDs stable on x86/bugs? 
Would it be rude if we pulled that in?

