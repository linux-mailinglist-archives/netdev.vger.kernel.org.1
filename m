Return-Path: <netdev+bounces-257993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id meVBJJtaimn1JgAAu9opvQ
	(envelope-from <netdev+bounces-257993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:07:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C3114F76
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F0D7301227B
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 22:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B6A310624;
	Mon,  9 Feb 2026 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="BWZL/KUa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B730FC05
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770674840; cv=none; b=c8Qh7xAqyCRmAvmzESuIj0t7iHJfkIxbxjplzJ+fVy90MCfFvVWfn1n5LXTZ1f9c2RjlWNclwqrIJFpfJ1co1Z7ZSCFIeAnzTLIESIr15jzlWMDyLkHrVtxSs7Hc0lCu2N4XWDjxSY9hH8sSQlUYvEG+F9tGgEhtQVVaMgIVbfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770674840; c=relaxed/simple;
	bh=vODExa7EwNTcP2wp0wh1Mrsn96I0N4H9pH21s1NIrd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI+xXZYxBhqEGCfARYba9c/P5YjbYMP23ZpcX2CG2B9Vu5FGsHtsSXTP5p45MJ1KgSo9VDSn9Gl8YtO5kuhiQY1Ud/R19Nf12pLFtdZbsnDCO7VjIYNk46xZ/3pKPg/z8Sfk/T2yrogagps1dx0dcUZ21TYznbc3fXhQR8D2JVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=BWZL/KUa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a95de4b5cbso28079155ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 14:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1770674838; x=1771279638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaPyzGirSB3lcpLfzgErgNG4q2gAsYjNo6x8UO4wYac=;
        b=BWZL/KUaRI6lntOD4oHFxYwJDRxyh2hxxUiym56OPXU2Ee/BnLGYVGdnKyWw9PTpH2
         TtZsTaSy0C3SWH8/iltO/jH1zlcg0AB/rFFPxjN3QqLFrhMgSueEdzyXUwfz/AeylzU5
         ky174PtwHbgfFDA2iji19FZATZ78gUWfRWN7O6WBydeHmYweigovLrf7scNaW+KyPzwR
         R0VZn5zHWO3UZgxasl/Pp+bGo/v9jBOZY5iOFO+L1KvxAM418vGLrwek9CaWSQy6db0z
         +ObQdzzPdJkDnIfqcRtM6XY1TG7wpXNStO22Ea+eoPZtbCBN9ZsI8ARdtgn48NEMi08H
         suFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770674838; x=1771279638;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaPyzGirSB3lcpLfzgErgNG4q2gAsYjNo6x8UO4wYac=;
        b=bvS9qLfQ9aAdPA9/DG1vZL9v5UOCoa6XpJwYFWOa1/tgsO12txO4Qdq3v5eaw8RHA3
         tgNODcSpWrHneo75H8LlnnvxdsB8rnqQ9ygmV58F18KgarIrjUrvSQU322xSGXDddoeI
         qACSqxmMSs7Pxmyfa0Ao1aD7xGtTmf320ZphbROXaNhSG09IMG+KBNMr4NoNdtMn8xj3
         v2YOS/OUlhpcYNeiQcJi3vAxkE2z/Ifzm62w4E2b/ioy0CknCXy8o4mOiQABn/9/GOAY
         nSwSxDYpYFLWT+oaSfVjkgqxo2PJA+3T8ldsA5sglSScwNdFLaPsdEHMasN16bRVRRFn
         JhTw==
X-Forwarded-Encrypted: i=1; AJvYcCUYXVtqOCgL/7K0RSOwAu7n03xnqi5RaDwaZPavy+cO15j6uKdK6kaSupL5SKug4oagPwquEc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS3hzbaPnK8cwsDXDtUAU6df6TR0kWoGRe7B8xzL6JLnqVfR4d
	d9yFi3l6/IKkHo6KfOH0RqIRWlUo+KZ7iDUSAxmKTeAyojn8ptGmDbwjMAsyJrj6IMI=
X-Gm-Gg: AZuq6aLPgWv3x3GU4HKWv2ozV388laEzNZY//RMJ1L7rOO8Q+rXsfUZA7jvGodUd3ss
	Z3WU8GWoTq3/NEz9VFHXjtoPmHqY+xLuT9ghJU4jDK/tL8eFxpe61IejDHPDKlgVodTmlH3k89M
	t3l2xqwny6tFnwv3mQYAYXAxW9TqVz83y8zbxx/MwQU6M9a2CVkQCpYln0dNPNFSsmZD4kMV5Vp
	AcQ+WNF4voh02u6AeyodiFa01VFS8lQpS87L/881LP7POycZDVGkHOCTCg/GVvs+nh14FqBbiwf
	pQProju4qY0RVfIRiG0lKRqz5i3StswQ8d0H5skPWj/oH35iOHQG7Z4MDmDktRQHWj8dvcjYjmV
	CDQ3fP42wZYkZZBwMJat10snKIBJ1hoPe3wksLiyAkGvjpEczpZYDYCp+HMrw+criuEo=
X-Received: by 2002:a17:902:f54e:b0:2aa:eaa7:2a9 with SMTP id d9443c01a7336-2ab105482fcmr1487995ad.8.1770674838344;
        Mon, 09 Feb 2026 14:07:18 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a952217a43sm110283645ad.87.2026.02.09.14.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 14:07:17 -0800 (PST)
Date: Mon, 9 Feb 2026 14:07:16 -0800
From: Joe Damato <joe@dama.to>
To: Thomas Gleixner <tglx@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org
Subject: Re: i40e: Fix preempt count leak in napi poll tracepoint
Message-ID: <aYpalNvTIiD4nym4@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Thomas Gleixner <tglx@kernel.org>, intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org
References: <87v7g8zv2o.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7g8zv2o.ffs@tglx>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257993-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 9D7C3114F76
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 11:50:23AM +0100, Thomas Gleixner wrote:
> Using get_cpu() in the tracepoint assignment causes an obvious preempt
> count leak because nothing invokes put_cpu() to undo it:
> 
>   softirq: huh, entered softirq 3 NET_RX with preempt_count 00000100, exited with 00000101?
> 
> This clearly has seen a lot of testing in the last 3+ years...

I'm the author who introduced the bug. FWIW, I did use it quite a bit when I
had i40e devices.
 
> Use smp_processor_id() instead.

Thanks.
 
> Fixes: 6d4d584a7ea8 ("i40e: Add i40e_napi_poll tracepoint")
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/ethernet/intel/i40e/i40e_trace.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
> @@ -88,7 +88,7 @@ TRACE_EVENT(i40e_napi_poll,
>  		__entry->rx_clean_complete = rx_clean_complete;
>  		__entry->tx_clean_complete = tx_clean_complete;
>  		__entry->irq_num = q->irq_num;
> -		__entry->curr_cpu = get_cpu();
> +		__entry->curr_cpu = smp_processor_id();
>  		__assign_str(qname);
>  		__assign_str(dev_name);
>  		__assign_bitmask(irq_affinity, cpumask_bits(&q->affinity_mask),
> 

Reviewed-by: Joe Damato <joe@dama.to>

