Return-Path: <netdev+bounces-259819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KImIJWpPmWm6SgMAu9opvQ
	(envelope-from <netdev+bounces-259819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 07:23:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B439F16C443
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 07:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04F0F3016EF8
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 06:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2837D330658;
	Sat, 21 Feb 2026 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0JAPU7M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC76E311C30
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771655015; cv=none; b=LrHwGBO2rk0qpoShRF0Ld5zzJndi33MJWLl+ErTzLod0JmiTj3hoZr4krBsXCCAjVLCd8o3/pVWRJnDwfZ5QJKqjzvytgoA9x4x7iaDDm09DIyGEY08aBElq/WQuSHuEL96z+S7UPC3MbmSXv8Rcm+/pVRoe5gQY0UaXOqs2Y6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771655015; c=relaxed/simple;
	bh=khQz+frxlQ3aeqjRR1f1AgADDTbHR1tn0WVEfpoi0R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFOJLrXmo0e6nwGfLQC5jBMbv/5yrj9++RMaY5ModOHRV0Hp/akFf+TSE11mX64vaY0KA4Pc2PXUYBUQq9tEENQBeReH+6HrxdRYFboMkgddAgmHF89MEk/liXscQEwFvlEdzPyvG843nCCEiqPQUENA1eW64epqPcxNO/i/SPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0JAPU7M; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b82c605dbdso2806466eec.0
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 22:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771655013; x=1772259813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BBf9kf7GJHPNFL3ts/LvN6k9egSZ31VrlpejJmQZuUo=;
        b=K0JAPU7MQiSf03b4WdmkQKxHYXTjD3UaYrLolkREGuVr/6KPoL+I8W6MzrB0A8N/J6
         SFFCqwKSeKgIltgSJzvhRm/PRgi393hkbtHnyMD6HmgnPhGFQEuZGntnTjvc6jWy9eL6
         NjxZR5q55s1zB3hEj2gZETmWYaqdzM5Gz54wxOlVm+GWT+W2DFIiqsxLaJVR53DmH0XM
         V6lhghOMtcaILD/eyc5GbbVzy2WGL32h//L/ENS7Mkggn30kixOvANHcfj0mfNJNbUPh
         6DcKg82P5BEMZHgsy+wBpY/t87K3rGU+cLr7RjdVwjgDCl9f66WkZTzA3ZFs8s0O2YX/
         ABdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771655013; x=1772259813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBf9kf7GJHPNFL3ts/LvN6k9egSZ31VrlpejJmQZuUo=;
        b=Ohc0flab1EjhISHRD/30OUYV/Bw/mBOPC6RN3AUXjoISc7VXTwQonFQiZueg8Be47B
         K5XzEb/8z5gQEXDsOfnLU/wCweQHtRyfAVB80npPweHl8Fc7MdgMXRoW/2+fqDkbtQCS
         ApSQRflKUKT5QfKoEhDxEtbAqSkNrBgSgmMCv/gw//DtJ+cSd14b87ZbDR5ak4H7nbFu
         zQy4h5053dWd7qrMYKOscLSJGpQ6UJpU7GT8/J3c1A04UkI0mQE/cRPL6mGfJ8b1PGfC
         ealJ/3jn/p5OOpm5Q3PshmbiTlyqm6123G9P3L2k03sY7jW571vST2AfkvPzRDgkfLRZ
         8saQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7qHitp6NOu6zDrz15m26i1vLIxuI36f7UIwuZPUZqPSNDw39uoP+S5vJKXmmxK75sHTjvao=@vger.kernel.org
X-Gm-Message-State: AOJu0YycJ/ZVE3ygZyctXDYuOVnUuWDZbtDQzghuaOnScBsWH/GlIDXg
	sXwVNdxH9+9m+1FJ324Rfb2StRz7v4E686EvPMZpAWVlPBfgh71hsIM=
X-Gm-Gg: AZuq6aJnFteHQHKrMeOVB3Nrevase3xPIeg2WgK18/b5KomuH9aurJr9e8aopdLYJs+
	vTbrkp4WlYgKEgkHaWG0sbHOMMVoiKWlCqEWRP0xZjed/AqtIzCbrIOx2VPIle/1A0mkY2ahLgQ
	4EZpNzv5O75XZj5YYUfRePk8+NGJxZjoX3cQjQS7I2Wd2VOmMs7r5dYU3q3r5JInWvPrypOtpcp
	rvmyCGiVsQb9fmk7BgSbsbu/UqzZBNfCGMDCIxCQVFBH3qCkG31uK03gbBuNGApAVL1arlzh+6Y
	wUTH0I4zj/0jhg0TkLcfXJeL604JhJUhsjGwNhOJh38EcyTuu4annM0l0XGEXnLL5Sc070rvYW1
	JSIjtwhr52VHBo5ZVPtDAUdcRMiNWRXen14hbljnuIGwU9SsxJufIRiDAiASJKp2N0Brv5vKe+P
	GNC0sU3YMwfg2KjjY48s1sCtX0+q61QsaK3cMAtVwuauzpHLsvWGZMOaeYpsPb3bqKK1OBjKOax
	ZcIO8OTMXsBpEOKfcVD0GHvHgF3
X-Received: by 2002:a05:693c:3002:b0:2b7:ee0e:e9ba with SMTP id 5a478bee46e88-2bd7bae8d5bmr1112940eec.10.1771655012849;
        Fri, 20 Feb 2026 22:23:32 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe78b9sm863847eec.18.2026.02.20.22.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 22:23:32 -0800 (PST)
Date: Fri, 20 Feb 2026 22:23:32 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: defer __dev_set_promiscuity() to avoid
 sleeping in atomic context
Message-ID: <aZlPZLhx6gwVKsbw@mini-arch>
References: <20260214033859.43857-1-jiayuan.chen@linux.dev>
 <aZURjBHTHRvjP7Ee@mini-arch>
 <20260218174025.2fe593d3@kernel.org>
 <aZdddVNRy6sYiUEt@mini-arch>
 <20260219121213.5b5ab0e7@kernel.org>
 <CAPrAcgNP0av_d+Ai175QoEu5shjHXEEtObtqkhcnKufpHwHWDA@mail.gmail.com>
 <aZkHFB1yH2ooiukD@mini-arch>
 <CAPrAcgOzEnc-XPNG55UtzQMRamG4pTzZA8PB71WuzjGRSNmFjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPrAcgOzEnc-XPNG55UtzQMRamG4pTzZA8PB71WuzjGRSNmFjw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259819-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B439F16C443
X-Rspamd-Action: no action

On 02/21, I Viswanath wrote:
> On Sat, 21 Feb 2026 at 06:45, Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > > Do you mean rtnl_lock when you say instance lock?
> >
> > Search for the instance locks in Documentation/networking/netdevices.rst. We
> > essentially need to add netdev_ops_assert_locked to __dev_set_rx_mode
> > and make it work.
> 
> So, the handler should look something like this?
> 
> static void netif_write_rx_mode(struct work_struct *param) {
>  rtnl_lock()
>  netdev_lock()
>  /* Processing */
> netdev_unlock();
>  rtnl_unlock();
> }
> 
> v9 should be out by next week and fixes all the issues I could think
> of so please wait for that

Let's handle instance locking separately, I don't think it's as simple
as adding netdev_ops_lock/unlock.

