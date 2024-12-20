Return-Path: <netdev+bounces-153567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 472F59F8A91
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD751882EA9
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD1B2AD2A;
	Fri, 20 Dec 2024 03:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2llIR5q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84105800;
	Fri, 20 Dec 2024 03:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734665192; cv=none; b=IGWDFoLUONRJvet0K8iH37ftqsLpfDBXFKSv76REk//tZzpm1mlPeMN4YrC95DBQDzbklYykmCilio3HqnF9qLe/lZolUqZ9P1m16BASpWkTnMvdfhhMKtJaRQ8C+fMS5An5t9/QUcc5uu58CvqEkSmfW1KI/BBQZkbhXwTPuw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734665192; c=relaxed/simple;
	bh=poHXdx2pVMv0xfr2di/Ho1i9OQ0pVCRclqHkoaApryk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mahwvb97c27HKy/foNjZgidELAi+i1L71Kc50keglzcHOkAd02i6I9QBidrvd+nSKAOurqGlmxZhH5YVgLZ2LRDviOyTZ52cLIsM3/XApRv9zG+bi4SfecAx4vBRabGFB+BZugly8iQr1rDQZ/T6Ow4ogDLZxu8ZXS1bLH44RNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2llIR5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88491C4CECE;
	Fri, 20 Dec 2024 03:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734665192;
	bh=poHXdx2pVMv0xfr2di/Ho1i9OQ0pVCRclqHkoaApryk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O2llIR5q06LU1M15Xtyi2bxYOtPs+/z//z+cqHHVb/pUlrgPxtQymaGSHwMlye1+b
	 FLaN4WQgGQSt2InhGxrK9dyjd9wlAEX/zldBTDwyw9/vWWu2s34MYQXx61xYNgRZbQ
	 PNS/LNk7LyiBtagyFwmS67ytSBWP4+iVNw4PGFgHjMbv8D5UDrGeBJXIGiCu0RAfnd
	 CbtLK7cX12rVmUMyvuiPpaesPr8tzCo8k8QEMMk0NtaOTyGfn8TzsHmXFrEqTAxymA
	 5n93XptmC0/dlgypdjF+pcxVTd/zEnVkOUNs3IvsS2WBJJhKFMPIZMWdQglRFmvryl
	 qQknyAvpBqByQ==
Date: Thu, 19 Dec 2024 19:26:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <lcherian@marvell.com>,
 <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
 <andrew+netdev@lunn.ch>, <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v6 5/6] octeontx2-af: CN20K mbox implementation
 for AF's VF
Message-ID: <20241219192630.684eae48@kernel.org>
In-Reply-To: <20241218145938.3301279-6-saikrishnag@marvell.com>
References: <20241218145938.3301279-1-saikrishnag@marvell.com>
	<20241218145938.3301279-6-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 20:29:37 +0530 Sai Krishna wrote:
> This patch implements the CN20k MBOX communication between AF and
> AF's VFs. This implementation uses separate trigger interrupts
> for request, response messages against using trigger message data in CN10K.

clang says:

drivers/net/ethernet/marvell/octeontx2/af/rvu.c:2993:47: warning: arithmetic between different enumeration types ('enum rvu_af_int_vec_e' and 'enum rvu_pf_int_vec_e') [-Wenum-enum-conversion]
 2993 |         return (pfvf->msix.max >= RVU_AF_INT_VEC_CNT + RVU_PF_INT_VEC_CNT) &&
      |                                   ~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~
-- 
pw-bot: cr

