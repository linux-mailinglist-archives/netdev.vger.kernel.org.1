Return-Path: <netdev+bounces-265819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rmpAOydrr2miYQIAu9opvQ
	(envelope-from <netdev+bounces-265819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:51:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AE3243239
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8BAE303DA8D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9312765F5;
	Tue, 10 Mar 2026 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="ZqgSl6XA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E125F984
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773103901; cv=none; b=fhnbQA6iBrsBn2clssm+BWvdkH2f8RpptZXtqjbXGLyyF90G1AvaJjU1+PlNH4ktugIQrUkL8NSN8jL8e+gk7wtU+A23XGIu4LJ6zwo8xFVzsa28wMUH3KxdmuEcnAmkBtuSYbT0Znv5nID2NKYioI7wWTt2mY/9qZuQWanZTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773103901; c=relaxed/simple;
	bh=3IrG+fOOh+yxFO8pIWyDI1vjfTbn2z7aSBZSdPFLBCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq8ccQDKuFMSTFPncYvJxxObQBCwqwTC+ErSjqIH4WK5aDPtiIIx4PO0aTBGr4bxxNNsMe6+Lr+xiQRHFY0IUOPOmazfrSm4gtL4U8/mBzMn2qo8vYz+Pcw270mI1T0wMNG/Jc9kuDkFSxFuo7NjPRRI2/vR114zHiAwjbcV19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=ZqgSl6XA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae5423b02aso57145615ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 17:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773103900; x=1773708700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ui///VuHm/YZR9cjxycdSpMN+uMufMd2buaKUGijN4=;
        b=ZqgSl6XANqvr6d6deOO+7koTRR2/RHAbjqrofPaADGZnSUXxnZcFz/TVEg/9F97fFC
         KCkIqVehwQObkyRqz6VqnvAWd70w8z/LJvbU3aEu8l6fAbh70f2FBzlio9sh5PPo0vP4
         Hk7Uq7hIJ2c9aHfZ0tTVFI6QAXREKjCv3hz2CKDVzqpX0zhcb5/BDeSVUWugTcLetRj5
         lBdIKO5d1wD1etd4XiyuIhR37Hfy7tWEyJfuEc6x2/jb7RmjQkju07qzn2aLL3UzAFqb
         Yfe2T8T1q9yjH85NOIr2cCVxtNCnpKcsaw1MlhtQs2F/aEQxdvLs/egwMiVPxs9h+n6A
         k2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773103900; x=1773708700;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ui///VuHm/YZR9cjxycdSpMN+uMufMd2buaKUGijN4=;
        b=ZgXz0gIFpPdUUFpk8mkmkwnNSXg5o+oIvuBlfBDUfNqa2edoCiPZB42DUvGMCHyu3O
         5qlg3Q34q+mHtA6xrvnWHbQqDeQ/UOTaMXOrmzcgoQX8wiemL/TLpSO23eJEhvt7EQMi
         WI9PJtBPEe9oAtrrwAPgaiqa3pKq4rMdq14XF4FEPrzs3trPN8iv16wP7KhRCokt6NUv
         TRHrEjzypxCXA1vHFFbJC+/F+hs6TmsGmhjFH2O1KCf/rCPG2Y6XSdHUHnSV31gzOiFM
         Xu2mHS/UJIPsS3SJ9yrxMFtuyvZyICo4mxXZyllkyBXHCD4Qrm/xAq971gr+/CDQzsQQ
         /OSg==
X-Forwarded-Encrypted: i=1; AJvYcCXl5133wSHmajJGUdVrnTLmEJbBDSnz/rpFyfZxxnig3cIv2Z3tUvoLltn9389oGywMWLArv+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjO1TKwMXH7sPCO2N0NygFNL657/WwzoupNKwgL1A6cakZf1+4
	7NwgTWcro6iQ2HQmmRQVIGkZLakBPyy2uti8Dgz+wR5Kn/D6mN/qBHZn9s/svKedqz4=
X-Gm-Gg: ATEYQzzwcdqdZ9VKkniTuntSV8mSC+phLXVNm2WTZL69iMd67c+xGFFrsR+xAnnR/d7
	hCBuWl1387yJ7dtqo6grgXGfDr+xlhnMNMSg7DWpgarQazpedrv2km0TkQRTD7igEqLWnuVMcJz
	w15ZwmMg5MhNVUatGvJqeO1FeElMmyaaAYdWiKLtQOKjf2aLIPflyLCYnJ9ewjJJBmAFSMvfvif
	Fdf9uBVP/NVQ67HyBYpOSdDvfv0RBq7qtqKOs1O/Xd7Y4jAVARIZS8Zm4pnR6m4DNO/t1BvpMKm
	zkRqEb8QESZOfrRVZ0gS1LNty/QUnh4eP9R0Oae92Cqo5Gq23V9yW10oMbJhXpsYi4ND35PHF/7
	YZ993eR2561R3mTUSItfU/7IILGsYwA8S+WDLQ6gyHidd7FOJ8EoNSmZYwdXYuRuLIgy1bS2S3P
	fspMJj7rlxpHREZQ==
X-Received: by 2002:a17:903:3bac:b0:2ae:478f:2ec with SMTP id d9443c01a7336-2ae82434346mr125260175ad.29.1773103899755;
        Mon, 09 Mar 2026 17:51:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e585a8sm129807985ad.7.2026.03.09.17.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:51:39 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:51:38 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/5] bnxt_en: Add XDP RSS hash metadata
 support
