Return-Path: <netdev+bounces-26575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D377841B
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 01:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540A3281C64
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 23:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445A16FB3;
	Thu, 10 Aug 2023 23:25:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1971877
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36639C433C7;
	Thu, 10 Aug 2023 23:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691709925;
	bh=FL1OURaLWmN9Xjh4/6ybt68IL/DKEmHGvQ/9+m7PYvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DLk9oEjrX+q9V2ZbyAsOZSNLxGKTWBjH+PuVVo71qHPJHvxxfqtYNA+YxSlZFPQt1
	 l/TzmFJkjtKqNBKSShYwIseP+oCEW8xWiJUCSOXVrJ6BlE3fairChfpNl9FgDm04tG
	 vLyMK5JyjXE88kDn3IPsqVb8JxSlHgsYJJC8AnFDwFBcJBGzjQw2G6U9KiR+6vnVk7
	 NpN+jNU280kzQZ3JzoHHy7ttK6gHbAiGdvD+RxaiJw3vc2JhhxJ00gQF7fLIrvKLTn
	 MDLYB22JfrY4Jj8hpRE395g9HelEBhXERmLfnWCBeEBDJmEyoD0ft9qM/6S1O9SiCX
	 xUHKSDwD+fzyA==
Date: Thu, 10 Aug 2023 16:25:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>, "Borislav
 Petkov (AMD)" <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, Nathan
 Chancellor <nathan@kernel.org>, Daniel Kolesa <daniel@octaforge.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Sven Volkinsfeld
 <thyrc@gmx.net>, Nick Desaulniers <ndesaulniers@google.com>,
 x86@kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 torvalds@linux-foundation.org
Subject: Re: [tip: x86/bugs] x86/srso: Fix build breakage with the LLVM
 linker
Message-ID: <20230810162524.7c426664@kernel.org>
In-Reply-To: <169165870802.27769.15353947574704602257.tip-bot2@tip-bot2>
References: <20230809-gds-v1-1-eaac90b0cbcc@google.com>
	<169165870802.27769.15353947574704602257.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 09:11:48 -0000 tip-bot2 for Nick Desaulniers wrote:
> The following commit has been merged into the x86/bugs branch of tip:

Hi folks, is there an ETA on this getting to Linus?
The breakage has propagated to the networking trees, if the fix reaches
Linus soon we'll just hold off on applying stuff and fast forward again.

