Return-Path: <netdev+bounces-47202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142697E8C61
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 20:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1944280D68
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 19:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881541CF9A;
	Sat, 11 Nov 2023 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wrf9XsfL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2901D523
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 19:52:15 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8913AA6
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 11:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=A4RnEtUcfGm5L2IgI9SFGuT20I3jVtUiO6RFteWI3XM=; b=wrf9XsfLHifjA9q1u8pIq7SLf3
	17fPOELfCyalN1W8Hvddw1f4Y2mAIdf+thxjsZSASQD824e7qRyyCQ95xHW1oqAr8MiiZzCz8ASL+
	2ylwRDoDNEP28EH4MHcrnL7YCpuqrYAQ8Pd/BtDHWinc80YzvJKEONKteHRJFunTTxlE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r1u1M-001N62-W0; Sat, 11 Nov 2023 20:51:56 +0100
Date: Sat, 11 Nov 2023 20:51:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v5 2/9] net: stmmac: Allow platforms to set irq_flags
Message-ID: <111eed66-afd6-4ae9-acc6-1e32639051cc@lunn.ch>
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <e18edf4ab0a83de235fa3475eee4ba8ac88ee651.1699533745.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e18edf4ab0a83de235fa3475eee4ba8ac88ee651.1699533745.git.siyanteng@loongson.cn>

On Fri, Nov 10, 2023 at 05:25:41PM +0800, Yanteng Si wrote:
> Some platforms need extra irq flags when request multi msi, add
> irq_flags variable for them.

It would be nice to document what flags are needed.

You also seem to be pass the same flags to all instances of
request_irq. However, the flags should be specific to one irq.  So you
need irq_irq_flags, wol_irq_flags, lpi_irq_flags, etc.


    Andrew

---
pw-bot: cr

