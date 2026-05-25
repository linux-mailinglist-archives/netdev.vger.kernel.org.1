Return-Path: <netdev+bounces-291371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK5NGFB2FGokNgcAu9opvQ
	(envelope-from <netdev+bounces-291371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:18:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 309BF5CCB52
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BF033009888
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BA13F58E9;
	Mon, 25 May 2026 16:18:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AD3ECBFE
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725894; cv=none; b=eYIBfleGVzZsPJlQaN7/JHClqu/pdeJO0uUxVDHj3f2doqdiC0uME0mE37uwVvf/+cdJF9fzo8tpSaXJjvxPWjXPjMBzT9vwLM9Sy1n9lVUQPkct9T/hEkohJwjbmTeUAyHGXYae0r+oFxpSG8b6NS9UltM+Ll2hdWl2Y0MJ3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725894; c=relaxed/simple;
	bh=6wzastg+LGn+AnLUSwWMIsSPm0Q/7W6xcAXZdYu344Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAwqjofZAd6zAItJFWB4lM+7SemuGyvJvh2iYbfCXl0m+VqzZj3LM1iJzkoQQqGAnd+5GY7uDxht+7xIucIUrug4ZN/eWl3A3j7p2w4XIBC8DYe8zM3vHn13ZflFbM8iMAIlh7t2vhPuVr1Xwau5vn+4LNFgECKDsyvAw/W8jCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so40433195e9.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 09:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779725891; x=1780330691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gd2dKhw8uPH+jWxMwt1nfkNcZ1vI2XMz+882+9WfcDc=;
        b=auZFGjzi9221hFJW9ntSd1tXuzgIFRBFcDIjfjf7L0q11A34CGr4lFJTVDUBrkXmEZ
         E140jpJj1crx+OdtznIcibL4b/dnH2rsADpRC8aIRMZ3o8oftKoj7gsRyMlNCh1tdeCf
         vGJaKrEq+gf8yeZQkbBdeKgyvRkGfJjPMXzIR4OXTeAussi9rHAB8/BHRcxw7VlF9cx4
         3okonYWMolwMVI5lmZIg8hIjrMq02tgJ7CR21BcHb75ZRAGpmThh2E54L1jXQ9QNQA0E
         X9LlQNoK+8Q1zb6pbNfTTU5SfSINPhI/d7TwWmmwVlWadMXBKCcs+/WRI3H5rWQawKGu
         RW9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/iwqjJaMfbgJ+tNTTtJFdWMDmN70hUTmCEiE65t2Bd+41UPQzQxlp3rviX5UkzNEf+GZn6aog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5dbKNv1XlotqU9ITwRvUNuMdpH6j35fK6XIoX1z6TlZE9VxIw
	6vMIG/MMlkfmdz0NheUiRvSpxGi36nrWLJ2nCw3f0Z7sI9oHzOgEZXgU
X-Gm-Gg: Acq92OHCfoIbhGzyBTv3iXVrGU765YPDIZHmN7jy9adRILB2u2MNtcKAktJvfksciZg
	Ryi7xm8ckZvQAbAfXPNrtNnt4eR9Tzw8FJyFLBYUOlKgX8rbi1eQKQbN7f7/C6TdebIfrqctZmN
	ujHWWI3QhAmOl5y6uFWx8yZbOi0ZblaKNriEow4Gh7+kpiRQTqtYU8XJ8tf/c4VAAedMnzF6A5c
	EwbYFs+EyX2Us/yQvks4hfqQ8vrtbM+eNpa36w/BQG7DJKH1G+o3618jnhoS77ZGiCFs/LJeloH
	RYPW7gOgjc91ftU1qlGFqG6rIgeH+4nHt3+qkhcDFYntWM1pM7hQzObkTbZ54755B/w7xWAqeEm
	iCL8i7c2eeENW1eF5tUPSNuTgm/2Mt0aA5wRypJ2QMCuQYs0Oah3OAgOuE2cCCuHqyqd9o6l73n
	TSCcFiInY4hxHw3fn7lO56LQ1nuw==
X-Received: by 2002:a05:600c:1f8b:b0:490:6869:9601 with SMTP id 5b1f17b1804b1-490686997b7mr55378795e9.6.1779725891357;
        Mon, 25 May 2026 09:18:11 -0700 (PDT)
Received: from gmail.com ([62.197.47.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm273760275e9.9.2026.05.25.09.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 09:18:10 -0700 (PDT)
Date: Mon, 25 May 2026 17:18:09 +0100
From: Breno Leitao <leitao@debian.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] netconsole: Constify struct
 configfs_item_operations and configfs_group_operations
Message-ID: <ahR2HxbR0ogYjkIb@gmail.com>
References: <7ff56bdb0cee826a56365f930dcdf457b44931df.1779711734.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff56bdb0cee826a56365f930dcdf457b44931df.1779711734.git.christophe.jaillet@wanadoo.fr>
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[wanadoo.fr];
	TAGGED_FROM(0.00)[bounces-291371-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.605];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 309BF5CCB52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 02:23:00PM +0000, Christophe JAILLET wrote:
> 'struct configfs_item_operations' and 'configfs_group_operations' are not
> modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   64259	  24272	    608	  89139	  15c33	drivers/net/netconsole.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   64579	  23952	    608	  89139	  15c33	drivers/net/netconsole.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Breno Leitao <leitao@debian.org>

