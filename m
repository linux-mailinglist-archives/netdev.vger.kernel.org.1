Return-Path: <netdev+bounces-62919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5A1829D7F
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 16:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E552853BD
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5CB4BA9C;
	Wed, 10 Jan 2024 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEfzknM1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ABC4C3C3
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 15:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308F0C433C7;
	Wed, 10 Jan 2024 15:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704900199;
	bh=YgayTixa3vdMsWAnlNivzX9P4Rs9MIi00TQjTNIMqCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mEfzknM1M1mrvlk8OhatfhSPczkg57IT6hpMa3trcIHMEz2UeQsVSnp1Rk8nRSGab
	 HjPa7d3K37Kl/XRis3fhonnqTDSvS8/lYRgxoViyipul18h5IE6YgoBSLu3mn9jqQR
	 YoV0HcU1PXkXeCxk7z8tZwFKYpH4t/8Z6iL7kP3w0EqiHTNkRLhFwH9i/IeHYnJiQ5
	 qZ9v5sDfzUsKcsCkbRTs8qsQ/llVqSPs/uyzfcuZ6nuU+DexYzwKd9Gj1uCTgyAoZq
	 wB2Zyz1FwPV1akoPyiZAMehYQJetBOpCiiXgSjXwMrIRpZmhHWtf6vSQ4tx6qLs3PM
	 O2sMkbQnWW4yw==
Date: Wed, 10 Jan 2024 15:23:14 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>
Subject: Re: [PATCH net 7/7] MAINTAINERS: ibmvnic: drop Dany from reviewers
Message-ID: <20240110152314.GF9296@kernel.org>
References: <20240109164517.3063131-1-kuba@kernel.org>
 <20240109164517.3063131-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109164517.3063131-8-kuba@kernel.org>

On Tue, Jan 09, 2024 at 08:45:17AM -0800, Jakub Kicinski wrote:
> I missed that Dany uses a different email address
> when tagging patches (drt@linux.ibm.com)
> and asked him if he's still actively working on ibmvnic.
> He doesn't really fall under our removal criteria,
> but he admitted that he already moved on to other projects.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


