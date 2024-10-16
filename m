Return-Path: <netdev+bounces-135937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B8899FD58
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32C5B217F0
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6F11F956;
	Wed, 16 Oct 2024 00:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDh8HeFi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335C1EB5B;
	Wed, 16 Oct 2024 00:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039569; cv=none; b=hkF0awbyfJNqd3mu1hu4ltZBaBscmqzolBDxxcH4xB/7ZzogAt4d0nKlRLS4uQIzopLMIbaSjXNvrwVH7J9gC5Q+PIIdrnOjmJfP4MpqNk8uqQxY+DV0Dj6Zz/Y/lxNp8YTBgv6wYZAyYg4WW632iCtj4mLV3OD/Rr5Se5H0L9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039569; c=relaxed/simple;
	bh=gau4ljJEWPH7doucGrEEQmvS6b7hCt12v+vpbNEM5s4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsYM0XqorI7UZ5k8K5H2lIXb4PCNPmynExE1I8uUQCw56AqJpUQ2fgv1NWOB2Anoxe08sHY4UOwwWntsmXif5CXZz4AAzEASs8vRiP9s3KdtBtuRxbiweVJqQSeyPZmWjeEK5GzGc183oXsDSuT/84Uus9PuDEKJNx+VP/8XL7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDh8HeFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7562EC4CEC6;
	Wed, 16 Oct 2024 00:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729039568;
	bh=gau4ljJEWPH7doucGrEEQmvS6b7hCt12v+vpbNEM5s4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uDh8HeFiuQthP6mtjKIwK1u1Ou9nr3VRU5GtpG/DbGeWKm3HCp/dehGuz1x4O5bYT
	 +ocCNjnZ5NA4u6ynjg2rPbz1JGvUyh7Hv+Wckgk6jejhWH1SnD8AgHyi/qnuw5QsS1
	 VxNTGl6zsWXsD2k+XL9+8dI9bV0Tewgdi7RLYee+xbBadEhUUylfE6xDWXPj8/LdP0
	 v4dAsnQDqkhfF8DSSW89Gr1Hc5pChlHbLte04U71A+cckcT5EEGZZIXvayC2cdy4Qy
	 dTLXmKFopLB+cviFtVtCSnAwM+BCTbspbvgERaNW9YoBo3uIs8FkftFITv4OOwjupt
	 5blGzSBXipRDg==
Date: Tue, 15 Oct 2024 17:46:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johnny Park <pjohnny0508@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] igb: Fix styling in enable/disable SR-IOV
Message-ID: <20241015174607.6c29bb8d@kernel.org>
In-Reply-To: <Zw2mTeDYEkWnh36A@Fantasy-Ubuntu>
References: <Zw2mTeDYEkWnh36A@Fantasy-Ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 17:16:29 -0600 Johnny Park wrote:
> This patch fixes the checks and warnings for igb_enable_sriov and
> igb_disable_sriov function reported by checkpatch.pl

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches

