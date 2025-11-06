Return-Path: <netdev+bounces-236138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5EDC38CC2
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83F81A24B9C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7E41BBBE5;
	Thu,  6 Nov 2025 02:06:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99D22D795
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394818; cv=none; b=uo8Qj9OJX0FQKKwDCA5kYkbRgw5c5LUDRBcmHtSJm94vtHmPXdHbHEgA/oJUyAvaRAC2vfO9CBdEVm7eaHrXJRcAKvxZ4ET4diLZ1nDlrJowFohoNLiUk3J9Wi5QTUHRGngQya2GqzPB0aHnixPA7hZK2cH2U0OwTH9l4ZurzuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394818; c=relaxed/simple;
	bh=EJN8BYKOS2MGnzXt0xqWICyUTtWv7RNKzKBIB3bLhZ4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=gOK9m1t9WcRnAEy81qw0VDaN7SBP8CC1vi7htlzn7SdpMuC7lpCkj5Is/I4OqHe3VX7q11cJ/hRoyNtXbMhbHzUz/jHNwG/K49F1ia5NnGn4y/3l6II9fJYyBJ1SC4jTtPbSmFxP/1bmaUke1Xvi4wts65myCDP83tnNEc6KPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1762394725t979t24403
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.71.67])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 13201316561911771087
To: "'Vadim Fedorenko'" <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	<stable@vger.kernel.org>
References: <17A4943B0AAA971B+20251105020752.57931-1-jiawenwu@trustnetic.com> <de2f5da5-05db-4bd7-90c3-c51558e50545@linux.dev>
In-Reply-To: <de2f5da5-05db-4bd7-90c3-c51558e50545@linux.dev>
Subject: RE: [PATCH net] net: txgbe: remove wx_ptp_init() in device reset flow
Date: Thu, 6 Nov 2025 10:05:25 +0800
Message-ID: <09a701dc4ec1$d0cc3210$72649630$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQExXBZeSPIacREnfT1C8jsshPjwPgIYC4qltioGyIA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N3jdWkaw18INJ6L60Ov+LZg7GRWJTo9VnOBTNPVvJCW6PbCs35xAMrfL
	hTFkf5bdWd8WQE96DPdhh1HquerNUlFYSLxm61CsqrSoNaRpEWuGBN1A+N+xai3w84u4Tvg
	Ir8KgA7Pn4EzepfVGOw0W6hIR7X2FDHKNx8WoTFR9HUy7vC6oqOC2kfw14Cpn/l7sryKxhJ
	FDDszM4fMbbIuJc+wTlaYcWaTG03Z7A3HggqQ/02aWA4LYHHVF3FkAvHOxKtZ1myXzDWBCb
	IMnQAMKKOu6+0cKwx8p5w6rN7YELWEDiuFCZ2b3OakABB9+EHJT6lQ5FHqOAhS35mEHWH8n
	/Zca9nJOZTbjd359NEq2e4w8bQ9gzHwW6ZuXxw1TMLHVufgu1ohBYMfG8/I20/tBPpRgZWj
	VfN+8f17RZFZpkN2SLXhp4N+teEnqTJrXzpphObQi2gb/Fg8MstGCFWjJpJHJDoyBBTYJsw
	ibiAjq0iI2DgoLSiuNQJwpP/dNNNoVzRHTj6826ARme3gBKma8J5ivEdi/Qz0jsqi+MUcOf
	dqP8cmVEsFzRL28MEBdnVkpenPEOqoxZdZKAggz/z05ZiHO8wsrI8g75QhqxDspEm6ynHgi
	Gb1rbE+wq60c5fztjtwAtXZvixsRDRrIzUlDN3JFVQN3lENiKMdYrWGibMi+jpjv1rXehd7
	yXJ3t10nPvQRLe7BXnbyF+kF9wevJi+vm0Ro8PgJ7pKSDRsLii9Eayy05Ie9LcznjWYZ7lJ
	QNfwWVQrWPHqMcMwnML8pvEOuJ5vWODZ5R3F3AcPdS07ZR4zyYzs3NHdq8JOCM8BB5ndA2n
	nvcO8apxMzbqoFdBtr60TQZTkuREweqnCdsuyAt6sN/wUaKHnpR5qzpACSoujfFwoh3N/5L
	Qk6bLVBr3prDX3Y/Xj0wSAxDlzDKCfjQgiFSzwsQMWOxguyKEza1/aR0w8Y+T12F9KNiuuq
	hN6zmiMH05mveIh1IpVPU6xtcxNIYTW26V55eoEGRCAPDGsab+MPjVjkZyiXpjq+lBywlG0
	RZ4RJNKw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Thu, Nov 6, 2025 4:03 AM, Vadim Fedorenko wrote:
> On 05/11/2025 02:07, Jiawen Wu wrote:
> > The functions txgbe_up() and txgbe_down() are called in pairs to reset
> > hardware configurations. PTP stop function is not called in
> > txgbe_down(), so there is no need to call PTP init function in
> > txgbe_up().
> >
> 
> txgbe_reset() is called during txgbe_down(), and it calls
> wx_ptp_reset(), which I believe is the reason for wx_ptp_init() call

wx_ptp_reset() just reset the hardware bits, but does not destroy the PTP clock.
wx_ptp_init() should be called after wx_ptp_stop() has been called.

> 
> > Fixes: 06e75161b9d4 ("net: wangxun: Add support for PTP clock")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >   drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > index daa761e48f9d..114d6f46139b 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > @@ -297,7 +297,6 @@ void txgbe_down(struct wx *wx)
> >   void txgbe_up(struct wx *wx)
> >   {
> >   	wx_configure(wx);
> > -	wx_ptp_init(wx);
> >   	txgbe_up_complete(wx);
> >   }
> >
 


