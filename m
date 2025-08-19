Return-Path: <netdev+bounces-214921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA35DB2BDCF
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 11:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DDE523A6F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552A72E718F;
	Tue, 19 Aug 2025 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ky3nvWSv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90EC253F03
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596758; cv=none; b=ZC3Tga15LOBaU/7K/mJ0ZNRUd3GOcGJFi+DzOYPVhl+aE0bbB6X4uaElFU8kPCvr46VbvnW6zE4ILk/sYTqdrUYUkV3zbkJ698eQ5V4mDqu/zhEXwdjWAROZdeZUaCZzWpYUnc3SMa1ueN3Q5exEw/6JTJmHC00ilj2Kprdh/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596758; c=relaxed/simple;
	bh=V/Oq678BArHS/pkn3z/1AG2tX/0VWyD29OgrHSZ5KYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxiXOmrkx1wXh4BxpflSzCgmKgnyvziSlu3QWwhIWiPq/RxoQsITGm73ORHAUXWzzFLPJzH8ekxGcaiIiKxWdVwqTmVrQwY+Ippv38H87qZk3D/IOHxQsDWATt0duGAF3WmG9UV16YFODUwKU27xT8xLFUAfORQQR4k7BIYyJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ky3nvWSv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 36A451A0CBC;
	Tue, 19 Aug 2025 09:45:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F3BA060697;
	Tue, 19 Aug 2025 09:45:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D1CB1C22D747;
	Tue, 19 Aug 2025 11:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755596754; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=V/Oq678BArHS/pkn3z/1AG2tX/0VWyD29OgrHSZ5KYs=;
	b=ky3nvWSvMoX2c+pvIhTj+cu1ov2JfLwOCNQzdenjwhDzyP15XnEafVUzBDGclQe7UiRLBF
	Lx0kJ9pOIEUf2aZoP10qr3Y6vADaSF2KMjB6p7sI3LKdie9W5CYg20qkZEr/QRJDjKqelp
	sSo4m4PyebziLqf2RZKOfFNuGVa74ZaXOsdlV8CqMV9N9BQ3mxl2I8WE0d+w5VdaXFu9nv
	KFbnOyin5ZSHH4ncKfo24m2iHalyUbot7UvVqS+BqnoTszYBculjmAAbLM9CWs5AEHvmUC
	orXR4REnEQLGDydkvqhTtHdKYYpkjjaMSxHGr/B5HKKfIsg48EeGlZc7p4sfGQ==
Message-ID: <6d664b4b-080f-442e-bb7e-4d220a16ccf4@bootlin.com>
Date: Tue, 19 Aug 2025 11:45:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] phy: ti: gmii-sel: Always write the RGMII ID setting
To: Michael Walle <mwalle@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andrew Lunn <andrew@lunn.ch>, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nm@ti.com,
 vigneshr@ti.com
References: <20250819065622.1019537-1-mwalle@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250819065622.1019537-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 19/08/2025 08:56, Michael Walle wrote:
> Some SoCs are just validated with the TX delay enabled. With commit
> ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed
> RGMII TX delay"), the network driver will patch the delay setting on the
> fly assuming that the TX delay setting is fixed. In reality, the TX
> delay is configurable and just skipped in the documentation. There are
> bootloaders, which will disable the TX delay and this will lead to a
> transmit path which doesn't add any delays at all.
> Fix that by always writing the RGMII_ID setting and report an error for
> unsupported RGMII delay modes.
>
> This is safe to do and shouldn't break any boards in mainline because
> the fixed delay is only introduced for gmii-sel compatibles which are
> used together with the am65-cpsw-nuss driver and also contains the
> commit above.
>
> Fixes: ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay")
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


