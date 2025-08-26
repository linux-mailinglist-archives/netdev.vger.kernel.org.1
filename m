Return-Path: <netdev+bounces-217024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E476B371B2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6903A5609
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B04242D9A;
	Tue, 26 Aug 2025 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnD9afI1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369431A577;
	Tue, 26 Aug 2025 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230580; cv=none; b=Si1qENhG9/c5F/2lVrwzzBG9Bk41TnYufiEDtpCL7MrFDkOC8XwWMnTs+4ofPJjycbYq1TAq/QUd/O95A01gPIb15PPpOCheCbJPsAzJn+a2un+ijr3MWGrU+pqw00zUvpP+9EgwUQIlWq5iwFHBjnywqnAcj+AItw/b/8pufgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230580; c=relaxed/simple;
	bh=6TMtBzRFBOVX2bHF383YJhY34ok6iHyjIHKEfFFcpIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvTKlc/8ZWDrpcAUGMipMpDXjReWPsArECGtxv2AOttbWM1JjedWu7PXGZXyRIeSKzgVmcdA4pMF0PIXPRxJZ9rVeHxE0ntAv3cFEYnv36fpgjj6pXE0mEe9zOYmIOUW8XCw/GboS9dbWq9hfL6yrMWfZp/o4Vbg4qmRpLDbP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnD9afI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF08C4CEF1;
	Tue, 26 Aug 2025 17:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756230579;
	bh=6TMtBzRFBOVX2bHF383YJhY34ok6iHyjIHKEfFFcpIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cnD9afI1IWZDgoRRrVAa/8aSd0Rh24QzMGtIGcX1RUIzd+bSp+ssj7+b1we/mECYk
	 TCjT1kAGZIwACflpQlmUaMqBrxgNx+A4yFCA+IMIkILs7RE9cYXTPjnubqzQim8vJj
	 uESnp3zf9k+nxUe275Br+eyoQlIaCbubO5XWBQa1H8ibsfE+Ynz4yrMTzqMMqxcAiJ
	 0l09EQG0XHAjDxHVQCcm8iORlqMy7Fu0T8lT+rvz3l6IO+QWMwhSLZMznFTP92G5EL
	 aeKll2Ev0WzeKN9SP+4SIUyVXbZ2uSdHb1l+oxv+t0g67PWKzf2Ev5RVRP+9uwAEhL
	 8jPG+16eBzi7w==
Date: Tue, 26 Aug 2025 10:49:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
 <shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Meny Yossefi
 <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
 <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh
 <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v01 10/12] hinic3: Add Rss function
Message-ID: <20250826104938.20980ea7@kernel.org>
In-Reply-To: <53206f29-7da8-4145-aef0-7bdacef3bb55@linux.dev>
References: <cover.1756195078.git.zhuyikai1@h-partners.com>
	<13ffd1d836eb7aa6563ad93bf5fa5196afdf0053.1756195078.git.zhuyikai1@h-partners.com>
	<53206f29-7da8-4145-aef0-7bdacef3bb55@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 18:06:42 +0100 Vadim Fedorenko wrote:
> > +	nic_dev->rss_hkey = kzalloc(L2NIC_RSS_KEY_SIZE, GFP_KERNEL);  
> 
> no need to request zero'ed allocation if you are going to overwrite it
> completely on the very next line.

exactly, please use kmemdump().

