Return-Path: <netdev+bounces-208877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A33B0D78B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 12:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C83189DC5D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EC02E11B6;
	Tue, 22 Jul 2025 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OfW2ttUl"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9352155CB3;
	Tue, 22 Jul 2025 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753181572; cv=none; b=YB2AxcPK+UEO4w84E8pVc9IBBPU+eggVFGWIxBPw/LxL7cpwCDCUaldl/sPxukH1N5otUQ7uIZxm5YeGbiLr7tnapx6zMI8KMgMuvkjbuFZX/wXx0/JpZUgq/jxqGFnnjYj3eWVdJCDZs3KeB2ppiOVugr8Zp9LBymIztLNkfXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753181572; c=relaxed/simple;
	bh=dGCgiF63wh9ujAd3rXkaVlG91f8mb9WyF1hcxbsejLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhdqT7EI/qjVTbzBVisP7z098xKkpFxPhEIrrelnV4Qny1rptpE7iaZexNK4Pouh+f3XjNn0JS9lZ4BI4bBbu9XWbGqxmxYYfHRnpqKnEngWuQ/qnJdTSOVsVBPX/7PRn5oNbIj1og8CEblmLPcvPAx8JJmcP8MrTqa9USLJdrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OfW2ttUl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753181568;
	bh=dGCgiF63wh9ujAd3rXkaVlG91f8mb9WyF1hcxbsejLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OfW2ttUl+lir7OfWoJSI1AKVyrcbkofseiyAupBPX6BLa9Kgb2EjIERn7FcRu8ylc
	 w7Mie5adgmV5Xb9WMRElfoP2cN9zvqc9K1OUiHI/GbhN6zf/4LqlNklCkXyAov+gqq
	 5rcgqo1detU+150S+X4gq5mCTuLPEfvnhDyEGZE5L8+YvLOfHC23v+ZcAckpGy9HvJ
	 S9eePqrTHegUaLOa6XhI6hHmciCTAA6UmGDHo0j8PMmLyv9SYSLeFczJEnUyriPMyM
	 uyu//SzbUwIjulxRVFOCevgq0x3qrVUlOGaCD4bXOsS+tmDx+uwFIsUb2pgzR2P2wN
	 S8opaZ2AXsI2Q==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:bd9c:eae9:88b0:783c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C1DFB17E0D15;
	Tue, 22 Jul 2025 12:52:47 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: wenst@chromium.org
Cc: angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	guangjie.song@mediatek.com,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	mturquette@baylibre.com,
	netdev@vger.kernel.org,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com,
	robh@kernel.org,
	sboyd@kernel.org
