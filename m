Return-Path: <netdev+bounces-13421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC51873B862
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97096281B18
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FDB8835;
	Fri, 23 Jun 2023 13:07:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1AD79CF
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:07:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0BC2129
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687525617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+nlw8o0x9EmBbnewRBB9FOcSf2qgr1xezY4CpDaC89M=;
	b=dqGqlyik+K7vpvkYhcae8Oa26XEXAhC97ZeW0zP97e409/aneI/ePk2O+0Kxy/GavajD1e
	cPuWemHIah0KsgrlNjiX0Ycrn4i1Uaz0cQOSdeSuqzygSwsb9Is9CFCglNsslJiH+oMgM/
	SMqP33xJYP0xjv3WQztdrtzjdfQ6cc0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-559GTDCiMzCU8SClvUKgEg-1; Fri, 23 Jun 2023 09:06:55 -0400
X-MC-Unique: 559GTDCiMzCU8SClvUKgEg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-39fb9cce400so545949b6e.1
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 06:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687525615; x=1690117615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nlw8o0x9EmBbnewRBB9FOcSf2qgr1xezY4CpDaC89M=;
        b=TLL7l4DYHagv9GlaSD7mp2tpxOipSh5QGGanVgpEpERg/gPgu/rlCqOesHfmXcM5eX
         lBYWc8hRoyNh+Rtw3hoxTjmt6O4YT3YG3ju5EtTsFNRMiow0z49NebZXvj2g0jqJcpFe
         WrP6HrIjaS6K0RSa/V3d1X7qwPHS284h8jOFSS/ua/bWiaZwVAiYlTxTidYAjdEDSe6W
         DQeVkojrDFrUw6eLDtnCo/GRT3Zkloa+mtQIbnPgvdRgELt7QG+VdmDYsMST9D7SX6Rg
         acFZQ+BiI++ue0l6gywvuV5u+oLW67i0HUmjDstdEIVda4AaOpaIleMD8Z9uIWQAEHWj
         3lsg==
X-Gm-Message-State: AC+VfDwxNmaRyWcsf0a+beWA4Fzvhfwr/875VMMbrYpoMUApr3K6Kvpq
	BAf2fVL6DAnbBWYK0MRkKmPR8TSTEdyvjbt8OQz/3a8j5sk+subESBqCnmSk+xjEj9DokZZnz0V
	FCDglp5rWqzHmsU1X
X-Received: by 2002:a05:6808:1386:b0:39e:b84b:4786 with SMTP id c6-20020a056808138600b0039eb84b4786mr20204387oiw.27.1687525615071;
        Fri, 23 Jun 2023 06:06:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73eFqk8vQn5O2qswhndAQq+yzi1FAVd85HKmLTe2wlqJ6VQg6y5tF3WlSHMlgK/pA6NSAzsQ==
X-Received: by 2002:a05:6808:1386:b0:39e:b84b:4786 with SMTP id c6-20020a056808138600b0039eb84b4786mr20204357oiw.27.1687525614823;
        Fri, 23 Jun 2023 06:06:54 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id be18-20020a056808219200b003a05636f4a8sm2061949oib.29.2023.06.23.06.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 06:06:54 -0700 (PDT)
Date: Fri, 23 Jun 2023 08:06:51 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v2 00/12] net: stmmac: replace boolean fields in
 plat_stmmacenet_data with flags
Message-ID: <20230623130651.a36qensnjwx6j4ea@halaney-x13s>
References: <20230623100845.114085-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623100845.114085-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 12:08:33PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> As suggested by Jose Abreu: let's drop all 12 boolean fields in
> plat_stmmacenet_data and replace them with a common bitfield.
> 
> v1 -> v2:
> - fix build on intel platforms
> 
> Bartosz Golaszewski (12):
>   net: stmmac: replace the has_integrated_pcs field with a flag
>   net: stmmac: replace the sph_disable field with a flag
>   net: stmmac: replace the use_phy_wol field with a flag
>   net: stmmac: replace the has_sun8i field with a flag
>   net: stmmac: replace the tso_en field with a flag
>   net: stmmac: replace the serdes_up_after_phy_linkup field with a flag
>   net: stmmac: replace the vlan_fail_q_en field with a flag
>   net: stmmac: replace the multi_msi_en field with a flag
>   net: stmmac: replace the ext_snapshot_en field with a flag
>   net: stmmac: replace the int_snapshot_en field with a flag
>   net: stmmac: replace the rx_clk_runs_in_lpi field with a flag
>   net: stmmac: replace the en_tx_lpi_clockgating field with a flag
> 
>  .../stmicro/stmmac/dwmac-dwc-qos-eth.c        |  4 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 23 +++++------
>  .../ethernet/stmicro/stmmac/dwmac-mediatek.c  |  5 ++-
>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        |  8 ++--
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-tegra.c |  4 +-
>  .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c |  4 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 40 +++++++++++--------
>  .../net/ethernet/stmicro/stmmac/stmmac_pci.c  |  2 +-
>  .../ethernet/stmicro/stmmac/stmmac_platform.c | 10 +++--
>  .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  5 ++-
>  include/linux/stmmac.h                        | 26 ++++++------
>  12 files changed, 76 insertions(+), 57 deletions(-)
> 
> -- 
> 2.39.2
> 

The series looks proper to me:

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


