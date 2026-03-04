Return-Path: <netdev+bounces-263636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIGILq3mp2mrlAAAu9opvQ
	(envelope-from <netdev+bounces-263636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:00:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB471FC171
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F223300D940
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16EF372673;
	Wed,  4 Mar 2026 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zXSSt27F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B1346AE6
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611228; cv=pass; b=s3Slz/qzmvc5ztO2g7NhjKmWXWiDUcLjBvAwjCh8Nr2jNBiBnHMLYeGz91AwCb5qe3iiXDFLeuEimztv7OJxg98wiZf/o7cjU0LRm3Bqb+m0WKvJ1Mv+D1AngH89u2oEBWCdMz+wbou3bmH4aHhTV/KyF/928cg+Ys8kOQ3TqI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611228; c=relaxed/simple;
	bh=oZbMIfJgoyNC1huRn+xu0IHduJs85Fhgysk1qBuklxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gK7UxHWRojSYMBtpDZl5VrQRP/Z5hn47b+KqbiMiN7BN1yfYj/MRjmPfi0j8dscGObVjSng6rPu4Oz/UV6h86dKH2Eazd0HN4n4Dl7rsxFQ2kH7aWJ5Ns8fn6OFyD83RuqAOS5Aaad2sxJMrdzj8yI+LC6R4WdpYHBVaP6Wki00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zXSSt27F; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12732e6a123so4245110c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 00:00:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772611227; cv=none;
        d=google.com; s=arc-20240605;
        b=b4fmYmIspUihX5nJhqldbAOAl7pVjXw6mw+6o8M/gIFqHZYDAjX3plLHOsVyZH7InS
         VJYepQyyygJV2/t3sw6aT2XdWVc1VQwIlqjcs9WOK6eUAf2JPJuQIgfn2LiKz5SxK67B
         WAKjQdiiKnfJjGu9tTr0kqN8wtHflpINDxskg9TUViYvj3WDFJdAgZgizVvZfokTybNi
         Rye7gskk/lbw1J/wY9tN0yGBvPopsH8v17+TNUKGyBRvfZAl3EFjFwH5aaShkqiJZMze
         a/+xC3JaBd0eQ9/pwVi7ZpUSRfszb7zVyVm4YfGyy6qMZwQ6vBfMDYoAM0LYPHBLHbY2
         lOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sFQPVmuhhpgxSP+3G2gvfGYm5aXQsPrNo/XqOtHTd8I=;
        fh=bZk4HbBwimg2BU533McB+xtovKYqAJUAhJLJ6WksWDA=;
        b=cK+/GE7MhshBOvVbF5Oow/DQM+P7Hbd193nbZqUv3rxp03lemKgxcbuV7Edd4nG5hd
         bWFJOt6mMPV/TDmpmL0aQssmG8979IJorEQuXurdEILQIg+T9sAAgU1hZ5d7gDqNFqkf
         UiiqUScgWhHQcsRlznthh8R7Vx+dcZg5vPAcRqaIl9NoSCw2Wf48/9LgLP8P5Gho5Ekz
         Ojrvss8sRmEXBuZVtYYNNJcvSFu1yMOs4DHgro6alLcMP5rLI3foAwb9+sm3LjjHeQ/9
         MJ1zsiwTvZ/zc9hXAu9u0G0mON4Qkd3DqPSUws6jcYt6K90kyHaSOFPOt2QjVNuGMwb5
         pjiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772611227; x=1773216027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFQPVmuhhpgxSP+3G2gvfGYm5aXQsPrNo/XqOtHTd8I=;
        b=zXSSt27FzfBh0FaPbx886dLXIDOltt0d6wGCFakI/cna/tN7t3VczSz3kMHdbsInYF
         +uh3OZP9BXnIQ1E2rJhwr6Dk7snlmEFl0nIYAjIuL4a+lxDu2jdeLLi5Ayk4tSqX3u5w
         +nDd9SXz1JMiVG4qJDy4gdpOgdUC8rArlqjwNiNTrGwpA3k/PSLhOHiupfBXFI+ZPB5I
         iUgfWJjx4sDj5V3nav6Ln5mPW8gdWiH9XxVUP23sbze2JNAN4OV5DSzIL5MrT81iwNkb
         5k1Jy9B3EK2y0AjGWKikvTFA/Cm3Uro6+r4WJvqqJbme+9Fl15ZE6OrsB6IvHiO+9DSi
         iBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611227; x=1773216027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sFQPVmuhhpgxSP+3G2gvfGYm5aXQsPrNo/XqOtHTd8I=;
        b=R/CSqIseHFa6e9RH/RK4UPy+H/EzqMZGHVbY2EDmXDgF7GE2oEy88RMQF65agw1rGE
         FB5YOTMqHvkaalbeyoB50bF66anybDN8pQzFsWbNI3UDCWqdO1evrKkfy+MQpdUr+Dum
         OfTBm8uwpLWA0jfmuOwYEs2bmf/RrXcUGAV29L+OiNEP1AtO0EzZdhwRUjqNUP4yxtrC
         rbL73BYXHAf/EFLP1BcOxOhVv6Gk3gcq+2haOHOj4XdSvQhWuIJxOqFDFMETy7cdL0fe
         c3PRzMSKQmE/wogxPw3NuVZveqKHO0wjWzCTvdUh/+xlJZcLbE8xErkmKoQNfxbHzSGC
         88rA==
X-Forwarded-Encrypted: i=1; AJvYcCWMyNL0M/4GBxyXXJcPIphLVUzIDyA7ukne1JZZGPvqb8PW6EXJoCCRVGxf6mUky3d8AWG0yQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/La0pPBk+Ao67VI1n3kw+VUB9e+Afd4UC7Z3Sysy01qUaN+X
	leYqOat0yV+yWxxZp1eEjBdBKVO1Tpnr6uLDBeXjBcIZkmN69wUop/UxkQuBWkYSnRICzlL3E/j
	3EsrA4FTAnVPFmB40ze9IeM4dKulc/B7RhjlxRc8A
X-Gm-Gg: ATEYQzyUhRo6CC4SYFkcCIJbWRRjtv+fuInriCBZwTIxMaQOj8zyWVsTWKRSKvusi4B
	OyCjktn1c8XWFgkXUOP4RCOR5E1M0N3chDyDdODqtuVaZc3N4P0+NCe3/NjMp9fAjR0RFNhjGzz
	88f5bqGtk/rwo63+BZZ1LV3AWJckQ65RQeaMM0SX5dsNT6wsZPNrkO8EJ4Bwusfr80sIkuNnH4x
	JNOWy5XQfhMXXz7wMSng6kVgojVT8XfsAIm53dL46Ir/b33AgFerrc3CRCr7EhDHrfNZF8TKAeC
	2L48QlUuUUXQUD01Kc6c94dBLvaTW6VuozTnz71tUzacRwkCReDeO2RP9JrRwb0UdtVcV2IPgwG
	dSS3QUuo=
X-Received: by 2002:a05:7022:2390:b0:11e:f6ef:4988 with SMTP id
 a92af1059eb24-128b70eb100mr459939c88.36.1772611226193; Wed, 04 Mar 2026
 00:00:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303191243.557245-1-edumazet@google.com>
In-Reply-To: <20260303191243.557245-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 00:00:14 -0800
X-Gm-Features: AaiRm52L20syJNCptbObEqK1QQY-VpBjvmEdfNyR6XQ7ClAkxtYFs634lCUAuSo
Message-ID: <CAAVpQUDrGrjXrBKUBtFJ2=98nce-iXAgGtWXbNcbxB5HVUr1Xw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move tcp_do_parse_auth_options() to net/ipv4/tcp.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3EB471FC171
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263636-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 11:12=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_do_parse_auth_options() fast path user is tcp_inbound_hash().
>
> Move tcp_do_parse_auth_options() right before tcp_inbound_hash()
> so that it can be (auto)inlined by the compiler.
>
> As a bonus, stack canary is removed from tcp_inbound_hash().
>
> Also use EXPORT_IPV6_MOD(tcp_do_parse_auth_options).
>
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux
> add/remove: 0/0 grow/shrink: 1/0 up/down: 131/0 (131)
> Function                                     old     new   delta
> tcp_inbound_hash                             565     696    +131
> Total: Before=3D25223788, After=3D25223919, chg +0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

