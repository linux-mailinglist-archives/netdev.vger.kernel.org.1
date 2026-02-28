Return-Path: <netdev+bounces-262167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHwZO8UWo2mJ9gQAu9opvQ
	(envelope-from <netdev+bounces-262167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:24:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 974A81C448D
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D63283004F36
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7180E2DCF45;
	Sat, 28 Feb 2026 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hch7y4PL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353482D97B9
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772295874; cv=pass; b=VXwW5t9+Jbd3n2nqNPTLeR4EvHWHCRqFk3/XOce1AEQaeve+IxRa1me6KM08aFGOFP8/BeepuRrbftSYtdME+KtF/V1BAUN4r9X8R7wmZw6uSE0ojTvgFsRozBHZLhgPBrczB7TFKeTjSD6fKZzke7R4ckdQRz5iFn9QXfFA1uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772295874; c=relaxed/simple;
	bh=4F3bPpH3afJgQR4CpGDWDyJB4i6LJmi/FRB2TyMdrNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evQD7r3TPi8VnAKoPtbysaDCn3Wj6ik7WzvsQG+6XDrEvBn28dAhGv9kLJteOEu6Toh5emguC2G0O4CWyWdFd+tst2cjnYYALlc65w5pCkUYFdzuFTph/BQFutPfcpY8yAeP3dmT+er54zH+yGzSoBV49L4ySkbstj1NfnqZ5PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hch7y4PL; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506a6cf8242so23795111cf.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 08:24:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772295872; cv=none;
        d=google.com; s=arc-20240605;
        b=aFYOsICuMOTjjDEPIMZR852C75YC5bvh1wFD6ZX09VNrdVP/6I4/SuysNRKXjtDitj
         fs01vTvEqpvTqBCG+pSwxCIAOiPTvbg6alEYuO5kMJVYcVYyhDKV3OjY7Gyz0hKk/fS9
         PlJOh+oky0mAHkjpKfVYo/K3Wk60wUpKWfJjpaVvYZi9urtgkFvcfTVosSJBuWUiDWuI
         8nN8vp/4A/2oUPppy/BM2g431jnsxAI5pcwBSEsHJJG4eTITfJuntzXh7zGSgQyYmou4
         tn3Vjk15EZBqWwtzcHn3jQquOwi1Yatdzf/Buz5rxlR9QtH98kD/dpArB6vwKO/Aa45q
         b00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4F3bPpH3afJgQR4CpGDWDyJB4i6LJmi/FRB2TyMdrNE=;
        fh=wydKVAXXqyV995JBhECkgcm9cpOAfBSCmy3aFTddG9Q=;
        b=AFps+D8ht2tQB3bsSOUV17RMjFnSBMQ9Ravyddqe1TwGlPIstnt7SCTSc8fcDkDZGU
         nqWZrydWuJ8GcOO5UciFs6NEXpZID91LVs6F0LrvH357+tMCjGBladjoXE3mWYVDl1Dy
         /7R5Xr7jh24ldbt3VNGP9xvxe9D5JstqgKat9TDn37GjpPye6xPSw+qM3wo3zAOcgSHR
         BHPmn04oH9iNCd7zaQzux3sj5v6qSBuvCDV3bUFcUNcPdaQrdhH8yptfWk9Zr0kiRR2Q
         rbu11Z61Yg8ykIwdLPxhLxsAp0FWtWUZuBDifDw/Z15Thy4b6ls2drweGXA09q02GMRB
         9gOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772295872; x=1772900672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F3bPpH3afJgQR4CpGDWDyJB4i6LJmi/FRB2TyMdrNE=;
        b=Hch7y4PLW5QHfMW/4E+q6BIBF+G+DBbhR7EFq9OleDDF2K1NJnZBEHIDW6hYpNrRcX
         6594KONSSihyL2R1qtRq4YhMRFEP1t9ZJsxw04DT27PpcSbHYn8tDvZ1eTnrWxSR9Cul
         ll+z8MLocBXP/cjNmgqRnhdcHc3P2wAF4yuceNPhetW+AaZJbpWaxZdlp4VUr/KiD/ei
         T4yLLhkDKi0RVVJorUPB4H1E304sM50SPyGZp0mq/ENuqo0nRC26lGs9qUnB4fI57frw
         GxjTEw4zjz0dsoY+I8e7k4MJxiAJXhqS9/uSk7RDblAnYv0E+yuyZ27XGcq2ra0tg3DW
         vDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772295872; x=1772900672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4F3bPpH3afJgQR4CpGDWDyJB4i6LJmi/FRB2TyMdrNE=;
        b=YxJSnWGZDzOFE8aX/kbPFFTTaBnOou3omvoU7JBAJbYjd0LGTVNZD/2N9X/wIYns2Z
         c9gr0gTj9juphBTGb71LAh1NskDvIMntu35gu0dHiGPXEIgMP7ui+OKH6s6BiRtw7LH8
         OeyOz/FWUXgrN5Jr7unH4KNLCgFnaEcYFosqHBHiAb96Ui77rX3JiR02N/r5KdeDr32S
         lWqPZ4lduLGT6iz1Suhs73FRyNnRWtU7sEs9QnL6ZvOWv3LBRqebkN3Pp2tc1oCYu3zf
         IcCJVgGW8p29tQGcqNqWtkfnHzXGmluA71536c+dMSNNPedhjuWO8uI9BOiDz7LhEzUV
         xTDw==
X-Forwarded-Encrypted: i=1; AJvYcCVlcrAI1hejrF0RrOnw32AxmFnb0fqJbxN0B3usbsx6KyDJ3RsHRhcmkjFGKC3BrerbqplQncw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6JcZbM95dIFh7UvkAIMhuIoGqlNLeAmGaGkANISEMn44bel4H
	xeviJmKEOVkoXQTjN/riX+4BAPKD18+C0UEzQfV09/MqCevocBKJgwCJwC8AZ87E3T8sdP4CAb8
	2OPsGTvaZoIO+blFkzVsz95yduWtClHWPdMTbhKq2
X-Gm-Gg: ATEYQzzXDFibrlz3B+nOj75/f281o/etv5MYpa52roOfqCZou0n9NhbjbVcbmdK7fDb
	d0menDKj9oC9sMVvdKT32PhQm33lUA3uviUCeNWL1wIUDkIz0Lht8IM1X4Lp1K3ZQ+qfJfZJgyS
	QP+YYhpY7sAcgZco/eNF4OynyD41HEHq0tS0Meb3e+ehGrQnpuU+L4fdeCLeiTp8kNH745F7P6a
	TcGBwK7uoy/tOwHKq7r3/j6wZ7F/jNtABwBGeGNPxb0QfNR97asMhD1J8Oemqx2cJhHAsN4XC98
	GDKHirOt
X-Received: by 2002:ac8:5e0c:0:b0:502:a3b:f367 with SMTP id
 d75a77b69052e-507529b4cbdmr92448731cf.51.1772295871728; Sat, 28 Feb 2026
 08:24:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-16-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-16-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 17:24:20 +0100
X-Gm-Features: AaiRm52jgthXW5iSr7fOvMX8jM5TdBT6MrEMCHl7YLzHqWdeyfKpZdSRbkyrUy4
Message-ID: <CANn89iLAGO9A4jx6ESDoLAOxCS5btx4vB-U+arQ3tEwggt_L=w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 15/15] ipmr: Don't hold RTNL for ipmr_rtm_route().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262167-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 974A81C448D
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> ipmr_mfc_add() and ipmr_mfc_delete() are already protected
> by a dedicated mutex.
>
> rtm_to_ipmr_mfcc() calls __ipmr_get_table(), __dev_get_by_index(),
> amd ipmr_find_vif().
>
> Once __dev_get_by_index() is converted to dev_get_by_index_rcu(),
> we can move the other two functions under that same RCU section
> and drop RTNL for ipmr_rtm_route().
>
> Let's do that conversion and drop ASSERT_RTNL() in
> mr_call_mfc_notifiers().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

