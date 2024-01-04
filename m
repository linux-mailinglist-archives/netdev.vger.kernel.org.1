Return-Path: <netdev+bounces-61548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB7E8243C8
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A6B1C212AE
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AECD224D3;
	Thu,  4 Jan 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="qE9heZNy"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D136225A5
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmachata.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T5TR14M8Wz9sqw;
	Thu,  4 Jan 2024 15:26:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1704378365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIRwbQdxCEdzv4YU+BHERoTc7naj23q2060e8OoQ7NQ=;
	b=qE9heZNyk5jt3vzse4PP3K+wxndxZme3gNW99cs2YU06J70Wj8dxgkZ+vmUZhLI63jCYI6
	rrO1l6yaWBc1nIfN3bSRt9RQRJhubXiq44sIYwYuexWcV0NWn7ozfgopu/hhaACbpTBfTA
	f5tTcUc3H+kHFqIayrOzTcw11tyDUgwyFIfvJeS6wb6oHw0sviLzmB5XX4rZr+Lep1VPv3
	eyDp5j1crjjXNAinhJBc3kBC0pEs1+gw3DLphlBdBTRiTOmZFOcF4NJ69Q6EFy3S/DfH/G
	IHf6CX9u9Ou7hs9mU3Y8vLpj+OG44mFTBkP0begNIf8E2IFtT6w5GImLjnmG+A==
References: <20240104011422.26736-1-stephen@networkplumber.org>
 <20240104011422.26736-6-stephen@networkplumber.org>
From: Petr Machata <me@pmachata.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: leon@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2 5/6] rdma: add oneline flag
Date: Thu, 04 Jan 2024 15:20:24 +0100
In-reply-to: <20240104011422.26736-6-stephen@networkplumber.org>
Message-ID: <87v8895g5g.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Stephen Hemminger <stephen@networkplumber.org> writes:

> diff --git a/rdma/rdma.c b/rdma/rdma.c
> index bee1985f96d8..131c6b2abd34 100644
> --- a/rdma/rdma.c
> +++ b/rdma/rdma.c
> @@ -16,7 +16,7 @@ static void help(char *name)
>  	pr_out("Usage: %s [ OPTIONS ] OBJECT { COMMAND | help }\n"
>  	       "       %s [ -f[orce] ] -b[atch] filename\n"
>  	       "where  OBJECT := { dev | link | resource | system | statistic | help }\n"
> -	       "       OPTIONS := { -V[ersion] | -d[etails] | -j[son] | -p[retty] -r[aw]}\n", name, name);
> +	       "       OPTIONS := { -V[ersion] | -d[etails] | -j[son] | -p[retty] | -r[aw]}\n", name, name);
>  }

I think you indended to include -oneline above?

