Return-Path: <netdev+bounces-299626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dtM0CiNzMGqgTAUAu9opvQ
	(envelope-from <netdev+bounces-299626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:48:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D52C68A37C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:48:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=oml54g8s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299626-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299626-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E46DC303A92F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ADF3043DB;
	Mon, 15 Jun 2026 21:48:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01832E7631
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 21:48:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560096; cv=pass; b=F92M7lsRoGXTLAFztI8rc6VEzaQ6rxGjLq2DEvYHs1gXZ3RjzDjmiY1KjVxsJUeuPsS29fdu+CrxzB8i1NiTDRcnOXGpiDl2SWjSUo1ffBdC+XYh9XWTtZAGTew3XTfAT8mR15VuJRh9n5AbeR9Rq/KqsQvCCSzyxhGszPx7V9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560096; c=relaxed/simple;
	bh=fzIgzGe7W5e5IvcAWjbBTs1HQOJndjH5Xq2D2MmzqSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9SldWq0qn1D49ZfvVgVHA5AIFafxw4RrZ13lVm58R+lsMQ6AeAP+v/ZLKeI3h0OPN7iPmgtSlpn/2E8WiZl6pgaT7a87tFXqBd2uAQjVKTOHCnKsvaHTIiKuL2wJpPlCcZ7hz/luue4vAKzRSnXvC2KOMacMtAmLe7kwI6awmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=oml54g8s; arc=pass smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c40397e746so22902695ad.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781560094; cv=none;
        d=google.com; s=arc-20240605;
        b=JiHfSuL+PYtiaQsy1aoJnR25w8HMGPbkg5A9cN2MImjeClsftageaunTJ/rD9JZQTJ
         rFkLu1cNllkyenstL0ukKsF4BG7BNg8/CxStvs+2aIwvltRNqakD7NGENMXZEnffbvOu
         gXwZqo+1LPiMbVwAM4s2bCRqR+AXVYCiz/OheR27USMBLQla9iuVx1Rd6aY5DFPB7h4a
         XQB/vGTaizm/x9cZRkkH5quSMdGAVPN21hQZhZeAO+jEYJYiCC1qBgLGHs39a6QLW/K0
         u2sxJJX3U3vFTH91kh8+VS3KRB7Cd2JLKek66rW3obkbl2SD/Y7OhI0ovSzoaSjJgc5O
         5+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VRsNPjRpV/oXuOYckYS3ZWKK4Jdp6pbJLo2zB2KYTrM=;
        fh=ZYxaXIYMvabb9dHeZ2FhzI5l0he1avKb9pG0M/0Xuwc=;
        b=geHwUsC9h1WkmRxVKAuMkKyQXXLD/j4PpFy9PRGvOVqM4nj2OVcgTogyTGyNDkHBYi
         Cj7jQyXK9ZMwwFZ60KPSOkRPB0HHrAzN1SV/ARCbEAHLLeSugixsUwJ24gtUz9svokG4
         ym2SUV04t0LIcfgLkexaGz/9yOEZ0WECMyVZYA8EOtPYNis7OIqaFUQ7WUasVhKV7o5y
         Fb69ZGmJkErDwOUG9a5BlKjD0PdB/Q8EqEQ7DnO6cA7tuFM+eW8CjZxZ1s2jNi5KpJ/D
         rlfY9gJl+QO8ljJw773xd+bk5uo4AFPzw+LfuYTyBpVuO145nqnfQ+MuB2JcbtDVxmTN
         eI/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781560094; x=1782164894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRsNPjRpV/oXuOYckYS3ZWKK4Jdp6pbJLo2zB2KYTrM=;
        b=oml54g8szCgJZpyYKJIcG8lE19u70hkCWlvDoIigdKcTx+y0dvVyntd5UW478vuopD
         5sdtCzC0LopggyjQ7ffZ7nv+TbFoIvzfqyQnhjVZWDkL4jIzG21T0FNdCTBF7DLzp223
         oTDIfrzvGDHAdMR72R7Bjkdd93pp9hVYy/kX2b09N41GWALzVK3kjsHbVufTzj9VMTud
         rOkKJra7AngfBXvBzPzJYKOxgsXk2/fcrFxTeVQ4ohqpQkYTkjKdD3j1SFVBwLik28UB
         tFtUDT0fPDbaLhG+QytNKsRXlPz5RPc/F5yKlNvgy5sR5GBNX0DybZGiJS8BDeCFH26X
         sqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781560094; x=1782164894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VRsNPjRpV/oXuOYckYS3ZWKK4Jdp6pbJLo2zB2KYTrM=;
        b=A0/TUJr1OHRh7Zlu+ulqTIq7gDk7fLY7MArtibCX0qQZZ8QcvG1GGN/llnrcsdc5ln
         WWH0rj3JgsK2rU/PVMaYTCb+dtsUHY3K1KgiWnH22Anb10gshNjfWpC8V8qiR6G3A/Dg
         Prl+CQqNrdVGL07NMg6/ECOd/j7ytTKBuGKhC2dXZ1yCL3nNJj4gS5muVG1KWPcAjVkY
         VmGMcYQU65MML5ApdyDgZA8DztmbR4Mo0iLO/fpf4o/PwsAwE3XqiE1IiEPaOtaxnt2U
         CihXQSFt8unkMVk+VCmkCh+1FWXEi5HHnfYIPPr2XI1XqRUJxizPYHoGj3y+tIMXmNGy
         mFQQ==
X-Gm-Message-State: AOJu0Ywv2CzjF9FOXMhOIF5zfIFOnh7nJrtmXwaeLJrI4QSvFt/6hB2W
	xDR0KggEH2I3HzhCKQG+Pm51zZJ+ZNaYbwoaIACmJWqqQNqSDibirVVrb/zpobNwITW2abMiZTq
	vefasKgWqybzicmr0GieEVIAIaX2SnmyMhLDiaf/z
X-Gm-Gg: Acq92OHtIY+3P9dBmWcw++8jpb7LZkwW4T8VdJ7Kt9OLEkqFq7G7imTtiGatL2XTxr0
	yOW8GgcG+LsmCDJ0v2TDWf675+GhIfC7sLNKCXVIZ2r9ElkaU1UplFVmWViHGNmEiwdMDlqPX5Z
	HrawtjTk3a3Rfi03hAoGtJXjooyTTST/AoQl3i4nihx1vLRrMoDfAmGztEpoLIPJuZMNxn6Q+/P
	k67+YJkfcKXIGK14x+YmelpL/fhOTQqMQ93IzqMwGKMRTTCx5i2PMIGz+oVSN8NEgaRkPIv6vCz
	No0XvS6QIcFA5TLKn5/X9YNA0fwixJiCFX65tjSYaixgf87jZQ==
X-Received: by 2002:a17:903:2b0f:b0:2c0:a360:45da with SMTP id
 d9443c01a7336-2c69a1f496emr8973525ad.32.1781560094267; Mon, 15 Jun 2026
 14:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614034919.918494-1-xmei5@asu.edu> <20260615140815.7543fd29@kernel.org>
In-Reply-To: <20260615140815.7543fd29@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 15 Jun 2026 14:48:02 -0700
X-Gm-Features: AVVi8CeZUU2XiVsweFpSzG8sClbYxlgM__rGsZPo3sGtHKNIkgNcG5kWeb9_Fhg
Message-ID: <CAPpSM+QeUZTQzy7Dq=WrWdKGLKFs4RfgOeY=PiRdWxGzQq8S7A@mail.gmail.com>
Subject: Re: [PATCH net v2] psample: use nla_reserve() for PSAMPLE_ATTR_DATA
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, yotam.gi@gmail.com, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299626-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:yotam.gi@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:bestswngs@gmail.com,m:yotamgi@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,gmail.com,google.com,redhat.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D52C68A37C

On Mon, Jun 15, 2026 at 2:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 13 Jun 2026 20:49:19 -0700 Xiang Mei wrote:
> > psample_sample_packet() open-codes the PSAMPLE_ATTR_DATA attribute and
> > reserves nla_total_size(data_len) bytes but only writes NLA_HDRLEN +
> > data_len of them.  When data_len is not a multiple of 4 the trailing
> > alignment padding is left uninitialised, leaking stale slab memory to
> > every listener on the PSAMPLE_NL_MCGRP_SAMPLE multicast group.
> >
> > Use nla_reserve(), which lays out the header and zeroes the padding, an=
d
> > copy the payload into the reserved area with skb_copy_bits().
>
> Use the diff I provided or I will post it myself.

You can post it yourself. Thank you for taking the time to deliver
that patch. I don't want to take credit for your work.

Xiang

