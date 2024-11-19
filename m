Return-Path: <netdev+bounces-146180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1369D232B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091ED1F2162A
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F54F1C2DA2;
	Tue, 19 Nov 2024 10:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF91876;
	Tue, 19 Nov 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011307; cv=none; b=qc0F9PdF1XF7VL9jTXuhE656MzXt5L6ZgMHQlxMsIz9fKqVrmpAyaRA2HFko7+4VKMeLIaeb/2slIf72Nl9vo0KNS1WyKP8Q+yWcYntsnAN3wjwfeRCgurjugx+3F1P2hHH35Ub6FE8zQaeD2UAnXftI0wL9IEusDN3nFQDUVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011307; c=relaxed/simple;
	bh=adwGfsilUMi3V5aZhM2GAj65SgLVx75+TCUVrp+qcyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHf6uaBmpOyUbNRQyVrEzzOXdduig3LAKE0GAFIGJanfwpmq4hw7c5+1wwsAgOxyP/+aWe3DJ/LWI0MnR0rdXtdcHRhlOJWIcSDPxl4B7dWQ8yPvJFOc+CEZlif7SyLjRtMrUSLReTyU3Y539Ams+Ntz0C1Od+tcmDiZoeMST4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 8C16EC08A3;
	Tue, 19 Nov 2024 11:07:09 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] ieee802154: ca8210: Add missing check for kfifo_alloc() in ca8210_probe()
Date: Tue, 19 Nov 2024 11:06:46 +0100
Message-ID: <173201035742.581024.16670824289268407863.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029182712.318271-1-keisuke.nishimura@inria.fr>
References: <20241029182712.318271-1-keisuke.nishimura@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Keisuke Nishimura.

On Tue, 29 Oct 2024 19:27:12 +0100, Keisuke Nishimura wrote:
> ca8210_test_interface_init() returns the result of kfifo_alloc(),
> which can be non-zero in case of an error. The caller, ca8210_probe(),
> should check the return value and do error-handling if it fails.
> 
> 

Applied to wpan/wpan.git, thanks!

[1/1] ieee802154: ca8210: Add missing check for kfifo_alloc() in ca8210_probe()
      https://git.kernel.org/wpan/wpan/c/2c87309ea741

regards,
Stefan Schmidt

