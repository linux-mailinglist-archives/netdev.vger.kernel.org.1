Return-Path: <netdev+bounces-56585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167A280F7F3
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478851C208A5
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2F64123;
	Tue, 12 Dec 2023 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nkyz2XXB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002B64C
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 20:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744AAC433C7;
	Tue, 12 Dec 2023 20:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702413114;
	bh=9tSF4VzYJt2cB8c5D/JCneS7y1HL4A5N0+ouVo24dco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nkyz2XXBEpkZXkePAITHXeS2DaM/wWdoNvwSkI4wH9og70ySzmeF37L/TC1LJJCo+
	 XMplQPTPUcQdpfJZgFXE4okpncV46w8Z1/OPpkZSS4SPg94cKzWutHZR+BOZ/jkDEQ
	 XQhthqZrrACfFHLkxw23UxikIOmDGg6Yx2hCWP6J0IfxInVqZEVR8awovYL8/zaSBs
	 /1LovrSeT6P9tX2Nq//WAkwCA1xYu/7w+TRrHZsWHXNhxUUsXFauDlqsHzXx0mRWA1
	 iacvAleOQ1/GJmFeHHhrHYWKN+Pb8hHOYR+032mWoR2qGbjnrY5eXFGiFB/WZB06F+
	 3q7fNdCGTC1VA==
Date: Tue, 12 Dec 2023 20:31:48 +0000
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH iwl-next v2] i40e: remove fake support of rx-frames-irq
Message-ID: <20231212203148.GG5817@kernel.org>
References: <20231209092051.43875-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209092051.43875-1-kerneljasonxing@gmail.com>

On Sat, Dec 09, 2023 at 05:20:51PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since we never support this feature for I40E driver, we don't have to
> display the value when using 'ethtool -c eth0'.
> 
> Before this patch applied, the rx-frames-irq is 256 which is consistent
> with tx-frames-irq. Apparently it could mislead users.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2: use the correct params in i40e_ethtool.c file as suggested by Jakub.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

