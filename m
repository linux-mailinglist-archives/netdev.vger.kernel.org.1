Return-Path: <netdev+bounces-246479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B97ECECF77
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 12:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95C9330052E8
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 11:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA9C2C15BB;
	Thu,  1 Jan 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tS6o9/uN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D812522BA;
	Thu,  1 Jan 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767265690; cv=none; b=bz8lD9nGr62Mmmfo5OGchvKsJnrjIKTTEId8TREpXr9ZUoJyj3126iq80rL2P4kavv2PKhyaILJTlJU4R/pcZ/+rWkZIZKycEPuqJ2uEt6BDcJLB7QugOiIBeO+GtV02qAD/tHBr76vJDwJaXpj7dLzfyjBSJbEtqcu9iXBpXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767265690; c=relaxed/simple;
	bh=N6McmWiRC3gUWWXsSzP6Zof/WeqDCPbzzKSq7ESrF5c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rajbcNw25fcaRd4xA4P8YTxUxD2/oa9uvrbd1mzdG6JzryQXz064KjlIuqEZ5Ekbgx/ZjdbLKsnF8gr3mlq4iO9MPNKttnWE0vSXYS7baag98sQ6ar/dkH1uMVnUVsZaqt9XPdJKWruy8OlLppk2d9WGIqO3oi69sMgD4aM5p1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tS6o9/uN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B80C116B1;
	Thu,  1 Jan 2026 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767265690;
	bh=N6McmWiRC3gUWWXsSzP6Zof/WeqDCPbzzKSq7ESrF5c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tS6o9/uNs0qTT1xMfl2bqk0gutgChmWa5+rDXyA0MNxl0n7tIljGpg0mMovrNAbNU
	 UdPKJtJdviTBuRjgGVpPj3kE4LMryKUqREmAOHkzUle7qAYPXvAAH2FfOF+KHzRoL2
	 x/zVlKwszm9GukiLGwXxPQK4k8NK0Z8UpQMoX+8gM/9aMsalQQMPafLkQeVoaxGcXj
	 QntKmrrvGAlaobzaY9Aw4EvthO8nRdigsqkOAPGt7hDMBFOWsSw38YNhEFsdK2vpG7
	 zmKTPgmo5AMC/8vWVBJ/owZiSm2n9k05zdGnmqFAfFMJ4zAkAJLGbA5TKadF89Hbgg
	 D9Q3AgvG+Pxqw==
From: Vinod Koul <vkoul@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>
Cc: yunbolyu@smu.edu.sg, kexinsun@smail.nju.edu.cn, ratnadiraw@smu.edu.sg, 
 xutong.ma@inria.fr, Qingfang Deng <dqfext@gmail.com>, 
 SkyLake Huang <SkyLake.Huang@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251230140601.93474-1-Julia.Lawall@inria.fr>
References: <20251230140601.93474-1-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] phy: adjust function name reference
Message-Id: <176726568565.201416.1248729430822286493.b4-ty@kernel.org>
Date: Thu, 01 Jan 2026 16:38:05 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 30 Dec 2025 15:06:01 +0100, Julia Lawall wrote:
> There is no function clk_bulk_prepare_disable.  Refer instead to
> clk_bulk_disable_unprepare, which is called in the function
> defined just below.
> 
> 

Applied, thanks!

[1/1] phy: adjust function name reference
      commit: 6c1cdea6bafea96a818181e1289e22fbdc09f1d3

Best regards,
-- 
~Vinod



