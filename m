Return-Path: <netdev+bounces-105275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C391053D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AD8287888
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1DD1AE09E;
	Thu, 20 Jun 2024 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgefNqAc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7E51ACE86;
	Thu, 20 Jun 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888225; cv=none; b=YN+EZadCFTZVGiN0OuDkoo1tFEDOcux3Kl8HlSjKynxF5IyluorVMNkwg29ooJ+e90v5knAoDiytJBhU5QHAlqFLvCoUVldebcyGyHbGVSoSE3wtoz6cqP01Q5gLNdXhS8mm9wJKEA8x1UQR6EFAMoZnBSVL6I9QCu/uhF4SSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888225; c=relaxed/simple;
	bh=2b+09QKULaE9qJaQtCGA0vkddmGq6A8cGpUKyYREGbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhhPvMpC0M1oFcTES0eJ7M0Lsx26tyIOYhNn1R81LXhqfUlSI4gcqJrSlw3pS+XOmkZgOg3Z0QCa0e0WwR6oFy9uB807Bt28+s3OltV/S9AEGTBa5/a0BXqWWP0p5lTKeWif9LfN7+3GRNbH73iVxjwDq/dqj+r7xKZZfs7/5Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgefNqAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF9BC32786;
	Thu, 20 Jun 2024 12:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718888224;
	bh=2b+09QKULaE9qJaQtCGA0vkddmGq6A8cGpUKyYREGbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgefNqAcYvWcio8irIeO6fMvucWvbesbnifOF1pjvYFEoho7bOcI5sosD38f5gthf
	 wgh1f+wKgeU25Qj0hZ9Expt7s48xw647mpVuDlafarFWiE8n8PFKnI5tXlIPXXogQy
	 sxrp/JLLmMQQ5JC8LBCyOxlQkBbwAL4oLevHyOs7Cru4MbUG/kvd+OveGCyq82Qa25
	 FcD50Z3q8FoYiuSeV+H2x+Qgiz234CW6p7nPc5wJetHc+4C+O1B+a/XONVaderc9a+
	 fMr5Mbf46YZKvrkH4WtDQGh5bpjncbaeTRj3rLuoI8m0Gnx5Z3bs3pm+gmmTnFeIj/
	 HtWuskGK30NKg==
Date: Thu, 20 Jun 2024 13:57:00 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v5 10/10] octeontx2-pf: Add devlink port support
Message-ID: <20240620125700.GJ959333@kernel.org>
References: <20240611162213.22213-1-gakula@marvell.com>
 <20240611162213.22213-11-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611162213.22213-11-gakula@marvell.com>

On Tue, Jun 11, 2024 at 09:52:13PM +0530, Geetha sowjanya wrote:
> Register devlink port for the rvu representors.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


