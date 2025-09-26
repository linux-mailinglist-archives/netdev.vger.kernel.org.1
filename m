Return-Path: <netdev+bounces-226736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FF0BA48FE
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C8A189A68A
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F176123817E;
	Fri, 26 Sep 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cg9+AN10"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E7823DD;
	Fri, 26 Sep 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903036; cv=none; b=l/F/OTlvmH2WHKVD1WslfMiU1AA7JAlmRikuR+7nFoV7n2WrbruAIC8x8ozZxddLgr6yqOp3/o4JK9bJCnBGc+XhATFWBptXQAWQLRSk3KiZREYv3yOb1vPVFRFp7KXlR13odH30plMagpHu9jpfSZ+3xI9fNbU2GWR68TaozW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903036; c=relaxed/simple;
	bh=pJH5Hrwro75kzGiHFMA0wqzpgMM0shT+yN0jZxl8B4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTscQoG/rslR8YtK49qF8E64aS2qXqQtVZStKHZCX2n9hLZvSXyHLrs9z9oJETuGHV85iuuQex8uf+09FkgWr1++Hm0G7TBd+1RGWNb1Li0LSAJ2ljMElPj5W4OFv9J9RH8YmonSlGrl8gukCRyP9wNGEKm+5VE+JtW7wJqMXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cg9+AN10; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a8ppqvzfJbHLORVI4FUGxAEtvpysmOlFWvNRW2iwm/E=; b=cg9+AN104PlZDbjadHhLemQ6P3
	2SECT9YE20k1+7x95YYYNw64/FuHB2bAG83MSCcNdmOFxUVGUxbju3lD93C6rwX26VOe8M9IEDEtz
	nZZJn3lRXRQC8dkazzykeIzR/huKAQJlAUgvHcvi+NpFW+Wj0XaBPBwZxqytRph6F2js=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v2B1g-009a97-KM; Fri, 26 Sep 2025 18:10:28 +0200
Date: Fri, 26 Sep 2025 18:10:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net: airoha: npu: Add 7583 SoC support
Message-ID: <b5ff2e06-df4f-423a-86ac-fb025b243844@lunn.ch>
References: <20250926-airoha-npu-7583-v1-0-447e5e2df08d@kernel.org>
 <20250926-airoha-npu-7583-v1-2-447e5e2df08d@kernel.org>
 <82a08bb5-cbc3-4bba-abad-393092d66557@lunn.ch>
 <aNa464zcFCvNhL33@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNa464zcFCvNhL33@lore-desk>

On Fri, Sep 26, 2025 at 06:01:47PM +0200, Lorenzo Bianconi wrote:
> > > -	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_DATA, dev);
> > > +	if (of_device_is_compatible(dev->of_node, "airoha,an7583-npu"))
> > > +		fw_name = NPU_AN7583_FIRMWARE_DATA;
> > > +	else
> > > +		fw_name = NPU_EN7581_FIRMWARE_DATA;
> > > +	ret = request_firmware(&fw, fw_name, dev);
> > >  	if (ret)
> > >  		return ret == -ENOENT ? -EPROBE_DEFER : ret;
> > >  
> > > @@ -612,6 +623,7 @@ EXPORT_SYMBOL_GPL(airoha_npu_put);
> > >  
> > >  static const struct of_device_id of_airoha_npu_match[] = {
> > >  	{ .compatible = "airoha,en7581-npu" },
> > > +	{ .compatible = "airoha,an7583-npu" },
> > 
> > It would be more normal to make use of the void * in of_device_id to
> > have per compatible data, such are firmware name.
> > 
> > 	Andrew
> 
> ack, I implemted this way since we have 2 fw names but we can have a struct
> pointed by of_device_id driver_data pointer to contains both of them.
> What do you think?

That would work.

	Andrew

