Return-Path: <netdev+bounces-30938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6733F78A03D
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 18:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB121C2090D
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFF41118C;
	Sun, 27 Aug 2023 16:47:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F436100AE
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 16:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967D0C433C7;
	Sun, 27 Aug 2023 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693154849;
	bh=vDhsXRw3WVqEe39LN1DWXuIBT6/LQlWm8E1xNI3unqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjg+7F1GSWyFtE+DXiaCPlKeKcw26jUadcoTS3brl8EMyhipIeakexij739QMZJaU
	 7IJqklE3/IHn56kBX8W4wzzPPL0btzpqBrH/Cg9jv1RGfBAGRWZG6a5gBIYWayLFoP
	 9IOQ4XJNSL1Tmhymjb5AVnEolL8LZ+SGdJkGntFudRyq68ia2E+mbZHQblPNjFyyK4
	 5IIYvtgHuE0Z+g6oFEHTXVSEjhHzpeprl8QTs7sS00AyrNDfJTl+uzq4f4MrohNyLB
	 LAgKbmLSDKiQR/t9KRGF/c64Wf/HUrCVw2KT832sInQDcdlrhfCXGrb5+l4KI8nb2z
	 lDPFR90KnWjvA==
Date: Sun, 27 Aug 2023 18:47:13 +0200
From: Simon Horman <horms@kernel.org>
To: Mikhail Kobuk <m.kobuk@ispras.ru>
Cc: Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Prashant Sreedharan <prashant@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH] ethernet: tg3: remove unreachable code
Message-ID: <20230827164713.GU3523530@kernel.org>
References: <20230825190443.48375-1-m.kobuk@ispras.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825190443.48375-1-m.kobuk@ispras.ru>

On Fri, Aug 25, 2023 at 10:04:41PM +0300, Mikhail Kobuk wrote:
> 'tp->irq_max' value is either 1 [L16336] or 5 [L16354], as indicated in
> tg3_get_invariants(). Therefore, 'i' can't exceed 4 in tg3_init_one()
> that makes (i <= 4) always true. Moreover, 'intmbx' value set at the
> last iteration is not used later in it's scope.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 78f90dcf184b ("tg3: Move napi_add calls below tg3_get_invariants")
> Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
> Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Reviewed-by: Simon Horman <horms@kernel.org>


