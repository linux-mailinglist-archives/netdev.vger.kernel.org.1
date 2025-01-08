Return-Path: <netdev+bounces-156172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DC8A0547F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 08:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5103A5D87
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA26B1A9B48;
	Wed,  8 Jan 2025 07:26:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707DA1ACECE
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321196; cv=none; b=TAKtVH7Tr5zvvKadTdZEEl4zpchuu9oWFrf1rRAZKJpISMldHU8EwdZTw8JDKHocCzJIWCLTablEu3u2EOYOeKiFQ2xKGcrlKSRParyS2t0RMp3KFmTvYy1QVHe91sXhzMLeq7bN/kUUV0di1kU4dyZPxT6yOkTlVEBuloA/JMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321196; c=relaxed/simple;
	bh=xEQVnXYtMhz+dfxpJoxTKQp2ZQPjrXdGgd/2QLH+zfs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=pgI8NpAfjhVtFM57pYhIK4VT49S+OmmXNOytnLPPDGteruMg0H4C8qW85y0uaQ7t7hC8pw5kSvaDiXzyxr84TpsTBTMhaV5Ka166qYJ/p80V6ldAqW6KkF9acVxEcb+q3fd6IY4NIgkJGTuk1O+gkFiqzs9YIyZAIc7fI6ZmFps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1736321181t488t14533
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [218.72.126.41])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8239242233965610756
To: "'Keller, Jacob E'" <jacob.e.keller@intel.com>,
	"'Andrew Lunn'" <andrew@lunn.ch>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	"'linglingzhang'" <linglingzhang@net-swift.com>
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com> <20250102103026.1982137-2-jiawenwu@trustnetic.com> <ab140807-2e49-4782-a58c-2b8d60da5556@lunn.ch> <032b01db600e$8d845430$a88cfc90$@trustnetic.com> <a4576efa-2d20-47e9-b785-66dbfda78633@lunn.ch> <035001db60ab$4707cfd0$d5176f70$@trustnetic.com> <2212dd13-1a02-4f67-a211-adde1ce58dc7@lunn.ch> <CO1PR11MB50894A28220E758BACAADDFBD6122@CO1PR11MB5089.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB50894A28220E758BACAADDFBD6122@CO1PR11MB5089.namprd11.prod.outlook.com>
Subject: RE: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
Date: Wed, 8 Jan 2025 15:26:20 +0800
Message-ID: <03e101db619e$9d11d440$d7357cc0$@trustnetic.com>
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
Thread-Index: AQEgJ35Ybs4gTOBDiJnQm6cX+eEXEQKNhMgNAhs0hhkDC4VZPgJmfkjnAhMzQ1oBv9qskwKvPFq9s/4CnzA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NkLA2q2LD2295QQjPcbC8wCpgVWXuGXOjquTMJNCVt3+Bfd4R3tpnJEQ
	o5ooBhu2C/G64HFjYjXZR1MiMWPXG7aixBlIYVsOYOgOrcKlQ0+ag2ejkRLOMCgVJKpMm0Q
	lxFR01EYFKAxINT2mecyBcWYhFkISHVTDmURYn+MjzzZ+cQGcafOzSO+2leOouX1KO1HK/m
	MchWEaGdUtwfKSPbDml3mqodosz7YRsm7Rn1FGZKDY0GJO+ZlnCn560hL7sCMPxq3mxV+EP
	Etq7HldwciK2tpNUw3+IqfSB3nQwl8/DQYEWr+Ad3gYInj3PcxDtc462S2IQPu1eib0mQpf
	68WleyTSdbFqVIjynpvTL7OQiOMzITQ2A3FQzHQXYLG3306l0pSo3J6G+R09+8ZY5fK0TY9
	fm/f+GITd/aLgefhd2iNBgYqeG3mror/73hFPViYmabKstAcvsBvSlWuZRSGoehtZ/L0aME
	F4GjX69mzZVB59+UF+htPErHZle4CwCp9r3CK6VPXgEfnRUxZGnfCJV8GS/az/4u/JnM/LT
	GRdPRY7P1RlsWwhI+oB9Qbmsm6Qr9K+rgirrU30vg8a5BfjI/sgJSM96y3lHI5U1GEOz4AA
	xE31+vdMdTyJhX0CIODER2qPGZMj9vQHNp7ZfwgQ28XlkNmB+G6kanjP38Tg2J9F0PemCL4
	RV207e7nKKfqCsBwsFTJFIkDYVyYY2m+/7QuMIbK4yvqETy/KgKM1hd8XhM3bImfp1zsISF
	Z1v04HliEgifSXiVcIUUGmaT4At+jd7qFzq0ounNXmooYmDrDQJiAQRqqWuBz+7JH8XFbik
	0d1qp3QMZFXBC3EYyLgFuUF3To2yz85xJIFfUc2YkE5qVwddCsltQuI/5NAuavt9KdkG0Nd
	bO33vojS+pk4gG8uFu7YPF0Ctj6FpNK+4/6ANVRr4+BctQrjyFjmHB0zliJmGgpYbpPgkDn
	qXz0HOsvsRTHv4wQd9FnDqjSMj+CX+DFGspqg3KpcZGtUAsOrQ6XkfRHoQLWR1FD6e9e2z3
	Sen4XvUw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

> > > > > > > +/**
> > > > > > > + * wx_ptp_tx_hwtstamp_work
> > > > > > > + * @work: pointer to the work struct
> > > > > > > + *
> > > > > > > + * This work item polls TSYNCTXCTL valid bit to determine when a Tx
> > hardware
> > > > > > > + * timestamp has been taken for the current skb. It is necessary,
> > because the
> > > > > > > + * descriptor's "done" bit does not correlate with the timestamp event.
> > > > > > > + */
> > > > > >
> > > > > > Are you saying the "done" bit can be set, but the timestamp is not yet
> > > > > > in place? I've not read the whole patch, but do you start polling once
> > > > > > "done" is set, or as soon at the skbuff is queues for transmission?
> > > > >
> > > > > The descriptor's "done" bit cannot be used as a basis for Tx hardware
> > > > > timestamp. So we should poll the valid bit in the register.
> > > >
> > > > You did not answer my question. When do you start polling?
> > >
> > > As soon at the skbuff is queues for transmission.
> >
> > I assume polling is not for free? Is it possible to start polling once
> > 'done' is set? Maybe do some benchmarks and see if that saves you some
> > cycles?
> >
> > 	Andrew
> >
> 
> Agreed, I would try to benchmark that. Timestamps need to be returned
> relatively quickly, which means the polling rate needs to be high. This costs a lot
> of CPU, and so any mechanism that lets you start later will help the CPU cost.

May not. We should notify the stack as soon as we get Tx hardware timestamp.
But descriptor's "done" bit may hasn't been set yet.



