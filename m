Return-Path: <netdev+bounces-278962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMynARKa4GlMkAAAu9opvQ
	(envelope-from <netdev+bounces-278962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:13:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9697B40B5FE
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 229A03019837
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3838538C438;
	Thu, 16 Apr 2026 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/TawbMl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCEA366074
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326906; cv=none; b=CvsLb26yf3KIa/1L4dy3nloicUbClGSqiD9cZSkoq6mgUH1z0I3syoqt/qGsGNb8VfDjF23sAInTnQvTJjs22HdNtZgCHMfuwcwfVc1Ukzp5FFAb4LOmGi4vm9+Lfz7GvQhZ4QnAEMmAN7dMXz6dQErXHvooJKnGFSnNH+9hjPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326906; c=relaxed/simple;
	bh=s+3UVoBDvxblYUM1ly3fzDYhmo1CwTMZpIbv0zMEM8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvAeJoxzcPrUncCh1uL65m9QJRql8i2IERLYFplnpYozw6hi4fSe6InrGn1pfRQHF9iBUWuYNm7zTAAxSKnWle8SHBGNR7C2aMvNjlyiGcogBe+goGgIuofRIYctsKOspDstuj5RGqYBZwrkfEAYnk7ljYeRtOdtVLt85orL8Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/TawbMl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488c21c636dso46736225e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776326903; x=1776931703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFC0F6y8Jyg8+02DJjO5zYJ1NpRXDdXHR5iqcjYsELs=;
        b=a/TawbMlf/ZFCQ9pO61Lx3ZMoMNiXQQjsL4CuBrB1IBz7EHzeKkcw/8eB5856UZRnM
         QR76JGNXvPd2ZuO3k6K5R+IRC3focZl1jhDi7wQ7IjZGGX08gvhrEsWrkxj+3hTDCbAR
         u5dwyg0WSIrtMWJusCgOCZMCn+ydg8cxhTT08MvTQjK1x1dbC365mfnQLX8Cb+dNkVX+
         wgCzz5cnyiUwg9NyhNQDiHUTNSJ3wNLSYem+qSXWX3tuyJQ6VET6gQgjrxe/9h8Qzq7q
         7jjJuM2eJkqWe/BuJiLLZZdDIIV7HPuCJQ+tSiTT3R7IZb9jyl/BZ1MWXIw8wpeWmQu7
         2YPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776326903; x=1776931703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFC0F6y8Jyg8+02DJjO5zYJ1NpRXDdXHR5iqcjYsELs=;
        b=DRsciAXhj7t9WPLRIzLtTJTDk5wmPEZxFyh92qjHhuthmyDpRBY5edcJQ9o0sMMOWG
         orxzQmb/wPC2jAx6SON4S3dXIb385Y7KDrkqSCF15rHvOMO1df0U6xcS5HjfVkKRCOy0
         T/qtZ+0xUsRPs0z/mGjsNretK1PFE10nd1NnacbxmYLb5b7dkDwuyvD38FhqW+RO2Q4o
         m88jAvohRjAQjXKUQ5szQyPK6fe/e8hBjiLsu2ikkRL1wthVTTLhKwZTx9ueoLLCARH3
         o+yW8ziK2y7ntXk20udmhKFVvaIl+H0i58bNWLWTFkHpfuGhllNwl10Ly2xJ9psPDNQs
         aHuQ==
X-Gm-Message-State: AOJu0Yx8vwwZ5P1ZWvzN5KOLG3Z7ff9D2Ykpg/edLXjenMZz73lEBQb0
	DcieJPgjmahiysbsoyoJGGebiyAk0KJ15suID5A8yHG0wC6HC6jSuLH8
X-Gm-Gg: AeBDiesVQKXaOt+UmXQXYwl2W9H1dhPw8Ww3Rq3cHTZV79fRIRmgCKgxSurNVt/h9he
	ztuszb3O+z83Bl0CP4esldXNRW65OcxG6EeMm7UyGQDo+PqVVIzSnUI43rzjKm3AKhznsOliwTb
	vBaImfhYYni4ZjL+1Rc6rx3nFoAcJRR0Ff0gY+Z6/XBC4Ch31K6qyK0m2nna5srqIYELCyp84FY
	xdvMqbwu/K7dXLhRjcKCn2QyzU5P9ErJ0nntcs70NNbWqzsQED22rtgx630ICI2oSyXGEBQBl15
	gX3t9HTRV29Lkn5QI/eROWmo1JE2xlaWqYu8bEh9ULn4jNMA74SlPrRUxrgT10syWOVH/Q2pY7Q
	1SOPcFvouBZSDg1o9WUupeB7qumEXITxwBY0fw31BAyK8tbID9A8u50SpeW3PpjVdWM70h87//v
	VsL6JOjydWUqVsv2eNzCI=
X-Received: by 2002:a05:600c:8883:b0:488:869c:eda4 with SMTP id 5b1f17b1804b1-488d689b4edmr242495565e9.21.1776326902910;
        Thu, 16 Apr 2026 01:08:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f08bdadbsm43966735e9.0.2026.04.16.01.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 01:08:22 -0700 (PDT)
Date: Thu, 16 Apr 2026 11:08:19 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	dan.carpenter@linaro.org
Subject: Re: [PATCH net 1/3] octeontx2-af: npc: cn20k: Handle
 npc_mcam_idx_2_key_type() failures
Message-ID: <aeCY88-gdBHx3JDP@stanley.mountain>
References: <20260416035352.333808-1-rkannoth@marvell.com>
 <20260416035352.333808-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416035352.333808-2-rkannoth@marvell.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278962-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,stanley.mountain:mid]
X-Rspamd-Queue-Id: 9697B40B5FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 09:23:50AM +0530, Ratheesh Kannoth wrote:
> npc_mcam_idx_2_key_type() can fail; ignoring its return value left
> kw_type unchecked in MCAM enable, configure, copy, and read paths.
> Return early on error so we do not program or interpret MCAM state
> with an invalid key type.
> 
> CC: Dan Carpenter <error27@gmail.com>
> Fixes: 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
> Link: https://lore.kernel.org/netdev/adiQJvuKlEhq2ILx@stanley.mountain/
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Thanks.  That silences the uninitialized variable warning.

regards,
dan carpenter


