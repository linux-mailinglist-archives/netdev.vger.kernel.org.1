Return-Path: <netdev+bounces-269405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGr6KUfZu2k6pAIAu9opvQ
	(envelope-from <netdev+bounces-269405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:08:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 465DD2CA130
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFCB8302BBFD
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844E53C6A27;
	Thu, 19 Mar 2026 11:08:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F0A374190
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918523; cv=none; b=dAnhW0xPTp6e1TAHVmxtSwusGx5I5IXCn4fHk8Z/zz1UvqjBiS6uGMZE/QGJEwEE3kCVjdXzNmFqn5wXYdFcDJQ9WorVh+D9iRs1aiRFBG1uO/5TwLSfwE/0Dcn57caiSuObAsFzxmgRsJpb32F8Ne18HG84Dz/zp6qTuBx7Irc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918523; c=relaxed/simple;
	bh=FxtnzjYiOXPXZmrsWH2aajR5bqo0D8rt7LHZSQf6wzA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QGhV+djCqt3I5vEOgCdo+PN0SdlRPIyC42n5UuOUWXivRIdDaVPjssFjTZgDmqYipngUGBYpqxWYqHhesIw11nAPE+uIG/S+4wcBOIx+fmKweK6fGTKnzmDAVB2txwO+wuqxYlaCwfpJT7aW7WjyocFTke6xT0IzSfJGUBO2KV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso7225265e9.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773918520; x=1774523320;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=put5KumiekHt31iINbS4ymgV3zYRrm1ZpvurQiG2hmY=;
        b=s0dEgOnziKbfg7/bQtAdJw4PSLkr23y58V5afngKnCx8T22N44t0VDLIr251HrE7sp
         PTr1Zj1Eq/5X4EHEq6N+41algOuVZLdHqMGJLUjaPuVZ4Da+VgQ5MkYCnJ6zSYi2SM98
         jGhMvguMMzRCo72oxXMH3aHGkTwdtxXARkpFWMoDzGn88w6wTYhUP+PYyBVE76astmcn
         YgR19F51hVGYOaMhq/KMeMf8D4BfHNfozgM/tLFFtpTOpm4/XReKqM7cd2A5Mm6e7iWo
         m4fgZcRAUDDO1y760AOW1HIAW1WaNBjmuYMDpXhI+5bKdveOkCgua3qx6+kkaHE8DjOw
         keaw==
X-Forwarded-Encrypted: i=1; AJvYcCWTOg0EkA2Ov4/+8rkjKgBSLF018NpB8vrwDIVTRrQOQVbbAZXx8ee3YwO8P98ftLVsATkJtY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPubI3iteOMKU7+DbL8yu9Kzocj4uWsJqmRdTXvUjbekjFRTcI
	/x8WXY8zv0EInpk4b10YLdOA1AJwgwD7YWrUKfwv4uHN++Qo8kKHT+jf
X-Gm-Gg: ATEYQzyXQ41teyoV8c12hy40nvFNLwOw6a/Fm0RM/j+ft1jOko2JFT84cC1xLpbgLne
	KYx5htIdFvfNOYUjZ8azT30yjR+w8rbjUQYgPwWevgcebGifpreH4tALTBh773QrPH08yB6da4j
	NMwNfdlEH91qZhpvaYa8dTRmSgwWAdizmLYWetCPE2GcvB38p+sOjxhOy3GN2R7ngdxJCw5Wihj
	x3U1IoaMz207hgRXhy7pKJSDomUqvt/oaAxtft4JIy5utgHmw6htEpjqoJARCTLMlICytDeb24x
	bKmSFfpJbJRR2ZBwSBvYkzVRgLCBsaHIM7Dy3djhb3PBXYft/d7vNBAI6gug65WJGXvrypIc1Un
	B67Jf/UmwOcncFQArmVNOVOUJbYMi6d4Oo9TRpRZmo495IsWufBgCzIQzlq8qcro3IxTtqAc9CB
	ez4JdCd0JOxL0Cx51YrWQ0SCS9wyqu66M6yOnvb0WU4H2eNfZzduilfSo=
X-Received: by 2002:a05:600c:154e:b0:485:3dfc:57c with SMTP id 5b1f17b1804b1-486f4441232mr111362295e9.21.1773918520260;
        Thu, 19 Mar 2026 04:08:40 -0700 (PDT)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8bd9d78sm19646435e9.5.2026.03.19.04.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 04:08:39 -0700 (PDT)
Message-ID: <833c6df6-d272-4cf0-b74a-01835d0f4d17@ovn.org>
Date: Thu, 19 Mar 2026 12:08:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, pshelar@ovn.org,
 martin.varghese@nokia.com, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 tanyuan98@outlook.com, bird@lzu.edu.cn
Subject: Re: [PATCH net] openvswitch: validate MPLS set/set_masked payload
 length
To: Yang Yang <n05ec@lzu.edu.cn>, aconole@redhat.com, echaudro@redhat.com
References: <20260319080228.3423307-1-n05ec@lzu.edu.cn>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260319080228.3423307-1-n05ec@lzu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,davemloft.net,google.com,kernel.org,redhat.com,nokia.com,vger.kernel.org,openvswitch.org,gmail.com,outlook.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-269405-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.821];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,ovn.org:email,ovn.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 465DD2CA130
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 9:02 AM, Yang Yang wrote:
> validate_set() accepted OVS_KEY_ATTR_MPLS as variable-sized payload for
> SET/SET_MASKED actions. In action handling, OVS expects fixed-size
> MPLS key data (struct ovs_key_mpls).
> 
> Use the already normalized key_len (masked case included) and reject
> non-matching MPLS action key sizes.
> 
> Reject invalid MPLS action payload lengths early.
> 
> Fixes: fbdcdd78da7c ("Change in Openvswitch to support MPLS label depth of 3 in ingress direction")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
> Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
> Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
> ---
> 
>  net/openvswitch/flow_netlink.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
> index 67fbf6e48a301..45444b81e9b97 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -2953,6 +2953,8 @@ static int validate_set(const struct nlattr *a,
>  	case OVS_KEY_ATTR_MPLS:
>  		if (!eth_p_mpls(eth_type))
>  			return -EINVAL;
> +		if (key_len != sizeof(struct ovs_key_mpls))
> +			return -EINVAL;
>  		break;
>  
>  	case OVS_KEY_ATTR_SCTP:

Yeah, the check was not adjusted on the actions side when support for
multiple labels was added for the match.  Thanks for fixing this!
I ran OVS testsuite with this as well, and it works fine.

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

