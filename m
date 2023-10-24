Return-Path: <netdev+bounces-43757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49B17D4944
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43D21C20AC1
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ECE156CD;
	Tue, 24 Oct 2023 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="0afEiYWF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AF257D
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 08:07:00 +0000 (UTC)
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1852799
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:06:59 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 984FB174C4D;
	Tue, 24 Oct 2023 10:06:56 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1698134816; bh=Zd1GUWd5iKjynBSEWxZa12JBrIgjgAIg/+wIDEr9/Xo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0afEiYWFQut1xFV+DW0TnwqYPKAgCFMeOVOTOwBz8DLiTYv5r5u5x1Kfl0SMKoeQE
	 0MqW63Yl9calsJjIWO/OSesfdKD+RByEaSXkzGCVnuz46q43EB6VeNVaTQRXR1ZLTM
	 SBke3qjOpF9B4Eah5YWlLb1JWOKqjF6vfWfQvjXJAkSfcYkoJrMvHzgA7AZLxTn+Ap
	 FD9Wloy8J94POhjxHmIzRIo8RpDO5ELuSmP8P/xnfpeKd5oUvZHzpKS9DIxzV+lBGa
	 xsSBttII3G8s8+KZPDhxDb3oGE/KBInM8TiAIWkyueCsLtgBvc9j2pzeo/DH0e0/v9
	 tKOrmo88p/5GQ==
Date: Tue, 24 Oct 2023 10:06:54 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Ben Greear
 <greearb@candelatech.com>, netdev <netdev@vger.kernel.org>
Subject: Re: swiotlb dyn alloc WARNING splat in wireless-next.
Message-ID: <20231024100654.56d53be4@meshulam.tesarici.cz>
In-Reply-To: <20231024062920.GA8472@lst.de>
References: <4f173dd2-324a-0240-ff8d-abf5c191be18@candelatech.com>
	<96efddab-7a50-4fb3-a0e1-186b9339a53a@gmail.com>
	<20231024062920.GA8472@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 08:29:20 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Looks like we need to limit the maxium allocation size.
> 
> Peter, do you have time to look into this?

Yes, I'm already looking...

Petr T

