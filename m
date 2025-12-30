Return-Path: <netdev+bounces-246376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8FBCEA47E
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 18:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09C353004E2C
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7066A31985C;
	Tue, 30 Dec 2025 17:15:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE423195E4;
	Tue, 30 Dec 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767114906; cv=none; b=kEH9idcJMYCfL81hj04pGNAIlfrzeFcYQroPh+ZqXKL13RPmSPkEX7mQ9OKrirpdXKpYSbWG4Zv7R1RDvvqJjulLRJqFxuEFSl3RDTeM2sE6kxdV16NKPuP1OXnKsZZRbsTH0Tb0T7pjcyV7pQ1i8EfkIzdL3tSpOMwVHFhcr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767114906; c=relaxed/simple;
	bh=Y8XG1JEhHhSuJB/0zc+q581GNZlSmlWVb/FINMvpZhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXsvFuMgP2AozQGDZPBc8Tq3kAPYX5wNxx8RiBLFHeQiq5Dz062gOAAiinOiTGJztuFal+4LiLRrBkYxbqr5m10nO3v7TrIw7TlRhM4RXgUtjqVqfwFtHaJKBxh73oT4yHnkgDy0rkoG1QytWJqdXlcSVblJc70uWdnWj1rZY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vad1A-000000000rM-1zMA;
	Tue, 30 Dec 2025 16:56:20 +0000
Date: Tue, 30 Dec 2025 16:56:11 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: yunbolyu@smu.edu.sg, kexinsun@smail.nju.edu.cn, ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr, Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: adjust function name reference
Message-ID: <aVQEKwj38I1Coj2L@makrotopia.org>
References: <20251230140601.93474-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230140601.93474-1-Julia.Lawall@inria.fr>

On Tue, Dec 30, 2025 at 03:06:01PM +0100, Julia Lawall wrote:
> There is no function clk_bulk_prepare_disable.  Refer instead to
> clk_bulk_disable_unprepare, which is called in the function
> defined just below.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Thanks for spotting this obviously wrong comment!

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> 
> ---
>  drivers/phy/mediatek/phy-mtk-xfi-tphy.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-xfi-tphy.c b/drivers/phy/mediatek/phy-mtk-xfi-tphy.c
> index 1a0b7484f525..100a50d0e861 100644
> --- a/drivers/phy/mediatek/phy-mtk-xfi-tphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-xfi-tphy.c
> @@ -353,7 +353,7 @@ static int mtk_xfi_tphy_power_on(struct phy *phy)
>   * Disable and unprepare all clocks previously enabled.
>   *
>   * Return:
> - * See clk_bulk_prepare_disable().
> + * See clk_bulk_disable_unprepare().
>   */
>  static int mtk_xfi_tphy_power_off(struct phy *phy)
>  {
> 
> 

