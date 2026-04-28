Return-Path: <netdev+bounces-281873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPF5IrW78GmFXwEAu9opvQ
	(envelope-from <netdev+bounces-281873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:52:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD134864B8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BAB73318A77
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E3143D50E;
	Tue, 28 Apr 2026 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="PRCN4Asy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5E43CEF2
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382002; cv=none; b=qsG5Xd6PCNR2nig4hkTXnQd9rx5zg4p25tVCLVCDmmH1ahj+xpa+Z/1cSpmsvfON5w8fHLF3c80DoxoWh4oyT9G+knE26+2F4RDocrupk55TUDnPF8Vh3aO90T0cD1iv1IdtomKUO9nWvJu3yKLxZpJXG7ayb7PVPUuaBchS8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382002; c=relaxed/simple;
	bh=i8j1qMVhIXUx5kMKDn52NX7A8T+N9YdbIRflE/XS4ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oz1YJKTEZo4QJaJamqIDDBqK++ETSgxylJDr0O/ZP9JpMJlvCdIagYpTiIVAFSpRgMZEp6RacdMKtpjuBizlc+Ka/FL+6Jr8VlO3E6sf9UItgm64ZXRDhpLNjVQACuo92pGHLyWo3I6RdmOjooplldqQWH2uAISctwlnP+VHnnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=PRCN4Asy; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so6557171fac.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777382000; x=1777986800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXCJaGrSLaKv4YGTnclIICROVVbO2+Gp+8vAxfV2kjA=;
        b=PRCN4AsyrPVd4gJ0igOMdRozu54POT/lVX0UTurBDibGq1cMxVxn0z7qF37kF03t0R
         WNnKxL7VWxcK6uTzT0iYX7Qec1MoEEkD+/j3/UgRMddkZ2Dbo3rtI+gw2lXR7B4zpEt2
         I+/MhNKS+X4GW4WGhw7MEiYdUtQb8lYDfadpr+JLYIntZ7j8DTXtAZqhRpiFykwvOkZq
         mFiNjcN91DUXWQ1KV9CEN//A9MJ854r2bY69Qi/mQndIBaEPXX+co8nJQETAObsBpFCp
         HTbAXmQbrhhixwpQbxMmMcgsoOSksBVdDOqYtREaYDctZAaiajUFC+2F81ktAdr4VQC1
         Yq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382000; x=1777986800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXCJaGrSLaKv4YGTnclIICROVVbO2+Gp+8vAxfV2kjA=;
        b=Y3KcFzLiNLO/fogzpgfpZR5pB/kDqSODWl0khClPVQgbba8GN03DLp1EZFxCSZuOMu
         Kf6wJ28a/5xJQRVdh0Gdpg1IkeL7Lr9wW/03AyoK02IsfIqX+500ZCMUd45yGizFtzre
         gdmER8LlLpiw2Oz3jArQSHJEdSZDW0Iqj7kDR4Kpm9NIiZhJrI+z8WdOlfkzW3RKcD2j
         5sHZNF9azCV9SpEJ0SY0sHrrKgvAS8Wh2aPy9CiI7RKkW5XHDII3ab7A4kKu6lIio1nf
         gJ78YfSLH8xZBWuyEPPknCxJt1ikEzS9OfaT0sDyDJMANX9vGQXfaqu2QY5YEmsfQLQD
         Qdkg==
X-Gm-Message-State: AOJu0YynrGdOSf48tEWpiZJOVKUki6/mudAGPEYkn7SwTtchb+uUlvAb
	t4ynKuumzjhtuLBRJ7kDfbQh8O3WIOxRFL5OlyBcww2DxRHekiBKx4yj/Q18bSYBTx4=
X-Gm-Gg: AeBDieu5bGMFYyRADKZSM4/T82DWIPuwFZLTN74EfIy7exvQf0NsvFUD/3hdvcl8y8g
	Pe5CxnGZxnWjpljEolirHVoak2So56sp4skftCmfGcEm22iZKaX7P9e1B8O4PJZgAzax7wlgOoR
	/NkF+3u4cSH5hlZhN2a7GwI6xhb6nP8A1E9WMyUVR8wnE0y4rRbpFXeXTyUzV0zl8S6m2yliiI0
	BRSMxqTj1XtsylATOK5WehluYLbGAEAFe1XUAZ2Xa6sixP3zx79Dgiby7+l0S+dGzd5GADKltCG
	F8vIpFxAPgBxn7dpecavltFGEknQGxKepOmaosPANgszkrDDRiEqoh0JL5TpLQMEbN/EsdgTLVw
	HQy0nr7bNk0mE0+NY7pdzEuyPzRSY0IF4Hw3igABPFYY8JkudFsoibgobYpcTJJdbCuDuECq8rE
	ldYhwTMqsQrucTbyL+Dnf/+13liDQL1HpNVEqeWTxFZIgzM9H4jVzMJTT3i8b0tYLhK8DvMkXKB
	0qa+ocI40u1xGAA9gsT42cmYMgDeA==
X-Received: by 2002:a05:6871:3325:b0:42c:6ea:3227 with SMTP id 586e51a60fabf-433f3a15ce3mr1521884fac.19.1777381999703;
        Tue, 28 Apr 2026 06:13:19 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-433ef7d122esm1903865fac.0.2026.04.28.06.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:13:19 -0700 (PDT)
Message-ID: <af21e72d-d4db-4fc1-84d1-e374884ff919@kernel.dk>
Date: Tue, 28 Apr 2026 07:13:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: add net_iov_init() and use it to initialize
 ->page_type
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, asml.silence@gmail.com,
 almasrymina@google.com, sdf@fomichev.me, hawk@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vbabka@kernel.org,
 io-uring@vger.kernel.org
References: <20260428025320.853452-1-kuba@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260428025320.853452-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0FD134864B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281873-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,fomichev.me,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel-dk.20251104.gappssmtp.com:dkim,kernel.dk:mid,kernel.dk:email]

On 4/27/26 8:53 PM, Jakub Kicinski wrote:
> Commit db359fccf212 ("mm: introduce a new page type for page pool in
> page type") added a page_type field to struct net_iov at the same
> offset as struct page::page_type, so that page_pool_set_pp_info() can
> call __SetPageNetpp() uniformly on both pages and net_iovs.

Thanks for catching that, that's an oversight in the offending commit.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

