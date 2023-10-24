Return-Path: <netdev+bounces-43686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EC47D43BD
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 02:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9FD1F2164E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 00:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392AA7EC;
	Tue, 24 Oct 2023 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JivXI1cL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEFB386
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD0CC433C8;
	Tue, 24 Oct 2023 00:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698106305;
	bh=nunD+4gbQ43OWpDMzt1aMIddlChl+mgwV/NK5UI/DNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JivXI1cLvpqztbdV9v6ENZOYrWK50wD/keeSE7slXsG0LBOG30oRoKeg0yEWml+0x
	 4dz4dID55O72HEKnF7KuwuI6/PqG0JweiNf7LJTpAvF/6u3+TBI6050umD/mosWvQ4
	 uVVNTz3xk1RdB/fgX3bY22RNduPlzKIAnJXcp1XOQbzOK1tnr0ulWMbOfhUi0qiuIB
	 YYPdcQVnRDhIYprIMLgK3fPVsbY2ziYnF8qzm+9HDXZyH41Eg2Dc6gv43FFObzSHRv
	 CMg0Q+UoGX1pbcsEoLXGZeX8ELI34XOul8AVRKymvtinLljzyv165Eh0Fhnyuw2XC6
	 jZw5AuYOhoZLg==
Date: Mon, 23 Oct 2023 17:11:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ciprian Regus <ciprian.regus@analog.com>
Cc: <linux-kernel@vger.kernel.org>, Dell Jin <dell.jin.code@outlook.com>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexandru Tachici
 <alexandru.tachici@analog.com>, "Andrew Lunn" <andrew@lunn.ch>, Simon
 Horman <horms@kernel.org>, Yang Yingliang <yangyingliang@huawei.com>, Amit
 Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, <netdev@vger.kernel.org>
Subject: Re: [net] net: ethernet: adi: adin1110: Fix uninitialized variable
Message-ID: <20231023171143.47c83b0e@kernel.org>
In-Reply-To: <20231020062055.449185-1-ciprian.regus@analog.com>
References: <20231020062055.449185-1-ciprian.regus@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 09:20:53 +0300 Ciprian Regus wrote:
> The spi_transfer struct has to have all it's fields initialized to 0 in
> this case, since not all of them are set before starting the transfer.
> Otherwise, spi_sync_transfer() will sometimes return an error.
> 
> Fixes: a526a3cc9c8d ("net: ethernet: adi: adin1110: Fix SPI transfers")

Applied, thank you!

