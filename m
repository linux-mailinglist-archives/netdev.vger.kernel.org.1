Return-Path: <netdev+bounces-68297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36738466F8
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 05:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEF61F27933
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 04:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C7DF41;
	Fri,  2 Feb 2024 04:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1Pg+U5Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB5EAEF
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 04:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706848150; cv=none; b=LyQ1uHaSF8jKGEd1scrB6v7yKcIjnAFZb9G81HD7vaumW3x4We3OL7arE2q8eBjj5WYN26izyE5xTMe97irQoPBar2oxIuzLMEQ6/3Fq5FMYTshd42iqFInCwT5TvUIM9ljGCMj1Gr3lXE9mF+NI2S+Zv26InJ+d1ynpniSjMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706848150; c=relaxed/simple;
	bh=mjv/9loy7g3R9CL/ASFtZn97T7uDjnw7x9w0jL3xXAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=js7Vkvgz3K1hygHbrOnwv12kTnB1pN4elrZeRF0B9MGYgF0sSblDa1nUBW9w72h75iql6/Cob0GOzxqYVj96KHVaz6bDKsmvE/J0CDUDIg9odPpRR5KfN7BbYDylkYL5FGErBDz8q/f/pNCLMmGfOXgr8T+UcrxRu8BL9riGzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1Pg+U5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956FFC433C7;
	Fri,  2 Feb 2024 04:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706848149;
	bh=mjv/9loy7g3R9CL/ASFtZn97T7uDjnw7x9w0jL3xXAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l1Pg+U5YXyXruDSvnSQ2YT7cqqJSIN1U3LtWyrWbzcp2QqLo0Ks6+Px0yN4sNGZRO
	 5VGeW6IYz0O5QUtLvQZ2o3QOZRyXdv8JV1qVAc6X5gauUuxpin7rs4cZsJlyvWJk/y
	 eeuSfyI/13hcF+buRCddXnQWzPBo+h6OkOI+XwwCSlW2rT6zM/homAefqkPSU/hh4w
	 PEgEUwqgTmBoGHT1KUJlph/1ryXV96ytgBsjowG/6IpzQS8oyeGK7KslB/UNme4apS
	 UECdoaN8sQqB0lNsKr+BQwpnGrxAqP4nKc0xdWcG/NMlh/xvqmwc3xHkjjXzpx79jI
	 8XmlY0YF0sgXA==
Date: Thu, 1 Feb 2024 20:29:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Fei
 Qin <fei.qin@corigine.com>, netdev@vger.kernel.org,
 oss-drivers@corigine.com
Subject: Re: [PATCH net-next 1/2] nfp: update devlink device info output
Message-ID: <20240201202906.13fb07b7@kernel.org>
In-Reply-To: <20240131085426.45374-2-louis.peens@corigine.com>
References: <20240131085426.45374-1-louis.peens@corigine.com>
	<20240131085426.45374-2-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 10:54:25 +0200 Louis Peens wrote:
> +	{ "board.pn",					"pn", },

"part_number", spell it out, please.
Why "board"? Part number is for the entire product, isn't it?

