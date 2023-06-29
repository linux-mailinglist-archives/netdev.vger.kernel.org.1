Return-Path: <netdev+bounces-14582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F8A7427A0
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 15:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F722280C48
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 13:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB7F11CB8;
	Thu, 29 Jun 2023 13:45:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25EE125A9
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 13:45:08 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B60D1FE7
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 06:45:06 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QsKSv2tg8z9sZd;
	Thu, 29 Jun 2023 15:45:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1688046303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hoeRTZ0Q3hYrPiJFed8cYsFzX61kSYukJTrpvMMn2z4=;
	b=gE8522o0L4tdkfUWCx6ULHsMlOje04BakK7FzXoBYG48w9dIjJLO1OqhY4RuyfLJXeIwaA
	5T+4h5NjvLzM6hY67ujMAzfbqV0ysYPZzdS1YeZSAt1+hFl+eWHFOsQObd3CTWGV1WfBk2
	ay/9ym1a+Dfts0QbOL/ScGjlTw518ovVEn7TbyjTR0tDOEnbqRX0K+RFu0RtJf/Kq2YpAk
	P9tLzazg4VFWuv4YZ0ZtLZpEkgZMtByH2k2Pb538d9eu305yXsCpIE2GuknmcF/nCI8TOG
	xxAHFGK0RYL5oO9EeUz7gpWfRaLt64HTsr+dVLtdq0Z0SUfUWc+VHmMrlL8GvA==
References: <20230628233813.6564-1-stephen@networkplumber.org>
 <20230628233813.6564-5-stephen@networkplumber.org>
From: Petr Machata <me@pmachata.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 4/5] ct: check for invalid proto
Date: Thu, 29 Jun 2023 15:44:43 +0200
In-reply-to: <20230628233813.6564-5-stephen@networkplumber.org>
Message-ID: <87leg2e61u.fsf@nvidia.com>
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

> Previously since proto was __u8 an invalid proto would
> be allowed.  Gcc warns about never true conditional
> since __u8 can never be negative.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Petr Machata <me@pmachata.org>

