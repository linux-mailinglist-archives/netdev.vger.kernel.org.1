Return-Path: <netdev+bounces-71910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB8E8558C8
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA498B23A9E
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4517C8;
	Thu, 15 Feb 2024 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbd5sAT8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8715B7
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960714; cv=none; b=GMhJbrWrYwjahskZ+RTvu3jhuRitwLspbG0Xq1yrv4C6MJhvwIIpRr85MUEv1PH6N8fRk0AucPmanZa3PDxy68gIwwrdjVBm/6Dssl8YQnXQvVVgByv2P2h2Ne5KSb3wyXTJ3+MzVocZBgs7rn5XMOgmYgX7J2fyUwnkJQIdS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960714; c=relaxed/simple;
	bh=LfvMskgCiHa+7MnpWmzWHJXmfVSl/s1csIqbN++KsNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/R0k64EK80tdsl39IzeNLepXxbsVKqt77n0F7BFEphikw2ExOW2+uofLEEMxbJPmg/6kdTvSQqKOTIvp1+O4fWAtc8pgunJUvr5pV5WGBKvLN5mENbRDTPZfSuAW2AuDgDLKswmkYECS0MdWHVSX6hU11ftLC83BDc2NnX2aTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbd5sAT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06CDC433F1;
	Thu, 15 Feb 2024 01:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707960713;
	bh=LfvMskgCiHa+7MnpWmzWHJXmfVSl/s1csIqbN++KsNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dbd5sAT8Xu0hSYL0ugajmhl+jV2ZWQFAXSLRkHKEhoeMdYXVCdJPkOoybYCigIGPB
	 f/QbBHFytpiI/NDNChHEEodA/EuLtcXqolhnR/SQlJdDoqJpysaczlTfDJir+C0/pS
	 5ceHLH23cINgp6NcWa7yztFLjNydpCv0Ry0GrUX5kNsnrgzisVAUoYITVNLcLbFWoz
	 +ThtHvMNL0Mqg9hxulCYUYk+Nz0AvwGD2/6zj7fVAarjIPNGijsSO0mLmzC7tW4fLn
	 /95Km91AE5vBTnt+JmsKudJEauSNeEfc2udfev4ekqaQ6PLAJUfylEycQsw0m7f9VV
	 VfGJHDzQEC01w==
Date: Wed, 14 Feb 2024 17:31:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2024-02-12 (i40e)
Message-ID: <20240214173152.0a4f2555@kernel.org>
In-Reply-To: <20240213010540.1085039-1-anthony.l.nguyen@intel.com>
References: <20240213010540.1085039-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 17:05:35 -0800 Tony Nguyen wrote:
> Ivan Vecera corrects the looping value used while waiting for queues to
> be disabled as well as an incorrect mask being used for DCB
> configuration.
> 
> Maciej resolves an issue related to XDP traffic; removing a double call to
> i40e_pf_rxq_wait() and accounting for XDP rings when stopping rings.

Looks like this got (silently) applied, thanks!

