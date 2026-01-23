Return-Path: <netdev+bounces-252927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFNPIl7Ec2kpygAAu9opvQ
	(envelope-from <netdev+bounces-252927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:56:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A779E43
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE9993045A2C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3131027B4FA;
	Fri, 23 Jan 2026 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbX3Hzxm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386A260592
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194525; cv=none; b=i2NlghKotxkTeUel8mPYaCImYzWerEexl64BjAwKeT/La2IaFOjRPcO0EcrRwBcdwVHpWMPcv0Ucke6yH3Lg2ttBMx2CzwqP4rNUKp+LaalxrTuA5WYFwDo20XEuBfz+5Ybs66OBXia5KgrhHB3e8KtLFcEWc+m5vSZIrBQZunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194525; c=relaxed/simple;
	bh=DC9rNWfCiMVA2t6yQSZiMua5nMrtCbgvS3iX2Q0nBVQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii9ZKanRe9DvHw7A7Dmc+AVz/rUZgUoAhwrSl2yIPdN6MHFj0PuaRUHDhmutMBHXRcDKp/3lwpbKugMGzplcNndGXpv/jJiHdmmIbDT1DSjyNgrwnFH+d+8hu7MHPc7rKahp8n5Taa3pdZ/p6JL7WrqoIQhXfC+lLAkYdd85C8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbX3Hzxm; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59ddf02b00aso2619195e87.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 10:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769194521; x=1769799321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sEFLsQyzoxdu1YcF2YnABjIcE2WnszBPzD975tlZq2A=;
        b=hbX3HzxmSjZs0kxJC1leAATZIT/Xoow9itXABRslTbdvWKXxVbf9FgACKRAUohART5
         c+/KhLstQptagdMm2+dVRSj99UJALMJqu6aElKnKrlIfQKcSnm9n6M+x8xL0NEDZVNBc
         BHvy4cNui71qy62OsGzU0LlW75bXUqIkwb0mg/sok1rGBPGqWitCbFfl8tl8fW37AhLY
         zORwkg21YCxcEUST5orrzEn4/zyXDJcPks80p83e47ceQjlUIJFmH6Q2QBZ+A0hv6WIg
         lXspZkbair7Hlq595gu1EBJ+yN5zIeaN2E3rej8T2yjmsE/jK7lRAc4JRZW5BtMYhOMo
         ZIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769194521; x=1769799321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEFLsQyzoxdu1YcF2YnABjIcE2WnszBPzD975tlZq2A=;
        b=FpZA/v0fLJ4BkNfqPz9T3RM83DR8xqMVHxyLX+y1LQZ0kp8EUqrZ5DU8fhsnOXHv6o
         w7n7wGSPMsgg/IsdEvyhIeNNV4LtRQ8CtSLgeCbn9ne4QsLWpjtcbHN2W5FiB8MzdULu
         lg7oBZYWSsI7GDqecVOpvHQ6QAeEmK3OnEAiEZx0XMgDI4pzk2ToY7H7Y31tEbJlcjwj
         VgmqErpdWHv5gpz7LPe6qLYiKtWWA6hCaD2KDiYMuraThHlaFNPrUE5UPrdYmrVe1qx9
         v8B03w/DzmVbXBKHSmFIxOrIEEh62En0EG2QZZCAnDE/P8D2/op5yH9Z1HnTe8MdS0Cw
         VZxg==
X-Forwarded-Encrypted: i=1; AJvYcCXFnbro3aISeoZkBvq0d6Gu/j8Z9cP7lGO0oqB+3Fzv2uP/kEQSdPWVTWhi+sxJLGdxotmUAKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0uPbtWsApAyVcFOJ9yMt1UzNBMQ9ljHglqkWsTh0dsSYGDrF8
	Z45QF2XRQ518YPnqzr7gjP+hrURP0shapTybmNSSBeHE9ukHbjGqrQKU
X-Gm-Gg: AZuq6aKOQcrq5zsG2yfcxfa1iWPrnkOXhtJU/b6vrUVtVifdvHmbyelC5RhUXc2t355
	rwfuaaD4vdOisAd+i6HQMXCUiXqv0Mt8N/ilPO4W+yV6Lz42M3VaMzCnasWGwQXqIJuvbRZRMvT
	tYRsE2/py5aAdOAY0yFblLhaaUcRlLCt9rd9AfqTDJ2hXRG3HYxaxn4it/e9xjkXAUiAj2xuZPZ
	dY8iFzqL6FxXpcGdelZCqDuZ4vnPeMehc6F7Uk4Q/BBRiSMqDWwgMJs6/OVGCrFEdWyy4miymuI
	7VBNi+XsEqdZf9eFfkgeHH/wK7w39RRB3qC4o/ArdWciD3CZ4WzygrsEdlMseUUnPtDPX4T0jE6
	uKp5JOmQktUhAGPmtbGEcuzAROzgJH4jK9q2WRNdNQk/zJLrSMLfy
X-Received: by 2002:a05:6512:2254:b0:59d:e7b0:cfc with SMTP id 2adb3069b0e04-59de7d7309dmr849185e87.15.1769194521113;
        Fri, 23 Jan 2026 10:55:21 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48e6023sm848831e87.32.2026.01.23.10.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 10:55:19 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Fri, 23 Jan 2026 19:55:17 +0100
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <aXPEFdEdtSmd6AzF@milan>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123082349.42663-3-alibuda@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252927-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,linux-foundation.org,linux.alibaba.com,google.com,kernel.org,redhat.com,linux.ibm.com,gmail.com,vger.kernel.org,kvack.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 038A779E43
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 04:23:48PM +0800, D. Wythe wrote:
> find_vm_area() provides a way to find the vm_struct associated with a
> virtual address. Export this symbol to modules so that modularized
> subsystems can perform lookups on vmalloc addresses.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  mm/vmalloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ecbac900c35f..3eb9fe761c34 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3292,6 +3292,7 @@ struct vm_struct *find_vm_area(const void *addr)
>  
>  	return va->vm;
>  }
> +EXPORT_SYMBOL_GPL(find_vm_area);
>  
This is internal. We can not just export it.

--
Uladzislau Rezki

