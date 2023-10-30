Return-Path: <netdev+bounces-45348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6757DC301
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 00:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E247D1C20AB0
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 23:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD72A168B8;
	Mon, 30 Oct 2023 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH4SCN61"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C915E96
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 23:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB760C433C9;
	Mon, 30 Oct 2023 23:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698707705;
	bh=9umW4ZL1h/kspfg3KCaDmu0m+cqzhiIXiYtpSFVPNOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GH4SCN612U+QFEpNv1tXJb1QCWqn457q8C6WX+17HrdA3G4JiyNsmt9s07RyQtINu
	 G79YXdsQ49Btr48yd9YFwggdd+sU/DDrLiowqpQMPe/ybEiy4HhPsVXf03PwYx2AS1
	 tjs9LJPqZIIUbDabAeLmFUyBgiIks2iNpriGWASMwe/vMptMqbkezHnNHETmo9q9C/
	 bfm0Q91P2pfI5d/EV3lIF5M2Xv78SpskFsrIiLlOnrl5VJdINl13phLCLLeCdQtr44
	 34Ft3QSwynllml8145pzK5720Zpt4tEl7h7a46YgDx8/YgdYddSCfAT1IZ7CToiX4f
	 kk/qysJPIgc/A==
Date: Mon, 30 Oct 2023 16:15:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for 6.7
Message-ID: <20231030161503.4f247eeb@kernel.org>
In-Reply-To: <20231028011741.2400327-1-kuba@kernel.org>
References: <20231028011741.2400327-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 18:17:41 -0700 Jakub Kicinski wrote:
> Hi Linus!
> 
> I'll be traveling next week, so anticipating no -rc8 here is our
> merge window material.

Minor heads up, there's a silent conflict with the crypto tree,
you may want to squash this into whichever you merge second:
https://lore.kernel.org/all/20231030160953.28f2df61@canb.auug.org.au/

