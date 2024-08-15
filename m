Return-Path: <netdev+bounces-118910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB109537C8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F0E283E9C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E279C1B375F;
	Thu, 15 Aug 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFZAJIlg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3E51B1512
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737578; cv=none; b=fHK9sjV/wHOkqd1YhZbOVe3a2qLSYhEqPU9Mk7bN1q91Up5xaUFS2cjN0W34VyIheyBHzy8WIPEqfeoNtSX7lt0l/pUzPR4k44IuW5luaaL96QXP5naCUhytAeQDxmMiXJf2IIV5HoRDxcP+R/P8WIzuDK3JXvrOjY56W4NljKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737578; c=relaxed/simple;
	bh=Au56kqPSO4SYC4Hsokls9bS1sMRkkgcNVz+GLBgLM4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tct4h462/5E2Wkg4AqlnUeomiUJrR/pQWZBN/Dqz3E1Vt6l0J8bmVMnx0qpG+rENgsXX+1xSEaAw01IxkUvibxpoK06QCBXp9ii+EO1T0C18/7+H8nK5WI8F9/c5HV3MpB9/lq+rHhBJk1TK0abtOmx5LDZ2k2HqXldLhPZhO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFZAJIlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E26C32786;
	Thu, 15 Aug 2024 15:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723737578;
	bh=Au56kqPSO4SYC4Hsokls9bS1sMRkkgcNVz+GLBgLM4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MFZAJIlgY53bqIiO4aamdcLayZt8u012GOBod8cwQW0HGTDokopjODILziWW0oQ5i
	 tADDsJecyudNPLS6PnGZONHp8c2CFlWk9VbeEwrH4XIHAYPArbc9mEyTvg5JUsiomX
	 bcChH5MUDQiDlibiEn9OnuYm0b6c/KTbhoatuIL6yFSGVlDs5Kur9pY/wbM7v0lHKd
	 czhVASVi2NgbSdHRS2gawIppnavyFw3I6yMX0mnPOsLDDmgf9RKvOkSutonLacYUuX
	 09vcywHRVyFthNzEIjD7eBl5/+Hv5u3XVEPb8YG5qS/PF/5jQ1GHVx9ZzkbiqhPYA2
	 ejH99izbd6XyQ==
Date: Thu, 15 Aug 2024 08:59:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dimitris Michailidis <d.michailidis@fungible.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org
Subject: Re: [bug report] net/funeth: probing and netdev ops
Message-ID: <20240815085937.1658fcb2@kernel.org>
In-Reply-To: <f9fa829d-2580-4b49-b0c6-cf2e2a8f6cac@stanley.mountain>
References: <f9fa829d-2580-4b49-b0c6-cf2e2a8f6cac@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 14:29:38 +0300 Dan Carpenter wrote:
> Hello Dimitris Michailidis,
> 
> Commit ee6373ddf3a9 ("net/funeth: probing and netdev ops") from Feb
> 24, 2022 (linux-next), leads to the following Smatch static checker
> warning:
> 
> 	drivers/net/ethernet/fungible/funeth/funeth_main.c:475 fun_free_rings()
> 	warn: 'rxqs' was already freed. (line 472)

Somewhat related, Dimitris is Fungible still active?
Advanced NIC startup are very close to my heart but I wonder if anyone
is actually using these in the wild, given the "exit".

