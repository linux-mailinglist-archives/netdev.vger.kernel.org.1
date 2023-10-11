Return-Path: <netdev+bounces-40038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C7B7C582E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D811C20C24
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB55208C1;
	Wed, 11 Oct 2023 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqMOVbfy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B632031D
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CB3C433C8;
	Wed, 11 Oct 2023 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697038672;
	bh=sZYMiIgfprtrSPa/YkV0LT+ZOWe7IlPCwKkD47oyPlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqMOVbfyTIsQHi9u7DJ5iIe+Ff0gwSpewAuPmDzyYXvqcvJ4F+kiBPbNSqrlJQCRK
	 tl46k7q4/GIsuM7g4CwYR5gzNQxaknnoWaSotPpEGO/v02gd346PPfYUXzJFP37CeZ
	 1b8PmDksnZhMFZJciijKOd81d9mD1d5wdrPRzetPswD+VujzyqUgU7uwhKfuQJn5b6
	 dZ32lmPgn2Gcwb4ezDISUOx2EMgAWCKMPcBIL/8aUDlgnc1ziq+hJv678yteFFpcHP
	 kihDfRlFKpIHXiE0oRUkMx4q6TEM13lCXeM/lE5TR920UXFBWWVOpeJX98sphVmy3X
	 80UQuo8FOYC2Q==
Date: Wed, 11 Oct 2023 17:37:47 +0200
From: Simon Horman <horms@kernel.org>
To: Jeremy Cline <jeremy@jcline.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dmitry Vyukov <dvyukov@google.com>, Lin Ma <linma@zju.edu.cn>,
	Ilan Elias <ilane@ti.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 net] nfc: nci: assert requested protocol is valid
Message-ID: <ZSbBS74m2PmdSmP2@kernel.org>
References: <20230906233347.823171-1-jeremy@jcline.org>
 <20231009200054.82557-1-jeremy@jcline.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009200054.82557-1-jeremy@jcline.org>

On Mon, Oct 09, 2023 at 04:00:54PM -0400, Jeremy Cline wrote:
> The protocol is used in a bit mask to determine if the protocol is
> supported. Assert the provided protocol is less than the maximum
> defined so it doesn't potentially perform a shift-out-of-bounds and
> provide a clearer error for undefined protocols vs unsupported ones.
> 
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Reported-and-tested-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>

As per my review of v1, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

