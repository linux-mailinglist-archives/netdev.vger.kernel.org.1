Return-Path: <netdev+bounces-182896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C06DFA8A4AE
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C6D7A74E1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127E2296D1D;
	Tue, 15 Apr 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VzxOD8Yn"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926082185A0
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736032; cv=none; b=I3IAaExg1/XCZgG6/poRsP9Ctexub80zINXE67tx13Xr4DAv2iuG8HiSya+ST+eCtbMM1hcZRm3Be6qtv9P+6rjt16R2Sb/6RRlzsCux/2e/BkiwoC+PYCaabTqXm4/9gWw8q6RwN+knFYS+exCIhSIjFl7ZzR1p5pTZGb/gSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736032; c=relaxed/simple;
	bh=/UyV+QXEQ8haLX9huHlE3y+B0oeS61wRn0lhjcLxYKQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=MsG/IHD7MjKlffM3GYiyaeludPz5OH0MoFO9Niiw2/pIv6t98Z0jFa/AL8emqmy2gAyrvk2WTdtNI1AiAjndBllaE2PEjYnY9a8m0Qgs/WPtTQebcs6g3vR4HR9t0pLo2uK7n1iJm5AN51vt+3NDRLuzvxy64NiQy0RtmTmfOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VzxOD8Yn; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744736027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UyV+QXEQ8haLX9huHlE3y+B0oeS61wRn0lhjcLxYKQ=;
	b=VzxOD8YnS9wDma3D6iT/jLlob6zweEEO3tFLRs3caMkZwuOtAcf99bjr6dGU9jxpzECawn
	M5vw4IYbvk+vGqUB0QYA+wyVgMEn1RIzDU8BzPbeaSAtc9aOBWjhHEaldcJeB4T7fQyNXo
	FznA1ikLV7AuLTAKdS+jWXCCXSjC1h4=
Date: Tue, 15 Apr 2025 16:53:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <3cb523bc8eb334cb420508a84f3f1d37543f4253@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf] selftests/bpf: remove sockmap_ktls
 disconnect_after_delete test
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, mykolal@fb.com, kernel-team@meta.com
In-Reply-To: <20250415163332.1836826-1-ihor.solodrai@linux.dev>
References: <20250415163332.1836826-1-ihor.solodrai@linux.dev>
X-Migadu-Flow: FLOW_OUT

April 16, 2025 at 24:33, "Ihor Solodrai" <ihor.solodrai@linux.dev> wrote:
>=20
>=20"sockmap_ktls disconnect_after_delete" test has been failing on BPF C=
I
> after recent merges from netdev:
> * https://github.com/kernel-patches/bpf/actions/runs/14458537639
> * https://github.com/kernel-patches/bpf/actions/runs/14457178732
> It happens because disconnect has been disabled for TLS [1], and it
> renders the test case invalid. Remove it from the suite.
> [1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kernel=
.org/
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

The original selftest patch used disconnect to re-produce the endless
loop caused by tcp_bpf_unhash, which has already been removed.

I hope this doesn't conflict with bpf-next...

Thanks.

