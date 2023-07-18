Return-Path: <netdev+bounces-18716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315247585BE
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B161C20D3C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C673171C3;
	Tue, 18 Jul 2023 19:47:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FEC10946
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 19:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DC7C433C8;
	Tue, 18 Jul 2023 19:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689709642;
	bh=a4umGYRDvYDJZM2/mBq+3qEU9SR1eriRi+EkCDcNGjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K5CNPLK9e8vCAo7aFILV9ozJohcg7nnWMvl5pB65ehZXOqkShwlyngOSt2Ca6s4lK
	 APKiJ2llRnyWv1Y/cKuem5d+Tr5daQ7a2TIhpED/Vsny4Z7eaSblY2vvF1MjHV/Sdl
	 mnwKnPRd+oU34Oa4YjjpQJzRRgad9qLI83X4UTwbjMWnl8lLNcsUygp/uXJfSM48SS
	 2kZ95rCXxq3TPAvoQxUZ+/huYfn8lVJ9q4i6ow7V6Y6/2TYFUubHaExNZztybe0jKG
	 sT76VYgTI+x4aE1xB0p7FZ66qs8hBdIDgld8Bp0Fp7PAn0s5d6x/Z4x3KHXCdLNgmU
	 QV4KccAFgTIfA==
Date: Tue, 18 Jul 2023 12:47:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: shijie001@208suo.com
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Fix errors in af_llc.c
Message-ID: <20230718124721.7e8510f3@kernel.org>
In-Reply-To: <7da2f0c57e848c77ab30a948dc73653a@208suo.com>
References: <tencent_4CED92D1C8320CEA29489ED8DFEF3614EB05@qq.com>
	<7da2f0c57e848c77ab30a948dc73653a@208suo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 13:48:33 +0800 shijie001@208suo.com wrote:
> The following checkpatch errors are removed:
> ERROR: "foo* bar" should be "foo *bar"
> ERROR: space required before the open parenthesis '('
> 
> Signed-off-by: Jie Shi <shijie001@208suo.com>

Please don't send checkpatch fixes to networking.
Your patches are whitespace damaged.

We had an influx of similar changes recently.
Are you part of some organized effort?
-- 
pw-bot: reject

