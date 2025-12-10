Return-Path: <netdev+bounces-244195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EDDCB2279
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 08:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 190DC3026A2E
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 07:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA7F279794;
	Wed, 10 Dec 2025 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQaM89xf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AD923BCFF
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765350773; cv=none; b=fKHkCrcPV9ahW9ioSlNIAcQCR4vU898xogOOwrZGYewmMcIYyLQxd5QAkbOqodue953bNMcq95zIaGmFrWvg0QTIo+hhFvUBqiQmFluKdUBUxMjLBSn4xBgKRMW1P6BGDJ6AEqGycFVvjei1aO5TuUjuznuUco7Vzp+rIjD3L/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765350773; c=relaxed/simple;
	bh=sFqEyBE6yxp6EkIYxJswQ6NzxzBIlN7thXzlUqxpJLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePiYP60FXLzldZHuzxUBoFAEcejsQJvYgGBXJzw2ADDzCS8iL7HaDbN1XhbZvu2r/Z4Nkw3cGqcTXsGg9NTyBnLPe5yr5Hbxyg5JXVA1JYT113meG6xtyQYOdF1tKKemt5B9E0NOAUZ49srLsYGHXTKZHCu+GQnnkJPN+qVe1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQaM89xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3449BC4CEF1;
	Wed, 10 Dec 2025 07:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765350773;
	bh=sFqEyBE6yxp6EkIYxJswQ6NzxzBIlN7thXzlUqxpJLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gQaM89xftyw1qw4y/TSZOuMV7ZyORfW5VHnzWd7Hy5LRO0bS9Zx7eNbi64OYOaFdl
	 v7HyUcI9ymOPCb6kmU03s6YhGhlgNf4eKHrI/hEC/H2i+52Z+U8AEhmw9q5ZUSkhlY
	 eTo2e2slUAvVJa8/e0zqvtP2dRQIEdo25nlFLcxZncOnj5Prc++CYJVAraeqkmYkph
	 ELSXNR95Uh1mYKl8UYKswSVDny77heLoE8BoqA+BIJAfBB2dl26p0R0ld+I0KnCfJW
	 yutVBJAglF6RC0Th3V2NLVR2FGhDNFD8tn+FHxJgHSOjWLINAkKVmGowrEGPvYid2c
	 lom3U2zCz7rsA==
Date: Wed, 10 Dec 2025 16:12:48 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 <adrian.pielech@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Krzysztof
 Galazka <krzysztof.galazka@intel.com>
Subject: Re: [ANN] intel's netdev-ci
Message-ID: <20251210161248.49f213a1@kernel.org>
In-Reply-To: <20251204082049.1ecfd15f@kernel.org>
References: <a0561c1f-f64e-4d76-b08b-877897d45eae@intel.com>
	<20251204082001.561a5f3b@kernel.org>
	<20251204082049.1ecfd15f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Dec 2025 08:20:49 -0800 Jakub Kicinski wrote:
> On Thu, 4 Dec 2025 08:20:01 -0800 Jakub Kicinski wrote:
> > Are you planning to stay on the SW branch stream? I was anticipating
> > that HW testing will need a lower frequency of branches hence the
> > existence of the:  
> 
> https://netdev.bots.linux.dev/static/nipa/branches-hw.json
> 
> HW branch stream.

Thanks for switching! NIPA is now fetching from you!

One more ask - please trim the results.json file. Last 100 results or
last week's results would be enough. We poll this file every 5min so
better to keep it relatively small.

