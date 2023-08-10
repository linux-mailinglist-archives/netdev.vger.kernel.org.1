Return-Path: <netdev+bounces-26466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7406C777E5F
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5986282320
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2971F93C;
	Thu, 10 Aug 2023 16:36:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014F1E1DC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:36:27 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D809C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:36:26 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 212C832005BC;
	Thu, 10 Aug 2023 12:36:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 10 Aug 2023 12:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691685384; x=1691771784; bh=a02C2z/AhG1VR
	LQ16fvQWeT4gYz+O3SSAhXOnLaNwN8=; b=BChiNIrLPCLQRByyJMCpkssTjVXmg
	7a4e3UUkjoez2vaiY/ZdUcQ2j7DsicZISuiae6+GLiFFOgtC1ZkhX46C9WKx0/Aw
	t0UefLTp17SN1+TA9nVYrK+PHm+q3hmfURReIdFMlrwuFuMSGem5fj3OjtZYq/ad
	jxBr6QfNpC+79kpOcZUL2kbTPN2Dhl5F4UVkeQO0LzjpTOgOuARsXYt39etBahQ4
	0Y5KgbZon4n7WF/jvSQh6YtXANNFrUEvLfP1Ik7/jegEAQjXfXtMOmVlQjebczjM
	bsM9SpbWnHxcAf/k5E6yyUD7W7+hp1mqr4wcaf83/x/Ro4+nKPnbdiCEw==
X-ME-Sender: <xms:CBLVZAac3IWnactmrjYW7_lorzWtZd2Iay7ACCWFoIQTyL192XIupA>
    <xme:CBLVZLbumYTGCSEWoEu0V31UnAbzAMiha78lHYXj0pUznnKwclL5v_otyVI_lm5PV
    wkMtdQoZJ-BMV4>
X-ME-Received: <xmr:CBLVZK9_Kp3Pvslt0J5j6EhWZ3CsKGl1KNjy7V8R08NdqW7SzIyBMp00STyZqLAkDzbbsR4-nspb0iZ_US144VbBCF8z8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeigddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:CBLVZKoDB9alY5dD2zgZwI2LpgZd_tn2ICYRGrTyIkttVnHCIvFlTw>
    <xmx:CBLVZLoPQ3fuJjVgsut7BepPhGAA22kMUW_1JNC_W3qJ_0rVFW9pgw>
    <xmx:CBLVZIRqDVTPYGEUJ3KKR5A08BbRUOdB5fBPqIkLcqnkwLCrAT3SFw>
    <xmx:CBLVZO1i7OvQCeFzLtUU0q3DggEcfXvhnev9la7DYQ7-OjseYP-I4g>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Aug 2023 12:36:23 -0400 (EDT)
Date: Thu, 10 Aug 2023 19:36:19 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
	jbenc@redhat.com, gavinl@nvidia.com,
	wsa+renesas@sang-engineering.com, vladimir@nikishkin.pw,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] vxlan: Use helper functions to update stats
Message-ID: <ZNUSA3ZMDB+ymMAJ@shredder>
References: <20230810085642.3781460-1-lizetao1@huawei.com>
 <20230810085642.3781460-3-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810085642.3781460-3-lizetao1@huawei.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 04:56:42PM +0800, Li Zetao wrote:
> Use the helper functions dev_sw_netstats_rx_add() and
> dev_sw_netstats_tx_add() to update stats, which helps to
> provide code readability.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

