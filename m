Return-Path: <netdev+bounces-257574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePLGMuADhmmyJAQAu9opvQ
	(envelope-from <netdev+bounces-257574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:08:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33164FF781
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3EC53042B7C
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867AB27815D;
	Fri,  6 Feb 2026 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuGqi28g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMgjoE/C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2F92773C1
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390303; cv=pass; b=IAG43itYtQb+9FltPqnnWXvul0SRZ9z/wYWeFZf8icgqKkVulf2xxA6nEl5s9DxdUVemmpUFek6u6NlypLAPyiZfFQ59tX5Fhm7pVgXVZ4jn0E3W3V5twbfUldVAF9zua4M2aHr1ZkdNYTOBgweduhbGqwGbiUyUBclJmoQjUlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390303; c=relaxed/simple;
	bh=ewWRw4onFZ5nbE6pRBhrfOQn+cqNzh5TN8aXE39zAiE=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OR88Ty9JC6BOJ85s7Tw6HC8LuJTFHX+A5Ics5DAdvtTETAEBI8SM7AhZ5eamlhIeFbj+xuf97mHN/jrNRWraVBoIxyQ5jyTPkpjUrsGwT2aA3rRlSzGWwtsAxgWOI4K2+diH7Pem+JWmA/nSlmaBwdilca3guMhDi6gVIii0pZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuGqi28g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMgjoE/C; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770390302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewWRw4onFZ5nbE6pRBhrfOQn+cqNzh5TN8aXE39zAiE=;
	b=AuGqi28gpF3ZFV83TCjfwdSjgeZghO8sposyArKcw8guclPW2R36HYL4OO7umxJX9cDDeW
	+4sTFahOAmbqEsN6u68egDrlQKXiRJHwxnj6hUY/8aCRBZ9yRnv9zH4Ygrb6M4Wr4PZFRL
	/jePQN+wLUyrxzmhk9MKEYJE8PNlMxI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-l3PYPtTJPsS1jdhtrRI-qA-1; Fri, 06 Feb 2026 10:05:01 -0500
X-MC-Unique: l3PYPtTJPsS1jdhtrRI-qA-1
X-Mimecast-MFC-AGG-ID: l3PYPtTJPsS1jdhtrRI-qA_1770390300
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70a62ca32so651288685a.2
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 07:05:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770390300; cv=none;
        d=google.com; s=arc-20240605;
        b=isKtdQzIbJ5Q/RwyCLMsXJkCYeMeVu0vYTnlmSgfE6VrOkI9AaIrmkikw0nWSwiMea
         TjhHaXNAmVEp5cYeQREx9tnFWzJZ/gElnLwrF6ytGfLH+TSIpb6WlYJUF5TFUtr6aq6y
         bvOKGpiIBHrEbL+uLIVpfECf/QQ0qRzjiQMhQd93v5a/Q3WP3C+AOeMoJb3AMwuSHvlZ
         AZTRNExGWLrXdYeQElFJVaZSqoiibqFvO7UWxAqbju6EBgK9W1MYBAvqmxdSm8mwoq4+
         31gE23Yv7+4n1VZCWPjQCrkjnBppaTqiPzc3hp+a3GKsrFQZEgr/98DMW4Az3iOMwAyy
         0uZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=ewWRw4onFZ5nbE6pRBhrfOQn+cqNzh5TN8aXE39zAiE=;
        fh=tU5M2ue3u7bqFazhXgaCutn+uGvD96+zOF+G0+Q2uR8=;
        b=VXLr5MOOsQ0Rh0f98TftbzA2lFUFvE+30dii/AdZnceEx4qPGVMfDGqU69tEygu8M2
         RszYoLGokBaNSitBtZNQv7h0e+mGaQz/rLwzp3k13hP8YscuA0bZqCAhFK/v2TxG5gNw
         bR42I8R0rPs74RP8/DAUQusMdH6P1TEN54OHXlLVu2iNyVyJniHAlavUun6clhWcune4
         vxJrU5EWg1B5pdhW2dDWg1qAE28pI3f9SamzJgAHdakcCEVlVTeZ3dd5ZlnlKixtCBC1
         6dVrKL2gD3XiBqOYJNXyuQXIMyO09BHImm5I0kBc+x6LHCYvbP6P4NYkN8vaZY/LIW5P
         cs4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770390300; x=1770995100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewWRw4onFZ5nbE6pRBhrfOQn+cqNzh5TN8aXE39zAiE=;
        b=LMgjoE/CQnvRP6wEL/Q+FvY7UCQ0L/3GY0SKMIV5/XXdBQyEhHThQfmoOjWwRfzXKz
         mvrw3NR+mYheG1YoaS8NMC8gHMHlxiZHjfRajdDBBB38bXClw/BgPImd9DROpUraYV09
         FbVuIX6y1ZGaVzT8VHzEW+lzsAIs/Iego6+ENPQdq2kzO4r2oRwD1KjVRWVm0FCd6rLo
         EIr1sWdO07qjk5GKzCO6MwjLbEDg1Uj45LT2lrm9Y09ext8SElC8jS/WowLfuBc1nHKI
         FktwkrjXLLof40tZo/VjZv5Sv7HRKNqwFWAMwyWWbYbF4KmAvf4zzwS3FOpSF0sqmaeZ
         hyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390300; x=1770995100;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewWRw4onFZ5nbE6pRBhrfOQn+cqNzh5TN8aXE39zAiE=;
        b=WwxISWRTJlnnyqzJ7NQqhtOJS+1LU+ZiWP1YfheHcJfJyXHOSl1QzkAnx/HwGoObc+
         /OlBCikvyAtGDXwHWPEeYtWTQNlR42kE6ACsyK5VzpIwS330kffxrbZnDo+YmGmZQPRB
         RdwJaobTjCpGw83BgZmTLfsL1aLwyKJtmREuWC+ukhIVLrvMs/sW20c4owzOjoKR5Le4
         v1Q/ka3HzdlfAllxHtGSLuQAWLzekBmHqTbFDjs4oG/pDL8ltwN0SIEB0p0pOi73gEkQ
         5CV+5imHN7BI6cDPpQlLXhU4mGjoY6jlNBCbAz7A99JkpttotUEUORvmEDooapz8nrz8
         aqmA==
X-Forwarded-Encrypted: i=1; AJvYcCUFZ6j1VNRB1bb1dl4EKJAPH5ziqRhnvReyXFHD8vdfuza2aSSlRsq1vxMclJlhYACryHr+m7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNmYSb4u1DTTrBS/c/zVUKZljXv4eixP79FTxJJzYmDeQ0XfiE
	fU1tmz9AO1VqRxGNV2DJbr59gDo4aTeJwulV8GA1DTkGsNAgcfPbkvrpO/cHH0WPI67LD2ZaHb3
	WoDK1PkEP8nycYgiQl7TmSARleMPXHiXhTNIUcIk7ggtmr3NhrZS6kFp04Vm4G02efm+huxDhfX
	BuFLU8piD7ROUay7vpBby9ay910I7f3b0a
X-Gm-Gg: AZuq6aKXfIZTPkuGXrS2wVdvWLOjAxRqeFA/GzYTqoerw83qVmfPRS+G1fb8/QkBLzC
	akTYtW6U6J2PSS+hNDqNsfxmicIAkNo0FDHzBxlPekje5zB9ptODV1dGZeq4cHsxs0fNaBJwFKR
	5ESN1eHvt2uFL5/EObnI0HBThTaiJuLU7vIhTkYkMwNuAKBQLH2SxCnoKPgrSmIZjh5i3aZiJ+8
	PDexrgOKwNPwEJbxjzoS86vhQ==
X-Received: by 2002:a05:620a:3720:b0:8c6:b14e:655d with SMTP id af79cd13be357-8caf24957d2mr345817185a.74.1770390300493;
        Fri, 06 Feb 2026 07:05:00 -0800 (PST)
X-Received: by 2002:a05:620a:3720:b0:8c6:b14e:655d with SMTP id
 af79cd13be357-8caf24957d2mr345812185a.74.1770390300049; Fri, 06 Feb 2026
 07:05:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Feb 2026 09:04:57 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Feb 2026 09:04:57 -0600
From: Antoine Tenart <atenart@redhat.com>
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
 <20260204190417.110f5498@kernel.org> <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org>
 <877bsr1l1h.fsf@toke.dk> <CADCXZ1yMkZbRd7ioGw5QQ61OdmYp6misUDoj-s-g7wuoiCHKbg@mail.gmail.com>
 <87v7gbz1ru.fsf@toke.dk> <CADCXZ1z-gg_VsN4kjf325HvWRxL1irhUC76B_erggm5+A7qQ7g@mail.gmail.com>
 <41da26a6-4024-461f-8254-ac5dcf231397@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <41da26a6-4024-461f-8254-ac5dcf231397@kernel.org>
Date: Fri, 6 Feb 2026 09:04:57 -0600
X-Gm-Features: AZwV_QhCilbFjpthzPSYyG6IlbwC1XfYP-FBXIw9tWB8TwXWyelscAaiXVYCVmc
Message-ID: <CADCXZ1wMxCN3B-c+x4SgqC7H-Wap=e_sJ_hu-2B+96b=ip9OVQ@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, 
	horms@kernel.org, jiri@resnulli.us, edumazet@google.com, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, carges@cloudflare.com, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257574-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,gmail.com,vger.kernel.org,davemloft.net,resnulli.us,google.com,mojatatu.com,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atenart@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 33164FF781
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:41:23PM +0100, Jesper Dangaard Brouer wrote:
> On 05/02/2026 17.24, Antoine Tenart wrote:
>
> Can you point me at the OVS userspace code that consume these subsys
> drop_reason's?

I think this was mostly added for debugging utilities and not consumed
by OvS directly but I don't know the OvS userspace code tbf. Anything
you're looking for specifically?

Antoine


