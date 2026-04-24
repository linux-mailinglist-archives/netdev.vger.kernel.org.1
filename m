Return-Path: <netdev+bounces-281063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEylMyno62nNSgAAu9opvQ
	(envelope-from <netdev+bounces-281063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:01:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5416B463A56
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A1C1300102C
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 22:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3C5330D24;
	Fri, 24 Apr 2026 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="dmX33PDY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE4D239E6C
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068069; cv=none; b=P4gH+JH5vwEDOhqCqh/a220iqhg0rTZML7heuSC/P/rnn6ieRAhuwUHlVswNLH3+GPR/cI4G/UsqA5bONO44PTS+mDW3OvIvfGSW3B5M0MtX1wm3WcnguhuSk+O5JmZh+kTSQb2bvZ+KkcuU5i5J1FqbusxN+S1YeO3f2Vn5NVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068069; c=relaxed/simple;
	bh=Z8MToLMmTv7vX4Z6ouI/G4uQEhPx1JpDZt2yFdxB+vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoJWHukEU9HiriA1KhnsW0ufIK8JiS6YTXamOZMYfimT9f4coVZByi+QNuLYTf6g1DLR/Bs19h7pVVO/OqIqT4Si2JmnY6pFAcGc3ZOQG9b5fdvrfzs5slyo/hPP1y+LKeNQ/8SPYeZYEcHSVHaf4SJW+DvVxXq9q+KNKu9wJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=dmX33PDY; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbec19732eso7080040a34.3
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777068067; x=1777672867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU54WrT8vSKz2nv46NK69CbxZNPdBhrL3CM8N1zOX1c=;
        b=dmX33PDYb0Uh8Ieqorj7XWxY1gw4auirLLX6eC1//MmtMt9Dd+nnhrim5Oygfo32iT
         Lrjms2F+EfCKwy7bjTV5q5s5tObfAMDXNONBaLD2MEMSUblmdCCq93YdcxVSdUODYzyv
         Q2v9nlSIkL0zJcfz8PjyR6GkpenToPgU6/7FyhD7i9yz7tD3wQIxInPAygxTDJhGOuSK
         UHKsiawywH1kwyMqv2mSl93GmtZaWRGEXAanc5Rn/OoBOJ+ttm5o3EtB7wlxwLNBBuHe
         FoAkDntxZF9gqw831oAYVAtF1Orz2JRnHfG7/Vhi1C2WTLxGaEN1iweDF1ut0n/Bhfv1
         3TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777068067; x=1777672867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VU54WrT8vSKz2nv46NK69CbxZNPdBhrL3CM8N1zOX1c=;
        b=GcyxdLCsH/UGuW1ytGU9cvY97Xc2CMHJEKrYRES1NxylZP+ypFGTFfakAtPBM9XpAk
         uLfkogFDqW/7Kr2dPkf8pF+koTmMnsBL71M7hZkx7BLKPF+OCWj3QySCr+pYfEL7LcdW
         SDQP+FT+JlafDnCVETB00AYL0MNXCvd78t7L7puUH4yYgfvBv6YsQHONkFGF0Hvsf7UP
         Izs1I0C5d3tGESM/CmhYccWZ/nCEY+KnrjtChLWaMmoBieIii67+ZHiVU5W/h/ipnLNL
         Gyb6hNQHW+6NrrejFh9/czS/27f6lP3GlVEBzUdSFBH7xdsk198N84auaTd9NzuCIu7P
         8vnQ==
X-Gm-Message-State: AOJu0YyPoY2o/7oGjX9UObs6+E4Hdj33y5aD2guCLBc37qb0nVzilp+i
	e6f5uWBsEbEoXx25ST3RAVgyhb8FHojWKRO97MD2g99ai/qxFMoIGzqzu6TIi3zym7SziuPHYHH
	QitWC
X-Gm-Gg: AeBDietbhmwfOYWqpiY8IcLljSwiFbCYZqKqdmg3sDq43Lc33fwURok+5Cw2RYwy+Fw
	DCaUrCMu7Evo4q+qQ32t9BAqrLe6ASfnEcvD1RT3/cOcwbbLu+z39dNSvpNF2xdJML/M0adyIoD
	SVtRi8W0Hv3wP/bBGiFT7zoA5Jv0D3/7vHhqnKNqDjkLnQmzIqY9YsOeH8EyA+O+0EvMgCNjWmC
	tFM/JxQs/4tr4oFPmqbAmnnerxqlFBQ1uGwKVzfbw8KdGGmyuqAIBZGsICOs/3rSJ8PRMGFbX/+
	mGeyn1pqH0M6+8fOuCmr4s54n8MJbTC/RZ5GGEKbKhdc42C5pOuxG51DxClulzlFw59cbDG8JCo
	dkp0bP9qFxoDnEtlxjASD9ujG/mbf+fx6Bk+o43z+guNp0GG+kjujnknTcnzpoJL+M7jRt6BNLJ
	Stx2/nXhuBi3HKfeJwfA3p2hqBqk4xnUZF1TK5SHuhd9pTUw==
X-Received: by 2002:a05:6830:280a:b0:7dc:4a43:fb5c with SMTP id 46e09a7af769-7dc950fedeamr23445672a34.11.1777068066705;
        Fri, 24 Apr 2026 15:01:06 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc97616c11sm19793538a34.25.2026.04.24.15.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 15:01:06 -0700 (PDT)
Date: Fri, 24 Apr 2026 15:01:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sergei Trofimovich <slyich@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [ANNOUNCE] iproute2 7.0 release
Message-ID: <20260424150103.1f15fb4f@phoenix.local>
In-Reply-To: <20260424213233.4dabf6bf@nz.home>
References: <20260424213233.4dabf6bf@nz.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5416B463A56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281063-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Fri, 24 Apr 2026 21:32:33 +0100
Sergei Trofimovich <slyich@gmail.com> wrote:

> > Download:
> >    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-7.0.0.tar.gz  
> 
> This URL is 404. Looking at https://www.kernel.org/pub/linux/utils/net/iproute2/
> it looks like tarballs slightly changed their naming and now prepend `v`:
> 
> iproute2-6.19.0.tar.gz                             18-Feb-2026 15:36      1M
> iproute2-6.19.0.tar.sign                           18-Feb-2026 15:36     566
> iproute2-6.19.0.tar.xz                             18-Feb-2026 15:36    936K
> ...
> iproute2-v7.0.0.tar.gz                             13-Apr-2026 19:31      1M
> iproute2-v7.0.0.tar.sign                           13-Apr-2026 19:31     566
> iproute2-v7.0.0.tar.xz                             13-Apr-2026 19:31    940K
> 
> Should `v` be there? Worth removing at least for next releases?
The v ones should not be there. It was a typo