Message-ID: <aa9rGglS62WGgSMk@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20260306230600.1628196-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-1-carges@cloudflare.com>
X-Rspamd-Queue-Id: E5AE3243239
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265819-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,cloudflare.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,xdp.py:url,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 05:00:15PM -0600, Chris J Arges wrote:
> This series adds XDP RSS hash metadata extraction support for the bnxt_en
> driver and includes selftests to validate the functionality. I was able
> to test this on a BCM57414 NIC.
> 
> Note: I don't have hardware to test v3 completions at the moment.
> 
> Patches 1-3 implement the driver support:
>   - Patch 1 adds bnxt_xdp_buff to wrap xdp_buff with
>     pointers to the hardware RX completion descriptors and the
>     completion type. This is similar to other driver implementations.
>   - Patch 2 adds the xmo_rx_hash callback for CMP_TYPE_RX_L2_CMP completions.
>   - Patch 3 adds handling for CMP_TYPE_RX_L2_V3_CMP completions
> 
> Patches 4-5 add selftest coverage:
>   - Patch 4 refactors common BPF map helper functions out of the
>     existing xdp.py selftest into a shared net/lib/py/bpf.py module.
>   - Patch 5 adds an XDP metadata selftest that loads an XDP program
>     calling bpf_xdp_metadata_rx_hash. The test skips on devices without
>     xdp-rx-metadata-features.
> 
> v2: https://lore.kernel.org/netdev/20260303024510.644962-1-carges@cloudflare.com/
>   - bnxt xdp: actually fixed RCT issues
>   - bnxt xdp: Added patch 3 to handle CMP_TYPE_RX_L2_V3_CMP completions.
> 
> v1: https://lore.kernel.org/netdev/cover.1772211065.git.carges@cloudflare.com/
>   - selftests: moved tests into net/hw
>   - selftests: fix pylinter errors
>   - selftests: add check for no error count
>   - bnxt_xdp: followed RCT for variable declaration
>   - rebased on net-next

I think I commented this on the v2 [1], but it would be super helpful to put
the summary of changes in each patch itself to make it easier for reviewers.

I think you dropped my Reviewed-by's, so I'm not sure which patches changed
and which didn't :(

[1]: https://lore.kernel.org/netdev/aacsQvvOoL29Rvyw@devvm20253.cco0.facebook.com/

