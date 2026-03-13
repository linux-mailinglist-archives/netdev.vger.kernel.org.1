Return-Path: <netdev+bounces-267569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KyXMrdotGnxnQAAu9opvQ
	(envelope-from <netdev+bounces-267569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:42:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3025928963D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F1863083017
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E745A36492A;
	Fri, 13 Mar 2026 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="cIzathQT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871D526CE05
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430952; cv=pass; b=N34sNFee6S2gTIxPBDiFTnVXY2FtvNuxl2LgGfUgfPtovTMapqKTutDqh3j1FOPohKY2JA1esmtptbO8ulpvGV7XkzqAwUPvlhAfPSaKKMY/4Jt/oxm1Xl2rhjvZWEXTO4IuM4LO2YZUeGSzptx1i+Qy3lxSwH/epqxFJEFJWdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430952; c=relaxed/simple;
	bh=wsYk92wdASY+NJiAH+RHMJCbxM+eFQK2Aa0H0k5MJWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0Jt8cZZ/i4hqzavy09lDUYkXlFJJyO/4YTEQDqa13BIiH6wvZYhUGyOzPRrei/6V6hBg8SodAQBUEAYgF8jPaf9RoW6rAObtrXnUlRegHMBHruCwBViVO8435DWAsNHb8mp0UzbSUPcbIi/3iuCXbbbH3R3yfLCJlc2TwPh8NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=cIzathQT; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829b2018c94so1567252b3a.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 12:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773430951; cv=none;
        d=google.com; s=arc-20240605;
        b=hT8b9oH15QWzqmCL3kgBATqxhZByKgMW3KbHyTYnmu5gbO78NTNEJM7OiHYUfOVEiR
         MbD3FXKdgNFquihcDQQsYfH4dKxE4gUFsl98nS6EYRnKm+QL1z+SZHno3HKISL5x7mWn
         qEaFfdTocgarTlfSQWxaRaXdb6GEeZVdz5yRpJaFWKtytc0vFYMHU9c/uJmdS9qIpKZA
         hnEMLJz7Rfcit0dbGBWXpKY///+vgDMVBwrrEhEs+Mu9KC/NNGL43QW/5jHz3/wLR5OC
         z+ibKWiKzKokVLRnyD9YpJMhAe7g3nILqlfpN+8i4xsrRDSlPTHAr19kvtLZc4mucpHC
         5iPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bQuiNB+kjpZqcVpuFBimlrF+cfPpSFp76RvAtN54i2k=;
        fh=116JZhIbpH6Oq9YjKafuzyVtNV1zGZeqY1qUQW0UWt0=;
        b=V7Ybhmm8A1TgkGNheSSkpO2NFy0Sr3AQv8hepcTKN6ASIDgeBAucztynmmTDN7oWLm
         VyCtaIzzxheRsS9roLJ3DjVYYPeAUew6J8wCETkZwTs0Y2ovAdlhD1RNY8ojyXNk3R6o
         whw+HFggmabPV5lnZaV+XyH7SxLG3KqJ4j+NOcT3nTR7UviI0kiPM3hdOrkuGFXpGJMo
         iEr2u65ayvxrxvzZo3aL89QPo1Nz+Hpo92FBKogBfTys/nNGlRyAiYRMl3PTQdUinpwk
         d21ZCI3Sl4tqtQDp7t4Ckv2tJjj79l50ASLk8RNZG52twrZuwndmcV69oSHY4c7u/yzA
         2B1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773430951; x=1774035751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQuiNB+kjpZqcVpuFBimlrF+cfPpSFp76RvAtN54i2k=;
        b=cIzathQTR7mLCLtFSzwJTsdoUqurKW119JbR/1GJ9umGjHBYvDm3ZNls2UcyjZoFJT
         DDHKo1Ripco0OfKfvp0EvXji8e+rchiHj+aNcRef0PYaxx1luoKJsW+6FNzeFUXUinfo
         f6tD906j6mQLRMpPGT8m5a5mVBBeePGLbcd8pBb355GATsrXYAH4lEU0pQ7/C0KWbhgy
         mnA26Ylz+Wegd8jeRrGwyCC7lHsoVtQ5e46a20MLAPkhtjgWo7gMtGzVH/UHKmirUs9i
         wSKU49wuZTzkvoWc72b/OUXA8cXIFzOiCXVzw7QFSOtzB6UOJTLmAdBjsIcT/n7yK4qS
         ul7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773430951; x=1774035751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bQuiNB+kjpZqcVpuFBimlrF+cfPpSFp76RvAtN54i2k=;
        b=Ph6RwuTLYcD264hnTYxg4NbmRwe3maPjA7gaVMNsuImoA1o/jGxF4gmRrmZtG7v3k0
         bmkEycbLINfo1TgF29BmwUVe20o0/6yxWlu30mcB7kgHTXbqYWraOY5K4ovx9nFU5kmt
         GaDPlAW2ovDo8A0rrpa+sdWjRaE6r2LFHeDnufvlK4zrjT4V/dr/LE53IttsZuMg0Pjm
         PtXd6wRHM30GVxhOYDuFHi+VgUpslHGKVA96I/GTV6+NSuunGv+kbaGx3HkrAer0Fj7u
         UyrLhxV9KV32pH49nbKkmhDkcce0lJq+V/IZFHbQiWisZUsNToEduQZyWas0RkC7U9h/
         Jrcg==
X-Forwarded-Encrypted: i=1; AJvYcCVA4yl2S4m6O5yZGLGojd8YN4xyNBAIUsWGCdMPrPiFMihHFxrYlCNd3xgr+PiBc77GpMzuSu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBX5pZTvS3oimUyHwSvkCR+KKQW0HMnaI9k04wO2JyLcOqSwDN
	H74drZsm8NeJ1FugaDO40gXh1UckUf9E981YmJpWFgE61zPiAnrMtkSvzHeSvKn5FmKQro8+OMw
	J5WGmAshtD/nujm6sLagY8ubExCgOG6h+gvg13coiXvvMcEceDyo=
X-Gm-Gg: ATEYQzwrXE+jThlui6p5FMPEMLuzY+SAGNOMx16kNi6h6SZDZldVQGfMajbYrccidjk
	to4Mn4SrMDHuY2Gl4oy9BbymrtWBqQB7ikKhKIUUbfMZXtZJ8OCPP1QrZMWuPd2gA4pSYxrgepX
	cxraZNIl2DW8Z9344/Y4MmNa0edH9ORSj0kNCEfoUEAqPyamN8M7j94AI5SaCAw6SSnulxWTizw
	Yq31qhD3Qq0ixo9u3bCYoJugkh6MdxpuzDbIo7+rT26MVL/jeinw/5b/tvu4iAhdc4ZgcUUoyeQ
	QoifTraoUKD94mg=
X-Received: by 2002:a05:6a00:ae13:b0:824:188b:c173 with SMTP id
 d2e1a72fcca58-82a196b5675mr3103967b3a.5.1773430950941; Fri, 13 Mar 2026
 12:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773411667.git.dcaratti@redhat.com>
In-Reply-To: <cover.1773411667.git.dcaratti@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 13 Mar 2026 15:42:19 -0400
X-Gm-Features: AaiRm52SY_QDYeq_HaX6tlxq35M6FgRGcXC_9gDett2E6swBKCLDcx6xgLZhXm4
Message-ID: <CAM0EoMmSuF1-BLZH9m-fVrddtena7L8__qZsRaPBYWSL2dX-Nw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] netdevsim: support ETS offload
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267569-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: 3025928963D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 1:24=E2=80=AFPM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
>  - patch 1 moves netdevsim tc offloads to a dedicated file
>  - patch 2 enables ETS offload on netdevsim
>  - patch 3 is a tdc test for ets offload on netdevsim
>
> v2: don't use x-macro (Jakub Kicinski)
>
> Davide Caratti (3):
>   netdevsim: move TC offload code to a dedicated file
>   netdevsim: support tc-ets offload
>   tc-testing: add a test case for ETS offload
>
>  drivers/net/netdevsim/Makefile                |  2 +-
>  drivers/net/netdevsim/netdev.c                | 51 ------------
>  drivers/net/netdevsim/netdevsim.h             |  3 +
>  drivers/net/netdevsim/tc.c                    | 79 +++++++++++++++++++
>  .../tc-testing/tc-tests/qdiscs/ets.json       | 23 ++++++
>  5 files changed, 106 insertions(+), 52 deletions(-)
>  create mode 100644 drivers/net/netdevsim/tc.c
>

To the patchset:
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> --
> 2.52.0
>

