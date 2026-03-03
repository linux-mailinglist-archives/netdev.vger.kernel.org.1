Return-Path: <netdev+bounces-262980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGr4BO47pmmpMwAAu9opvQ
	(envelope-from <netdev+bounces-262980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:39:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E23B1E7C31
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47EB430333E2
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 01:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE8B5474F;
	Tue,  3 Mar 2026 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="LAsn0EeH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B2B373C07
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772501987; cv=none; b=pwzkmLJiPVPhlZ/spyilUheOpqAE4SpkRYHRyoFbwN/RwKzvuFUdL+yBi5ZIq9a/RIckyXJKONWnduKtKnioEs4cgdweDRU6S1u+/RWyFd/UTOFJNYFh0HQsCWJrjS2EAEx4GkCDA4TCXvR1J05nosVxxhVvsGr36UZoxw5Ht4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772501987; c=relaxed/simple;
	bh=07/B/y6z/C1XZtHDENUbpuRm2gMOyQUCSFWgbN3Qaeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7zhnXRlogDZvCufLadTW1y+NFrx7H5vWOlGqqI46SJAqk5JfumaTHotQVa9FSyr795ouNvFTrHtt02DKmmtG7o4I4YNNWrc/t+vYYR9vox59psFDloJzmYP8aWLZaDwDqmIiwi6rO1DZRJAir1oaCS8bGkHIK3dwRWoC7J6qR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=LAsn0EeH; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a0b376fedso719496d6.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 17:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772501985; x=1773106785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPbZzuRu+dosfK2R7jpOlV1O8wbpx/a0Ic255VXuhAw=;
        b=LAsn0EeHSlqVmURyxWAjTLITLYmvdOhgO3Lrw3netcUSV2yvq2UbL5wzxzV7CSlYjX
         YoyLu9ZR5htKTCZztPuRdgqNrOFMVy3IoQZ1kRDvGr7x2DO+IczAXOgqdkdfWbMcBXuS
         LaONTfB9+tgD28gFI6IaTvgpwHMDFSbcvIBE/wpaS+vlr+PhDUoevWCd/VY1RRogEMKx
         klugydNlQczpWuZJGVkibtN1BOXSVD0FAv5x3HAMVyjZPo2JiMBHd689xsu0o+WZFukZ
         OgOg3x6kVUXrTt63UgRj4w2WBoHApHf24oPwn5cEgtJpoEMH5DR0xwlVNuRHCuAsVN9b
         gxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772501985; x=1773106785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPbZzuRu+dosfK2R7jpOlV1O8wbpx/a0Ic255VXuhAw=;
        b=rLrEkrgPPkZuac2+cwBXS1Xw5keiREV14QFE/IaH6t86+njQYwpBD6TTsyLtGo8xfd
         fCXblw5H2blPz/+JC0T+tBKWq5SJcNPJm/owZKM75XQyh4mZ8753obaNW9ClsKsg/j4c
         619Y7XNUH09/yITvSb3+ZTELjBY1WX/qESnTJv1wMISfSrtNqQrdpfIeCtUOY3rXMruv
         g3Cq0InGAkYVvgatR5Jo4pxVTFHm8eWQln7PTk67ZW377dFsgnsyGfTeOUWeDVbDP7y0
         5KUDzCQ/GabjH0rPRObik8jupzR+cfHGbR2lZB7AayfKtC0SVWOl3itnk1LsFO839YW+
         rxzg==
X-Forwarded-Encrypted: i=1; AJvYcCV2698iCA9Z0cQlM5k3NiORkeyDMp9jU/7mH8YTeVs+onY0x/I6g4jMGc5cRMVXB2D/rqwXnok=@vger.kernel.org
X-Gm-Message-State: AOJu0YywqVsvWFQNqeOZWDPgfgqNyAD6bNK56hJA2ruv4zZiaT/KT0Tt
	gWGtulxzwq98+B9A7bQ3TXFR20SCMd9YzB5dpRhaQTsHj6Wwr19V+C7FO+FTB0U95t9tP46JI/1
	0T4RZtPg=
X-Gm-Gg: ATEYQzy3ezccVnc/AYEw5eJ37HFLjkFuIP/qxZERHHFGoHa+8mcDX8evuixPDO7pfIa
	03SE+qg6/PFF7EXKZ+b+3ChonGjyxLI6TPcN4/uQfTlHBR9OTHzss+HNPL5ce0phOWgW0sBCrNy
	8Y61Xydm/75X+O7QQyOHDx+jd2gtoSTT85xz5eyrYKsh8C9GFGjcfSShoSZBychLm/tTL0mwdG8
	+bkBEb5blF+bxtTBX5+Zb3L5Y+/vQnZOuPOvqX24tVMqVngBT2UCdzwx41T0yJgIsmWTmrdNVUA
	OcoCFqWEK8umoc7pqgFFiSHLnhgUz4np72bIn6ICXRt7pfSMl34GIioifvB8LOoKhahNtdP6SeL
	v8BMk1T2fJbl3xWt5xErFJvv6M6+n9OQ3qTocqmDtfI1+50/Yw3P4YlqTRzT1O4Irf4x/LT7qtS
	85vjJCYJV22TVI1T29B0pN3gxfqO3FCnhjW9/6obGj4NdK7TzTjiaVj+dsFG7RjH7NJT5pGsNXt
	LE/
X-Received: by 2002:a05:6214:2121:b0:89a:df:164 with SMTP id 6a1803df08f44-89a00df0411mr54969726d6.39.1772501984767;
        Mon, 02 Mar 2026 17:39:44 -0800 (PST)
Received: from [192.168.86.87] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7374dd7sm121117826d6.32.2026.03.02.17.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 17:39:44 -0800 (PST)
Message-ID: <e5c356f5-2be7-4d24-aa2f-f9d312b7a2c6@davidwei.uk>
Date: Mon, 2 Mar 2026 17:39:39 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] selftests: drv-net: iou-zcrx: wait for
 memory provider cleanup
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jdamato@fastly.com, asml.silence@gmail.com, io-uring@vger.kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20260227171305.2848240-1-kuba@kernel.org>
 <20260227171305.2848240-2-kuba@kernel.org>
 <8489fcbf-ab76-48a9-a21f-d7f6873b9a2f@davidwei.uk>
 <20260302164642.43375391@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260302164642.43375391@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7E23B1E7C31
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,fastly.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262980-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 2026-03-02 16:46, Jakub Kicinski wrote:
> On Mon, 2 Mar 2026 07:49:01 -0800 David Wei wrote:
>>> +def mp_clear_wait(cfg):
>>> +    """Wait for io_uring memory providers to clear from all device queues."""
>>> +    deadline = time.time() + 5
>>
>> This is potentially a very long time to wait if code is buggy, as I
>> found out when debugging netkit queue lease. How about reducing this to
>> say 1 second?
> 
> Just to be clear -- you're saying that 5 seconds is a long time to wait?
> Please note that if this wait times out we're going to fail the test,
> the timeout does not impact the length of a successful run.
> 
> I picked 5 sec because with all the debugs enabled and under QEMU
> scheduling latency spikes can be pretty brutal. I guess I could make it
> 3 seconds if it matters a lot?

Hmm, yeah let's leave it at 5 then. Should not be optimising for my
buggy code.

