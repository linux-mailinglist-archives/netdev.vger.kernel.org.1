Return-Path: <netdev+bounces-161392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C2A20E92
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 17:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E0C1888D7D
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A741DDC3B;
	Tue, 28 Jan 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4PVJiDI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151E1199E8D;
	Tue, 28 Jan 2025 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081848; cv=none; b=TlH/uN4xBp7NkR+6acqFGqmmkrQ0iePPUPJ/3CNGef6eRSYSjbXEIYy7GMIbJpaoJ3j9yhhq0l749DiqwhaYBLV5rY9yaxz+k6e6uUGvGU7+IE1fIQ3cxSbGD9mG1MlIj65E5wXtcPfmv4JCWEU2WBJXTmlrruriW9cGS7zQipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081848; c=relaxed/simple;
	bh=mTF9PqvNK8xtw4T9Cr4RRkv0DJ6NT73ki7gnenaHdBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8T+owafvcJiOgNLibq73rgiyrrGp44EpDQxOlaSS6b/+jwh8eqhG10DuZxqw5AFLpt2kZY/b6sLA0xSql4CQT7gle9vvW/06lCqlNpV1vWlsyG89LPbU+eEJxOwdFJj3q6pTmBoqQIpfEu1u6VC3JfBJ15b+rGSKhl7OYkWKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4PVJiDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602ACC4CED3;
	Tue, 28 Jan 2025 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738081847;
	bh=mTF9PqvNK8xtw4T9Cr4RRkv0DJ6NT73ki7gnenaHdBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4PVJiDIWs16mOyqQEIrIj6s5VW5rsTr8Lf7m02oDsOcWq26Ukp/OPTBYatcEUlwB
	 LT/VnHU9hTuxl1ewd+9Y7QvvSsi7K5VdJIBcqyyVJZBrNvAfTwWHD0Ny4G07UOT06+
	 UM73c6dS7wIBb66jmhGMzvFmPKLrPBuL/I656l5pGUjf2pzEqw3DijNW+OjBJYGauj
	 hqvMNfCRf0tunKxw8d8HtdgVYShbYHYs0rhG0/d1Mog8n4bM9268yaz1S3UhFOAdll
	 sqB3mCcwM5HqXSZ5gOCYDK7qrnDibg9p5JqDh0wFflPRunWydQ7b1iOi8p9bvwBTlv
	 Bp52jJq8c7pog==
Date: Tue, 28 Jan 2025 16:30:43 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: MGMT: Remove unused
 mgmt_*_discovery_complete
Message-ID: <20250128163043.GE277827@kernel.org>
References: <20250127213716.232551-1-linux@treblig.org>
 <20250127213716.232551-3-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127213716.232551-3-linux@treblig.org>

On Mon, Jan 27, 2025 at 09:37:16PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> mgmt_start_discovery_complete() and mgmt_stop_discovery_complete() last
> uses were removed in 2022 by
> commit ec2904c259c5 ("Bluetooth: Remove dead code from hci_request.c")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


