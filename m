Return-Path: <netdev+bounces-15044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 638E87456BC
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC2F1C20510
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877E9A34;
	Mon,  3 Jul 2023 08:02:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F0138D
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:02:42 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB5F1993
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 01:02:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 71CA15C01C8;
	Mon,  3 Jul 2023 04:01:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Jul 2023 04:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1688371304; x=1688457704; bh=BYI7zc4MEAhpZ
	w93FL9/xlC6ezfaHZ7I1Xp2+zgUQdw=; b=en3op7ply6Rt3TF//CNHH8cFh8F2B
	xXPYm82lFUlp/Ge78eO4+XHqFuzp/qrvdKxxET7tjPibPAth92Xv0S3pxMPTJxA9
	fISfDpqlSUA01igpNeymuV9T9paj5OHJyv9WGsJUDs5ra35sCzg09F2Vnm4DtlGR
	FuLtYtB8+K+AqsuKHYttSvMU7GBjKNOQI4h+dIduLrXNJhtQh0EtNnuWEB+2HNat
	zpQnFHZcE7GjWuqxZvp2awcNo3J4uUe8iIOYj426iuuov5DwHTfs4SO39CCYgFq7
	Hcd1JcRitZI/Cc0Tdc2Y+RouW3aOHfKp1NbCIoap2m1Xt2YpDFNdp8K3Q==
X-ME-Sender: <xms:Z4CiZBpVzlvRfXVXAbcIivmGAmk66IzPibMZGz4wWCUrhxlYptfnbA>
    <xme:Z4CiZDq0Pb_dV009NpC_aIxoNgiv5ggdnI_lvR-veelqRWtgZLQpjjpVKHURzP9A5
    EjZhzQtSRAKHbY>
X-ME-Received: <xmr:Z4CiZOMwCkan2MrGpYfIkaqWaS6al9YQ0B5Q6FFxGsPRpCBCkB9l6NbrlfvB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddugdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:aICiZM4uaiqbeW00Iz6aI-dLz60qLvAVrjyzCu0a0A4ReKq8Wx8xkg>
    <xmx:aICiZA7GbntAm6QoGP1XX5cmUByjP3zuVpYKk1Bg4kT-bT18H_t7JQ>
    <xmx:aICiZEiE6U20QMfRUXyV46ljaYvh8t8XlkmqZVQDHOVx3cw_gRshjw>
    <xmx:aICiZKTGAavto4S9-Glu_VaEUytT0DKjbVJ8vy1lX0j-jg0dsCRScQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jul 2023 04:01:43 -0400 (EDT)
Date: Mon, 3 Jul 2023 11:01:39 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
	hmehrtens@maxlinear.com, aleksander.lobakin@intel.com,
	simon.horman@corigine.com, Zahari Doychev <zdoychev@maxlinear.com>
Subject: Re: [PATCH iproute2-next] f_flower: simplify cfm dump function
Message-ID: <ZKKAY3cIUQuFnUvE@shredder>
References: <20230629195736.675018-1-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629195736.675018-1-zahari.doychev@linux.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 09:57:36PM +0200, Zahari Doychev wrote:
> From: Zahari Doychev <zdoychev@maxlinear.com>
> 
> The standard print function can be used to print the cfm attributes in
> both standard and json use cases. In this way no string buffer is needed
> which simplifies the code.
> 
> Signed-off-by: Zahari Doychev <zdoychev@maxlinear.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

