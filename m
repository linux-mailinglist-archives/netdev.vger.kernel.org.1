Return-Path: <netdev+bounces-35143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9A17A7413
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227CD1C20BA3
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 07:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC48BF8;
	Wed, 20 Sep 2023 07:28:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499CF8484
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 07:28:52 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FAB97
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 00:28:49 -0700 (PDT)
X-QQ-mid:Yeas43t1695194851t697t49499
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.240.142])
X-QQ-SSF:00400000000000F0FRF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 15463586431410757597
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <netdev@vger.kernel.org>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<andrew@lunn.ch>,
	<mengyuanlou@net-swift.com>
References: <20230918072108.809020-1-jiawenwu@trustnetic.com>	<20230918072108.809020-2-jiawenwu@trustnetic.com> <20230918082309.7e592c7c@hermes.local>
In-Reply-To: <20230918082309.7e592c7c@hermes.local>
Subject: RE: [PATCH net-next 1/3] net: libwx: support hardware statistics
Date: Wed, 20 Sep 2023 15:27:30 +0800
Message-ID: <002601d9eb93$ea6d1ec0$bf475c40$@trustnetic.com>
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
Thread-Index: AQGlJCOTC22ivbN0JsMCmaiCYDRK8AJR7wWhASUyu2uwcSXmMA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Monday, September 18, 2023 11:23 PM, Stephen Hemminger wrote:
> On Mon, 18 Sep 2023 15:21:06 +0800
> Jiawen Wu <jiawenwu@trustnetic.com> wrote:
> 
> > +
> > +struct wx_stats {
> > +	char stat_string[ETH_GSTRING_LEN];
> > +	int type;
> > +	int sizeof_stat;
> > +	int stat_offset;
> > +};
> 
> Type here is an enum. Therefore for type safety you should use that
> enum for the type field rather than int.
> 
> Since offset and size can never be negative, why not use offset_t and size_t instead.
> 

Do you mean off_t ?


