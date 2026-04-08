Return-Path: <netdev+bounces-276574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGe4IDZt1mkQFQgAu9opvQ
	(envelope-from <netdev+bounces-276574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:59:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B4B3BDEC6
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 344B93009140
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87C33D47AB;
	Wed,  8 Apr 2026 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9KH5yma";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5baNqTH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E423D3D03
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660316; cv=none; b=dpkvYrMYjSED7AnHGKmMz99nOAjBydxd+9kR73rqWJF39dz9BAWrFAgH+kHh8x7ZezoFC2hIv0fQlYPydDDJCcNIq7MPfdRcggz7vpvWqeBqo222koEPLchn+SFglVqvRxD2LAF107xbJ7p9ufj1/GpGEnVXlSwlzhXbS/VLE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660316; c=relaxed/simple;
	bh=8vpKueCEQB76GQR/ngtVMyDYDBmSiY6p1/WB8iXOvko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvbnnR2JOyLqEZ7bhfeKZTuJbWom1zmZJhIK5vHGOXDjgCip7MIC8E4MClvh3CY19B/aEes+GTHv2pdXod1RsDnZ6iGGzqws+3ZoDroJ+mv1u3WxAEh/7IwB9Jeln5TfSdQAmixgYbFwlnSB5uLKsUGdmDkga9MLeQQ/ytSVSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9KH5yma; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5baNqTH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775660314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5k9cDfj6fEVUNaXp8nCyqPBRWfO8zKeH0JyXDvSDvA4=;
	b=O9KH5ymaz9sB/FM6GqiqOg67Q6YSaKvv2WbZZiBvBgVvsh8jV7kLEkoBsmMo7cevWm3QpJ
	1OYgxo3bgVP+4IqIBOy7QgtU+ND8V4m1Geflu1+jHbmo7DH07E+GjDB+kIv+Ydq6IM4mi6
	R/75uZt8dDdc0B+Si7dzLdKEa5S5yjg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-4qP1Hm9zMa-0QxIFey-k6Q-1; Wed, 08 Apr 2026 10:58:31 -0400
X-MC-Unique: 4qP1Hm9zMa-0QxIFey-k6Q-1
X-Mimecast-MFC-AGG-ID: 4qP1Hm9zMa-0QxIFey-k6Q_1775660311
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so62457835e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775660310; x=1776265110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5k9cDfj6fEVUNaXp8nCyqPBRWfO8zKeH0JyXDvSDvA4=;
        b=Q5baNqTHBGx6tbzaTThNskRyHYEph+/5WCHms1yQvk5YwxryUTaLXQX/XuZjffsHIF
         0Yv6F7pcySwluNULX8nMt+X33NWvkrkSivR6j3RAd2aIN2jEd0QAA7BNp7Z4NnRDNjAx
         volgUv+TkQqJFd6yqpus5Q1USRNqQPXnl4O4Pyf2+uQW18a2/nb++iPEi+WBMg7c3kI4
         sZakYRtTCCuUm8tVaXA6aJg3m6QZDPji+W9kNI1VVf+VoJmj53rigH05EGLL5Qdxrw7K
         kM+hZU76Ngy3oIzULQF5pOtCopDRYtb5zDnni9USBX85eoDrjm6Je5P+eXAJRYKy7P70
         xhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775660310; x=1776265110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k9cDfj6fEVUNaXp8nCyqPBRWfO8zKeH0JyXDvSDvA4=;
        b=M7msgi86fVI/a2Mj7VQyDwjfaNIsSeTxHe7MZR9Sb3QJSdcWAEU/OpCTF/KxUSe/tn
         eDUpmNKbI6e50jE5uflTbKOPd7OK+tOE+MSJU8uY7zGysju6NQRyjWXZTeEUns9DYOgH
         JzjZnEItGcoevXbqGEsvZXWYyG1PRlk61MmsCnAK/8HkLRu7F4LSjpyC6DXuCKIiaD7z
         rUGYg4QsuEfM1Ozx/uFnE9iLdieoSCrZDr3ZypnFRNurGR+74MGkvEMQT311/ZGJH/yc
         KMueMXPxYaab4nfxKGewCVL9QjG7rv1wboSUTan6Pcv8KuVtsknyy8O6MQOYumgcvxFh
         B0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWxNNbHY7lPhQ3OirAs7dJpSYEM9jK685WIWDQ1oLXw9Ux1QvqVLTpzv9vD6A1wNWykUEl/m2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzhrNFY8scQHo1SWaWrIzLZMhigWdInIPAilhzZ2aIkWnG6Wg
	VdwyNuQJGxWydXefMj+/ebM0PIS8j/2/6vOsmBWcDPsiD9strt1+5U/izpJEZSQprl8JDRmTTyq
	zoQSBEnOmfJ02wzbY02MURVK1Oa7FN1ofSF/4/ML+tJ/UUpx9O7A8BFM+Mw==
X-Gm-Gg: AeBDiesmn66fppxlUdSLdsfWB6EeBaIvKNtAt7COwn09qDEBLA+2XbvJndv0XlDzUwF
	CZfaIQZxHKcGPnivo58GbPop5fJsOmUOU7esZ3L+LDeJ7LRhOL5mcReT0Bw7rAMV3XwQim7AjCE
	vBW1mAfsAlbOqoDzVYJYcuu14J1YNMkZ/yKFW9vTKH0l7gh8uOtwkulJ0uoCBqm2cxpIHxpg5td
	Z5Xe5RoKzgtQzJ9nu9q6G4TDqM1PlGncerJEdecD7fIh5BNvKJia50wZ3VylqPB5rd+2SiuK7BS
	b4h2P3aqQTvUtXso4iXkWPU2A17lpK7xiCS4+L/5CiJGivYtbKIi1/AeL5sC+0CHjO+3ejJRXMM
	RpJZARXaxFir2jaa+FTUlgsOrY3xFJg3xs2PP5lSeMEAy4pd9L7iwRnxCRg==
X-Received: by 2002:a05:600c:a303:b0:487:1fbf:e0a1 with SMTP id 5b1f17b1804b1-488ccf3a015mr783495e9.4.1775660310526;
        Wed, 08 Apr 2026 07:58:30 -0700 (PDT)
X-Received: by 2002:a05:600c:a303:b0:487:1fbf:e0a1 with SMTP id 5b1f17b1804b1-488ccf3a015mr783225e9.4.1775660310103;
        Wed, 08 Apr 2026 07:58:30 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a72baa8sm504011835e9.15.2026.04.08.07.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 07:58:28 -0700 (PDT)
Message-ID: <a9a49203-b393-48da-a151-d1067ed81645@redhat.com>
Date: Wed, 8 Apr 2026 16:58:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 0/2] i40e: implement per-queue
 stats
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
References: <cover.1775648513.git.pabeni@redhat.com>
 <3c7e8261-7528-431c-adb9-3b90124cef99@molgen.mpg.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3c7e8261-7528-431c-adb9-3b90124cef99@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276574-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: D8B4B3BDEC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 1:50 PM, Paul Menzel wrote:
> Dear Paolo,
>
> Thank you for your patches.
> 
> Am 08.04.26 um 13:43 schrieb Paolo Abeni:
>> The i40e driver already collects some per queue statistics, but does
>> not expose them to the user-space using the standard interface.
>>
>> Implement the stat_ops callbacks and extends the already collected info
> 
> s/extends/extend/
> 
>> with basic GSO counters. Overall this allows passing the kernel NIC
>> drivers TSO test cases.
> 
> It’d be great, if you added the commands to show the stats, and to run 
> the test cases.

I'll add some "show stats" examples in the v2 cover, hopefully fixing
the typos while at it.

How to run NID driver H/W self-tests is IMHO a bit too wide topic to be
discussed in the cover letter, but there is already a quite
comprehensive readme in the selftests dir:

https://elixir.bootlin.com/linux/v7.0-rc7/source/tools/testing/selftests/drivers/net/README.rst

/P


