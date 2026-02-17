Return-Path: <netdev+bounces-259057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHWUMdV8lGkfFAIAu9opvQ
	(envelope-from <netdev+bounces-259057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:36:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C46814D36C
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69A8A3011069
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EBF3596F1;
	Tue, 17 Feb 2026 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atPdAjQU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhFD3ssJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0046936B04D
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338961; cv=none; b=mnvdgWeKWGezEuD9jZ5LYLEHT7HkAOiO4Dg+OGdZUR7dsk9YT/F7PDbH05KQGngpE/pun+mwpb0fjbAgbwd11j0CFEVF9blJIIK5aA+rtOBOfqsWvvnCT0HGrM6aVBYSeCOmR5M5uq5wLxDiSM1TOkc+vZoN4ToinjhH0m4lp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338961; c=relaxed/simple;
	bh=LAk6zvMggeqi5+4tEfwNjECBctjNPld13NdqgunSSYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tcrx1lAE7WfdnAspgL5/+5VnsNF79ZUFaLVpPKBRYPRo8k2ob9EnSR+koFZgjG3KdbLDCP5KUdX6jdC7OQ34RHxUH+QSqCZoCwONJoVdFU3LM3lFa4AvB0gGmagsHAzWjCtaqRbqKclGBxq+KuEd24o6M5y2hg3XO99pynhbA5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atPdAjQU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhFD3ssJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771338959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeSRtC6cS3zMvmRLLjVQWzIwPdkF/VGB6fKZUE6UyW8=;
	b=atPdAjQUue7TOiP8L04Ib+DMP46yPBlSimegfX4j7gwJBveLhXqeeXeYKFoTvSWSHIytVR
	u1aNq8EuxW+EJRMQ1edfrC2chr7XEO3D5HxuN7NvkdgBe52kQQldbs58hq8h6d+yKQhn8Z
	RJrV3BJwJe8uVaWhlJlpZlp4TtfD6DU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-HBh6a-_oMha-i7sv7ApNQg-1; Tue, 17 Feb 2026 09:35:57 -0500
X-MC-Unique: HBh6a-_oMha-i7sv7ApNQg-1
X-Mimecast-MFC-AGG-ID: HBh6a-_oMha-i7sv7ApNQg_1771338957
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4803e8b6007so36460405e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 06:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771338956; x=1771943756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YeSRtC6cS3zMvmRLLjVQWzIwPdkF/VGB6fKZUE6UyW8=;
        b=FhFD3ssJ1QvdPVFPYKVnCo9K48E7wqqvkndlHTZCffiqSBubdQCHeA4jU6UNSFNujM
         mNkKZVeWzOSNSjVdQDRgfEnUf8eRDhu+xzIXRjKgqJuzzsPs3pwaTDbICdvTLPgcldrr
         7VcqT4Gpcl5hUKHqbSSUmpbqYqjwgWEd6lzQVkpStPrGs9twZrjk2NoLbpaK5ST2Wpjk
         HPGGHJh2CiNgAnRCk4RuVzX+nZBMsA618rFBmdiU5L3b2D7fZ7om48Gc7wXUCy1wxImi
         swQ8b9LdJZzgZho353RExwUkjih7r6Z6sO0Rs7ET6C7JGvmnNR65TpxzHHCABHoEzXN0
         5UBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338956; x=1771943756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YeSRtC6cS3zMvmRLLjVQWzIwPdkF/VGB6fKZUE6UyW8=;
        b=qQcR4n1VtkHyZK6QASathxdK4pF/CKYAPNVbxuE64yHv1dzo3HqPpy9JDS/ZHz6+0D
         o1ii4ybVoX8BetWpVu830iKR2zDWh8zx/11qay7qeczyHtdFHt46H93WXwQx/xrIsbE1
         OzwGItvDS9CPTQRqXJPAhXF2LdQYxEsCoLJDK4Go6TeQ/5eltDed5fsfSHWilYGZNHZy
         y4B8O1z/isTnnhYPeRGNzVRr0SkjpAwx0LVYb4amZ5Ac3p8hcqPWuWAxvkjJXVmpX7Uz
         r3gBDgbFe6/xzuv8VKJqUcTzKEok9EM3A74QUb6oLLcp9aSyRkLw2O5oMABhqjXtfXjQ
         MV/w==
X-Forwarded-Encrypted: i=1; AJvYcCXrEXH25pd4bbG+R7uDuJv65/8zX9vAhUxk/jSjUsEF04DtetL145DQnf62ezN7+xHLd/qEIhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGuXvZXWGSL8P/scgInw0Wh6D3A4aXfwJVqSzhXPSoig3whilI
	/W/Ngexm5yeXhgfjSlAdibnbzswrzu2ay5NzCSbUuZf61K9x6lvQsDKrzLPA3TfxYVBgrTUzzU6
	pOotXWS+VSetDRKFxoczQ1/pp38BuYFpur9K+KDPvl+4JmVaIV+q6E6jFcQ==
X-Gm-Gg: AZuq6aIpnUOf6bsfs5ltd48b1wb2qSBN4en+P4IpVdl3BNm8lqMiFFl0LgxEsQHJ//k
	7FSgkKbYXFoBcJfNhH2w0XpXjOIgs3wKlFDjkrF6U8aiM4iWDLj49gQT3gqtuj8937dpcJ0UWBD
	ublj+of6u8mgUHhYUJj5RPTWOcp/9s3V+1HV3+7GD21wTERgAnq84XyH6aX0JLpENfQIFQ3Adle
	Yo2FSC/QIELinE1kfDMA/gRg6AtJPinz0VgO09Znxw11dmX3V44JyXRk4Aa3Jb2d5RaLoANYRuI
	obFZRntPky9jmLJOzL2KdRMYELkpzsbTUMr7vis911wCEQZvheD4oQv24RwcG5JMC04/v/N2MUW
	+u9mHEEAiE7B5JLrv9Y2JKvZ2eg==
X-Received: by 2002:a05:600c:a308:b0:483:7980:4687 with SMTP id 5b1f17b1804b1-48379804a28mr177155655e9.17.1771338956543;
        Tue, 17 Feb 2026 06:35:56 -0800 (PST)
X-Received: by 2002:a05:600c:a308:b0:483:7980:4687 with SMTP id 5b1f17b1804b1-48379804a28mr177155305e9.17.1771338956129;
        Tue, 17 Feb 2026 06:35:56 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d8334a8sm552913635e9.12.2026.02.17.06.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 06:35:55 -0800 (PST)
Message-ID: <599a89cb-496c-484e-be62-471bbe49e7e4@redhat.com>
Date: Tue, 17 Feb 2026 15:35:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] pull request: ovpn for net 2026-02-12
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>
References: <20260212210340.11260-1-antonio@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260212210340.11260-1-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259057-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C46814D36C
X-Rspamd-Action: no action

On 2/12/26 10:03 PM, Antonio Quartulli wrote:
> In this batch you can three fixes:
> 
> 1) ensure that sk_user_data is set before configuring socket callbacks.
> This way we avoid dropping early packets received by the CB when the
> ovpn data is not yet configured.
> 
> 2) fix use-after-free in ovpn_net_xmit by not blindly assuming that the
> first skb segment will always be valid. It may actually be released by
> skb_share_check.
> 
> 3) properly increase TX stats, by counting bytes of all segments that
> have been properly processed, instead of just counting the first segment
> only.
> 
> Please pull or let me know of any issue!

Pulled, thanks!

Paolo


