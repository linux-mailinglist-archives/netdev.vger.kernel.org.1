Return-Path: <netdev+bounces-63544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4AC82DCD5
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 16:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841901C21C18
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9513B17996;
	Mon, 15 Jan 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gFL5GVht"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6FC17980
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 87CC61BF20C;
	Mon, 15 Jan 2024 15:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705334330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2s+j48ZaXgPUXaAjq8MYuqL1+p2AAMg2Z7Hh1x4Cp8=;
	b=gFL5GVhtrrzs8HvciRc1ygotvqvIYlNXM0QUJCabHST6S5wIstH9duAy0kk/hyM1ky61NG
	I85w7D/qOlyhA6BRvaMzvJO5LPYQ++0K2dkUnqJJFLjWTc1gy9Y3ywOs/as9B6sh0PjOZ0
	M159/TfTg2yUoPmWSNDM+kOy2cYO2/3oXsB8fXMyAfKrte0M8Q1bp7W4nvlBxcCTNLaYJ2
	bhVSquZkkeHjIGc/vyNOSJF/odMBfubtgv+pcICJQOOWEQWO8gntwDi8F0kMeDv14JDRXK
	dlsccRxgJ7G1fIWQcuO7V5TNIepyCZXNiXTHlgDV5GOENr/QLpRjkhbm+RKEcw==
Date: Mon, 15 Jan 2024 16:58:48 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: sfp-bus: fix SFP mode detect from bitrate
Message-ID: <20240115165848.110ad8f9@device-28.home>
In-Reply-To: <E1rPMJW-001Ahf-L0@rmk-PC.armlinux.org.uk>
References: <E1rPMJW-001Ahf-L0@rmk-PC.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Russell,

On Mon, 15 Jan 2024 12:43:38 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> The referenced commit moved the setting of the Autoneg and pause bits
> early in sfp_parse_support(). However, we check whether the modes are
> empty before using the bitrate to set some modes. Setting these bits
> so early causes that test to always be false, preventing this working,
> and thus some modules that used to work no longer do.
> 
> Move them just before the call to the quirk.
> 
> Fixes: 8110633db49d ("net: sfp-bus: allow SFP quirks to override Autoneg and pause bits")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I don't have modules to trigger the bug, however the fix looks OK to me.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime


