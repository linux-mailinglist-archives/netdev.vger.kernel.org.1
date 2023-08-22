Return-Path: <netdev+bounces-29731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BFB784839
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D7A1C20B54
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE472B566;
	Tue, 22 Aug 2023 17:09:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E69C2B554
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9334C433C8;
	Tue, 22 Aug 2023 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692724181;
	bh=FW4BVXYleMpyRNFbkNVU2hdua81+fhJKOZWxrRxVY1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FUyQclBKucLGDFI07i2zlxlI6rdSZu5q9QA7UvRpS8QHw9oFAh3zzEhBiM2hUzv74
	 DDeVGFuBHdlrC8yR683WT6bl9FUCh/KYPAMjPu96OBQ8rJFenaOxNv641+eaxQB8e7
	 tjgnCG9rF92AGkMZTIMR2Tmchc3AmsERRG4nmuMu+eSQRUPSrReaZgKtgoCqkMxBeL
	 +fbXBy8VEOsYRq/kjXtCuHveldtmGdSXIdRCDRc2xnD5cyHI3hugU1hOlVwufPCl3G
	 ziC5tGlUeHiDOwLXkklKZG8f0Zs36lzQ/gyiHJ4yNUfEYlNp73UMfeP8gnynlJh7wj
	 c9YX57V8Fn9ag==
Date: Tue, 22 Aug 2023 10:09:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net-next] tools: ynl-gen: add "spec" arg to regen
 allowing to use only selected spec
Message-ID: <20230822100940.6baa7574@kernel.org>
In-Reply-To: <20230822115000.2471206-1-jiri@resnulli.us>
References: <20230822115000.2471206-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 13:50:00 +0200 Jiri Pirko wrote:
> $ tools/net/ynl/ynl-regen.sh -s Documentation/netlink/specs/devlink.yaml -f

touch Documentation/netlink/specs/devlink.yaml && ./tools/net/ynl/ynl-regen.sh

?

