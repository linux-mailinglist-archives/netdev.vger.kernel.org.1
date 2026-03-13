Return-Path: <netdev+bounces-267586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NJYKTNxtGm2oAAAu9opvQ
	(envelope-from <netdev+bounces-267586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:18:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45373289A8A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DA6E3012D2D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB213D301E;
	Fri, 13 Mar 2026 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="cYpTAsjn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A423CCFC5
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433135; cv=none; b=B+8IGtMzmEJn9D7TNydYG5v9kwbGYrcMZlbUp/CS3Rbg4IO2fBK6W0yQ+LjwnQNpw5OCr6ytyokBDMsr/A2HZO+DR5wbfB0eUkOpxO8qUBXPoS+aujt/RGYfEkGH7jqzRke0MaW7puEuJcALC7tgILC0gtUE6hHL8uNVCtwwvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433135; c=relaxed/simple;
	bh=53EVG/JlppnLTIhH695WvIPcWUTeb2QhCh6p8STGKP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9m9Fo/Xa2f4DVxTm6zRPBoYf1jZRrFBkTunV7YbdRMbmi3FqRXpm0GYJ6qFLMkt0V7ZOLaeT20jIKNAIC7DJUsLlXWuicQgHpQ36HRYDQbI+oFGxgvAig9Amxh8yyZFGwyMuK62tT1GAzTV7poa8/cqOm89R21ccqjWougJYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=cYpTAsjn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8296d553142so1241879b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773433132; x=1774037932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsr7CzjIw07IjEyEVK2hexe7Lo8E7E09xiNJd1OZ0GE=;
        b=cYpTAsjnDvJ2Sm0lIdXPUL3YDagh/70hsc/SA72aoRLP18oH4eZccuoEBnKTNXGbXB
         h4oS6y7NtZVt5YD7UovJbsZ9rNugXDsfZU1AAysPplgf9DdqDh2HZiHkdhBU7K3IBlxe
         hgf3/YF6PaC+W9TZc5YBuNO563Hcc2M+I3eMhpgmPmWI6c9rn0N0KFv3LoRVfWpmDU5e
         2f0Ge/w4PqYP4dN8ladkkZCqAxmo186J/QWAxaFEei86CKh1iUWBoRyz4tQ5e6wjuKwn
         3IN86Lks7u7Lnf9ctTAYGre5s5fM3hl2tQ7+ZogrqmlNB4mQgccmMgea2dle6Ax0NKu3
         VCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773433132; x=1774037932;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsr7CzjIw07IjEyEVK2hexe7Lo8E7E09xiNJd1OZ0GE=;
        b=Iu49pTREI//PVap27AGzOyKLzD7uTF0TQu0i75KPynL0rCpGLBf111AV3SiS9MaAXv
         0GiWFPn1E0Xpo2yPRHX1rb62fz5BXSWdOpD2TeJkpMvHJUUwtLfbyOR0jeKj/upMlp6Y
         AJoJuPwz9gVnUQ57ooZGKYZLcZ8cN8Lt/oz8jQv6kv2gNTFVt1ToshrwyAdCA/vzUVRN
         +6yLFFphwanvJskH5ej4Re8fVvgrv+nojYYGhOR3NFHZX9mBh6urHThWL1wAK1M4A8HX
         nMjK7V5ztxrgq2nhmvyx1udr2sk+B9IezxBYTaYDpxv0FMKMPIBHs34CHiwzHJURxwSi
         U7hg==
X-Forwarded-Encrypted: i=1; AJvYcCXa8FqZouvyOx8J1v41EAWemXuZSOArf0SrFkTnFkKb/14SJGOIiCtZI2nd7Fx7ykzF8a9aiOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO6fn+++FZX3Aqw6V/yB+C1OUMC/pGNM0kLoQkmUQa/5FUvcTt
	0wp9hH4IwpSdtofEiFHbFrIDETbwxGyWP/mEs/dmY7abvZKXKGaQrdjMLm6Y2Ka7MPhvCehLIHG
	D/bDe4BQ=
X-Gm-Gg: ATEYQzyOT3GhU4o23N8/BwsxcNWgAdvPSq+Zq8WPZaWNez4MPUoyAHL78Kt6MBfu5C6
	ifRVlfJiKa0rjITt2Px+r7001aYlNER/fm1FAerkMDhEPtKIUu8g2tapFob04ia5MbLxCZ0OzTX
	4iEO3nt4A9zvpLRp+PNGRi4v9nXbC0qRdjt8w77N+keYcuI/LvoQ8iTqt66Sx8xMRBAeLC6M6bp
	j9v7mNs+XaZrYj6Ap5Wuy4zHFyTtx8sukIPCC+d2mrd07AlmImCU0bXTPp9Taq821mE9XOBIlFf
	SOdYqFH47rXiGvJkBpQl03yJ7aa/V4R8t2hUMlmYDFI9dJHj2s8VkC62fmXkX+fLLsEztGs90tc
	nKXQA9ghccOza+xp/5FpjP2XuzDiD6M/WvcK71VelZehe4ZOt9UunbVpmApwj0Ua6DAASc4B3b4
	/OcYQT
X-Received: by 2002:a05:6a00:4f8b:b0:827:32d7:6690 with SMTP id d2e1a72fcca58-82a1970423fmr4569878b3a.13.1773433132539;
        Fri, 13 Mar 2026 13:18:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0734199csm6789430b3a.36.2026.03.13.13.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:18:52 -0700 (PDT)
Date: Fri, 13 Mar 2026 13:18:51 -0700
From: Joe Damato <joe@dama.to>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/2] net: plumb drop reasons to
 __dev_queue_xmit()
Message-ID: <abRxKxa8jD3zTjGm@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
References: <20260312201824.203093-1-edumazet@google.com>
 <20260312201824.203093-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312201824.203093-3-edumazet@google.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267586-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm20253.cco0.facebook.com:mid,dama.to:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 45373289A8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 08:18:24PM +0000, Eric Dumazet wrote:
> Add drop reasons to __dev_queue_xmit():
> 
> - SKB_DROP_REASON_DEV_READY : device is not UP.
> 
> - SKB_DROP_REASON_RECURSION_LIMIT : recursion limit on virtual device is hit.
> 
> Also add an unlikely() for the SKB_DROP_REASON_DEV_READY case,
> and reduce indentation level.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/dev.c | 83 ++++++++++++++++++++++++++------------------------
>  1 file changed, 43 insertions(+), 40 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

