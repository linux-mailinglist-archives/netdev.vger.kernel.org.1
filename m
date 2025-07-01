Return-Path: <netdev+bounces-202762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F1AEEEAF
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CB51BC4C49
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1725CC74;
	Tue,  1 Jul 2025 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POH/UCP4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72D24503F;
	Tue,  1 Jul 2025 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351201; cv=none; b=R3v6cpBCKqh1iC+I3s3iil0i41rhR5zqbtrxGvaBsmMp/0OQ2s8Ei6fJ0brO82nxrkyTkDrAddU7DZbb+vF/5mwk7FTjxoVfpsSP1aanvAVTpZSwNTwtsCWD3gL5Ojtu9VGAuMVP+jXCt2qrRpQLvZyhNZ1WJPEsMsbqHvhNsY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351201; c=relaxed/simple;
	bh=k/ticS7hIAAWxY9laIuFjHn3kYId2TOgfiR6jOhFUBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjUxD/gJcr+iWS8C+YpO/lLHse0DM1qx45rqKbs47Njl2+vc9n+S4Z+rOn7FWq0DW/kBZSu41RToPrUKmnD17CDzHxWKdLnxdIgY2f4xB3QSAYEXiVTIOGdpEHRifYLxc17Q5TRuoE+rY1BycJovOAzTmd10jdC2UGfhEftGHuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POH/UCP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC5FC4CEEB;
	Tue,  1 Jul 2025 06:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751351201;
	bh=k/ticS7hIAAWxY9laIuFjHn3kYId2TOgfiR6jOhFUBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=POH/UCP42qv1aCRSzVAaU2IDqIdvF0SihBBqRF1GtoqeNKrysTCFQ34LndoWUQbok
	 06mVAiNlLtZLccSNPpqMvKx7ieF10csL/fx/QTY8c+6odRjopiT45TT9w0VN1ufeeo
	 Rh23X8wfltIejM5NgyZjnXuyJz6kpiIrtDC9DdgL7OopQr5OQImHAJnAkYppZGBScv
	 ULhD53XlLzJBJ6Z/zJzgO7RMhQ2RgdFQBhxGhZpqf5xzImI9g/wIh3D8sLfYorsydZ
	 YvBvz+5jj2StYPpEtyiLJwaf82CGFSnXJsuVlgXYmz45STnnHT+NxsHgcOyMmUx2TQ
	 l2SLAa7FXaowQ==
Message-ID: <a5107266-853e-4658-ba90-d6a08882d2a8@kernel.org>
Date: Tue, 1 Jul 2025 08:26:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC v4 0/4] riscv: dts: sophgo: Add ethernet
 support for cv18xx
To: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Yixun Lan <dlan@gentoo.org>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Longbin Li <looong.bin@gmail.com>
References: <20250701011730.136002-1-inochiama@gmail.com>
 <vxnvovuetfd6rzgaenwplpkhxm62fhw6t3vi4wkyigul7p4bkx@pwlprna4pyul>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <vxnvovuetfd6rzgaenwplpkhxm62fhw6t3vi4wkyigul7p4bkx@pwlprna4pyul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/07/2025 03:23, Inochi Amaoto wrote:
> On Tue, Jul 01, 2025 at 09:17:25AM +0800, Inochi Amaoto wrote:
>> Add device binding and dts for CV18XX series SoC, this dts change series
>> required the reset patch [1] for the dts, which is already taken.
>>
>> [1] https://lore.kernel.org/all/20250617070144.1149926-1-inochiama@gmail.com
>>
>> The patch is marked as RFC as it require reset dts.
>>
>> Change from RFC v3:
>> - https://lore.kernel.org/all/20250626080056.325496-1-inochiama@gmail.com
>> 1. patch 3: change internal phy id from 0 to 1
>>
>> Change from RFC v2:
>> - https://lore.kernel.org/all/20250623003049.574821-1-inochiama@gmail.com
>> 1. patch 1: fix wrong binding title
>> 2. patch 3: fix unmatched mdio bus number
>> 3. patch 4: remove setting phy-mode and phy-handle in board dts and move
>> 	    them into patch 3.
>>
>> Change from RFC v1:
>> - https://lore.kernel.org/all/20250611080709.1182183-1-inochiama@gmail.com
>> 1. patch 3: switch to mdio-mux-mmioreg
>> 2. patch 4: add configuration for Huashan Pi
>>
>> Inochi Amaoto (4):
>>   dt-bindings: net: Add support for Sophgo CV1800 dwmac
>>   riscv: dts: sophgo: Add ethernet device for cv18xx
>>   riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
>>   riscv: dts: sophgo: Enable ethernet device for Huashan Pi
>>
>>  .../bindings/net/sophgo,cv1800b-dwmac.yaml    | 113 ++++++++++++++++++
>>  arch/riscv/boot/dts/sophgo/cv180x.dtsi        |  73 +++++++++++
>>  .../boot/dts/sophgo/cv1812h-huashan-pi.dts    |   8 ++
>>  3 files changed, 194 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
>>
>> --
>> 2.50.0
>>
> 
> As this is mark as RFC due to the reset dependency, now it is OK
> to merge it as the reset patch is taken and this patch is a minor
> change . I hopeif anyone can take the binding patch so I can take
> the devicetree patches.

I don't understand why you target net-next with your DTS patches. The
subject prefix is here not correct and probably this should be split.
Anyway, bindings have issues, so no, it cannot be merged.

Best regards,
Krzysztof

