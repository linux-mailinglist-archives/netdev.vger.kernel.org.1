Return-Path: <netdev+bounces-53588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3276803D20
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD301F2120C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128832E65B;
	Mon,  4 Dec 2023 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkeZQafm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301D2FC35;
	Mon,  4 Dec 2023 18:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114EDC433C8;
	Mon,  4 Dec 2023 18:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701714824;
	bh=r9JqdhrB+idyYIN8+nslhqPgmrCgJOrXcQLqFZ+NAVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LkeZQafml5Fpzojm7UG28qdjQGPJnlycvqvJVzJPcQjMAxO0cQ9M77Ik7abB2Qg6g
	 K6d07G76/5Z08YwwYdNeENwaj7u5tZUQSOUV2zLFOP6hAXPwkcusmwCZpe+RvNb6RK
	 qkdv8tcD2dKLQz932BMv1c8OeoIQW7+/aibebUJUPyb3EGMjKsswJY68tagWXr2Qps
	 foqRHOOVJXbN1r4MqwQ38KWu5se8JswVeTqhlkcTMeLb4mhritT+j/SWIP4N0Yys95
	 Xu680jroi9JLKQ5Z+l9Ro/xWKiP9AyFkVAXyqEqAw8ZWdCQMHbkSJAmiJtv3Km8CBK
	 l7eITBNoEo2Kg==
Date: Mon, 4 Dec 2023 10:33:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 0/6] tools/net/ynl: Add 'sub-message'
 support to ynl
Message-ID: <20231204103343.5e9b31e2@kernel.org>
In-Reply-To: <m2leaa6k0q.fsf@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231201181505.002edc7f@kernel.org>
	<m2leaa6k0q.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 Dec 2023 15:54:13 +0000 Donald Hunter wrote:
> > Should we add sub-messages to tools/net/ynl/ynl-gen-rst.py ?
> > Does the output look sane with the new attributes?  
> 
> Ah, yes we should. Okay if I look at this as a followup patch?

Improving looks is 100% fine as a follow up.
But do check we don't break rendering completely for stuff we should
already support when sub-messages appear.

