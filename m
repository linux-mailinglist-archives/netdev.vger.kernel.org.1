Return-Path: <netdev+bounces-47169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A37F7E86D8
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 01:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E487DB20B70
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 00:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D6015B8;
	Sat, 11 Nov 2023 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDXP8iRF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693315AC
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 00:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA9FC433C8;
	Sat, 11 Nov 2023 00:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699661768;
	bh=8qYJg9nL8VYtEfIOiARfcAin+4JMCchykm3vQ3QeeBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jDXP8iRFCiNoA2XQd5EU9sBDJDmo5Os3p1Be1M3kfGLffypGdifAVpieLqep7DJs+
	 fBt3Q0ZnaNA8FXEGK0/Ziid2JQmGxre+jGzFBKVey+0RBlzQPqC1Tnf/vPbuOMDuBV
	 DNfD2Qggzrdp5i014odHKmcOrSm9/Vm2unTkbN5dYqX9eCFw8Mb54itylJ7R1TZqZf
	 YfTpmyflDANnl9QCIMBQKDxeqPeW4EJOlByC/8WFAL5qxmFQsU+X04nuvtP1Yf02z7
	 4WPWPhvD9ssDQGRjAY5SbAXitZi1zxf1WrXdCoY9bvBR8hRc0eNxBg9XnlmxNTdHrF
	 4SeIq2IdF0RCg==
Date: Fri, 10 Nov 2023 16:16:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <netdev@vger.kernel.org>, <brett.creeley@amd.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <drivers@pensando.io>, <joao.m.martins@oracle.com>
Subject: Re: [PATCH net 1/2] pds_core: use correct index to mask irq
Message-ID: <20231110161606.16f5af39@kernel.org>
In-Reply-To: <20231110200759.56770-2-shannon.nelson@amd.com>
References: <20231110200759.56770-1-shannon.nelson@amd.com>
	<20231110200759.56770-2-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 12:07:58 -0800 Shannon Nelson wrote:
> Use the qcq's interrupt index, not the irq number, to mask
> the interrupt.

Patch 2 is whatever, but this one really should say what practical
impact the change has (i.e. is it causing any user visible issues).
Has impact == should include a Fixes tag; no impact == net-next.
-- 
pw-bot: cr

