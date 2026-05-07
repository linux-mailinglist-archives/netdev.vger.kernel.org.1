Return-Path: <netdev+bounces-285212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BQFF29e/Gm7OwAAu9opvQ
	(envelope-from <netdev+bounces-285212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:42:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D77784E629B
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E67B303980F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559763C4542;
	Thu,  7 May 2026 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="UJ4ENShi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA8038E5C4
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146460; cv=none; b=Ct1d01wuMgl3HzvsMPOhFdPsLHGR96c1IF/yT3dGLQQezulHDngi1KgbHQySBgFnwBetVBoEN9EsW4wpClUW9ZjDUKOUeC5ZmhftET83C5lyUs1WkShOLMt47vcMnEyeHNSDuHIpKqNB/CBu800N2hs0I1dQq211ampB0j/LObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146460; c=relaxed/simple;
	bh=SiL0I7BTqDmOrEYB/RwFyieTxl0aty4XtD8WXRHHt7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWMVn8OiapLuvY0v/Owz1a/lgxn2fYfuUS+jOuZwZPvHIKKVPA9E7sv30sSpSe4rC0GiLofqTagIJDTb1Xw46E0JDGzSWitvrBrQNFrg9nmIq2RFSCeBq+/qbcJrxhkpYfQBTGnvvv3/lUjcvVZ4JXMmdMlp0WIraZ/Li0rwjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=UJ4ENShi; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so383861f8f.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 02:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1778146457; x=1778751257; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0RDPZxyyoA+nLVJX1tOhu7GRz/OpeQnLIvnlbEm9kx4=;
        b=UJ4ENShiWepzea3FlvSbyVzkrxv06OS9rK195BomMZJaYNxNPMVdIPKql8eg8tyMYM
         kfb0+VCzq+YZqC1FbDpCc5nwHABPrK4p9Sjc4oiaxEn6ehyovW11UxYlU9hBZdiqrQAu
         JXNy2bbCM9b2Q89RDFEL+pz9Hp5r0zOU3HF+qHFgSH4o4Qy7S/cS8Nv1pwDkVdPqaR7q
         RVoLoJph4XG9HBvebMI19zuhTawA0WQ7YdMtnAzBsL2xLTyFfQflSRB/D7nG8SF+c8R9
         XEvNCGk1qCFdv4aT3H+zGN90jsUZb9v2UfxKMBd5pOD1tt68SpAUmdDG88po5IsRpsbp
         susA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778146457; x=1778751257;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RDPZxyyoA+nLVJX1tOhu7GRz/OpeQnLIvnlbEm9kx4=;
        b=O2toy959OYNx6g3N+ILr+RV79GhCSNymxt5FD64xlFFlnq0xd0uDhR/0trAiJGpUdd
         ohagweJaVOuDVHXGsisry5NnUkAVd23GGwQiKZzih1VTFDvSEZo0dYXXNbyeso4R6Xcc
         yz4WQEEcwJu9OjrWF729moQFfyxjf8EiYvSVn73YzlB6wf1SM40zydIdRBZUPxoZhlS6
         WRmvIuZdIIsv0wsDHi/0dVhpRuu9o3fx+1FKrrNlxvr8cfKKjnSxbQSuMiBabDhKZxKU
         hzlMYVqqJv04dhpjgpCg+/pNwHXu7aaC+RPqbljo1azItdJKpkIXH/zYbMdgJslKWVq4
         V8Ag==
X-Forwarded-Encrypted: i=1; AFNElJ/GmXce57UR23QG2a8zqsY/S1k+Re9dGal4ZEdS2StZXDdfzuACiUcsAnozZ8Y0JFGVWxjal2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+6H3dLX2Z37CRE6vcEKp6VnGUNSPvr5zPMT8w/4c4YMeqyJ6v
	x0UUhNx7pJYSW5xqnjP18QLTD1KoXnXmiGP51NId7giTsjjWiSU3bnQhqv5j+o7JU3Y=
X-Gm-Gg: AeBDieunl0b5sD12u1W+clbyrgdLa4li2pHT6SLqYOhexMe55h2/2uC7O65uQ3tAMt5
	0iL3CMbe52911/x+Pxg9KD2DC0Jqqtdag910axaXXv854y7r/+FfTvLlh5D2t7S4emy9KdjxZXI
	jvyab0o8PtXdEdGXTaiJ5RStNDo8cCp++1873jCFI5n0JmSWDOKHIUF6S1xHXnsfNEVgzFc7p7J
	zpjM6Smq+67ss/zGFI0vPRy1yqMlOAU4MT2R8bwLz7qVdKOWU/Jczpng7uqZAexmt9dED5CjXIN
	PdJUIsfWDqZToRveNlh8Pju+tlUrUgHWP3dljACDhsr1Q/tOL6Imms/uhDMNGmNy6q9N3RZIbk/
	kZXsClMp+a3DhO7c9QFewX/NDrV4jGbpSXeVvQ+X0wTR0tltzFoGHTzA8USVp34xJu1a7UACSAv
	BcWLgDy5Wyxc/fq2VJkeU5
X-Received: by 2002:a05:6000:2c0c:b0:43d:7e11:1b72 with SMTP id ffacd0b85a97d-4515a6c32dfmr11386364f8f.9.1778146456983;
        Thu, 07 May 2026 02:34:16 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:294b::41d:50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505238e7c0sm17157280f8f.3.2026.05.07.02.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:34:16 -0700 (PDT)
Date: Thu, 7 May 2026 10:34:15 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>, stable@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Joyner <eric.joyner@intel.com>, Paul Greenwalt <paul.greenwalt@intel.com>, 
	Alice Michael <alice.michael@intel.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: Fix missing 1's complement
 negation in GCS raw checksum
Message-ID: <afxbZjldi1OC3HmS@matt-Precision-5490>
References: <20260501095717.1032151-1-matt@readmodwrite.com>
 <531aec13-c33f-4e77-ab48-de8861f9b6c6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <531aec13-c33f-4e77-ab48-de8861f9b6c6@intel.com>
X-Rspamd-Queue-Id: D77784E629B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[readmodwrite.com];
	TAGGED_FROM(0.00)[bounces-285212-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[readmodwrite-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 05:10:23PM -0700, Jacob Keller wrote:
> 
> Hi,
> 
> Based on your patch description, I assume that you've tested this on
> real hardware.
> 
> I dug a little through some of our internal changes history and sawe
> that it looks like the hardware has a register setting in its
> GL_RDPU_CNTRL register which determines whether the checksum value
> reported is inverted or not. In E830 hardware, it is supposed to be off
> (i.e. the checksum value reported already matches the expected setting.
> 
> Perhaps your device somehow got the GL_RDPU_CNTRL register set to the
> wrong mode and that results in the swap being necessary. Hmm.
> 
> I'll ask the team to see if they can confirm this behavior.

Hi Jake,

Thanks for digging into this.

I read GL_RDPU_CNTRL on our affected E830 and the value is the same on
both ports of the NIC:

  0000:c1:00.0: GL_RDPU_CNTRL = 0x0020a275
  0000:c1:00.1: GL_RDPU_CNTRL = 0x0020a275

Decoding bit 22 (E830_GL_RDPU_CNTRL_CHECKSUM_COMPLETE_INV) gives 0,
i.e. the hardware is supposedly in "not inverted" mode, which matches
the default you described.

However, looking at the data on the wire I see:

  - netdev_rx_csum_fault fires ~65 000 times/sec on this host.
  - bpftrace at fexit:ice_process_skb_fields shows skb->csum =
    swab16(raw_csum) directly (no negation), e.g. raw_csum=0xfb4f
    -> skb->csum=0x4ffb.
  - At fentry:__skb_checksum_complete the upper 16 bits of skb->csum
    are 0xFFFF on every TCP/UDP packet -- the signature of nf_ip_checksum
    adding the pseudo-header to a value that was the un-negated raw_csum.
  - fold2(skb->csum_at_fentry + skb_checksum(skb,0,len,0)) ≈ 0xFFFF
    for every packet, which means the two values are ones-complement
    complements of each other, i.e. the driver stored S where the
    stack expects ~S.

Negating the checksum makes the failures go away.

Thanks,
Matt

