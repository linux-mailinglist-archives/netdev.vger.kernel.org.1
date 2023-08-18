Return-Path: <netdev+bounces-28757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 424AA7807F6
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D3D1C21405
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE0118004;
	Fri, 18 Aug 2023 09:06:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEFD4689
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:06:01 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EECEFE;
	Fri, 18 Aug 2023 02:06:00 -0700 (PDT)
Date: Fri, 18 Aug 2023 11:05:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1692349559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=797A4g137aklzqty4Q0W/9jDhfvBpZi/RjFD2RSZuXo=;
	b=4qWYuLyIWUBMRT7Lcy4sL+QAlOBfHR/yiQkAtf9V5C+CZVlnbMSOUfIs455XG3OpoYYA6o
	giHHqi1nfT+0EYstvmzz+ZChwdXxiFY9BvLMjfavkcLvOK/UmyvVktbhgFIPW4cWQCfs5S
	armnOSnxs97sksutnxKoRP5G9vy+idbAdFo3pAgfyBzBNSfbXS+mXZ4OpXDxIWkDoLv+1j
	36uaTg1xM7pXdObHxT4VZYBfSl/wCFoPViz5QOv4TJiXK/LkiqX3HRTYdI1s5xVOV/j9gH
	wN6IwZzKqX/as9KQkMl5O6dSDZqKCIIPJF2EdEVNMN2cCsAFRf2OAr8XKz6KJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1692349559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=797A4g137aklzqty4Q0W/9jDhfvBpZi/RjFD2RSZuXo=;
	b=zfzsD6nibSYHMn40GYkqzcFRG6cwbAIwRB5zV+jh+bCeGel7IdK93Q2Fd1G8fvBLNe1sFZ
	Mu5zRyP77OxmxFCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] softirq: Adjust comment for CONFIG_PREEMPT_RT in #else
Message-ID: <20230818090557.NAiFBJTa@linutronix.de>
References: <169234845563.1636130.4897344550692792117.stgit@firesoul>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169234845563.1636130.4897344550692792117.stgit@firesoul>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-18 10:47:35 [+0200], Jesper Dangaard Brouer wrote:
> The #ifdef CONFIG_PREEMPT_RT #else statement had a comment
> that made me think the code below #else statement was RT code.
> After reading the code closer I realized it was not RT code.
> Adjust comment to !RT to helper future readers of the code.

indeed.

> Fixes: 8b1c04acad08 ("softirq: Make softirq control and processing RT aware")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

