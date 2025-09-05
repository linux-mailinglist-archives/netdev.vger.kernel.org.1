Return-Path: <netdev+bounces-220189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D968B44B56
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 03:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514AB1884267
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 01:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164C21A9FB3;
	Fri,  5 Sep 2025 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arHvTfHr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543320EB;
	Fri,  5 Sep 2025 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757036984; cv=none; b=aMiuyQ+OFRh/r8yyopouJG2Sf6hwftIu6lBkBMUu2TEgkj8eLuT/Vk6geyTlLS5uIyQk7RLHYeuRsCRbYU/s77RjeIN1kFUWTSRvLv6xkbmOP5mVrbNIxJM9uboSuzyUiD9wHJUwqZPbPkndh539Ty7IOZSsfyuMrQbUA35JfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757036984; c=relaxed/simple;
	bh=Tu8dRLxfbouCfnvyFL1u/voFfdEj304GNbmJcjKPnMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XA5FJCdYvPkxq2/HEOB2xWIrayWuz9uYIj5/zB3C98jJwxwib/BWlRnVC2UalKCbTR9AMoD8o4Q3sYEIQHeVFsRwIYR6JFiI3hgDFCozrM4L82YK0JgtNDucg4mRf5PY+4keAZiyvudGpbBfnOQjuSjC/X1czGcoq5t6kg1wAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arHvTfHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41525C4CEF0;
	Fri,  5 Sep 2025 01:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757036983;
	bh=Tu8dRLxfbouCfnvyFL1u/voFfdEj304GNbmJcjKPnMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=arHvTfHr/x83tMaViDMhKMfNh5iHY6zBLv7spcIACyMHnOMYBO1aY1QaWGpRwfSCD
	 R40gX0f7KdksFVTam2Hvz4prnjP85wymEqPryhHgLM61yBNfezir9fdfqFL5a6kR7E
	 9XnG0cP+YN/xe09/qPyTKtFb2+fkvHpancnN7Pswh4nmR8KqfM3mLhvWYxKP/EEC7w
	 ocADly8+wcqAFffq+RHCroudIfMa7Md2iEXMGAL7u8Y2JP9DWVXHfun4TbfcARzozy
	 DRRBC14cxIg8PsjwK4oX7iuDP7JcTjO41WrAwTbI5zi9opR0+2u9PP66rkHpD9tdkj
	 JGCjdifIG8/fA==
Date: Thu, 4 Sep 2025 18:49:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrea della Porta <andrea.porta@suse.com>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Phil Elwell <phil@raspberrypi.com>, Jonathan
 Bell <jonathan@raspberrypi.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v2 0/5] dd ethernet support for RPi5
Message-ID: <20250904184941.207518c8@kernel.org>
In-Reply-To: <20250904184757.1f7fb839@kernel.org>
References: <20250822093440.53941-1-svarbanov@suse.de>
	<06017779-f03b-4006-8902-f0eb66a1b1a1@broadcom.com>
	<20250904184757.1f7fb839@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 18:47:57 -0700 Jakub Kicinski wrote:
> > netdev maintainers, I took patches 4 and 5 through the Broadcom ARM SoC 
> > tree, please take patches 1 through 3 inclusive, or let me know if I 
> > should take patch 2 as well.  
> 
> Thanks for the heads up! Let me take patch 3 right now.

s/patch 3/patch 2/

> I'm a bit unclear on where we landed with the parallel efforts to add
> the >32b address support :(


