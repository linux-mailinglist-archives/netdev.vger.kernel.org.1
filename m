Return-Path: <netdev+bounces-165928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6A7A33BCE
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F8E188C1C0
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0230B210F4D;
	Thu, 13 Feb 2025 09:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFA20DD5C;
	Thu, 13 Feb 2025 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440704; cv=none; b=VMX5ymtqBKkcGSoZ4Hc/R5tWU2bPR42qDcTky8Ha1stDiraTsHub8vpZQ9t/HYx98Wu/CU84Y8RHB3MjeIdJwkL/wnBDgr7mIYb+jXhg/nlPUFYZ2R4m5C8vWExKjAJH6SDLUJxTH9WYiXAL2Qt0xT1TcKLAclB3uC3ue/Fzzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440704; c=relaxed/simple;
	bh=sIMf72bZ70VvfcEOfaZNDsy8vIAaeXVF9ry/WOwLlbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvCaVq6MyfOQ5sqQt0zi8/ThVC8vv2VMtEV415cLN2cmZAIrNPytF9AyDMtg7PieihHkS9y2qI4vPRX7RSoMxhOzQhcSbIiRpIkXIAqVvq1lk3JpaOwU/KEtRq1PC01D4biJznlF/TMimD7nqMpEcfB2q5HXAhE7dHIQUA6dRaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5deb1266031so1105556a12.2;
        Thu, 13 Feb 2025 01:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739440701; x=1740045501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5ZamwJ0Kx0KvBpg8RsfWbLjBh13gTrQJTmNCAequ2U=;
        b=VeriCGpBCFxtt93aPBFZgSZOQb6UkBsOEYETPovaIJb9CRHE5E9X+IS4TIkMUbR8D0
         VA1PcCvKaPMwpWqC60iuW1iyMbf13EEF9gno0af0/mb87/T+gpRX1xNEtTEfKjDdVZ9q
         QtfuDxHHLewN0VSOD2GWJ93JSDu/UGYMO1PAfyMBXvSVYqXs/fNfGEg0d1mP14SCoeSe
         0DI3dg5LEdxB1AnfUcRCpxFz9lo/b5JBN4UBvTi9d50Xd9YNIF3rSyPy18Yg9oGFOJc0
         ///wv6Uopol1951Jbwe3EzQd9hb+66sBzUj3DIESsnZg+FysobStkwHE48h/NH8KBmMM
         tAvg==
X-Forwarded-Encrypted: i=1; AJvYcCUupDawC/RWKAa/qphxN/STBOZLyvyHEpPmO6edqj6aG6qxPQfTXQHp2+QXcgU8lCzvdwpKrhWfIcRP@vger.kernel.org, AJvYcCVDNki0bQ1I79/KKwFujjmWaXDN8q6aUUU2nNsdDCQQg4cwAvhtylHZ0C14BeDDNxZYEy7OGiM7KjvawYc=@vger.kernel.org, AJvYcCVELeNE9yMpwamnczQ29uXwjp79yQGlDI50gHgFaayDlRaxeWtwcq76bt6tL8Ge+uWnoH9wmfDI@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLLTbR7Pa5W16F0w1pLhQXq6WZssIMnOt25W7Y4WfyMVJy4lw
	+PUKI/ClI5pb3tCREOyaUHGRTpRfiB4PY8/YilGMRstG/JcZYtPL
X-Gm-Gg: ASbGncuCJasNSuszN+284LRxVFYJ5XV8ECLdTze0ZS7lIsV7JZn8VosmRGxXMCZ3r5b
	A1ce1Tx+FED+7gl+peLdQY0maTfpuXcsuIhHSQV4bcrk8hhxgi93XhbDb9N7HVHpk1dPYiqTMId
	8hkpC0/Y3pxHg3DU4QNIIihTBG9F5tRjQCT9YA1KNScxnxulCR36ct1huY9J7Y2vDm2wkzXvvYi
	b1fH8/0yQ5PWbfUOcTIXJe8nQysfIVgbJ29oKtXzpLMafzfisTUpgpqgZAX0E1jQ93Km6VC1NWF
	ga/oj8U=
X-Google-Smtp-Source: AGHT+IHijeTw/BOivI6gfk1oV8DxhJZtMmLYZDv3eGifbdwjoZKdiicg99ky3m/GQj2Np2THLNDk/A==
X-Received: by 2002:a17:906:478a:b0:ab7:e234:526b with SMTP id a640c23a62f3a-ab7f334ac6cmr723688766b.3.1739440700615;
        Thu, 13 Feb 2025 01:58:20 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53231ddasm98891566b.36.2025.02.13.01.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:58:20 -0800 (PST)
Date: Thu, 13 Feb 2025 01:58:17 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <20250213-translucent-nightingale-of-upgrade-b41f2e@leitao>
References: <20250212174329.53793-1-frederic@kernel.org>
 <20250212174329.53793-2-frederic@kernel.org>
 <20250212194820.059dac6f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212194820.059dac6f@kernel.org>

On Wed, Feb 12, 2025 at 07:48:20PM -0800, Jakub Kicinski wrote:
> On Wed, 12 Feb 2025 18:43:28 +0100 Frederic Weisbecker wrote:
> > napi_schedule() is expected to be called either:
> > 
> > * From an interrupt, where raised softirqs are handled on IRQ exit
> > 
> > * From a softirq disabled section, where raised softirqs are handled on
> >   the next call to local_bh_enable().
> > 
> > * From a softirq handler, where raised softirqs are handled on the next
> >   round in do_softirq(), or further deferred to a dedicated kthread.
> > 
> > Other bare tasks context may end up ignoring the raised NET_RX vector
> > until the next random softirq handling opportunity, which may not
> > happen before a while if the CPU goes idle afterwards with the tick
> > stopped.
> > 
> > Report inappropriate calling contexts when neither of the three above
> > conditions are met.
> 
> Looks like netcons is hitting this warning in netdevsim:
> 
> [   16.063196][  T219]  nsim_start_xmit+0x4e0/0x6f0 [netdevsim]
> [   16.063219][  T219]  ? netif_skb_features+0x23e/0xa80
> [   16.063237][  T219]  netpoll_start_xmit+0x3c3/0x670
> [   16.063258][  T219]  __netpoll_send_skb+0x3e9/0x800
> [   16.063287][  T219]  netpoll_send_skb+0x2a/0xa0
> [   16.063298][  T219]  send_ext_msg_udp+0x286/0x350 [netconsole]
> [   16.063325][  T219]  write_ext_msg+0x1c6/0x230 [netconsole]
> [   16.063346][  T219]  console_emit_next_record+0x20d/0x430
> 
> https://netdev-3.bots.linux.dev/vmksft-net-drv-dbg/results/990261/7-netcons-basic-sh/stderr
> 
> We gotta fix that first.

Thanks Jakub,

I understand that it will be fixed by this patchset, right?

https://lore.kernel.org/all/20250212-netdevsim-v1-1-20ece94daae8@debian.org/

