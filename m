Return-Path: <netdev+bounces-31745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E62FE78FEA3
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 15:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FDE1C20C8E
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A3BE66;
	Fri,  1 Sep 2023 13:55:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61818489
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 13:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DD4C433C7;
	Fri,  1 Sep 2023 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693576548;
	bh=+VvfZVPGs4uQ9zqARpEX9ACbrVsYYT1G2wpq8eWpZJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXayCCtUUumCsXNuP07jC5j+7VbZ1/+ZPxMMP8oSEPuWhNBaCklCmd7vDl2+RMyJY
	 YGac+HqLRIYrmG9PvVBJO83jZE85OWdpEyLSUuy/Yb/DQkxR+gD9fnTGVyF9tEOFqO
	 s49nOeh5uPNxxUQKnUO2x39CXz99bA0k699zxZ7BFzlzM+JqEcFCiK6GKYT9LDfHZW
	 s8uNyMoQI3SQC3PPnyuuECbdfAF9bBIXe3uePDJQyHKbF8EJOcYA4faYoupczScP4E
	 nJfkvCnMcq206fyeOZLlAM/XdjgsBU3RLZK25AwGdYL2BEOyDdr2cNBfXYhCcmyqB3
	 RXCA6H2cRJOGg==
Date: Fri, 1 Sep 2023 15:55:34 +0200
From: Simon Horman <horms@kernel.org>
To: Li kunyu <kunyu@nfschina.com>
Cc: idryomov@gmail.com, xiubli@redhat.com, jlayton@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ceph-devel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph/decode: =?utf-8?Q?Remove_?=
 =?utf-8?B?dW5uZWNlc3Nhcnkg4oCYMOKAmQ==?= values from ret
Message-ID: <20230901135534.GG140739@kernel.org>
References: <20230902201112.4401-1-kunyu@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902201112.4401-1-kunyu@nfschina.com>

On Sun, Sep 03, 2023 at 04:11:12AM +0800, Li kunyu wrote:
> ret is assigned first, so it does not need to initialize the
> assignment.
> Bad is not used and can be removed.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

Hi Li Kunyu,

A few things:

* Your clock seems to be in the future.

* I see you have posted similar similar changes to related code.
  Please consider combining them into a single patch,
  or a patch-set.

* Please set the target tree, net-next

  Subject: [PATCH net-next] ...

* net-next is currently closed

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

