Return-Path: <netdev+bounces-52344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB47FE7AC
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 04:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19721C20A71
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 03:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5D0125A1;
	Thu, 30 Nov 2023 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B973D50
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 19:34:25 -0800 (PST)
X-QQ-mid:Yeas43t1701315143t650t15003
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.128.129.197])
X-QQ-SSF:00400000000000F0FSF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4404046532227934155
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com> <20231122102226.986265-3-jiawenwu@trustnetic.com> <4a36b46d-3f71-430f-8158-da58769ae52a@lunn.ch>
In-Reply-To: <4a36b46d-3f71-430f-8158-da58769ae52a@lunn.ch>
Subject: RE: [PATCH net-next 2/5] net: wangxun: add ethtool_ops for ring parameters
Date: Thu, 30 Nov 2023 11:32:22 +0800
Message-ID: <029601da233d$d4b8a9a0$7e29fce0$@trustnetic.com>
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
Thread-Index: AQIZ7m4FfqhO6yXRbjtvxmXj2jKlSQJjneaLAvi6Bwev57q7YA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

> > +int wx_set_ring(struct wx *wx, u32 new_tx_count, u32 new_rx_count)
> > +{
> > +	struct wx_ring *temp_ring;
> > +	int i, err = 0;
> > +
> > +	/* allocate temporary buffer to store rings in */
> > +	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
> > +	temp_ring = vmalloc(i * sizeof(struct wx_ring));
> 
> So it is O.K. for the pages to be scattered around the physical
> address space, not contiguous. Does this memory ever get passed to the
> hardware?

No, this memory is only used to temporarily store ring info. It will be freed after
restoring the ring info.


