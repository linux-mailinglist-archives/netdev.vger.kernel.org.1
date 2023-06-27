Return-Path: <netdev+bounces-14148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBDE73F416
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 07:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C34280FC4
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 05:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C54E1396;
	Tue, 27 Jun 2023 05:51:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA0F1C3D
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 05:51:36 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC21519A1
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 22:51:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 91F5F5C01D5;
	Tue, 27 Jun 2023 01:51:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 27 Jun 2023 01:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1687845091; x=1687931491; bh=vfYFM/eIiHcPb
	FuLctadjTGPsOtdsNBpz3qvMmshr94=; b=dQV2KIDIFRBsRDICMBTJzyjd+farP
	1BbmaxTCMiqn9jwC2oYCEsciVOdP2uhjjMsdXrNVilXEjx4NHPcHkJPG8LsKHrIE
	G+zyJI+dGiIxVnb4Att0BSLUBYcl70awyzMIHN5jXETTIhZicx8cquwMjbUqWiTk
	ZVMi5VagobEcj2ftyyMKWpWbQsr6OSkOAbzAFWKsj9qGKSGw7EgVY33TTFnqKuCa
	E/yqpW3UZ8+TK5rApFHAuvI+X3OOwtWvTy7ZG5eFYwRpr0usYx9+TLb3FOaq0HN0
	iRj1+WQWLl3iP6u94g3GULW0mhtz1319b5Noad+ueQ+fcsPEROXKpcCaw==
X-ME-Sender: <xms:43iaZJ6ktBiu2wz9K7xioUAOdT4Z1lTKKwMAmxaFxQ8Cc7Z3RjZajg>
    <xme:43iaZG4nbt69ohoA3WgNfhcC-N2sC77VV5NMjNcmiw9tbIU5AfDS8gqGCF3ZHCbLx
    nzYfJPlOS5-UUE>
X-ME-Received: <xmr:43iaZAf2G2FHnCx7ByHsQUOF9VeE-YaaUWXEEb72JOZ6ivoEJIvcteue3TeDQdn5PKMl8oGfZZ_-djpyE25GNJdUDv0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehgedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfh
    jeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:43iaZCJ3SZ31nfW5BJXsZ8rpnccddGWh_by5JTpO_hTIpNsHK3y0Pw>
    <xmx:43iaZNIJ7IR0SYtNzRigkBKMzpc5qkk2WgS2WnzqNYce44X82PmVBw>
    <xmx:43iaZLx20VOKKZcBvMt3rW44J8FZftLfBHG0zhjKxbjap1IZx0-mDw>
    <xmx:43iaZLje4kRAsh4I_j9NgL7y7QLTeGpDhy1CUWom8CQGwnvXvI15Gg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jun 2023 01:51:30 -0400 (EDT)
Date: Tue, 27 Jun 2023 08:51:27 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v1 net-next] Revert "af_unix: Call scm_recv() only after
 scm_set_cred()."
Message-ID: <ZJp433emuSZcZc4m@shredder>
References: <20230626205837.82086-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626205837.82086-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 01:58:37PM -0700, Kuniyuki Iwashima wrote:
> This reverts commit 3f5f118bb657f94641ea383c7c1b8c09a5d46ea2.
> 
> Konrad reported that desktop environment below cannot be reached after
> commit 3f5f118bb657 ("af_unix: Call scm_recv() only after scm_set_cred().")
> 
>   - postmarketOS (Alpine Linux w/ musl 1.2.4)
>   - busybox 1.36.1
>   - GNOME 44.1
>   - networkmanager 1.42.6
>   - openrc 0.47
> 
> Regarding to the warning of SO_PASSPIDFD, I'll post another patch to
> suppress it by skipping SCM_PIDFD if scm->pid == NULL in scm_pidfd_recv().
> 
> Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> Link: https://lore.kernel.org/netdev/8c7f9abd-4f84-7296-2788-1e130d6304a0@kernel.org/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Tested-by: Ido Schimmel <idosch@nvidia.com>

