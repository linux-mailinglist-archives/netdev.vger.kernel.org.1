Return-Path: <netdev+bounces-14481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7E5741E9E
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 05:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7031C208C3
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 03:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0891851;
	Thu, 29 Jun 2023 03:14:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBFA15CF
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:14:17 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73F62724
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 20:14:11 -0700 (PDT)
X-QQ-mid:Yeas53t1688008434t313t44889
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.195.149.82])
X-QQ-SSF:00400000000000F0FPF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 5295698947072354349
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20230628034204.213193-1-jiawenwu@trustnetic.com> <516f2276-e93b-4a90-a82f-8849d5bd3ccc@lunn.ch>
In-Reply-To: <516f2276-e93b-4a90-a82f-8849d5bd3ccc@lunn.ch>
Subject: RE: [PATCH net v2] net: txgbe: change LAN reset mode
Date: Thu, 29 Jun 2023 11:13:53 +0800
Message-ID: <02be01d9aa37$bbe042a0$33a0c7e0$@trustnetic.com>
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
Thread-Index: AQLZ/7y0uDQ2bquF6z0FvqKkvBzrkQIOra+erY/5eDA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wednesday, June 28, 2023 10:44 PM, Andrew Lunn wrote:
> On Wed, Jun 28, 2023 at 11:42:04AM +0800, Jiawen Wu wrote:
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
> You are posting this for net, so i assume you want this back ported.
> What is the real user observed problem here?
> 
> https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst

No real problems have occurred so far.  Maybe it should be post to net-next.


