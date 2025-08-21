Return-Path: <netdev+bounces-215480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C54B2EBF6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 05:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC68683B21
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071942E5B24;
	Thu, 21 Aug 2025 03:33:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012454317D
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747189; cv=none; b=qQAtyHxB7PMxW8R2rlPSU8OccUZ2ywrwJiDZaGXku/cqlqHSeimCPyyJ/dEZufwlVi0kO5MyD7NDLa4ZG/nXMMzF1TX3KQHUJMFr/V9t7Gd/lsZUEPpI4fMVPDY+uMm7mcvIcaQ0nuoCdmudndKYR/lycLsOYiZ/8+XeDBs0y/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747189; c=relaxed/simple;
	bh=4LFcMDfo/zbUYfGKlorYccLY9PwrEh1kqHEyrvJizI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlNd0a10if+MbRab3m1SdbEwUme4rQREBdxyAb291WV0zvxOflRy5IRm+H6IFG6sopTuV6MQfsVkWfpuwy91ia8+m72PDtTWtp6Jw333+e1U9ss6IMcFwTUN1ZcxpCn26LXwPRTx4bllR2g7frD/IlMCH50qoWze/cIxofJ/hmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1755747174t1aeda2f3
X-QQ-Originating-IP: B3BZVKqW3jX07jw0veN9lGFzHwGmjdz36KID2sMYiu0=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 11:32:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9983899224186391793
Date: Thu, 21 Aug 2025 11:32:53 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <7FCBCC1F18AFE0F3+20250821033253.GA1754449@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-5-dong100@mucse.com>
 <39262c11-b14f-462f-b9c0-4e7bd1f32f0d@lunn.ch>
 <458C8E59A94CE79B+20250821024916.GF1742451@nic-Precision-5820-Tower>
 <47aa140e-552b-4650-9031-8931475f0719@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47aa140e-552b-4650-9031-8931475f0719@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nc4Sv39/e83WJDUNsElZp8L6cF3bf/DZtWDpbGsH/jb93GdE5axLPAJM
	b5OomXvJB8eiNca08p5ljvk95tC4E0wplmtL4OF7L31gukDaNPY9apCtEanBgPXxnJF0rPu
	TpBOt7KJ/ylHDH6s3ch2HqPIu9Sfe6HGMYiLKW2WhFMEIEaHMWHVOau4vFPhiEJda/ozTui
	ycNNGykK7H6GfXoc0JLjPCTlkL0T/jqD+p5k13LP54YGnWZLxRq+RIdX8g4D10DmRyarN9e
	wlToIT/bz66G/20rzZj+pDFdwYujy/vIkm7Xnl4zxx73K++31j6VQque8/MbPa/f3ipbjKD
	PaxtM7R6xUY0isDVaPR49NsuRum0ZN7pen3VN16d/eYxVNU/oYh072qYIfjTOOK6NladTgc
	v+G/612+yQ/yB5hjZZLs8amDFRh/fAihk09wmONEFzfhCVM4PmibkKL9TI0GtgOuMh2rCW+
	lcaqc1XD5EIqdNaYhqhNQ3LuukZThXMx1W/SJDhXdpjL19lV9SP0IycjNdYqzDGLsZ9nlKH
	Bj0sy2Tw9GGs6D2awtfWlFxrSKYG84uBrXrE6oYBoJjrFGjEqJzPxl6OiqNHoKkXXYAP151
	s6w7UwXDrp1L/pol7PucOXacdB2mIEM2VbdhlIIpMqZli6dzvqGQ729Xc3IWzHoj4ITjCU5
	6iNoCo5jPrg9JVVxxrGg+Z63arjJ+DKlw20MMRNU2Uf8DmtAy3EKzOA3H834XWcqHPbNQ92
	pK5pr4BjX2VqBgWLrUyT/ki0XLNfuxTs05SlDYCDmJefuadJF7FDJeGG9FlItLpB6dwyLrg
	6tWFrVQUWzFNP5sLw7/xUqE4Aervl49wSp46QRChIHrxpQX0MFiwp4+RIEtPv04Ku0y0GQj
	lnrKmmqxg4SHKujulJbStJMlJ7u7QvTSOIAJvC4xJLnIExjDuKD0t4EB5n0flyzfEPv3QE7
	o+9/C1xxd0CjFOiJgNIj9Q66Tt8n1eQ72U5UoTDVgB1yceOVeFyRb86GkOByCLKDu9pRM4X
	QnFkQmIbPevK/GNugbajx9aqv7p8PKs6675IEfuQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Thu, Aug 21, 2025 at 05:13:27AM +0200, Andrew Lunn wrote:
> > 'mucse_mbx_fw_post_req' is designed can be called by 'cat /sys/xxx',
> 
> It is pretty unusual for ethernet drivers to export data in /sys,
> except via standard APIs, like statistics, carrier, address, opstate
> etc.  I don't know how well the core will handle EINTR. It is not
> something most drivers do. -ETIMEDOUT is more likely when the firmware
> has crashed and does not respond in time.
> 
> Do you have any operations which take a long time when things are
> working correctly?
> 
> 	Andrew
> 

'Update firmware operation' will take long time, maybe more than
10s. If user use 'ethtool -f' to update firmware, and ^C before done?
If ^C before mucse_write_mbx, return as soon as possible. If after mucse_write_mbx,
wait until fw true response.


