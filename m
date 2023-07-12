Return-Path: <netdev+bounces-17174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2389750B6F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29BE1C20FFF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080582AB4C;
	Wed, 12 Jul 2023 14:54:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3C21F199
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:54:05 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0E9BB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:54:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id B50D55C0186;
	Wed, 12 Jul 2023 10:54:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 12 Jul 2023 10:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1689173643; x=1689260043; bh=Obdgo1ph00bZH
	C4Rao8ThDReb5dSQF1kT34rZ91WFTE=; b=dymLeyf767vKvw7DaKJM0Dii5A7LX
	RZ4Mf/0kHzgeXmHZmrPM/P4gmp1ktIfgjofNJGNgrceHLjHA4Cp35ijtSXY4Vrv7
	MlSSh4C2+ASUxUCkrLVo6tv3zxUmBssdxYQwO5d2LauQEactqFSXJGUxF/nwK8n9
	i0X6943CwY6PJ7eREhzB8KoO6GnSO89c0XnggOu2WlPt3sKAk+N4xhqi+r9yS3nh
	NaK1U8lqchwiIhsVzivDcoVdVMNcABOFc8ENvh+417xBC8WejQi2TmieX5syle+f
	JlJnAMEgUbvW6lZo5i4KIu/G3IwWBmiFOEPyBNpA2re+X9IBWSt2UO1hA==
X-ME-Sender: <xms:ir6uZDDZOi6xT_08CQxA_WCS_AUsYhVFJyK0DGKhENCdAEuy-3CSwA>
    <xme:ir6uZJi1Za50NRXuExyMughSDGKdFnNR5UHfgT5Is5Dw078imfKhrc4ioT1TjQkhm
    fmFfRHF0cn8ndA>
X-ME-Received: <xmr:ir6uZOk59dFtX2qKs8ID--88lycnisnBjbQYgRB6Ywzry3EZujsIWsFumONBnHKslGQXojzs6pCV0GtcINkPaXPGteA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedvgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:i76uZFxqIG2qwemUGCW-J2nSTBvFw2_B5w5fNspoRSxXdhXQMYgK_w>
    <xmx:i76uZIS1b6f5dtWuAaroFdH4bHXWDClvLsXJIqTO_sJHA9XPAYZUag>
    <xmx:i76uZIZ9O_Zofa8wbqjZ6wRKztCSY_pYsGqdnhxqgWq-dHSI5ABUQA>
    <xmx:i76uZB_a1MT5vm3KvjP7klOS3aLJgrSuJS-38nrA-ig4dl5AJ0lxew>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 10:54:02 -0400 (EDT)
Date: Wed, 12 Jul 2023 17:53:59 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Roopa Prabhu <roopa@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org,
	Harry Coin <hcoin@quietfountain.com>
Subject: Re: [PATCH v1 net] bridge: Return an error when enabling STP in
 netns.
Message-ID: <ZK6+hwL5p7OVy04X@shredder>
References: <20230711235415.92166-1-kuniyu@amazon.com>
 <ZK69NDM60+N0TTFh@shredder>
 <caf5bc87-0b5f-cd44-3c1c-5842549c8c6e@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caf5bc87-0b5f-cd44-3c1c-5842549c8c6e@blackwall.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 05:52:09PM +0300, Nikolay Aleksandrov wrote:
> I'd prefer this approach to changing user-visible behaviour and potential regressions.
> Just change the warning message.

Yea, I noticed after sending that the message no longer fits :)

