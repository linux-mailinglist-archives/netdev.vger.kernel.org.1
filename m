Return-Path: <netdev+bounces-200586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E742AE62F1
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD4E4A58F2
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1E28853A;
	Tue, 24 Jun 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nnlp0Wrh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC56286D59;
	Tue, 24 Jun 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762425; cv=none; b=u2J8aSvjIhXEWI1nSl5TD+dngeX3i0TG5YFv78ykDYH6xckJG6YxUX8bfXY6zHQMyHW5I0Q2WczRD3dXxJlQdQT5ARBAxa3CPb6nuaVf4uqcKu20Zayq9Wa2mbQOaALKf8bZRgM4ppguACFV1Vt60wWuF7S3ALvcdskzT6Lzbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762425; c=relaxed/simple;
	bh=S3jUCUp2XdUsiQ7eYQqsm28zjcmax5vNV3r2nF72mWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugR+l0NVFniDJYkkuahpamJwCyI5pegTu8e4N/rbfZsO07FKeJktShANrWgPN3E7k7lBtF8U/cf9LM45+8wHJw+8x35hLNMptCcmYl6ojCSF1OCJ2N8WIntjOhSA9wEFRYZzZ30y92hLvhud4JnMs5WbyW9bcYIGzPA1cJz+n70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nnlp0Wrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28549C4CEE3;
	Tue, 24 Jun 2025 10:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750762424;
	bh=S3jUCUp2XdUsiQ7eYQqsm28zjcmax5vNV3r2nF72mWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nnlp0WrhMFFkS3PU5K8RVYPXtiuGQ2bnZI1Uld1fZa0IXBVnPYzEs5skJ9DvtdOS+
	 kUxMslPybB6IKoFBMxJ76wH1SGDBFwSZ55eUFhgMYOdQhVWUWSmsIC6onYX7JN5Xoa
	 0xojNkQLviwMY2q+Mu9/nFH7eXFXV4bC+ZgOnjEGQELO25FmSwvRn69dMmmx9XYPvj
	 qCLgOX2HaU3C7K0+eioqYUz2OHs8VZptxfDcmTlqzWwGJeysuHK8bZvpJyX2/7BpXS
	 UMn1OcvikOGsB1Y5CJl1AhhZgqY4LSZ4OFtVHIX0nsjZBQR80idK/MFNrbrCfK94GY
	 onMxzcdSxS6dQ==
Date: Tue, 24 Jun 2025 11:53:40 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/3] net: hibmcge: configure FIFO thresholds
 according to the MAC controller documentation
Message-ID: <20250624105340.GF8266@horms.kernel.org>
References: <20250623034129.838246-1-shaojijie@huawei.com>
 <20250623034129.838246-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623034129.838246-4-shaojijie@huawei.com>

On Mon, Jun 23, 2025 at 11:41:29AM +0800, Jijie Shao wrote:
> Configure FIFO thresholds according to the MAC controller documentation
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> ChangeLog:
> v1 -> v2:
>   - Fix code formatting errors, reported by Jakub Kicinski
>   v1: https://lore.kernel.org/all/20250619144423.2661528-1-shaojijie@huawei.com/

Reviewed-by: Simon Horman <horms@kernel.org>


