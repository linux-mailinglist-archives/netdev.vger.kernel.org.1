Return-Path: <netdev+bounces-222107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B18B53241
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0EFB7B3CAA
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCB82E8B9D;
	Thu, 11 Sep 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdOhMc8s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9FE3218D2;
	Thu, 11 Sep 2025 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593816; cv=none; b=kaH2sCL7huCoTtb5DYdry5bu8YMrWeAi7V5Wbhyze/uXRRSFbjodHK85yuQUoSP+HXnrh1hBjJdcZvpxrZ1vc9Sklz+PlYclMoCN3qdMzRJ+CR+rTNeELn0r4qRilb8l+3xhNgCvCLScmbOkkhpX2MZ8wfuR10RY694R8sZNiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593816; c=relaxed/simple;
	bh=gZ1dZ/ElhQhLoCMCCotria6+48Ot75ZaRc+i3BwpA5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYfaIISIJ3EdK+UpuLmQJ6urY6rqekr1n65MQ9aVoQrrlPwYAoRL9UklFjnb70TkBZRWzki8xkg0Fd23uTWmZFGgLUBOzga6Jj+g5Fo1oPawLvF9jTb4lr8bC8BxGIe1iRSyD6bJcFjOJhAhy9PdZ3odmHsKYl2h9JUslY33hV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdOhMc8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969A5C4CEF0;
	Thu, 11 Sep 2025 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757593815;
	bh=gZ1dZ/ElhQhLoCMCCotria6+48Ot75ZaRc+i3BwpA5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JdOhMc8stCim9HV3ZLDrTlgni74zo23htGVDKm4/Fy1BopuclwCWvaPgeTeP6E5iW
	 97ReJt5nw8C662GsFS8BQ6EmQ7NYBfghxkejoozfA+fHz5TTtOv9kd8GXHu56PNwBF
	 hf7mwbobaqOrAclEY6DvyJSL3Hv5UKhDQATbFtfS3hOPg2IYBGPLy+0EqYxnlq4aQW
	 84SCDwAFPYu7LnWnxTj+iyJ1jOQV3omXtQVK6OeN+/Iv90sF7dYUAxreTr0KLnG4aZ
	 OJ5benKi4btjtOvvcjo/dpQV7ykocacn3gEM8hu1C3uScA8hPQJDMg4eKAmw+R4T6H
	 t1cce+LKipgUg==
Date: Thu, 11 Sep 2025 13:30:08 +0100
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
Subject: Re: [PATCH net-next v05 09/14] hinic3: Queue pair context
 initialization
Message-ID: <20250911123008.GF30363@horms.kernel.org>
References: <cover.1757401320.git.zhuyikai1@h-partners.com>
 <8323dc5ce83f9d442c00824dd7dd24e55ddfb666.1757401320.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8323dc5ce83f9d442c00824dd7dd24e55ddfb666.1757401320.git.zhuyikai1@h-partners.com>

On Tue, Sep 09, 2025 at 03:33:34PM +0800, Fan Gong wrote:
> Initialize queue pair context of hardware interaction.
> 
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

The nit below notwithstanding, this looks good to me.

...

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c

...

> +static int clean_qp_offload_ctxt(struct hinic3_nic_dev *nic_dev)
> +{
> +	/* clean LRO/TSO context space */
> +	return (clean_queue_offload_ctxt(nic_dev, HINIC3_QP_CTXT_TYPE_SQ) ||
> +		clean_queue_offload_ctxt(nic_dev, HINIC3_QP_CTXT_TYPE_RQ));


nit: unnecessary outer parentheses

> +}

...

