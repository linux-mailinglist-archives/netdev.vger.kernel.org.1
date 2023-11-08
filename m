Return-Path: <netdev+bounces-46556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E67E4EFC
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 03:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17DB281513
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 02:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4532E81F;
	Wed,  8 Nov 2023 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSnFHRQ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26284EA3
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 02:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39919C433C7;
	Wed,  8 Nov 2023 02:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699411090;
	bh=xQXSHY99tMn6wHTjcb9UdcPhv4XfJAyPz8gPkmjHz4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pSnFHRQ3gU8YMNY+ZGYNhtMIgaveRgUN5jKE5dKs2U6vmW+vcMW8vtLQtn6HdJzGr
	 lrGpX5eZ+vsPp/kfxUNQtGtETLhx7Mo29i9IjWbb4lfo+31ljaDq5+S1TBmg8SbSGK
	 acqrkpGg0HSaPI8y8cuJQUON+CZDqLM+550KFG7C+xQwatwjNp8VrINbaHkgXXlJwY
	 4fuwGmWdblrZL62bdCXLG2Hxf/4YJqSpk/eWwUZ0xrsxCLkyy/Pa83Ol/QcmLhQ6xl
	 OrGyMFJ21424C1ogYhJSGqOb/Zuvd9VuFub/nYXTW2GZonSy9BiT2UhBk9t+CfUSBN
	 AwtHPT2VjymIQ==
Date: Tue, 7 Nov 2023 18:38:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net] net/smc: avoid data corruption caused by decline
Message-ID: <20231107183809.58859c8f@kernel.org>
In-Reply-To: <1699329376-17596-1-git-send-email-alibuda@linux.alibaba.com>
References: <1699329376-17596-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Nov 2023 11:56:16 +0800 D. Wythe wrote:
> This issue requires an immediate solution, since the protocol updates
> involve a more long-term solution.

Please provide an appropriate Fixes tag.
-- 
pw-bot: cr
pv-bot: fixes

