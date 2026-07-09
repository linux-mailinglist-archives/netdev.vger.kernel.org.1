Return-Path: <netdev+bounces-306232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ByJ8NKWnT2pFlwIAu9opvQ
	(envelope-from <netdev+bounces-306232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:52:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AA7731CC1
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:52:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=L7AP56Uf;
	dkim=pass header.d=redhat.com header.s=google header.b=B4IRzah2;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306232-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306232-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F7D3317616B
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA662EC09B;
	Thu,  9 Jul 2026 13:40:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E920B2F7462
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 13:40:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604458; cv=none; b=IX0VBqzZ3DDcgUbjFfLB/ExK9s80U/3823kbXRUA33wihYMqjBPPU+QlFZup61bNmZQ2I5UYimg+adABCg8nzQ2XQEReGmBmbCO/dOCRGfnC6JSVdpVABFpgoTSS1jfqhU7blMCpDynqq1cBc6U/tLYZac+pYAhge3GqP/ER72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604458; c=relaxed/simple;
	bh=CTwd3m3EU5RyubZ4hrQ78npbfiB/tzFKuCO2g5RcURc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FssQZ6Ij8GgYOTXJd4S79lqtSYP3BlPD1CltUoxZcbx5tGsnP6eA5iSVIbcBlSxjcFUYWCL1PNXN8xfMqZV2TTZXxZkQZzu+snUJtPaVyo9S3BDewMQiu4TxNGhgJaMl8lz8lpVWy4v417Ensr76VLKXkjgMA4YScO4dxLvCWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7AP56Uf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4IRzah2; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783604454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XoiO9fU/3IeaFYHV1LTxt3vPWdnCcjD+/AsfyGvDib4=;
	b=L7AP56Uf7/i+930ti7oj1+wX7AIfWpbPvnCu4qQs80bt76VF3PQwqhxVS4unvZM4A3W7lA
	rEYojRhhAOXVMY2wCWOXjjnE3MAGWtsoO6cql6IDfdHEOiVy6BpRTUZgc8DOtydWrnretT
	ubXHC7vmbQufKqK9DsTXwWlwWa6s39E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-8SQVeGq5NiWJgnKYrpS5Zw-1; Thu, 09 Jul 2026 09:40:53 -0400
X-MC-Unique: 8SQVeGq5NiWJgnKYrpS5Zw-1
X-Mimecast-MFC-AGG-ID: 8SQVeGq5NiWJgnKYrpS5Zw_1783604452
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493c55d5ce5so11650465e9.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783604452; x=1784209252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XoiO9fU/3IeaFYHV1LTxt3vPWdnCcjD+/AsfyGvDib4=;
        b=B4IRzah2aO2gS+5qnFUnQRJCBsLdu0HvcT56JQmcglcumGV9Xw0O6u3VNH8PGw9E90
         ez6d64FO/wWGGO+GI+p9WWCNRchVE9tfzJ+Mt3dUSx2Mbihtp6BsC8Fg1ubanx0D2mK+
         hR2JGKcm1OtLhCW7q18tCJ/MRVq5HSl3OuJ+Jjpx5yURs45BiLoMLq5gtQ/l4uZE6aef
         gqAgN4+3nXMgQsR8Ldp4iyCxJ4wsLPUaQuc9hE5edMkXOKBFDTTSE42x/ZA+dh58ehT3
         U+4fdpThf+fLJhm/kGT1/sbnDmhgi8Xe2Pwk/q2EqDfp9mIvklNv+S9/UXqtTgNMGf1A
         Wnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604452; x=1784209252;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XoiO9fU/3IeaFYHV1LTxt3vPWdnCcjD+/AsfyGvDib4=;
        b=pkP7UuImtKuahmnE/3eyK7B1CEmoIBiPWF6IM9yE524yTe1BP6HkuSi1MFb2UKoD+b
         bx33zKWzgfndwmVU64m4S7miacBrYqBHxs2KCPFQ6s2PljPipASmZOiSfO3QqV/koxMo
         hw7qs9H7RO9OQIzU2gjZGxJYzHkqIkpxZ7n3vGSBX9BSIkUYA/GJcnrf6pOaM/c3/w4g
         3ucxdReU+y3uAOh8v9m8qv/toNrwH1Q0DyDWbruGQSky+d8m3L4Mqxxym1I2/jLGBk6i
         jcFeSIa8O6J4+2uOxSxL5VjSPwQlzZ7A6a6IMB7HcfppR+jJ1dUHG93/56tbqsGPUaVq
         QEMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDJDOamiaVHrQfJJFQR5xSjMpwyNcymKSgpCTmpnTr58tObDLeDRpjzj2J50cz+F9G1bZwIUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRuSrf1iyJDjj63AZNOZR/r9NJJ62F+tJvR2RbsOvT+nQl88zW
	Sn00LBq+ThSJ8jV+ruHNuUuBmDJMFUkOCbiWB0CsGT1pThxXiQreUXHwHUve4k3SHQ9nXg1UWMl
	12gDmCz7g4Z1y9QqL70392DgwBhJkuDm72wwKBRNq0/t+cfv9ByKha+Az8g==
X-Gm-Gg: AfdE7cmTA1mCO7m4JzaGGc4vzncUXGEGBS8nyvCOtAzqNDG0bEwcD6onKCY6qeAPi5L
	+DcLc4ZcJsJNYyb5p4qbnMD+U2le9HPSSIn+3lUBcwMY/7hcKmzR3TW1alUgW3S7Gw60XOo0CT/
	OkbqAhSQUvuSswsr1go2EQG1YSR0n/1LiQRbGDwZuWyCYAYgAjGZd1lzpsZKD5agf6E7H+BkvNE
	EnDHrsMzbWqJjky9iQ45aWHvwoMwQcWQTUsAthWW9VgEbHutqjNAy1sj2BwAiX0VYQV2uGWJw/z
	Tduh4NCzmJDvWQG4hoDDDE1hzN053VBOeMsodxINg2sUpEijTeR8m3gIWmsbEXpVwQC90Amu+Ge
	mOUlnLeBUUSLL3wcMC2HegVnwIOyV9PdPjr3BNfXLV/4ZJXj4OkfAL+AP4ATSi8MLdA++VEBp9N
	wK1+vAcfDHSrWv
X-Received: by 2002:a05:600c:1554:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-493e6859938mr74190465e9.4.1783604451884;
        Thu, 09 Jul 2026 06:40:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1554:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-493e6859938mr74189985e9.4.1783604451263;
        Thu, 09 Jul 2026 06:40:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb66beddsm70856255e9.0.2026.07.09.06.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 06:40:50 -0700 (PDT)
Message-ID: <ec4db4e8-ce1f-4a08-b400-f4e507befb0d@redhat.com>
Date: Thu, 9 Jul 2026 15:40:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] wireless-2026-07-09
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
References: <20260709115038.243870-3-johannes@sipsolutions.net>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260709115038.243870-3-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306232-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22AA7731CC1

On 7/9/26 1:49 PM, Johannes Berg wrote:
> Sorry, I meant to send this yesterday, hoping it'd get
> in/out before netdevconf and all that, because it's
> actually really big. Mostly I've now collected many
> random LLM-induced robustness fixes (I can't really
> call most of them security fixes, though there likely
> are a few).
> 
> Please pull and let us know if there's any problem.
I'm sorry I was already finalizing the rc3 net PR (which is already
quite big). I think it's not bad if this one lands in afterwards.

/P


