Return-Path: <netdev+bounces-23079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7731476AA81
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD42281795
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A721ED22;
	Tue,  1 Aug 2023 08:04:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0F1EA9A
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823D5C433C8;
	Tue,  1 Aug 2023 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690877072;
	bh=Tv+oYDR8L9V9W/c2l2OAdHIcJgsgGbcswiHtZzQaNhQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=I114Msy+sme9c8Xqqa/nLUtJEsHDs1ACQd4cp3G1yIxuGDbjrG8iwEG6x4by7ZNSH
	 bHOu12c4zWevOcO96Tz4nntB6501ZgchVnA6z9du0NVknqaNnsmsupZmfAncKadfq+
	 Tx4PoXAL4oyrcsFtWR08l1NYgkm9AT8c0WLygRyLteAZJW352I0lMv8m9KpOoiHf3s
	 p/299KpE27dGdrO/BVSaah1LYuYiSXTElxyIABR0XLzmnNNFT5U1ehbuPXkbc5E1ka
	 s12EYyRFq/BCKDDBAaHf7YDST3PkxF90VP+sTuqNWNMK48RZ0U2gVi+fxXBZM4488F
	 QPRXnUCo9BLSg==
From: Kalle Valo <kvalo@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>,  Lorenzo Bianconi <lorenzo@kernel.org>,
  Ryder Lee <ryder.lee@mediatek.com>,  Shayne Chen
 <shayne.chen@mediatek.com>,  Sean Wang <sean.wang@mediatek.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob
 Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: mt76: support setting
 per-band MAC address
References: <d3130584b64309da28a04826100643ff6239f9ca.1690841657.git.daniel@makrotopia.org>
Date: Tue, 01 Aug 2023 11:04:25 +0300
In-Reply-To: <d3130584b64309da28a04826100643ff6239f9ca.1690841657.git.daniel@makrotopia.org>
	(Daniel Golle's message of "Mon, 31 Jul 2023 23:23:16 +0100")
Message-ID: <874jljyyra.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Golle <daniel@makrotopia.org> writes:

> Introduce support for setting individual per-band MAC addresses using
> NVMEM cells by adding a 'bands' object with enumerated child nodes
> representing the 2.4 GHz, 5 GHz and 6 GHz bands.
>
> In case it is defined, call of_get_mac_address for the per-band child
> node, otherwise try with of_get_mac_address on the main device node and
> fall back to a random address like it used to be.
>
> While at it, add MAC address related properties also for the main node.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

mt76 patches go to Felix's tree, not net-next. No need to resend because
of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

