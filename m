Return-Path: <netdev+bounces-283045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x8UYKCD882m29QEAu9opvQ
	(envelope-from <netdev+bounces-283045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:04:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB904A9716
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36F1D3018D70
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5AB285C9D;
	Fri,  1 May 2026 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdLJnB/9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBF61DF751
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597467; cv=none; b=KIyjSZBWNeX/++/JZWd7AoWAIcSxHLefNHlKFpUnPBQSF45D/fib9YkPgqL9XMwEgRHHUnsd7RNu3YHuer+X9Y4qOuYKhH270uwjyMF+K8Cf4KiQw9LfBjQcSXnJck0HwFpTfEW14JeeDrBIXCszptewdvWqfsql30HFSnetiLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597467; c=relaxed/simple;
	bh=/DJ7wZtMAXQCMxmN4svRwnpE9acNFiZmKF0ZopAdBT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL9fEVfjZ+RBFLjKwOV4xcpavuIQvXCaEogJUE1EFKCFO1sR5XOet0x8Yt9D5aOhf2xL9y3+6GVICmkaR7yGGJsoZWPXUTEOPnt1+nOnVyM9JPnlLdecP/ykTN2TO3nVzrmebruULIuu5nUKq9aZl0sSPjEY9lF93HG6TZOnT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdLJnB/9; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a3b0242631so20160076d6.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 18:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777597464; x=1778202264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YgTjr8+nRWTJvq9pIAhCak7v+aRK5KkPsWEHGXUHTRE=;
        b=gdLJnB/90EiZQUrzVqnOJC0c+QuyxddLjlh8k7F1508n1zygl8hVdqtrShrPIQIQ8b
         gLqpZzB+9epM4kJE/vKuE/0633/enY7Z7wEwYE3eV1Xgps5aC3e0NO6RlKV0v85n2Dyx
         2oNNNgjc06o8vZCzvFeFvZ/Nu3gfFSvDqsCZU4bIv4k0n7p+H/OucOVw6lXQhL1wbgAY
         gGyBdHfQjpcOV7zBiG4Hc8bJY23bQulj2jNReUlvMBxY0ro/XWViglGMrDBVGzNXe6ph
         V2/TqJ5AXddlJEoYTEsUXNHc22vKL0XlaRGOSy6RccIrlU8tStcC1JfbQPjlHQm2oXZ8
         0K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777597464; x=1778202264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgTjr8+nRWTJvq9pIAhCak7v+aRK5KkPsWEHGXUHTRE=;
        b=ANFmjFqZ9R4Ja404gIATwxSCtNSLDjsuHhcmg8mGRE4iRn+lxaxdIzRr6HQaHkm/td
         1zIkZRQ/yCwKUfyCsK9ZoDy62n1W/bzOxPoTXyQdm2FKgLnj6c27sHoavySx2BlVLJ1g
         KNphekADDL7qx5tfTNZuYJ4pPu/xeL26jveFetHMu0yWYmiUJ/VgLL5yToileSHLCOnP
         0qhVCvtQWTkJYJ7sYAOochYhHWmRQSnCKfqn9BN7cgPSJxH3M7tIiHr6bva7c4pg3QH2
         rgSAWIOy3+zAUkroYNpn8zDZP7jNmXs6jlzopi0b+CXpwZS9pdPYe+qGkT3JCGSgKco8
         xPRA==
X-Forwarded-Encrypted: i=1; AFNElJ+VWsxGCO2uiHVizZWXfhgE3wOwMLT1Y6pBhp/1gqxo9DoPsy8BzPkjDJFKifz0LBFArkStrkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe+/nduGx0UUTj6VNjOGedaurWXSG4i1MB8MQp3xT9Vmzbxlgr
	KV8E0wTWmyoFynzQpBn8belUb34L6pmCx+Cy9r8A7S+uxWdP3fRZEMCD
X-Gm-Gg: AeBDiesUcZegmmSZoOv2RA8bPgloIeNMBIpkmlorN5vHgvexlm47bX1NanM93wS+VPE
	iaFEjQLxWDc6y0SooiQYNE2NZyEJ/G9QNgF2+14KkSninlBlr+S7pgwZJ1oyqwAN6YLxGNlOxmi
	9+76wbESMZwTjTx2LZm3Yytp2ayc1MHbY1fU0dBlqlheIJQbS6hM+Dt2Z7NpqsIQYo8iPf8ZavE
	/YbrTyQS4p/YFmtXbtbG7FFZumY8mxt3rCkd2FvSUypOTtE8tTc00cdjO7QLZ+2zwGe0grjUe7T
	P/uyRGynMhtiswAr4ZGGjxDDMnmDQrSts/WGppzQ4jWHZlcMW92sVkFFQ1xSH8IXw2VMzAF7/9e
	K7vRachKBo+vUJRcwx9OfdOdG6jg3AJjDwE0haNoETnsKbXjLSu0Im7d7BmyNFw2WYFeM+9BgLF
	Gz+2ufnVq8dbPYZSrKzIgZee9hO0AtnIxfJbVq2w2r3ouEepkkUxs+18Ei9A==
X-Received: by 2002:a05:6214:4710:b0:8b0:2dc3:319f with SMTP id 6a1803df08f44-8b544de5bdcmr13924316d6.2.1777597464476;
        Thu, 30 Apr 2026 18:04:24 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f814:31::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d6442d0sm7643106d6.46.2026.04.30.18.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 18:04:24 -0700 (PDT)
Date: Thu, 30 Apr 2026 18:04:15 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 00/11] net: devmem: support devmem with netkit
 devices
Message-ID: <afP8D4RUPRKaOS7Y@devvm29614.prn0.facebook.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
 <20260430175945.476734ca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430175945.476734ca@kernel.org>
X-Rspamd-Queue-Id: EDB904A9716
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283045-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm29614.prn0.facebook.com:mid]

On Thu, Apr 30, 2026 at 05:59:45PM -0700, Jakub Kicinski wrote:
> On Tue, 28 Apr 2026 15:41:57 -0700 Bobby Eshleman wrote:
> >       net: add netmem_tx modes that indicate dma capability
> >       net: bnxt: convert netmem_tx from bool to NETMEM_TX_DMA enum
> >       gve: convert netmem_tx from bool to NETMEM_TX_DMA enum
> >       net/mlx5e: convert netmem_tx from bool to NETMEM_TX_DMA enum
> >       eth: fbnic: convert netmem_tx from bool to NETMEM_TX_DMA enum
> >       netkit: set NETMEM_TX_NO_DMA for unreadable skb passthrough
> >       net: devmem: support TX over NETMEM_TX_NO_DMA devices
> 
> I think it looks reasonable over all, but the assumption that rx lease
> implies tx queue does not seem great. Sounds like Daniel has that part
> covered tho :)

Indeed, with TX leasing this becomes much nicer.

> 
> When you post v2 - you can squash the driver patches into patch 1.

Will do!

Best,
Bobby

