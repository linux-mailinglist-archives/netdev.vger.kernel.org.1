Return-Path: <netdev+bounces-180560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17088A81AC1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87A247A4553
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B534614A4CC;
	Wed,  9 Apr 2025 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrV7wyCM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020270809
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744163887; cv=none; b=IZXl5XW8VExoRlYZiv9B+VestFDDUa9AbDMn7ccp5GWObg+qcFSee+Pa8HEs3XI/VLFiNpMkWBhxkvcgtFN8BvowLcgj5HwtQXTPiMAOT7uuk+AbYlI4eFoeXqT7eS51WVROuMLOF3rngARFGkNlnw+g/uY8w49iNnSVcgP+iKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744163887; c=relaxed/simple;
	bh=pIVvXkTr2x/0mrRnQyLSePTj5TkVGBJtQGUcLzFvvAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENbavip1Bbs9xexNi1tAo7Cmlam/SIxpu3tHNHk7Zt5uO+s7XIr+WgJrS85d53uUpzSvKTVg00lh0qF3Eg9X5aiSBQaBT6kZhvGXrPozHsijPhKC4hrI2HUqFiQAADocuojgMRwuDJ7wqSaolnNH1dGC9x0Q4Xv/HPiLtuvOs68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrV7wyCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DEDC4CEE5;
	Wed,  9 Apr 2025 01:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744163887;
	bh=pIVvXkTr2x/0mrRnQyLSePTj5TkVGBJtQGUcLzFvvAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HrV7wyCMh2JhiBqai580Z/brOkzz6ZA/1Wj2Vj4JYTx9ClZz8f0AilwXPQo5lnfbV
	 t9gjuAS6ffGrnu5cd/yekciLPMoAen3nZ6XAAo5zzeM2EX2KH0JrM1zRmdB7hpezZ7
	 4Llq3jMN1tDzXuF3DNi2FTqDbgVtmiWUpqE/SK6gAOsbQ3T0WqvC/wUJ+PX2RGraPp
	 uJ/eDXCNJK0AKtyBgHHYOMoVJ52cLiVlg1voaKkTfzLJfsmWCakpHdU17BbN00+cm8
	 v470S+OVFWQjF6CdTFfARpaaaVWsn5goAOzK1AG7+gbh+OmpHI1JWYmDram+jrEXZw
	 OWw/LsjvUZGkQ==
Date: Tue, 8 Apr 2025 18:58:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com
Subject: Re: [PATCH net] net: txgbe: Update module description
Message-ID: <20250408185805.2fae770e@kernel.org>
In-Reply-To: <20250408081958.289773-1-jiawenwu@trustnetic.com>
References: <20250408081958.289773-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Apr 2025 16:19:58 +0800 Jiawen Wu wrote:
> Because of the addition of support for 40G/25G devices, update the module
> description.

Not important enough for a fix, please repost for net-next.
And I think it'd be more typical to sort the speeds from the slowest.
10/25/40
-- 
pw-bot: cr

