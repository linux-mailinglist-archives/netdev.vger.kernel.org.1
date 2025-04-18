Return-Path: <netdev+bounces-184056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94840A93006
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E896C8A49CC
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CEE22A7EF;
	Fri, 18 Apr 2025 02:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D262770E2
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943816; cv=none; b=RYQfGEOQWV+HLejGulTmSZE88OlgPhe0f5KzodDrZ/pyQ+QmV7x6TAWRIJ+If0jRSWCoeCy0Uko1kVrSPtoZ9aXiolqH5I18Tg5jh2EwVhJ9yNPFMZXQ4HHOaBbKy8yncRpY95iM9C55b5cwVsGGzPPUK1Uk2hESYw5cIBGTQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943816; c=relaxed/simple;
	bh=8bXjqvJ4M+Xl3uu3qgG8WDuIei7iv919+1X+owbyprg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=jyU7uGqL8w9l72APg9AgDfZ0S6vFPVCjbUDkWl+nwTXGjoDlMJUsfp24qvdd0c6sK/IPcWajPxXk8nx8AQ/c2VGBdYHpEaevod71USRwJir6CctqdAD6E7PIj/8xXNccVRue98wyg7tLw2jXGD/vdWQa9P2EE++VgIqxeMV8cGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas10t1744943769t432t20061
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.64.252])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 10371502986806309605
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<dlemoal@kernel.org>,
	<jdamato@fastly.com>,
	<saikrishnag@marvell.com>,
	<vadim.fedorenko@linux.dev>,
	<przemyslaw.kitszel@intel.com>,
	<ecree.xilinx@gmail.com>,
	<rmk+kernel@armlinux.org.uk>,
	<mengyuanlou@net-swift.com>
References: <20250417080328.426554-1-jiawenwu@trustnetic.com>	<20250417080328.426554-2-jiawenwu@trustnetic.com>	<20250417165736.15d212ec@kernel.org>	<01fb01dbb003$5b920bd0$12b62370$@trustnetic.com> <20250417191939.1c4c2dde@kernel.org>
In-Reply-To: <20250417191939.1c4c2dde@kernel.org>
Subject: RE: [PATCH net-next v3 1/2] net: txgbe: Support to set UDP tunnel port
Date: Fri, 18 Apr 2025 10:36:08 +0800
Message-ID: <01fe01dbb00a$a3fdea90$ebf9bfb0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHTQdIaykwAzFMEiQKHJOM0w1kQSwKFSxn4AihjOFsBue0lyAGZjbDOs3mG3LA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N2bAIxLK0elnu3u8PoCIhbU+a3GkfOawuqzWiiEoVdGou2d4Xh2wgq8i
	gyFc6CK4sg3yGyvkqNR4GXiuD8Gio0rzcCJc/+4nwdoEUwVaTieQZTNuoB8LKwraxJbcU+1
	mF9LVuuygAxKu1ydK0kp0UBnl170M4nZ0/B5mhvKkQ5pkB+skE7mHtBL8REZtir24T+TkCj
	wt9I4GmL+v0I+byzt2Sn9wtsvQvbT1u4eRR1Xy9GuX2wOUDxvoHIyCq+KuokwD5V3PDFqYi
	66ww6krGRSQVcN3Nw2dBLvyNYQNZlzBDewHBtVpXnU066b+fpiXvxlan9KEZQH2OzZ8Hy2I
	Id6J8U2BZaeXzkXezVqndbd2sc5hpHG7/9QIFS7LgFlzWGh1lnjCeX784miFswwn83Hqi5b
	WkRanSkL3ekIg7wA9v+6sN03anvlHt4iPSn10ccWu9ZF1ZwFlucO+CMr1ERdBQ5QMM/h6wx
	NqKv1xF71Qr4Nmf6glmLXndtRGyEjVx8EyvGK25UlSMb/6dE5GRaYluM0Q+5OB81aKeV67a
	yhdLh7bIr3nRjfr+CZbUUv1RH5bzQmc5ke73m0SUGGSahgne20LyiGpHu/jvUCNI8ZDnkqy
	HVSWT73pOzh2gLZLMzzL74XNkDSG8wloU2zAC1/CrsYof1B7OiqRmSZgBv15zX5ta71ko9P
	oNzpjzuAjKA8FzIyVp7KsWz5ThKfAZY0dd5lXOajJo1UOHxHb6zem9bDYHfO8YQ4RIirm1P
	HQoxn/k6lgRsaap/ZM0eP6GG3vXau33W1n0NWOL6lt2KMC78waLrH8pUtaFW7+Xs+nUUU8i
	ZDEp8Po3+D02QoUTB6PW9pltUrw+5aQGi4Pto4XUVAptGnyvXAAyFHYLl3nLiCpO9jy694T
	XV740eI+bos0hBCvFjjvOwN5+TwzcDl6iQ6PtX1vC1k1nMFqduudQLhd1nq62ok9J7Wox4R
	z0fgTfOB+Zk5VHsBsAQmv4aMyWFj9y+946ifT/vXbSe9h1xN+OsoTZ5qIIDRbZI8tcRsGM9
	zTCSLJDfgK1sTVUARJ1noiUjZJJDM=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Fri, Apr 18, 2025 10:20 AM, Jakub Kicinski wrote:
> On Fri, 18 Apr 2025 09:44:00 +0800 Jiawen Wu wrote:
> > On Fri, Apr 18, 2025 7:58 AM, Jakub Kicinski wrote:
> > > On Thu, 17 Apr 2025 16:03:27 +0800 Jiawen Wu wrote:
> > > > @@ -392,6 +393,8 @@ static int txgbe_open(struct net_device *netdev)
> > >                                  ^^^^^^^^^^
> > > >
> > > >  	txgbe_up_complete(wx);
> > > >
> > > > +	udp_tunnel_nic_reset_ntf(netdev);
> > >         ^^^^^^^^^^^^^^^^^^^^^^^^
> > > >  	return 0;
> > >
> > > > +	.flags		= UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
> > >
> > > Documentation says:
> > >
> > >         /* Device only supports offloads when it's open, all ports
> > >          * will be removed before close and re-added after open.
> > >          */
> > >         UDP_TUNNEL_NIC_INFO_OPEN_ONLY   = BIT(1),
> > >
> > > Are you sure you have to explicitly reset?
> >
> > Yes. Stop device will reset hardware, which reset UDP port to the default value.
> > So it has to re-configure the ports.
> 
> My point is that this is basically what the
> UDP_TUNNEL_NIC_INFO_OPEN_ONLY flag already assumes.
> There should be no need to reset if you already told the core
> with the flag that the device forgets everything when closed.
> 
> Could you retest without the reset_ntf ?

Thanks for the guidance.
The test result looks the same as before, when I remove reset_ntf.
I'll fix it in patch v4. :)



