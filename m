Return-Path: <netdev+bounces-279561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 47I2ILgg5GktRgEAu9opvQ
	(envelope-from <netdev+bounces-279561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 02:24:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FDA422B90
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 02:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FE9E300440F
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 00:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE851E4AF;
	Sun, 19 Apr 2026 00:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3xx84e4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A331FB1
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776558257; cv=pass; b=IPTlx5n10vww8bek3I/fEanoLklvHIn9dwT227lM36mpc+cDkDoYrTGD4LzIa9c5GuIEH8Gpt1Ohbpyo8q8VSc46NKoOvcTpYvOklBYPwdBCTq6LE/O/Pw6z2D2ARSG6dlzqXxQopRmEuFIKUSQW9hOoeRrZqo43t8mCpakjb5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776558257; c=relaxed/simple;
	bh=DhZU8eEgPK9l0Ipb+0TIk9wwqcZfMVu/6k+K9w1pbQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ryoP282dbo03ZByp5iKhftNbXk+nqzdgiBVeM/R3uW7/SgbtjePSKwlEoysJ/eH77/uG10a3ricoxH7NsUzqXKExvsQhhN+drD0ZsfdZHYn/fDC7jTYN0HxLjJuDq8rsP3o6utgYXWmdw1FUQGcRlFQoAtnDwetGFNH9+piEanw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3xx84e4; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56a8e0ea02aso1978424e0c.0
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 17:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776558255; cv=none;
        d=google.com; s=arc-20240605;
        b=AzjObrMOe4A7pk51G6UPK6ATtFAhQh5z1dQHBDUJQ2ue0kOIwPqXttebbHiArXUVeo
         4yLDrj4pSPsHpRLcpg2mR/IKe75acw7DT1skNbibZiVwoGknpXunoNXmA6Ynlzn5/XgM
         IT2kSrdKPxjv11MQkLVygJKJPcg1NEthg4+jnPYOym16CGsCHqvRAewwx2B+waGWDgAJ
         bx7R0daoTJVcBAebc7GHXomDEQfivrgVm1o/ob0fOyoWgAkuWqO+E+5fXU3FwKAHtxQ+
         o+4XU8w5M85Cxl5g/vVHB0gqZedu0tDUg2U+UdtjwS3XJ2ZUUnDeknSxfCCtLCiMjz/Y
         862w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DhZU8eEgPK9l0Ipb+0TIk9wwqcZfMVu/6k+K9w1pbQI=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=VfMgCq8/BeipY3271Z7AAixF1SCIOLQUZzp7NqaUQmlHZSeKEV4pfgkPcywL5N2Arp
         h8f6VhmsIxUuSasQ4Mv8/D9AslF+3c0lHSV/wZhdUw0m54ARFzZlnUgO5aMAxIAJcN66
         nsQUi06VC2tO1/v8zhgf3Z7f6nqSpK97nL1D21z/8Va8xRR384bX0vhcDHFa+i3kf/BH
         DSdFSyatv+T28XbRWywIDunhW1YfgPq7x+ydA8HmRcQZFspYpipZNYYWLzImiSYbfk44
         bhoNNULns+ib/XuSRuJqcWgTlaL2kaowIhSbY+OTRXGx2K/aQmNu4n1TiCtj//4MvC0z
         vY3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776558255; x=1777163055; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhZU8eEgPK9l0Ipb+0TIk9wwqcZfMVu/6k+K9w1pbQI=;
        b=G3xx84e4Oxgyc4NyCIkCVM0uJhwwN3g521TmDSCuSf51PhaItfhJZs/SfbuJ0RWtEb
         lekbgf75NSf91M9JAxAVQ3E+/5ogP3OXQrWHOY66A2CdKv6THfPYXZPFPhEBmbcFlIKx
         +EOKnWKxPH0zGCFKFmrs7rTrTqQnNB+84mmyAnml/FrPXIX7AycPjckMxaE2GytSwUD6
         MQiZzSiuC5dctqL2XU6TxlDVHXxsG1VDoq5YEkgLdCLdaMFaWhkUA3NH83DP6WruURSO
         xe9C1uwKrOcPF1VsL/myinLl5/6biByheLpcIEE8ifpGPw4w39Pzs+7hbGiTG+MoICew
         ywOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776558255; x=1777163055;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DhZU8eEgPK9l0Ipb+0TIk9wwqcZfMVu/6k+K9w1pbQI=;
        b=mVmRwu3C8E5BucOeWMMsso1/dOASGTmGIZNzzhuLM6PlBhgUlL/bK+IyTdeauBQm+X
         lqPr1eohHY10NJv/4PZjyfkQeiERDidPMbMc4QV0IOqkxipscC0W3IDFfKdGtzEm/OuZ
         whmwvualSjsIt0Lk7xtxD6/HnI5HTgGeZq4raPRa1UIB9gX5sUqy0Y/jPg22N4JgYcsc
         1fpw2QE+2o9Gxfh1F1MxJruWannil1d3v2E008l5j/gMQTOH+9pDpihvRX4hhBBJyzb+
         bXAHyBY2VFlGm0Rvhtb8iFZrf+Hh7vk/ia0lGaCTZvXm2uF+VSiSV8GNcsAT1RAqfTpZ
         AvMQ==
X-Gm-Message-State: AOJu0YxSnroMKx5zl9V62K2eNCtVvgwS7GMjEMOjFZ09sgU8Ht4qEvyR
	SsLijkcnQK0wseNpakpv5cqWCoB0z0z9PrUAtqSPA/NuQ3iuO+vMRu9XPqjgFz97phk9W+OWtew
	E3HHMoFPaCXqiWW0FJ/HHks2lM2NHf/sI6gZi
X-Gm-Gg: AeBDieuONeSsIyzAJQcrM1176x/GCmvvP9QRCPlR9EbzqZ0aghgP4CCMt/WuZ74WTCg
	v7J+qsff+QqzdKfDGdSpy7MXhSfqWwZXc5xa7rWwXsU95KzMwqHmntRTVhz3v46tiltzPRyifDY
	Lra7+VucY5j95ssNCbI98xy4rxhpxqP03F1iNCGQo/LSwmsP3JM6UJejFHWEt8AMQsD1rVmmHWz
	vTA8UmzvKOZdQdGNVDKS18B2FNuy4gK0d8ul9sz8fUuz8QneV5ajI4qb5bBFsvi1ZAo9USAISPv
	L8xvfX6l43Kx+j5SUWAxvrRLZGgETgKfZq3A785LNGESgYO34g==
X-Received: by 2002:a05:6102:8026:b0:5ff:d434:b507 with SMTP id
 ada2fe7eead31-616f68d7591mr4283484137.17.1776558255107; Sat, 18 Apr 2026
 17:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414071322.30851-1-shuvampandey1@gmail.com> <cover.1776446840.git.shuvampandey1@gmail.com>
In-Reply-To: <cover.1776446840.git.shuvampandey1@gmail.com>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Sun, 19 Apr 2026 06:09:03 +0545
X-Gm-Features: AQROBzDbYG6pdVxU9bTA00WvIrkOjudzEy16Uu-QZKSx_95LgVng-VeR_tTT1Mo
Message-ID: <CANAAWHJKfRVO++ZdXYAKSaTH8JCBi_Xeu4DE-Ldaa6zu2Kub6A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mISDN: fix socket/device lifetime and naming races
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279561-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuvampandey1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74FDA422B90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While re-reviewing v2, I found correctness issues in the current approach,
including lifetime and synchronization problems.

Please ignore v2 for now. I=E2=80=99m reworking the series and will send a
corrected v3.

Thanks,
Shuvam

