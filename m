Return-Path: <netdev+bounces-27407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0355777BD74
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F1C1C20A66
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CD5C2F9;
	Mon, 14 Aug 2023 15:53:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF43C2C1
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1742C433C8;
	Mon, 14 Aug 2023 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692028400;
	bh=VYn89773/Fan3jTs9Lj+W9soq0OKz68en037iNXyJcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G8+fGV9msZ6gV+netW5s77h+LqsYFQEk2OgkyIUTXENvsBz+e8KWcYAu81iLHbyb1
	 X0T7bIRS51XBtfLwJJqOiO9yuHC7jubMafxk+Z7K7Xc5EXRhM4W0hLBJK0cp5/dmBg
	 teaibNl1QNdC0Yi+Zbwov9A7CdgcBHgpGkCn5zrGadp0RohumKn9qUG1OWSyA4lS84
	 gaJHRsS4r7W3Donl8USTDrsaEvTtecp/ZykFR/cgY114B36+7b+ps+7VJTTEZnV2Lh
	 DZhyCgmxFyklVfKxRdPUaSjaV9N/ZFQCtyZO15vecZkOuNjrTl6nOhzZE1Dk89kXxu
	 /rPWuQBb0XuFA==
Date: Mon, 14 Aug 2023 08:53:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Lin Ma" <linma@zju.edu.cn>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, rdunlap@infradead.org, void@manifault.com,
 jani.nikula@intel.com, horms@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] docs: net: add netlink attrs best practices
Message-ID: <20230814085318.090c832d@kernel.org>
In-Reply-To: <54e9d6f6.106b1a.189e798f8ae.Coremail.linma@zju.edu.cn>
References: <20230811031549.2011622-1-linma@zju.edu.cn>
	<20230811152634.271608c5@kernel.org>
	<54e9d6f6.106b1a.189e798f8ae.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Aug 2023 10:35:09 +0800 (GMT+08:00) Lin Ma wrote:
> Moving forward, I suggest we consider the following options:
> 
> 1. Update the document to address the confusion and make it more relevant
>    to the current state of Netlink development. Maybe the newly added
>    section seems not enough for that. I would greatly appreciate any
>    specific guidance.

Unless we have docs for kernel side of modern genetlink any sort of
indication that this doc is only a guide for looking at old code will
fall on deaf ears.

So you'd need to write a sample family and docs for modern stuff.

> 2. If the document is deemed too outdated for being kernel documentation,
>    maybe I should publish it somewhere else. Do you have any
>    recommendations on where it could be better suited?

GitHub comes to mind for publishing ReST docs, in the meantime?

