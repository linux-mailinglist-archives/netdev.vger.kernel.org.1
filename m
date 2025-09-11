Return-Path: <netdev+bounces-222109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D440CB53249
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B76C1C87BB0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19203218A8;
	Thu, 11 Sep 2025 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVC85HVA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BE1230BE9;
	Thu, 11 Sep 2025 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593916; cv=none; b=Q3iUYVlWrDO00xvfE042OJaVMOrq6BCZ0XzQydcnfbDF/pxHu010KO/k/VBp/Hr8FL/QximNoZmN1kVa+pMBKUEz/M9+1tyoBzaupn7P9skCnSd+LviAbOAO4jBm1p4mJoMuYGrAYOPPS4016K18+gq+5VvjEhudHGmQtBOzOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593916; c=relaxed/simple;
	bh=h/3CGPg27sPIyCL7DkHf00uX54FfRpMvd5NorR/sADE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4D++nNGLKpio01ZPlcdNTfBOQKRBCe2gm54dcV9vpnKPDlo3hkRTATJ4L977wBoxARXVci1x7yI1m07dNxOykIBnB8LhJmGIuHJbXpQLEZTUzzD67iSyl3xErv49nWtcPvxFME5r0DPn2EKppu73PWgwWMNkrCDPF8GJz+0cMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVC85HVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468A0C4CEF0;
	Thu, 11 Sep 2025 12:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757593916;
	bh=h/3CGPg27sPIyCL7DkHf00uX54FfRpMvd5NorR/sADE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVC85HVAt1FqSkENJccnQ02j40rBM8GPAWRCHhXsGC0+VcKZ7Zzi4pJzz4fi+xD+J
	 klmihoFNmiKb/AEvOki+93CLpwzDyedIQWaGjptRcpJNIgDZci2Fo/wt2t1pd8J7+G
	 dlxrAmBE4W9gFJIoUe196VJ1PztezaqbwSF7apRotdLLiQxDc8OGvUVvQyvxyVrI45
	 eWBK2mFbfNL1V1W3CwXMyzUymtzW0hcH6BxDyNRjJsfdslslyOryR/eZw3auLY5Rl1
	 mjWSVE7Hylsl1qu9a5QHWur/1goZv3/80kuW0J/6B7Ihy7dOgrT5HlnSPhrH0084/1
	 EX+F7DhWEtFxg==
Date: Thu, 11 Sep 2025 13:31:49 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Luo Yang <luoyang82@h-partners.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v05 07/14] hinic3: Queue pair endianness
 improvements
Message-ID: <20250911123149.GH30363@horms.kernel.org>
References: <cover.1757401320.git.zhuyikai1@h-partners.com>
 <90167074ae79a7e90a0fea0e38c32bbe8203231e.1757401320.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90167074ae79a7e90a0fea0e38c32bbe8203231e.1757401320.git.zhuyikai1@h-partners.com>

On Tue, Sep 09, 2025 at 03:33:32PM +0800, Fan Gong wrote:
> Explicitly use little-endian & big-endian structs to support big
> endian hosts.
> 
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Excellent, thank you for addressing this.

Reviewed-by: Simon Horman <horms@kernel.org>

...

