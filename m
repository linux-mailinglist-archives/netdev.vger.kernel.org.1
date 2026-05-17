Return-Path: <netdev+bounces-288759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCNFEsr9CWqqvwQAu9opvQ
	(envelope-from <netdev+bounces-288759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 19:41:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D46562B1B
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 19:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 060A9300FED2
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F99355F22;
	Sun, 17 May 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H60X56wj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670BF34F49F
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039479; cv=pass; b=KHO7y6mONp/2XOnj8bbk+vxvXqM9p7YUGo78/vI88lOAmJOaE6y+VAtmGtH+l0oO7ZnYtVf0TTer0WU9aGGz2jZsWHzxYz7/jYI2gtUMVI5MSawUkmk95Zef25yS2k6o60zIv3+AgW32RBog8yw2KxfT3veS9e/irGuMT8+18OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039479; c=relaxed/simple;
	bh=YZ5Ke/sEGFabuzBfVldOLJOcizsrW/Nl7bivRjdo/zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uf5+6fklcY8SBnyl6GzfEB8ddcPKtuqGRdpPrVSciyDB4cCCyzsVUCsPfNB5EmXnG3QYR34HpPjUS5XXX8slXAZN54iN/lAD4V8lsvxRePXcJs52bofbC/o1bqfJ7D4IDtl9Mug82ENGL9UFvjFwV+/uCwh3j3I5k5TNSJXyiB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H60X56wj; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40ea36b56b7so1243076fac.3
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 10:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779039477; cv=none;
        d=google.com; s=arc-20240605;
        b=Au0Io33nYlhCH/ONQfn66Am4d+kohIGUkPCT7RL9l3918LYa1IUSRo4DKisfDJgcYu
         kRJN/tDHRC8BU/atUD/38wUzur9+Erb+SRTHT/bdlfizbCMlp3h2ldqJUr4Swm020TEr
         3krGU83sSsIwxX7GXgOx4wlVV2Gyr8bnyY1FmXog/NubXNZwfAvEoKFNgMMgeVgziIP3
         qgTxPiX31OSrlCaqdhgEMwpdnDGFylqB9jD4a4tqNOe3t3BZ07EEWOaMM/st+tSYzRUC
         9SBVYv8OggXDqwyaeWanCBMi+icw9GsH6AKcgTg9VuHYUf78pwS6ExjriR5FujcC4yQT
         miqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tlVlaFBAIkcv0HbZfkTnOaqrfVsvTeI+ScRy+0SZE24=;
        fh=Iqnbhir0Sncs9rKNH1rME+QBScsuavQT7RGtJVIeAzY=;
        b=cgwTrOquyr40ysivNj7WbrjnjOxZGJEMm6dqzrMW74SE7ptKOoad/mKaUPlfumTVci
         yr/5BM1wt3gabcU9z9kfPQQyIWN8XZ2J5kEW9B/AmQ9IhLAvjaGdOfsladnAGjEbs4V5
         pd9CqBStX52ELi7jUKZfJoMdELdlj6usSs9nTa66SjEEfKpiZqFNKA0C9DisyhodLEWx
         wo31QCGasi/j3UvfVWtL8QC4oEekiLC0dK1eEz+rHng+16Utt8Lkc79DWBfhRa+b0zuY
         T8O6PlPErhXF3jKzciZs76jUkDMahwkqLD38UqJMXU5JmuZNfgEQOOGQOrLWnSPttzY7
         KbqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779039477; x=1779644277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlVlaFBAIkcv0HbZfkTnOaqrfVsvTeI+ScRy+0SZE24=;
        b=H60X56wjblRPR2uyKkg+bp/AE+VJV/2yl6eKZm/pTQCfOHpqjxI6RGghlkCGoY1T4o
         qPS0LUmH5omRZOdkkFHeCHbvO97aDj4mQCkWK0X8LKhpUmggrM54jZhzgmWvI2J+kpQG
         kKlOgO5yp1MtvfIiEBBPtFbIIRqJ28QMYPWGMpKFYPMzreH6rTBEZMr56CBugGKyDZwB
         owJPxDbed2svykV8f8LpyKmiW7+XvhNXRSqqPf4jgKRL327xblgk4pS/IFC+yLYKHGMn
         Oi4pX3Vk6cpu6o2CK/+BuwnpOAv+hJ6DYqhyoVQh7GtskDC4rcVzHaPEsB41RvOhB1kj
         ZM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779039477; x=1779644277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tlVlaFBAIkcv0HbZfkTnOaqrfVsvTeI+ScRy+0SZE24=;
        b=XOLiUy6PSu7BgGakZp+OyrpmmotdjhqkQm9q/xkJ1nacwLfW3lRrpjEBEUbJEZ+Rrw
         59QH8B6BMR/VStnQB3qiJ6rvoaRN80PfVtt3zHywSDTj4sUWvh375H0iqHwy+MZ8R0lW
         lfwPTrflQ+JtS0jftjCGgZeMSLsapTghLYwKX21h88/Pv2AMsgr4Ji6gT6s+eQWQm9ak
         ptb2Pm+iDl9YiNOzDDC9560kNcZVtKXuV3xjoimIj1dPCCT+M2oHk6+YI5OxU+gxIjsB
         VfHUQdi5742sbCzZGnFv+d3pwvlWmtUvICzfIB8ySipeB3dQrI3QdlT2Ypp14ZC91R8q
         LvYw==
X-Gm-Message-State: AOJu0YyqAWsR+X7O66osIphLRA/Ya/uGyvHjpG0bV6tNO3ph/wapQl1F
	T8P43vRiUGdGJClAR6nlvPM0yhooS6gUunn3Fkfz/ngpY4N1rP0MrwlSo26FsiCd9g7Du1WF0TN
	IvTaDOICMOJctk22PN7amfzDnwvO0ePH/wORgko8=
X-Gm-Gg: Acq92OHjs5e52gIIWZwO0AgSn35s/XiAUMPjS+bTSx78P+FDomXIBLIb55rH9rtX3xb
	0+TvYOLVWpNY8vOSgHg0SExyOfcWtbwuN9mqoD/Clys/PDfPlLEAzL+lcrVWcjYidVYuWGNfXFh
	6AM5iG20m86ZOeWzlUmMTsj2/0c+ZMVlBSwWLLV4xFNjjeOa/7sNPhqD0P+zxirqBFRqIiVD3it
	OsM/+YuAvhBNfxavdXBOQOIwnFM6D+YPrhPH12FQPuY1dEBgYoE/oEiD1rg52JmNmAQrWFfAbeZ
	ESW5asHatpCcObFiTnQPe5BLre8VjSSIiqUdSw==
X-Received: by 2002:a05:6870:6b86:b0:435:51a3:7139 with SMTP id
 586e51a60fabf-43a2da2c0e5mr7428036fac.13.1779039477364; Sun, 17 May 2026
 10:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517041306.24841-1-devnexen@gmail.com> <agnF8KScbKxtUite@penguin>
In-Reply-To: <agnF8KScbKxtUite@penguin>
From: David CARLIER <devnexen@gmail.com>
Date: Sun, 17 May 2026 18:37:46 +0100
X-Gm-Features: AVHnY4KT-anqkYPAowTH1z-aktUBhVHv9a9ooTXMQP-FAwDVJGuu25829Ys9ZHM
Message-ID: <CA+XhMqzrQfN2qmyfCyO1J+u0865cUDfkGrexW+h4dXS39CokeQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: tpmr: add Two-Port MAC Relay driver
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, andrew@lunn.ch, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A6D46562B1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288759-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi !

> Please give people more time to review the proposed RFCs before
  > sending v1. Also you specifically asked bridge maintainers to comment
  > and did not wait for us to do so.

  Fair point. I jumped to v1 too quickly. I CC'd the bridge list and you
  specifically, then turned around v1 inside a day on the strength of one
  review. I should have waited; sorry for the noise.

  > First, I'd like to ask: could you please elaborate why bridge's
  > group_fwd_mask isn't working out for you?

  Honest answer: I should have tested that configuration before posting,
  and I didn't. Let me actually run a 2-port bridge with group_fwd_mask
  set, no_learning, stp_state 0, vlan_filtering 0, and see where it
  falls short of a TPMR =E2=80=94 if it falls short at all. The places I'd =
expect
  to differ are PAUSE handling, multicast outside the 01:80:c2:00:00:0x
  range, and carrier semantics, but I haven't proven any of that with
  real traffic.

  If the bridge configuration covers everything materially, dropping
  this driver is the right call =E2=80=94 400 LOC duplicating existing
  functionality isn't worth it. If there's a concrete gap, I'd rather
  close it inside the bridge than maintain a parallel driver.

  > Second, what else did you try and how exactly did you try it?

  Same admission. tc mirred, cls_bpf, nftables, XDP_REDIRECT are all on
  the table and I haven't evaluated any of them seriously against the
  use case. Let me come back with measurements instead of arguing in
  the abstract.

  Please consider v1 parked until then. Thanks for the pushback.

  David

