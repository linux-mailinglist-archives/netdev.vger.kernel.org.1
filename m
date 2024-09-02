Return-Path: <netdev+bounces-124296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C550968D54
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19171F22FED
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF4419CC0F;
	Mon,  2 Sep 2024 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA18/XTO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC919CC0A;
	Mon,  2 Sep 2024 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301466; cv=none; b=W1pr6IQegRNoCLmYMSS0PPhtj4/Mn8fYhP50lN91X6IasG8gPUvh6ddBjzystEmABi63MmLBlRqXkX0xi1qzyZVjjOVZXAPfm2VO5kqq5dcJTgTQfhVV5U/jYh4z3Es7/w1eq1MW3AIlssrqpaGv5wmvK2DJgnlAMlMHn8FY02A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301466; c=relaxed/simple;
	bh=xHVi6uviIP3ZnrHvWgWk6awIFA69Nc96HEC4GESxjLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY0oLYrkr/hTHQo4UwPm/O+WjAoCgTLX0q958Y44xIxOh+3LsMpJHF4ZvyLMjRnU+C1igExjW6n50hYp33dQ3Yd3itMY42k2fti5A7dGS0c63jJwhs6h//ngfT6aAqOYdZPyMFYXqMXydNC31bUHlH8MbaD22tOcaoxSdJgjtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA18/XTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A982CC4CEC2;
	Mon,  2 Sep 2024 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725301463;
	bh=xHVi6uviIP3ZnrHvWgWk6awIFA69Nc96HEC4GESxjLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kA18/XTOlmiqMYzj7P6IRsXeXxzH+2JT2Hwhyqr0mPMSnjtBm4TCEDCsvef4CYJNU
	 I+7eC0Xq995A5XKBFIsHXJchLTdaGLyWwGCA45YVgoqb4P6mcgyJZU8qC5qUHdaXJ8
	 Xs8SAkzf8weLDC30FjSHbIF/Ua11P9S3mlMXQKuFCbag8/JPvjAxGU/zHmdwhQVtXR
	 f5KgacDGUm9y9uu5JPA0S+wC7udRI4Dt7hLRp+y3aJMKZ4PQuyo/9hhmbMpQztnDup
	 yl4e936ILwOn9OsVxDZH1BT+j7yu3MM9Yl3FEeJVallLqQumiipmOoptzBG+30Jded
	 j/srfvUVqUaHg==
Date: Mon, 2 Sep 2024 19:24:19 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] be2net: Remove unused declarations
Message-ID: <20240902182419.GJ23170@kernel.org>
References: <20240902113238.557515-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902113238.557515-1-yuehaibing@huawei.com>

On Mon, Sep 02, 2024 at 07:32:38PM +0800, Yue Haibing wrote:
> Commit 6b7c5b947c67 ("net: Add be2net driver.") declared be_pci_fnum_get()
> and be_cmd_reset() but never implemented. And commit 9fa465c0ce0d ("be2net:
> remove code duplication relating to Lancer reset sequence") removed
> lancer_test_and_set_rdy_state() but leave declaration.
> 
> Commit 76a9e08e33ce ("be2net: cleanup wake-on-lan code") left behind
> be_is_wol_supported() declaration.
> Commit baaa08d148ac ("be2net: do not call be_set/get_fw_log_level() on
> Skyhawk-R") removed be_get_fw_log_level() but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thanks, I agree with your analysis.

Reviewed-by: Simon Horman <horms@kernel.org>

