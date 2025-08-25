Return-Path: <netdev+bounces-216478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006BDB33FD5
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6143188E49B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E4D1D5178;
	Mon, 25 Aug 2025 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yu9AahQ2"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B2F3594F;
	Mon, 25 Aug 2025 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126015; cv=none; b=OYvSgQE9ilB2Z69yosJujTKAxCYUAdD1ctGRPH4eUPHL3/ixo8UrwZucmDx1M1cDajI1nOk8e6TSmm0/ODVRaTdXe5PlV7pq0NcrfGXjURtj4FIoDcf4numLdRjXLB724C4GiUMkogDPqeNTBn2bnlFz0QEhwXyygwEPoXykc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126015; c=relaxed/simple;
	bh=hdy4i+IJfDmwPUeO0cQIvZ6/j/3qKI3BuBU2aJFSg0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzVhu2V+zH95Q90HC5TKWups7MIAjZriZNN92vQGVQXzdzHloMnKnhtSGItQOPsh0SuwdJoFnlPFmr9KX2/TLMERvvhS6Td6noHajhItKxz3w4RNCxwavM6VGKRCXUjDwL3wtIESFbVDMPT5w6To4NfIVeFp9Hdo/wBIy9qoEc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Yu9AahQ2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756126011;
	bh=hdy4i+IJfDmwPUeO0cQIvZ6/j/3qKI3BuBU2aJFSg0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yu9AahQ29E2OcaroLuixc58t06V5qpugBL3v7xQ4wGfKR0RFiOz7OjE0Z8Z8kDbgJ
	 izBXwzTw7LeLQG+0ZnYd4MQJNB+OhAJ/z7dYGDuwaNGO+gSa2HjbgtyzuO7mt2I7J7
	 sx8B+Lg68Lqo0tjX9J0i7mh/CUGG4zDcBUeZs/SV1swi3g4MedompFeSZPrAhw3wDG
	 ctVt0T/eP4RvjudZzf+scoyRFolLUZ0J6YvtE0WhkT3k4r3n6ZnNhOVrGQEGQmuECh
	 iJZrSFMdxiE28BYebHd+3kYUyzGmuNIP3fdmhSEHRQWVQ6muzjjVn8zQIxcJy6UNq2
	 lFa+Yhhn+gazA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:b1df:895a:e67b:5cd4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B97BA17E0523;
	Mon, 25 Aug 2025 14:46:50 +0200 (CEST)
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
	nfraprado@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com,
	robh@kernel.org,
	sboyd@kernel.org
