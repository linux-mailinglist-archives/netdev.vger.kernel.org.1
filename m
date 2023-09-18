Return-Path: <netdev+bounces-34424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F167A422A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCED28161C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 07:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F670748D;
	Mon, 18 Sep 2023 07:20:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B23C2C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 07:20:48 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA5A8
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 00:20:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 6C86A5C0195;
	Mon, 18 Sep 2023 03:20:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Sep 2023 03:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1695021642; x=1695108042; bh=74rJpM4r0ga6/
	myFAwv3LP42Eq5W9bJkbFRn9KLTXXk=; b=ckaYwwbgZ/cVkRGmW7nXQ5PRDOVvq
	bagQ236SYsJ/JSRLw5CgOBP1SZ0633P2qwVgvEGq7PTtruD6mi24uoT4JWoWzBn2
	E2IOag0gNfhE8Z1HYOkzlVdiDNSU/hJIHPy1uyh/eBTVU+Gjw5ftsw8sKccyt+Rf
	6RkgMF33g05uXGx9IGHoTVb/U8uKdhrngPMwc/5pJWpANQP525j/9Tuu2HryoTzR
	VLmSGJodLFfs24AHnNsWAIPM2cIy4Sl1gTgnkY9dmb4LRpU7sDvY8tXxa7XkQAoS
	57gOAZWp7XRo1zYHUXYyjSNCtwfUVS0vBRIHyEk3ERC096vjkPEiVZJ9Q==
X-ME-Sender: <xms:SvoHZY2s0_Rm895wxU4U2H2O8FqGEUdc1s3CeVJUIW49nwaaaIXKew>
    <xme:SvoHZTFCGQvWHBKD3rc6UrN8cZrIwH5Z-6A8IXCHUa-755Qp5-Yl0-ZUGkBxab_cF
    YH97F77rCD2YV0>
X-ME-Received: <xmr:SvoHZQ6NxeXsOnEt7aVdJWTuu2bMfuO6gr1IdMYbCHJsMDho-X0fOtl9lqxbPvgXJjxj4klHKGHG05exEpBlc3hllNBjvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejjedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeej
    geeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:SvoHZR0Po8PWoM8ZBHJ8LBWuD0g_Rzzz-sH9HhfpAnKqS_R7-mhPCw>
    <xmx:SvoHZbFBAR0ehy7YV-p05s8xGlk1uICTGieisfiFnH-SsjsTUi2PnQ>
    <xmx:SvoHZa-aoAiMgoNJzrcnEgVJJXBJ4jrAJPHEx_X6GhKootSyugactg>
    <xmx:SvoHZeP9ZY7wcMTBxVuVuk7atS5woM3IinWn8j9o24ImzasbI8wIxw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Sep 2023 03:20:41 -0400 (EDT)
Date: Mon, 18 Sep 2023 10:20:36 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com
Subject: Re: [PATCH iproute2] bridge: fix missing quote on man page
Message-ID: <ZQf6RNyTeLQ8kvJp@shredder>
References: <20230916145844.7743-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916145844.7743-1-stephen@networkplumber.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 16, 2023 at 07:58:44AM -0700, Stephen Hemminger wrote:
> Noticed that emacs colorizing of bridge man page was messed up.
> Problem was missing quoute in one macro.
> 
> Fixes: a3f4565e0a64 ("bridge: mdb: Add outgoing interface support")
> Cc: idosch@nvidia.com
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