Subject: Re: [PATCH v2 14/29] clk: mediatek: Add MT8196 vlpckgen clock support 
Date: Tue, 22 Jul 2025 12:52:03 +0200
Message-Id: <20250722105203.33151-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAGXv+5ErtDLNf3u5OdHrEBdrA-2bPA5wy32S+Bqd1c_1Z9u1pA@mail.gmail.com>
References: <CAGXv+5ErtDLNf3u5OdHrEBdrA-2bPA5wy32S+Bqd1c_1Z9u1pA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/18/25 10:31, Chen-Yu Tsai wrote:
> On Tue, Jul 15, 2025 at 3:28 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>
>> Hi,
>>
>>
>> On Tue, Jun 24, 2025 at 10:33 PM Laura Nao <laura.nao@collabora.com> wrote:
>>>
>>> Add support for the MT8196 vlpckgen clock controller, which provides
>>> muxes and dividers for clock selection in other IP blocks.
>>>
>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>>> ---
>>>  drivers/clk/mediatek/Makefile              |   2 +-
>>>  drivers/clk/mediatek/clk-mt8196-vlpckgen.c | 769 +++++++++++++++++++++
>>>  2 files changed, 770 insertions(+), 1 deletion(-)
>>>  create mode 100644 drivers/clk/mediatek/clk-mt8196-vlpckgen.c
>>>
>>> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
>>> index 0688d7bf4979..24683dd51783 100644
>>> --- a/drivers/clk/mediatek/Makefile
>>> +++ b/drivers/clk/mediatek/Makefile
>>> @@ -161,7 +161,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
>>>  obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) += clk-mt8195-vpp0.o clk-mt8195-vpp1.o
>>>  obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
>>>  obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o \
>>> -                                  clk-mt8196-topckgen2.o
>>> +                                  clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o
>>>  obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
>>>  obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
>>>  obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
>>> diff --git a/drivers/clk/mediatek/clk-mt8196-vlpckgen.c b/drivers/clk/mediatek/clk-mt8196-vlpckgen.c
>>> new file mode 100644
>>> index 000000000000..23a673dd4c5c
>>> --- /dev/null
>>> +++ b/drivers/clk/mediatek/clk-mt8196-vlpckgen.c
>>> @@ -0,0 +1,769 @@
>>
>> [...]
>>
>>> +static const char * const vlp_camtg0_parents[] = {
>>> +       "clk26m",
>>> +       "univpll_192m_d32",
>>> +       "univpll_192m_d16",
>>> +       "clk13m",
>>> +       "osc_d40",
>>> +       "osc_d32",
>>> +       "univpll_192m_d10",
>>> +       "univpll_192m_d8",
>>> +       "univpll_d6_d16",
>>> +       "ulposc3",
>>> +       "osc_d20",
>>> +       "ck2_tvdpll1_d16",
>>> +       "univpll_d6_d8"
>>> +};
>>
>> It seems all the vlp_camtg* parents are the same. Please merge them
>> and just have one list.
>>
>>> +static const char * const vlp_sspm_26m_parents[] = {
>>> +       "clk26m",
>>> +       "osc_d20"
>>> +};
>>> +
>>> +static const char * const vlp_ulposc_sspm_parents[] = {
>>> +       "clk26m",
>>> +       "osc_d2",
>>> +       "mainpll_d4_d2"
>>> +};
>>> +
>>> +static const char * const vlp_vlp_pbus_26m_parents[] = {
>>> +       "clk26m",
>>> +       "osc_d20"
>>> +};
>>> +
>>> +static const char * const vlp_debug_err_flag_parents[] = {
>>> +       "clk26m",
>>> +       "osc_d20"
>>> +};
>>> +
>>> +static const char * const vlp_dpmsrdma_parents[] = {
>>> +       "clk26m",
>>> +       "mainpll_d7_d2"
>>> +};
>>> +
>>> +static const char * const vlp_vlp_pbus_156m_parents[] = {
>>> +       "clk26m",
>>> +       "osc_d2",
>>> +       "mainpll_d7_d2",
>>> +       "mainpll_d7"
>>> +};
>>> +
>>> +static const char * const vlp_spm_parents[] = {
>>> +       "clk26m",
>>> +       "mainpll_d7_d4"
>>> +};
>>> +
>>> +static const char * const vlp_mminfra_parents[] = {
>>> +       "clk26m",
>>> +       "osc_d4",
>>> +       "mainpll_d3"
>>> +};
>>> +
>>> +static const char * const vlp_usb_parents[] = {
>>> +       "clk26m",
>>> +       "mainpll_d9"
>>> +};
>>
>> The previous and the next one are the same.
>>
>>> +static const char * const vlp_usb_xhci_parents[] = {
>>> +       "clk26m",
>>> +       "mainpll_d9"
>>> +};
>>> +
>>> +static const char * const vlp_noc_vlp_parents[] = {
>>> +       "clk26m",
>>> +       "osc_d20",
>>> +       "mainpll_d9"
>>> +};
>>> +
>>> +static const char * const vlp_audio_h_parents[] = {
>>> +       "clk26m",
>>> +       "vlp_apll1",
>>> +       "vlp_apll2"
>>> +};
>>> +
>>> +static const char * const vlp_aud_engen1_parents[] = {
>>> +       "clk26m",
>>> +       "apll1_d8",
>>> +       "apll1_d4"
>>> +};
>>
>> The previous and the next one are the same.
>>
>>> +static const char * const vlp_aud_engen2_parents[] = {
>>> +       "clk26m",
>>> +       "apll2_d8",
>>> +       "apll2_d4"
>>> +};
>>> +
>>> +static const char * const vlp_aud_intbus_parents[] = {
>>> +       "clk26m",
>>> +       "mainpll_d7_d4",
>>> +       "mainpll_d4_d4"
>>> +};
>
> Also, all these audio related clocks (audio_h, aud_engen1, aud_engen2
> aud_intbus) have a "vlp_clk26m" clock as their parent. It should be:
>
>   - clk26m (clk26m from the top ckgen domain)
>   - vlp_clk26m (clk26m from the VLP domain)
>   - (from PLLs)
>   - (from PLLs)
>
> Moreover, an offline discussion with the audio owner suggests that
> of the two 26 MHz clock parents, we really just want the one from
> the VLP domain, as that one is usable even under suspend. This
> could be done by providing an index table.
>

