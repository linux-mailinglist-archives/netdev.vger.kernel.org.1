Return-Path: <netdev+bounces-14298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF08B74001D
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 17:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E041D281078
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 15:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C42319BB9;
	Tue, 27 Jun 2023 15:53:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C0919515
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 15:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61171C433C8;
	Tue, 27 Jun 2023 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687881214;
	bh=VFH04KQ3gvefUySLTDf8LtzRnAMEIEUyc0inlA7xpbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mI2EHfIeePjlJPuspRxyfSV9FsMA9HlLGkZd+HcdZ8vlvKxDr9MoWJKA8AsAqT8wd
	 1djlje/vvpiXQhKC925sxIhVOHfBuLGyYyjyFlMwBl5pLHfh/MYxlp3NGnL4yzegCk
	 KZqnQ757xoGvpJaSVeH8hDaGnocMW7uwHiTb9tIQmFhf2C29RTSQG1SJeINdPqfQKn
	 je1v5uyAAy8pne/K0OoQwv0m1esdCnx8hGhNpc8JzYMrZii7xyEt8Fy6w3fwaH1ZOM
	 8C1tUvcXeLzfOZ75STv4hhQzEc++98WCFIbnHrIsqQrgSl4BvZEdbCaX52uJ6MalrD
	 mMXt/XLNELSVA==
Date: Tue, 27 Jun 2023 08:53:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, Xiaoliang
 Yang <xiaoliang.yang_1@nxp.com>, Richard Cochran
 <richardcochran@gmail.com>, Antoine Tenart <atenart@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: dsa: felix: don't drop PTP frames with
 tag_8021q when RX timestamping is disabled
Message-ID: <20230627085333.0968615d@kernel.org>
In-Reply-To: <20230627155147.atvr32v3vldnybrc@skbuf>
References: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
	<20230626154003.3153076-4-vladimir.oltean@nxp.com>
	<20230627151222.bn3vboqjutkqzxjs@skbuf>
	<20230627084651.055a228c@kernel.org>
	<20230627155147.atvr32v3vldnybrc@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jun 2023 18:51:47 +0300 Vladimir Oltean wrote:
> > pw-bot: changes-requested
> > 
> >  a) your email address is different and the bot doesn't understand
> >     aliases
> >  b) commands are hard to remember
> >  c) don't care about patchwork
> >  d) laziness
> >  e) other  
> 
> hmm, I'll tick e) unslept...

Ah, good, I was worried it was the aliases and I don't have a great
plan yet for how to deal with that :)

