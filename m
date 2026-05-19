Return-Path: <netdev+bounces-289544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBJaKmGcDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:22:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41044582F9F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75DF73080F94
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788753DB31C;
	Tue, 19 May 2026 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZ45DE9+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3883A4A23
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211212; cv=pass; b=hu6Ua/9lFQHv8xWONKoBUaS6wZ89EDw14NnGQP/W/TAPPQ/bWhOwHZEOFMaru+AcLyUMdcbqIBSZp7RsgQLnCbEhrDbYmOGCfggaJ0XmTAhxmzAGBuC3m6+Gmdou5o44wjgzYDglakp2pJ7twyDl0HO51y55KUu3fWe3848zYwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211212; c=relaxed/simple;
	bh=2DLgzqZJ5p1ZCqGSn3kM25I7MJRT43xzHHQMKm+TPAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ug755lyy5NCiQrwuPAzi0sbUmyQ8HmzRNf/n0MS2zwwwybjfYiDWkIN2SkQCy7B4j8iU/tDEEgulMhWFHwlXwSfVtYnEnhaluOgpzwnKFwUhRTMbvFogaK6k0O33vAXscTtIHcsxNwbwl3j3FgMEh2tNsvikteUFoaJ7biGJtFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZ45DE9+; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba180a022dso825ad.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779211210; cv=none;
        d=google.com; s=arc-20240605;
        b=kdhCIBOtcix9iqGM1Wz+H1a6Wjh79z9vdHw+SIcuy3KRQULaFw3G04iLwYP36BeGrV
         S7VNu2DqHtf1Fcxt5mrdKMv0d05JhFWhrhgd1lV2crlLDnPn2A9/wfwIvwUvuFY+x8zG
         INfOluEUXsMbGkzD60viP4Bv2A3eQVUO+cRbZGGzMPzb+JRptY/FyzmbKf/O0SVP+2E2
         vojSD5lq8yNYb9zV3p8wZTFS8iyrQh89PGwbAGfm1wvhQBCn1rSTS1+re3hwJOUhn8ki
         cyzc0f0fJmyDHJdroaP5PUyNrJujiFfIwKLzm21bVoVYlywwwjtT14SZoF6UNaz0/W56
         z6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=45VcAaAGxdINjsuoDSahDEmylTGz4VFthZK/dnu7mYc=;
        fh=8nT21Vqg6X00wqcnK+HJh0wtT4C+d2sxP7XREFc5Wdc=;
        b=UeDCcjE1iMJsiob4Bbf6l27hGwRx1YiTZ9dmbyg12PDVorq/ZyugwhG+K10Bqfiqgz
         j1aGruIEa9kKRcCq4K1QTVZI3A3pG9PAINV9+m0Mz1RszjXvUKHl2TVhuDEQRAKQ9RDE
         UEqFTar4DdGvuHgopwejM7NI3P1RMUsMoX2dT+6LKMpOWNOZu/Wu1PqKpT11+uTZEgVW
         qFroYDF/c8u5uiNU44Q3DfSWpRtMgVwKLqNB7qhW5ucQdwT53PfZsPZmJCo5oMgwq0cU
         iovH3/wzfS2Ff652UvX2/UR24m0l9GLW6YsabOWzTt4ajJOvxRsm0CiPcv8vnRVInw86
         xu+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779211210; x=1779816010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45VcAaAGxdINjsuoDSahDEmylTGz4VFthZK/dnu7mYc=;
        b=LZ45DE9+7x7rU/X7i8LtHEdU02eN7UGn3+fXk/PN5Y8+MJdvppFlRhFx5Z1WnXbBNA
         FpdUzcXyTJBF03cAuEOcVZbzoZeTCxc0wUGx711rW1NYZ1+a+MIxG4GmpUI9ow8MS/o8
         eYgxiIs9Lgfu6Oz13VNRBaM3gOYAJZKxoM+XEQNV9u4Z2Mtet2ETR8kkifoSLvDeij0J
         AZWW+BSLH9hguwLHf9rVicNpyR+GhLPL/CgQHHBp5ej0o2Ppe/3PGpqA/oDrzgluXEIo
         ZFzj6wfD5s95k0VyVcgzRUCjUOXvzw+xlJDaUaUElwQ/PWJNQIpMm+f0lHxr865Ialwg
         I3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211210; x=1779816010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=45VcAaAGxdINjsuoDSahDEmylTGz4VFthZK/dnu7mYc=;
        b=aOxLkdKdX7dvNnyoaqc/yZo61+uQQy8o0w73MAedkyhb4u1EhXWMK5F53Tp4zSbWPC
         HMUXkhDNfVD6b6N/GcaccBsY9AoaZeD+lCEAud42vJWeqZuMsTLRD3CA3JIJOGVVaSq/
         MqZ2tKDGHinIE3qrpeu6Ng2iMTx3hyA/EocOBzVHk08SX5+PFrQ9z1z684zKm9MwpKSz
         D+VgvN1Q87LKvdJaeY12BIEckk8tdSZggM8yE9qI7Fp47Bo1W783z7AjVUgDUOLO8vP7
         MV84GNDzMlOhPQzRL/dC32TVZ2d8WQ/t8as4DYSMj0qobV+JqxhLdsNYiJm8fhhPOhEm
         2CEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+npNyRQuLr7dm8w5HwUJ6LNTIF61camQZZj5fgGcN44BbvRgzadsZootG8kKDclrgfK8ytcT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzWw8GkBchv38+uJa/L0PLNJCMQNbcODSOa0SCbP1B/SixmuTe
	ulNxwbq1qD4g/Fa/f6x7871n+OdHleOPc2XzCwQFi7Kyvge/YpC6+/dy+1LSCgLKWj+V3ZOrcyb
	fB/oyuNC1JXOFKxWuCjR0cMqW95AwLZesI1L2/ug2
