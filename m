Return-Path: <netdev+bounces-109391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905439283C3
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EA11C2231E
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 08:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7975E14658B;
	Fri,  5 Jul 2024 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9CEFwbv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5138D146584;
	Fri,  5 Jul 2024 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168556; cv=none; b=s03LnwoNjIsriiYwm5w7sef9pfQi1NOc5YooFImZYI/SvO92CdKy+PCBk8TjDcbwfbU1M9W0F4dksE8v9JIw27n4xx+8p0PRbnNpVzio+fZBKE/EuPOFgqP37io5gpxBSEauJKdX+YaCN1GsHG7bX011tVPgNwVFqzs93MseY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168556; c=relaxed/simple;
	bh=IKRkgE7HTYushKsvXZ0tIGrzlUvI+jppSG/Bsv6Ha14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBe/qd2q0GZ6DxlscTkf7xl6xBBsC5rkCJuYNkUdrLc6nCmEiGfB3rp34gmz6bAm54c0Q8CBxs0PxMXhzmDvk2gG/+SkuLtxLUz7QjsyvUcMclCoIm0S0ixrrtpRn/nsIIvAuZZTa2MvHfLZl5BCHVU9BoPgH/seV1r4rSZPTZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9CEFwbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B3BC116B1;
	Fri,  5 Jul 2024 08:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720168555;
	bh=IKRkgE7HTYushKsvXZ0tIGrzlUvI+jppSG/Bsv6Ha14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9CEFwbvNY1VeOJO4phfFGSsKZeKz1UzMzRM6XtE8TzIqWqkMEe8sIy79ew1CNc52
	 g5eRRAAjoOr5FhHD5xpM9BDkYlx30Z2dUm67U3EgjO1j/dsYgBUTw8Yp3LsDL0eZTB
	 /oTaloP1ZtVdqZgEggE7izBV4C3X6khLu/DH+d9otJHoll3N98/r/5kkAxnDomxp7H
	 ib28Lcaas6FCajN3GcaFxhQQHHikdoxDnd+kZfSkiPMwT0XUaxYEXO00E8eL7om4M/
	 uuVRg75gbmbei8oT9HVGVL0jid7W0k1MtzGLSK/+fnezaJD4WkRdgxs6gW2Kqf2cYX
	 Z4syNyv0EDk5g==
Date: Fri, 5 Jul 2024 09:35:50 +0100
From: Simon Horman <horms@kernel.org>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, Elad Yifee <eladwf@gmail.com>
Subject: Re: [PATCH v3] net: ethernet: mtk_ppe: Change PPE entries number to
 16K
Message-ID: <20240705083550.GA1095183@kernel.org>
References: <TY3P286MB261103F937DE4EEB0F88437D98DE2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB261103F937DE4EEB0F88437D98DE2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>

On Fri, Jul 05, 2024 at 01:26:26AM +0800, Shengyu Qu wrote:
> MT7981,7986 and 7988 all supports 32768 PPE entries, and MT7621/MT7620
> supports 16384 PPE entries, but only set to 8192 entries in driver. So
> incrase max entries to 16384 instead.
> 
> Signed-off-by: Elad Yifee <eladwf@gmail.com>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
> Changes since V1:
>  - Reduced max entries from 32768 to 16384 to keep compatible with MT7620/21 devices.
>  - Add fixes tag
> 
> Changes since V2:
>  - Remove fixes tag (Thanks to Jakub)

Reviewed-by: Simon Horman <horms@kernel.org>


