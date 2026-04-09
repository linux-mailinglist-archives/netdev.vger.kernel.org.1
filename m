Return-Path: <netdev+bounces-277049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB2ZHgrG12n6SwgAu9opvQ
	(envelope-from <netdev+bounces-277049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:30:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 724EB3CCB27
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 297363044A7E
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6D53E122D;
	Thu,  9 Apr 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="MOkDm60q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B257F3E1235
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748394; cv=none; b=NMieoghshA07Z/rNwOAk9eQvKiZFUP29pTVtbx5bz5KR6wwc9RjAnccFovLZnhj7E804wRRbbR3GIZgFyCjBvTl4FCqV6sZhgeq2BUP6e4dZgJBd7BVckXg/BY8rG374fWGRQUypalOJHHVJIm8PBJ8wgLiIoPFEPdM8K1sAzQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748394; c=relaxed/simple;
	bh=Vo5BdvgMKNwCv/sgsRcNCPktf/KjsVUtBqlPMGZ3I/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4Zp3Az/iyBjiHc6f9cOgiEUZXlDmEiU8PhSqPHkOy8gNHGZWJB81gCRIs2HT9b/zQtVC3vKHEVxVcQC8VuiqifrEzGYpUoMoV/ZprCN8HK+jmw9TxKuMHHZSgiBf/zhNsy3RpWk7/LxOReuT2hdsRJMedTsqdvV1Y5ZVBuzF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=MOkDm60q; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1273349c56bso1244684c88.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1775748393; x=1776353193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHRoQZNPAYM8bnXSy4YbYk14YDP/fBgqD6/mrZ9ntqM=;
        b=MOkDm60q97mgNfdUgLpbHtDm6YcHujdQCMnEAjPmrtcrcwF/0ChMcHE4Uokqe51nqd
         VR9EYIaEEwTbk3pv1Lrr6+aoGtkx4Jl/vyUffmbWHKSjwFrE6ZIC0+qy3KgwKhiU8c8v
         o01SU95PUoijrTYG5s58nwzHj0IiLebrNJ5uxGxYfiF1Qw9Q0ECAbsRtkbU4f7YiXHqF
         KtW3bD1y3NTocIqYkSNTcNJlBp1kSU6m+GhIe0+76acMP/Uimr2uRvIWj3wISqphgins
         THtUkqUs5v23i0pGBeGb3mQK6NJ9AtUD0SRQO6SRRbJWa6e8b2eJswAXqe4ZVqcY8KKq
         eFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775748393; x=1776353193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHRoQZNPAYM8bnXSy4YbYk14YDP/fBgqD6/mrZ9ntqM=;
        b=PnVXiWzdAwpgwFzQMMVPhWfcw+X1puJehPoXKve2zrJYcXIg4PQwbsmMxuPKMpxTZV
         coVGpnXAT+ah+w3imJQnliMxDeY1Q05Ye7WlQCH+wgiHdiCDUdCnCMPrYHUvbLFWlW6U
         3H6Ia1xSRLKLlR8WGRFtbdZez2POhxRymSr4IzWZzlQtCsv8CMgrtdKHM8XU6yq8SPwZ
         3LJUVf+vZHAoDlD54XzMwzcjo7+3cuXDwxy/ChUf3aTfTgumzMZtTBUxQ4t/fHuGAifY
         8M7Emn5f9bwcLGpv8fHVtD1AC8v0JmpIvs+iv8DPXJIpvZROY7cTjwZomsTnu5ix6z+M
         2bHA==
X-Gm-Message-State: AOJu0Yw+cpUjKgGBvfGBjeIxBQ7WlpulDWY7H2oSsGY8ndsGHWut1U6O
	XI+xZmEKZ5tqtXkONAUV+L6LzqiaLCLR4APQlasJPFksrQc6dYMhbI8mpzfah9Dz6Eo=
X-Gm-Gg: AeBDievXRjzPAUZu95CWDXlL+iKIGXCU04quV7AGickKfCK0VAztpjIujfkiMNF4IwH
	hJdHQ3Fo8G7jpqBSuBaKBWJ08ZnKs6MiUi4BJ3/0pVtnxMRrlHcZdSej3C7ctDM99xj4KV+S80l
	G7aFtTaezPIOOkvdpuofXcJ/cCnIceQs6y+YFj0wJYXsf6vNKzXP5m7vEGPQYjH669pm7kgJfjQ
	2O4Ip0PkqhMvIwqOiFOfA5bY1+maBcahNuv+Ld0nwrt5pR/VVXE+fqPe4VlsNwh7IKAYooYAyo2
	Ha3BOHE334pU7LKCjw7aS4xzbEm5mgfAo1Ru20c65/bojrZaCb+LA7VfkimIuYQIUun0dH97Ky2
	0mxifcObczyweYsw6psX+rGvic3+omx4wKm+977VmRlgIE23Y/gAIK1Gzyb223KK99+1eas6f0z
	R2LBuUgj/H72ACFCFdM32+YuAZHiER717nBIZT9opm3fc7OxWvQYSdIDY7QzRvUvQ/kUhGQbquv
	ocSm+tOo1W5raM/eoEbOokE
X-Received: by 2002:a05:7022:7a4:b0:127:33e0:ea40 with SMTP id a92af1059eb24-12c28bf1e52mr2275147c88.15.1775748392572;
        Thu, 09 Apr 2026 08:26:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::3:da93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c14a371b1sm12471884c88.13.2026.04.09.08.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:26:32 -0700 (PDT)
Message-ID: <244b745a-3c95-48c3-b6c5-11ed3eacdf46@davidwei.uk>
Date: Thu, 9 Apr 2026 08:26:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 14/14] selftests/net: Add queue leasing tests
 with netkit
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260402231031.447597-1-daniel@iogearbox.net>
 <20260402231031.447597-15-daniel@iogearbox.net>
 <20260408162238.16709090@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260408162238.16709090@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-277049-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[davidwei-uk.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,davidwei-uk.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 724EB3CCB27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-08 16:22, Jakub Kicinski wrote:
> On Fri,  3 Apr 2026 01:10:31 +0200 Daniel Borkmann wrote:
>> +    ksft_run(
>> +        [
>> +            test_remove_phys,
>> +            test_double_lease,
>> +            test_virtual_lessor,
>> +            test_phys_lessee,
>> +            test_different_lessors,
>> +            test_queue_out_of_range,
>> +            test_resize_leased,
> 
>> +        # test_destroy must be last because it destroys the netkit devices
>> +        ksft_run(
>> +            [test_iou_zcrx, test_attrs, test_attach_xdp_with_mp, test_destroy],
>> +            args=(cfg,),
>> +        )
>> +    ksft_exit()
> 
> ksft_run() can't be called multiple times.
> 
> The first run looks like it's purely testing netdevsim. So that should
> move to selftests/net. The rest which tests HW should stay here.
> Please also move all the setup inside the test cases.

Sorry, didn't know about multiple ksft_run(). I'll prep the follow up
separately so we can land it soon after 7.1.

