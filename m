Return-Path: <netdev+bounces-122376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC266960DEA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A554285500
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB96B1C5798;
	Tue, 27 Aug 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl/uRIvJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626A1C4EF1
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769780; cv=none; b=hykfV6evtaaJYzqx0J+uzIo+Cda1SK6PVG1sKqdMD7oPNygmYms/Sf2E93xu5Bx8XfEM4wYemYdGHAzAsFhu2Hugphu+9MLpbslIRC+Dch8BfuQlnFPtx30e7wSxKjNSyKSS3axbld2zjSCar3cvROfvbDqSNkYfQVu67+6jDj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769780; c=relaxed/simple;
	bh=fuAmVw0qTQYOA1I0BIT8+be/LyQlwTWj1skbOpwpMnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaNUgT/7dIQBR8CldvlYNmWfXm94cV9kLdjCbBh9GICjeKTtnTAs8s7LrVJYlwGnl8dYaOEdnG0K1MsgNhscbOzOf2wI9UGrRCCH5SdafQJP/2wwQ9vNno5FiQrgqjOCYb5dSYWe2fKaIfB9mIdD04abJmmenS5PIq5VPiRPRMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl/uRIvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFC3C6104B;
	Tue, 27 Aug 2024 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724769780;
	bh=fuAmVw0qTQYOA1I0BIT8+be/LyQlwTWj1skbOpwpMnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bl/uRIvJOOVQ8cHQ6ebqzEVUPu2dVGy9/ievVHdXXrHkSqPrzaTt31vRZeQBMUl7h
	 H/Y8Y0nLuo1/Slh76qvxoiMbnjs7T4K/n1cgwSXCmSqEHaDwCQ/akBCbmxNH4zVaHP
	 CMVDaOm+wRgykNr+XngjryI5sHXtgpTuuXXApLUNdT7fuyrkGmHnvef7jGK7MM7Ugd
	 TqMVMkjQqJn62pmEkLW6UHr75YoaE778wPieaZ6xd1+MbqYYiPyM0N82hJviM1nAdZ
	 hb5ZuLMAbmkDN6U1wuWvPtuuAiRc4GSJiA5hJM8LwMEiui07jlkshNp3Y9qREzhXGZ
	 eUGBeNKrRiY/Q==
Date: Tue, 27 Aug 2024 15:42:56 +0100
From: Simon Horman <horms@kernel.org>
To: Yu Liao <liaoyu15@huawei.com>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, liwei391@huawei.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH -next] net: txgbe: use pci_dev_id() helper
Message-ID: <20240827144256.GF1368797@kernel.org>
References: <20240826012100.3975175-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826012100.3975175-1-liaoyu15@huawei.com>

On Mon, Aug 26, 2024 at 09:21:00AM +0800, Yu Liao wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a PCI
> device. We don't need to compose it manually. Use pci_dev_id() to
> simplify the code a little bit.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>

Thanks Yu Liao,

I agree that pci_dev_id() was being open coded here.
And that it is nicer to use that helper.

Reviewed-by: Simon Horman <horms@kernel.org>


