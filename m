Return-Path: <netdev+bounces-279921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AApJOVKD5mkIxgEAu9opvQ
	(envelope-from <netdev+bounces-279921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:49:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D79433740
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52E7C3029255
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FB63C2765;
	Mon, 20 Apr 2026 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eipjT9dI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFAD39FCAB
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714547; cv=none; b=hqNdYCV44x0l6IN4ELwa01QpFKTG22UzZl2gGjBU8utuuqDTAWvZeT+WncKyfnHfhKLOV73d+58Fk/LszosecZJRoZnGLZghWq5N8ReaGjNmxjvy6idxH1ChziW+XqnUXWry0J/6IepKxoKK0dsMuOG5s7K5B1NaHBxpFosndYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714547; c=relaxed/simple;
	bh=RvxmqShgoNfRbdSrDMGgU9v3sO/CSHCNP0968kgV2bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk2zgbEXEOdRVqVTlhjuxh4IE4VGqS84Iye3BkuRBiyJ3hYumjp8PguoVqm0rQw+fmdxamXR6CnkOUCf1f6ddK/bXxXYJAiIVsOl6wi2HPcS7RB2+aGO4ibKeFEJJXBmn8d/z79YdTNOknNkrQQhuJVOUx20fU4drNO9AJmgX44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eipjT9dI; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-4152698e745so1380632fac.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776714545; x=1777319345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6sEVNyktJT3zTdcB1bcpogzWQ9r6pcoZ/Pg+Jhahbc=;
        b=eipjT9dIk2LWfawcTMue8OU2TtOSQjmu2kW0LoBIx7v1yCZYFVB0fcwcHUG0yKtc3C
         iL9LOD8PQgGaO8RIJAvOpOi/Tafzhjnl+eokvdKjUE4f59oYziu1Z9ZIeALeHkvbcyFV
         dm28ydDIcNpdtGmkphnfYPfNGNnG9tD6LZnGaSJw0oXK0k/1mYsuX6g34D1adzhFSFoF
         hHzljpNUH3MEYxYDSMtqI7YdPsiQdPy8ucxMBSeDU5zZwV0skEcoHLql9ZaN6OuBYWzc
         +tEhSqt3E3g9REdVkmtC7MKC/lQWePcLyKWAzuqtgB6uycKrAe++Ns8Khv+dHOz9l4q3
         b3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714545; x=1777319345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6sEVNyktJT3zTdcB1bcpogzWQ9r6pcoZ/Pg+Jhahbc=;
        b=ShMbb6xaHDhlwoifo94nQWrymAlg41vBOzN39DbsKILMB5sAZ23cTep14HOtSG7k3Y
         9DRTKZw+s4drr4zO6IFs77ifRcbugKc0i+iiUW4u0gdIWTXfXulTuzMejMa7GLKuzwep
         rryraSTA5vXdbWi7jqiqZ5WeA0PPYbJ9xUBy1FUNFAQTk562LFbrDJwydMo4Qgt2kmZF
         JS6XvJtRyuu1YIprjAS0A8XJiu35XFRTrVfI8bhvRcgIGTHZWHfLi2SGuk4hpClWWsx8
         224LgHuXgKxRxXOyRpAYGJ9Lu/Zuo10ycLbRO3IdwgsHRlQgyZZ6nGEYD3Pk2e/vsFpv
         dGqw==
X-Forwarded-Encrypted: i=1; AFNElJ/LOfMUUMo3l8iAoMtL0dohRh0qIGPjaLCdi1v8Tr44yNp2UM9EwInmKmRU5LavsvJDSZyNe4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YynicNhSknWUW9ezRX0EXQGUcIiTmhtERs6dHXDLc2cJHOMSWyR
	kZ7aP4Z3czePg4GwH7gz4iwgSzJaS1gDDY6bxLxodDAc9hP832sMxFlN
X-Gm-Gg: AeBDietYmCV1UMlTYcSnYcmRP1POIl73NqD3TQqF0y1ngwBHd3DXt0TyHvsCo7G5jhn
	8daJQLDwhOh2E46Uf/yGSoj2e1UwCh+c+kKTxJey5cgi1Nxrwdbg5wDsyNaR+YgmmD0PtFeDds1
	ykiH+0ZOH/fFH3jBGVds9eN9slgfpCqk+RhLBQoakczD9kGcpRAgGhDqAbvI6dy2NkMEFtQXY8r
	qDbtMRYFK6xluPgtPaZ5Nu/yqINdD8Ut7/nmSjh9ueAh4mPkIlh1aS7m1zfA+9/dVW5LnfUZD1V
	mCQvTKidDqiGZ5WFqsrFeOEn+aQQb4J+LO/DCP2Cs6nGT7IsIrO0Xb4/jrVLddoDDQy/EjLegU5
	WDZR+n9SrzA7QRloxTOFl9JGVgFALtE+wAdGQ65IR21hWpiGu+jQObos3CqzAzctfXJo4CBAXM2
	/nnFwv585T13FUcFQyLBPdYqlVyOpFCYnqOi2bOA==
X-Received: by 2002:a05:6820:55c2:10b0:693:7a6f:b317 with SMTP id 006d021491bc7-69462e20f32mr5089979eaf.9.1776714544742;
        Mon, 20 Apr 2026 12:49:04 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464fe6d3esm6324400eaf.14.2026.04.20.12.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:49:04 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:49:03 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v2 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
Message-ID: <aeaCzchKwsp_LWyA@devvm17672.vll0.facebook.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
 <20260420082805.14844-9-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420082805.14844-9-kerneljasonxing@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279921-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49D79433740
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/20, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> uintptr_t cast:
> 
>     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> 
> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> mode the chunk offset is encoded in bits 48-63 of the descriptor
> address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
> lost entirely. The completion queue then returns a truncated address to
> userspace, making buffer recycling impossible.
> 
> Fix this by handling the 32-bit case directly in
> xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an xsk_addrs
> struct (the same path already used for multi-descriptor SKBs) to store
> the full u64 address.

Is it easier to make XSK `depends on 64BIT` to avoid dealing with that? Does
anybody seriously run af_xdp on 32 bit systems?

