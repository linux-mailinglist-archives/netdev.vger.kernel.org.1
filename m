Return-Path: <netdev+bounces-261623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OQZDs3PoGmTmwQAu9opvQ
	(envelope-from <netdev+bounces-261623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:57:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A25531B0A68
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 065D1302F433
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A41344DB98;
	Thu, 26 Feb 2026 22:57:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1993D6693
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772146630; cv=none; b=pT0My1g95/Oez4wplVmloI1xWeOXMau/3WFFpiqza7Ft/t4F7mc0qR+oS8IRWdqnyMQrWKnM0RHBTApoSZeQDBNWPctCR5sxoMJSsdY1VVuIw2JRvTGUXjhzkzvTpzZfPZFZzJtktnxf25JCijllHHX/3aJG9vLHlUeSGUpfkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772146630; c=relaxed/simple;
	bh=r2KtJt7SxXAAmhyqqyT6k3ceXxJLVkiICCmjLJ35Jrc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=byuQYhQLvV07m0RDJu+cZinFByD2/8P5btDYmkEZBdhTzkUPHBOj7DJuYE+l3Tmoa1Xjrzrhgs1H08JkaARIP7YwXqipznze9kzPX233j8SpdJytjL2Svfu7Fm3Xn4PSF4YjyAWhNhGd7WUOjKG4T6vE4YA5dVL/6MRQ30yD2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43767807cf3so959836f8f.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 14:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772146627; x=1772751427;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6YiZi0dO8mjuo8RdqOulEroaY6GaL2k8zTqAUyQ+dA=;
        b=HLcpZ0TF66mCCyhMQUmhR/Tq+0exYnioP4hPLvyRwi5Ujlx5txhv9W1BHXavREENiC
         cBvq6KFWmRl/S63pc6+kw5wypp+zKgUJrZgm6+cKgQAHE25rZ1u4neFA5bQaimgMDpyg
         pAsG/lH+dIPhiAvtxa0KqEdKWos4+5p7U3zW+RO4eJH2YMPBk46X8K5aJ2O7IhjgMl6T
         9IuRPBDIksolH+LGfoWE6wj11GjlbjSL/t7d3Nsx8zTqOj/GF2Ht+pAEyn36SozRTFxm
         hBPHBmp2vWIUmk8PRo1LFYc4AGLKrZdik3TtjWXtw02zLfgxXB/OPee+krxhJTHQRAmm
         qzrA==
X-Forwarded-Encrypted: i=1; AJvYcCUxPxaiHgaosVJbRuNw+1qr9GGDd6TTyci4MwOrSBeeThtWY97NZhWLotjaM8tAKZv6w5LOsqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxazOJcd5Cmbj5hr6nM/12YvFLbrtI5zpPjrnhPSOgWvkcFIDL3
	U/QHOODUfN0Di1PcXuV6jt8+U31EVUf2d/vo/YWllfML3epqHGbW4p+M
X-Gm-Gg: ATEYQzz05McQSnJ/oXSGpxQwMpUwhyZlVvDB5pm2YhpUrcrwqUzb5xmi1vVVAtFDhbj
	bzlpQu65UeGQlLn7ryF5yZNQZHn+SVm9vrmVTS4+NPZk2THFGDY0ERCQhUlsWAgFVsvLwjypyyF
	RU/2btTcrntg6YQ3D0GOTpYBzb0DJKsAyyixx0WUNFwOM0EilPgrJwdLXNTdMoO47aGx4/Hr+Ch
	vi61D0h/PGfkVgts+TWjr7ja/tk7EvGyntBHJNAWAT3gDzff64dULmMugivSkRUpfgRk6Aatc8A
	rd70I8HA5lhR0EZashPslKh3/Ev8uHIW/SJRoS9W0jTNKY0+CUo3Aiy2tghPr64KUxb+m6xcFpP
	uWGyU/5Sewbm+e3cARyM5WXpWVK3ZvEz8LZqHjSUrMeji7VJjGj/AyzPydwJyVybxYnqJMs1P5r
	ZlW8elneBXWgBd6mUD6u1S5VK2NxLs5aWgdz3NYNMu6loYNkht5iHVfJ72pWQ=
X-Received: by 2002:a05:6000:2005:b0:439:8aaf:33fc with SMTP id ffacd0b85a97d-4399dde2e95mr919614f8f.11.1772146626890;
        Thu, 26 Feb 2026 14:57:06 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75b19esm2616867f8f.25.2026.02.26.14.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 14:57:06 -0800 (PST)
Message-ID: <5708dc9f-2cc7-463c-a9a7-32e82634c94c@ovn.org>
Date: Thu, 26 Feb 2026 23:57:04 +0100
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
 Simon Horman <horms@kernel.org>, dev@openvswitch.org
Subject: Re: [PATCH -net] net: openvswitch: clean up some kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
References: <20260226221054.1041044-1-rdunlap@infradead.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260226221054.1041044-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-261623-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: A25531B0A68
X-Rspamd-Action: no action

On 2/26/26 11:10 PM, Randy Dunlap wrote:
> Fix some kernel-doc warnings in openvswitch.h:
> 
> Mark enum placeholders that are not used as "private" so that kernel-doc
> comments are not needed for them.
> 
> Correct names for 2 enum values:
> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>  '@OVS_VPORT_UPCALL_SUCCESS' description in 'ovs_vport_upcall_attr'
> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>  '@OVS_VPORT_UPCALL_FAIL' description in 'ovs_vport_upcall_attr'
> 
> Warning: include/uapi/linux/openvswitch.h:638 This comment starts with
>  '/**', but isn't a kernel-doc comment.
>  * Omit attributes for notifications.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---

Hi, Randy.  Thanks for the fixes!

If the private/public is the style to follow, it sounds good to me,
though there seem to be an inconsistency in how the kernel-only
attributes are marked.  I see the OVS_SAMPLE_ATTR_ARG is in the
private section, but OVS_CHECK_PKT_LEN_ATTR_ARG and the
OVS_ACTION_ATTR_SET_TO_MASKED are public.  They should either all
be public or all private, as they are used for very similar purposes,
which is storing extra information about the action to make it easier
for the kernel to work with them.  These attributes should never be
used in the communication with userspace.  So, maybe private?

__OVS_CHECK_PKT_LEN_ATTR_MAX is also public for some reason.  I guess,
it is because while it has kernel-doc-style comment, it doesn't start
with /**, so it's not treated like one.  Maybe we should fix that here
just to be consistent?

note: Some enums and structures do not have kernel-doc comments, so
I guess that's the reason to not mark them.  I suppose it's fine,
since adding extra docs is not the purpose of this patch.

nit: the subject prefix is a little strange.

Best regards, Ilya Maximets.

