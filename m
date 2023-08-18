Return-Path: <netdev+bounces-28853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951E7781032
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87AA281C5F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302DF19BC0;
	Fri, 18 Aug 2023 16:21:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089A19BBF
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55132C433C8;
	Fri, 18 Aug 2023 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692375672;
	bh=F4hu+ZSGYoWCRdUdfsCxfVt10gS2gebSaptHFSyZ0rg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cjDtFUU8eNav46CbF/zksDLJ6ng2War+LGduWysDW0s+Lmkcq0/Ke9m7Z18+YGblP
	 /oWBnuokIWWyib8Mn6QEdc8eXYAzMZih5TbtFr0jR2yDbxfinK0rNJdM/hK/MIMG5W
	 aPnFZ7D01SZc3UFJAhPhCvdGD+EL9pJx0RhnSl2ZKqwfAxZR9m5S50CtMA6N8h9ZGo
	 Hu4FbDMijaPofsi6x1jLdLik5IoFWNUlGaa6ISTa5yZ+kR1rNI8AeLGAva2tPVk3iF
	 dXKkydImC+K2Zp9302csEoN7KQSu3pZ652ghYJIHFbRyKBrpzOCPar0rHdQWsXUo+V
	 awXViSsjHW7wQ==
Date: Fri, 18 Aug 2023 09:21:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yan Zhai <yan@cloudflare.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Wander Lairson Costa <wander@redhat.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230818092111.5d86e351@kernel.org>
In-Reply-To: <20230818145734.OgLYhPh1@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
	<20230814112421.5a2fa4f6@kernel.org>
	<20230817131612.M_wwTr7m@linutronix.de>
	<CAO3-Pbo7q6Y-xzP=3f58Y3MyWT2Vruy6UhKiam2=mAKArxgMag@mail.gmail.com>
	<20230818145734.OgLYhPh1@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 16:57:34 +0200 Sebastian Andrzej Siewior wrote:
> As of now Jakub isn't eager to have it and my testing/ convincing is
> quite limited. If nobody else yells that something like that would be
> helpful I would simply go and convince PeterZ/tglx to apply 2/2 of this
> series.

As tempting as code removal would be, we can still try to explore the
option of letting backlog processing run in threads - as an opt-in on
normal kernels and force it on RT?

But it would be good to wait ~2 weeks before moving forward, if you
don't mind, various core folks keep taking vacations..

