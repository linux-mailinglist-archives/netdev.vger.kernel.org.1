Return-Path: <netdev+bounces-154676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640FA9FF67D
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 07:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA293A2654
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 06:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4FA18C035;
	Thu,  2 Jan 2025 06:44:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F109D3209
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735800260; cv=none; b=tEvmG+0VQDQyRitNqmQGEaJlub0Pu38wFoI2+sgQxeEwk6C7qI+AmnwvD+oG9kYM+3blZzY2uumnE0iAMMjgTlH/xx7RRO822U/0tnz7YEpG6zg4Q1+sCmWRCow0lalQ22/uIVIO/m34IYWgUW5r8ICC9pCetm3NtQvRQiQ1UbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735800260; c=relaxed/simple;
	bh=n4vZmGIvAWx72QsyrztvVFz3AEj0lTP3CjsQ5U33m/o=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NyOPfxMTIyDE1N6jWxTzZxIMquZ92lwW53O8PML9O2qxzHPMhvIA03XPctlNyJbRgbmKDut2jY6k/UVprrl98o4ank1uNsH4bB5EBKjgQ87i81lLgDO002zoZK0G2uxALpop+34s//vIU40N7jS47QRHgxTcHX0JZ/j/xgsCVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas6t1735800152t085t33579
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.220.136.229])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 1768535203905050333
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<rmk+kernel@armlinux.org.uk>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20241226031810.1872443-1-jiawenwu@trustnetic.com> <20241230181150.3541a364@kernel.org>
In-Reply-To: <20241230181150.3541a364@kernel.org>
Subject: RE: [PATCH net] net: libwx: fix firmware mailbox abnormal return
Date: Thu, 2 Jan 2025 14:42:30 +0800
Message-ID: <028a01db5ce1$7f555f60$7e001e20$@trustnetic.com>
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
Thread-Index: AQEHYnVMQ+w9IFHEdc47KYMDLb0kSgKXSBkztJLT//A=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mq+dXfLz1bhazJp1QbpPlnXkYqEVs6pszUdWwKqxmf0e9XIrTUi2RUqa
	QKhHyk+d3LeMAfh7Hh7oZ4dVbVw4XTOndeqYESPv9DuKiPzc740gSY3GI//R8w4f/AeQfKp
	egNvfpqKr/LQkl4m6ISA/z1eQDC/yC6m8wCqJUxG1iNMXG0x9E0PsCxme+DINUXiFm6QcI/
	gzcBhFZ9SXiMyWOWdjePLz6tsNjPuZuEWARi7Jl5ZND9hKa/FdRlk3Xz5DG6YjAaL74NohL
	zPOODNW4GFYasm9WT+2kEBhpSN5S9/CeF6lycty4fBDNGJdw3ibiXcs3oI1XL8pgLZfOS9p
	6GONshDI5xBpWmbK1uXBll3RlaJogqBzTvg2sXUOHaVZtX8ZUNm+NoaHd58cjZob3yzjW9B
	qWgQBUkEba0ZmNfgQEP2HmtZ4nlnZo05coYW78mfp37F7p7mq5VwKFXg1wd87mGn3dWM6Yq
	MKeWhRqsR/iRRoKA2yRVWZL3fyMgCbExAf7fnSozbmkJOCNdEfPrCFUSHGws5ColfpKpJA5
	pIEPQV2b+mLiT3bH7QE9jJCSABmCArxNPvejqpGpt3CRhO27xXmoHS0AHv78kXAg3itD564
	MSOWBX1RI0CtPQSSU5hieMg5GsHKvUy32iHtvoNL+Y57BJTPQ0qrm9GI41WcfpDOC+0abNv
	0fLU0zgQp66Ldi+fAi3j9pBM6LNH40HPk4xvoaUUMb47yRlrYssZfE/lMGk1ltX7CpSfst+
	WB4S5HlMUpwgKdQIPBRi//dZuIOd+xNu8YUTnvnL5jLx4o3MkaCgudO4lBesw/YFdDID9/X
	Ju9bxzTLV6sDzRACPaserSy2Ve3MDsQS/wWXP70hrXn3hy3cUnEPtq67zszaKWJd3ze9Qbu
	vtWHdGq3+ka8WpN57M2BSNUnXRgrBWQQZqnkEW4cJ7qQ0+8cHuStX5P6vMHzPnJ3+voYaH/
	bZ+LZn/yBLEyykGrbCWGCCjcoWa7avn4gMTuKxXT8e1zj2ePS/TeZ0QAiHSQ2lESMh4k=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Tue, Dec 31, 2024 10:12 AM, Jakub Kicinski wrote:
> On Thu, 26 Dec 2024 11:18:10 +0800 Jiawen Wu wrote:
> > Firmware writes back 'firmware ready' and 'unknown command' in the mailbox
> > message if there is an unknown command sent by driver. It tends to happen
> > with the use of custom firmware. So move the check for 'unknown command'
> > out of the poll timeout for 'firmware ready'. And adjust the debug log so
> > that mailbox messages are always printed when commands timeout.
> 
> The commit message doesn't really explain what the problem is,
> just what the code does. What is the problem you're solving
> and how does it impact the user?

The problem has not happened yet, but the code behavior is wrong. 
Follow this wrong flow, driver would never return error if there is a unknown
command. Since reading 'firmware ready' does not timeout. Thus driver would
mistakenly believe that the interaction has completed successfully.

> 
> > Fixes: 1efa9bfe58c5 ("net: libwx: Implement interaction with firmware")
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/libwx/wx_hw.c | 22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> > index 1bf9c38e4125..7059e0100c7c 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> > @@ -334,27 +334,25 @@ int wx_host_interface_command(struct wx *wx, u32 *buffer,
> >  	status = read_poll_timeout(rd32, hicr, hicr & WX_MNG_MBOX_CTL_FWRDY, 1000,
> >  				   timeout * 1000, false, wx, WX_MNG_MBOX_CTL);
> >
> > +	buf[0] = rd32(wx, WX_MNG_MBOX);
> > +	if ((buf[0] & 0xff0000) >> 16 == 0x80) {
> > +		wx_dbg(wx, "It's unknown cmd.\n");
> > +		status = -EINVAL;
> > +		goto rel_out;
> > +	}
> 
> Why check this before the status check? If the poll timed out doesn't
> it mean the FW did not respond?

Firmware writes back 'firmware ready' and 'unknown command', so the poll
will not time out.

> 
> >  	/* Check command completion */
> >  	if (status) {
> >  		wx_dbg(wx, "Command has failed with no status valid.\n");
> > -
> > -		buf[0] = rd32(wx, WX_MNG_MBOX);
> > -		if ((buffer[0] & 0xff) != (~buf[0] >> 24)) {
> > -			status = -EINVAL;
> > -			goto rel_out;
> > -		}
> > -		if ((buf[0] & 0xff0000) >> 16 == 0x80) {
> > -			wx_dbg(wx, "It's unknown cmd.\n");
> > -			status = -EINVAL;
> > -			goto rel_out;
> > -		}
> >
> > +		wx_dbg(wx, "check: %x %x\n", buffer[0] & 0xff, ~buf[0] >> 24);
> > +		if ((buffer[0] & 0xff) != (~buf[0] >> 24))
> > +			goto rel_out;
> 
> Inverse question here, I guess. Why is it only an error for FW not
> to be ready if cmd doesn't match?

It is to check if the cmd has been processed by FW. If it matches, it means
that FW has already processed the cmd, but FWRDY timeout for some
unknown reason.
 


