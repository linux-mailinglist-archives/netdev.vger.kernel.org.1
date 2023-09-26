Return-Path: <netdev+bounces-36193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F1D7AE363
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 03:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id F22C01C204AB
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 01:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD7A4C;
	Tue, 26 Sep 2023 01:38:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD57EC
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 01:38:36 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199C6101
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 18:38:33 -0700 (PDT)
X-QQ-mid:Yeas5t1695692205t349t05864
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.200.229.121])
X-QQ-SSF:00400000000000F0FRF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 6851883711132174218
To: "'Jacob Keller'" <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<andrew@lunn.ch>
Cc: <mengyuanlou@net-swift.com>
References: <20230921033020.853040-1-jiawenwu@trustnetic.com> <ccf1a90b-4f5a-bcee-83fc-1bb85cb80d8b@intel.com>
In-Reply-To: <ccf1a90b-4f5a-bcee-83fc-1bb85cb80d8b@intel.com>
Subject: RE: [PATCH net-next v2 0/3] Wangxun ethtool stats
Date: Tue, 26 Sep 2023 09:36:44 +0800
Message-ID: <017d01d9f019$e8512160$b8f36420$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQImy0ka2aie5whMdyynpSuhQPzKNAHgATzBr4OcWMA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Friday, September 22, 2023 4:34 AM, Jacob Keller wrote:
> On 9/20/2023 8:30 PM, Jiawen Wu wrote:
> > Support to show ethtool stats for txgbe/ngbe.
> >
> > v1 -> v2:
> > - change struct wx_stats member types
> > - use ethtool_sprintf()
> >
> > Jiawen Wu (3):
> >   net: libwx: support hardware statistics
> >   net: txgbe: add ethtool stats support
> >   net: ngbe: add ethtool stats support
> >
> 
> I probably wouldn't have done this as 3 separate patches, but the code
> looks good to me.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks for the review. May I get more comments from other reviewers? :)

> 
> >  .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 191 ++++++++++++++++++
> >  .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
> >  drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 116 +++++++++++
> >  drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   2 +
> >  drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  11 +-
> >  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  80 ++++++++
> >  .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   3 +
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c   |   2 +
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   2 +
> >  .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   3 +
> >  drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |   2 +
> >  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   2 +
> >  12 files changed, 416 insertions(+), 2 deletions(-)
> >
> 


