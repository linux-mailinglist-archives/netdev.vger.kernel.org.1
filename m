Return-Path: <netdev+bounces-263446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEnRHdNap2kThAAAu9opvQ
	(envelope-from <netdev+bounces-263446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:04:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 171B01F7D5E
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41863304004F
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 22:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80CD3382C5;
	Tue,  3 Mar 2026 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="m29QqHME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C330DEA9
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772575439; cv=none; b=HUpF1Nso1zTO+rZEXGbrj8QTVF22DqP9QxKmOTvS7ai2trlLkm6AeAE4fTOTF8EoMmDmh0ny0IGBHUd+goPw/2Xyz+2+mPYDYGa8da4//Qovhd3+GyZABlWx0qKgx9d1Eu3laHEHaQRH+ybvhLcwDgux6lkKXggSvbcBKy23lHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772575439; c=relaxed/simple;
	bh=9MaNRFJnZxP5EJnY8JlnZjTHYbjkm7LYLNArTT+SG/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8iCtuKKJ0uvkjwXtj7bNKlmZsu53q3NywwQDmmn1viskyJjAGdrB9+ABieDoR6B4uDdRErP7h5QjRrdbj4rdaOIWHYe6RokhGTETTGLChV4BHIZaFunk9CyDU2+Pw530Y/swuT1f4tc6kCCNYSeML9t++nl2eVQmyjSvi5GSyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=m29QqHME; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82728e5680cso3396429b3a.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 14:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772575438; x=1773180238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvntIVdu2BVTaDx4UqrrYAWuWANSpPal7bpQbnebOtY=;
        b=m29QqHMEGKyo/EqrxLeG9B3PCNjxM63IokS9uxqghe0Ci7AXLjFnk4tJAeLNxbiHwZ
         Ij+cboatotUeC/brBcX6UiHsXc3rMwtTg0Ke+DDG5Zz+/cjViwJHA/FTHpbjq9HaZp9C
         KcG1HOuGk+Gm9jTqQmvwdkcjPVb7mbcnRi9pIpS3Bs15wFBTn2evvBGl/d3OFq5ZGgeR
         arllnT96lHvxFtZKvao24GZYvyQOxSioHkEpXHZSHuLTiXvnuwwaV0cxmV2XVAbqhEoK
         d6uFoQygH2/ctN1SS4ZCxAQ3XenU/q9R3tgBMNy30DS6ClmDgK12nnE6RdKA0AfgMg1r
         sZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772575438; x=1773180238;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvntIVdu2BVTaDx4UqrrYAWuWANSpPal7bpQbnebOtY=;
        b=ORNkwC0gqfz260f7oP5tzuLWgzlmQtBGXXVaQpc6eqH2jVdvdwSG4rq05x3bN4c+Zt
         2AgPHe1qP6DW03iX2qKc9ql3r43ZNTpE3ulPyxKqU5A+bs7e17L2SKcbjaJ4Gza1XqTP
         70Qp6XEEr1N0wK/XbZ3livVSkX7v3oLTBW1PtcilVVWray0ReYYGXsj5YD5IHFDbw2Sw
         e5LSgiSgadMkar24lpXcSW9YGAWXPkn9WmDlZCdMDSyqIBhrwLHsshq5rTW+y3hVCwnr
         feChRO1lzqNF3bu8nWOjUbein69RZsOun/QpbyTFPR6wBlOYtBB+XorO42Vigc8OywBk
         +IiA==
X-Forwarded-Encrypted: i=1; AJvYcCX5cvpnkk5bbtPMMu5gHwCTmviHO1gOUbj3W1PQzMA2s2bskXrBShuD2Uh8+qAUQNGx8ndXee4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOg1af5aWljCM0ZoGL54WrXlwpH8YBOaQxrH6/9dW61rPt//eC
	tkA+j1PEne9pAeMAJKDQ+cQGv9Zn/xlGOBexkAFxqwfm4p6qqz1s3CwKUpSQi1FJmiY=
X-Gm-Gg: ATEYQzzLmtCHp/x2YDJrYTCyu/EyLTB++2oi71lkyJl2O8Xmy02lmtkp9ZNDExlZi1M
	7KvPeKlAVD6pVtbvS7TtUb4FGFeZFHtcBNMkmdZg3qQkeMbgmvRjLCwtAbIXCUvhxGum/LAPy1a
	lOf2x3nP6W6Ezi98RPgbCfacX8LOkR0oVw5ID1f/ePlZ4IS/2/8Ka1QOV67sIiVTUQ20hxugiuH
	74arE9u7yz9l+iSBWpJpfHBiS0VSeqfVNmSWfITl89P3llIrCsz3Br/x3Ge8F31eVNorevc3vjb
	n9GePiGEuJiQtQebEtJD0ua7VP3s+fYVP7kl5FT9oVOMio2c6pYACzZyYoYLUxJXUt/fpyEh37N
	m9BIbxiRmKLHozWfojpYOQT8MTyVpXOE4PuBnjDxO5jigAbUQMZb089/eXBNx1EMFuZGJVvZxze
	1m4tU=
X-Received: by 2002:a17:90b:524a:b0:353:5c16:aa7 with SMTP id 98e67ed59e1d1-35965ce0e13mr14484562a91.25.1772575437677;
        Tue, 03 Mar 2026 14:03:57 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c105d24sm3211838a91.0.2026.03.03.14.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 14:03:57 -0800 (PST)
Date: Tue, 3 Mar 2026 14:03:56 -0800
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net 3/5] nfc: nci: complete pending data exchange on
 device close
Message-ID: <aadazAolRVOqhNK9@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20260303162346.2071888-1-kuba@kernel.org>
 <20260303162346.2071888-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303162346.2071888-4-kuba@kernel.org>
X-Rspamd-Queue-Id: 171B01F7D5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263446-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,dama.to:email,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 08:23:43AM -0800, Jakub Kicinski wrote:
> In nci_close_device(), complete any pending data exchange before
> closing. The data exchange callback (e.g.
> rawsock_data_exchange_complete) holds a socket reference.
> 
> NIPA occasionally hits this leak:
> 
> unreferenced object 0xff1100000f435000 (size 2048):
>   comm "nci_dev", pid 3954, jiffies 4295441245
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     27 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  '..@............
>   backtrace (crc ec2b3c5):
>     __kmalloc_noprof+0x4db/0x730
>     sk_prot_alloc.isra.0+0xe4/0x1d0
>     sk_alloc+0x36/0x760
>     rawsock_create+0xd1/0x540
>     nfc_sock_create+0x11f/0x280
>     __sock_create+0x22d/0x630
>     __sys_socket+0x115/0x1d0
>     __x64_sys_socket+0x72/0xd0
>     do_syscall_64+0x117/0xfc0
>     entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> Fixes: 38f04c6b1b68 ("NFC: protect nci_data_exchange transactions")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/nfc/nci/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Joe Damato <joe@dama.to>

