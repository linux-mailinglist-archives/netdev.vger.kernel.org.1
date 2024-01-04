Return-Path: <netdev+bounces-61546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 774EE82438E
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CC6287435
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2F3224FE;
	Thu,  4 Jan 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="gmKmrGQy"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555A224E7
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmachata.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4T5TGm0pdlz9sp2;
	Thu,  4 Jan 2024 15:18:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1704377936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c7yPRs7vAf9WyQnjPNPLck/joQmBUXp+I0xLmU60u4c=;
	b=gmKmrGQyRf7vYTMwaaYoTNwcHDRMS2OT1DKEHqZv5USbDPK5aE+fllEWNjy7PJW/Mr/qdG
	EsWjRIa5DrklU4FLR8COkl5oZeNNTe5dsbM5qVVKTThJF2sz1V32ZvpR3XF3YvyJvlKRTm
	fp7lJjB3Dl1bTASJ1t6sjQiiA9R3oXzwiWogLVGrxvtnzTISvJVoddLoR7iKXm/No02R6r
	BJKTOPY0EQvTD8pJMLidN0nZDVMxtiWTpoUwIqwZv/1VaSRVQ96+3zJwdruZ5A3oGZEZB8
	bXdyYzlhtdzS1uCwKvB+wZD6TjDnguuVNx1552TF2ds/wHiyZP5iPRFu5Tt1+A==
References: <20240104011422.26736-1-stephen@networkplumber.org>
 <20240104011422.26736-5-stephen@networkplumber.org>
From: Petr Machata <me@pmachata.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: leon@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2 4/6] rdma: make supress_errors a bit
Date: Thu, 04 Jan 2024 15:17:59 +0100
In-reply-to: <20240104011422.26736-5-stephen@networkplumber.org>
Message-ID: <87zfxl5ghd.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4T5TGm0pdlz9sp2


Stephen Hemminger <stephen@networkplumber.org> writes:

> Like other command line flags supress_errors can be a bit.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Petr Machata <me@pmachata.org>

