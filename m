Return-Path: <netdev+bounces-32736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AF2799ED5
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 17:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B255281176
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 15:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7488464;
	Sun, 10 Sep 2023 15:28:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7901F257E
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 15:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1839FC433C7;
	Sun, 10 Sep 2023 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694359695;
	bh=+Wff+pK+Vbh4L0aEFSRYIsCk9XAL1qmKYXRwW4CMwXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zvo2Sc+23JNTgc9wOA7TcBm92+6QzHv6cc4nACCst+QXuXJQu/l/PAtY76bjAI3V3
	 O8NieKDbltZRZ7myHslY5cqUkTzqbH8kPN3Ow09hUSQE0yjYkzXaYz/oL2jr3cMq27
	 vOw6cKyA/sG0ycppAzIsU7Cjl3MQxOqv0cuSIih8ui3IvjV18WrHIJKjbqPnOcs0Lf
	 Vmwjn72ssikqA0oOyUKNVGCPxaVVhHbvEryTR86xZQOnlK6q9STSJfLSi+CJ9GLHgE
	 uRjYu6CyphRSj2c+s4dKkf/ZuU3i2aUXF/W9iieAQg607ZfD94Hel5cAmEDb3z7oS5
	 BHimSj6B1knaw==
Date: Sun, 10 Sep 2023 17:28:12 +0200
From: Simon Horman <horms@kernel.org>
To: Jeremy Cline <jeremy@jcline.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: nfc: llcp: Add lock when modifying device list
Message-ID: <20230910152812.GJ775887@kernel.org>
References: <20230908235853.1319596-1-jeremy@jcline.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908235853.1319596-1-jeremy@jcline.org>

On Fri, Sep 08, 2023 at 07:58:53PM -0400, Jeremy Cline wrote:
> The device list needs its associated lock held when modifying it, or the
> list could become corrupted, as syzbot discovered.
> 
> Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>

Hi Jeremy,

thanks for your patch.

I don't think you need to resubmit for this,
I think this patch warrants a fixes tag:

Fixes: d646960f7986 ("NFC: Initial LLCP support")

Otherwise, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


