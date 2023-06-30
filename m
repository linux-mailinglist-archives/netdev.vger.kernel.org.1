Return-Path: <netdev+bounces-14682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B73574315E
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 02:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2420280ED6
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 00:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E483E19C;
	Fri, 30 Jun 2023 00:01:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCA3180
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 00:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B16C433C8;
	Fri, 30 Jun 2023 00:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688083317;
	bh=Bej09wYFcT6D4FI/gm1ZGuRayoSdiiH2baukOvRvHEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LWmFFlvh/aXLzdmV/dcJn2GkigvCiQc4jA7nQOHqgG2p9NVoIcuBPwtlHgVSDIK/+
	 P6tfAOINFIzPaS1CaW8XWgs/r6B6QCZJV0uCr1+EwSz450QpPBHiYM8ZYeinUqLrjP
	 TiQQSKO7TvNHS4zAQCm0eMEsYBGHFik9pPojQBGLctgE0iSVu68gKlwsSqUEZvqwBy
	 R+DNMVdyT3OyWCZQX9nkVqe15fOYjfFX9PiwIhu3tbUwqFoqmjEAzN5TxOIX9EjOL5
	 WQP6ONBI2NMuVu1siTtZGqMAnS2FpBpqCzpPPwqtoad0MWatYvMk+VYlhYrVIcHtr0
	 ZePiyxj0S2FAQ==
Date: Thu, 29 Jun 2023 17:01:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Dave
 Chinner <david@fromorbit.com>, Matt Whitlock <kernel@mattwhitlock.name>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe
 <axboe@kernel.dk>, linux-fsdevel@kvack.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
Message-ID: <20230629170155.175d71aa@kernel.org>
In-Reply-To: <20230629155433.4170837-1-dhowells@redhat.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jun 2023 16:54:29 +0100 David Howells wrote:
> I'm more inclined to adjust the documentation since the behaviour we
> have has been that way since 2005, I think.

+1 FWIW I think that networking always operated under the assumption
that the pages may change. In TLS we require explicit opt-in from users
that the pages they send will not get changed, if it could cause crypto
errors (TLS_TX_ZEROCOPY_RO).

