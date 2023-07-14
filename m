Return-Path: <netdev+bounces-17737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3187A752F25
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A20C281F55
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 02:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF74807;
	Fri, 14 Jul 2023 02:07:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5A806
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:07:09 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6C6E5C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:07:07 -0700 (PDT)
X-QQ-mid:Yeas5t1689300420t377t64930
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.254.133])
X-QQ-SSF:00400000000000F0FPF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 18169891054353140419
To: "'Paolo Abeni'" <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
Cc: <mengyuanlou@net-swift.com>
References: <20230711062623.3058-1-jiawenwu@trustnetic.com> <520aeaeae454ed7e044e147be4b4edd9495d480b.camel@redhat.com>
In-Reply-To: <520aeaeae454ed7e044e147be4b4edd9495d480b.camel@redhat.com>
Subject: RE: [PATCH net-next v3] net: txgbe: change LAN reset mode
Date: Fri, 14 Jul 2023 10:06:59 +0800
Message-ID: <001101d9b5f7$df93df60$9ebb9e20$@trustnetic.com>
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
Thread-Index: AQHbyCexHOUisSqa+/6k3HYPwv1tswLK7LCtr54FpWA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thursday, July 13, 2023 8:49 PM, Paolo Abeni wrote:
> Hi,
> 
> On Tue, 2023-07-11 at 14:26 +0800, Jiawen Wu wrote:
> > The old way to do LAN reset is sending reset command to firmware. Once
> > firmware performs reset, it reconfigures what it needs.
> >
> > In the new firmware versions, veto bit is introduced for NCSI/LLDP to
> > block PHY domain in LAN reset. At this point, writing register of LAN
> > reset directly makes the same effect as the old way. And it does not
> > reset MNG domain, so that veto bit does not change.
> >
> > And this change is compatible with old firmware versions, since veto
> > bit was never used.
> 
> As the current commit message wording still raises questions, could you
> please explicitly the level of compatibility of both the old and new
> firmware pre/after this change?

The old firmware is compatible with the driver before and after this
change. The new firmware needs to use with the driver after this change if
it wants to implement the new feature, otherwise it is the same as the old
firmware.

Does this explain make sense?

> 
> And please drop the fixes tag, thanks!
> 


