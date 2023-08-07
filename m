Return-Path: <netdev+bounces-25173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3CC77319D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8306B1C20D63
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE4517743;
	Mon,  7 Aug 2023 21:48:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926BE17AA2
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:48:52 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7C91FF6;
	Mon,  7 Aug 2023 14:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wjf3II9tQSsHptZP1wnX0uw0+rk0u8g53PPdZQ7RlSY=; b=BuQ44GeBKgQB4uW6Dw4xQ1krIz
	8IYQ6MpAT3xZeih6OTR/LEGVNprorScrMil3MXmFiO/z0YfGAiiNubYDnSa8r3JTOy7YsRnFkYS6n
	6uZGDdJ+mGzA+HKYD1BVOX+izS0EGkQG+NZ4WN81BheV/jN4QLiU8d/h5LdNIYDbJTtI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qT85Q-003Oh5-65; Mon, 07 Aug 2023 23:48:24 +0200
Date: Mon, 7 Aug 2023 23:48:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/9] arm64: dts: qcom: sa8775p: add a node for the second
 serdes PHY
Message-ID: <c52b2eed-d546-4027-bfb9-f3d964f025a9@lunn.ch>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-2-brgl@bgdev.pl>
 <qdagbipfnukpsn5a7f6hswbktrwutizluf3zom2gq6q4q6w6df@h4lkoi3mjzes>
 <b5e30baf-4cf4-4a7f-aa2f-348de843226f@lunn.ch>
 <ann5dn236wyjoz2v3lmvihh2f5ses7nwy7lpqlkpoxvpcxgbjp@7ys6bkodptek>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ann5dn236wyjoz2v3lmvihh2f5ses7nwy7lpqlkpoxvpcxgbjp@7ys6bkodptek>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> That wording of "match downstream sources" is amiguous, sorry.
> 
> What I meant was that:
> 
>     1. This looks like a properly formatted dtsi node, follows
>        conventions in the file for ordering, etc
>     2. The downstream devicetree from Qualcomm uses the same MMIO region
>        same dependencies for clocks, etc. I do not have documentation
>        to further review past that

O.K. This does make your reviews worthwhile.

Vendor crap gets that name for a reason. So just saying it is the same
as the vendor code is not really helpful. So i would avoid this
ambiguous statement. And your later comment on a patch which points
out real problems adds to my confidence you did a real review.

Thanks
	  Andrew


