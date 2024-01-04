Return-Path: <netdev+bounces-61498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5FB8240A6
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 12:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29EE1C215D6
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643BE2110D;
	Thu,  4 Jan 2024 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="sZAilHdQ"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067821101
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmachata.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4T5PVp1J5Mz9sv3;
	Thu,  4 Jan 2024 12:29:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1704367746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QvVvhYxtNSn3UDh1RWG+djbjpMav7qFO/KvzSNlMBUU=;
	b=sZAilHdQ3NonvA+bHqFQ5/9NR1LsdICVbbzFPDywDZUYSx3AMW1hRgbgxw9vqANsHHpmxi
	NnTbQMJGuYQ+4Z2wbq8Iglv9uRw6F9gavsR7PhAC4ktz+a5eHmoWBUCSut/ybFva7tC0q2
	k21E/QsOY/O7AjKzi5bgIdRHuP63Mw2TksZiYPIR3NubHXHuif6EvnLmJ/DSjHyKQM9RzZ
	UMgsxVNjrSvlvkO/Ds2SlCc2ePI3L1bNCK2hJb6wuv9IHoxAAPHm6SYwj+sD7SEsYtVLtt
	TZ1ZB0RR+/pta8ZRx2oaLlE1AlS79IgxVg+mGElCjiNbGqAJZOqVUv5EQ0IESQ==
References: <20240104011422.26736-1-stephen@networkplumber.org>
 <20240104011422.26736-2-stephen@networkplumber.org>
From: Petr Machata <me@pmachata.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: leon@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2 1/6] rdma: shorten print_ lines
Date: Thu, 04 Jan 2024 12:28:37 +0100
In-reply-to: <20240104011422.26736-2-stephen@networkplumber.org>
Message-ID: <87h6jt72wv.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Stephen Hemminger <stephen@networkplumber.org> writes:

> With the shorter form of print_ function some of the lines can
> now be shortened. Max line length in iproute2 should be 100 characters
> or less.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Petr Machata <me@pmachata.org>

