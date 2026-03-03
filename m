Return-Path: <netdev+bounces-263417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN/mHmRMp2l2ggAAu9opvQ
	(envelope-from <netdev+bounces-263417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:02:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D99C1F7100
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E820D302965A
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70025F994;
	Tue,  3 Mar 2026 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Ue6Pj4CG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2831F99F
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571743; cv=none; b=NgB4+v1IJYGbE0aZCmFQ7KnGtCBwo+FfBZpy658rGoUTZI+INfBU62f8IsrQhx6VE3aSl8gezd+aFu+sAlFTxhj/haIT78+/xRV0goRJ5bCbpavE5GGoNM5h+yvaaKiT3w6vcI6KWuBjsHY34mqSlWrwNNVYwz6wD5e37QYIQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571743; c=relaxed/simple;
	bh=ORvWY5lou6kfxS7HEbwUwWtrjMJe6cBzwfq5Lcsus2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EODMFjnmVX/YP2DFQtcZxPaSssAM6oUGE1531tBUceo/RyXA+3s+TTpNHRbAc52JrzJYRtylB+Q1UCAneh+dt1yMbe4tYNxGP10CBXebh2CnJe/V+xlQlvVUPZOHYocHAgIlx48/c1peoa6GsQExNXGcnhhny5uzFzQIOEFzvyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Ue6Pj4CG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82735a41985so3686244b3a.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 13:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772571739; x=1773176539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QK28LuLqQ+GK7ESZCGOcUnyt8e+LKU3myYEiDkza/GY=;
        b=Ue6Pj4CGwkY9Akv6ICzg6J6sjamJtP7XZobtohTEcjUPPndZMKkt2aapNZWgQeI+Ue
         fIB3Z1ME/Iw+OMTeWv4NrdM/938+q9Q80ycwiUM03FNJ41U55jH2LnnkgjwvwqYXjv22
         bU8OqYpSG8pOfvHDpnf8kn2ZKAzcObLNSuUxiOC/7RMl/8hDM2HNmubkfHt8vRxGPpwQ
         KJD9uxLVouECcvlDPP2TsLMdtGKNexs+u5fT6XSPoJWuJDN73dU6eyIAMSlrMbrSaRpw
         TIBCiaAxRw9HHtMnw663a7bEly15m1xwJT5qxsArEh9Opya7xP/opnLQoBHFer9/30Ib
         yusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772571739; x=1773176539;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QK28LuLqQ+GK7ESZCGOcUnyt8e+LKU3myYEiDkza/GY=;
        b=DJJadVyYkHD9QjL1h90q1rIFfmJH8MEDTJLufErlJkv0yTPJdtX6VnUIhBbgsUTDRk
         7e5KWDF7x++IUUlzoo8LZIj9B/AFOLUhvQBtI5c2LKrXFKyituyX7CkgwcWLUvMUxzHA
         jxi+dfaW+WlNftIVrif/ID1bNCua8Xex7IfqosXIoew92+pFjWBn6MA9E4FCPs1tVqIf
         CPe7EFax4QuolskyFEFDi60wDNJRCuXPKVuujMn7Qc3dPF82mjBac5eUqtSDeLrg/S6d
         l8Y/8hEBvS2Q0mDO1sV8heDV5i62H43pjX/45lJnvd/nKetV6Vg7dIUux50iSLM5yKWg
         SHuA==
X-Forwarded-Encrypted: i=1; AJvYcCX0coD4jcZve2F6lRwTPp2kQX1OAaQ7gCfOA+NITFSGAu1IuOgUBcx3UPoUnBWerIAZ91dUMxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo550OU3wheAuVEznRw+GhtV5kjwyckdoh2gIKPW5vze9pMMOh
	Yi5K4ROkvT03bpOnIBk3syDYeW8+/AbcucvCzcRN7jDI2KtIXtRCbE2ZzbjKl+wCODfrL4WUCh0
	DppqHirk=
X-Gm-Gg: ATEYQzwkrMu37wX+RHCWz95f7c5qgtVTWx8+2xFZonfxXOAo4Iz+1XF78OyZWIcgVJD
	cu3lYdMXicMwJ+xSow4AIGv/s/HAZaMOhv48BPdHPPmsM+imPnvKHSyieBx4r5gaF+vNtkifvVX
	wbOUEMgxGqcd0+x3EGFJi+q2lvOFrirxA20fXgJ+5y9KA/ZwGCPgDvZmagCOZM6ky5Wzf1OKU6h
	CateupwTNMoYUCILTSShc5U7AZedf13r9nn5VnYUQxth9faOM1XFo+eFomqpj1PHoqUABXs2bPp
	iQdSGUoIO656nqy0XKiPfldAuInNHYxO5PQeNIPi48qDjUX5nFknta9kFcs2eIh1IMyrbB2cJG7
	HwPTgTgjTFDiz4cBj2Q2/ImHG4KMdBthRQVexn186ZGybH78IpPNbegGl5dS4XkrSrArGudxegJ
	iQeJw=
X-Received: by 2002:a17:90b:524a:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-35965ccfe99mr15513265a91.23.1772571739013;
        Tue, 03 Mar 2026 13:02:19 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm4057328a91.16.2026.03.03.13.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:02:18 -0800 (PST)
Date: Tue, 3 Mar 2026 13:02:17 -0800
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net 1/5] nfc: nci: free skb on nci_transceive early error
 paths
Message-ID: <aadMWe0YaCdgFxKF@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20260303162346.2071888-1-kuba@kernel.org>
 <20260303162346.2071888-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303162346.2071888-2-kuba@kernel.org>
X-Rspamd-Queue-Id: 7D99C1F7100
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263417-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 08:23:41AM -0800, Jakub Kicinski wrote:
> nci_transceive() takes ownership of the skb passed by the caller,
> but the -EPROTO, -EINVAL, and -EBUSY error paths return without
> freeing it.
> 
> Due to issues clearing NCI_DATA_EXCHANGE fixed by subsequent changes
> the nci/nci_dev selftest hits the error path occasionally in NIPA,
> and kmemleak detects leaks:
> 
> unreferenced object 0xff11000015ce6a40 (size 640):
>   comm "nci_dev", pid 3954, jiffies 4295441246
>   hex dump (first 32 bytes):
>     6b 6b 6b 6b 00 a4 00 0c 02 e1 03 6b 6b 6b 6b 6b  kkkk.......kkkkk
>     6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
>   backtrace (crc 7c40cc2a):
>     kmem_cache_alloc_node_noprof+0x492/0x630
>     __alloc_skb+0x11e/0x5f0
>     alloc_skb_with_frags+0xc6/0x8f0
>     sock_alloc_send_pskb+0x326/0x3f0
>     nfc_alloc_send_skb+0x94/0x1d0
>     rawsock_sendmsg+0x162/0x4c0
>     do_syscall_64+0x117/0xfc0
> 
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/nfc/nci/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

