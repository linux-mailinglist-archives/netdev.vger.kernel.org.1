Return-Path: <netdev+bounces-228478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8696BCBF77
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 09:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9717E3A8C8E
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987D0275870;
	Fri, 10 Oct 2025 07:44:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25486274B35
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082248; cv=none; b=kl++NdsopWfkFK2HQiXmaavCs9pa/iyYQLwWJ9KwwYN5BP0FfAygciw8nNUUL51GoME8wYLKsN0XCj7gRlbessyxY8ZK9JJzvStuXxB94EXwN/ICy9e/o2YOf5uK5dOhzlxeyoCEUzAEV/IYlVsAA/myn7M2rYRJgkA7rLvIhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082248; c=relaxed/simple;
	bh=i3RrmhqyWPIFfDJ8NvUHfW4pISQqwWR0TQRyORkUJcU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qBBhQT2qgeU1ZGVJTN2goyBsuAhDDYbqK7WX0YtuFDvNSlbONFi8MKaLUMJEOA1aAi0sOgLpadMaOy9qTIfhZ5XbkcKcGQ7hNTnrJE/Pw/L5SFYbNb5TQfdhIguVR19993aM1a660TRuF2nsrAOqib7zaq49DKymGJIlZxPHD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas1t1760082121t259t01098
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.70.212])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 9812641663496567845
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Russell King \(Oracle\)'" <rmk+kernel@armlinux.org.uk>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250928093923.30456-1-jiawenwu@trustnetic.com> <20250928093923.30456-2-jiawenwu@trustnetic.com> <aNqPAH2q0sqxE6bX@horms.kernel.org>
In-Reply-To: <aNqPAH2q0sqxE6bX@horms.kernel.org>
Subject: RE: [PATCH net-next 1/3] net: txgbe: expend SW-FW mailbox buffer size to identify QSFP module
Date: Fri, 10 Oct 2025 15:42:00 +0800
Message-ID: <000201dc39b9$5cdcf5f0$1696e1d0$@trustnetic.com>
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
Thread-Index: AQF9Ncx3ddJxbS4YFASGoFm3bIwFPAJ+Ie7MAqLeFNG1T/0+kA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NzSDQCFWCzVTtNMncOylc4CuChubXf2W3n7aZwfFUqGUKoYKXI6c9WtH
	3NdGM+9wxv44YUjn/LSdIc3NCKivhh2n+HOkIH+pYzEOjQ9Dv/RojY5d+V/FY7qijbfnvbS
	D85fk3E1tCr8Ws77m3jrg910F4BYE/YQE09NIBpvkyVrxs2fFLcyih5yQdagPeqElo/w01y
	ECugbMxkPzgOsCwrnrs1JmT9jyIzKRVc59/hQBiz/6zXLVnc3mWTvwI8q7dzBnrysOF4yGo
	9JxyiKIDbty31z8cbEQ6wYZapFZ6yGN5r+JwayZpWcGhgkEsLyWolJgxYj88Qru/+h73JH4
	OcCff8XQkh7LGTURf6CWaf/OMs+qUPm/WQR0zQvpb8qVjpx3PqL1IR8sR2bQmR16ZNc9LZe
	cndyO4Z3GSH/5+kiiH7fd+PiO++cXX6OKMPWK8PRF7BUVjIBABSjHpQzvWnp2M7KhE6lyl2
	8um3f/90pO1sznfMJNGL7GWm7f4KL+fFRNPlN3eRJPUYQ+V5BfqXifK3MH4/tXxOo0PXwHx
	RE2LiRFYmcNG7EPU4nN01YpW4I8xHS2JyBxHY2kBoIjQCyIWsVyZedGWa56wm9lge3cUbKj
	qcFO0V3m25+vmfwzWfmSGiCLMjSNVKF/yKghx8mwz1oXw9L+1H34JYkPZ0OTpWDKLHsIqyD
	3uYQN3Xkh9KWNtPSFFDhnZfpOkdsFpHiUqtwx2Ec5sC14zVg+OBcJIW5t2oixOg7eZf5nt/
	kv7ZYbicp4ojlpJVBeH30tzkpBgoKPwJE6TL/kTPPaNjqSA4v+n9WC9Rdj8T/Exp6V07vi/
	+OHab708ZQzDfyyfa1jlbpNxQ5z/yOudWXhE9GjRZyOmp3LHzgwZcUfqJ97jHzb6gNQKZoR
	DzaYPHdrpqQWkKcNPqiBVKzeVmwJ4vxBzl/lLH/SzMT5PBQWjplvWk80zDqWakN745J7xWP
	vOzCZ7l7q7y5YUs3nskS8c1wyqY3x9aTeQoIgrDxuPdJI381OrSG+DqH6w8zGu7TcXg7Lwp
	5V7sTR/h4xw4p8rB33c95RYmrQuac=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Mon, Sep 29, 2025 9:52 PM, Simon Horman wrote:
> On Sun, Sep 28, 2025 at 05:39:21PM +0800, Jiawen Wu wrote:
> > In order to identify 40G and 100G QSFP modules, expend mailbox buffer
> > size to store more information read from the firmware.
> 
> Hi,
> 
> I see that the message size is increased by 4 bytes,
> including two new one-byte fields.
> But I don't see how that is used by this patchset.
> Could you expand on this a little?

It is used for QSFP modules, I haven't added the part of these modules yet.
But the firmware was changed. So when using the new firmware, the module
cannot be identified due to incorrect length of mailbox buffer.



