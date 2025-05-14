Return-Path: <netdev+bounces-190476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D49F8AB6E80
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1679F867511
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4B527E7C0;
	Wed, 14 May 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwTUde3K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D21AD403;
	Wed, 14 May 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234137; cv=none; b=cts6ON4F8dYAeL9UgGG+CCylWEvZN25Yk3K+/xO6yqcZAPYgVzZ26m+SLx7sc/DPgHmoRx3rS5XBu2+SJ+PHXic/n6htIpHST3pwZMauAqWPMNYpZNsUjqd2pFcPUDCdNW9b8HyDph0dwacFxeMicj+hDqBQK2ShRddndwXFdik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234137; c=relaxed/simple;
	bh=5fA8nY7OxBpcSnivn1xzl8ihA4TTvVLXiWs4iLF9d4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSsZoXg8Uu17lNJ3bgDVEkZ9bJWhZofTSNoGbLD50hPGGfRrxLgvYmuYszUwmlk38S3pHpUceCXazPUvt8BCA9bqsjsAdNh/L4yAFdK0aIwd+/MH/o/8j4KMwNXmJO5EV6LBa9bqv/2OYM5uJ8EtADrsvhW0jdIFFU/XEm7cYuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwTUde3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9395C4CEE3;
	Wed, 14 May 2025 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234136;
	bh=5fA8nY7OxBpcSnivn1xzl8ihA4TTvVLXiWs4iLF9d4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwTUde3KY40QQLNXH6HUgKl7skgyHeK5j2a3WHKNp15VexhcGxcREUgWTdNtB7eTn
	 B+GFktOd7PRTbm2+s2MWd0h4R5RPTy8NwZt11gw4JIttXX8oaacA/OtR+WKTLeEMd1
	 SVMQNEX6f5YmbLAZ5R0pqcxbj/WMV0S093Rl2lJai6WCcAKXdAgzmysnEiT+e1Fi+7
	 VVZTBhnrBOljEgL+Et+ln9B9lKrQYiPHQ5XI9w50exgN/6YtkMhsJkuvDHhBictkQ1
	 R6UDAU2lJp+fFqgeEVB7VxqI6UFZSva/iRRcvu5yaz/Lnxj2kHq8RpGNXXZRQaCi3u
	 w7nA3lmZRR9RA==
Date: Wed, 14 May 2025 15:48:52 +0100
From: Simon Horman <horms@kernel.org>
To: Alper Ak <alperyasinak1@gmail.com>
Cc: kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, corbet@lwn.net,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] documentation: networking: devlink: Fix a typo in
 devlink-trap.rst
Message-ID: <20250514144852.GO3339421@horms.kernel.org>
References: <20250513092451.22387-1-alperyasinak1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513092451.22387-1-alperyasinak1@gmail.com>

On Tue, May 13, 2025 at 12:24:51PM +0300, Alper Ak wrote:
> Fix a typo in the documentation: "errorrs" -> "errors".
> 
> Signed-off-by: Alper Ak <alperyasinak1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


