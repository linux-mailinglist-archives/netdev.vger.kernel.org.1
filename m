Return-Path: <netdev+bounces-279919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHeuL3+C5mkIxgEAu9opvQ
	(envelope-from <netdev+bounces-279919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:46:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5684336CE
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 615A63028ED1
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40FF3CD8C3;
	Mon, 20 Apr 2026 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVqvz5pK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A43CBE8B
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714364; cv=none; b=jNN330n3iKR/jBM4IvSk2YUkjIGJCQq6IKiSWhA+xPZm9Ln5JUb9336YnnJGlke7+pngvkGj9fGpPpeVWP/F5aQNLQSuxsr28rJ5odtFVA8/PJ8I/HkYiDNLOEbuHAh2kiPxHanogUzp8fX8wMTwOVY9Mkictz/2gmN4yLMnAPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714364; c=relaxed/simple;
	bh=OvXrKzh6MXKJbe492xCBxiHB9QStXwZgAkK3MODf83o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jMBFAt+EVfGY4DbnsDf1AM9iJRqNed7cIv5haSMpKRM620ix091WI2lZHTKqaZRMZYHC3EbJAQw6zm5EuQKRyw8w+AcIcB9sMwXlTtfakaq20Jvkcj7IL8qMm6xypIKfb5V5AW1ZMLXC80oscGLOjssSnj1b2Elq4Ju/nnzQj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVqvz5pK; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a46ebe2beso34270577b3.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776714362; x=1777319162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRIdQoM5qk/CrQSoqc5ffDH7C7ZF2CT4OYbyaV3UOOs=;
        b=PVqvz5pKFZfIIxRVe6Yk3d6n1F0GwD4RXKMNmy897596rn3SgsVnG8KIziBLLE0PsC
         I9s7h0mAXKlJ8wO71D2BDZQx2QLeocAWpuDtOnzf+AXpstr1KYGYQbvET1om8kDWPAdX
         YmR6KYJ/qRDnM/iAkU3Ne8DJ2Z7fJrfOHjQ6MqAHLYWXBPQlTiMTtwx6ASHxc24QJgv9
         IjFkgezwes4XtxsayvlAhbT/qY6EmoBjyBPHwYflseev4ERJI8ynBlx/nQI1eQ0+hIuk
         781e1hQ8mmouhrtZnyoldtIFiJGQ843F9GhP4QI3tXDPWYlKSK4DRuJFKVfnMwi5KbDy
         b5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714363; x=1777319163;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRIdQoM5qk/CrQSoqc5ffDH7C7ZF2CT4OYbyaV3UOOs=;
        b=iy8NUXhLBSzNTeBNcrd5pj+IED8f0lQzMee9vU5eWWqlNjpW/u1JM5ncEAQ5dzqE6h
         ZsotUMNvJkiQQT1FnuplmG3tW5tc3eersVm55p0PSarLADRSn6h0Dl8gRzok0hmMbuAx
         OIj4fiMf6didzzUhm1MZOR9bL1j/4PQaKlEMmk5AvFxDUPonyPp7K1h9qaSPJS8X2sFy
         RW0SFPsh8qnYOSVEwr6eg1mS/effUl+IYm1mk+kXRvo529a9iCBajH40ow0eKVadlay1
         3PIfnVWeuqHfBlN3dql8u3UCXCiAotNixAuEshXub7Ir/NYaYkmLMHs4wleUmyz/pyUc
         K3IA==
X-Forwarded-Encrypted: i=1; AFNElJ+aUQRMqPUlMxh351hW9eY1DzExEHPfaHHkudRCVDPcHs7WLvGyk/wwmGRrEYz7o2ieb5HssxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzFFSkQ4DGlABiMml+4bqbV7YHIBWlGb9TBcx0i8thNXPcmGH
	Q5qN7fkOEva6NpR0CnvbShaE8kBxYLzw8CxzKaiFWeR5scUDuoE/kYzk
X-Gm-Gg: AeBDiev0PBKb/zYmfOVmXHckekxXN+q6mV8MzkNnQws+lflnUH3P5fkFWb+1wrp3xmn
	oLD7InyYpWrPkQ05T/XB1+xK/tONKTb1tDS4Ktki7+xEldvXLI/2atL0GAEubqp7ID7CId2Y1ML
	VKjIEJws8HzCv0GVFefxJERG11N1dTnfcHVSAGXOUOLtXAVKvkZi2GRh0RGrjHKt9z+uDg3GcfZ
	zx/kfCnQlHqZuOCwMsSOwl475btNSerQBz8Td6DpsfMkgeoP5yBtfbuqPpfduYbAQDzKLIimrZr
	wxGpTY8LpLZ3yFzyazw5V31zKz56SVwRZv9i4y4o05bWPaJy9Sx0yp4AqKrk1xDUw7iaIU+QHcX
	VXXY8GLBwiz+HCPX5U20oXFL8XA/F6I0IEtsP467Gud/nskVVfk4QdB0SexAdfmhe8yaZE2I0vg
	zVbI4n6jpSn9CrjMsKp+eEt0TJeEzEbNn2U82azWd6myV/i/nEfg7TxUTnZ7iGrcr9WkFfslYhg
	HZnCONybIiUDh6zecj5ExhJqA==
X-Received: by 2002:a05:690c:4990:b0:7ba:99bb:d4ae with SMTP id 00721157ae682-7ba99bbe028mr135603117b3.34.1776714362661;
        Mon, 20 Apr 2026 12:46:02 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b1e55sm47723417b3.37.2026.04.20.12.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:46:02 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:46:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.29253753e6c97@gmail.com>
In-Reply-To: <20260420104051.1528843-6-nhudson@akamai.com>
References: <20260420104051.1528843-1-nhudson@akamai.com>
 <20260420104051.1528843-6-nhudson@akamai.com>
Subject: Re: [PATCH v5 5/6] bpf: clear decap tunnel GSO state in
 skb_adjust_room
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279919-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D5684336CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> On shrink in bpf_skb_adjust_room(), clear tunnel-specific GSO flags
> according to the decapsulation flags:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_UDP clears SKB_GSO_UDP_TUNNEL{,_CSUM}
> - BPF_F_ADJ_ROOM_DECAP_L4_GRE clears SKB_GSO_GRE{,_CSUM}
> - BPF_F_ADJ_ROOM_DECAP_IPXIP4 clears SKB_GSO_IPXIP4
> - BPF_F_ADJ_ROOM_DECAP_IPXIP6 clears SKB_GSO_IPXIP6
> 
> When all tunnel-related GSO bits are cleared, also clear
> skb->encapsulation.
> 
> Handle the ESP inside a UDP tunnel case where encapsulation should remain
> set.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

