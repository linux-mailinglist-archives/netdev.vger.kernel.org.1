Return-Path: <netdev+bounces-29805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACA6784CC0
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522B11C20B12
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 22:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B0D34CEE;
	Tue, 22 Aug 2023 22:15:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44BA20183
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 22:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C6BC433C9;
	Tue, 22 Aug 2023 22:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692742520;
	bh=X6fTjt67iWWbrFjW9gx10bA6iKhUv3TcJEHhFDRn9rU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ho3Cnh7MFrQ/OP+GbxHJmRT+Djohuih6MKHJvZpt8v7xp7WgcA722MaTDrwctI/rZ
	 M7VJtzeMWkMCITumOGj61FhgjTS89aoUO0Z/nUcZadq7Bp7Vanwx9wI3waCN6GQcTu
	 c/ZX5KksWeAtBCUsZGJTYxCOvP0LQ3G10LhcxE8Dz5eQjQMpEONw0zjgTxrEADCL4r
	 TLNEc13OQIiAY/lI7AT9nUTjfPSwGbOnD96dUYjf3Zp05kbe+hx24iEIhaIDSrlEut
	 zQszAvnI2VGkke7w1bwkGQBgkgOw920ydFB3IhMBwcZNkicKBW4dor9bMBi6Ej7rsN
	 +wC6hg2yWC6ug==
Date: Tue, 22 Aug 2023 15:15:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-2023-08-22
Message-ID: <20230822151519.3b3baf84@kernel.org>
In-Reply-To: <20230822124206.43926-2-johannes@sipsolutions.net>
References: <20230822124206.43926-2-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 14:42:07 +0200 Johannes Berg wrote:
> We have two more fixes - one stack and one driver - for the
> current cycle. I think the Kconfig fix would be appreciated
> more than the other, but if anyone runs with UBSAN they may
> find this problem as well.

Pulled, thanks!