X-Gm-Gg: Acq92OFUG5JjBoyX+8kgPXtnS3pqIyjdZaJ6PgG9LMq6UyZEpYjF1DKeExyPb3H1iA6
	hLr7hN7oYNBui24dAuW79a0woA/6Pui0W94S6h0RqPpLr5aKA4v8fo3TvzqnOOVGNN1qSRZ6eiN
	wbXPkIQtxWEuFVI4q3qNW2QBSLSpOQzJcKtX3Y652HLLmxZNksViHNCgBFVdbKO+6aYkWeoDItl
	jz1m9s7xFiomwBGIeMvdJIJuJ5p6yf89yWWEuNtkQs7AzUYnoty9Z+7SQMvgTswa/MlodtRoUVN
	YIMiMh/FXacK58nE+2goFK8xGShAjgbSH1P8GSIvtweQ9ROpnRPMskKPyB17SRCQmWMlL6XBQkf
	ETfsiqjqDXbKY6FpI
X-Received: by 2002:a17:902:ce85:b0:2a9:5ef5:399b with SMTP id
 d9443c01a7336-2bdb32bcb70mr6690835ad.19.1779211209697; Tue, 19 May 2026
 10:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513103021.2190593-1-wei.fang@nxp.com>
In-Reply-To: <20260513103021.2190593-1-wei.fang@nxp.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 19 May 2026 10:19:58 -0700
X-Gm-Features: AVHnY4JTHToihTdtG56Fn2wMZ0yfZJeikVG9It8zZEUo1xg0jYg1dgfIyUDllE0
Message-ID: <CAEAWyHeTZJ+=QAbPGfvefwcSJfVCAw=w2P70xytxqBOScvb19w@mail.gmail.com>
Subject: Re: [PATCH net 0/6] net: enetc: SR-IOV robustness and security fixes
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	catalin.horghidan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289544-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,nxp.com:email]
X-Rspamd-Queue-Id: 41044582F9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 13, 2026 at 4:02=E2=80=AFAM Wei Fang <wei.fang@nxp.com> wrote:
>
> This series hardens the ENETC PF driver's SR-IOV implementation by
> fixing multiple security and stability issues in the VF-to-PF mailbox
> communication path, identified through code review.
>
> Issues addressed:
>   - Missing input validation for VF requests (security)
>   - Race conditions in VF state management (stability)
>   - Initialization ordering bugs (reliability)
>   - Resource cleanup issues (memory safety)
>   - Missing ratelimiting in error paths (DoS prevention)
>
> All issues are theoretical (found through static analysis) but represent
> real vulnerabilities exploitable by malicious guests or buggy VF drivers.
>
> Wei Fang (6):
>   net: enetc: validate VF primary MAC address before configuration
>   net: enetc: fix race condition in VF MAC address configuration
>   net: enetc: fix use-after-free in mailbox cleanup on interrupt race
>   net: enetc: avoid VF->PF mailbox timeout during SR-IOV teardown
>   net: enetc: fix initialization order to prevent use of uninitialized
>     resources
>   net: enetc: add ratelimiting to VF mailbox error messages

Series LGTM. If the commit message for patch 8 is updated, feel free to add=
:

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

>
>  .../net/ethernet/freescale/enetc/enetc_msg.c  | 34 +++++++++----------
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 28 ++++++++++++---
>  .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 +
>  3 files changed, 40 insertions(+), 23 deletions(-)
>
> --
> 2.34.1
>
>

