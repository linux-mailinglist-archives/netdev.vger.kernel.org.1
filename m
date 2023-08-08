Return-Path: <netdev+bounces-25290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FCC773B20
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCFE1C2105B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A6D134A2;
	Tue,  8 Aug 2023 15:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB213AD8
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:41:56 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DD64237
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:41:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 4D4003200908;
	Tue,  8 Aug 2023 07:36:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 08 Aug 2023 07:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691494599; x=1691580999; bh=3Q/eY5w9nDCM4
	40MCQpwIzLyHwWfBJad9fCeXeySfn0=; b=rRg6E0MSecuXdO+2Z9d31GMkKdRUC
	BOZZU7UiH6E1hgmRXVioSSqN2DFB8NO1vYpUEm5+kLq+QUSdA3CUMWSSm1KW2VXc
	3dDf4U7sSrSd1kRW+5eO3diMQqm9ehhWwCwtYzMExnzcJ45c0INN70uL9MFM+MbN
	tV39aQ0HvDP7SqaQvFaxNQNtQ6mq6FSxVOv86PjcRCE1i2nOaNKk2ZqXfjgaSNIi
	LG2WbD0ImaMp9O8wK5KZOFiDyhCX9zzBQRrqCS3OTvAhI+QkaKvGJ81zVQB0+FgC
	gkgl3v7GiC/iwnlTjkyXwEUle2Bscwq/dQ0nfpazwKZD9j2a4XXx4nAhw==
X-ME-Sender: <xms:xyjSZJY9XwhEZw47Yy-xnnL56_1TwiM3RRaC-t6rKD8JFD7WGPZjmg>
    <xme:xyjSZAYZIERuo5G5xUdIqe7oUHs3b_UpOWmyjy5cR51-TGyaGmRQkJPqRI5lZYWZj
    rt5nhywx3loYeg>
X-ME-Received: <xmr:xyjSZL9jDhWVmF75L9uPgFqnjyONDiYDOjH9Dmyk1dC5SnZhvBfHP6LMh3r_UAuJZZNSKJ0qQMbzhtr_XqkkH3JXG_MCGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeffueevhffhuddvjeetfeeuudfgheegledvveehheeuueduvdehgedtteefheeg
    feenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:xyjSZHp-tb_kjrGrzIYyeUHO3BRWx2ZgkpxgLMbNe_zwOsTUA_pbGw>
    <xmx:xyjSZEo6pFAVwsqbaw624pBaT0ZZybTSfhz_IrpQuYrHyGnoc_3Qeg>
    <xmx:xyjSZNTpaUtqd3GNEhYXY4G0WMGSh5W5sIB-G4K8xLlPv71VnBh3JA>
    <xmx:xyjSZLSZttq1rOH_NXROP-f02SKEDj3hAVM157TComc-70rSSRJjQg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 07:36:38 -0400 (EDT)
Date: Tue, 8 Aug 2023 14:36:34 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org
Subject: Re: [iproute2,v2] man: bridge: update bridge link show
Message-ID: <ZNIowqAsMJhhUtoq@shredder>
References: <20230804164952.2649270-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804164952.2649270-1-nico.escande@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 06:49:52PM +0200, Nicolas Escande wrote:
> Add missing man page documentation for bridge link show features added in
> 13a5d8fcb41b (bridge: link: allow filtering on bridge name) and
> 64108901b737 (bridge: Add support for setting bridge port attributes)

FYI, the convention is to refer to a commit in the following format:

13a5d8fcb41b ("bridge: link: allow filtering on bridge name")

See [1], near the end of the section.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks

