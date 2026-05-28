Return-Path: <netdev+bounces-292709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJwaACVUGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:41:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 043095F3D8A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09E17306FAE5
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC423C4B93;
	Thu, 28 May 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryAF6AR9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9B22475CF
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978544; cv=none; b=DSzfU253R3jVJZS4UJrIPH38iFwI4Jpgtmc/CW2+4tCkS1horiHaTfeQybK6KFdR6jKAdcX6lTSH6mTDch1I9xrJzzc1PJpxySuNNqsKJ0bYOQtXmvLzrtKgvfbThn35uLW5bDARZiKIIcDL1feTE/TvkQrFBTp3UKXTRy0Hbcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978544; c=relaxed/simple;
	bh=IrefFyAQpAFQqILK1eHAz0Ih9C2ER7OVE5y48RaXZDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9dbACRp7yY2G1LurhmDX1tL0JDi2nebSxmLl4CFrICr5ELsDCZozVI4Atn7muXd08UUS0LohF1UanWO7g4SEFwCvhGZ2VzlnW2sR+yylY1EcJdyeiilGiiPzSwS2erFw+E2C7pFDB4i/6e7wrjABNtJQc/JKeImIGcmeu+x/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryAF6AR9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so81775215e9.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779978542; x=1780583342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ0PThY26u3CRD4CW+SITP6QP3S+wGr6qROSdUOWaXc=;
        b=ryAF6AR9lhvGsa/FBKZUM6tHpamYzfDt23bDcrjb9R1IPWmNkz88EHDo3C2qx65pRQ
         wYNayVUvO7ZL3NL7Jja6Bfa4LZnJllsUGxOFUXv14NN+3WG5wRMLMPHp/fzmzhDiemkW
         EGGDKfTE/9ujGiaIqxHBXZL6e3ZMk5KjbFHDMmRW/xiR5jxOeh7rnrELAwyRrRg+Nt/7
         VlqABa8bFqcw+LydOFy2oMgpCLuHz8TUeq9m9w/3xbwzHIzc3bmRHeTCkn2PDsCEfwR5
         taLveUss9DsHlbUqUx9kKWJ/TZsWeIEdhpRohAo5OjLGggXi/OflU7zwaPua5DsYoX9N
         nFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779978542; x=1780583342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQ0PThY26u3CRD4CW+SITP6QP3S+wGr6qROSdUOWaXc=;
        b=s5q/UNhq647nHo+JP1w6YxFgOuxzbn4NL4kK8fYUduURCJMXE4mtW8NiXFIcPtjt77
         RPAecLv1k5yvA7xwWXUPNtN0WKq29Bu8xSP5Cq9Z9HpQO82nrruoBuOFfrCFsBzaG7IG
         IDViLR8S6gtMlvv8xHCIsusvhd1yIi90OWfk/wNhJmaP2M6kBJF9n5heYbJ/q23y4HOc
         nSiubJ7vC+5cwjP1JLQqwohiLiklVIDeL28wSxmDz0uALspINSTOi1Yb00J4Z+1TQHUT
         dJZH2jMJ3I56eMixAwoySTE5DRCgD+O/N4XMQMHN1shMZxuctbDeESIAEB1CLm5KMPo0
         ymVQ==
X-Gm-Message-State: AOJu0YxuNMt4wwH9qS6PKBQOq1z/6lNjJDP918xEUMu0EUzjn3jHronD
	KM0rYUphLDSrwxdxuep5iRmDGsLN0oLiDSW0XpVRrvyVcTUWrxd0wX0d
X-Gm-Gg: Acq92OH1yUehQGfdSm10iaY8tf4si8Zw3Gnak4345a7k4xoctKs0OCjcMviQYzl9bV2
	WcFLS7gzBb0LKeMt0P2vDdpK2t1oJS9b+n6mRzti+kp/dvICKttvJWaxL6lJkyjPDqdq8E9W7Hx
	i0E9IPMCKxx2LTKk5JxoSQS3QW6q2KqFkt4xIQBE9sS/baRi95hj8GOHwrquhr9C4Sx6+V1wvYl
	QqWldNfB7KtC4UgfsLyFDhVDmxWkt6GPPmsyjbycmZ/lxp0utw1HebT3IgUgi/4h2EX399FJF5h
	YW6Od9mvhEBANtc3mu18h/9bKQ5FeoZG0vNoSuLU/AZYszKFwNLiPB8ZBn2Le9XsfVj10RmSSpM
	phNXFbKUcWrG4uP6XyaCYlLxB+6CSlGSCSWy6OPCYCqWAHmIA57ZRFBFNiFI2B1BTrNKaRne35E
	Byi1mtK1aS/TEqkKgYJMQ7gI9udqpUiNQ3zI5CnxnRsH9E+A==
X-Received: by 2002:a05:600c:1d05:b0:490:890a:da46 with SMTP id 5b1f17b1804b1-490890af5b5mr78417835e9.2.1779978541689;
        Thu, 28 May 2026 07:29:01 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908eaada7asm21989115e9.8.2026.05.28.07.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:29:00 -0700 (PDT)
Date: Thu, 28 May 2026 16:28:51 +0200
From: Oscar Maes <oscmaes92@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/2] pcnet32: switch to napi_alloc_skb() and
 napi_gro_receive()
Message-ID: <20260528142851-oscmaes92@gmail.com>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
 <20260525125437.4061-3-oscmaes92@gmail.com>
 <20260525084528.547fe263@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525084528.547fe263@kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292709-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 043095F3D8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 08:45:28AM -0700, Jakub Kicinski wrote:
> On Mon, 25 May 2026 14:54:37 +0200 Oscar Maes wrote:
> > In my testing this resulted in up to a 25% RX throughput increase in iperf3
> > tests in both directions.
> 
> On which platform?

Intel x86

