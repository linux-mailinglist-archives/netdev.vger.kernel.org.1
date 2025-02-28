Return-Path: <netdev+bounces-170810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70545A4A01B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A1B3A9483
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5906C1F4C8E;
	Fri, 28 Feb 2025 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULf7CA68"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8D3597A
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763130; cv=none; b=nhCz7nSX9wL76Gkhe9JvTpvEj9pL4ILjUlwx22SUP1kIYgPiRfLJLMG97Hc4dGo9iLfV9Kl5efGud1PD5eF3dGlQ1zE1DJqIL++7xak3Zm8ufXP9XJuaJNzl7SK5nDYV9a/Mo1ZCdJPwyIJnPqnDm6XMRvTtOvLikr3rzdaYZ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763130; c=relaxed/simple;
	bh=7HijeybPsV5Qv1AFP1hGBIXylNHVAD2V5/bt1yISKXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBVfyZER8izbvvzpElEX5WlvXNNYQi45lvFG2NfKQf5+iyfMfSd3YxDYw0csR1eTN0eC0KNJ9tTY0tI9fMinC69YMkMrH/hRv09gVrOrFbTSZ1bzTIYnApdJCoXiJvWIQ2DemUWvAkBEspqGiUWvvJIYOeJynF/yj6/L0HhIPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULf7CA68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8104FC4CEE5;
	Fri, 28 Feb 2025 17:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763129;
	bh=7HijeybPsV5Qv1AFP1hGBIXylNHVAD2V5/bt1yISKXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULf7CA682U1hgZ9yE4rLNbJyinxTswKwaYBq/oBr6F0ZOkU6S5zNcrq8XYYZsCBln
	 aVmYmVg901X4cl0rneOcuT7q96fKYQcWrR9Ucn1dqv7KJP5XmfVyT6KJryvQ3xKCFi
	 rJICU3MFHj0kih08LcH3DYRmyIuqWoxm7By0sikqI1yAaHZoa2eMnJRKnwCJYEtfFd
	 hRHztvwtRFNRPi/M120ZjZU6J067PlUtMCHuY8ycQ10va96wVgDG9CLJEjdk8fMSiS
	 kijWQC4kuWsKh3Ssy+rGdGXd2+UOQHZM8vTQQACphToecjH5rXuWyjRRT/ceZNFH6e
	 a2qrA4ZrPjO6Q==
Date: Fri, 28 Feb 2025 17:18:46 +0000
From: Simon Horman <horms@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [iwl-net v2 3/5] ice: validate queue quanta parameters to
 prevent OOB access
Message-ID: <20250228171846.GO1615191@kernel.org>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250225090847.513849-6-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225090847.513849-6-martyna.szapar-mudlaw@linux.intel.com>

On Tue, Feb 25, 2025 at 10:08:47AM +0100, Martyna Szapar-Mudlaw wrote:
> From: Jan Glaza <jan.glaza@intel.com>
> 
> Add queue wraparound prevention in quanta configuration.
> Ensure end_qid does not overflow by validating start_qid and num_queues.
> 
> Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size configuration")
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


