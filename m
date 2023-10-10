Return-Path: <netdev+bounces-39400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E407BF03C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 03:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B8D1C20A62
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 01:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC9659;
	Tue, 10 Oct 2023 01:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0LYnq9U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0B621
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 01:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF194C433C7;
	Tue, 10 Oct 2023 01:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696901206;
	bh=C6enjxS/IK6o5UnhWAniB1lA2Owal9XzZCeyFJmmlz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d0LYnq9U9Pmocp5K+Z2tR8RnTS8bcmYoODRJ0s/HKzMRbaJhPbO7rii2tZNGSN7of
	 KRQXsrtTue5h7uET1tPNFkKRuN3dkkcHu1N8bcqusP+g2YqCK0sxfd13/OMvTrrkek
	 a7ToJog0Me4zgv+WAWRc+zPbH1Br2J67ofMjkDMnROd5R5PAq8DdqLk9IFhLgRq2YN
	 /xlqrSyqozY4BVbWfTZud+aP9IsshYG1Jl9nOTrJFVlQWXhucKEv+cBcm9yQswJxpy
	 HJBaLyhDl1rPqUncT67k9hKMC1YAoXoWzAPL36L83nzULevZzUjTQssechUP6aKJxZ
	 p+N50DisixN5w==
Date: Mon, 9 Oct 2023 18:26:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net-next] netlink: specs: don't allow version to be
 specified for genetlink
Message-ID: <20231009182644.0f614c2f@kernel.org>
In-Reply-To: <20231009154907.169117-1-jiri@resnulli.us>
References: <20231009154907.169117-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Oct 2023 17:49:07 +0200 Jiri Pirko wrote:
>  Documentation/netlink/genetlink-legacy.yaml | 8 ++++----
>  Documentation/netlink/genetlink.yaml        | 4 ----

You missed genetlink-c
-- 
pw-bot: cr

