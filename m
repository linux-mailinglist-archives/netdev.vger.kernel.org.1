Return-Path: <netdev+bounces-127867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5439E976EAD
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE73E1F21848
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E136A149C50;
	Thu, 12 Sep 2024 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NYns5o2K"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D113D625;
	Thu, 12 Sep 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158566; cv=none; b=HVpQaGjma4ktyEdBZ12a9jS5R8Vixp7rvIwtVH7xfoNbAARXP5er0FDdDfYYaL2CeYx8OpQ1LZT/T3u5kfG9kwib0LlUFmTWJwPiUtcCXaJrpkX3TM34eLbdUxcXBjU4qSMJL9Ld12ZcpCxqqXSMk7qxEQFplMwI8wbJVWN9isY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158566; c=relaxed/simple;
	bh=PluGaKUymZawE8kpYzl/FgA5QAW2GSiFGKjNfkPXRvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BostE0uC2sohHuNTE6bqcSq4sMtgxlAnfhOz2gOMqjMLiYcvbhLKnTp2O1qZbsd5LvFFUet6rSzlHz+WHXNKLpeC5VBhAHjjQcUGbN+CGWXVij6z979eBaM6Fh3h2RX28QGw6Hyyrwe5c79teFOeFPGbc7LeqCQgBVa2J7KUswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NYns5o2K; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=RP6DPM0iIVkE6rUikh5M9EXqW46ewLE58uqbat4mqfI=;
	b=NYns5o2KwXRpUVQtjHzcnQtiSMZHdGkqjjjNH1AXw+y+02U1RvpL44jPObSquS
	aKjsADw2ARH6b6y/zKhr1cguoe71IHq9QczvtlctJpS64M+MTjw1GyO92WmQVJcL
	GmRDWgrwQ9/z9pf0bZ7wTeTWl8V7C3QCFmrqC3YRkNFH4=
Received: from localhost (unknown [58.243.42.99])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wDXv1ytFuNmwAzFGw--.9282S2;
	Fri, 13 Sep 2024 00:28:29 +0800 (CST)
Date: Fri, 13 Sep 2024 00:28:28 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Chris Snook <chris.snook@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, kernel@collabora.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: ag71xx: Remove dead code
Message-ID: <ZuMWrJwTSUj4nqpc@thinkpad.>
References: <20240911135828.378317-1-usama.anjum@collabora.com>
 <ZuHfcDLty0IULwdY@pengutronix.de>
 <CANn89i+xYSEw0OX_33=+R0uTPCRgH+kWMEVsjh=ec2ZHMPsKEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+xYSEw0OX_33=+R0uTPCRgH+kWMEVsjh=ec2ZHMPsKEw@mail.gmail.com>
X-CM-TRANSID:_____wDXv1ytFuNmwAzFGw--.9282S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr1UWFWkuFWDCryfZr1xuFg_yoWxurc_Ww
	s5CayrGr1UJrWF934kAF1SvFs8t3y7JFWkWw1UtwsxWFnxZa95XayfXas3Jan3Xws7CFnr
	AFy5Jwn2vrW2vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8na93UUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRRFYamXAo4G4-wAAsm

Hi Eric,

> I do not see any credits given to  Qianqiang Liu, who is desperate to get his
> first linux patch...
> 
> https://lore.kernel.org/netdev/20240910152254.21238-1-qianqiang.liu@163.com/

Yes, you are right! I'm a kernel newbie.
But Linux is a FOSS software, and anyone can contribute, right?
Actually, I have two patches that were merged into the linux-next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=93497752dfed196b41d2804503e80b9a04318adb
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=cd0920ebab6bce93ac5054d621c0633f6a4d640b

-- 
Best,
Qianqiang Liu


