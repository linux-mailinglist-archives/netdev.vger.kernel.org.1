Return-Path: <netdev+bounces-105171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ACB90FF48
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E034D1C23723
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1990C1A8C3F;
	Thu, 20 Jun 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="t4RkBj6R"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F79157A7C;
	Thu, 20 Jun 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873122; cv=none; b=uXGtd60wLMJJBvIl5hNp7OszrhK52YFIgTfVH4p+pVQMSm+KPt/N7z4iRoVw4X0okREKmWnBOHAPF15S8Wb/HrzTPue7xjK6U++60D1CFqJbEd0K7siw0NeleF9FUjZuTiqGcVYg2sCabV1sbrYXgGobzL6Y4+U7wsSQcty2WxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873122; c=relaxed/simple;
	bh=PxBnoJGW4Rs6vDxQykJcoC7D5CHDpHoYUPQTU1o3cyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mz8SgVIrSRXh0D5q3+sEx1545WpDBzuE7heinZ001wEdFQNLaI9XZWfthG+AtHTuh4bMomtsBlSHb9hUbxMqBfSsLHLELngW47Aikh2KJ2eSX2lHT8UF2j4YNhrEw3OhBShmxTVNW8tzoBLfL5QBthvQwOpw6dqNApdCjgIHmUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=t4RkBj6R; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=zCGKty/L5MGdwQS5K/QcY24vFCLiM8wHxaRMk4azd9w=; t=1718873120;
	x=1719305120; b=t4RkBj6Rkb78LSbnz+MfrKHG52WQUSIkGn7WgBiPgyLEHkNdZ/LdUDB++2NKF
	tQ/Z5OS9RtxewlBLqeS9u448vKbas0ms8G3ldeDmG7ytkKzxj7/+HOAUKNx7KxaDvKYf9eSJEFK1d
	rTTwex6h4rO4FmcQ1p1JEWB0w3/nNLdLbUUtEjFsPyMLgzOoOTFQvsjrZPEGZ52E13RTzVWYpEGo4
	cofhtiJrUoAV8ahkgZXu8VmD9H0+cGUoIPuy0UpSezT2/QM8WeUFQ9SXDA/Mo/8og1Pgh7illwymg
	ZTs+/5JGVHw5qBBOL8WzK7+lAHqiDRBEz/j8cQnPYhGshtvvbw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sKDPj-0003QU-2M; Thu, 20 Jun 2024 10:45:03 +0200
Message-ID: <02493a25-30c4-4e32-835c-6fdfe0f2abbb@leemhuis.info>
Date: Thu, 20 Jun 2024 10:45:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation: best practices for using Link trailers
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ksummit@lists.linux.dev
References: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
 <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1718873120;606b96ce;
X-HE-SMSGID: 1sKDPj-0003QU-2M

On 18.06.24 18:42, Konstantin Ryabitsev wrote:
> Based on multiple conversations, most recently on the ksummit mailing
> list [1], add some best practices for using the Link trailer, such as:
> 
> - how to use markdown-like bracketed numbers in the commit message to
> indicate the corresponding link
> - when to use lore.kernel.org vs patch.msgid.link domains

[...]

> +   When using the ``Link:`` trailer to indicate the provenance of the
> +   patch, you should use the dedicated ``patch.msgid.link`` domain. This
> +   makes it possible for automated tooling to establish which link leads
> +   to the original patch submission. For example::
> +
> +     Link: https://patch.msgid.link/patch-source-msgid@here

I wonder how long it will take until someone starts using
patch.msgid.link/ for things that are not the submission of the change,
for example by misunderstanding what "provenance of the patch" is meant
to mean here.

How about something this:

"""
In case you want to record the public review submission of a patch while
committing it, use a ``Link:`` trailer with the dedicated
``patch.msgid.link`` domain::

   Link: https://patch.msgid.link/patch-source-msgid@here

This makes it possible to reliably look the submission up, hence don't
use that domain for any other patches you might want to link to.
"""

But I suspect some people will never see this and start assuming that
this domain should be meant for all patches -- and not all of these
cases will be found during review (or by checkpatch, in case we add a
check and people actually run it). Writing that made me think a
dedicated tag like "Lore-Submission" or "Public-Review-Link" could avoid
this while keeping some of the aspects that Linus likes about "Link" --
but I doubt that will convince him.

Ciao, Thorsten