Hi ChenYu,

Thanks for the feedback - I’ll make these changes along with the 
previous suggestions and submit a v3.

Best,

Laura

> ChenYu
>
>>> +
>>> +static const char * const vlp_spvlp_26m
>>
>> [...]
>>
>>> +static int clk_mt8196_vlp_probe(struct platform_device *pdev)
>>> +{
>>> +       struct clk_hw_onecell_data *clk_data;
>>> +       int r;
>>> +       struct device_node *node = pdev->dev.of_node;
>>> +
>>> +       clk_data = mtk_alloc_clk_data(ARRAY_SIZE(vlp_muxes) +
>>> +                                     ARRAY_SIZE(vlp_plls));
>>> +       if (!clk_data)
>>> +               return -ENOMEM;
>>> +
>>> +       r = mtk_clk_register_muxes(&pdev->dev, vlp_muxes, ARRAY_SIZE(vlp_muxes),
>>> +                                  node, &mt8196_clk_vlp_lock, clk_data);
>>> +       if (r)
>>> +               goto free_clk_data;
>>> +
>>> +       r = mtk_clk_register_plls(node, vlp_plls, ARRAY_SIZE(vlp_plls),
>>> +                                 clk_data);
>>> +       if (r)
>>> +               goto unregister_muxes;
>>> +
>>> +       r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>>> +       if (r)
>>> +               goto unregister_plls;
>>> +
>>> +       platform_set_drvdata(pdev, clk_data);
>>> +
>>> +       return r;
>>> +
>>> +unregister_plls:
>>> +       mtk_clk_unregister_plls(vlp_plls, ARRAY_SIZE(vlp_plls), clk_data);
>>> +unregister_muxes:
>>> +       mtk_clk_unregister_muxes(vlp_muxes, ARRAY_SIZE(vlp_muxes), clk_data);
>>> +free_clk_data:
>>> +       mtk_free_clk_data(clk_data);
>>
>> The AFE driver sets some tuner parameters in the VLPCKGEN block at probe
>> time. Maybe we could do that here instead?
>>
>> /* vlp_cksys_clk: 0x1c016000 */
>> #define VLP_APLL1_TUNER_CON0 0x02a4
>> #define VLP_APLL2_TUNER_CON0 0x02a8
>>
>> /* vlp apll1 tuner default value*/
>> #define VLP_APLL1_TUNER_CON0_VALUE 0x6f28bd4d
>> /* vlp apll2 tuner default value + 1*/
>> #define VLP_APLL2_TUNER_CON0_VALUE 0x78fd5265
>>
>>        regmap_write(afe_priv->vlp_ck, VLP_APLL1_TUNER_CON0,
>> VLP_APLL1_TUNER_CON0_VALUE);
>>        regmap_write(afe_priv->vlp_ck, VLP_APLL2_TUNER_CON0,
>> VLP_APLL2_TUNER_CON0_VALUE);
>>
>> ChenYu
>>
>>> +
>>> +       return r;
>>> +}
>>> +
>>> +static void clk_mt8196_vlp_remove(struct platform_device *pdev)
>>> +{
>>> +       struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
>>> +       struct device_node *node = pdev->dev.of_node;
>>> +
>>> +       of_clk_del_provider(node);
>>> +       mtk_clk_unregister_plls(vlp_plls, ARRAY_SIZE(vlp_plls), clk_data);
>>> +       mtk_clk_unregister_muxes(vlp_muxes, ARRAY_SIZE(vlp_muxes), clk_data);
>>> +       mtk_free_clk_data(clk_data);
>>> +}
>>> +
>>> +static const struct of_device_id of_match_clk_mt8196_vlp_ck[] = {
>>> +       { .compatible = "mediatek,mt8196-vlpckgen" },
>>> +       { /* sentinel */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_vlp_ck);
>>> +
>>> +static struct platform_driver clk_mt8196_vlp_drv = {
>>> +       .probe = clk_mt8196_vlp_probe,
>>> +       .remove = clk_mt8196_vlp_remove,
>>> +       .driver = {
>>> +               .name = "clk-mt8196-vlpck",
>>> +               .of_match_table = of_match_clk_mt8196_vlp_ck,
>>> +       },
>>> +};
>>> +
>>> +MODULE_DESCRIPTION("MediaTek MT8196 VLP clock generator driver");
>>> +module_platform_driver(clk_mt8196_vlp_drv);
>>> +MODULE_LICENSE("GPL");
>>> --
>>> 2.39.5
>>>


