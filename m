Return-Path: <netdev+bounces-270574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJpyAgNtwWmqTAQAu9opvQ
	(envelope-from <netdev+bounces-270574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:40:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F6C2F8958
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C5DC320EE17
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5534E25F984;
	Mon, 23 Mar 2026 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ngzzRSRu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A341258EE0
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278096; cv=none; b=c4GaaPj8+6a1TbwnCTa4FvGfixYqQ9gOz0bFcyWWI+SZjM2CGCygNlYW+wsrfFas3wKVqSZaBe+3sdCjWZhtAf1u++kvOBwXlUBv/OCXAaycLaNn62mW9uXyqUciFvQq0zEujVi1+GNJxiHr2OPsZslrvpS9JiZv4N4S2DoMMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278096; c=relaxed/simple;
	bh=YJAGFGGqTDdOapPqoyMIufJSNynlGJlzEAnVFZvT4oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGG3yM/ZznX7eGHbuhKhShyRrCDxJQZomB5HV7s3gpzzBEvLuwYTA+2nf7vUwzEXwxYA/ZCV0SFItwrvUK6p8twIEmcHfU4x24oyFoYyrAHF7bAFd8euh9dbf6w3ix2m+nJ7I3stGsuL/myGbdonYfMTp9G+RiFJtAuKw4p6x6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ngzzRSRu; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40423dbe98bso1103093fac.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774278093; x=1774882893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOPOYS/nGpT6q8jY3dWvKs7qQBZ0laozgcfEFZVyZg8=;
        b=ngzzRSRuyM8B3sEkL1nkBwYw746zNpG1KVfpJREhN15HtNmX0w9trIFjMfkuANx+W/
         JPP9bMj/Ufz2oNoguTJyfY1zGK4cU+C6Wku4qI3/3ZXsx5G7Ol2nTv8h0CDhW/x7FbcY
         13j7fXR0WXHqW9IIHz4K9lB4wVGeuaeqvvmayFuL6Xioi3gmoTsGr08QatTiP8c6BkKT
         I6Dey+RWxOGSPKHFRhxkTOIBuRJHdD9owWxXQMFcD9vIy70RvcChG1k91KWJqCRNEH8g
         U1VV1ZNnOhEwL2vbXZJAC5Dm19rqmAofOYuoA1Uklkr3oekqDIC+dLWhEXVCN6sBlgaJ
         zg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774278093; x=1774882893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOPOYS/nGpT6q8jY3dWvKs7qQBZ0laozgcfEFZVyZg8=;
        b=qiYRCEC0cZ2LOkNO4rs82l34Qa5iLmNX69cChF07nGhRQ+nTi42Pr5YYWvQeLGCXfN
         8Vvj2/iVBuPMBvJoWkBeohq3wsqj38FwXmG7vspA48dsMQDYmDmFvoHCujEMjmYpGvqC
         Z3wtwQ6H87D2zXBMeFJMP1emUtGkbC4fZ9JDiaRE+9N8kMkSBWdaR6dh7jNoebdyPvXa
         +A7dmUJmIED8tAoDX3xMivwCauxwysXOyCHzSMY1NGENvwAnd6TncSLj5iAWwHWRsWrf
         qsTU6PbjCdjzl/zPpCQzLNaxP7BHtEJzzHIfYduEnaZ9bs0MoGlQcUfPjtLCMgYZX9j0
         6Sdw==
X-Gm-Message-State: AOJu0Yw20Bs5gJGvpqtJmtDoiFyMMEKRC7L0tMvUdUORKZRdoFfB1HbI
	+/VPTZh4oMAlNViJnBfr7whSXFfn5xxYz0Wuv4xCvCAxC0wNACY9tUBWtwTSzz/FDVU=
X-Gm-Gg: ATEYQzwh9AqaH6cuEl+13U1uR3IOgEQ+vhAruESwNCflfOM0ntYPSxjjH1Ivs9l1jKD
	YbTmQJzyO913q+HhZgHEPLRMzOqFjwRUV/w2q3scPRE/i2b+nhKYDlIV41z5Jy558xTLDv0FqT6
	mmiO6hiBqPwymvUhhFZTu57S0tIOzQfMMwu5dBplbqLRw2poAugnaeOPw1kbisGSOEsLuS5kO/B
	goGOfmkx/3vtzND4FkNbvAVfOc8JtCaL0/D5a7hWPHj3dxVFo2434gXzO+JO71zMv9q98Qcs/Zw
	z5ryGF/jFoJvco2v0AOVQlnio6XQIW27Y0sV61jbSGyf8pZy5I2h4OaNdTctfBJyKJXPeqcpgHB
	RE8y7B14TaUmYitZIQGV4pU+h4SU+YrSDZ9Y6mSod7cUkrgJ1m0KyHoO1/EKOanSKxpgx8DGTz4
	ByqVTK1nQts7quJMe+mwZjSczsj5QtQ/vfybF6vtb2igEhqN+AE2Cy82sTt4CpfEqarv0sEr0Or
	N8/mIH5pg==
X-Received: by 2002:a05:6870:28c:b0:417:5828:ed3 with SMTP id 586e51a60fabf-41c111f5247mr7123073fac.38.1774278092544;
        Mon, 23 Mar 2026 08:01:32 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14ddbca8sm10822185fac.15.2026.03.23.08.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 08:01:31 -0700 (PDT)
Message-ID: <1b3ad321-866a-4cb8-9810-5eae7805647d@kernel.dk>
Date: Mon, 23 Mar 2026 09:01:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.1 01/16] io_uring/zcrx: return back two step
 unregistration
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org, Youngmin Choi <youngminchoi94@gmail.com>
References: <cover.1774261953.git.asml.silence@gmail.com>
 <0ce21f0565ab4358668922a28a8a36922dfebf76.1774261953.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0ce21f0565ab4358668922a28a8a36922dfebf76.1774261953.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270574-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 45F6C2F8958
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 6:43 AM, Pavel Begunkov wrote:
> @@ -898,12 +933,15 @@ void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
>  			unsigned long id = 0;
>  
>  			ifq = xa_find(&ctx->zcrx_ctxs, &id, ULONG_MAX, XA_PRESENT);
> -			if (ifq)
> +			if (ifq) {
> +				if (WARN_ON_ONCE(!is_zcrx_entry_marked(ctx, id)))
> +					break;

This break is inside the scoped_guard(), does this need an ifq = NULL
here? I do like scoped locking, but this seems a bit tricky...

-- 
Jens Axboe

