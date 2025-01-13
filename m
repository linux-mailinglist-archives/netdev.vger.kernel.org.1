Return-Path: <netdev+bounces-157567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9451A0AD39
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 03:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76573A54F3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 02:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7556B3EA98;
	Mon, 13 Jan 2025 02:01:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51317591
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 02:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736733674; cv=none; b=sJGyYNxqLen45Alj8PxEK/Aib8MCkoW/Oe+dgTPu8BKzAm+KWRXYDjrAiNcyfWM+BBtz3DdA4cXhwqZu009j4t06nETyHkl7Zcy0rmbORuRWCESm7X/1mK7FdWswnWNyXAWCHNH9NS9pBbqDN1dXsKEpo2KurAW0mCapzBueT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736733674; c=relaxed/simple;
	bh=rx/08yE8yVMTMxKE3scvmCh8OcClSwLI1Z1x7DDPeXA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=h4GVqoubTwIe2O9ic4RW3AHnSrooeMgUUwfbVaaeGH2YsMnhd7rfBe2v6UDgKNQzgl7pq+W263zDaQ7ctNvUpxCjiklAKFjjV76+EoHs/CCkdamLPotRof7nlxSh+Pe0adpQmOX+FtSOtwGJzxpflexxrsj8EWL2NuG5U8T6vmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1736733575t583t63501
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.58.48])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 1278653723033852028
To: "'Simon Horman'" <horms@kernel.org>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20250110084249.2129839-1-jiawenwu@trustnetic.com> <20250110120357.GD7706@kernel.org>
In-Reply-To: <20250110120357.GD7706@kernel.org>
Subject: RE: [PATCH net-next 1/2] net: txgbe: Add basic support for new AML devices
Date: Mon, 13 Jan 2025 09:59:34 +0800
Message-ID: <051401db655e$cb1c91e0$6155b5a0$@trustnetic.com>
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
Content-Language: zh-cn
Thread-Index: AQJ61aqJnOw37UQr++/HgZp4qqxfaQJUQSOjscJt/AA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N/EN6P+BmEafEnz7fmjJsF75OQkIeO9GFyOvUjsAze4DmBdqLDJniXk5
	8hM3FOxMF4Ux38wQ3PguIKIw9FCO4I8nJQsCsx6YVS1BNOpqzfKIuKIeP2o1N+cfJpPHX5p
	cHlbfPCfzQrSLnjX9Z7xFn3QLrhFDlOpnMnWevoFn0OW5LeHuVKqRqQjEnwhu+5n2+XLoAD
	OL9corllMJfqNCpk0Djb7b8YjbGcVu3Iuftl6CXgiqmCn9oCcDkIvbfZ3ljOS1QReAEriKB
	AMcLh9xcruqISXB1HkwcWKlOFjSIBo9XMjsE+IRxDYvMElwGLxN5yPi8Dn0/kcs8eZJ54E5
	jZBtdaqWFLZXDucmqBObypfY7YaO+/5TwV583HE4rdIrqLnPI/PA9LqBr20+EyX/vOlb7Ya
	fKxG3BD7FVVYdQgws+IAag7D3R9assW5MSLVsQELrNHo/uoaE1Zgf2FgKu+EcvMziyQlTAF
	V30/A0emfBasUM6O50VXljO17IZHODlXFafD0ben29OdvAMTCHfVnkOPK2/VafyuDkYHZYQ
	/6SqCgh8A5IdV+Gqxndpdb1wiUP3Saz6Jbizf38toINztbCztlg3KKje4j8ypVpfVdKyE9R
	46e5IRFNllYptSZeWMAYA2MguR05KoAckHsUado4Uv7GxmUr66xLeg3ENTbCyyQv4PGwLT/
	JzJRRAJGsyRmk1eu4s59l2Niv6LstvUcr0KEaAfkcrLgeUFdkZZ5MpIggR1CHtaXnR7wrN5
	7oJz073QRZRxsCn4dIGya8RyvzRDv9cs7OwajKKUWa99IUIbZdypW6/SWVO0KenBNkFRfXT
	yryT5JCZj/xShuM/LXTOR9az+dcRkhy5VmCoGWlFVuEcSA189HqQ8kAav0QZJkPAQNSz1VV
	57lPDWKawjXog3zX/IGLf8xCLzUqw1psUfgzSIrjz6RdcsdERVR0HGcDzEUhRr1jUe1ZDm1
	TnpctNg4WogWRX0Z8bzMnLeLyT8O2GHv59Uc=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Fri, Jan 10, 2025 8:04 PM, Simon Horman wrote:
> On Fri, Jan 10, 2025 at 04:42:48PM +0800, Jiawen Wu wrote:
> > There is a new 25/10 Gigabit Ethernet device.
> >
> > To support basic functions, PHYLINK is temporarily skipped as it is
> > intended to implement these configurations in the firmware. And the
> > associated link IRQ is also skipped.
> >
> > And Implement the new SW-FW interaction interface, which use 64 Byte
> > message buffer.
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> ...
> 
> > @@ -2719,7 +2730,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
> >
> >  	netdev->features = features;
> >
> > -	if (wx->mac.type == wx_mac_sp && changed & NETIF_F_HW_VLAN_CTAG_RX)
> > +	if (changed & NETIF_F_HW_VLAN_CTAG_RX && wx->do_reset)
> >  		wx->do_reset(netdev);
> 
> Hi Jiawen Wu,
> 
> Here it is assumed that wx->do_reset may be NULL.  But there is an existing
> call to wx->do_reset(), near the end of this function, that is not
> conditional on wx->do_reset being non-NULL.  This does not seem consistent.
> 
> Flagged by Smatch.

That is conditional on WX_FLAG_FDIR_CAPABLE, which is set by txgbe (SP/AML).
Its condition is the same as wx->do_reset being non-NULL.

	if (!(test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)))
		return 0;

For ease of reading, I'll add "if (wx->do_reset)" near the end of this function.



