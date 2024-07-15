Return-Path: <netdev+bounces-111451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F3F93113A
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7356EB21F54
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BAD186E37;
	Mon, 15 Jul 2024 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUoXGt+G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96291199A2
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035865; cv=none; b=oDuKtz7s9syPZF5rca7iecJxNGD4Clsa9otkNapfU4i+xBDlqai3t/tHNVSgQDCCtvw8iPJGDp3Aw5mnzZYNC3bwrOPlIOeBcuFQR5vVS/jjvYKDVR/cVc8JVxytq1BQ7RNBlJPa/dGLKfxf67pIaqc/9vrVfDr4A/WZ/MVxnpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035865; c=relaxed/simple;
	bh=9h2wTSw8EuPWyFr/HCsD/b38FdzEbTfv2HZPgwyV0ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDDiU+tvlHD5BmpyIDLFpPJmvEDcOQz1OMxTBbIGZ44cqLAR41UbaEwRs6n3HtiKxhwl61LWbR6oI2phRxBZa99D5GB29jbsH16XoOQmJWhgP7vNIiAQBXhEjs8Ws3Vcd8Nxo7W8kQsuQU368wCHAeRyvslIX/60gByet3rk6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUoXGt+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EAFC32782;
	Mon, 15 Jul 2024 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721035865;
	bh=9h2wTSw8EuPWyFr/HCsD/b38FdzEbTfv2HZPgwyV0ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUoXGt+GSQhIADRI45zd87yOSIKblZ/b128ijyU5Z+BvxfX3UlatE+xUAEKOFNDja
	 28+ZFxNFbOwg0fZ+q5aaRPhD0BnaF+z6y6dIRI9JtNUUyDHsD2YB5DdJ3NPiKzuFMe
	 /WesgSdQWe8A1Nn1IM3jLByTQI/t5GykL1bpOYkM4BmZgqYrRjeVu7CP0ePyJMS5Pr
	 dGieCB99zPjKJ+u4ZG3SBK1d0vC2S049LFFZxMLI7/Kfk+7zapNdpAMreEOAlMIbem
	 02WypFfTQqtsMv5GO61PIVODmyW4M/6W3h3A1HeNI7yHX5WkuL5ACOWXj9jMPv/eEY
	 j3awrHsAQg+oQ==
Date: Mon, 15 Jul 2024 10:31:00 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next 9/9] bnxt_en: Support dynamic MSIX
Message-ID: <20240715093100.GL8432@kernel.org>
References: <20240713234339.70293-1-michael.chan@broadcom.com>
 <20240713234339.70293-10-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-10-michael.chan@broadcom.com>

On Sat, Jul 13, 2024 at 04:43:39PM -0700, Michael Chan wrote:
> A range of MSIX vectors are allocated at initializtion for the number
> needed for RocE and L2.  During run-time, if the user increases or
> decreases the number of L2 rings, all the MSIX vectors have to be
> freed and a new range has to be allocated.  This is not optimal and
> causes disruptions to RoCE traffic every time there is a change in L2
> MSIX.
> 
> If the system supports dynamic MSIX allocations, use dynamic
> allocation to add new L2 MSIX vectors or free unneeded L2 MSIX
> vectors.  RoCE traffic is not affected using this scheme.
> 
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



