Return-Path: <netdev+bounces-19605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85BF75B5EB
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB21F28202A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1CF182A4;
	Thu, 20 Jul 2023 17:53:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF8A2FA35
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 17:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AD6C433C8;
	Thu, 20 Jul 2023 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689875597;
	bh=kFQpUoh4kpe+V3yjAvtA+pGQek8ZBGTb2rcrSK1Qwlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GfOUGegsVzsOyx/+ydaKbX3ItFePfjxFRHw5GEGdHeA5Hx/f5U9JjaLoWzyd1fITD
	 NJWzkoDBx8iVgUzkn2duoABDDOCDaVC1wqasMbWm5lcQCk4AXMdbzMQ/DAtkReARZK
	 BraoEJwvGHimp1S1SRRo88G9FlHtdDJhGXuQTJ8uMWABSTzBizn6VT3/OAZnPvLxrP
	 WMs4CycGsbN2Zb0/WosUHZpJ2Ul7B6ED/yNNaKpRwcJV+Kzva4oE7CXnrQslDacoO/
	 mPzMR5+wd6jV/2ljOTInp50DxmJD9Uv319Yo6eBlurJHRijNqdfIcQRZCIuuOZL/wI
	 rsVk9KfHrZBXQ==
Date: Thu, 20 Jul 2023 10:53:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Ard
 Biesheuvel <ardb@kernel.org>, Bob Gilligan <gilligan@arista.com>, Dan
 Carpenter <error27@gmail.com>, David Laight <David.Laight@aculab.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Donald Cassidy
 <dcassidy@redhat.com>, Eric Biggers <ebiggers@kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, Francesco Ruggeri
 <fruggeri05@gmail.com>, "Gaillardetz, Dominik" <dgaillar@ciena.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Hideaki YOSHIFUJI
 <yoshfuji@linux-ipv6.org>, Ivan Delalande <colona@arista.com>, Leonard
 Crestez <cdleonard@gmail.com>, Salam Noureddine <noureddine@arista.com>,
 "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v8 00/23] net/tcp: Add TCP-AO support
Message-ID: <20230720105316.0ad41719@kernel.org>
In-Reply-To: <20230719202631.472019-1-dima@arista.com>
References: <20230719202631.472019-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jul 2023 21:26:05 +0100 Dmitry Safonov wrote:
> This is version 8 of TCP-AO support. I base it on master and there
> weren't any conflicts on my tentative merge to linux-next.

doesn't apply
-- 
pw-bot: cr

