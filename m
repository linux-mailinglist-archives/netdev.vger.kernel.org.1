Return-Path: <netdev+bounces-116197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D839496F6
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185501F213DE
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502556F06D;
	Tue,  6 Aug 2024 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AraJaUcK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2194B62A02;
	Tue,  6 Aug 2024 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965722; cv=none; b=PMrGkqBxKMgYocoUr0WuwCZ6jN8oJ6AI24WQ+HgPsWLaI+vkQXs1JCtyHG7DKYyIT8ZsNDtDsmXrbuECNXebHPr/IvESN7G0d6JZ5etgPlfAPoX77fcU/4hMYE4Nz+8gRD3wQgNdc9eIe18L4Jo/cyUarozHbldnWS1FGhNlyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965722; c=relaxed/simple;
	bh=sbFiD0UTPz3Xhgo7u+pcibnbth29PoEv4oSZWuoSTH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cic3d1jpaOxmkDWrXshqXf17PvASGJGLOwcAge0F0dnemBRh5/5cn1SpLWqXY1Iy9AL1PvZnX0XEzovzMYhx7rmszKPE6z6u1l6/rAN+yy59csIQKx3ClIhG1AUd4DckF7mJg2kovj+hAwVkR37P04dzHMBbEbj8YpnssvCBg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AraJaUcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBBBC4AF0E;
	Tue,  6 Aug 2024 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722965721;
	bh=sbFiD0UTPz3Xhgo7u+pcibnbth29PoEv4oSZWuoSTH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AraJaUcKzqP3jBmRFw6xv4VnTrnEVv1aMvKj0UsGZVEII5DF5HuwCnr7knf3XnQns
	 rGNx6IM+xauv2tAmu3bgXTiYlquGu3Rlgl1Aug6P7gqabxD/ZdnN1xxJewPvM4FjC5
	 J7M15LPoteevpcLEvidwur5kSOEmiHcEKRXZAkyxqsOlV1e6syhXlwJ3zMjU20Av48
	 LswP5i2igU9+OlMAaDpL0rOMJUrMFDv3RwF/UrbSkMNiqBskdCE5w0geB6Y7r2g+vG
	 aOcB8T5te3zffbvfnUKz57/V6bXG786oDFRNVZPrw8GdMQq2QIh2VS6GJBI2HdsQqd
	 bq1OZqSiR54pQ==
Date: Tue, 6 Aug 2024 11:35:20 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Jose Abreu <joabreu@synopsys.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: net: Add rk3576 dwmac bindings
Message-ID: <172296571928.1850493.16580227879384063021.robh@kernel.org>
References: <20240802173918.301668-1-detlev.casanova@collabora.com>
 <20240802173918.301668-3-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802173918.301668-3-detlev.casanova@collabora.com>


On Fri, 02 Aug 2024 13:38:03 -0400, Detlev Casanova wrote:
> Add a rockchip,rk3576-gmac compatible for supporting the 2 gmac
> devices on the rk3576.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


