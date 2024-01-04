Return-Path: <netdev+bounces-61497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E5782407F
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 12:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EECB1C209F8
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002CA210F6;
	Thu,  4 Jan 2024 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="uSY795Yh"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58555210F4
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmachata.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T5PKP1l09z9sst;
	Thu,  4 Jan 2024 12:20:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1704367257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FZaj0jedT1v9cFHpAbNpbe3b5/CJ+muFX9dJhL0Etgo=;
	b=uSY795YhZeXL2eOpLv9j8s2YFbTsyauTGVav3/shoGEGg/8/aQaHnASs5I9nYZifmOHmkZ
	3BbHXqp13IN8o1gK9CbHZ6n6TqR9ZRMVFbyPl0tSB8tSvdNyehpKzVXzHp6kb9LkEYM7rj
	t94be+jcWzEfPrNfy7Zz3vXwFOl/KRibTeM8FG7dcmVlOTvgZhOeMeCO765ST2IPjjU01M
	Kb3UX1X6V/r77jN2MuwtfS0AXDIK9ZrVQxoX8VK1DU3jSJMtTZjZH0ofUBiyY7HLoM6iIO
	3Z+6UvqgYlDO0yJ4GCt2X/r1aoGfLrABZWDg4sO5O8nk2G6HNsLtUNbAcGpzPQ==
References: <20240104003127.23877-2-stephen@networkplumber.org>
From: Petr Machata <me@pmachata.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] ip: merge duplicate if clauses
Date: Thu, 04 Jan 2024 12:18:09 +0100
In-reply-to: <20240104003127.23877-2-stephen@networkplumber.org>
Message-ID: <87o7e173ag.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4T5PKP1l09z9sst


Stephen Hemminger <stephen@networkplumber.org> writes:

> The code that handles brief option had two exactly matching
> if (filter == AF_PACKET) clauses; merge them
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Petr Machata <me@pmachata.org>

