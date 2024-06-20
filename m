Return-Path: <netdev+bounces-105336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9980C910822
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C456282E96
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7404D1AE0BC;
	Thu, 20 Jun 2024 14:26:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA521AE09C;
	Thu, 20 Jun 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893580; cv=none; b=DBw9YWMmLDDUFVTLCFkKuS01dLWAQ2HSFSthczU803OVtM4mgAHzdYvv+7DzxmkVcCYft+xn5cq66gcAOvCn+BLVVoo7GxVfjlTF/fAB20x1hCRtd81ZAKgMnLli+SP9/6SYLpIswEDJaHstbtEmk+gA/mUNT3e48prXhFe0hnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893580; c=relaxed/simple;
	bh=v4/Y0Brkjokk9Q16BCvSklcARCeaZDYKuPQ9dJKC9hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpvXD1ZkuMvkYWccI3Rt+XWJrPAKks/XgjrSIy4bc27S+SFLOstCTF8WgZ6prFgbIyEqOU683T1apUeNLOe4stzJBGqLL7VzPKKSTMu2+kksC+CcgwMp7JuuQ01pYkoEnKqwyDth95m6+ZTPDz78/Ms0Ahx7fE3VcriB0hfEfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cc8.versanet.de ([94.134.12.200] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sKIjk-00065o-HX; Thu, 20 Jun 2024 16:26:04 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Johan Jonker <jbx6244@gmail.com>, davem@davemloft.net,
 edumazet@google.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] net: ethernet: arc: remove emac_arc driver
Date: Thu, 20 Jun 2024 16:26:03 +0200
Message-ID: <4777231.1oUyQt6lIG@diego>
In-Reply-To: <20240620063729.55702736@kernel.org>
References:
 <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
 <7d208e8c8bb577cfc790fd24cf990684020ee7c5.camel@redhat.com>
 <20240620063729.55702736@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 20. Juni 2024, 15:37:29 CEST schrieb Jakub Kicinski:
> On Thu, 20 Jun 2024 15:19:24 +0200 Paolo Abeni wrote:
> > AFAICS this depends on the previous DT patch, which in turn should go
> > via the arm tree.
> > 
> > Perhaps the whole series should go via the arm tree?
> 
> FWIW Heiko said on patch 1 that the whole thing should go via netdev...

yep.

Reasoning is that the rk3066 is mostly inactive, so taking that dt-patch
through the net-tree won't create conflicts with other dt-changes here.

And of course both binding and driver changes are the bigger parts
of this series.





