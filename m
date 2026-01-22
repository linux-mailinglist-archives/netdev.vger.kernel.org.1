Return-Path: <netdev+bounces-252408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JKnBDdCcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:28:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6606768CF3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04A3D300E81D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E462842983C;
	Thu, 22 Jan 2026 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmDbHPTh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F003D3D0A
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095174; cv=pass; b=UALo37qi9wYgG+jCzMs7L/Y1G/lGcLp9GRTLYDGcNLNpJbvJomzfRshl12eihmNyv1phAejjuevw3Bvq3DW9hZ5Hawg3MJ/7OIhDHyX5tzKdB+VmF+Wy8t3P9F32sv+gKGuogcsYFykLjf1wAQluzO5CnYhHHCJfWHRWgkoogaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095174; c=relaxed/simple;
	bh=MaPpnx/vBBIayQFGECqVGrzomTQry8199/x998YCK+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHpnrmFYIfbG5eBLtciWgV8SFPa4L5J3I5WJM4kYbvKbtxoRRkYPC2K8GYCC3pi5zeaG/8myXboy5Jv3fg7zdz/Dfm2wx9g9YghOrYAwW+ngJmh5qU5GFrkNfmcZaAWXDbkt0tCX54W5gBVEr7yA15x9To4k15/cPyoEnX2B7zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gmDbHPTh; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5014b5d8551so443311cf.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 07:19:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769095172; cv=none;
        d=google.com; s=arc-20240605;
        b=NFLhMnjKv0Wwzh69KjoV2pQIiJGxMfXE9gI9/a1+REpK3GUBou5yC/crBZyKB4VVRt
         er6RJlSTSbuHtSP4KLPHWxIRT/b+lMqKupeU6wgr+gjdySKAmPeWS2h9Tzsufy9z/JZH
         1c49VpTLLgdUZIhEWAPZd0c/mcDBLltzPhBBgtC61P/sr6JZoDu5ke1HSmP+QDf+EL7s
         6NLILf/IxMrPu03EI4Nj4+N9dCLV5hppjqCECnXU5SZ3rsS3gRteLcepfjYRwFRpvNLj
         dnaX7V4cXmxyhoeb0YT0YOgxVmL8Bbhx0RlqpoAytw8Mu3ZxBziLi/vBn/mBoAiaI12s
         EeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IZIUSe4CFld+7SumWOw28qFVJhajq7myQwBADeYwCyQ=;
        fh=wx/JsMhc8lHmU14nweacmDIeqfjYdDtOJ/ksucjGApQ=;
        b=JccK+OTaZF3IsizCckLf8t664DIexlZgD8TLdNPWroTalODUewoVTpnXNP84mwWoBN
         RW9Su+cJEXFp6QLsmzHI+JbOlukst+baNSivcYP8w3pb8dtpf5i0cvkeDzQbuj3H3CGA
         PJiVf9s4kHkByIKdms5gC0VmskhO86rrWKWssNhtBLyvvz9ufjOMh1SMVJqKg5S1JX2i
         TdGN41c0PmNEmIO0a+Xn1cCCoLmujBB1BNgXa5IXKmvRqS8N5x9k1HyM5kYpttT+JsNF
         z09LTU+Rem0GYbzUovrURhJXbsaJEizcyDgoPb7IErduscYnNIpd6sULbD3FutdRw8ax
         9EpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769095172; x=1769699972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZIUSe4CFld+7SumWOw28qFVJhajq7myQwBADeYwCyQ=;
        b=gmDbHPThVkCAF/tCHvF7dYpMDvtSkyzMNnu/50gokXdlgQ22tvWXuW625B4y8NdBCx
         DuXaZ6uQORqxdWYq2hwNJ1AlgbNONyG7Coe6EXEIWkeMQY+sLaNwlmYNseifQJiHP9Cl
         tszHwDE43CCSwSfRnHG1SDnaYMpveKVVnvmSKtKmpO5Ae80k+t2Yq0Fw60c2Fal3dL+0
         g/rW3cvQqNlkJnuW4b9oi4Fl1Ps0lCJnAk6f7nxjKrhcaJxrhgF7bguf4M0mKGxk3B6w
         /VyVz3JPWd8ENs9TTeSglzIhAx9fQykwMAV8s8S/Ez+LSDKmgwUoT7TVqnkXPXmvSNgQ
         B0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769095172; x=1769699972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZIUSe4CFld+7SumWOw28qFVJhajq7myQwBADeYwCyQ=;
        b=oDyD8wyDuzGPDAUBoEPGnaaV+mXMNawJ71iy102Y2jql4269zwq5Yhhdsk6u1h8rST
         H/C8a0x2iNjSyRrcEspOoKHWcp2lQopSqict+wEowBJv4M08LJdoPvj0kIxFqWPFsrAM
         hPME1V2o3VyLoqLm8DrbQxTycCV37Gmehdyuk9pn/ygPJ+baMnxArPYyO0ofjIMK4gUO
         3TkVyBp4ZYhYcYrSNWUqy1t4kIcL+ntrqKZcQcNawH8pYk7EqUea7vVbH7in5Lhw65Z/
         fgVcpzBOGTI1kV2fVWS1dphSNzxrrQAUcTVsc+WbbqdBBsLAJTTbeLq5wCPwmaJt/9JZ
         iybw==
