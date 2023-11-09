Return-Path: <netdev+bounces-46728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D72B7E61D9
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 02:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E0F1C20862
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 01:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47F21108;
	Thu,  9 Nov 2023 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJYiVDnV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3BC10FE;
	Thu,  9 Nov 2023 01:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3008C433C8;
	Thu,  9 Nov 2023 01:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699494188;
	bh=iRr+JTJV0XjpZVz4OSwuJCfZf4jBcFbPiRGy+stDaM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tJYiVDnVeLxr4ZuTXuOCEFQDYZPdhUMfcqVXyKBhu7CIYkJyQ/SPn3XEWVUZnvKe0
	 J9dzfbGyCiZfYQjzzDvFQDgp8Wt3IsIgaksTjUsaCu7yBuxkrmqDK+NMBozoRGzj60
	 3DOOIGCSeSOyl4HWs6WBPx+lev7Bhf/gfazH8bH1Nc7ZhLu9EhHsbnkaDu7Vqf5hud
	 2ctGHXnlxsXfuGXKjWLdlE4fDYMcT2HgCf9mUyuKrKdvGtwnq86D7DaUYN2lFJmJpr
	 tYTq6BKLduoSY1whnhNIU3cnTg6qNdxQekclztNY8HVMQldSFpNZIuzMxl9UOjULui
	 FFe7DpoD1/4ug==
Date: Wed, 8 Nov 2023 17:43:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Breno Leitao <leitao@debian.org>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH] Documentation: Document the Netlink spec
Message-ID: <20231108174306.47a64bda@kernel.org>
In-Reply-To: <875y2cxa6n.fsf@meer.lwn.net>
References: <20231103135622.250314-1-leitao@debian.org>
	<875y2cxa6n.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Nov 2023 13:27:28 -0700 Jonathan Corbet wrote:
> I do have to wonder, though, whether a sphinx extension is the right way
> to solve this problem.  You're essentially implementing a filter that
> turns one YAML file into one RST file; might it be better to keep that
> outside of sphinx as a standalone script, invoked by the Makefile?

If we're considering other ways of generating the files - I'd also like
to voice a weak preference towards removing the need for the "stub"
files.

Get all the docs rendered under Documentation/netlink/ with an
auto-generated index.

This way newcomers won't have to remember to add a stub to get the doc
rendered. One fewer thing to worry about during review.

