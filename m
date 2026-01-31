Return-Path: <netdev+bounces-255473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDIzG6w8fmkvWgIAu9opvQ
	(envelope-from <netdev+bounces-255473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:32:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C45FFC3377
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94273301FF93
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B298E3596E1;
	Sat, 31 Jan 2026 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZoH7zPjo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5CD3587DE
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880743; cv=pass; b=WmB+/nXQexK0k4yHOdH8G4rGYlnD9wpXxN5CbaAAEwlQZvQNvIgYFg8iXHdGqJVR0N9Ce5wEz7cZG0P6qbG3Fw1eCaCL6e3TsQl5LQr1aSNvIRtiKuBMpSZSVkFJAuaBS3sOTRCQYOqyrOoyv9QusP4yNGvP/i6JJ3hniqmdl9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880743; c=relaxed/simple;
	bh=AH5Mp4HVfEwP7d3SekbzrvjttHLLachc5B85p75vV1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdoqoGE5hGHi4Wj2bNh25e9gM2BYumHEsh2bQS3qrNlxF1hK66V8SRwCzoqGoDOotLv3LvuEhp6ROubFObXftYL2cEbgDJlI5AwLU6dSnipRYoDeiqoWt3MVlxHU05GCf1ZIHjK9aJPBIy0k2uYlUOqvnJseURCUblnn53tHZ0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZoH7zPjo; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8947e6ffd20so38591886d6.1
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:32:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769880741; cv=none;
        d=google.com; s=arc-20240605;
        b=fisYTGqFhLHnyDUPhRpE0o2pcaEiGZthb1qbjJf0tJtXPhMj4PEw/qfzhiG2RepbsY
         nCjiA1a2U0xiVliZbi6StnnQDZxP/V6PY+pYAlvxj4cQASbmtQ6vs5EPUPLlW/ZYmH6G
         6y/F3jStmubFbkczV2voaSZV/0+cf+gHPkZNiYO45aUdUZw4zxfcXn/cWmJNcIQA5rz4
         h+Yer9M7/vF/Ddp3LYdmaZy0GkEL96NK3YQ7yyz4D5MBUmqvPT+pTEeSkexM1eeg2tWh
         F3u0SFrz4P7DZEUyyMrsaxp5y2w9V3HmBIUAdvpTDfPJGtmCYI/huhUCAQ5sUORaTFQr
         t91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FFXR4/OMDB/Hha2547tcEC7+gK55Y57dEdHNOzamh28=;
        fh=x36LTROy9jRSIefevFO7tyX7iscNEZ9SeuLO8v9Mj/Q=;
        b=Ju5Dxt1M9WPu77C9M9GjWkrfzAjzG70v96SiOEFK/vi6Hu9FlU0XI9ODAipED3PALC
         yL0A5rbN1/2AzdPRQGpC5D/Mv2zswemWP7gsL83WHVfWV23iALrTHQwz2Mi+VKJMAZnJ
         6agnksE/3vt2x8aPL5wkcC46v4OVQ6J1e+WgCzWFqZIAVseJP+p47NEqE84he1t9G6VM
         B2tVkahKwnhivhzqaQVIiOPkhpQATlI7hy3nOIlCkaiZ7Ujp0AXnyPQWRJt0Mpfyh0y3
         vTtyTKiZbhQjbdv087hAwZd//EfoCPT4ZR544CAqfY34whCyGe3ve0084hAVqchls3AQ
         CFRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769880741; x=1770485541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFXR4/OMDB/Hha2547tcEC7+gK55Y57dEdHNOzamh28=;
        b=ZoH7zPjoBvg9IK/bhGX+tQtyaB+QlQHQyXyDczRnQqO2E8qAmDeodTNcW+t72hfzWT
         qUCZ5NCz4COmChQKOb3WS13r/Jow7HLtORF3VJMZlptJN79GnGiJCjuInnjvLLTFVMTr
         aNqswAm5tx8dNuySuYA7Qf6nG8Sx9ffXSS1ef4cK56oa05alM6+UC3FgB7OrQRBbviXD
         DiMHJ5mB/tyXHcRO31W1lUI0M4SPPiD0KUCBVEy9NYvAsTPphjxGqjHbPhxvKOjX9fUc
         xiLnrz24IW5kKq0LsaUI6EgKju8Pn0C7QhrOJ7LGEBMqZ2ktqAZ+bcACXMKRUOmVEJNb
         HcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769880741; x=1770485541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FFXR4/OMDB/Hha2547tcEC7+gK55Y57dEdHNOzamh28=;
        b=Dq0PMh7ieHVe1xd4fe01c/fytqOlEvyVLcL4x6xGoo9lH0uXe50OtPH+tqay5TGHL8
         jPdjn7IqWd+lpf92N5aiYXdSZ7cUqb2bztmkgHI2CUkdi4krIW8BKhbFN/JUTQfNTrUb
         7tkRwmnt4yDn+qq0hGbLqY0uvM4n1FmyQMznqwngVx1VEbrR/xlmAXVtu3EbaDD+AXly
         /YLQ3MMRLF+S+BPXMKu0mbjySwd4JEdZqFp1FZtSTnVLMqjjwRSwjzya3aCxeKGoR1q/
         Gv4S4i5bP08U+lXXjFnzEM8gtpbRLbPWVYs1dxmOFDOoZ0rfqkAHuO5gZyCBVgm0Sr5r
         FEOw==
X-Forwarded-Encrypted: i=1; AJvYcCVXpS2NytqwLhrYQR7XMXYBC5ItcWgLrT40YrsQnbsrf0j4wA480oFv19XLRQLB3a8cVg8bjqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHy0e+YAruQEmRoX6q5LaWjnHvvuOYQnPghEWzGAj+OKwLjT2
	cQ9EY74+IehPhfunHiDxZKpnf26fBKAvc1GsGYkrXU0/xdNdtlfNYFZCrvn29+q9vg8DZm0afLI
	0mUXdul0fu8ULWu7gI4oFd8fCIymOez+BVYnPJHEIMSugyeGIqx8Cq3TRCXA=
X-Gm-Gg: AZuq6aKvbosFgY8JEwCtXN6RdOXZq229TQRIwhZTzqthGaNNJF2obYoEQCIpQdnymb+
	gqPEUqbLbEMb/K8aHZ4EPvplZ3e9NZzlCvhztNdmbM+fqGS837kD4O97BM4zjg2JEOwJ+fdjbZa
	10aA+YYhQ+s9VnW98mbyMDbpokzr2H6Bk81Nzs1EzYFTDskXbzTlUAb5qObILqMiaCdLrna4Qyt
	2HWG3xq+0oKzZQ+WXX/0pcIPm5yaSK18Y7d2177XLzCRNwEHOSIMJ5nY605r7x3jgweuw==
X-Received: by 2002:a05:622a:64f:b0:4ee:fe8:9348 with SMTP id
 d75a77b69052e-505d22a4946mr89976711cf.72.1769880740957; Sat, 31 Jan 2026
 09:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130192912.826454-1-kuba@kernel.org>
In-Reply-To: <20260130192912.826454-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 31 Jan 2026 18:32:09 +0100
X-Gm-Features: AZwV_QgPeezvCbcvz2jUIiYO-eyxh6cjEBmy1B5tUEpzAXkFkVVqzBMCpx9RMGM
Message-ID: <CANn89iJXjCLyPsUwEnFBz2wR1Cst=UGOJehNV87UK0Ko4uEkOQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: drv-net: rss: validate min RSS table size
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255473-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C45FFC3377
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 8:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Add a test which checks that the RSS table is at least 4x the max
> queue count supported by the device. The original RSS spec from
> Microsoft stated that the RSS indirection table should be 2 to 8
> times the CPU count, presumably assuming queue per CPU. If the
> CPU count is not a power of two, however, a power-of-2 table
> 2x larger than queue count results in a 33% traffic imbalance.
> Validate that the indirection table is at least 4x the queue
> count. This lowers the imbalance to 16% which empirically
> appears to be more acceptable to memcache-like workloads.

I think this nice observation could be captured in
Documentation/networking/scaling.rst
amending your commit ?

commit b91f2e13c972c3f2f33ecc873b0ff0ada3fa1854    docs: networking:
document multi-RSS context

Thanks !