X-Forwarded-Encrypted: i=1; AJvYcCWbIbfu7X4hubys/G6Y+ey068QZF0AN4BE8VkZdMPrBpTQ1c9muHZC0oJebpsKM37tAQPL3UkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6fFEJgToolmMfMraWGu4XX97zWPrYM9ha9ch8GfZnUU6nGPA
	9Zn5Zv9GZAOkfFZXETZGfRaVhlflYzJ6Ls8acPMz7PCO+cj22qkvY8/ZcJQkb1/mB9zK/jJS9X6
	xqqI3ZSnrOQITSsf7Pk2HGi+NvIQIS5BELV17zbpY
X-Gm-Gg: AZuq6aK7L1v7Rj8smeCDw2rWjnoSgx5OggE2hEFfCPXYumsdRFrEdoQaWbXtgna921s
	VVYtM+5V720lOeEUd18wu4C2inQItxlkwPN9UXPJnjZqItUhdWgIyiZqeipMkmF/egiR2on3Nok
	EgEiQmkbR6YW8LYG2BfZZE0kGNXoZnnGJZhBIzHv1e5G8/VRPCVGJxo9w/IJcogJykeEX1WywrD
	kPJ+ZS3sfEsl4L5T6a7DWOCrLocWBZynVSKTOw3BPTerxjaeeRxNMcE1Vzum6DWvHj/EBpDh7ZY
	iFjsrC4MWR4y3NCxjR67yocIX62JhE7bvoMEkq8OwsiSV/FwFt4yicKf1vU=
X-Received: by 2002:ac8:7f11:0:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-502ebd67f28mr12806681cf.8.1769095171739; Thu, 22 Jan 2026
 07:19:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122090228.1678207-1-edumazet@google.com>
In-Reply-To: <20260122090228.1678207-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 22 Jan 2026 10:19:14 -0500
X-Gm-Features: AZwV_QhcZ0IV6qCj-pKXcfy8aVxyghUMK7K7GsrrlGhvX3qHWnTqH2e2d1cPoRk
Message-ID: <CADVnQymuxV2WWiTKAoXtVuFKXPc_Jih=Saqzp7pxO3GC98-_kg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move tcp_stream_memory_free() to tcp.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252408-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6606768CF3
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 4:02=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Moving tcp_stream_memory_free() to tcp.c allows the compiler
> to (auto)inline it from tcp_poll() and tcp_sendmsg_locked()
> for better performance.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 2/0 up/down: 118/0 (118)
> Function                                     old     new   delta
> tcp_poll                                     840     923     +83
> tcp_sendmsg_locked                          4217    4252     +35
> Total: Before=3D22573095, After=3D22573213, chg +0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

