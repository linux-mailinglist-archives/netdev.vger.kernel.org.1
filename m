Return-Path: <netdev+bounces-274495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIOyKWlZzmkxnAYAu9opvQ
	(envelope-from <netdev+bounces-274495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:56:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0888D388A58
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01E5C300BCB0
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E2A3D8121;
	Thu,  2 Apr 2026 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWfKX3H4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqPQf9UM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594F314B9D
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129476; cv=none; b=tIVieZcT+uA7vTZIpfGxwjDkf3QuZLYmZAvPO19yA0AwizAlaLKv3jw746/2RAyicfCG23nDXf/0ZAdgkskHB7O/pSslKdl2a/LRioEYpipqlJuhViSt4+DKhrLO4f8ZbFU4Wd3hzHYVySWpHgzKMxefXrDZHoGqtKq4K6EeNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129476; c=relaxed/simple;
	bh=SYVn1iKdGSbwj1CVEa0z0TjKkiuTJRsEETO23ojcku8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdDVaU4N0snCGZeCq8J6EoFIzj2v6DufNUzFghnNT/187rFMNYny64G21r7E7U1PrMc7hbQx73QJBh809xBg2h5umtf2z5Znw1K+4n05uf8HyUWozb32JKxlpZi1kojp654gLBKKpMfG/csDulokpAs6S33epoAR69oQTqFOI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWfKX3H4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqPQf9UM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775129463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0fqRfblYLTJDEQYUztuGu7ZBJTLdZDmBKDJCfvc594=;
	b=JWfKX3H4sWqyf5xEMPgkrXpalWlG43QveB1DakwcvQBG0B8y0keHxt9Ahce7zVILjIWqOL
	UT+qzNptoKHEml/3xbVIVgdRwMfXBYDPvmcM7cofcXhl16yeUlFFxTiFgdyOljANsHS2Jk
	aFhQS1Y69IVHKAaN7IrtgqGCHfGnBto=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-LEpZ7K-vPeCfYm0_aLNtog-1; Thu, 02 Apr 2026 07:31:02 -0400
X-MC-Unique: LEpZ7K-vPeCfYm0_aLNtog-1
X-Mimecast-MFC-AGG-ID: LEpZ7K-vPeCfYm0_aLNtog_1775129461
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4887f516cf5so4666165e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 04:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775129461; x=1775734261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0fqRfblYLTJDEQYUztuGu7ZBJTLdZDmBKDJCfvc594=;
        b=JqPQf9UMv096/HSLzPoft6X0X47dg9rdpmXizUA5t0C8Il8Di4a6l9fowVjBs0E0lQ
         DvWrqmCk/uzaPux010foufEHU+E8o3pSaCJI0+kU8d7cV9cDX2x0gJDB6yuzVClpS4tv
         rq3ZYAIyKQXUMnhQ0D8rM4HvcSlnw6ukTb59X/OT+S6UDjTOVWxcl/6XBAANAkkiRtv5
         hhFsnXJ+EOIOqVY3eP1zQ0TC7B+z78nRKbefFfJxVuqd2i05+sEqhfVSHQlhy7JS25e3
         VwIE89e1zBblJ3bqxXziXM62KLjvNXbHmx6Q1a3Z+MbDuGHoFGc+FOjw1ELcWLQFFhN1
         Aw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775129461; x=1775734261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0fqRfblYLTJDEQYUztuGu7ZBJTLdZDmBKDJCfvc594=;
        b=pW+MwK0sLklmtUKPH7a658kA/f/y1i57yP95oGHkV5e9RDMY5x4deIPWmwuS9AVN7u
         Wql1b/cR4Dkn1C/wuSXKOfAt6MsixwUBsY8+FKeLUioMkd92ZzcovP+LSvIHuxsdvQWy
         +HPEAYgSD7gF5thJlb78jIgFUEX13ZNk6Z/3hko+H2sz22ZjnH44V5+eGvReKS4UIyFz
         SoWymg3h3okjEzn5SATSg360RghvioNfbMuFbV+jJBK+BtSIlsAJafKK7ibSdfcvYCNN
         ji5Io+EoyI3gLl7wo5IUM6+m4A2kb0RQsqp1MrK8aEeHNJqSHE4SuZf9bfgZLhAKZBhq
         Qxbw==
X-Gm-Message-State: AOJu0YynSjwP/HvKHMVDvxrh5vh4HNN7YHrXsg4sS1bgolLUPXFmGEPx
	DEyD68MpaK2bhnbVa+DZ6L43z1L4dcnpPr/ehtu2Xyv09tRlnH7dPBF4wSmXIMArU1/jfqh8gF2
	m04aADTSbyfdnXCqfhpeWFg0eXNBXjaNPb9WyYloBQin1zc/ob/2YwPfalg==
X-Gm-Gg: ATEYQzyBowY2Zf9MXu0i2uBviDYhv3oeXnNmbz2Rqg3tgc6RsHrY3wPbCORGxNfSECI
	C5ZqMD8LIpOwtl5/ATz6xXRk/zHqkhC2gaaQ4mczABfXCwDamvc2PZyJjeJkB9lUHfhWGPQJ8gH
	VXxy6GW1FA10eKGeRoPC4H9oXbUBhOkw2Vi2NBrSnkb45b48wa3tDSe5ofBewB0AN3EXWVuC7Mb
	8sJy3DylljnQ9AoIKIUiq4Fg3Kqjy2Bm5K3yo81hKnBKvC97yUeBgEVwOac7F7EhnD8ePtuh3GC
	ZKe/cx4erYGm7Th4oFt6AwSu7NVSvWpD5OlfUXYHt0rz67xqf06PKV4aW7wAShLMlyAMB2K0OyT
	sMDSpAtp9kQGp8pr1uOad8daU1I8RUY5TPEnlX2VaUKihBCfL4lOvj7n2pw==
X-Received: by 2002:a05:600c:c04a:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-4888b769877mr33194325e9.21.1775129461198;
        Thu, 02 Apr 2026 04:31:01 -0700 (PDT)
X-Received: by 2002:a05:600c:c04a:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-4888b769877mr33193615e9.21.1775129460637;
        Thu, 02 Apr 2026 04:31:00 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm229806465e9.0.2026.04.02.04.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 04:31:00 -0700 (PDT)
Message-ID: <05c7a9b4-9874-42e6-acae-a5d66d33428f@redhat.com>
Date: Thu, 2 Apr 2026 13:30:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: mctp: perform source address lookups
 when we populate our dst
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20260331-dev-mctp-null-eids-v1-0-b4d047372eaf@codeconstruct.com.au>
 <20260331-dev-mctp-null-eids-v1-1-b4d047372eaf@codeconstruct.com.au>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260331-dev-mctp-null-eids-v1-1-b4d047372eaf@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274495-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,codeconstruct.com.au:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 0888D388A58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 9:41 AM, Jeremy Kerr wrote:
> Rather than querying the output device for its address in
> mctp_local_output, set up the source address when we're populating the
> dst structure. If no address is assigned, use MCTP_ADDR_NULL.
> 
> This will allow us more flexibility when routing for NULL-source-eid
> cases. For now though, we still reject a NULL source address in the
> output path.
> 
> We need to update the tests a little, so that addresses are assigned
> before we do the dst lookups.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Sashiko pointed to a possible pre-existent issue:

https://sashiko.dev/#/patchset/20260331-dev-mctp-null-eids-v1-0-b4d047372eaf%40codeconstruct.com.au

please have a look and follow-up if needed.

Thanks,

Paolo


