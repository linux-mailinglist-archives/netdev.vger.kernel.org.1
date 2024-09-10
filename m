Return-Path: <netdev+bounces-126750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C92C97260A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1ADB20ECA
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD9F1859;
	Tue, 10 Sep 2024 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrA+YXSn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1481E
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725926859; cv=none; b=fe8Kv5EQmsaOdLp4CEe9VdLyJ/x0g0zALVfJC1T6mLqZvt3dwEl5l6JgB2F6S+jXaD2ABvB6SXT9tt6DV4JT6DrDD+R4vDX/iqOVj4cY/P87IiOD/UmxCfZyfZ0NtIeCsKmrWa4P/x5aV1CIOvJr+5MAJnV2y3EMkdB5ZAoFfBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725926859; c=relaxed/simple;
	bh=hDtMFnvMyTA3j13ZXrs1kBIAuCL27ZyrET7pW9wG13E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LR5CedhjU+i9POOse2xJr5F+sFNM3IC/hKQdO/pzXqiCblpwnSLTK96q13dhgMG5M3m6WEw+ZRNduApNhJJ/u48g3ABre130cWcTKCscQMcUQWWzhZ5TEVPxQStLIGLweyP9WF9vbAgheS+whd/oE2g3ZqnOUSr8O584kYNuzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrA+YXSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C923C4CEC5;
	Tue, 10 Sep 2024 00:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725926858;
	bh=hDtMFnvMyTA3j13ZXrs1kBIAuCL27ZyrET7pW9wG13E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OrA+YXSnZ3hCQQnEuRSYW8kuSUHMYvmtX8w8k/dkO3DPu0csJGR7Cwc5GzatNfLQm
	 /cADJjQJNkZOXTrKgcfKfkI9pxZBSxFvMkCk5Hd7m/cLb/FBqyyb70tO/GNzjqNywx
	 IPj9qPbpigvEje3Z54LMXoPfmdIhWg1JcK3qRBpxqwvZ8YWig6+fLc4gZ6K3TCMwhx
	 +7lfk83mxuCoFFzJyfTNjF3O5nsAZkzxSVFOOEr9hXQY6Gz1D0s9JFyW7143kgd9SE
	 qtvJSk8dS3HWk5omSB/MTxplwQs/hkjW9gpfScg0YA+eGuitRnyOc2AOIuibIphWT4
	 U39D4GivnQscg==
Date: Mon, 9 Sep 2024 17:07:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ales Nezbeda <anezbeda@redhat.com>
Cc: netdev@vger.kernel.org, sdf@fomichev.me, sd@queasysnail.net,
 davem@davemloft.net
Subject: Re: [PATCH net v2] selftests: rtnetlink: add 'ethtool' as a
 dependency
Message-ID: <20240909170737.1dbaa027@kernel.org>
In-Reply-To: <20240909083410.60121-1-anezbeda@redhat.com>
References: <20240909083410.60121-1-anezbeda@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 10:34:10 +0200 Ales Nezbeda wrote:
> Fixes: 3b5222e2ac57 ("selftests: rtnetlink: add MACsec offload tests")

Don't think it qualifies as a fix, it's an improvement.

> +require_command()
> +{
> +	local cmd=$1; shift
> +
> +	if [[ ! -x "$(command -v "$cmd")" ]]; then
> +		echo "SKIP: $cmd not installed"
> +		exit $ksft_skip
> +	fi
> +}

You can use net/forwarding's lib.sh in net/, altnames.sh already 
uses it.
-- 
pw-bot: cr

