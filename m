Return-Path: <netdev+bounces-34540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3B07A488E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 13:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3721C211B6
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 11:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E2B1C6BC;
	Mon, 18 Sep 2023 11:39:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41738F83;
	Mon, 18 Sep 2023 11:39:01 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0034E9B;
	Mon, 18 Sep 2023 04:38:59 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qiCad-0008GJ-2g;
	Mon, 18 Sep 2023 11:38:55 +0000
Date: Mon, 18 Sep 2023 12:35:31 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-mediatek@lists.infradead.org,
	sujuan.chen@mediatek.com, horms@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 09/17] net: ethernet: mtk_wed: fix
 EXT_INT_STATUS_RX_FBUF definitions for MT7986 SoC
Message-ID: <ZQg2AxAIxkadOiIr@makrotopia.org>
References: <cover.1695032290.git.lorenzo@kernel.org>
 <ebde071cc3cc9c35b00366c41912ee2f25e5282d.1695032291.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebde071cc3cc9c35b00366c41912ee2f25e5282d.1695032291.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 12:29:11PM +0200, Lorenzo Bianconi wrote:
> Fix MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH and
> MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH definitions for MT7986 (MT7986 is
> the only SoC to use them).

Afaik this applies also to MT7981 which is very similar to MT7986.

> 
> Fixes: de84a090d99a ("net: ethernet: mtk_eth_wed: add wed support for mt7986 chipset")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_wed_regs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_wed_regs.h b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
> index 47ea69feb3b2..f87ab9b8a590 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed_regs.h
> +++ b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
> @@ -64,8 +64,8 @@ struct mtk_wdma_desc {
>  #define MTK_WED_EXT_INT_STATUS_TKID_TITO_INVALID	BIT(4)
>  #define MTK_WED_EXT_INT_STATUS_TX_FBUF_LO_TH		BIT(8)
>  #define MTK_WED_EXT_INT_STATUS_TX_FBUF_HI_TH		BIT(9)
> -#define MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH		BIT(12)
> -#define MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH		BIT(13)
> +#define MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH		BIT(10) /* wed v2 */
> +#define MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH		BIT(11) /* wed v2 */
>  #define MTK_WED_EXT_INT_STATUS_RX_DRV_R_RESP_ERR	BIT(16)
>  #define MTK_WED_EXT_INT_STATUS_RX_DRV_W_RESP_ERR	BIT(17)
>  #define MTK_WED_EXT_INT_STATUS_RX_DRV_COHERENT		BIT(18)
> -- 
> 2.41.0
> 
> 

