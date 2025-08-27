Return-Path: <netdev+bounces-217099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A776CB375C6
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581857C0047
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA720ED;
	Wed, 27 Aug 2025 00:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/7SNo5Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6F189;
	Wed, 27 Aug 2025 00:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252960; cv=none; b=mqbTP3uoI+XKfgjj9uEOeN17C5yfpVs9ugbNW8RC+1pOeoMSInjd+x9ZwHPW6vkGrWzcbiSKmbb7rMx45gtD59GgBgfCu93DZvcB9TBbw62s/dCuA+MG04CUNyc4n5lkaKoIQFKADUFbB5d7MHv2p6HnTU1Uvc5sr7uKEdDGxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252960; c=relaxed/simple;
	bh=ZFEKkcmzQf9xYxqrEb9OKbXitIi2zDjpRGT/RGXKm1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScmXzMGLTV5Vw55o/e1vOUV79ru/gnBTx5BR+9ILezVNXFefgWHAFvfItm2L9RZ+QnRBOMT9IzGC8yoWvc/z49EWwvNrVB+A2bC5Ie589sfkN05VoDR15UlYNFSHG3F6rDirSsxXuAVOVP5BpHwCAiI6EXQqie/u389PDoCEQ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/7SNo5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D414C4CEF1;
	Wed, 27 Aug 2025 00:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756252960;
	bh=ZFEKkcmzQf9xYxqrEb9OKbXitIi2zDjpRGT/RGXKm1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W/7SNo5Q8/0kaZbHBjpqtEp91cgacqq/wJp4/VB5GHO5y12coCmfIjX6bZDdm//E3
	 WWqOJjOhSpEV1aNbnjyCNTf+aJt4kb+Yj/dignBZQpy6fMfMxoaPLWN+F3sRht5iol
	 67264mAJFZ83eSWnIys6QNf5zNe3ji4ZwsMn2ROelSJg8F+vnjhV3auxzD1RTeUI9t
	 Pa+WSu3WCMbH1gfgJGUh8NlvESN34DErTCLkWpfkGYSXrNIW69XWzK1qS7DjEV96qX
	 JSL8g3ywTFOVmYg62IGmeWauhemiG7ICje6ftphmevivcpasnf0KHXCYAsvRyFmoEb
	 axY2wL3Iz8lmg==
Date: Tue, 26 Aug 2025 17:02:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: qianjiaru77@gmail.com
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] VF Resource State Inconsistency Vulnerability in
 Linux bnxt_en Driver
Message-ID: <20250826170238.6014a818@kernel.org>
In-Reply-To: <20250826162541.34705-1-qianjiaru77@gmail.com>
References: <20250826162541.34705-1-qianjiaru77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 00:25:41 +0800 qianjiaru77@gmail.com wrote:
> Subject: [PATCH 1/1] VF Resource State Inconsistency Vulnerability in Linux bnxt_en Driver

If you want this to be merged please read process documentation, 
or at least git history for the relevant code and format the commit
message correctly. I'm dropping your 3 submissions from networking
patch review.

