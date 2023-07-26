Return-Path: <netdev+bounces-21536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860FF763D44
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 19:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBAA1C21220
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9221AA8B;
	Wed, 26 Jul 2023 17:09:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD21AA6C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 17:09:12 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02CD1BE3
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 10:09:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 394185C00F9;
	Wed, 26 Jul 2023 13:09:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 26 Jul 2023 13:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690391350; x=1690477750; bh=ggN26GMAWWRV1
	00Nbdaqj7DCJiOU/qF3Y/Smhz6qlec=; b=FOyQd95I+4dCGnwHSe7mrvX4yGA/T
	cTpT8cLE1IP94DSZvvc0+kltl4Tc7UorkVDSEJtHV6CXcDnBisu0IKtF9koX1n7P
	Fz2U3ER63Xyosi+kYi37o1t0bSR+kPvjjPQH6YnhJvjn0SCEgCcYL4lLjyUcVBC4
	NwL6TgP0N7SgvoGCv1BCMYY1L9k9Oir2TlTC+BcUW50+nsySwwaTPZBlhb//l6BK
	QbX4GyuEtISYk6qYALA9Q1TqCH+KLFvEVTMLqitYcfGRsQQZlOo+cgk/Pi0GAwcw
	PTsGf6DKx8xNbJf63Ta1jUnDgSh5c86M0UiBzNhosFL/9w0M/QtFh3esg==
X-ME-Sender: <xms:NVPBZBIIPAodSyotk1ovOqMy4AAxjaQQun5O_FMeaHNyPMloZv_tSQ>
    <xme:NVPBZNK3XZ_8PJ4wQzKRqk9rTixLGOUBU-x-z9rEpLdPBpdvj98y9Jviu0GsQb8sN
    cb4JTDLcXY9D1w>
X-ME-Received: <xmr:NVPBZJtIBpccNIBqJsMwfO2pkUkFailkBSI3pKrUN_I4ldwCK1aZ5Ia-cuY0ILBDjVxpBtRg86VqWjWtm5lStHIvXTPjYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:NVPBZCaYr5CohCBRXOP-HW7DcrwA5mQcEUEFBQN3g2usfgZT7v4rww>
    <xmx:NVPBZIawwdAZKGhxEB5lpp5ZfBTX2974SbGveS_U7igTzTi926-RHg>
    <xmx:NVPBZGApf1e8YgkbDtfhcqrPIvk8sYhFW9ba9lsIst5w6pR_RyyhUQ>
    <xmx:NlPBZFRwrVGeUedI7HS9J3M5YxdHO9Xkl3vdEPTCaq8BgosnHr3yeQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 13:09:08 -0400 (EDT)
Date: Wed, 26 Jul 2023 20:09:05 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Zahari Doychev <zdoychev@maxlinear.com>,
	Simon Horman <simon.horman@corigine.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH v2 net] net: flower: fix stack-out-of-bounds in
 fl_set_key_cfm()
Message-ID: <ZMFTMW8pc168mabK@shredder>
References: <20230726145815.943910-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726145815.943910-1-edumazet@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 02:58:15PM +0000, Eric Dumazet wrote:
> Typical misuse of
> 
> 	nla_parse_nested(array, XXX_MAX, ...);
> 
> array must be declared as
> 
> 	struct nlattr *array[XXX_MAX + 1];
> 
> v2: Based on feedbacks from Ido Schimmel and Zahari Doychev,
> I also changed TCA_FLOWER_KEY_CFM_OPT_MAX and cfm_opt_policy
> definitions.
> 
[...]

> 
> Fixes: 7cfffd5fed3e ("net: flower: add support for matching cfm fields")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Zahari Doychev <zdoychev@maxlinear.com>
> Cc: Simon Horman <simon.horman@corigine.com>
> Cc: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks

