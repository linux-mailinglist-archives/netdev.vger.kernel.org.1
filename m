Return-Path: <netdev+bounces-44549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17727D88BE
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 21:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D79B20E8D
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 19:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994723B282;
	Thu, 26 Oct 2023 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hck3Lmv1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0DD3AC17
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 19:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2B4C433C7;
	Thu, 26 Oct 2023 19:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698347507;
	bh=Nta3p2RmHPi+PBWCmBctW0fY8+7DtRZDqSuQ8WJcx8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hck3Lmv18PHu9GyKTR44pNGFKPa2aqBPtezwcIqhVcfFwJ4CDtDk3IkzDUOUsyruI
	 MrCR33DWlCEGF1SQzyg68lO0XR8W/7bYnkZUy/roJmSt2Xy7TkS0KnfBYm45mz9/rN
	 uJ5yErQ/+exRaivp4UNO4Fkl/tILhI6XnEBxodpc=
Date: Thu, 26 Oct 2023 21:11:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, ulf.hansson@linaro.org, rostedt@goodmis.org,
	sj@kernel.org, schspa@gmail.com, vladbu@nvidia.com,
	idosch@nvidia.com
Subject: Re: [PATCH net-next 3/4] net: fill in MODULE_DESCRIPTION()s under
 net/802*
Message-ID: <2023102633-quake-nape-bffb@gregkh>
References: <20231026190101.1413939-1-kuba@kernel.org>
 <20231026190101.1413939-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026190101.1413939-4-kuba@kernel.org>

On Thu, Oct 26, 2023 at 12:01:00PM -0700, Jakub Kicinski wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: ulf.hansson@linaro.org
> CC: rostedt@goodmis.org
> CC: sj@kernel.org
> CC: schspa@gmail.com
> CC: gregkh@linuxfoundation.org
> CC: vladbu@nvidia.com
> CC: idosch@nvidia.com

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

