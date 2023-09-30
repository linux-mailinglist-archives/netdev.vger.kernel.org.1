Return-Path: <netdev+bounces-37161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB507B406E
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 15:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EF033281C8D
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 13:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4E2BA46;
	Sat, 30 Sep 2023 13:19:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA9BA955
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 13:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41F3C433C8;
	Sat, 30 Sep 2023 13:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696079947;
	bh=TkJccJDta5ELpn2APXWKrpLmjnFVEgfNbXdHwnS1A48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=prjRe/hp5ipBDD2VrPfn7Y262AKGszVcJxK1PYvUyF55UjcL9DBoaauzrNri8P8j9
	 FLAgxmAxBLxiC/wGxLLlcCa8ZQYCKKu71ysKk7vZdukPFg9c28C3UGbcwI7bVKJCMx
	 jcIvGhaPTBydQL2n9niLuJTHP//SHlUTAxLxy0ymYcQbPnbb4Q7bmJWoSKIwhsJ5HA
	 xfp/bsRIFyMzTOL1axA/8DRMKM+7TD1eFyPFYVRZI23wlhd+NtabSELBw1sENEuRMs
	 odu6X7ueSEpUu2W44HurRkb8KmnvhbdFnmQ43YIOxX7KhkycqgcWi42cxc+sbwJFH7
	 IMKKuH77KCG6g==
Date: Sat, 30 Sep 2023 15:19:03 +0200
From: Simon Horman <horms@kernel.org>
To: Jeremy Cline <jeremy@jcline.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lin Ma <linma@zju.edu.cn>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 net] net: nfc: llcp: Add lock when modifying device
 list
Message-ID: <20230930131903.GA92317@kernel.org>
References: <20230925192351.40744-1-jeremy@jcline.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925192351.40744-1-jeremy@jcline.org>

On Mon, Sep 25, 2023 at 03:23:51PM -0400, Jeremy Cline wrote:
> The device list needs its associated lock held when modifying it, or the
> list could become corrupted, as syzbot discovered.
> 
> Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
> Fixes: 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>

Reviewed-by: Simon Horman <horms@kernel.org>


