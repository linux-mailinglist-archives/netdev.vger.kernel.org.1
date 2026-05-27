Return-Path: <netdev+bounces-292327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KND3FLYEF2qK1QcAu9opvQ
	(envelope-from <netdev+bounces-292327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:50:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E597B5E6316
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25AFF303D116
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0164836D51E;
	Wed, 27 May 2026 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/Rklsa3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47300364950
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893230; cv=none; b=JJ7tc+ONF7La0NVTsKNvZj9r3RMRLmH9H548fnAcS73v+WdCeY9K8pTSFT2vAWG9j4HI+ls+Q9E7sNvAiJI4hfz+a+Xbyz5sKasEi/mTR/zgRYFcrcDQaxgrzDpdYqyQ1ooaj3o4FgCMsdoRlrnmb5pbLGptbbiMUDSUhzBhnUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893230; c=relaxed/simple;
	bh=RQv2v3GrtyPH1P3jo+Fvi9hLCNkYsZV4mlez82tXnqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heOJDA8qe2gbSfSmdi9zuLxeVmqVtskTE4HZ9CLK93eBgy2rRJrOAmVvTAzRkUWfjQTl9v2TVcA+zmLR7tg1MpcONveaoTOmQ1XYJIqb6DR6fP2elcNvfbXfaz+3EOHudt/FHAluL2AGcD0WE9NZJ66V22tF7OS6StlAdoXtOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/Rklsa3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba17c8cfacso123576875ad.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779893228; x=1780498028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQv2v3GrtyPH1P3jo+Fvi9hLCNkYsZV4mlez82tXnqU=;
        b=K/Rklsa3boOzEkEY0psrb4Irr1v+nqy0uwraxezDBoPTZymMGdreF2kRiKavyR4JM/
         NdVkrQsgUROSMK2d9sacqmM744lK0sOkeUlnzGam0cIjfP7WjRjQlDoV4oo/vPXBa6R/
         bs2G/5FcGVgDImvJRK67Z+LPtyAj4/Yv3kcV1fs7yqubjEyZJyumhrXBWUdcty1mDtHr
         AWfTJEfzPZ1X9jb95kOWpJW8AzdnD23wFOfWj2q3Vhq2RyGM2CAsLpf/ltGBQ/ytAkaB
         JICVjLcYXaD3Q3ENVFqwA8V/PAFV3Qroa7WMxKZGPCfuNQevv3qvRVlnHG6/mStaIRDu
         Gmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779893228; x=1780498028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQv2v3GrtyPH1P3jo+Fvi9hLCNkYsZV4mlez82tXnqU=;
        b=RJt7tw8FP/rAYdDCkr/i5PysEV5SsQw03b2xOy/ldKpLdW9HTsKh8yD6h18342RHMX
         d4TA2/BMF+rxIHgUqmb9BJmZmOB3+C8LqAnpuiXc2SuSJaAEcFzH0grz4+r5+pTdXfLm
         4uQgnngeUDkdqnSVtOG7Xd45AfHZ726aNKYd0CvCrcHQ2/YxhTotaxpHwvGnix0lm6S7
         O9F9m9p13BDHP11wbTmcqLpGZGkUAaannc2u2Ji8lNicjpPC2qzMIoqjkBN5NRhJf0Ug
         i9iiy5cXjmI+ufyxkg+h/ADiKZHKEORu0RcLETOiUBiYTXkRtocvAp6SmmJnswxh5Chg
         tbYQ==
X-Forwarded-Encrypted: i=1; AFNElJ96FNmhoyBqpUiVYBuKM1DI/K0TphMWoOJ3b27LkcD+RamRLWYKGL2Jwe2sv2DpfUcMjqKSxU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/T3EalXJTduJNV1lozO4Vnn/STTOoh5VVBM4Ik+QpDilnhwE
	XhUl1Q9kCMkA3h8CCH2bRdayynvCpCbvWrlxlHuT2R3YTTCMhb1MesoM
X-Gm-Gg: Acq92OFLTmruuqGQdrHWu09g+TDqyTCYcl5+TAAvu1NANEQ9m6CHTszkq0OYTShk3vX
	kwURXTc5rMmfH1vh7Pqsqp0gO52VtrB86NgL0T/u6DEt14HmGxKKrGZoT0z7IVJK2cEoyDT8nWU
	SZnM1I2Hs26fYkELt5ZJK3CZ0pED88ZFghPiBDIK3xOg4J+tQKtCLjCodbfPiGFmP/gn3GP6gw/
	mCOgKVaZ95i6P8ZNcaAy8GtZW4MwWZXtBNphzbCF4knncsbhQJ0114O1ozUTQ9tdzTzLQfl8vLn
	DY5NgCwByGk3HQUFe4oEC6dAcHnbK7XfRvT5YDv/w9zPZVSvy4/CoqKrv4cgO1Ot74cV9zy3Mby
	jBSx1iNfPlK5asnYOlo9AVS9sNoF+T6TfHALXJU2NVCZJFaCQbJoTcVVyqqa2DMxlmz2bAb0pdI
	lrra1oS2Gx/Sm4XI3MSGbwbQ==
X-Received: by 2002:a17:903:3c63:b0:2ba:85:5827 with SMTP id d9443c01a7336-2beb05ff545mr297392925ad.26.1779893227497;
        Wed, 27 May 2026 07:47:07 -0700 (PDT)
Received: from john-p8 ([98.97.42.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58fd888sm161317245ad.73.2026.05.27.07.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:47:06 -0700 (PDT)
Date: Wed, 27 May 2026 07:47:04 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev, 
	daniel@iogearbox.net, sdf@fomichev.me, ast@kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	xuyq21@lenovo.com
Subject: Re: [PATCH net 1/1] bpf: sockmap: fix tail fragment offset in
 bpf_msg_push_data
Message-ID: <ahcD0MqTSelmtDEl@john-p8>
References: <cover.1779636774.git.xuyq21@lenovo.com>
 <8b129d10566aa3eb43f61a8f9757bcf51707d324.1779636774.git.xuyq21@lenovo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8b129d10566aa3eb43f61a8f9757bcf51707d324.1779636774.git.xuyq21@lenovo.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292327-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,fomichev.me,kernel.org,gmail.com,lzu.edu.cn,lenovo.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lenovo.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E597B5E6316
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 11:48:15AM +0800, Ren Wei wrote:
>From: Yuqi Xu <xuyq21@lenovo.com>
>
>When bpf_msg_push_data() inserts data in the middle of a scatterlist
>entry, it splits the original entry into a left fragment and a right
>fragment.
>
>The right fragment offset is page-local, but the code advances it with
>`start`, which is the message-global insertion point. For inserts into a
>non-first SG entry, this over-advances the offset and leaves the split
>layout inconsistent.
>
>Advance the right fragment offset by the fragment-local delta,
>`start - offset`, which matches the length removed from the front of the
>original entry.
>
>Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
>Cc: stable@kernel.org
>Reported-by: Yuan Tan <yuantan098@gmail.com>
>Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
>Reported-by: Xin Liu <bird@lzu.edu.cn>
>Assisted-by: Codex:GPT-5.4
>Signed-off-by: Yuqi Xu <xuyq21@lenovo.com>
>Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>---
> net/core/filter.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.

eviewed-by: John Fastabend <john.fastabend@gmail.com>

