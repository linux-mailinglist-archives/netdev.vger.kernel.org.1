Return-Path: <netdev+bounces-263368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JQsBl8sp2mbfgAAu9opvQ
	(envelope-from <netdev+bounces-263368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:45:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7B1F56DE
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287F03019BB1
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7832347BBD;
	Tue,  3 Mar 2026 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="eU948Lyx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3328370D50
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563525; cv=none; b=LAOxpWAi7ksWQJNzOtK12iWAJUZZs2WG0z74X3RgekKoTHUjgJ38Racod9HoUqVriNCY1Gq7nFwiDp4CEOpSfg6WmIa810LaGIpmuhI5wBt6yrKf8j93V6HVXnTfhc2Nf2yuaR2jKKNIyBwRzI7kmnWWA4pVUWYKSl38mIffjt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563525; c=relaxed/simple;
	bh=/0ILQ7hw3gS6ZwHgbumlQjqi2DpelTsxL549Yob4aUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMlJjYx0ox/Etx4H8AVr466C3No4uQFe265D1+FA+AmBCZH3TyK7lVPm9yoHiPqKANnvDSsijTxTbsfqpa3GAzDQkZBwjcnk9CDG8Vdp8mEG8+hUDwMm54xdUK1gAJ24rz9GBlIa+jkW8d2d7sN7bU6/0pXecVAzTCzEfHYN/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=eU948Lyx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82735a41985so3617840b3a.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772563524; x=1773168324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wddq1jg/giJEMP/2BF73BaEW+ygAMyWGooCCfzuCZiw=;
        b=eU948LyxAx4PcJYjyY7c6QSdXNmF7pOEYXggoVOFKICzqgRBYgHbxjcqj34SeRWlFT
         ERyiFhhV6EfLPUZwhqJM3Uitb8+Kxdzo946vFUoFeKHcYYJtvIawh0WhNt6K1GGr6tBX
         kwUAXuqvU085/pcvQ8g5A+u0bEty0bS9tCNcI2oJjqB7QLSSQVjoqCg2uz3+62KC+mRk
         6GgY6VQ1t3GjbMS/MiKtosPQnfLjI72rfIzHPdpTiU8Dhdi0HmlDcr+E3TgrINsJBJbN
         BT5GvQ5xn2ywDXq0HCNj95BizsgbAB6iYrsC4Wva8b4780CuQ/aQNMTGY8xTP7ljk5zY
         Nu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563524; x=1773168324;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wddq1jg/giJEMP/2BF73BaEW+ygAMyWGooCCfzuCZiw=;
        b=khNarfY5Jka26rA7y+BDtEoNCFm5JwbH5gHZaYWABvDVaaTyjBh+KCQg5KCfqdNz12
         Nh0XkTkaEZas74lBq/91LKrue6l+4KO8i3CGwT8MVZDSv3ON4rKpUB6bQ+rcTowLX5Xx
         IytbW2NvJ0hrBhRZHWw9eQVvj5GjhS8tR5c8CJzB0OH6miisKwcjPB/d5TdhnfdlOasX
         Z9CLNEiJjyH+3C4qbZNFxQeNxwsdds+WY9wvpgy1ETZSuF7IousZ2b2gvwu8/CpaNxD7
         IecoXv12nxTfF7TRtW1B/qRP7kN9iYwApHwQ7nPpfL6roCmDFp1UyryzpE6IwjMNK+7g
         aUoA==
X-Forwarded-Encrypted: i=1; AJvYcCWqpSplsh/LcrltJI41T+Lnm3iKaNFMYUXDahyObWXGKZWIICTLB3FC+sAVb6GJdCA5b0IrxmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKQC8DeevtWPZSWQno1FMJZcuAz79jBI2mco2oMt7tcfKRvr4
	JLNkS1jGBE767DRteyEqcZpd7h111Ar/EKanwOziZSm++vD4tCrVsNsOiOQufhd18Ko=
X-Gm-Gg: ATEYQzzsONLg3p6MtnNeweI9jr7vd+3VWxlWT92dx/nft3oB9/HvCPFt/rKOHmlx32d
	6is53W/lK6Jqj/p8d34pPqRqLN8ceP8Rs1nViq/lR8ooaQ2cI1Yb7Ol12rmSL39LJJlIhZXD5p+
	K/nrszIIw9+dndl93VOWMkqFOrt9wov4tzhlihVvG+EkaGsntqznmETkCPt0xFwaDqT+7XamO8A
	iYz6fJtPGpKzOSDd6sF7MFJrXo5GvhZnXmm/hP67UenCH0KuKadRYO2TrRXjhQ5baB82SXZm+1x
	plGcpAexSCUQINSgO/ZtolvkCt/zgcQPhFYQdvwVgjRq5lHm54WojwLsha1/SDi0khAvHzBhgiZ
	E+F9o8ldqPbjeJmzBo/+sO8bqR1aXNG421yavcOU3NTfSIdu+A81dDm3hjEXwKLevjsTOF1x6ug
	2Gj9K8
X-Received: by 2002:a05:6a00:1a0b:b0:81b:c599:7593 with SMTP id d2e1a72fcca58-8274da5fdc3mr13561241b3a.60.1772563524070;
        Tue, 03 Mar 2026 10:45:24 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff350asm15746256b3a.35.2026.03.03.10.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:45:23 -0800 (PST)
Date: Tue, 3 Mar 2026 10:45:22 -0800
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] bnxt_en: add XDP RSS hash metadata
 support
Message-ID: <aacsQvvOoL29Rvyw@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20260213192449.1294830-1-carges@cloudflare.com>
 <20260303024510.644962-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303024510.644962-1-carges@cloudflare.com>
X-Rspamd-Queue-Id: 6CB7B1F56DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263368-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,cloudflare.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm20253.cco0.facebook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:43:48PM -0600, Chris J Arges wrote:
> This series adds XDP RSS hash metadata extraction support for the bnxt_en
> driver and includes selftests to validate the functionality. I was able
> to test this on a BCM57414 NIC.
> 
> The driver changes introduce a bnxt_xdp_buff wrapper that carries
> hardware RX completion descriptors alongside the xdp_buff, then use it
> to implement bpf_xdp_metadata_rx_hash().
> 
> The selftest changes refactor common XDP/BPF helpers into a shared
> library and add a new xdp_metadata test that verifies RSS hash
> extraction for TCP and UDP traffic via device-bound XDP programs.
> 
> Changes from v1:
> - selftests: moved tests into net/hw
> - selftests: fix pylinter errors
> - selftests: add check for no error count
> - bnxt_xdp: followed RCT for variable declaration
> - rebased on net-next 

Thanks for putting the summary in the cover letter.

In the future, you might consider including a summary in the patches
themselves to make it more clear what changed in each patch.

As an example of how you might do it in the future, check out this recent
patch [1].

[1]: https://lore.kernel.org/netdev/20260303145828.7845-5-ovidiu.panait.rb@renesas.com/

