Return-Path: <netdev+bounces-261039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAR3GLczn2lXZQQAu9opvQ
	(envelope-from <netdev+bounces-261039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:39:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B671919BA97
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72DFF301465C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC53D2FE1;
	Wed, 25 Feb 2026 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="s9A4E67n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A03B8BAC
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041140; cv=pass; b=Nb/WpKYBlXFkWpW8SyTqpTpC8ShTNrb0lny50yskUMd/O5tIZE5F5M9NeRDHFi8A/iOyR5Fmsfckbr7BRg2EH0nPlVH0WD6XGegV0KW1GDwBmfV4krbNgNrrVyuDmH7O6YZnT0I77sjbdajTGUefV2tEl6wYxrBRv4/xAEopWCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041140; c=relaxed/simple;
	bh=Oxw/88EeQbs9X0ww8Zglp+Dh9v+HALHW6N/RY1wqo+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkQg8N6Kvx3e8zy038qNKNYtjCzR49Rnk5fSvkBN0q/gWPjgD5EmyX3diJCpUleqw5WQxiVeg9N77g5ikGApoaOHsLeluCRmFkjxLQ/rd80fZWjPYdAAAElDxzuuuwOdgrmFWErEiUSeMzRrbaEwPePc4gb3jV+xMaVeI7ZlUD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=s9A4E67n; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-824b05d2786so5428589b3a.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:38:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772041139; cv=none;
        d=google.com; s=arc-20240605;
        b=hCJng0cn8PWlXCXAWijmCYB0vciageAkBrgnE6LMdxCHCBcaDXlN35ikEaB011wCRc
         1p2R/fQH+O3YQrnejWoqDKKzoI0QaSue9FapJy1lG13JfxgRUr8vnPgORzpkRPrtQgyP
         1TvYmj7jcq7zW6CbjKKdSnqok/+d0geaw7zhuuzVxlPTJWYuGZrVApMsesb3Rv1S0/nR
         KEn2OU6GvEY3O2Z1+mJKS88XMuW5RiLBCYhQccrtRTBBqSESgOdMUCS+gWyUPVJmihM9
         uhqDpzVgQIrvvFltomcyZaZ40zuax9TlWa0nOkZ8yjX5s12aIsr2dhNa0+vGdgFaZ82c
         nRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oxw/88EeQbs9X0ww8Zglp+Dh9v+HALHW6N/RY1wqo+8=;
        fh=3MEOuXJ2jEu2TC+kAMqwvU0q8Y8kM77Zd7K0JryVPpc=;
        b=lbwNENByfvJBVTt1J4qIsMl7pdBl6sf5HSznGT8RR+H9xzAYQqGsmu+iYb+lRpML8H
         hEl5T2W6sTgEVnzb4D2VEoI2NUEXtzAWUWvofx/cwMpZMQq2sRGhf1PvQg1v3fHvj2Ss
         2JA8oo1O3zhbos7+So3p5v2JzwMqui5PG+u7A9vIfo2vp/V2/8VNmCAq4ysK0mNIcj6B
         OdX6RIi0nAT4uhiaJ2+thXh1je6l9Z405xaVb4BzJUSCdcSRMQtp/1sQTo80bSPo5Ina
         ufAYVDpc/pMiyPH0ofIEmcgmsaeX2L1ZI6AHIRtjit/caXcgE637wwl5tB4pYrwXvHvJ
         1s/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772041139; x=1772645939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oxw/88EeQbs9X0ww8Zglp+Dh9v+HALHW6N/RY1wqo+8=;
        b=s9A4E67n+EcieUvr6kFJFTZhF+xRQvPm0oTB0R9hu15v/QTW9syMsVCX1I16SZO5dT
         vrYJWeQF4zzNLCT4RrsbLTRZfSzKb9JYOSABUPkjO//kIw3nNighcHC1A9x4c3uPU0I+
         +JHW6rcE47pQHTncZ4U9PzTX7YM/6N3adY1pNwu5R7TmbTJ35nGtYuSHEoqCPmioiF3x
         3x9lqy5aP+C/MwjbXrh+jY9n3YlwSjlrwZe704sJekE9vIxqXNjYq2+mAmgFQDuIEd/w
         6HjI4Ytzv/cc7znh4cihoU82ZSmcHUnGveC206peQ2rCOuo72OxJ4uvMcAMytFaKCxme
         QnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772041139; x=1772645939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oxw/88EeQbs9X0ww8Zglp+Dh9v+HALHW6N/RY1wqo+8=;
        b=JH1fEAZx/S8Aj8XtrnRnCHeRxX1P92kJkyxGcfvlvoFX2nqs43xaSTLJozoT+Hg8pb
         N1qZB5maX2eGVTcNPSEQ9/UuWStdncE+RRcbllRgIS0VbXiZsk5MekwPuc6EWQWv0Anu
         2ChJ38LigbnjfH24frswTMcvtW5HU6R864J3oF/1ERs9P/I1uOpxy0P2TYd7ZQtoWI7O
         8g6heYhP3En3vHaDV8a5+OVdx2r2jbriWeUQp7RdiBWLQfpeZ8ES/xMCQoR+al6IpvrG
         xd5JdqMs8z1ZVavMd737wvVLwnkKAmNRZKu3tARYhEs2wWn8cs1F4YFxJAjl2BwWS5FY
         aGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNlnCkxVUx6Ligy2MZU4gVhpnkC8uDLw+qUDQ+PhF62kdmoeDrs9eayLiCewQKUGIoh++ozLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkfl0Uzg4BNi2qyiPSyWG2LuQc/KM3GTkMQXg+z/sojnha7R2G
	g3Dqnh9kV8TEUAzH6oMZrn7Lt3YxK2zFCAVLpSAJzdlNkbRQuwrP4vOixudmCZw2FxecWnBIkRG
	PhZVNa0h7TrvEYI61MaEn4f2QRsqwJv+ANoNRfrO4
X-Gm-Gg: ATEYQzztwfTNWfFBC0xMbE8P0h09bbaXePCpjRP1oO8/5gUqqzRTL49DztpCIocSAFo
	CxBW86Xyswl0txpLo/pqKWV6FRNYA2qU/5c9p+soYNIxbs+TzFKpI5rdZDCH1wBt6sUMWye0acr
	e68/XGZhh1vFsxAJCD3zTqcgCeA1LyEYTiLtrJyA5T+qYEe1/gsoJi8kqOTkELYbb7yIhHpV5UI
	P98XSQYREyXw48wSUT2yvvjWvLaNkn4Hpww0Rn0zS2V+tTHWPvSnGUoSP0aWAPZSipXiXqEI7UC
	iN222nDm0eUo6zY=
X-Received: by 2002:a05:6a20:a10a:b0:393:e2e3:5df8 with SMTP id
 adf61e73a8af0-39545faf8c3mr17196903637.72.1772041139267; Wed, 25 Feb 2026
 09:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222061306.28902-1-ghandatmanas@gmail.com>
 <aVA4YJIT6at11JwH@pop-os.localdomain> <e68da695-2fdd-4692-999b-566c1b521f47@gmail.com>
 <b7df8a5b-95ad-4cd6-860c-1adb1f89a7f6@gmail.com>
In-Reply-To: <b7df8a5b-95ad-4cd6-860c-1adb1f89a7f6@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 25 Feb 2026 12:38:48 -0500
X-Gm-Features: AaiRm51kv0QN7jjsCO-PJhxxRk2r_TqmMhp0nDewlXNYrc7BfKPIHcQ7zNmz4dw
Message-ID: <CAM0EoMkisLVqMFZ-DKnG4s6xNc6aWYgocRy3uOj=iic7idiFhQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: Fix divide error in tabledist
To: Manas Ghandat <ghandatmanas@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, stephen@networkplumber.org, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261039-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,networkplumber.org,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B671919BA97
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:35=E2=80=AFAM Manas Ghandat <ghandatmanas@gmail.=
com> wrote:
>
> Hi,
>
> I just wanted an update since the patch has not been merged yet.
>

Patience please...

cheers,
jamal
> On 12/28/25 20:54, Manas Ghandat wrote:
> >
> > Hi Cong,
> >
> > On 12/28/25 01:19, Cong Wang wrote:
> >> We are reverting the check_netem_in_tree() code due to user-space
> >> breakage. I hope reverting it could also fix the bug you repported her=
e?
> >>
> >> See: https://lore.kernel.org/netdev/20251227194135.1111972-3-xiyou.wan=
gcong@gmail.com/
> >>
> >> Thanks!
> >> Cong
> >
> > Reverting the above patch would fix the bug which I have reported.
>

