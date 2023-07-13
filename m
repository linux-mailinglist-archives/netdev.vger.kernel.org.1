Return-Path: <netdev+bounces-17336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA467514FD
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC9C281A17
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 00:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C067E;
	Thu, 13 Jul 2023 00:08:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82217C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0A4C433C7;
	Thu, 13 Jul 2023 00:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689206921;
	bh=nysdcT2cBEpDaFUZWVjOSDnDzGwTJjiXyeiRueCcw/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bWAJ2I3kbhM1bv9xahRC2XsdjBoi/vP/cwKTwGSnGeUdki5eLDrpGBroYR5ojZ0Fm
	 YrtZKQn1W5d7zN01Gg/erIUIHpBb9SqY4Ox04dFDE9R40TXDon9nUEsjdhrkCwsk19
	 RAqA1MGd2OL46aCkU+j+WIe5XcEhOZWH9RlVtcetMNNv+d6ta8Z2mEK1syauTF1KAD
	 cdwFw96lSlVDOqexmNdzDOcXey3jpQ28zlSwDtE5pMqV13pgh5HU2LryJK+oucfQx9
	 BKx/5dr53i/cdI/fWdfp565ePj2a36miyEMdMgQ6h/SEqlpPBLBozDo4N6cdzc0DNz
	 EM9T69GBkBQ3A==
Date: Wed, 12 Jul 2023 17:08:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 joabreu@synopsys.com, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowskii+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] net: dwmac_socfpga: use the standard "ahb" reset
Message-ID: <20230712170840.3d66da6a@kernel.org>
In-Reply-To: <20230710211313.567761-2-dinguyen@kernel.org>
References: <20230710211313.567761-1-dinguyen@kernel.org>
	<20230710211313.567761-2-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 16:13:13 -0500 Dinh Nguyen wrote:
> -	dwmac->stmmac_ocp_rst = devm_reset_control_get_optional(dev, "stmmaceth-ocp");
> -	if (IS_ERR(dwmac->stmmac_ocp_rst)) {
> -		ret = PTR_ERR(dwmac->stmmac_ocp_rst);
> -		dev_err(dev, "error getting reset control of ocp %d\n", ret);
> -		goto err_remove_config_dt;
> -	}
> -
> -	reset_control_deassert(dwmac->stmmac_ocp_rst);

Noob question, perhaps - what's the best practice for incompatible
device tree changes? Updating the in-tree definitions is good enough?
Seems like we could quite easily continue to support "stmmaceth-ocp"
but no point complicating the code if not required.

