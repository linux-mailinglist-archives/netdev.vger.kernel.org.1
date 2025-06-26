Return-Path: <netdev+bounces-201382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E21AE93DE
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 03:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6759317C6E6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 01:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8427319F424;
	Thu, 26 Jun 2025 01:57:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB71BF58
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750903055; cv=none; b=k488gEjCtY8mRAROkQxBzbM/wpIzFuL+H5lNdOv8bDeyuYfncO6FW/910wlJp8QDajobJbiPZ7Dbr7e5Bh5/nF5RExfyF2L1l+tzqfZzriYxmUdJ8qbCgsk2+ywBnJK59lJfwLK4DLxt8y+t23i16j42u/aewYMlZt0T1Ig+G3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750903055; c=relaxed/simple;
	bh=TH9AQBop+q1RlL1q2SbBmMUg85sTvRP5gGOtBDZNy3s=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=cI78vsR+vs4qSK85npyq/J9xgrPrz5TRJQWzWIrfFHcKRV4dRM/Bqdbarfz1rIH4QnSgnMUQa9O2Px0yjMKCUKXATEv1SdDY9HnMcCNpmVNdqPYL1j+fuH6WfEsnvTfLGLuZKI4y3X5QfWoVnmyDtSfb8nLzv0GSX/v0NGWTAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1750902981t615t20315
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.27.0.255])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 14095354140544416299
To: "'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>
Cc: <netdev@vger.kernel.org>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>
References: <20250624085634.14372-1-jiawenwu@trustnetic.com> <20250624085634.14372-4-jiawenwu@trustnetic.com> <aFu6ph+7xhWxwX3W@mev-dev.igk.intel.com> <030e01dbe5b3$50ee41e0$f2cac5a0$@trustnetic.com> <aFvZ4miOKWbj1Xvp@mev-dev.igk.intel.com>
In-Reply-To: <aFvZ4miOKWbj1Xvp@mev-dev.igk.intel.com>
Subject: RE: [PATCH net v2 3/3] net: ngbe: specify IRQ vector when the number of VFs is 7
Date: Thu, 26 Jun 2025 09:56:15 +0800
Message-ID: <034a01dbe63d$800dc060$80294120$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQG8FB25wsfEchebLehyFWt5Oiz5UQJQZy3BAnQi+8MBhPWLHAK0cUsNtAxiwdA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OW3qjH3bC/TA9c5WM0nHZAp8Y0NoQD2bfl4dZCYL77o2KCjJenc1KsFI
	/CdyHt+Yj+yCIXpfyFME7uUBNTEUc7eEF7idVCXt7oZXH5R77ItrGbqh+9t8UkgepzKImX+
	JM9ISC3tB0Qq5rcxYGD79lTCq+I1a37pUdLyqIimA8YfNHsZrQBqWecksfRTbd3Wr1nsKIP
	6LkOpDVolUhcA2of3dV3tMc2XhtiEgjBF1eQKcEaXRFakBvpzOW9hSdomcOQxdZXEndVzvg
	+0+uSuhx4qfvQecH0alZR7WvKmEmjZWw9QcpUo1I31IOEokNDbI1Hc/w/JApw/bQRg+0Oj3
	iHbwiHeWNInGcnSvPRsE5guykuxYWiRNKX46KE7PV0NbngiZUBySTBh1eWCFmtNlPTzOBmd
	scNZNl3YrP/WXgh1RT4pdgfVWUzfj7Wc9VOgRNCZfJRR+N41HPhVwgU2LcpZGSmTep2hiCo
	8216oUNqRSJFJeH/oU6uBQujApndRfy0auGNEkFxDJB/VHmT8ARqclvh/wfWC9GGxDoXipi
	6u+ubSC1yCZFSUIKIzvK+k0aStgbVZazW7uEA35qkAYCxnZ+X3/VGYZe88++Rx6b37ynJny
	b6UfW+3G6C+V5Vg5MtbT2f3s5ycI3Z/TuSRCTrct6Wpj+BlmAbec5LukiB3LAz7i+Dih5hN
	JQDkx6fG5Ll+Wn+je6sXr0QSMlHaPVYjuLa/AlfMzZH4ARBr6gspXT3U2GJNKiogTNbw+MP
	ERansmWu3yNIwVyc3OOHjtT3ZT6Tp5TAqwr2LXo1eMzHkuwb6Kn8FGlmXLDVgxp4l/LU0y5
	Q3eQqpznjEjE6wpGyywFVtZvj6hfNvCUBAqxFoo0mVkOGg43BGorw8GsXklcqbD6PxftSln
	/1/E5jE/AxqI/n4PxuxZtf27XwZR+DVzMzI4nTH1BSRAwi5vnRn0gOqeKDdl1dpknh7MzUo
	fyxxAfX8BRbKbaIGKnywX63kNMgRgowji0dCm4wfsxJgHQC6hfI36oMzbKHIeLgIcHQo0Zr
	tF8JT6zRRsxBvYhunX
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Wed, Jun 25, 2025 7:14 PM, Michal Swiatkowski wrote:
> On Wed, Jun 25, 2025 at 05:27:05PM +0800, Jiawen Wu wrote:
> > > > diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> > > > index 6eca6de475f7..b6252b272364 100644
> > > > --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> > > > +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> > > > @@ -87,7 +87,8 @@
> > > >  #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
> > > >
> > > >  #define NGBE_INTR_ALL				0x1FF
> > > > -#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
> > > > +#define NGBE_INTR_MISC(A)			((A)->num_vfs == 7 ? \
> > > > +						 BIT(0) : BIT((A)->num_q_vectors))
> > >
> > > Isn't it problematic that configuring interrupts is done in
> > > ndo_open/ndo_stop on PF, but it depends on numvfs set in otther context.
> > > If you start with misc on index 8 and after that set numvfs to 7 isn't
> > > it fail?
> >
> > When setting num_vfs, wx->setup_tc() is called to re-init the interrupt scheme.
> >
> 
> Right, maybe to be more clear you should use wx->msix_entry->entry
> wherever misc index is used.

Sure, thanks for your suggestion.




