Return-Path: <netdev+bounces-90711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64B78AFCF2
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 01:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464AB1F21C41
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 23:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7F744C86;
	Tue, 23 Apr 2024 23:56:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3F446AC
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916604; cv=none; b=DsU0vvEaM9PmVOTeprJgDhKq8u323KmI4N0w0da1BVlBt3V0JeVUlJ5FXEhhEmfPQvtvd/XD4Oq0Yq81AvB2vI5upRpRYty/bBuff+lY11MTj4FkKgAbsmzO01/d/m6F7Ksvo1zrhJYJW/1PIJ1cGhJ+ebdS1eSrXUYPUQNxe3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916604; c=relaxed/simple;
	bh=rXXYh8Ia4WTXYIq9lC5Uh3/nGLQNNjfMaOOaGBd6vmw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olB+GRLoERs5BafCOCy5oq4S8SHLCqz6UPBUtjrua3e3LGRoKd0bkQoKhufAZ7wAvYEESLpbwOFeasZbZOJ2BW3ASEhVoV3oOBFrtE+7NuIuf5l5MoIaTN8FXU3DuiG+qHVQfAgwtt085JeDjctBXS4Wy9D31WBvIOBRgBThKAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 1f188d5c-01cd-11ef-abf4-005056bdd08f;
	Wed, 24 Apr 2024 02:56:39 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 02:56:37 +0300
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	Lee Jones <lee@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Duanqiang Wen <duanqiangwen@net-swift.com>,
	"open list:SYNOPSYS DESIGNWARE I2C DRIVER" <linux-i2c@vger.kernel.org>,
	"open list:WANGXUN ETHERNET DRIVER" <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/4] Define i2c_designware in a header file
Message-ID: <ZihKtSble151A5mT@surfacebook.localdomain>
References: <20240423233622.1494708-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423233622.1494708-1-florian.fainelli@broadcom.com>

Tue, Apr 23, 2024 at 04:36:18PM -0700, Florian Fainelli kirjoitti:
> This patch series depends upon the following two patches being applied:
> 
> https://lore.kernel.org/all/20240422084109.3201-1-duanqiangwen@net-swift.com/
> https://lore.kernel.org/all/20240422084109.3201-2-duanqiangwen@net-swift.com/
> 
> There is no reason why each driver should have to repeat the
> "i2c_designware" string all over the place, because when that happens we
> see the reverts like the above being necessary.

Isn't that a part of ABI between drivers, i.e. whenever ones want to
request_module() or so they need to know what they are doing, no?

-- 
With Best Regards,
Andy Shevchenko



