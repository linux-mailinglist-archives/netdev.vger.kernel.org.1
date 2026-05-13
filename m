Return-Path: <netdev+bounces-287438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDPZNd8XBGpLDgIAu9opvQ
	(envelope-from <netdev+bounces-287438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:19:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3183052E05C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD9473051D2E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 06:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F603D3CF6;
	Wed, 13 May 2026 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4VqkFNV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02C3D1A86
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778653127; cv=pass; b=IivbjUwXDhmQ/qsGsYKXDLnvTRXBYlfQv6N5qfr50bneJyq1ke+jTtSP6+xf2SP/51elJqpbceHwTtyUmhKEY81dS4Md8Pgc6vZA5WelLbTmFhYz8TWIIGK++KKp7JHlCPTewF5LP+FIyVdNy8E3lElKg/hKTwDjxIwclG544Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778653127; c=relaxed/simple;
	bh=WrY2hZPMMxxQ1LWP6MgclBD3iRLMofj8yrbwp/ZI7kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UflOfcUcO8jkcJtRJJt8u9g3lG80u05Hx3z+HjBUpRT/Nm1rxk4vRcYgmML4r6HAX5Bjr2Iny+k62rR1VYvcdSlHMcyVEHB4DoHAuc/vuE36SeDWo6SCe0mUs2A/8HZwVLr5CXswjpUjpNHV83BKSvaBwT7LLm6k2VLFcGjedco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4VqkFNV; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so75721375e9.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 23:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778653124; cv=none;
        d=google.com; s=arc-20240605;
        b=SFkJMnyvGxVILddDPI/EQMJxOhpxNcEkSB8Ak4A5B0eihXcLpLQa2kyx0M2zfK3+EU
         5q+Iu29o+TuggwPI4B2SpOKgb2gLoDOqD8Al1Ogx4fLlxmniMYPjiJhnLrZAeijRSWEy
         FMHfIyFRHwNK1RrRT23/t1LawPhxOnP46kaWR6iYDmFymI0EQD9rwix0u+4Eorz0gWfz
         cyJCy6T++2toHHBCPkd6tjpJY/4VSLBAMz6jJXO9Wyipk/cfR5StndE1HmsqI06xCM7z
         SAzLojInDSZD3F1SJ77x6aoZepaVMe1BIDL/6kabYWSew3pMqT80x4L5x+Bf5X1WJHFx
         yYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WrY2hZPMMxxQ1LWP6MgclBD3iRLMofj8yrbwp/ZI7kY=;
        fh=0XK8nYwosRUNGVibhpm9w5Km/AolWAlu7opLEZ2/cX0=;
        b=ZNnS3zdSDd+Il7kF0i4KQwlZ+in3TEEz33c0vMo3/5reV+fmm7Au/bGPsxRJSqXyUe
         q6UlNJ1adlUaTjwhFHA6mLnd12aWATKyZCcTFQr5t3G2tjWFcKgvxvgmyEbEs1Y3xAWa
         Vs63JU97L/xgXJY6n5fcIuCOLsPRB2DshWfPPUjpKuhRj+VHz15H+wWNlKO+FOJoL6YF
         Nr6KNomILa+3Ex0itfaFzpbV7DPSn6GTcP7f82Rk9JUrc4POEECXSwJ+y1+L2YTmvn8a
         8mgILf1RIxOYlCaejtv1gp0rLLl3WeUwmz3wfcNmzd06sPRYoSwDGW80n4tfD6OSAAky
         /7BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778653124; x=1779257924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WrY2hZPMMxxQ1LWP6MgclBD3iRLMofj8yrbwp/ZI7kY=;
        b=L4VqkFNVw7lQg5Wv+6QgazCzrAZt2c3hwqn4QSKnF0XObuHGJSIXFtwwtYU2elGr2S
         2Mzs/VIdbRkXhxvWIg9JboEKYzKmC7V5vq0CFEr6Pjru89GMD7miYJD+DRSukE320XJx
         a9f29VfxTWWWYCzavbnOFocc3+NnXAAZ/VWgqLMKS0ZXCAPwmXeyHKoeDMZWD/Q4Z/h6
         oK62kfckBon4TjMHI2vAMGJZDwrVZl9W1AWkD0nas+wOVzcdCsmpZOfdG03928pIgYE8
         BzHiUnBkebOzqU1uj5+t4mL/icxCcqtZdjQAWletIhlS2w8SBj5g1FgN56msmRne/XG4
         IAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778653124; x=1779257924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrY2hZPMMxxQ1LWP6MgclBD3iRLMofj8yrbwp/ZI7kY=;
        b=epKG3nmOSL0tLEtz72Z0Z2vSo4I6AEtyqoVF+RyIpMFVUX0PmMl9/69XyCtutHjYt6
         exmGl1TBrwywHNNDYHDTN72DSBUVaPn74jvrpjTHa6CV8Avj0MU4+yE1fOo0pHu51TTu
         FJ/mq0sBJh9pSC9+PttY6hoLkgHDsFQ8AFnG3GWhzZfQ/ABh96ZNVWPGecTm+wMQRUs0
         wK/XQvqrhQbKFXZcfuXJoojlULWSO4p6cHrRkNN3lT+Jf7NDvamCCLU4RRP3TUYfUCQJ
         ksBZmpYXjKKNo24hY3kehjEVp/LiFI90dTgByabM1Uh/Bpn31i+bXjeHmnEOrj5DT3hn
         +dew==
X-Forwarded-Encrypted: i=1; AFNElJ+wmTHNRbCuxxRm3t0R2W6pb/xvl6qWSbsqpCRGH7ZwrWQ4lXn2yKu/qNdZFqEe98SOnMNPIi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXFUFJ8SW0C9s0qCkOU0TXn6C8gXiSWYv+SNVKfCAntpotgalQ
	vgR9vICc8MTyD0krKd7r8tRFOX+ARhXFd7+6BU0dMB2KkdDQphW6297abyd9RMgsBODQp1s7Jgb
	+uImo30U2rk8W1DC7CoRAEeRRz2v2HF8=
X-Gm-Gg: Acq92OGfE2JCR7SVEJmWD/4XRC//9z4e4JZQBfNyzIg/qq4IqdVXoLS5ukkJ3+G+zw7
	EYfjtgc7vAO91BEbxnZ5IghUj8qSgvgaZaXj4URMjb7k7ByQ3PNDh+LPCaCnTEBjPcrIeBrqKMm
	NYNhr7trP+AXAB5FAkbA++yCxHMPGVvqsJjlmgKcY/LsZWQDhGQOIlVaKfmRcnEM154hAGRxGb/
	zIqWUbGJWvLKGbXSzMXtZNMJGR6vkOwCpNb15Pr/tIOJ8+dbzc/XP4/Ms/3dTAgzdRy3PKNJOng
	RF2NuCgdxKGNd2G/QA==
X-Received: by 2002:a05:600c:a48:b0:48a:52ee:5776 with SMTP id
 5b1f17b1804b1-48fc9a0ef80mr25793175e9.11.1778653124195; Tue, 12 May 2026
 23:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511070211.1033178-1-maoyi.xie@ntu.edu.sg> <9b6148b29f57728d97a9fea8a400e87a3f6a1526.camel@kernel.org>
In-Reply-To: <9b6148b29f57728d97a9fea8a400e87a3f6a1526.camel@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Wed, 13 May 2026 14:18:31 +0800
X-Gm-Features: AVHnY4IcN0Jh7DC42BSM0bqJQ3RvCnFtHU0k-WlbQCijrYUbo8dXtGmCYJeD58E
Message-ID: <CAHPEe=HK5=T6OwozBwKR_i_ULNPbWC2k6PNhBfJLX6_gK76+qw@mail.gmail.com>
Subject: Re: [PATCH net v3] rds: filter RDS_INFO_* getsockopt by caller's netns
To: Allison Henderson <achender@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org, 
	Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3183052E05C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287438-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Allison,

Thanks for the v3 confirmation.

One small follow-up: kernel test robot reported -Wunused-but-set-global
for rds_sock_count, rds_tcp_tc_count, and rds6_tcp_tc_count after v3.
They became unused once v3 replaced the precheck with the per-ns
count. I plan to send v4 dropping these three globals (delete-only,
same files as v3) and carrying your Reviewed-by forward.

Best,
Maoyi

