Return-Path: <netdev+bounces-300253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZbdoIVwZM2oH9gUAu9opvQ
	(envelope-from <netdev+bounces-300253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:02:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C015B69C9B5
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:02:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300253-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300253-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 181DA3041384
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAAD39524B;
	Wed, 17 Jun 2026 22:02:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2436D3783B0
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 22:02:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733721; cv=none; b=NaLBI1kjWQwPxvI7DK8J5SzoU8VZ0d82HioqvMZQe15KSBQLJcakk9sIeFK4yo0rXGgpHRaLGaSMwrQHWlcPlvMI8To+2Q6MVSkzTHsjo/xQmrmqJ4fY7ylyDx27728izvly3+QRJ4ZYaBifmiHHu8l/nFP6iLqFQdrlr4ThM6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733721; c=relaxed/simple;
	bh=AZW4Zex5B5rzcFJ3548d/dIMzBeTRvEo20EnNSGIn5U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sahL+d78GU5XT9GgqayY7tYTDVmmKAPH9Q9ok0fGhpLNuVjS9TH1Hnga8tDArANunfv5z/Na4a0sKI3FCGbZnt7j5vhtEgkvPzor3uopXpo/hoRFQti1WnEpFXfbmTF/NFmR4528vNUjlUe/0QWsMSng9iz6E60GshPVRO+qJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso1745885e9.3
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 15:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781733718; x=1782338518;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ3/dHnx3DT4Q8bHqR+qZOvGURqTgiTK7OuDW6YlKYo=;
        b=jqU/e4ps+sfpX6mzIMl3SPtuOMekpn1RpE94F+bgMnz9rlIV9pJVHmV46u4H9qlhuG
         ctHXwrQrq8gg51s7NAeW+F2zhZzsXdq4ieqXUJ9FxXpz49fNX1GD4hm5dlk15VVABELo
         /vCEJ2onB9ncV4nxyDa69Gr4spcS/k3mDXL6wuwE0TivDRMUC8te0YNHB7vEMg7Z48Dp
         0zauPjlG9QBqUa1hoAMJCaTv+DtG+fwIxPf7sMLvJiqHDii2pbSPgGDRfmHspEuCCff7
         quHfVq4mYGxzh8PmcBTVdDebQZGuDF+3mH3YxNLJ37YPwgFn34TrskO2d4Yv3G9dEjrQ
         J/Iw==
X-Forwarded-Encrypted: i=1; AFNElJ+/v+xc43759Dbd6/sDlaTbs4peynRkXEJJ6vt6FJi45UcUJJvBnq+P7xqRtzS6jYGCT7juU/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTUlsDL8WdcD2lfY6RqHL3O0eGi5TUZIVTI0P8vm9K71nv+bHD
	G/iJEIVZhA8Fk2eqAFVtb/js0PGCpwLwYOBDzQ3pJHoQX1li0tkQvo08
X-Gm-Gg: Acq92OFJU9Xr2lKER74CMA+dXTQpFZKLJegdoyHfsHXZWa5mDSbm33om3XJxABLp7xS
	qpKestt8uTZv/g8AVB9dAJFZEf9n8Dnl9okWyuh5M69nisYVN5kOpGPlRdV9ZM0/eMBWvlOWHfM
	MLxlVU3EsjkYK/zzaHsp4SL6jJAgD8Wg0u0igAzeddECPOtCSFGu8VuP44nUHaFOFyH6ld0Gxbv
	ZfCrKsJATb5iLVQP3JTAMVRInZZt/BL905GoisjTgIljU/4PmJNIZi1yLTDa4uxmu/fLpTZuvYu
	DY1YvAxFXjOmX+X/zKv/FSIzqMc5NKZIP56DPBC52E4QtXhuxqmhTq+8r5ugGQCB8KOfPyKhM0i
	oKcEmJ6yZmIVgKo/BS1BYXETBwhvRiizmYz2GWb61nKiwmzBymZAFlf/YBUQIGLSenYKEfeDD5l
	tMhKVwrhTvQ//0l4YOcKj1SppcaZBlckn6eEBdMKAjlgTL
X-Received: by 2002:a05:600c:6748:b0:490:3fa2:1b93 with SMTP id 5b1f17b1804b1-492381f132cmr16831865e9.13.1781733718507;
        Wed, 17 Jun 2026 15:01:58 -0700 (PDT)
Received: from [192.168.88.241] (89-24-35-102.nat.epc.tmcz.cz. [89.24.35.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-461eaa0d275sm13995468f8f.2.2026.06.17.15.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 15:01:58 -0700 (PDT)
Message-ID: <b16e8bac-e149-4052-b1cb-8fd3e1137f9c@ovn.org>
Date: Thu, 18 Jun 2026 00:01:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, Johan Thomsen <write@ownrisk.dk>
Subject: Re: [PATCH net] net: dst_metadata: fix false-positive memcpy overflow
 in tun_dst_unclone
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, netdev@vger.kernel.org
References: <20260616100332.1308294-1-i.maximets@ovn.org>
 <9e941b82-23d4-44e6-a240-b7949ace76ab@embeddedor.com>
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
In-Reply-To: <9e941b82-23d4-44e6-a240-b7949ace76ab@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-300253-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_RECIPIENTS(0.00)[m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:llvm@lists.linux.dev,m:write@ownrisk.dk,m:gustavo@embeddedor.com,m:netdev@vger.kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[ovn.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,ownrisk.dk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C015B69C9B5

On 6/17/26 10:08 PM, Gustavo A. R. Silva wrote:
> Hi,
> 
> On 6/16/26 04:03, Ilya Maximets wrote:
>> kmalloc_flex() in metadata_dst_alloc() sets __counted_by for the
>> structure to the options_len, which is then initialized to zero.
>> Later, we're initializing the structure by copying the tunnel info
>> together with the options, and this triggers a warning for a potential
>> memcpy overflow, since the compiler estimates that the options can't
>> fit into the structure, even though the memory for them is actually
>> allocated.
>>
>>   memcpy: detected buffer overflow: 104 byte write of buffer size 96
>>   WARNING: CPU: X PID: Y at lib/string_helpers.c:1036 __fortify_report
>>    skb_tunnel_info_unclone+0x179/0x190
>>    geneve_xmit+0x7fe/0xe00
> 
> This warning has nothing to do with counted_by. See below for more
> comments.
> 
>>
>> The issue is triggered when built with clang and source fortification.
>>
>> Fix that by doing the copy in two stages: first - the main data with
>> the options_len, then the options.  This way the correct length should
>> be known at the time of the copy.
>>
>> It would be better if the options_len never changed after allocation,
>> but the allocation code is a little separate from the initialization
>> and it would be awkward and potentially dangerous to return a struct
>> with options_len set to a non-zero value from the metadata_dst_alloc().
>>
>> Another option would be to use ip_tunnel_info_opts_set(), but it is
>> doing too many unnecessary operations for the use case here.
>>
>> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
>> Reported-by: Johan Thomsen <write@ownrisk.dk>
>> Closes: https://lore.kernel.org/netdev/CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com/
>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>> ---
>>
>> Johan, if you can test this one in your setup as well, that would
>> be great.  Thanks.
>>
>>   include/net/dst_metadata.h | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
>> index 1fc2fb03ce3f..f45d1e3163f0 100644
>> --- a/include/net/dst_metadata.h
>> +++ b/include/net/dst_metadata.h
>> @@ -164,8 +164,11 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>>   	if (!new_md)
>>   		return ERR_PTR(-ENOMEM);
>>   
>> -	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
>> -	       sizeof(struct ip_tunnel_info) + md_size);
> 
> What's going on here is that, internally, fortified memcpy() retrieves
> the destination size via __builtin_dynamic_object_size() in mode 1.
> 
> That is:
> 
> __builtin_dynamic_object_size(&new_md->u.tun_info, 1)
> 
> For the above case, Clang returns sizeof(new_md->u.tun_info) == 96.
> 
> So the warning is reporting that 104 bytes don't fit in an object of
> size 96 bytes, regardless of any counted_by annotation or allocation.

Hmm.  Does __builtin_dynamic_object_size(&new_md->u.tun_info, 1) return
104 when the options_len is 8?  If so, isn't that because it is counted
by that field?  Asking because the fortification doesn't complain if we
keep the full 104-byte copy as-is, but set the options_len beforehand,
as tested by Johan.

> 
> Of course, in this case, the write of 104 bytes into new_md->u.tun_info
> is intentional and controlled, but what if it weren't?
> 
> On the other hand, for this same case, GCC currently returns SIZE_MAX,
> which translates to -1 inside fortified memcpy(). Thus, bounds-checking
> is bypassed, which is why this warning doesn't show up with GCC.
> 
> However, this is a bug in GCC. We're already looking into that.
> 
> I think we've had just a handful of cases like this across the whole
> kernel tree. We can deal with them as you did here (by directly copying
> the composite structure first, and then using memcpy() to copy into the
> flexible-array member). If these cases ever become more common, we
> could create some kind of helper to do both things at once. :)
> 
>> +	/* Copy in two stages to keep the __counted_by happy. */
> 
> So based on my comments above, this code comment is not correct.

I feel like some comment is still needed, do you have some suggestions
for what would be a better wording?

> 
>> +	new_md->u.tun_info = md_dst->u.tun_info;
> 
> This is fine.
> 
>> +	memcpy(ip_tunnel_info_opts(&new_md->u.tun_info),
>> +	       ip_tunnel_info_opts(&md_dst->u.tun_info), md_size);
> 
> Is ip_tunnel_info_opts() really needed here?
> 
> Probably this works just fine:
> 
> memcpy(new_md->u.tun_info.options, md_dst->u.tun_info.options, md_size);

The logic here is: we have the access function, therefore we should use it.
It gives a bad example if we don't.

Best regards, Ilya Maximets.

