Return-Path: <netdev+bounces-303706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wKqMCBUpRWoe8AoAu9opvQ
	(envelope-from <netdev+bounces-303706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:49:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D36EEF99
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:49:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CbQk3WMG;
	dkim=pass header.d=redhat.com header.s=google header.b=k4rqM0dd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303706-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303706-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F98830E4FA5
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B1034CFD0;
	Wed,  1 Jul 2026 14:38:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022B2DF144
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 14:38:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916722; cv=none; b=d2uxVLHGEPR/tV4snjXT0WQicWnvWuexaQE56Tuf6ElppK6zuODQBcz3xGjbwAMgUyRjAweCOlNjtaVvBPv3wtzog4UsRJE0+8YfdIjHCIMCcajSidSjIbhQ9oo5PY/dPurzF5fLOP1Q2s1YOm08n20D+BCOAPcdVy6ELmBQm0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916722; c=relaxed/simple;
	bh=0YFYU1MJWgulitatJBeBn60XcAHqgrtmFbtauSxwcf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kzm0AjZdGMbXRxnAf4ZBpOmqV3Z9GRt84Y83BqPRLwhFAxJJ4T/pvExZChsInztec4nJGwYWcalDFbyUOLQe8rXFMu2h8O3wqWXLVRY5G8p8Vp08rbrR7BLcOIaJa+0XPbocqEMO9xs6QpC9yeP6StgLxSGsEnXnHqt5DVKjoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbQk3WMG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k4rqM0dd; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782916719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrdNneIgH6yMJu9p2N3FIGNVTXTUUQ5T56Karm+HK5Y=;
	b=CbQk3WMGy3KKHXnnHTUYu35e87ZjLocNX/fVBif7kiAMnmHXkO64L8r/OiwmfbDCC8zPdM
	3GLAvE9aJjJLIL9NdlbPy+USAAIMuoAVDwyJrvCVSMsGQghPmJy+PyR7+QfDSgXsNkAFiq
	4NC6pOw+pmniCc2H8cW+0yOSJNhXinI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-O21lHADiPOO3gP3BWEMkWQ-1; Wed, 01 Jul 2026 10:38:37 -0400
X-MC-Unique: O21lHADiPOO3gP3BWEMkWQ-1
X-Mimecast-MFC-AGG-ID: O21lHADiPOO3gP3BWEMkWQ_1782916717
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493bc2b376fso4322115e9.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782916716; x=1783521516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrdNneIgH6yMJu9p2N3FIGNVTXTUUQ5T56Karm+HK5Y=;
        b=k4rqM0ddJoE2CdEZZ4l7/DDrUt3iuKPORA/TztLaBVZ1vX1O0ETeQ0LJIO8/AoiCS/
         lFuJJMGKRe95Et4rKFmtnqUVj7vH7MhPyt937PzArsD44iV5QGHqhgSOjHjdysuksfcJ
         gz4i+yzULCLrEeLS8lkHS0Wi9KJ9IGwXQ3fSly7UuBEIk0RO+uE6ViWIpI9EbIYfzepz
         kKJ84kOrI5bo1KepoespJwMocC8iknOtcVBVrLll5KkNoir0uADBMy3aJq/9A0rlMe59
         7xnntih1JLKB/7qBgt2mq2hjB0MZTg5FBmmO4kmAO/xc0+o7rXn5C3klMn/pK7fG6znr
         1hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916716; x=1783521516;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrdNneIgH6yMJu9p2N3FIGNVTXTUUQ5T56Karm+HK5Y=;
        b=s3F2MiZ9awtp9vJR5YndFfyHIb11VBmDF6tI3fsTIA0D6v5inSYDFogUQVF/nZVDle
         QMyw4TbIgwrpgOnttZwEK0gVUSRe5QQ4LHOppJPsHbPkQr6+gvZGj7/rorzDgrJRN6Hi
         HkR3czqtk6od7LNqR0wKFQ+Kwt3pEPfMP/KZj2qk7L4LXEEfiKmH4oqn64YJJc1jZIQZ
         oxTqsLJvQDlGYAfo3ttOP9GvRmmWUT3/YqetN+UpaFlOpqqzUxEgJu23+o21rShIZC9T
         VYFa11sqsYn0yyFPQSqWxq0RLp00GQVi5JY3ZzDfpKTP4FduEHlaZkIh8q5Tyxll5pBG
         Itjg==
X-Forwarded-Encrypted: i=1; AFNElJ9EalSNfiwJMhWjHjaX+0I7iP4Ld6ItsCtTSU8836RWe2eHREkbcOvzfnU0p4sOJkvFBNvwthY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJi11TOw1qdGsPSNpy0Ncbi6P6POOZNuerANLvd69Rxws/ala
	v8J+5DhbrjlvdeLZVVG6S5bEvaow33jL1gMhrBj573LRPTD1+owmaEb5Y7lzg8yUnCQ2DrqEWFu
	SCb/pzGOyYxUKy3Fz9/sVOMeXxilJkR7rEBtFl64XkTqznVkaTxivT5AQZA==
X-Gm-Gg: AfdE7clSCVCj+4xd0elqBHXKitFFrnl+yO7yL6+JUGsGLxD7BjDlQUWki4I8/sdWl6b
	NI7Ax/ecOsyl2PHXEzIWPPTCp5S86sSjB3U8XcbjrOMUJKMAT+LfQerE6yIv0LF4aEaVhFrdkOy
	AfKoTDnapvmbTujdl4YT2LObcHqDiRqpJ5OvEiyP5WthZT8GijvyDetOlPFolYM9v6fHum9t85u
	kq+TiFqv1ufYvvWf2t91jOJMpwavv3NTvZGxJVkF6FKGyYfseYekCC1ONWoCStzvg7AvEQyLW0T
	JbNiczYPB0u+ve8nhKYKqahRyQgzMveBJBYTBlHFfQxC0kRHhVMGIlsPzOkMUvjYcoAPna4SZcb
	GnpXbNN/yjTOaC6l/ovuJMoRr2HYtmrogcPJFbuybphriB5FwiptTUFJxWrIEVEbsj628sKByQr
	5Y7lYy/z9nJg==
X-Received: by 2002:a05:600c:5247:b0:493:c378:18b3 with SMTP id 5b1f17b1804b1-493c37818b6mr22702825e9.32.1782916716599;
        Wed, 01 Jul 2026 07:38:36 -0700 (PDT)
X-Received: by 2002:a05:600c:5247:b0:493:c378:18b3 with SMTP id 5b1f17b1804b1-493c37818b6mr22702395e9.32.1782916716226;
        Wed, 01 Jul 2026 07:38:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4540aesm81733665e9.0.2026.07.01.07.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 07:38:35 -0700 (PDT)
Message-ID: <8138f145-6a4d-465e-a45c-b8ffbf9e05bc@redhat.com>
Date: Wed, 1 Jul 2026 16:38:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: HWS, fix matcher leak on resize target
 setup failure
To: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kliteyn@nvidia.com, vdogaru@nvidia.com, horms@kernel.org,
 kees@kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, zilin@seu.edu.cn, Dawei Feng <dawei.feng@seu.edu.cn>
References: <20260629064049.3852759-1-dawei.feng@seu.edu.cn>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260629064049.3852759-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303706-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kliteyn@nvidia.com,m:vdogaru@nvidia.com,m:horms@kernel.org,m:kees@kernel.org,m:stable@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:dawei.feng@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 734D36EEF99

On 6/29/26 8:40 AM, Dawei Feng wrote:
> hws_bwc_matcher_move() allocates a replacement matcher before setting it
> as the resize target. If mlx5hws_matcher_resize_set_target() fails, the
> replacement matcher is not attached anywhere and is leaked.
> 
> Fix the leak by destroying the replacement matcher before returning from
> the resize-target failure path.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1.1.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have a
> mlx5 HWS-capable device to test with, no runtime testing was able to be
> performed.
> 
> Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

@nvidia team, double checking I did not miss any relevant communication.
The last process update I recall is that one of the people listed in
maintainer file will ack patches for us to merge directly into the
net/net-next trees.

Should we consider any ack from @nvidia sufficient to take over?

Thanks,

Paolo


