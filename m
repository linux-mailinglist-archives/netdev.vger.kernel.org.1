Return-Path: <netdev+bounces-24460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50957703C6
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63151C21898
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F03CCA6E;
	Fri,  4 Aug 2023 15:02:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCC2CA5E
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04851C433C7;
	Fri,  4 Aug 2023 15:01:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D20yQJz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1691161318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sx2BTQhNuo1lMbCjENXe8kIeQAvO1r0M2h5WvUy3DS0=;
	b=D20yQJz8Lu1RADbQiFnRhgQGDETDlEkyDAlz2Pf36y9Ni9AZahhS7/IAPaeU9LgDJbF5qy
	eXJavWQMDQvE4sEL3T1NQ1mikViHE/OuUWPdJKUPxzCkdE1ExE27mylrAIKRUwAaKAQYBK
	Hya18wwfYjcC6XRZnPr3w3kjaBN2dlM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 586460bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Aug 2023 15:01:58 +0000 (UTC)
Date: Fri, 4 Aug 2023 17:00:43 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org,
	davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com,
	kuba@kernel.org
Subject: Re: [PATCH net-next] net/tcp: refactor tcp_inet6_sk()
Message-ID: <ZM0Sm6cx4Y76XLQ9@zx2c4.com>
References: <16be6307909b25852744a67b2caf570efbb83c7f.1684502478.git.asml.silence@gmail.com>
 <ZM0QHZNKLQ9kVlJ8@zx2c4.com>
 <CANn89i+_DoEDcFY9SfNqQ+8bqJ0kFpt4waQ8CSvhchE4aP2Dhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANn89i+_DoEDcFY9SfNqQ+8bqJ0kFpt4waQ8CSvhchE4aP2Dhw@mail.gmail.com>

Hi Eric,

On Fri, Aug 04, 2023 at 04:57:04PM +0200, Eric Dumazet wrote:
> I think my patch fixed this issue, can you double check ?
> 
> f5f80e32de12fad2813d37270e8364a03e6d3ef0 ipv6: remove hard coded
> limitation on ipv6_pinfo
> 
> I was not sure if Pavel was problematic or not, I only guessed.

That appears to fix the issue indeed, thanks. As this is only in
net-next, you may want to pick it into net for 6.5.

Jason

