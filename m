Return-Path: <netdev+bounces-57189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A3C812529
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1555C282262
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF677F9;
	Thu, 14 Dec 2023 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0Nt4gWA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D99642
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A1BC433C7;
	Thu, 14 Dec 2023 02:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702520472;
	bh=E+nTFsxPhhLeQMpDCEQGk2uiEZkW2LcAQEEFfBZAtG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i0Nt4gWAGZ0loOUiz3/ecoZACsJrcTxv3P0A3aLSPYDX7Ha7JW854C/nDDgJZPkeV
	 uTGo7DeG00edeKD/n1LvuiKCLOUPA3HyqmdBrEA4pQKNkKTYV/wEnCr9Clma/6NeWU
	 utlfaVdB13m/Y6BWnjzPSpn5kYuIR6jq5Jo4QgHvI7HVOlgPCigMp1bDKyZA0IOeQy
	 g2VHWgHzdb9sqE2OcPoHsRLOYoHTxsMJrZ9wjtAaaDfLjxhoB8lk4SmenGr/SX3y6o
	 5GP05crTcpWYall8bnQkNS3X9Ug72EC1vFXdJ/wtTs+idHPD96FM3DGNaYp1wmCKmK
	 2lsEnDOTk1RwQ==
Date: Wed, 13 Dec 2023 18:21:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: duanqiangwen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, davem@davemloft.net, pabeni@redhat.com,
 yang.lee@linux.alibaba.com, shaozhengchao@huawei.com, horms@kernel.org
Subject: Re: [PATCH net v3] net: libwx: fix memory leak on free page
Message-ID: <20231213182110.38052c7b@kernel.org>
In-Reply-To: <20231212032902.23180-1-duanqiangwen@net-swift.com>
References: <20231212032902.23180-1-duanqiangwen@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 11:29:02 +0800 duanqiangwen wrote:
> -		__page_frag_cache_drain(rx_buffer->page,
> -					rx_buffer->pagecnt_bias);
> +
>  

sorry for the late nit pick, there's a double new line here
checkpatch seems to miss this :S

>  		i++;

