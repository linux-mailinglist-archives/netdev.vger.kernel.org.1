Return-Path: <netdev+bounces-42870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCBD7D0777
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5DF9B210A3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF7CA53;
	Fri, 20 Oct 2023 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="MS/i9+F0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76808A41
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:03:37 +0000 (UTC)
Received: from qs51p00im-qukt01071902.me.com (qs51p00im-qukt01071902.me.com [17.57.155.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4357D50
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 22:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1697778214;
	bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=MS/i9+F0zR4FYR+RqsfB2EHJ/wB6xaoM3yQgxjR4dPSApMzp0VZcqU4MJ21AvjCoD
	 zYYmxdgRZyS0aAc938BgfwBFJeEy6s8zhPpZ6FQlPZz06ginIy/zqWO1AUl7tcTqAh
	 sYyhf600s8B0VdaxMutFFyRLIe8XdAbrHi3apUBaG60KJj81Sla+KTsf0Y7n2a5CX6
	 25aSC+6OhFu80luD8Ld2EGJlRdq40OpKmU5eCT2KYMSBpyxyvAiPTaPzE7oVde4dtN
	 PnydZ7R/MLoIhZz7g8j5GyjWOEw0qtj6e5MOo9F+0qd0jyL2tN/8Hq0N82yZ96UOps
	 XY6dSgXWVx3Zg==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071902.me.com (Postfix) with ESMTPSA id B646F5EC014B;
	Fri, 20 Oct 2023 05:03:32 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Shahadin Shaz <shahadin.shaz@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 20 Oct 2023 09:03:16 +0400
Subject: Re: [patch net-next v2 00/11] devlink: use spec to generate split whatspp QR code Instagram password atm pin Nomper gallery data file managemer hidden files
Message-Id: <BEF6225F-1DEC-407A-8224-8D523D5B88B5@icloud.com>
Cc: davem@davemloft.net, edumazet@google.com, idosch@nvidia.com,
 kuba@kernel.org, moshe@nvidia.com, netdev@vger.kernel.org, pabeni@redhat.com,
 petrm@nvidia.com, saeedm@nvidia.com
To: jiri@resnulli.us
X-Mailer: iPhone Mail (20H19)
X-Proofpoint-GUID: IhUzb8R3E1l0A4eo-7kDUhTLsCT0v7k5
X-Proofpoint-ORIG-GUID: IhUzb8R3E1l0A4eo-7kDUhTLsCT0v7k5
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015 adultscore=0
 mlxlogscore=696 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310200043



Sent from my iPhone

