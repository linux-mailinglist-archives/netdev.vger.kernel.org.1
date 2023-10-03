Return-Path: <netdev+bounces-37837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2DD7B74C4
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 318421F21950
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2053A3FB23;
	Tue,  3 Oct 2023 23:22:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5C3F4CF
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:22:17 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E657B0
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:22:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id C074C5C0285;
	Tue,  3 Oct 2023 19:22:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 03 Oct 2023 19:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skym.fi; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1696375335; x=1696461735; bh=VN
	OyPEWBQAAFLac97WL6aEfmGtPB+AEqwcXs+k/LkAw=; b=e1jltFeepNEtWtM+jc
	kFdEAAiWJKXW75hv/S+QiWld6lIyqRsOz8zO57WeplNmXgtAQGNR1gcRvR4hc+o2
	7CHLiNIey43tsL2IVI+A5Dq3BbuKQo3ECW5Krd/XHiiX4EQmXJA1y8ObHTiwp/l4
	h93a7zkF1g7nSNSuOT12+wF4YT0a41j/aRjvw6Vy9P79ERJBr9YHjaOYov/oEXOC
	nCi5HEeLM0JbCQWWG0ru98UHCP/7lox9ti99RCTLX5HvaSHtoJr6xiYpLwc5p4Cc
	M5/q9k/W1uPwFaev9msWdEafsQbl14fflL73ZqeApgoIcm6KjbvIzSY5Rk5iwZkl
	ngnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1696375335; x=1696461735; bh=V
	NOyPEWBQAAFLac97WL6aEfmGtPB+AEqwcXs+k/LkAw=; b=iBLZ1i60GgblyVDG7
	SBJYlFUNa0ECBBTZ/vDs+GtTWe8pwrk46OVJL3dYaSnKozlZizYoxUDlcKt/fgQS
	aZH/rWmXAYcC2C9gmE9uFFX3f2o2auLv6yAawP41oDV2JK4GCsQvXnhDS9BD7q6H
	qU6jGjouoGAezOuhLJkAPemOfh4l4fXQtLnR9PcFQ2QATYRk90edWyfNKt6Nawrt
	5r4hBOr1aZvr2L+9qp7g59JnGifVnGHMAesq1VgZmSiol7cDRooSfSGSucy5JYtj
	Gy/sePHYSXI51GTbFhHuJDMg3hajVw8qNQvYjnpDXa4RDgS5Jdj1hxWyZ1DCqB6Z
	vN9pA==
X-ME-Sender: <xms:J6IcZZU3hA1s4BZ3IqIlD2tKGGqnReHPtvKx87eElFCa-IFSHftK9w>
    <xme:J6IcZZmkjUZXxf3Ua6TKno6958yqieQxri_wA2gKRQD22iRpYrrAPh2nQO6eXUK9M
    8J8G0Do__PszDv9-Oc>
X-ME-Received: <xmr:J6IcZVbjnK5W3HtGiYS0O_sA5jP8ao4R3dCjylDrs-NGPO5keqbu_0yRZqCbCzB0nOENKw7ziQvcURnGxHSQFLUAfLz02MAohsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfvfevhffupfgtgfesthekre
    dttdefjeenucfhrhhomhepufhkhihlvghrucfomohnthihshgrrghrihcuoehsmhdolhhi
    shhtshesshhkhihmrdhfiheqnecuggftrfgrthhtvghrnhephfejheehudefveekgeelle
    euffffteejudfhgfduueetkeehudeguefhvdetfffhnecuffhomhgrihhnpehvhihoshdr
    ihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hmodhlihhsthhssehskhihmhdrfhhi
X-ME-Proxy: <xmx:J6IcZcV7N7lKA0iddF1gYAKPoMd4t5cGT9O-nEW99V7iXS-ovxKPQQ>
    <xmx:J6IcZTl1suHUoaqU439HH6NNZiZ8KS_ZlWRjXdL40sBuateTYQ7cng>
    <xmx:J6IcZZe7v21cOFZTtMrug0MnHfabhlsOiRbqZig-0xIMKovV07l00Q>
    <xmx:J6IcZSvVJmGSH-XxI7856-DsYHJ09EI6GGXGVagnNqaD0rXBsqvxMA>
Feedback-ID: i1cc947c0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Oct 2023 19:22:14 -0400 (EDT)
Message-ID: <5135ae4c-4a0f-d2ac-84e5-dc27c4c5e18c@skym.fi>
Date: Wed, 4 Oct 2023 02:22:11 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
From: =?UTF-8?Q?Skyler_M=c3=a4ntysaari?= <sm+lists@skym.fi>
Subject: The difference between linux kernel driver and FreeBSD's with Intel
 X533
Disposition-Notification-To: =?UTF-8?Q?Skyler_M=c3=a4ntysaari?=
 <sm+lists@skym.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi there,

It seems that for reasons unknown to me, my Intel X533 based 10G SFP+ 
doesn't want to work with kernel 6.1.55 in VyOS 1.4 nor Debian 12 but it 
does in OPNsense which is based on FreeBSD 13.2.

How would I go about debugging this properly? Both sides see light, but 
no link unless I'm using FreeBSD.

For reference the thread on VyOS forums regarding this: 
https://forum.vyos.io/t/10g-sfp-trouble-with-linking-intel-x553/12253

Best regards,
Skyler Mäntysaari


