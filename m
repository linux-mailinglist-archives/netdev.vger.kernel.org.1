Return-Path: <netdev+bounces-307353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tPOzGTu7VWqGsAAAu9opvQ
	(envelope-from <netdev+bounces-307353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 06:29:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA666750DB9
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 06:29:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gdi+YAnD;
	dkim=pass header.d=redhat.com header.s=google header.b=eryeoF8p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307353-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307353-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6804E304B99C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B9F2DB7BD;
	Tue, 14 Jul 2026 04:29:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6AC2D8DDF
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 04:29:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003348; cv=none; b=YLhBpaHLbLn1dVU6JeCkE6DrhwUcbTHaWFERWSAcJjrtKKQkVAiAxuRBTtZ7N0yRMYR9aZvLjI7Tz8eAA5NF0XlRSmSP+kIjmkTrWJzWN6oely8E11ySbAf9TGJh5SxHovYx6cwJ2lbTgZGItgp2JKoXnE5QsR1GslScA7f12N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003348; c=relaxed/simple;
	bh=4QfcCRLcU0kNhBP6p/zkXE5wTlb1ErHRgMVmRNnSlkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhyyEUvN5RbXhwDS+myJjVQmo7KWimcGg/8ZzGfOmH/NFVpRmZxgbOWhGY1r7xIoc+MEZni9lo8ugYhcH3EMV4YD56S00s2QuDTZMoERcOYoUtTVbpURLcM+aOn7BUTvI5CymzetiwykkJSUZMx/oO4lXbwOUYKY2HQ8Y0dNefs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdi+YAnD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eryeoF8p; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784003345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SmIZ4DZ5UHZkChftLBOyBJmLHvpi5F5/b2ljO8TtHaY=;
	b=gdi+YAnD5CwuhDRukfEjmVm0qOHFaF8v+rt48vO0ix0LNQiuTWSMC7QbmvklzXTfyaQz4e
	e8hoz3tsIqtFReQNrlqJvKVXtCJomQWHxpHVDqxiQAWRB2roA+tSi/4gOvPH8Hh2KWUGeh
	ynSqX0wHc35VbQQGfSwxR7e1o6m0FS4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-nImp-R96MKe7j3xxRB0tTA-1; Tue, 14 Jul 2026 00:29:03 -0400
X-MC-Unique: nImp-R96MKe7j3xxRB0tTA-1
X-Mimecast-MFC-AGG-ID: nImp-R96MKe7j3xxRB0tTA_1784003342
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46fb9079a04so1989594f8f.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 21:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784003342; x=1784608142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SmIZ4DZ5UHZkChftLBOyBJmLHvpi5F5/b2ljO8TtHaY=;
        b=eryeoF8pGvyfA6mea9ANmWJ7S82GGHLjqkFv9xQjet5y6P6lxXFSzxJe8e/CbSJmqG
         gNF1qmvecaNqMCaVMV7vN36PfhzeSPvFu5Asl3+jvdoUrU9qIcZbNPcTgY4h3W4VxuaT
         55bXyaUGPnRv25jVgoUcBN00dFK+1111WL1xIGV/E+ywsAakHCvnhx7qPrbnVNV7n/0r
         nV0Jb1KnGSCOhq5z4YNHFmd90GIZllpEwQoUcwvOlLC0maJEfibpiwbfshIKdU8B3uOS
         qeC2L51Ii80pyFSrvKxFtQyi9XjFvb/nN8mMlSQlDCwdMOwgpgUGaQmHr8yfqbrDus56
         HqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784003342; x=1784608142;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SmIZ4DZ5UHZkChftLBOyBJmLHvpi5F5/b2ljO8TtHaY=;
        b=FFCBdBpI9emOUpz9p1MOi3jfM5pAHZnpmpkmooNuH2SZ6bn12C4MN2O/7P7yk7gnqH
         exdlm0EdrxRsuBUeJe14yVraesWO7cdNKrH/H2qJgzl4lRWdGSTWAv280VpDCsf0EnbX
         xjDJKiofi4UcQ7GS5kh7hw54jWo/Lo24xU9QE4g7uTUBFB2ZoNOElzA0IsRawwD42Kgl
         YgGvBNd9sqLP9dmlhQiFQQlMKN+etFJGCu7EsFcv+jlsS8YqUi9kCaTFWwf0Bck5aJI+
         2yF7RFIzFoCIMkLag+wJfxB3+cH5MScLbtsxQ7PNcQl3CcEWrLFTfowwvO1yFgZ+GYTA
         3qfQ==
X-Gm-Message-State: AOJu0Yz9Lp90SxUVkPKAz6/2DxDjo2KuHpNNdLteU+U/L65lXlNJ9LgT
	zOWXJevL05S2X5PbPBaL4DFOG7YvYLvZVwHFEyybJfBXq56Imaw11oxW9wSX1aQmCBcro5VWWZF
	+2GumhRrOBQRL00ycwkPDokezkuYDImi+36nuaMZoui2/gNVq1nPgaZ10XA==
X-Gm-Gg: AfdE7clDNUbUDfm94dQo3TwN/seqombqgETIVflc15LKixRig6Cn1F/rP3Ys9/QVEjC
	YiU9uwTC2p7Dhn/nvGXi1zPQPb0vQ54EVMbS0G7uWFjmj6s398Ilfp0wrfJnq/5ERg4XkUUjtI+
	NYo7RmTyvxIUEJ+3pKuIbKsEPJ4BqsdBq65bakQNZWmUBHRcSRzspvnli2EjJM2hlPwGjSbYJyA
	Zeg0BfBghr7RWwZGKHY9l/E0pJpjOmMSAhwyf3KVq+j0infUkSprVM1tRKVB2vPk9Ic3dm+9+am
	LZXYV2LYEkrWdNgfIqN/SeRm+aexTbgBUNlEDjMdTLqlRRvbGsGE5jN/P+vX+4qv4f8nUo4Xiqi
	iRN4Hb9rn
X-Received: by 2002:a5d:6e52:0:b0:47f:4602:66e9 with SMTP id ffacd0b85a97d-47f46386a9dmr1707321f8f.40.1784003342335;
        Mon, 13 Jul 2026 21:29:02 -0700 (PDT)
X-Received: by 2002:a5d:6e52:0:b0:47f:4602:66e9 with SMTP id ffacd0b85a97d-47f46386a9dmr1707305f8f.40.1784003342045;
        Mon, 13 Jul 2026 21:29:02 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a9879sm5451047f8f.22.2026.07.13.21.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 21:29:00 -0700 (PDT)
Message-ID: <f1d4197d-55e4-423d-bb18-edebc773075a@redhat.com>
Date: Tue, 14 Jul 2026 06:28:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] padata: Remove serialized job support
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steffen Klassert <steffen.klassert@secunet.com>
References: <20260713223234.24812-1-ebiggers@kernel.org>
 <20260713223234.24812-3-ebiggers@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260713223234.24812-3-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307353-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:steffen.klassert@secunet.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[thuth@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thuth@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA666750DB9

On 14/07/2026 00.32, Eric Biggers wrote:
> Now that pcrypt has been removed, also remove all the code in padata
> whose only user was pcrypt.
> 
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>   Documentation/core-api/padata.rst | 145 +----
>   include/linux/padata.h            | 145 +----
>   kernel/padata.c                   | 902 +-----------------------------
>   3 files changed, 16 insertions(+), 1176 deletions(-)
Nice clean-up!

Reviewed-by: Thomas Huth <thuth@redhat.com>


