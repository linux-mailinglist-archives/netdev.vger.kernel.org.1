Return-Path: <netdev+bounces-43158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3977D19C5
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 02:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB29B210AF
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BECEBC;
	Sat, 21 Oct 2023 00:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HO41pWF4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A31EA3
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701EBC433C7;
	Sat, 21 Oct 2023 00:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697846594;
	bh=yx4b5fn0c6i/eWSkHChzUW6XYw4N9dR7DJEx3AAQzKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HO41pWF4QiVeyQdPM9A8bwglMTkInB+dDxLsibIcJ30M+4iCc9NpMlN4JttCNzuaK
	 I0X1YuLX1KLGw99923ETQopyWBDfkGs4geJUBuctgKXlTwLzelPSiWGMIY15iU+aUd
	 yMyu6R5D0p1G+noEVVZD3ia8XWI492fPN30rc3YTrazlWaBy7gEQ5KO63eh+IeqSwe
	 qaP4ucYpaw5nJPDqHHyzsvTdPJVSCwle669n/x7ACYuxC6EW/+MDpB2nOkRb/Djs+s
	 ykmMHQc+LybdfhMTFle5SpngmM//y3uCXr572zhDZa/75v1wJ0nr/q9GuZfKwG9HPT
	 qg3j2dn2Cs76A==
Date: Fri, 20 Oct 2023 17:03:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 mokuno@sm.sony.co.jp, linville@tuxdriver.com, dcbw@redhat.com,
 jeff@garzik.org, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kunwu.chan@hotmail.com
Subject: Re: [PATCH] treewide: Spelling fix in comment
Message-ID: <20231020170312.5baf8c59@kernel.org>
In-Reply-To: <20231020093156.538856-1-chentao@kylinos.cn>
References: <20231020093156.538856-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 17:31:56 +0800 Kunwu Chan wrote:
> reques -> request
> 
> Fixes: 09dde54c6a69 ("PS3: gelic: Add wireless support for PS3")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Appears to have been applied to net, thank you!

