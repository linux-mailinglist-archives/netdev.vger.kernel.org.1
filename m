Return-Path: <netdev+bounces-228581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B52BCF1BE
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 10:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAB819A48DA
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 08:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5F8185955;
	Sat, 11 Oct 2025 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUKrm9hR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507BC1EEA31;
	Sat, 11 Oct 2025 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760169728; cv=none; b=W7faEOupvgW/6YQKlBFkkEDTsBBJ9xkYOVp/P9toUw5++BuAKMh4sUcwB4IFmDVAHqlH90Ysh078+rq7QEdAAgPPzMcbLssnfKSlD2nW+XQQtV572dgO61f+PHhsiFSTIRIv1hHQpk27lad2x4hj/bEkFMlQPwMxY23+JsAdp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760169728; c=relaxed/simple;
	bh=kdpPAoMGGneDhkZQDbHzrKQRkHA/Rwa4e7iHJOy/Qdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4Ix4diAwcf4iVT8fjmtwJgK0KkOwZ+LSjTH2dPUIkK0Ml5XEEeV+lPgqhEZsVfwPjI1vZ9ZYcHJ4eW2roHC4ZHSUgpryf/P+5TNqqkYV8ZZePd/VwBhGYFVtO5ovSyc+LkIC/Elpzxe1W8YtZmVjf6hk0iyiOEdhAsiYvFePEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUKrm9hR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC07C4CEF4;
	Sat, 11 Oct 2025 08:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760169724;
	bh=kdpPAoMGGneDhkZQDbHzrKQRkHA/Rwa4e7iHJOy/Qdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUKrm9hR2SrUvaqPKbA96PQrvg/bGFmBODThuJZapHwSXb6CL5EoU3sPd9l+toz5N
	 U2qXAEH8qReXHhVESrdot0Qo0FVBxUGvAGw715K5iqT2f4FnmSy3dXRhclFhvSptSd
	 YMvPPl6hJwPBr7Hx94oy1ixuUAnV1D/eVMYjeP2qe47CgJetSidHnzMr5afDZXdiOF
	 o9fv/dFhTTRS12W30AW441DCyxTMZNAgCy9nuKYvtddphGqyoEsK1+I6oAM9RJrwG+
	 ntS5qXW3ykk+fKpmNetWqi+TSXatMcFQasazZvQY+b9JnhPdQQ7bmr//JEXkdisD/x
	 yeaGiAiNOx5Sg==
Date: Sat, 11 Oct 2025 09:02:00 +0100
From: Simon Horman <horms@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Philippe Guibert <philippe.guibert@6wind.com>
Subject: Re: [PATCH net] doc: fix seg6_flowlabel path
Message-ID: <aOoO-AXbtSEwEoZH@horms.kernel.org>
References: <20251010141859.3743353-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010141859.3743353-1-nicolas.dichtel@6wind.com>

On Fri, Oct 10, 2025 at 04:18:59PM +0200, Nicolas Dichtel wrote:
> This sysctl is not per interface; it's global per netns.
> 
> Fixes: 292ecd9f5a94 ("doc: move seg6_flowlabel to seg6-sysctl.rst")
> Reported-by: Philippe Guibert <philippe.guibert@6wind.com>
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Thanks.

Thinking aloud:

I see that above the lines added by this patch are documentation
for the variables seg6_require_hmac and seg6_enabled. Which
are per interface. And thus documented correctly.

And below the lines added by the patch is only seg6_flowlabel.
Which, as the patch description says, are global rather than
per interface. And with this patch that is now documented correctly too.

I also agree that this problem was introduced by the cited commit.

And as a documentation correction it seems appropriate for net.

Reviewed-by: Simon Horman <horms@kernel.org>

