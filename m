Return-Path: <netdev+bounces-263455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDxgCvZpp2l/hQAAu9opvQ
	(envelope-from <netdev+bounces-263455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:08:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D001F8444
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34C84302511C
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 23:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E71F390238;
	Tue,  3 Mar 2026 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="i7OaPcjn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7638836B
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772579311; cv=none; b=rX/mZbEMVQd5Lyyoe+RrRVELVle/MTfdVQHL8Wu6zp6ukd3PbyvIcE1Z/A6BU5hh3j2DpWZ6x3driS3zHbN+EQ6IIAjjp4TZ0l0aQxd8HWjd9duglwuJUW6xrd4i0vdp7n/D9zBgGXClEZMIfeCKgm4di8KY70r1C3KLSLaPXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772579311; c=relaxed/simple;
	bh=HUX0i0I7PlBuLWWVstQ2H5vKS+AgS7G2dCyg2A81XU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXRJXDy+u5tH/aY5nPvXA+Hp4040JzihRqk+aDjW0XWyCxx+6j8fojimYz+Lc4Im9Py7M4kL8oCdXkMbdKcyC1CGWlL7oj5IwSTWIY41Z8Jm54RR/Pc50H9ZXNkUuA6Xhl1KdiRaYUfcZl0bONQSYc8D2/95FMwnybPhOUjl4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=i7OaPcjn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82748095963so3106975b3a.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 15:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772579310; x=1773184110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyGTuCWGO45jPKeyWUndsgiqo1yT0pSCCNty9r3XSng=;
        b=i7OaPcjn20DCNz6lbUAWeHdkRg7dUSKjEWzTwdn909x0ZYKaUIe4Wtmuey5x0ThjbV
         5I30rNE1mlvKt1fPq0lxReuNEbsQ0nf5NnA8V1yVXXhBrWGDZ+hABjyAMc6py+yFLnQj
         NNxfoIoUVi0WNp+vxumzDdDCRShLIrZmtyXjKh9a4AD6IRpwaL8xm+RvoNRuYvZ9cWbe
         Z62stx7WU9ruYYgQ9VOF3EVQVOHRls4eWoNvWHUZh4OfjU4zxiEA40rZs4IcoAMOP/uK
         KepnM+/UKpuI7xZFyKdLCnyww5j62bnRs0PV+8LHgL7WWVnduudIsVOz5Pmtk3LChwsk
         zN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772579310; x=1773184110;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyGTuCWGO45jPKeyWUndsgiqo1yT0pSCCNty9r3XSng=;
        b=b80Nl36l8J0HiJDqA9vxENN6XY1eCQkvOB1ajeoyqimGUEA0g2VSsZg9VGxPafGKb0
         2WronBEWMoPcNxvmmbFfb0uNesWdtVENhvrtJgeZgqf3JUYPZAw1fTBlK48D94mEiSGT
         FKS+QHPCMV1t6TtdakPlrXstAfXZthf3YZT2X/TDwA8Q7tiPDT2U+miB8yOPDR6jz7W5
         x7GmALjhMm/eKuGHNpTUqYwOlOf8pmkEl2pZ1jRA1QVKUoL+0Ltnuv3bMJ/79XZm7QkC
         7hz9hxr4IPCXxhObUKNmthTymSLN6T8Yp4TDm/kEtjJO1TLm/fU1ntWidSPe5F4gOlxY
         usjw==
X-Forwarded-Encrypted: i=1; AJvYcCWp1gMSt43hz85fTBXnsQjNkUhHL9uVmU04EaMd7kkCNhRR8NbYxbcVgp9Yl6wYut5wV2r6kKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZD5LnqU4XJcJ4la2GDJkLPe6i48VzKtwSCnh3aBAGZmPERnsU
	n6+B+mohJLR6R5OF24ptLDAM440OMwG4NVJUvnh7y4bYPTkHd4Zci553hySdrVHKw60=
X-Gm-Gg: ATEYQzzk2HDp4145iGP4hSEKYOJ/oQZHn5SWpuzKn4M73Z7flvZ2GjLpTaRnW/J2T/h
	Dh+NavKXF0r0WjUanjmWlVRyJGeAmS4Tu24ixT1lk6z/lwMd30egioFDNiJ/U/VksdBrvAAuvdE
	MHUtSnRQetcMCLCeIAzdQ/+RRvjjMr9zqLJ9APi+bpkaefqVLXnaszffq7mlCP1bClHmPpffQKD
	bdMxiGtZkU40pC1ABj5TFTJ5QQfcyzmRjHfvkCCKwQ9p9K6XfkLLz8gtGHcac6OvBFoe07Q4qnK
	qSwAG3qiga1u45isOEJO22a9OCLBmXCrtUKZLjLuqdr8nMIKu8XWQW9O4TFsvPn86tJvHepppOP
	CRchbisMEeqQJ1iRVlHnX6kseVLgDetLzzfDErkKoXRSflPd1v+qdfo1fGJ/0XKKtx481mdgXE4
	B8Lpk8
X-Received: by 2002:a05:6a00:9193:b0:829:6f7d:3093 with SMTP id d2e1a72fcca58-8296f7d3294mr201387b3a.48.1772579310080;
        Tue, 03 Mar 2026 15:08:30 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8c7aesm21018686b3a.21.2026.03.03.15.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:08:29 -0800 (PST)
Date: Tue, 3 Mar 2026 15:08:28 -0800
From: Joe Damato <joe@dama.to>
To: maximilianpezzullo@gmail.com
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] igb: fix typos in comments
Message-ID: <aadp7PhlQMV7BFhC@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, maximilianpezzullo@gmail.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260303-master-v1-0-f180b1ad98b5@gmail.com>
 <20260303-master-v1-1-f180b1ad98b5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-master-v1-1-f180b1ad98b5@gmail.com>
X-Rspamd-Queue-Id: 26D001F8444
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263455-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:38:20PM +0100, Maximilian Pezzullo via B4 Relay wrote:
> From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> 
> Fix spelling errors in code comments:
>  - e1000_nvm.c: 'likley' -> 'likely'
>  - e1000_mac.c: 'auto-negotitation' -> 'auto-negotiation'
>  - e1000_mbx.h: 'exra' -> 'extra'

These changes seem fine, but codespell noted another spelling error in
e1000_defines.h ("Device Reset Aserted").

Maybe worthwhile to get that one too?

At any rate:

Reviewed-by: Joe Damato <joe@dama.to>

