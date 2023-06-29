Return-Path: <netdev+bounces-14586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507277427E2
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 16:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6529E1C2031D
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F650125BF;
	Thu, 29 Jun 2023 14:03:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B3125B9
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 14:03:27 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712CE1FD8
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 07:03:25 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QsKt2034Dz9sc5;
	Thu, 29 Jun 2023 16:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1688047402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=07uQUdgDb/JcNp4hA8NmomZdrO7B9047HZSpQvUrJOs=;
	b=NhAqIDfwKQFssBzGXUfquWLNJ5b0+oNQtI3k2uMsCZjxZfnvZ+mKtH3JNdNlIlipM0EqkR
	e6DEGzWcGrxpQwGV2R7O5qNYaAGyTL0yNsxeFFZZBYBBhzF2OFtPdGopCpruCfUg7VuxEW
	o1+3sdRWm/Fnk+IZyS+vC0sG8wZpXlfEOJCp1d+k69R4+winbtpHYq/IJvFVinguz+kRZk
	50n4dPUwVDGU5mWsUIPxIDyrS401YDSoZTlMjtRQbRUD6h3Yme4k1fJSgEYdCeNHgZMMET
	v1s3Djnvy8fv44umfA9IpUwOs+etTEbkCaNNhKGAZMH6Vepl8CPGOQQJ4uc1qQ==
References: <20230628233813.6564-1-stephen@networkplumber.org>
 <20230628233813.6564-3-stephen@networkplumber.org>
From: Petr Machata <me@pmachata.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 2/5] fix fallthrough warnings
Date: Thu, 29 Jun 2023 15:54:24 +0200
In-reply-to: <20230628233813.6564-3-stephen@networkplumber.org>
Message-ID: <87cz1ee57b.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Stephen Hemminger <stephen@networkplumber.org> writes:

> In lib/utils.c comment for fallthrough was in wrong place
> and one was missing in xfrm_state.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

That xfrm code is a bit too sprawling to understand what's going on, but
it's hard to imagine what else than an intentional fall-through would
make sense in that context. With that:

Reviewed-by: Petr Machata <me@pmachata.org>

