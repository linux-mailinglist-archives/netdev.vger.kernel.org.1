Return-Path: <netdev+bounces-35269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4E97A83C9
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 15:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836E51C20AC8
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAA938DE3;
	Wed, 20 Sep 2023 13:46:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD47836AEE;
	Wed, 20 Sep 2023 13:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4EEC433C8;
	Wed, 20 Sep 2023 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695217619;
	bh=dBGRbuxNukRXbCtz9In2yhS+++hVLMIGSxm4jlSnasQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iEXiZ1gLIj8peOlIiFkmdudyE9LimPVizJ8NyJju2ik/EzRelagdoufjErmi3qyeC
	 AIZlYEAaC7g3e/qfkbsJKIIDvNJL8Rki9gUbaWYW+CSniJB5xAtyKshieDbA5wp7KB
	 /kDTeCHq6CJYGhNvb+Z5UaXnuQIZ7IYo6jKq7O8WqmZ6Y5rH5FGpa2Nhx9MzcA+eEA
	 N/210o4x99na7cQ1hrD4RuoJA2nEuIozlwZBgD5zW/HgOySgGshctgmGDOqngyToKB
	 OhA2PYcBJHWlo47p9UBPo4lNfSnR5DmK1jMfzkTjW/ltAKYPHlD6QEGWYHNbnPnArJ
	 pXiVr+to2h15A==
From: Lee Jones <lee@kernel.org>
To: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Serge Semin <Sergey.Semin@baikalelectronics.ru>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230914114435.481900-2-keguang.zhang@gmail.com>
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
 <20230914114435.481900-2-keguang.zhang@gmail.com>
Subject: Re: (subset) [PATCH v5 1/3] dt-bindings: mfd: syscon: Add
 compatibles for Loongson-1 syscon
Message-Id: <169521761559.3446293.1897507502065442678.b4-ty@kernel.org>
Date: Wed, 20 Sep 2023 14:46:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2

On Thu, 14 Sep 2023 19:44:33 +0800, Keguang Zhang wrote:
> Add Loongson LS1B and LS1C compatibles for system controller.
> 
> 

Applied, thanks!

[1/3] dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
      commit: d6e3854f720f13bad60c086d3cb4ea2c1958214a

--
Lee Jones [李琼斯]


