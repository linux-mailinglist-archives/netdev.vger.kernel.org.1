Return-Path: <netdev+bounces-129839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4BA986745
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E0E1F2428C
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C37146A79;
	Wed, 25 Sep 2024 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixP4c6hU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21285146596;
	Wed, 25 Sep 2024 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294403; cv=none; b=XH/LaOJtrN6aDeTSC3ipugtp9kKQ+BvdlHO5lIhMKRuHQtOuuTcOcjvhsYS2QQoFONytqgCMvFQvmf0DLZsjXfFR7vVjsGQUCUr29+km8Z22b9Me1wDIE9sXQBA6sF+x99Qla2QOeoQYmliIaWpPZShJ816szwASnThQO050I1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294403; c=relaxed/simple;
	bh=aDuFfv+lsRoCCBwC9iGeBVszOjMXqflF/WbrOXRnA1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G35PAfali2rJhqiPJTUG5GuknaR3v6Y50w80KbhKxsoeoccXY5cjEsCBhtGRTVhvolUzoeHHtutFYdSMMgiHcqXQbfoFBkk6VKRd/hgHjy1+RnGpvvukqcv02im0plYW83psUvCHlQEs+BSm86ujbx4CJncKKu3CheTIyWAY2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixP4c6hU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30297C4CEC3;
	Wed, 25 Sep 2024 20:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727294402;
	bh=aDuFfv+lsRoCCBwC9iGeBVszOjMXqflF/WbrOXRnA1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixP4c6hUJVMucy4/aZ8ut1f1nsYTgGwHGVjI4fWJ/KxdrJrpTEJjS02G1HIASI2wo
	 hfO94vruhFY7NqgVNvH+MKGAUhWI+oIpe7ZW4tnFDcuqvLGZWdFyEsS88Jg8iVMmnJ
	 IZw1RHTJdMGy87zkal26gnzLNkUlAXiEN+ws1cxTWvvExDV5zSTmZYio/eaHxQCVM7
	 n+B5oZxNYltk1v32daaZNsTp8z6xr75utbGxZYvx+GoVs+5mJavNhCUo71QCSOkRFQ
	 eoxoPtB6HbpDtOaQzQMAFl/jgX4sLb3vsoqXJqaMRutcYJ5c8SYFDM85/+k/ckWcoz
	 xQQODTUdn3Q9g==
Date: Wed, 25 Sep 2024 20:59:59 +0100
From: Simon Horman <horms@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	hawk@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/net:Fix the wrong format specifier
Message-ID: <20240925195959.GZ4029621@kernel.org>
References: <20240925085524.3525-1-zhujun2@cmss.chinamobile.com>
 <20240925195354.GY4029621@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925195354.GY4029621@kernel.org>

On Wed, Sep 25, 2024 at 08:53:54PM +0100, Simon Horman wrote:
> On Wed, Sep 25, 2024 at 01:55:24AM -0700, Zhu Jun wrote:
> > The format specifier of "unsigned int" in printf() should be "%u", not
> > "%d".
> > 
> > Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> 
> Hi Zhu Jun,
> 
> Thanks for your patch.
> 
> While this change looks good to me it looks like it is for net-next.
> Currently net-next is closed for the v6.12 merge window. So please
> repost this patch once it reopens, after v6.12-rc1 has been released.
> I expect that to happen early next week.
> 
> Also, please explicitly target net-next patches for that tree like this:
> 
>   Subject: [PATCH net-next]
> 
> For reference, netdev processes are documented here:
> https://docs.kernel.org/process/maintainer-netdev.html

Sorry, one more thing, looking at git history I think the prefix
for the patch should be 'tools: ynl: '. So perhaps:

   Subject: [PATCH net-next] tools: ynl: correct page-pool stat format specifier

