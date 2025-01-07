Return-Path: <netdev+bounces-155665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACDAA03516
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE8B18863DE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B939E33086;
	Tue,  7 Jan 2025 02:24:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB752BD04
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216686; cv=none; b=kFawCpsDBtxHE2YRDRo2LvamkKpFgJR907TDlEkC46AX7uSY1DL1QRIBIJ/j6e7FjC9pL6POh0fSn2rKQFmNQXoEhfJU+PcjHiyGpc8uacCp0BgUc15KCaqLd0JJLO+V4oXN6pAsVeg4YS4/q9aznvqFMn4pqVbkgnggrwHIAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216686; c=relaxed/simple;
	bh=7get7PwQQQlQZAjyKFX/M0HCgb8mC6HZSEYaaz25ewM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=EZX9istZWN6TIZz0zBfflBweJmRh4AAkd+YTXX//HnqhtY+jWEQEmV2lxocRfFEpUW1vy5lb7PBicqyueP1umumU32gBSVX4+PDKSwI4LEtrBrGz5dXWV//TEpfonIr9obsNyE8h2km6COU6nt2ZJrUPhObdgi5BHIk3wv8QmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas6t1736216669t426t25583
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.118.30.165])
X-QQ-SSF:0001000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4438678781041383670
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com> <20250102103026.1982137-2-jiawenwu@trustnetic.com> <ab140807-2e49-4782-a58c-2b8d60da5556@lunn.ch> <032b01db600e$8d845430$a88cfc90$@trustnetic.com> <a4576efa-2d20-47e9-b785-66dbfda78633@lunn.ch>
In-Reply-To: <a4576efa-2d20-47e9-b785-66dbfda78633@lunn.ch>
Subject: RE: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
Date: Tue, 7 Jan 2025 10:24:28 +0800
Message-ID: <035001db60ab$4707cfd0$d5176f70$@trustnetic.com>
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
Thread-Index: AQEgJ35Ybs4gTOBDiJnQm6cX+eEXEQKNhMgNAhs0hhkDC4VZPgJmfkjntDAwn7A=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MTkbnw8ZeqfcXFyFCpcFVn0RAyDpqGSzmI1IY3C2fX4lq6/PiD/tPjrB
	jXhiWydxrlszIqLRR1Vz1Ca8p/mQTFKlS+sNqyg4D24/dsfz6HKktZc+P/JGMB3Hddr9d4z
	RlduyUaC/LWpuX6NEsUSuTRzr/PRy7wwRhBPKdJ5JCIb+jUrbiWqU1C5AsWeVEJLSzS2Ryt
	Cg6hOabOaogh/sx4hVcOOxjYQ6NwvSkyn+oPMe3tp+77Mx3Ouf2kbzJlEZ6u8UfA1oSZoak
	pJins+ZvI4DaLUhWyiIWbldywMydnRD2sNQhq45G/XbNiKnZxJVZAzms3tff5IsBky28w89
	mV4+hKRkYl7Cht9j33bk3fAM62GVK2KV+H/HIBj22GkWS0UGSoctjd8q7odrmquSRd6P3M1
	dLuBAgBiisr/0R3QdPjxhY4CAKyjYm/GbaIrsO3beI+yjnOYsMVyoG5nF4xYw3MZTHpLEKK
	bid+hfDD/vVJZwEV2pTOwjStFPgcOcf+2UEeDT7zYPzODU6nshaUuQYI9D+2FhHzWsRm4wX
	h6bo45MOlDZmuI/ieMoqXpgoZZMXCOGaWJCRdxZmNrxsCxAebnqHhqPGwJoWOpwLWA/IMEz
	wLLnf29mwhZRAkLLXiT6yWQ3IfV9b///Vru7YIY09MkQSL3xnY/ixKjz3q4VbJa+r9OZjAl
	v8YWcUMZKjXanEsfwGyqYueV6f3e/gaASkZ/yNge4+s41YCktqN7+wuCq3cIVw5DckGl95W
	8KnbtpIZo4MV4HxnwBYXm710UUOGWQHok79mblu4Q4n++PFiQZTJUuAJ3ZWlGHuSvuZnQ53
	GSd3MFG/EBhTDnuo5KOkV6LfJIARkofC4G7429kqtaN0+Sy6outcFoE3hmKglBU6VL7hLDa
	46woXFegkEqmlr6IhuxhbndbW43QsBkVFNA5HpbFRmGZCSXz0DavIchezYAhj6mGnqRKiAF
	stIgUgNHnfVu31J8wHKM5yz7iHFGbRXMDlhbD9wdHReBtYAqUT2F/daw+TsC9FnJlnDEf+S
	NTZHFl3VyfQRUVryb9YG+dCsFZQWay/kL9LbG8gi9Hvvs7Y93gugOzsYI0TVY=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Mon, Jan 6, 2025 10:27 PM, Andrew Lunn wrote:
> > > > +	smp_mb(); /* Force any pending update before accessing. */
> > > > +	incval = READ_ONCE(wx->base_incval);
> > > > +	incval = adjust_by_scaled_ppm(incval, ppb);
> > > > +
> > > > +	mask = (wx->mac.type == wx_mac_em) ? 0x7FFFFFF : 0xFFFFFF;
> > > > +	if (incval > mask)
> > > > +		dev_warn(&wx->pdev->dev,
> > > > +			 "PTP ppb adjusted SYSTIME rate overflowed!\n");
> > >
> > > There is no return here, you just keep going. What happens if there is
> > > an overflow?
> >
> > If there is an overflow, the calibration value of this second will be
> > inaccurate. But it does not affect the calibration value of the next
> > second. And this rarely happens.
> 
> If this is a onetime event you don't really care about, is a
> dev_warn() justified? Do you want to be handling the user questions
> about what it means, when all you are going to say is, ignore it, it
> does not really matter?

I'll remove the dev_warn() to avoid user confusion.

> 
> > > > +/**
> > > > + * wx_ptp_tx_hwtstamp_work
> > > > + * @work: pointer to the work struct
> > > > + *
> > > > + * This work item polls TSYNCTXCTL valid bit to determine when a Tx hardware
> > > > + * timestamp has been taken for the current skb. It is necessary, because the
> > > > + * descriptor's "done" bit does not correlate with the timestamp event.
> > > > + */
> > >
> > > Are you saying the "done" bit can be set, but the timestamp is not yet
> > > in place? I've not read the whole patch, but do you start polling once
> > > "done" is set, or as soon at the skbuff is queues for transmission?
> >
> > The descriptor's "done" bit cannot be used as a basis for Tx hardware
> > timestamp. So we should poll the valid bit in the register.
> 
> You did not answer my question. When do you start polling?

As soon at the skbuff is queues for transmission.



