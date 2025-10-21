Return-Path: <netdev+bounces-231043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD982BF42DB
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 02:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8832E3A52BE
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 00:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1361922FD;
	Tue, 21 Oct 2025 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqoo2JAq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195617736;
	Tue, 21 Oct 2025 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007769; cv=none; b=tMNzwDuy9qxtG1BmJP3yNfXBp/OXieroBzp8zIyDIJwSi3xTee8kuX7aZ5hZHX0h9Q12lOg3qjTVba7aRz2zHHexcUYW7EdnrlYlC2m4z1ngsbJE2ttqMnXg795fyke6GtsrvpqdiKaA/vIdjNa1KYhjhsTGHnbZfhAY1Ah68kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007769; c=relaxed/simple;
	bh=r0SRqh0K/5CeBJ5oVQRkSGK/ydvO1n0dQnYqh5+SFbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4X3VRtSO3KSEJBgmizxOPWvUL+4Z/CU3wd3CEL2Kr+2P+ieCJ+sVPO3v2cNuZIxeq/4DD6GeCPaPN5ZRprmJJ/2QGXha6GgcWRUKtl9HyYviVxuVPzHe31p3PyFTwZDFZae2A/a85rOZbsGsPvqEvL8gjqfnGVi/JCom8SZHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqoo2JAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F366DC4CEFB;
	Tue, 21 Oct 2025 00:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007768;
	bh=r0SRqh0K/5CeBJ5oVQRkSGK/ydvO1n0dQnYqh5+SFbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pqoo2JAq7ivbC+kgC/w+jiSg70nh6l8h9uTxjfjKBxpd5JlgDMj7wofWNOGrk+zWq
	 ALAKOtrifQQK2zmQ3u/cXPGTHoCN3PQ/4vn04a1Ksej/Hlm4niC6QI5vf1t1fT7bG0
	 mDzC7M+k5yX4Zbg9Xy4Sjbfy0F3qbMRCog3QvaOH7TSNrUbRcpPrTnYLhdYrlxxz4A
	 EF2AZICJ0FB6DSXnWAljrLhC5FcFpLQ9UlMExPOmyOiWaNkn/ZAdiqordPaPNs6vLB
	 WdyaZwbYv5mmLbpOvOpm1g2PSpAwTupyJcdCg7kDCkPiNIp76FLbDyiBC86LmXf4Iq
	 sgH/Xrjj/9/nw==
Date: Mon, 20 Oct 2025 17:49:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: yicongsrfy@163.com
Cc: michal.pecio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, oliver@neukum.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, Yi Cong
 <yicong@kylinos.cn>
Subject: Re: [PATCH net v6 0/3] ax88179 driver optimization
Message-ID: <20251020174926.36ec9464@kernel.org>
In-Reply-To: <20251017025404.1962110-1-yicongsrfy@163.com>
References: <20251017025404.1962110-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 10:54:01 +0800 yicongsrfy@163.com wrote:
> This series of patches first fixes the issues related to the vendor
> driver, then reverts the previous changes to allow the vendor-specific
> driver to be loaded.

Discussion on v5 reads as an outright rejection, so I'm dropping this
from our review queue.
-- 
pw-bot: reject

