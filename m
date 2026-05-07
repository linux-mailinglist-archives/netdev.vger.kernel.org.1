Return-Path: <netdev+bounces-285297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JpiMlGA/GkcQwAAu9opvQ
	(envelope-from <netdev+bounces-285297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:06:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC034E7F87
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E24983005A8D
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DEF3B27F1;
	Thu,  7 May 2026 12:06:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4AE363C73
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155595; cv=none; b=RYHAF3LoLC9f2Pv+m+u8HGv7nVGb3rVpC4WHD5N/ZDeo8RdlOWYXmU/Xcw2QKrxsMZW+e8ov1gJRKM1lF06ET5fflOXQSKrWrwOnHNb1MF8Ni6jjnuccOrQw73ZLVdosTvK7Ol/jR/0LIT8GzmAJrMEixp0fwHzx7Wmgf2g8MfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155595; c=relaxed/simple;
	bh=xc4jZSCHtseZbJYMZLNMEchqDU5zrMTLS5HcLaz0Uq4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gqyr6U7qbutM4xcVxDSwj4hWafwv4CiHWnt7/fCZOMOcd19mOG6WMSkRrS03GOPuf/Q2kYXnMdpNpZFM4wnvrZDgahCEKktDPAMcUxmmax7wiJyW/yY74FZ4XK/aArxrr9HtfTbWSWNk1xaB0db/HwFy4CauMSlT73tWJp3qvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-bc2301be8ecso135093966b.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 05:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778155593; x=1778760393;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksz9ghdYxAcg16xyHU5ZmeuINzq4tKFCjVTdnglmNss=;
        b=qXCovaHpwFC4YMZcJ2mYMNjXSS/A+Hdi4MaPxFfyOa8meGg0e/tw1zlzR9e6/02mva
         hJxmjgi5SpP74iiHipwg5ZW70mzny2FFuLswuLeXCCo8EO1uOsFNLMp8miU4Iij8gdjv
         lIRXce9hfZs7pih4kMo4VDw+J1nmMCrnhn2o9WTaiAzQxhnW7MXczZPdv86dDFmfdBuU
         UMofSBnZM2tz+IkAqzwH1Lx4ZxauQkOOX3MX71Ne+zpuq1ZngSyxEoOEDBiFwm6ZRA8c
         xLywZyIn5IRMMCl7cBHu6Ou8vFuj3fXxDt6oUDD+IWumw4IHrQj9YuVA7XGVNz7ULi6O
         dnqA==
X-Forwarded-Encrypted: i=1; AFNElJ/NaDLztXf/c+ZG/F7rwyqGErXRd7Y2AsWVHM53jNEdubs/iPiNL8VEfctuHoFiJa5iQpvUlw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoye58GDFFI6nCycy+Mw6xTbmknYwZs1W97czy0KZrWe5qURXB
	Xe1xHfsv1MPMu0yUI+H1mc5Fn8wwp6aibKGTpmB0JPy1GMWE8BBGXeab
X-Gm-Gg: AeBDies0LPJ6NMIyJ52KnZ66MK7KH/j+yZ0PUHXzBI/gQLlcCf9J2oLz5DOcog5Q4mC
	duVDzaOGcHQ+beYLef52SG5bBA2czpvixluQl2w2PGB+mfkKiHTiHeBcAMGS5bFSj7yzwIrW73t
	ZUsMkeAsWY6LUgZREqERE+K9jwEwiWhXPOx8M8C9DG41TEniTpA1lCM/jm/N11XyrI5JfhMmYpJ
	q8KS3aiEsTHc4xCT3KKibGdbHY+bAbKmQIxRQdaNqB2XFo8iBP9G9u4jsrjJdbMzQjHy+49djTB
	ri3wlbzUSB11XiMH6ijj+JSbmYkB/Dbk4CreagkGh1KoukalqEDQXrvoChNxLrnk5VpwxBOEGkM
	IU4qwZ4aaswjUCQizZRpLu9FrxPgf3mZ1LkLPHv7/Ndwq7tgYBzjIHoWTeQTVjE07iceFhxg/r9
	q75DxoZ3FwcEBhw3u6oAal3MRE+68HTaqyfyNfXHbi1M97fSKi2H2fHYFHmO5kxoNvfA==
X-Received: by 2002:a17:907:3e84:b0:bc3:784f:e143 with SMTP id a640c23a62f3a-bc56cb25f37mr457582866b.19.1778155592367;
        Thu, 07 May 2026 05:06:32 -0700 (PDT)
Received: from [192.168.88.241] (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc835430dd3sm73470066b.52.2026.05.07.05.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 05:06:31 -0700 (PDT)
Message-ID: <c81f54bd-db80-4977-978e-b34e420c477e@ovn.org>
Date: Thu, 7 May 2026 14:06:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, aconole@redhat.com, echaudro@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jbenc@redhat.com, e@erig.me,
 yi.y.yang@intel.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, ldy3087146292@gmail.com
Subject: Re: [PATCH net 1/1] openvswitch: reject oversized NSH MD2 metadata in
 push_nsh
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, dev@openvswitch.org
References: <cover.1776929256.git.ldy3087146292@gmail.com>
 <9d2b5c6127e149ebd35094d662bfd008c20347c2.1777120226.git.ldy3087146292@gmail.com>
 <9c1f6c24-3641-4bef-aad7-8f276def50a8@ovn.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <9c1f6c24-3641-4bef-aad7-8f276def50a8@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8FC034E7F87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,redhat.com,davemloft.net,google.com,kernel.org,erig.me,intel.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-285297-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:mid,ozlabs.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 4/25/26 10:19 PM, Ilya Maximets wrote:
> On 4/25/26 6:40 PM, Ren Wei wrote:
>> From: Douya Le <ldy3087146292@gmail.com>
>>
>> The NSH header length is encoded in 4-byte words in a 6-bit field.
>> The current push_nsh validation only checks the MD2 payload against
>> NSH_CTX_HDRS_MAX_LEN, which still allows metadata sizes that cannot be
>> represented once the base header is included.
>>
>> Reject MD2 metadata lengths whose total NSH header size cannot be
>> encoded exactly in the NSH length field, whether because the field
>> would wrap or because the length is not a multiple of 4 bytes.
>>
>> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
>> Cc: stable@kernel.org
>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>> Tested-by: Douya Le <ldy3087146292@gmail.com>
>> Signed-off-by: Douya Le <ldy3087146292@gmail.com>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>> ---
>>  net/openvswitch/flow_netlink.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
>> index 13052408a132..8a1ae5309c2c 100644
>> --- a/net/openvswitch/flow_netlink.c
>> +++ b/net/openvswitch/flow_netlink.c
>> @@ -1432,7 +1432,13 @@ static int nsh_key_put_from_nlattr(const struct nlattr *attr,
>>  
>>  			has_md2 = true;
>>  			mdlen = nla_len(a);
>> -			if (mdlen > NSH_CTX_HDRS_MAX_LEN || mdlen <= 0) {
>> +			/* The NSH length field stores the total header size
>> +			 * in 4-byte words in 6 bits. Reject MD2 metadata
>> +			 * lengths that cannot be encoded exactly or would
>> +			 * make the length field wrap.
>> +			 */
>> +			if (mdlen <= 0 || !IS_ALIGNED(mdlen, 4) ||
>> +			    NSH_BASE_HDR_LEN + mdlen > (NSH_LEN_MASK << 2)) {
>>  				OVS_NLERR(
>>  				    log,
>>  				    "Invalid MD length %d for MD type %d",
> 
> I don't think the check is a problem here, the problem is that the constants
> are not correct.  We actually had them fixed in userspace, but looks like
> no-one ported the change to the kernel side:
>   https://patchwork.ozlabs.org/project/openvswitch/patch/1540503710-23597-1-git-send-email-pkusunyifeng@gmail.com/
> 
> Adjusting the macros should solve the potential overflow issue.  However,
> even if the value overflows the 6-bit length, it will just be truncated to
> a smaller value and nothing bad should happen in this case, as far as header
> push is concerned.  The context was wrong already, so pushing a truncated
> context doesn't make it more wrong.  But we should still fix the constants,
> so the checks make sense, of course.

I posted a fix for the macros here:
  https://lore.kernel.org/netdev/20260507120434.2962505-1-i.maximets@ovn.org/T/#u

> 
> The same for alignment, if the user provides an invalid header that is not
> multiple of 4, the code will just truncate it to the previous multiple of 4,
> which should not be a problem, as it wasn't correct in the first place.  We
> could add this check just to warn the user that they are doing something wrong,
> but not having it should not cause any real issues.
> 
> Note, the userpace change linked above did fix the real issue in userspace,
> but for the kernel side there seem to be no real memory related issues caused
> by the wrong constants.
> 
> Best regards, Ilya Maximets.


