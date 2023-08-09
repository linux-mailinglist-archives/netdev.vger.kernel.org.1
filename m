Return-Path: <netdev+bounces-25700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5724C77533B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891061C20BBF
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 06:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634F97F3;
	Wed,  9 Aug 2023 06:51:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF746B0
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:51:08 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE6A10CF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:51:03 -0700 (PDT)
X-QQ-mid:Yeas54t1691563741t685t41113
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.195.149.19])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 15458413322076864255
To: "'Andrew Lunn'" <andrew@lunn.ch>,
	"'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<hkallweit1@gmail.com>,
	<Jose.Abreu@synopsys.com>,
	<mengyuanlou@net-swift.com>
References: <20230808021708.196160-1-jiawenwu@trustnetic.com> <20230808021708.196160-2-jiawenwu@trustnetic.com> <ZNIJDMwlBa/LRJ0C@shell.armlinux.org.uk> <082101d9c9dd$2595f400$70c1dc00$@trustnetic.com> <ZNISkaXBNO5z6csw@shell.armlinux.org.uk> <b53e4e02-dc74-4993-937d-6acd5d1cdd9b@lunn.ch>
In-Reply-To: <b53e4e02-dc74-4993-937d-6acd5d1cdd9b@lunn.ch>
Subject: RE: [PATCH net-next v2 1/7] net: pcs: xpcs: add specific vendor supoprt for Wangxun 10Gb NICs
Date: Wed, 9 Aug 2023 14:49:00 +0800
Message-ID: <086a01d9ca8d$94387df0$bca979d0$@trustnetic.com>
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
Thread-Index: AQGWRt0YcmdMZE8wG3Q/Y3QvRd722AIybcEnAacw0j0CULtFTQKILPRlAgR2lwqwEtFw8A==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wednesday, August 9, 2023 4:42 AM, Andrew Lunn wrote:
> > > > If the answer to that is yes, it would be preferable to use that
> > > > rather than adding a bitarray of flags to indicate various "quirks".
> > >
> > > It has not been implemented yet. We could implement it in flash if it's wanted.
> > > But it would require upgrading to the new firmware.
> >
> > Andrew, do you any opinions? Do you think it would be a good idea to
> > use the device/package identifiers, rather than a bitfield of quirks?
> 
> Using identifiers would be cleaner.
> 
> Does trustnetic or net-swift have an OUI?

Yes, net-swift's OUI is 30:09:F9.

But if we want to read OUI from PCS to identify the vendor, we need the
next version of firmware to do this. How can this be compatible with the
old firmware version?


