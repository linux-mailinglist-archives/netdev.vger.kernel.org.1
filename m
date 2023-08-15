Return-Path: <netdev+bounces-27622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E7B77C919
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 10:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168342813D8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47484BA31;
	Tue, 15 Aug 2023 08:06:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4223C0
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF7DC433C7;
	Tue, 15 Aug 2023 08:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692086816;
	bh=mUQxZ4Mtp+QHlrdWnVpjORf3UPAKZsHLRbyV936Phd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTFe6erunt94BbhL15CBe7Yr2Xi1feLcdqRsFNRhPim7l1mhyZq5y9SMUlCki53Aq
	 yFRfVGKhJlpzxICd0rspXzxCHd6E4/RELRKmkgt8h656GFmf8ncCb3fugKaQCu7Jka
	 M7D6x6ojxJ+pj2YW8hCzRkilKcxleq0HMuOpTVDde1djCLCbKUziplQjjto8d47dbe
	 5o6UbyN6D+7tB21fGmhb8cKLmZkvpY+qw3QQ2Y/hzdG9XDl+1RrvFcX/cAkFqjcMnu
	 AvV0OyYrP0+RxP9a9NU/m2dhm7gEe+vl0kuvXw3JAX99i/O/+JUTgMWT8/SiVia8E5
	 aHwCYulNMSLgg==
Date: Tue, 15 Aug 2023 10:06:50 +0200
From: Simon Horman <horms@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	clement.leger@bootlin.com, ulli.kroll@googlemail.com,
	kvalo@kernel.org, bhupesh.sharma@linaro.org, robh@kernel.org,
	elder@linaro.org, wei.fang@nxp.com, nicolas.ferre@microchip.com,
	simon.horman@corigine.com, romieu@fr.zoreil.com,
	dmitry.torokhov@gmail.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/5] wlcore: spi: Remove redundant
 of_match_ptr()
Message-ID: <ZNsyGjC9zrg4DAvQ@vergenet.net>
References: <20230814025520.2708714-2-ruanjinjie@huawei.com>
 <20230814025520.2708714-6-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814025520.2708714-6-ruanjinjie@huawei.com>

On Mon, Aug 14, 2023 at 10:55:19AM +0800, Ruan Jinjie wrote:
> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


