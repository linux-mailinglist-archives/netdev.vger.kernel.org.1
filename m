Return-Path: <netdev+bounces-59700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2886581BD39
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D159D1F2649B
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D2D627FE;
	Thu, 21 Dec 2023 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYzgNXHG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308B627E2;
	Thu, 21 Dec 2023 17:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F8FC433C8;
	Thu, 21 Dec 2023 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703179805;
	bh=kcVqTac8RviEjF8aM/YTTN28lodJpiJLKerEF4JLWvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYzgNXHGgLE2eyK8DiixCQaeF2hy3AhAQ7b+1CX13T7RMttU/yHxRoGtc5i4hpBS9
	 KyyLoGue5vmRwkD4vdHjOXrvOkra9QXxa87Il/j2bEvcmlxkWAhYzGEaBFMRsYRm0s
	 SGWGMm5EljGNVnQKYBVHRuZ5Pxxm9m+NxLKFodRbF7bpnXoyhhOWscYv+mfkFxLhWt
	 oM5a28EMwP8IAu0Jb16pYFA6ffByBqrFCpWwjZ3Kgcm9Y6txBMCaUFaEgy8JJzsR38
	 E/kEfxw1Wk0F8yS8GhfOFSZHX+3BGdQIqSWfidXEkyZd5mZDqtWeU0SnTFzSbk66H9
	 n/LaG37kGEo1A==
Date: Thu, 21 Dec 2023 18:29:56 +0100
From: Simon Horman <horms@kernel.org>
To: Hangyu Hua <hbh25y@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, tgraf@suug.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: sched: em_text: fix possible memory leak in
 em_text_destroy()
Message-ID: <20231221172956.GE1056991@kernel.org>
References: <20231221022531.9772-1-hbh25y@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221022531.9772-1-hbh25y@gmail.com>

On Thu, Dec 21, 2023 at 10:25:31AM +0800, Hangyu Hua wrote:
> m->data needs to be freed when em_text_destroy is called.
> 
> Fixes: d675c989ed2d ("[PKT_SCHED]: Packet classification based on textsearch (ematch)")
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


