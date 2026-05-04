Return-Path: <netdev+bounces-283806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N16DYKG+GkZwQIAu9opvQ
	(envelope-from <netdev+bounces-283806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:44:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCA14BC925
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29964300D155
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366663BE652;
	Mon,  4 May 2026 11:43:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E13BE156
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777895039; cv=none; b=CcwSy+Rkgk4/N2T0bUaD0c57kkDEy5+80YZtTulS9DaTIOOQ6bdTpQDkxfOcyaIggPMeuUFrJhcjzsUKXlnhEriv/phAZRSOaYyOgvqmcXKFMPnQlM2O2M0Uv9IA4yA2jcOsXnrLTz1Wdt+A4tViH/7cs5xuuA+VNyRej0MMHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777895039; c=relaxed/simple;
	bh=U4v0yuUMAoIUSHI2ykoTdV0jHk2IFugqerjA+IE84LY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PPwGNn5D9mzr3l4SQ4d/uDHqZBH/r8gGjvyDOclVtbRH+LF2Ky5/93yVjFp54t0N2l9g2dNIcEIPwzc1mNl2Qfm88WZV0aAE+nqO/M1FBEHacz3sAwLnEjme2XCYMMzKaMcpwcGitVy6skes0HRq8nz5Zhpzto5jD21hCRtuK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so6291663a12.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 04:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777895036; x=1778499836;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BitYDc02mGdPLY7bb6uXCKEorSlQeFQtVxt67RJQ/v0=;
        b=LCSs0mHzRRZdycSHPGucTjYugcPEmIfObSEuefpocLFlB5/+UMom3ZKF93p3J4LzwR
         RWIJg4Mpeqa6X7a91KECY+DljBf6EpXUfJgS0MItqlsMIUgDucu3IszlGR52FlKC2x9G
         xnoYKfwTUSIPqVKmkuppnGA2Q7puPgJztDbutxEq5fQ2jOfHW2+Du8mW324/0CY/LxCj
         ue+TDcw1VFVNjkwOstoWKDK0DHa3Bey8p5OoQ2UEZ4oUljVoawOnQhri9Cnkf4d7wzIV
         9b+1visQghVibDiOJEtlY95M4uJ4gMfHnfnKgJIAhZ38djhdXIpkicWwbtdJ9h+D3mt5
         fPqA==
X-Gm-Message-State: AOJu0Yws7xXNrx6h63/alLuOrb1HjhIrv9NPTlgn92PUrsKaW3EdlL6A
	SWsWr0n0DuVMFc4DoF5nQ8ik5E0A8rxbtieY2wTGlskBF2A4z1uMPPshdbXYyAoj
X-Gm-Gg: AeBDieuc/Yqk6xILcqyR+MtedhhvIcYgdXo599fr7kn1GGQrE8shhV7Xc9+6FkHCYdq
	FPMpLSWn1PdF/9Tij7jjg9AFjFoftTo2IZWT66NkX2CtP/tcB7rZei8fGwpZBkkGyJ/nVZpIZny
	d9i1zY39PKc3Hqrtb/WJgTbwBg3XZGzopq6Mhl3E0gynVIIDYaj7jZm8ARDNKp/33w6N9/gXOIC
	COeAUE5vlTsfr7ir4NPLeNswqrIDcvZyn4M1hoP3kp/iH+3oy3wB2gk8XIO1EaDfvDnaD1P3nqB
	UF6QDQ0kcLuK6uPnNuJ8C5UKC9e6e/yA9KUvR6C7GSu+IboaezNH+n/4QLy701DDCP0slWu+Rp0
	FWLjviw1EgmRYV0SB6ah/+xsa6+dZXt5o8ia09CIzo0C1xCNvV9g/M+mpNLW/80DGyy3fsrzKDb
	daUcPAg3J6XOP14+ChBd7RAHQbbfNWC8DLfcsgglaQEEOesTYbaYjmVRBpix2N9+RxnA==
X-Received: by 2002:a17:906:9fcb:b0:ba3:8a04:7688 with SMTP id a640c23a62f3a-bbffe0cc792mr429478966b.36.1777895035837;
        Mon, 04 May 2026 04:43:55 -0700 (PDT)
Received: from [192.168.88.241] (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe6d97e486sm392135766b.49.2026.05.04.04.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 04:43:55 -0700 (PDT)
Message-ID: <d9a9fcf7-07e2-4e26-afde-f1bec6108c40@ovn.org>
Date: Mon, 4 May 2026 13:43:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Yuan Tan <tanyuan98@outlook.com>, Yang Yang <n05ec@lzu.edu.cn>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] openvswitch: fix self-deadlock on release of
 tunnel vports
To: netdev@vger.kernel.org
References: <20260430233848.440994-1-i.maximets@ovn.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <20260430233848.440994-1-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9CCA14BC925
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283806-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.930];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ovn.org:mid,dpctl.py:url]

On 5/1/26 1:38 AM, Ilya Maximets wrote:
> Two patches - the fix for the actual bug and the selftest that reproduces it.
> 
> I missed the self-deadlock in the original patch that introduced the issue,
> because testing required code modification in the ovs-vswitchd to force it to
> use legacy tunnel ports.  I thought I made the change correctly, but apparently
> something went wrong and the tests were run with the standard LWT infra instead.
> The selftest added in this patch set will at least prevent this kind of mistakes
> in the future.
> 
> I mentioned, however, that these tunnel vports are legacy and not actually used
> by ovs-vswitchd.  RTM_NEWLINK + COLLECT_METADATA is used in conjunction with the
> standard OVS_VPORT_TYPE_NETDEV instead since 2017.  The code to use the legacy
> tunnels still exists in ovs-vswitchd however, but only as a fallback for older
> kernels and we're planning to remove it in the next release.  I'll be sending an
> RFC to remove support for these legacy tunnel types from the kernel, as they
> serve no real purpose today and only increase the uAPI surface for CVEs, but
> we need to fix the known bugs for stable versions.
> 
> 
> Version 2:
>   - Added Ack from Eelco to the first patch (not to the second as it
>     changed a little).
>   - Removed now unused import socket in the dpctl.py [pylint/ruff].
> 
>   - Regarding comments from both Sashiko instances on the selftest patch:
> 
>     * The background process is not waited for / not killed.
>       If it hangs it will not be killable anyway, so it's not a problem.

Both sashiko instances still flag this.  Looks like the cover letter is not
included in the prompt.

If someone thinks I should add the suggested kill on exit, I can, but it will
not be effective in case the process hangs.

Best regards, Ilya Maximets.

