Return-Path: <netdev+bounces-15177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 985707460ED
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 18:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F33A1C20913
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B0100BD;
	Mon,  3 Jul 2023 16:48:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75810100B9
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 16:48:27 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B991B3;
	Mon,  3 Jul 2023 09:48:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 453EB380;
	Mon,  3 Jul 2023 16:48:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 453EB380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1688402905; bh=ga2EVcZjyUVLHKl6pxSbhkekHnekyK0nM7VX3UKTxPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MxKMymnS/QXZ12hGw7nVY0jv3r80ODCvy5sDCB/WdK1ueibJUGeR7/NV+uschiU4/
	 g7w23SwJDPPKcHZfMxr+hm8uWto7D3/vWkpDOkNsNBAQhV5A+3qAO0FB+M4sk7Wh86
	 5U6M/LCG6xFhZdR9neBncjDO52tMWrCkrVq06qKcYix2rqnaQBvoInSvyAO4QFiOXq
	 LgX/tiViQ9J12Gsw1GyYyzjzii+2EiV3COAvsa7Ba+HyBxz4789DIjagnJo3LHgPaq
	 u3A7u4pbbpbFPaJSsNL5SvbU5YWV6o2ygosSNcsuTHOf+2vodQW2rue2N0G2hU1BkS
	 wod2AHHL8vXnQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-doc@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH docs] scripts: kernel-doc: support private / public
 marking for enums
In-Reply-To: <20230621223525.2722703-1-kuba@kernel.org>
References: <20230621223525.2722703-1-kuba@kernel.org>
Date: Mon, 03 Jul 2023 10:48:24 -0600
Message-ID: <875y71j607.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> Enums benefit from private markings, too. For netlink attribute
> name enums always end with a pair of __$n_MAX and $n_MAX members.
> Documenting them feels a bit tedious.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Hi Jon, we've CCed you recently on a related discussion
> but it appears that the fix is simple enough so posting
> it before you had a chance to reply.
> ---
>  scripts/kernel-doc | 3 +++
>  1 file changed, 3 insertions(+)

Hmm...somehow I missed the discussion, sorry.  Fix applied, thanks.

jon

