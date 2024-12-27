Return-Path: <netdev+bounces-154365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 896689FD6EC
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 19:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFA43A204F
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 18:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D301F7086;
	Fri, 27 Dec 2024 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8cXIzIw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6EA45005;
	Fri, 27 Dec 2024 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735324296; cv=none; b=KJ+tB73XJj6k8tN03XZBSz1zmF0Ofs1p327+PD02jj8+MXeQSwvZ/5pGuxF44EPM7OA4L6kmz9YEm20StUhUsvd+9WR2m0f59+2a8ikwcav23SKCVmXSUtPAFg6UpowXkaW/9PnozN5E+bLH3NQ/ZlAjMZhzB6C5w+YPuD1b3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735324296; c=relaxed/simple;
	bh=utigrWpY3Dvby5cQbgGg+unB6OhBi5DsrEDYQJ+Hocc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pfwy5icmt3c664cqX9kwlddbyv4pj6miCXwO1L3/3iHna4iXnl4T07ik3c5vqvC/BYaCoWeXG1h5bLz0o5PIeUGQUxAOT/EvFiQvyWvxSyfm2eP02h2n7E9mXRdvAXV7BPwOkIdmGBILNCi2hEuOmRl1Ntp7bFOCQDWwn+wa4+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8cXIzIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D786EC4CED0;
	Fri, 27 Dec 2024 18:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735324295;
	bh=utigrWpY3Dvby5cQbgGg+unB6OhBi5DsrEDYQJ+Hocc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R8cXIzIw2NLYknuXZ2nWH1duHIe8BRAabKI1O3qK5OI3S9J2HrA8U5nKLn7caVC9v
	 wNSb22FUanVuRa9rLwA6yJ9UsC3PKW4tPX64ZDxnZkeF/w6QkcvL86QGRSAoFiTy1O
	 DNVoUwIO67s5UNXxMPJXeGXbRwrW/ZaKpl4uYlWVul/M76qGOMd3rwr8kIfdhSFmDG
	 Z3N/wy1fskE4yETYR3m6BItozyPWjKTdMxyoU3ShkzEs/g3DR7rCiG4cjqnVhHyPgb
	 CYknHXtMoTuaKeXWRxIzRqhUvq6/Ovi7F/BQ3Itbq5YG7SXGeSjFj8W97X1gf8pZZm
	 ASlO8kKthwkow==
Date: Fri, 27 Dec 2024 10:31:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
 <davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
 <guoxin09@huawei.com>, <helgaas@kernel.org>, <horms@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <meny.yossefi@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <shenchenyang1@hisilicon.com>, <shijing34@huawei.com>,
 <wulike1@huawei.com>, <zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v01 1/1] hinic3: module initialization and
 tx/rx logic
Message-ID: <20241227103134.21168df3@kernel.org>
In-Reply-To: <20241225125649.2595970-1-gur.stavi@huawei.com>
References: <20241223073955.52da7539@kernel.org>
	<20241225125649.2595970-1-gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Dec 2024 14:56:49 +0200 Gur Stavi wrote:
> > I understand. But I'm concerned about the self-assured tone of the
> > "it's not supported" message, that's very corporate verbiage. Annotating
> > endian is standard practice of writing upstream drivers. It makes me
> > doubt if you have any developers with upstream experience on your team
> > if you don't know that. That and the fact that Huawei usually tops
> > the list of net-negative review contributors in netdev.  
> 
> The most popular combination in the last 3 decades was little endian
> CPUs with big endian device interfaces. Endianity conversion was a
> necessity and therefore endian annotation became standard practice.
> But it was never symmetric, conversion to/from BE was more common than
> conversion to/from LE.
> 
> As the pendulum moved from horizontal market to vertical market and major
> companies started to develop both hw and sw, the hw engineers transformed
> proprietary parts of the interface to little endian to save extra work in
> the sw. AWS did it. Azure did it. Huawei did it. These vertical companies
> do not care about endianity of CPUs they do not use.
> This is not "corporate verbiage" this is a real market shift.

Don't misquote me. You did it in your previous reply, now you're doing
it again.

If you don't understand what I'm saying you can ask for clarifications.

> The necessity for endian conversion is gone (or just halved). Will the
> standard practice remain? There is not a single __le annotation in Amazon
> and Microsoft code. Not in Mellanox code either. Maybe their hw is fully
> BE (have to wonder about their DPUs). Amazingly, Intel that only creates
> little endian CPUs has lots of __le annotations. But they are the flag
> barer of horizontal market.
> 
> Interesting how both Amazon and Microsoft started with:
> depends on X86
> Thus evaded demand for adding __le annotations to the code.
> Later, both sneaked in quiet small patches with replacement to:
> depends on !CPU_BIG_ENDIAN
> Maybe that is the true meaning of "upstream experience".

