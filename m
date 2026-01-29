Return-Path: <netdev+bounces-254907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHEVH8+9e2mnIAIAu9opvQ
	(envelope-from <netdev+bounces-254907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:06:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FB7B4243
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 694753010161
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FFB3246E8;
	Thu, 29 Jan 2026 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="K3JEyVB0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2129B8D0
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769717196; cv=none; b=kqES3gg8fXjR5bhJqGZW3yaYAlS6lzat0SfmgEQPIe2qFKMotxjP1rJ8KaJFDft9XAK7UAfXCsjBegE5BElGC3YKYxFKHEHnlBLeinU+M3oS3k/3/Y/ZauYRHhXQQyZK/C4SRxPFQgn4BijlfK1cjDDTy0wpE7PRz3bVNDD7XJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769717196; c=relaxed/simple;
	bh=+eh/SUwQU9XD5Cmg6Rs5yD/vpU03vvM05wtq9Pa0vkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlYh9xyGJlPQ01aso1nIrBn8zmWnq4+fqUx581rhiTTqulIsjDuYdDr+MhIUgd7YQeLSj6zoWHU39ygDn3elm7HnkBXooQeSHwYbsKjQCPAVDFBj+W8ZotW5xexKdHcGC8/77sKz1m2S1mPujck/OcoSk9vAinHhGgjWYw+QLTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=K3JEyVB0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a7a23f5915so8820675ad.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 12:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1769717195; x=1770321995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=St0oud0e7oWpK/kNC2zmpDnKbjo7wRZGc2JcqraRRS0=;
        b=K3JEyVB0ZinlHzNJg+HCDg5yKi1ukkD6IdP9BuJhG9FDpWLhYWTIhgf80+bvtSv6h4
         gr6+xwYl91l9d7LgqGAmfP6qY46K94+/M0qWWYrckeuJmvGrl2KQbg4Tx6GlaZ6AR86u
         7rfdcKtVmR8NS1OX9Xofd84AUVk1jokwNF/9cmAIgYMPHFZXTPUAXlGqxF6FvIpLmH4B
         00ZsvGuvgnVx/rDx0AOUn57NyDZ7M6Kn/QNChU8B/oZ7l1vzGAKKhmQRdYUp8MR2VND5
         QitaJWJh21wEuPkHi8AL14dRQb841GR9XwIsCUfg7mRnI6cRKl2BsRWkHTiMIHn4PBj1
         /41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769717195; x=1770321995;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=St0oud0e7oWpK/kNC2zmpDnKbjo7wRZGc2JcqraRRS0=;
        b=T6eVYBU5DIhk12ZJ0JoFg+72nNRpayAcHOlG0oz2IbPyWC5aFB0FSim8CTAxpUd51X
         9Tv81Zy1F7Mh9JqPFzVKO5vqRo0wbR9+uEZRovi3estyiA62j3rbfUMRsdf3bonwErdk
         k2AcP/gVSq70SQGNhhV8sQgK/Tp01ow/SfCL8+TB6/VDyXRckxb6psNycDeF7dtkCrK2
         uBoAvC8dA/uDAX/HFnT62THT2QMW4zSQwjVyZNeIT71RDQXnSDHKrxXO28MTGz/4+7YB
         HA1vOGizNr04tCvxk2B8pSh8ciaFpDAI/UcoynostDhYRboYygGA6ld3XIb8Kmu8uZC5
         WD0w==
X-Forwarded-Encrypted: i=1; AJvYcCUzOEsIVUNPD2eVIy8gESldXtzpggWBfXdM0flcAJm0eLV3o+W8exlpDG7RXILpyTl8gK4vIGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ59CDw26oQyUUvcu6INYfZiolCJp1YN9l4LY4atBJniJVqGth
	1HicFoRCOe0sieBNxhld/p4/q3KuJH2EmoIawJgRLTlLIA6TJlws0goNOCrt2L+5odQ=
X-Gm-Gg: AZuq6aI3w4X2WZNbcVVVOhE5WnXbg9gZDRxCBD2UB71eoKCYuDiNMXY4llpHV/Q2cw3
	X0AvZ1l55Bz6Sh1xXGq4e+u4Hvqi9Dd1Rz5ogbAG3P3AJmGk//mYcgMNKLSuC2yoanlcAwEQuJd
	qvpiuSJdtSvM+3TGRbPWt4NXjKpIxGcho8ihR04KMBd68ahvRhQPn76CcwACMGXr11rPQhbVz3+
	2xQ+TdZQ7HVBqpuPVLz0A7fnrqPN/aJBfOCcsckUQNRDETmSnXJZRUEJBH0lkOrCSusQV76yVJx
	CjItDrhZjZcxs6n29oEFR+v8ijuvDC9J3kgn8aI+/cKo4gTSSCmvexUY1Nty4WgLgKXJglNCbgi
	gvHhVX+YCrpVX+gLMPmbVy1o3cmwFxtY3FN2rPM3ekwjRkovoVk2aLsigcl2eRt6+uA4if/H+bO
	I=
X-Received: by 2002:a17:902:d4c9:b0:2a0:bb0a:a5dd with SMTP id d9443c01a7336-2a8d9a60127mr2972515ad.57.1769717194904;
        Thu, 29 Jan 2026 12:06:34 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b414cc7sm58495255ad.33.2026.01.29.12.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 12:06:34 -0800 (PST)
Date: Thu, 29 Jan 2026 12:06:33 -0800
From: Joe Damato <joe@dama.to>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>,
	Wu Like <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>,
	Luo Yang <luoyang82@h-partners.com>
Subject: Re: [PATCH net-next v03 3/4] hinic3: Use array_size instead of
 multiplying
Message-ID: <aXu9yZBySHREdqoY@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Fan Gong <gongfan1@huawei.com>,
	Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>,
	Wu Like <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>,
	Luo Yang <luoyang82@h-partners.com>
References: <cover.1769656467.git.zhuyikai1@h-partners.com>
 <b7d6d384ccc0bd4c0d3e7af1f90901d589cbd0b1.1769656467.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7d6d384ccc0bd4c0d3e7af1f90901d589cbd0b1.1769656467.git.zhuyikai1@h-partners.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254907-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,dama.to:email,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,h-partners.com:email]
X-Rspamd-Queue-Id: D1FB7B4243
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 12:01:10PM +0800, Fan Gong wrote:
> Since commit 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
> use "size * sizeof(u64)" in hinic3_feature_nego.
> Use array_size instead of multiplying can make it clearer.
> 
> Link: https://lore.kernel.org/netdev/20250911123120.GG30363@horms.kernel.org/
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>  drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

create_cmdq_wq in hinic3_cmdq.c has a memcpy that could probably benefit from
array_size, but I'm not sure.

For this change though:

Reviewed-by: Joe Damato <joe@dama.to>

