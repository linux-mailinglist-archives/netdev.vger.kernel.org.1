Return-Path: <netdev+bounces-14758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492C6743AD0
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 13:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A801C20BBC
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 11:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1257134C2;
	Fri, 30 Jun 2023 11:27:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E137D101F8
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 11:27:00 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD288C0
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 04:26:55 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QstLz48w9z9sW1;
	Fri, 30 Jun 2023 13:26:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1688124411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/3w9nPy0ZNmiHZ09TesyH1QSLLpsIn2iXhVXSCa0o4=;
	b=lmp8mhkpqYibUfbhF53L+PgfQzAKTR9LP9Az07hNM5zYNkRGVky+IaM5LfIWVZVWg+STbm
	9QNmRNb6kx3A6JuYymPf7mpfMZ8KcS6wvrQkTrJx6lzSzjbtJ9NuVdULC9MHnSwdB6Ohdt
	1tv+VpEchP/dMwiWh4711pq7RPUUAQzq/VLvV/OQooB/+g1NOjcKPvC24ouvYaPUmkbYYq
	S0R85FT7uUHZowPhihKfX2o9XV9Jel7QrZvjkNMlO7fzVAJBwn8+clfbEuGcLUTTQC3fpQ
	pTIS1WgNA2Ej4iAeDDvQnJZLdV2PlAR/s+M2W/Qey9uta0OLf1i1iNLmyT/jbQ==
References: <20230629195736.675018-1-zahari.doychev@linux.com>
From: Petr Machata <me@pmachata.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 hmehrtens@maxlinear.com, aleksander.lobakin@intel.com,
 simon.horman@corigine.com, idosch@idosch.org, Zahari Doychev
 <zdoychev@maxlinear.com>
Subject: Re: [PATCH iproute2-next] f_flower: simplify cfm dump function
Date: Fri, 30 Jun 2023 13:22:45 +0200
In-reply-to: <20230629195736.675018-1-zahari.doychev@linux.com>
Message-ID: <87leg1xkax.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4QstLz48w9z9sW1
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Zahari Doychev <zahari.doychev@linux.com> writes:

> From: Zahari Doychev <zdoychev@maxlinear.com>
>
> The standard print function can be used to print the cfm attributes in
> both standard and json use cases. In this way no string buffer is needed
> which simplifies the code.

This looks correct, but please make sure that the diff between the old
and the new way is empty in both JSON and FP mode.

> Signed-off-by: Zahari Doychev <zdoychev@maxlinear.com>

Reviewed-by: Petr Machata <me@pmachata.org>