Subject: Re: [PATCH v4 05/27] clk: mediatek: clk-mux: Add ops for mux gates with HW voter and FENC
Date: Mon, 25 Aug 2025 14:45:48 +0200
Message-Id: <20250825124548.209157-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAGXv+5GyKoTb3iQTuQPWEc5Ewa+kr4dJUET8sAFRZ7T5RyNzLQ@mail.gmail.com>
References: <CAGXv+5GyKoTb3iQTuQPWEc5Ewa+kr4dJUET8sAFRZ7T5RyNzLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/15/25 05:31, Chen-Yu Tsai wrote:
> On Tue, Aug 5, 2025 at 10:55 PM Laura Nao <laura.nao@collabora.com> wrote:
>>
>> MT8196 use a HW voter for mux gate enable/disable control, along with a
>> FENC status bit to check the status. Voting is performed using
>> set/clr/upd registers, with a status bit used to verify the vote state.
>> Add new set of mux gate clock operations with support for voting via
>> set/clr/upd regs and FENC status logic.
>>
>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>  drivers/clk/mediatek/clk-mtk.h |  1 +
>>  drivers/clk/mediatek/clk-mux.c | 71 +++++++++++++++++++++++++++++++++-
>>  drivers/clk/mediatek/clk-mux.h | 42 ++++++++++++++++++++
>>  3 files changed, 113 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
>> index 8ed2c9208b1f..e2cefd9bc5b8 100644
>> --- a/drivers/clk/mediatek/clk-mtk.h
>> +++ b/drivers/clk/mediatek/clk-mtk.h
>> @@ -20,6 +20,7 @@
>>
>>  #define MHZ (1000 * 1000)
>>
>> +#define MTK_WAIT_HWV_DONE_US   30
>>  #define MTK_WAIT_FENC_DONE_US  30
>>
>>  struct platform_device;
>> diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
>> index b1b8eeb0b501..65889fc6a3e5 100644
>> --- a/drivers/clk/mediatek/clk-mux.c
>> +++ b/drivers/clk/mediatek/clk-mux.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/clk-provider.h>
>>  #include <linux/compiler_types.h>
>>  #include <linux/container_of.h>
>> +#include <linux/dev_printk.h>
>>  #include <linux/err.h>
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/module.h>
>> @@ -21,6 +22,7 @@
>>  struct mtk_clk_mux {
>>         struct clk_hw hw;
>>         struct regmap *regmap;
>> +       struct regmap *regmap_hwv;
>>         const struct mtk_mux *data;
>>         spinlock_t *lock;
>>         bool reparent;
>> @@ -118,6 +120,41 @@ static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
>>         return (val & BIT(mux->data->gate_shift)) == 0;
>>  }
>>
>> +static int mtk_clk_mux_hwv_fenc_enable(struct clk_hw *hw)
>> +{
>> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
>> +       u32 val;
>> +       int ret;
>> +
>> +       regmap_write(mux->regmap_hwv, mux->data->hwv_set_ofs,
>> +                    BIT(mux->data->gate_shift));
>> +
>> +       ret = regmap_read_poll_timeout_atomic(mux->regmap_hwv, mux->data->hwv_sta_ofs,
>> +                                             val, val & BIT(mux->data->gate_shift), 0,
>> +                                             MTK_WAIT_HWV_DONE_US);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = regmap_read_poll_timeout_atomic(mux->regmap, mux->data->fenc_sta_mon_ofs,
>> +                                             val, val & BIT(mux->data->fenc_shift), 1,
>> +                                             MTK_WAIT_FENC_DONE_US);
>> +
>> +       return ret;
>> +}
>> +
>> +static void mtk_clk_mux_hwv_disable(struct clk_hw *hw)
>> +{
>> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
>> +       u32 val;
>> +
>> +       regmap_write(mux->regmap_hwv, mux->data->hwv_clr_ofs,
>> +                    BIT(mux->data->gate_shift));
>> +
>> +       regmap_read_poll_timeout_atomic(mux->regmap_hwv, mux->data->hwv_sta_ofs,
>> +                                       val, (val & BIT(mux->data->gate_shift)),
>> +                                       0, MTK_WAIT_HWV_DONE_US);
>> +}
>> +
>>  static u8 mtk_clk_mux_get_parent(struct clk_hw *hw)
>>  {
>>         struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
>> @@ -189,6 +226,14 @@ static int mtk_clk_mux_determine_rate(struct clk_hw *hw,
>>         return clk_mux_determine_rate_flags(hw, req, mux->data->flags);
>>  }
>>
>> +static bool mtk_clk_mux_uses_hwv(const struct clk_ops *ops)
>> +{
>> +       if (ops == &mtk_mux_gate_hwv_fenc_clr_set_upd_ops)
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>>  const struct clk_ops mtk_mux_clr_set_upd_ops = {
>>         .get_parent = mtk_clk_mux_get_parent,
>>         .set_parent = mtk_clk_mux_set_parent_setclr_lock,
>> @@ -216,9 +261,20 @@ const struct clk_ops mtk_mux_gate_fenc_clr_set_upd_ops = {
>>  };
>>  EXPORT_SYMBOL_GPL(mtk_mux_gate_fenc_clr_set_upd_ops);
>>
>> +const struct clk_ops mtk_mux_gate_hwv_fenc_clr_set_upd_ops = {
>> +       .enable = mtk_clk_mux_hwv_fenc_enable,
>> +       .disable = mtk_clk_mux_hwv_disable,
>> +       .is_enabled = mtk_clk_mux_fenc_is_enabled,
>> +       .get_parent = mtk_clk_mux_get_parent,
>> +       .set_parent = mtk_clk_mux_set_parent_setclr_lock,
>> +       .determine_rate = mtk_clk_mux_determine_rate,
>> +};
>> +EXPORT_SYMBOL_GPL(mtk_mux_gate_hwv_fenc_clr_set_upd_ops);
>> +
>>  static struct clk_hw *mtk_clk_register_mux(struct device *dev,
>>                                            const struct mtk_mux *mux,
>>                                            struct regmap *regmap,
>> +                                          struct regmap *regmap_hwv,
>>                                            spinlock_t *lock)
>>  {
>>         struct mtk_clk_mux *clk_mux;
>> @@ -234,8 +290,13 @@ static struct clk_hw *mtk_clk_register_mux(struct device *dev,
>>         init.parent_names = mux->parent_names;
>>         init.num_parents = mux->num_parents;
>>         init.ops = mux->ops;
>> +       if (mtk_clk_mux_uses_hwv(init.ops) && !regmap_hwv) {
>> +               dev_err(dev, "regmap not found for hardware voter clocks\n");
>> +               return ERR_PTR(-ENXIO);
>> +       }
>>
>>         clk_mux->regmap = regmap;
>> +       clk_mux->regmap_hwv = regmap_hwv;
>>         clk_mux->data = mux;
>>         clk_mux->lock = lock;
>>         clk_mux->hw.init = &init;
>> @@ -268,6 +329,7 @@ int mtk_clk_register_muxes(struct device *dev,
>>                            struct clk_hw_onecell_data *clk_data)
>>  {
>>         struct regmap *regmap;
>> +       struct regmap *regmap_hwv;
>>         struct clk_hw *hw;
>>         int i;
>>
>> @@ -277,6 +339,13 @@ int mtk_clk_register_muxes(struct device *dev,
>>                 return PTR_ERR(regmap);
>>         }
>>
>> +       regmap_hwv = mtk_clk_get_hwv_regmap(node);
>> +       if (IS_ERR(regmap_hwv)) {
>> +               pr_err("Cannot find hardware voter regmap for %pOF: %pe\n",
>> +                      node, regmap_hwv);
>> +               return PTR_ERR(regmap_hwv);
>
> Is there a reason why we aren't using dev_err() or even dev_err_probe()
> here?
>

Not really, just got swayed by the surrounding pr_* calls. I’ll fix it
here and in the other mtk_clk_get_hwv_regmap call. We can clean up the
remaining pr_* calls in a separate patch.

Thanks,

Laura

> The rest looks OK.
>
> ChenYu
>
>> +       }
>> +
>>         for (i = 0; i < num; i++) {
>>                 const struct mtk_mux *mux = &muxes[i];
>>
>> @@ -286,7 +355,7 @@ int mtk_clk_register_muxes(struct device *dev,
>>                         continue;
>>                 }
>>
>> -               hw = mtk_clk_register_mux(dev, mux, regmap, lock);
>> +               hw = mtk_clk_register_mux(dev, mux, regmap, regmap_hwv, lock);
>>
>>                 if (IS_ERR(hw)) {
>>                         pr_err("Failed to register clk %s: %pe\n", mux->name,
>> diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
>> index c65cfb7f8fc3..fb6f7951379c 100644
>> --- a/drivers/clk/mediatek/clk-mux.h
>> +++ b/drivers/clk/mediatek/clk-mux.h
>> @@ -28,6 +28,10 @@ struct mtk_mux {
>>         u32 set_ofs;
>>         u32 clr_ofs;
>>         u32 upd_ofs;
>> +
>> +       u32 hwv_set_ofs;
>> +       u32 hwv_clr_ofs;
>> +       u32 hwv_sta_ofs;
>>         u32 fenc_sta_mon_ofs;
>>
>>         u8 mux_shift;
>> @@ -80,6 +84,7 @@ struct mtk_mux {
>>  extern const struct clk_ops mtk_mux_clr_set_upd_ops;
>>  extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
>>  extern const struct clk_ops mtk_mux_gate_fenc_clr_set_upd_ops;
>> +extern const struct clk_ops mtk_mux_gate_hwv_fenc_clr_set_upd_ops;
>>
>>  #define MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,     \
>>                         _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
>> @@ -121,6 +126,43 @@ extern const struct clk_ops mtk_mux_gate_fenc_clr_set_upd_ops;
>>                         0, _upd_ofs, _upd, CLK_SET_RATE_PARENT,         \
>>                         mtk_mux_clr_set_upd_ops)
>>
>> +#define MUX_GATE_HWV_FENC_CLR_SET_UPD_FLAGS(_id, _name, _parents,                      \
>> +                               _mux_ofs, _mux_set_ofs, _mux_clr_ofs,                   \
>> +                               _hwv_sta_ofs, _hwv_set_ofs, _hwv_clr_ofs,               \
>> +                               _shift, _width, _gate, _upd_ofs, _upd,                  \
>> +                               _fenc_sta_mon_ofs, _fenc, _flags) {                     \
>> +                       .id = _id,                                                      \
>> +                       .name = _name,                                                  \
>> +                       .mux_ofs = _mux_ofs,                                            \
>> +                       .set_ofs = _mux_set_ofs,                                        \
>> +                       .clr_ofs = _mux_clr_ofs,                                        \
>> +                       .hwv_sta_ofs = _hwv_sta_ofs,                                    \
>> +                       .hwv_set_ofs = _hwv_set_ofs,                                    \
>> +                       .hwv_clr_ofs = _hwv_clr_ofs,                                    \
>> +                       .upd_ofs = _upd_ofs,                                            \
>> +                       .fenc_sta_mon_ofs = _fenc_sta_mon_ofs,                          \
>> +                       .mux_shift = _shift,                                            \
>> +                       .mux_width = _width,                                            \
>> +                       .gate_shift = _gate,                                            \
>> +                       .upd_shift = _upd,                                              \
>> +                       .fenc_shift = _fenc,                                            \
>> +                       .parent_names = _parents,                                       \
>> +                       .num_parents = ARRAY_SIZE(_parents),                            \
>> +                       .flags =  _flags,                                               \
>> +                       .ops = &mtk_mux_gate_hwv_fenc_clr_set_upd_ops,                  \
>> +               }
>> +
>> +#define MUX_GATE_HWV_FENC_CLR_SET_UPD(_id, _name, _parents,                            \
>> +                               _mux_ofs, _mux_set_ofs, _mux_clr_ofs,                   \
>> +                               _hwv_sta_ofs, _hwv_set_ofs, _hwv_clr_ofs,               \
>> +                               _shift, _width, _gate, _upd_ofs, _upd,                  \
>> +                               _fenc_sta_mon_ofs, _fenc)                               \
>> +                       MUX_GATE_HWV_FENC_CLR_SET_UPD_FLAGS(_id, _name, _parents,       \
>> +                               _mux_ofs, _mux_set_ofs, _mux_clr_ofs,                   \
>> +                               _hwv_sta_ofs, _hwv_set_ofs, _hwv_clr_ofs,               \
>> +                               _shift, _width, _gate, _upd_ofs, _upd,                  \
>> +                               _fenc_sta_mon_ofs, _fenc, 0)
>> +
>>  #define MUX_GATE_FENC_CLR_SET_UPD_FLAGS(_id, _name, _parents, _paridx,         \
>>                         _num_parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,     \
>>                         _shift, _width, _gate, _upd_ofs, _upd,                  \
>> --
>> 2.39.5
>>

