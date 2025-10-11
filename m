Return-Path: <netdev+bounces-228573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C97EABCEE61
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 03:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5275934FDCF
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 01:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3483A157A72;
	Sat, 11 Oct 2025 01:59:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5DA1474CC
	for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760147950; cv=none; b=m6pVVwCLkcuklO5mpig3IDcVDBXWCxLs/RtxOB5WpeFEF8v8LNdYzNQbYFAX6+5rvsiQPxkU6CfEG/ViTHEmMkVlTsf2QmPz4g8WitR+/7bX+IYBwQJjP/QVOc83Ym4ChtrUStb5OkWJPo5mjwFhCHEOituc6qycKjME82XlSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760147950; c=relaxed/simple;
	bh=RThFTRM2CdgvDHz7lG7Ix7EKBD1py3jmN763K/WngvQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=UKDnO1aWgrQhL9cs9ts95WiS3sPWnOkdo9PBX7XhxZS/cRIo1sdd2rQiiONYOXroqbseV8wZYBJM8+A6H+5fGaxB8eue8yenC+xw+m3FI/c83/iTuSiJ6KEWKREMBGRCVNDh49pKlVXfFCjNe7ciftpJ1Faxm76JW8a3GEG+xHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas10t1760147845t631t60926
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.27.111.193])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 7225458375765542316
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: "'Simon Horman'" <horms@kernel.org>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Russell King \(Oracle\)'" <rmk+kernel@armlinux.org.uk>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250928093923.30456-1-jiawenwu@trustnetic.com> <20250928093923.30456-2-jiawenwu@trustnetic.com> <aNqPAH2q0sqxE6bX@horms.kernel.org> <000201dc39b9$5cdcf5f0$1696e1d0$@trustnetic.com> <f4c6d749-020a-46ca-844b-558542113327@lunn.ch>
In-Reply-To: <f4c6d749-020a-46ca-844b-558542113327@lunn.ch>
Subject: RE: [PATCH net-next 1/3] net: txgbe: expend SW-FW mailbox buffer size to identify QSFP module
Date: Sat, 11 Oct 2025 09:57:24 +0800
Message-ID: <002301dc3a52$63a80fc0$2af82f40$@trustnetic.com>
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
Thread-Index: AQF9Ncx3ddJxbS4YFASGoFm3bIwFPAJ+Ie7MAqLeFNEC3pVXwwJK9mPttSfjxsA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MDdEiFtOh5Nv+pOqWew5xPhTZAUGGbkNSmLYRhMHm9NYYYxcv3EoDBwH
	ZCFOsnUiPyNBxxY5o2DDYeiC/NFVperv0y39QXyrBVB/+D97RDBo5S35T3VpNJpPpjGLvGk
	wINv1wdpQ+6b+OWKnXbbJ0evxNjcKZ4U3M8fWNZSAtmnMvizJbzepsK/Z+0VqlBXILQHZwO
	DHP5i+rMv7AT6pltaall8eWHzLDWWO72j+eeTgBd7/qAZM6OmqWuAKcelMunySXBJVgljIW
	RULsyPAkyflp2girjI7TfElAsBX4iyK8tvU3G8Gvylto5LlDYCReBc2lhHAK+4PionbCaay
	fvawbCn9L26JcGYt+OWmax5qnrQKsbbFSBg85fFa3yjNhE+begVnA17jK7bQxaS384LVsUC
	yiVnltYNzwtJlIHGVy5/oyavt8tgsYD9plQwTkW1yxJ4XFDxOdV+11v7TuNUU/fIbJfnLdD
	X2cVPKW13uiT0yNXTnFPdIctEhqUpbiyUdx8eYUoJSiGlPCSXv1vNamscqReAMzXOBZ5Anv
	Iq8HjqVhFD7PHe+92F9I3X8wRByyCxod8UIJCAXhqOmZ6IDHWfSxsb5GJK/yhF/c4x9Wo8d
	i5hJatpPJV9CLlCYzmbmYXa/2iznx5r4S6Nhs3q5zNd0GAZ0xISAH06o/s0dAv+CwdWM4Yn
	+ssBBhlriygOVKmD4TGmFWoYATCLkToFUPgsP4TdGNt5GlKX03Wl4hYDi6jHICR5Dv2FOHK
	VnhmeOKUW6p6i5wIWniajE4944+w5OgxwuA/J7mEA3yJ4lKtfsSYQChDDTq54I76Zhqy51C
	8BUK4dcHaMJzEd4W4lBazu1R9j7ZZoNLjUwECMh7LWQxYpBZNm2ol6tqBjRwtLzCkFq6Z8I
	W6QI4fpk+Ehi8l98TQ6Ou8v/YIkFp95eQjTOv9uo3n7+7ufS3/GYm30IixdTtzo+peedWO3
	xYim5KhE1H0Qi592hss4h0rCJdI6wFzdkJ1Znfxl/EcK0C06Tq7aqd7PptLBT6ilMI0rJ1e
	cl/dhKzs/UUrTA9hZuS74O0F2ktPSEmN4Y0WyEhg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Fri, Oct 10, 2025 9:53 PM, Andrew Lunn wrote:
> On Fri, Oct 10, 2025 at 03:42:00PM +0800, Jiawen Wu wrote:
> > On Mon, Sep 29, 2025 9:52 PM, Simon Horman wrote:
> > > On Sun, Sep 28, 2025 at 05:39:21PM +0800, Jiawen Wu wrote:
> > > > In order to identify 40G and 100G QSFP modules, expend mailbox buffer
> > > > size to store more information read from the firmware.
> > >
> > > Hi,
> > >
> > > I see that the message size is increased by 4 bytes,
> > > including two new one-byte fields.
> > > But I don't see how that is used by this patchset.
> > > Could you expand on this a little?
> >
> > It is used for QSFP modules, I haven't added the part of these modules yet.
> > But the firmware was changed. So when using the new firmware, the module
> > cannot be identified due to incorrect length of mailbox buffer.
> 
> And with old firmware? Can you tell the end of the message has not
> been filled in with old firmware?

The old firmware has not been released to the public, so there is no need
to worry about the compatibility on the old firmware.


