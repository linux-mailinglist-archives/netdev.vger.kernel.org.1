Return-Path: <netdev+bounces-289308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH0sD+sTDGoZVQUAu9opvQ
	(envelope-from <netdev+bounces-289308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:40:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EC2579420
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 243593059FB2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96FA3DB65D;
	Tue, 19 May 2026 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=extrahop.com header.i=@extrahop.com header.b="IsqOUNZn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D343DAC13
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176157; cv=pass; b=IiXNIxzPExJHUT6yWCBdhIEcpF/3jF8iNQiSElmxXGDuCh0OGy9n1vQN3hEVDRgpuQXaT+84Ki3zdYuBYwCE/ZMatVgBrq6Rwjz0maFA9MYX+RsO2NBG7/BR5IzHcrgEBGAIrA/acZvcWU0uk1iorZiiEwDt3hik8Pw4XO1rzRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176157; c=relaxed/simple;
	bh=XxLdTRIRViloeA/nl/9zKQHbIk6Fd7dTbO8JdCx3yxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MySg4xA/34QUL2amf/YNE4enisKhP+h2QsS65+F1M63fWOjxXBmrJM2E2k0FqTncu9N3vJiKBIXdazOUX5p99Gqcnh9hQDONmffe1tW0h7zr5xnvMWNSIaLVA0/ERMhOOUG/wwoRJRJpV2n6llhZMbS3AI3HIdX0Qc0n1boWYQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=extrahop.com; spf=pass smtp.mailfrom=extrahop.com; dkim=pass (2048-bit key) header.d=extrahop.com header.i=@extrahop.com header.b=IsqOUNZn; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=extrahop.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=extrahop.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67c3cb1433cso6899387a12.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779176155; cv=none;
        d=google.com; s=arc-20240605;
        b=BecZx63pYjm2P0H9A1QpxHsdwuzPRBNj1VJ9o95ZbBNwbPcK4IStqD3mSLQYnQN4ve
         hNI3aR3+B7IS4Q7e64fhbAvevmSdEZ3vVcv1XcxYY2jsIVtb/o6QH5lJ6M+9Bf2QZ/Y8
         4wW1SjOZl/wyYixKrt4o0gG08eVnJDJrB0N5qNlsdzKU5izqfw7W6NxlpasJqxhO/9Lw
         FlaXQZRPR+S442ogPpONTafg/avilqJrh80QZG39h5AGJwMIjdDzXGXHIJ7lK3MP+bWO
         8+mto9SIpL68m/3ronyP34dUitU0pb9f2+QS77qdpQl+LzcVDPyyaSJQPmBk2V/I+bTS
         HXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XxLdTRIRViloeA/nl/9zKQHbIk6Fd7dTbO8JdCx3yxI=;
        fh=1rC56vqOC3zggv4F1ZvKCnJgquwicjfWm8pOUx6YNPQ=;
        b=WnHExsRWfqhzG69t/AkAAqk91QnU+srHF+KuxggPJsAKXvqJ2couDY5aJqt5JYDj7a
         mSSRixgy7tXJLNqaiFFG25h4Z2LbMyi5qSiBno+1KbXh085keZTs9r9rSLp8uzXXZ0TJ
         rV54AQiwgiGS/0QHsFs1j5Ynb6WbRpOnN2gX+aPBZZ/Krpza94XgkyT5auCaPim1xJ2L
         BiT9mfbMun3tHH5jMSmrzM21wSw3IS7wP+Np9FKHr7usYd9LRXFvgw7P/c6febXhP48m
         Y5zX2n5pVPhmKThuGis4ZosWZbKE7+2+jyCk8wS4FXUmmVI+hf7MZaWXTHli+GOR+Mw2
         cMVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=extrahop.com; s=google; t=1779176155; x=1779780955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxLdTRIRViloeA/nl/9zKQHbIk6Fd7dTbO8JdCx3yxI=;
        b=IsqOUNZnMQfRoZ6gSCa5/Pb2IodpWraRaiEmlMzTCL+GThCnUm8SrFbHhAjgQx2ZUE
         nsyMPQZ6jQS3atbIl7h8ezZH6nynMKAHyY48krtJUJA2SPgIZqk254S3O2LBJ/ij9fKg
         CzOrAEovkEUbwJUbOiADKmQBc8VGT0nhag7aa246G1VVW0r+Ol/L/V0iBXRrSgsdjNli
         dJ/oFXsd5PmwIueoATaqYBLC5KBWO0YF1o7F/RwnGzCeib05V39T1apxi9pXU+qfcjlQ
         IxKMk/dZz//J0TCJUyoIsVJXU5TZRWy3OTmYu/+2/UGpKT2zNQyj4ZbxSN+0gMzEqISI
         9IHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779176155; x=1779780955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XxLdTRIRViloeA/nl/9zKQHbIk6Fd7dTbO8JdCx3yxI=;
        b=Dp38kZzVaDRhHuizbDtKw10GGcH9UB07xjExxOAUmv0HfbseNk1GNp2FUGAPZaievM
         zJQwB1Lzr1NwBGJMLj1VXvmokf03Y35eBTIW2+ThAuZvQkeoRCUjiPvkvMDXTTU4gNP+
         HU6F2/WHg7yBkN44hbHeQ/fnXBA6wzvmvL94+oMsly7DisfZCUWY5vKxXYeih6lQBWw2
         jvH/BrstHOkJSPkkQJMO5nbYujn6bcQoDrUINlpru4QtCsA4GQwuiiPpq07UzAoA1uIS
         vtv8JmoZ1gf/unajfnMdRTFaSGiOaDX/2IcsBlKkkeH2Tn6m/9+Q/3m7Rja9+ksa4wUx
         ovWg==
X-Forwarded-Encrypted: i=1; AFNElJ8e81cOlPEixlLA5oQY+pC1npm73Cy6BpegEH4akw/V9Oo8AHrYhm7ZTUP0JZvk3I+vLZhxAxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5AhT+qROU3nfSvsAuCQYjLvAtNo8B5mVjkxlq2kpSe0FIsJ5u
	k27rkOJAJdRyjbN5qJuR6LvfCFE6i04eEw1FyIB7URJqKVIDgAN59Vww7qcaR4cb0yvpz8uRhCq
	IYpNKPb5MtFxKdp2abocDzKYV61wD64tdQtSvdpIy6L83wXP18Wyfyrofe5W/O3pZ23SZfsQtl4
	hxpnL5vRA1RcRrCxGezRTb3fVgKixJIzC9Wz2t9Ont6FGgS3HFl4sQLawgYMB6HhbTiNkTi0BIG
	I4W6dfKvUzmsP+6NZT6YWO3dQ==
X-Gm-Gg: Acq92OH5irfBRYKEYSlv+W+Ln8vSRNeZgNDoN65T1aL33xZpRN5D0l8A+xorFQbsqlp
	fIfyLZ/QkoEzIB0OiIHdmjt5dNkhMZxyNJKuA91fkKp3nZlL1IFRgyKa7hA9Hca48b51jAjEQCw
	wRInZGfzgELIXJC3Hb6T+YHbUVwM+uF+1EQnXGGEp1uSJufjA+gRuQWIW50QpRWqcvP3PIrBthV
	egyEBVM3eLJgMGUC4mFQIDkF15qGpSdsHKpn59FBSt2RvH+Ypw6nhPxGaj+HwBqCInZueysfJI9
	vM/HJAA=
X-Received: by 2002:aa7:d6cc:0:b0:67c:6836:7b0a with SMTP id
 4fb4d7f45d1cf-683bd58b751mr7883025a12.23.1779176154645; Tue, 19 May 2026
 00:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-b4-mlx5-sensor-fix-v3-1-f537ce191d6c@extrahop.com> <20260518112555.GM33515@unreal>
In-Reply-To: <20260518112555.GM33515@unreal>
From: Will Mortensen <will@extrahop.com>
Date: Tue, 19 May 2026 00:35:27 -0700
X-Gm-Features: AVHnY4KCOWuQ5o5TO5dLsOENIYFb6b7Fc_T6vOXkgGzYg1538-vpqKBjLazAOTc
Message-ID: <CAMpnoC5ACdKiqy9mzmwvm592fJCbxXJCsuFxKJPG0c75_frFhg@mail.gmail.com>
Subject: Re: [PATCH net v3] net/mlx5: don't printk garbage when transceiver overheats
To: Leon Romanovsky <leon@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	netdev <netdev@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-rdma <linux-rdma@vger.kernel.org>, Jeremy Royal <jeremyr@extrahop.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[extrahop.com,none];
	R_DKIM_ALLOW(-0.20)[extrahop.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-289308-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@extrahop.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[extrahop.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,extrahop.com:dkim]
X-Rspamd-Queue-Id: C8EC2579420
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 4:26=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
> Honestly, this approach feels overly complex and fragile for something as
> simple as printing to dmesg. In my opinion, you should drop
> print_sensor_names_in_bit_set().

Do you mean basically revert 46fd50cfcc12 ("net/mlx5: Add sensor name
to temperature event message")? Yes, we could do that. It is
definitely fragile regardless; there are lots of assumptions that
there's at most one ASIC sensor and one module sensor. If we want to
keep the printing, we could simplify by having temp_warn() just print
a static string like "ASIC" or "Module" rather than using the strings
from the firmware, and maybe also call a function in hwmon.c to check
against our module's sensor index in order to ignore events about
other modules.

